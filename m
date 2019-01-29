Received: from eggs.gnu.org ([209.51.188.92]:35295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1goMgY-0002QG-Ox
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 01:15:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1goMgX-00060s-SC
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 01:15:50 -0500
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:44535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1goMgX-00060Y-LN
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 01:15:49 -0500
Received: by mail-yw1-xc44.google.com with SMTP id b63so7752311ywc.11
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 22:15:48 -0800 (PST)
MIME-Version: 1.0
References: <20190122083152.10705-1-xieyongji@baidu.com>
	<20190122083152.10705-2-xieyongji@baidu.com>
	<20190129041155.GG3264@stefanha-x1.localdomain>
	<20190128232025-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190128232025-mutt-send-email-mst@kernel.org>
From: Yongji Xie <elohimes@gmail.com>
Date: Tue, 29 Jan 2019 14:15:35 +0800
Message-ID: <CAONzpcadLr2YHzWgBiqX3nuq=KPneTOKiNZ9bdwO1p4Ni7pUcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 1/6] vhost-user: Support transferring
 inflight buffer between qemu and backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Jason Wang <jasowang@redhat.com>, "Coquelin,
	Maxime" <maxime.coquelin@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, =?UTF-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>, qemu-devel <qemu-devel@nongnu.org>, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Tue, 29 Jan 2019 at 12:26, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Jan 29, 2019 at 12:11:55PM +0800, Stefan Hajnoczi wrote:
> > On Tue, Jan 22, 2019 at 04:31:47PM +0800, elohimes@gmail.com wrote:
> > > +typedef struct DescState {
> > > +    uint8_t inuse;
> > > +    uint8_t version;
> > > +    uint16_t used_idx;
> > > +    uint16_t avail_idx;
> > > +    uint16_t reserved;
> > > +} DescState;
> > > +
> > > +typedef struct QueueRegion {
> > > +    uint8_t valid;
>
> what's this?
>

We can use this to check whether this buffer is reset by qemu.

> > > +    uint16_t desc_num;
>
> there's padding before this field. Pls make it explicit.
>

Will do it.

> > > +    DescState desc[0];
> > > +} QueueRegion;
> > > +
> > > +The struct DescState is used to describe one head-descriptor's state. The
> > > +fields have following meanings:
> > > +
> > > +    inuse: Indicate whether the descriptor is inuse or not.
>
> inuse by what?
>

Maybe inflight is better?

> > > +
> > > +    version: Indicate whether we have an atomic update to used ring and
> > > +    inflight buffer when slave crash at that point. This field should be
> > > +    increased by one before and after this two updates. An odd version
> > > +    indicates an in-progress update.
>
> I'm not sure I understand what does the above say. Also does this
> require two atomics? Seems pretty expensive. And why is it called
> version?
>
> > > +
> > > +    used_idx: Store old index of used ring before we update used ring and
> > > +    inflight buffer so that slave can know whether an odd version inflight
> > > +    head-descriptor in inflight buffer is processed or not.
>
> Here too.
>

Sorry, the above description may be not clear. This two fields are
used to indicate whether we have an in-progress update to used ring
and inflight buffer. If slave crash before the update to used_ring and
after the update to inflight buffer, the version should be odd and
used_idx should be equal to used_ring.idx. Then we need to roll back
the update to inflight buffer. As for the name of the version filed,
actually I didn't find a good one, so I just copy it from struct
kvm_steal_time...

> > > +
> > > +    avail_idx: Used to preserve the descriptor's order in avail ring so that
> > > +    slave can resubmit descriptors in order.
>
> Why would that be necessary?
>

Maybe some devices will be able to use it to preserve order after
reconnecting in future?

> >
> > Will a completely new "packed vring" inflight shm layout be necessary to
> > support the packed vring layout in VIRTIO 1.1?
> >
> > https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-csprd01.html#x1-610007
>
> Probably.
>

How about supporting packed virtqueue in guest driver?

Thanks,
Yongji
