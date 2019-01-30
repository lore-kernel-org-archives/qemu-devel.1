Received: from eggs.gnu.org ([209.51.188.92]:56352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gofeW-0005Xm-KU
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 21:31:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gofeU-0000Dy-Pj
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 21:31:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gofeS-0000Bw-1r
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 21:30:56 -0500
Date: Tue, 29 Jan 2019 21:30:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190129212835-mutt-send-email-mst@kernel.org>
References: <20190122083152.10705-1-xieyongji@baidu.com>
	<20190122083152.10705-2-xieyongji@baidu.com>
	<20190129041155.GG3264@stefanha-x1.localdomain>
	<20190128232025-mutt-send-email-mst@kernel.org>
	<CAONzpcadLr2YHzWgBiqX3nuq=KPneTOKiNZ9bdwO1p4Ni7pUcg@mail.gmail.com>
	<20190129091012-mutt-send-email-mst@kernel.org>
	<CAONzpcaHJZj8w-nK_AjEJ9vxHFkZauV0FH_4Oa66_qZBWE9aiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAONzpcaHJZj8w-nK_AjEJ9vxHFkZauV0FH_4Oa66_qZBWE9aiw@mail.gmail.com>
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
To: Yongji Xie <elohimes@gmail.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Jason Wang <jasowang@redhat.com>, "Coquelin, Maxime" <maxime.coquelin@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, =?utf-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>, qemu-devel <qemu-devel@nongnu.org>, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Wed, Jan 30, 2019 at 10:07:28AM +0800, Yongji Xie wrote:
> On Tue, 29 Jan 2019 at 22:15, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Jan 29, 2019 at 02:15:35PM +0800, Yongji Xie wrote:
> > > On Tue, 29 Jan 2019 at 12:26, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Jan 29, 2019 at 12:11:55PM +0800, Stefan Hajnoczi wrote:
> > > > > On Tue, Jan 22, 2019 at 04:31:47PM +0800, elohimes@gmail.com wrote:
> > > > > > +typedef struct DescState {
> > > > > > +    uint8_t inuse;
> > > > > > +    uint8_t version;
> > > > > > +    uint16_t used_idx;
> > > > > > +    uint16_t avail_idx;
> > > > > > +    uint16_t reserved;
> > > > > > +} DescState;
> > > > > > +
> > > > > > +typedef struct QueueRegion {
> > > > > > +    uint8_t valid;
> > > >
> > > > what's this?
> > > >
> > >
> > > We can use this to check whether this buffer is reset by qemu.
> >
> >
> > I'd use version here. Document that it's 1 currently.
> 
> If we put version into the shared buffer, QEMU will reset it when vm
> reset. Then if backend restart at the same time, the version of this
> buffer will be lost. So I still let QEMU maintain it and send it back
> through message's payload.

I don't get it. If it's reset there's no contents.
If there's no contents then who cares what the version is?


> > Or do we want feature flags so we can support downgrades too?
> >
> 
> We faced the same problem that the feature flags will be lost if QEMU
> do not maintain it. So maybe we should put this into message's
> payload?

I don't understand why we care. We only maintain inflight so we
don't need to reset the device. if device is reset we don't
need to maintain them at all.

> >
> > > > > > +    uint16_t desc_num;
> > > >
> > > > there's padding before this field. Pls make it explicit.
> > > >
> > >
> > > Will do it.
> > >
> > > > > > +    DescState desc[0];
> > > > > > +} QueueRegion;
> > > > > > +
> > > > > > +The struct DescState is used to describe one head-descriptor's state. The
> > > > > > +fields have following meanings:
> > > > > > +
> > > > > > +    inuse: Indicate whether the descriptor is inuse or not.
> > > >
> > > > inuse by what?
> > > >
> > >
> > > Maybe inflight is better?
> > >
> > > > > > +
> > > > > > +    version: Indicate whether we have an atomic update to used ring and
> > > > > > +    inflight buffer when slave crash at that point. This field should be
> > > > > > +    increased by one before and after this two updates. An odd version
> > > > > > +    indicates an in-progress update.
> > > >
> > > > I'm not sure I understand what does the above say. Also does this
> > > > require two atomics? Seems pretty expensive. And why is it called
> > > > version?
> > > >
> > > > > > +
> > > > > > +    used_idx: Store old index of used ring before we update used ring and
> > > > > > +    inflight buffer so that slave can know whether an odd version inflight
> > > > > > +    head-descriptor in inflight buffer is processed or not.
> > > >
> > > > Here too.
> > > >
> > >
> > > Sorry, the above description may be not clear. This two fields are
> > > used to indicate whether we have an in-progress update to used ring
> > > and inflight buffer. If slave crash before the update to used_ring and
> > > after the update to inflight buffer, the version should be odd and
> > > used_idx should be equal to used_ring.idx. Then we need to roll back
> > > the update to inflight buffer. As for the name of the version filed,
> > > actually I didn't find a good one, so I just copy it from struct
> > > kvm_steal_time...
> > >
> > > > > > +
> > > > > > +    avail_idx: Used to preserve the descriptor's order in avail ring so that
> > > > > > +    slave can resubmit descriptors in order.
> > > >
> > > > Why would that be necessary?
> > > >
> > >
> > > Maybe some devices will be able to use it to preserve order after
> > > reconnecting in future?
> >
> > If buffers are used in order then old entries in the ring
> > are not overwritten so inflight tracking is not
> > necessary. This is exactly the case with vhost user net today.
> >
> 
> OK, looks reasonable to me.
> 
> > > > >
> > > > > Will a completely new "packed vring" inflight shm layout be necessary to
> > > > > support the packed vring layout in VIRTIO 1.1?
> > > > >
> > > > > https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-csprd01.html#x1-610007
> > > >
> > > > Probably.
> > > >
> > >
> > > How about supporting packed virtqueue in guest driver?
> > >
> > > Thanks,
> > > Yongji
> >
> > Depends on the guest right? Linux has it:
> >
> 
> Sorry, actually I mean I prefer to support inflight tracking for
> packed virtqueue in guest driver. This feature is only used by legacy
> virtio 1.0 or virtio 0.9 device. What do you think about it?
> 
> Thanks,
> Yongji

I don't see what does one have to do with the other.  Either we do or we
don't want to do it without downtime and retries. If we don't mind
resets then let's do it by making guest changes.

-- 
MST
