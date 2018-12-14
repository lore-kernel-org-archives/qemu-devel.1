Received: from eggs.gnu.org ([2001:4830:134:3::10]:37802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gXcin-0005z8-0p
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 20:56:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gXcim-0006XC-34
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 20:56:56 -0500
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:32943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gXcil-0006Vw-SI
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 20:56:55 -0500
Received: by mail-yb1-xb43.google.com with SMTP id c67so1679823ybf.0
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 17:56:55 -0800 (PST)
MIME-Version: 1.0
References: <20181206063552.6701-1-xieyongji@baidu.com>
	<20181213094043-mutt-send-email-mst@kernel.org>
In-Reply-To: <20181213094043-mutt-send-email-mst@kernel.org>
From: Yongji Xie <elohimes@gmail.com>
Date: Fri, 14 Dec 2018 09:56:41 +0800
Message-ID: <CAONzpcZLg5OT2nfBMVUktk2MC9-32yq0Nw_Lu3GjU_jPo0dqVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.0 0/6] vhost-user-blk: Add support
 for backend reconnecting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Thu, 13 Dec 2018 at 22:45, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Dec 06, 2018 at 02:35:46PM +0800, elohimes@gmail.com wrote:
> > From: Xie Yongji <xieyongji@baidu.com>
> >
> > This patchset is aimed at supporting qemu to reconnect
> > vhost-user-blk backend after vhost-user-blk backend crash or
> > restart.
> >
> > The patch 1 tries to implenment the sync connection for
> > "reconnect socket".
> >
> > The patch 2 introduces a new message VHOST_USER_SET_VRING_INFLIGHT
> > to support offering shared memory to backend to record
> > its inflight I/O.
> >
> > The patch 3,4 are the corresponding libvhost-user patches of
> > patch 2. Make libvhost-user support VHOST_USER_SET_VRING_INFLIGHT.
> >
> > The patch 5 supports vhost-user-blk to reconnect backend when
> > connection closed.
> >
> > The patch 6 tells qemu that we support reconnecting now.
> >
> > To use it, we could start qemu with:
> >
> > qemu-system-x86_64 \
> >         -chardev socket,id=char0,path=/path/vhost.socket,reconnect=1,wait \
> >         -device vhost-user-blk-pci,chardev=char0 \
> >
> > and start vhost-user-blk backend with:
> >
> > vhost-user-blk -b /path/file -s /path/vhost.socket
> >
> > Then we can restart vhost-user-blk at any time during VM running.
> >
> > Xie Yongji (6):
> >   char-socket: Enable "wait" option for client mode
> >   vhost-user: Add shared memory to record inflight I/O
> >   libvhost-user: Introduce vu_queue_map_desc()
> >   libvhost-user: Support recording inflight I/O in shared memory
> >   vhost-user-blk: Add support for reconnecting backend
> >   contrib/vhost-user-blk: enable inflight I/O recording
>
> What is missing in all this is documentation.
> Specifically docs/interop/vhost-user.txt.
>
> At a high level the design is IMO a good one.
>
> However I would prefer reading the protocol first before
> the code.
>
> So here's what I managed to figure out, and it matches
> how I imagined it would work when I was still
> thinking about out of order for net:
>
> - backend allocates memory to keep its stuff around
> - sends it to qemu so it can maintain it
> - gets it back on reconnect
>
> format and size etc are all up to the backend,
> a good implementation would probably implement some
> kind of versioning.
>
> Is this what this implements?
>

Definitely, yes. And the comments looks good to me. Qemu get size and
version from backend, then allocate memory and send it back with
version. Backend knows how to use the memory according to the version.
If we do that, should we allocate the memory per device rather than
per virtqueue?

Thanks,
Yongji
