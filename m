Received: from eggs.gnu.org ([209.51.188.92]:51398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gkKA9-0006ZC-T8
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 21:45:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gkKA8-00045d-V5
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 21:45:41 -0500
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:32822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gkKA8-000406-QX
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 21:45:40 -0500
Received: by mail-yw1-xc44.google.com with SMTP id p65so4722993ywe.0
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 18:45:35 -0800 (PST)
MIME-Version: 1.0
References: <20190109112728.9214-1-xieyongji@baidu.com>
	<20190109112728.9214-3-xieyongji@baidu.com>
	<20190114172157-mutt-send-email-mst@kernel.org>
	<CAONzpca2=Y+KbWCkF4YVmCU3_+X3KTBBupmeFmrPodMaFUs-cw@mail.gmail.com>
	<20190115075022-mutt-send-email-mst@kernel.org>
	<CAONzpcbnGbe-qjZdiBdjrrWbnhCBy+zGTtZ_qOjNoBecC+1r6A@mail.gmail.com>
In-Reply-To: <CAONzpcbnGbe-qjZdiBdjrrWbnhCBy+zGTtZ_qOjNoBecC+1r6A@mail.gmail.com>
From: Yongji Xie <elohimes@gmail.com>
Date: Fri, 18 Jan 2019 10:45:22 +0800
Message-ID: <CAONzpcbZ5yX1Vkri_d43HY91BdL4GZ_=TaSCZROme7dR4q1M_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 for-4.0 2/7] vhost-user: Support
 transferring inflight buffer between qemu and backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Jason Wang <jasowang@redhat.com>, "Coquelin,
	Maxime" <maxime.coquelin@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, =?UTF-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>, qemu-devel <qemu-devel@nongnu.org>, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Tue, 15 Jan 2019 at 22:18, Yongji Xie <elohimes@gmail.com> wrote:
>
> On Tue, 15 Jan 2019 at 20:54, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Jan 15, 2019 at 02:46:42PM +0800, Yongji Xie wrote:
> > > On Tue, 15 Jan 2019 at 06:25, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Wed, Jan 09, 2019 at 07:27:23PM +0800, elohimes@gmail.com wrote:
> > > > > @@ -382,6 +397,30 @@ If VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD protocol feature is negotiated,
> > > > >  slave can send file descriptors (at most 8 descriptors in each message)
> > > > >  to master via ancillary data using this fd communication channel.
> > > > >
> > > > > +Inflight I/O tracking
> > > > > +---------------------
> > > > > +
> > > > > +To support slave reconnecting, slave need to track inflight I/O in a
> > > > > +shared memory. VHOST_USER_GET_INFLIGHT_FD and VHOST_USER_SET_INFLIGHT_FD
> > > > > +are used to transfer the memory between master and slave. And to encourage
> > > > > +consistency, we provide a recommended format for this memory:
> > > >
> > > > I think we should make a stronger statement and actually
> > > > just say what the format is. Not recommend it weakly.
> > > >
> > >
> > > Okey, will do it.
> > >
> > > > > +
> > > > > +offset        width    description
> > > > > +0x0      0x400    region for queue0
> > > > > +0x400    0x400    region for queue1
> > > > > +0x800    0x400    region for queue2
> > > > > +...      ...      ...
> > > > > +
> > > > > +For each virtqueue, we have a 1024 bytes region.
> > > >
> > > >
> > > > Why is the size hardcoded? Why not a function of VQ size?
> > > >
> > >
> > > Sorry, I didn't get your point. Should the region's size be fixed? Do
> > > you mean we need to document a function for the region's size?
> >
> >
> > Well you are saying 0x0 to 0x400 is for queue0.
> > How do you know that's enough? And why are 0x400
> > bytes necessary? After all max queue size can be very small.
> >
> >
>
> OK, I think I get your point. So we need something like:
>
> region's size = max_queue_size * 32 byte + xxx byte (if any)
>
> Right?
>
> >
> > > >
> > > > > The region's format is like:
> > > > > +
> > > > > +offset   width    description
> > > > > +0x0      0x1      descriptor 0 is in use or not
> > > > > +0x1      0x1      descriptor 1 is in use or not
> > > > > +0x2      0x1      descriptor 2 is in use or not
> > > > > +...      ...      ...
> > > > > +
> > > > > +For each descriptor, we use one byte to specify whether it's in use or not.
> > > > > +
> > > > >  Protocol features
> > > > >  -----------------
> > > > >
> > > >
> > > > I think that it's a good idea to have a version in this region.
> > > > Otherwise how are you going to handle compatibility when
> > > > this needs to be extended?
> > > >
> > >
> > > I have put the version into the message's payload: VhostUserInflight. Is it OK?
> > >
> > > Thanks,
> > > Yongji
> >
> > I'm not sure I like it.  So is qemu expected to maintain it? Reset it?
> > Also don't you want to be able to detect that qemu has reset the buffer?
> > If we have version 1 at a known offset that can serve both purposes.
> > Given it only has value within the buffer why not store it there?
> >
>
> Yes, that looks better. Will update it in v5.
>

Hi Michael,

I found a problem during implentmenting this. If we put version into
the shared buffer, QEMU will reset it when vm reset. Then if backend
restart at the same time, the version of this buffer will be lost. So
maybe qemu still need to maintain it.

Thanks,
Yongji
