Received: from eggs.gnu.org ([209.51.188.92]:45121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1giBHu-0004ob-On
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 23:52:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1giBFf-0007tD-O5
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 23:50:32 -0500
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:39899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1giBFf-0007o9-Fl
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 23:50:31 -0500
Received: by mail-yw1-xc42.google.com with SMTP id k188so6667018ywa.6
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 20:50:24 -0800 (PST)
MIME-Version: 1.0
References: <20190109112728.9214-1-xieyongji@baidu.com>
	<20190110102551.GD19025@stefanha-x1.localdomain>
	<CAONzpcYgVWUFg1uSHOLzOS5en2vHP_=oNXQvWQEZd9FdYi2uxA@mail.gmail.com>
	<20190111155342.GA14776@stefanha-x1.localdomain>
In-Reply-To: <20190111155342.GA14776@stefanha-x1.localdomain>
From: Yongji Xie <elohimes@gmail.com>
Date: Sat, 12 Jan 2019 12:50:12 +0800
Message-ID: <CAONzpca7NEzX-GZ4W5J328njEW_NpUXJphTNwzgqfXOS-f54-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 for-4.0 0/7] vhost-user-blk: Add support
 for backend reconnecting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Jason Wang <jasowang@redhat.com>, "Coquelin,
	Maxime" <maxime.coquelin@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, =?UTF-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>, nixun@baidu.com, qemu-devel <qemu-devel@nongnu.org>, lilin24@baidu.com, zhangyu31@baidu.com, chaiwen@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Fri, 11 Jan 2019 at 23:53, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Thu, Jan 10, 2019 at 06:59:27PM +0800, Yongji Xie wrote:
> > On Thu, 10 Jan 2019 at 18:25, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > >
> > > On Wed, Jan 09, 2019 at 07:27:21PM +0800, elohimes@gmail.com wrote:
> > > > From: Xie Yongji <xieyongji@baidu.com>
> > > >
> > > > This patchset is aimed at supporting qemu to reconnect
> > > > vhost-user-blk backend after vhost-user-blk backend crash or
> > > > restart.
> > > >
> > > > The patch 1 uses exisiting wait/nowait options to make QEMU not
> > > > do a connect on client sockets during initialization of the chardev.
> > > >
> > > > The patch 2 introduces two new messages VHOST_USER_GET_INFLIGHT_FD
> > > > and VHOST_USER_SET_INFLIGHT_FD to support providing shared
> > > > memory to backend.
> > >
> > > Can you describe the problem that the inflight I/O shared memory region
> > > solves?
> > >
> >
> > The backend need to get inflight I/O and do I/O replay after restart.
> > Now we can only get used_idx in used_ring. It's not enough. Because we
> > might not process descriptors in the same order which they have been
> > made available sometimes. A simple example:
> > https://patchwork.kernel.org/cover/10715305/#22375607. So we need a
> > shared memory to track inflight I/O.
>
> The inflight shared memory region is something that needs to be
> discussed in detail to make sure it is correct not just for vhost-blk
> but also for other vhost-user devices in the future.
>
> Please expand the protocol documentation so that someone can implement
> this feature without looking at the code.  Explain the reason for the
> inflight shared memory region and how exactly it used.
>

OK, will do it in v5.

> After a quick look at the shared memory region documentation I have a
> few questions:
>
> 1. The avail ring only contains "head" indices, each of which may chain
>    non-head descriptors.  Does the inflight memory region track only the
>    heads?
>

Yes, we only track the head in inflight region.

> 2. Does the inflight shared memory region preserve avail ring order?
>    For example, if the guest submitted 5 2 4, will the new vhost-user
>    backend keep that order or does it see 2 4 5?
>

Now we don't support to resubmit I/O in order. But I think we can add
a timestamp
for each inflight descriptor in shared memory to achieve that.

> 3. What are the exact memory region size requirements?  Imagine a device
>    with a large virtqueue.  Or a device with multiple virtqueues of
>    different sizes.  Can your structure hand those cases?
>

Each available virtqueue should have a region in inflight memory. The
size of region should be fixed and support handling max size elements
in one virtqueue. There may be a little waste, but I think it make the
structure more clear.

> I'm concerned that this approach to device recovery is invasive and hard
> to test.  Instead I would use VIRTIO's Device Status Field
> DEVICE_NEEDS_RESET bit to tell the guest driver that a reset is
> necessary.  This is more disruptive - drivers either have to resubmit or
> fail I/O with EIO - but it's also simple and more likely to work
> correctly (it only needs to be implemented correctly in the guest
> driver, not in the many available vhost-user backend implementations).
>

So you mean adding one way to notify guest to resubmit inflight I/O. I
think it's a good idea. But would it be more flexible to implement
this in backend. We can support old guest. And it will be easy to fix
bug or add feature.

Thanks,
Yongji
