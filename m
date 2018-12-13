Received: from eggs.gnu.org ([2001:4830:134:3::10]:60292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gXSFD-000649-E5
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:45:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gXSFA-0000jA-8S
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:45:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gXSFA-0000hG-0B
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:45:40 -0500
Date: Thu, 13 Dec 2018 09:45:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181213094043-mutt-send-email-mst@kernel.org>
References: <20181206063552.6701-1-xieyongji@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206063552.6701-1-xieyongji@baidu.com>
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
To: elohimes@gmail.com
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Thu, Dec 06, 2018 at 02:35:46PM +0800, elohimes@gmail.com wrote:
> From: Xie Yongji <xieyongji@baidu.com>
> 
> This patchset is aimed at supporting qemu to reconnect
> vhost-user-blk backend after vhost-user-blk backend crash or
> restart.
> 
> The patch 1 tries to implenment the sync connection for
> "reconnect socket".
> 
> The patch 2 introduces a new message VHOST_USER_SET_VRING_INFLIGHT
> to support offering shared memory to backend to record
> its inflight I/O.
> 
> The patch 3,4 are the corresponding libvhost-user patches of
> patch 2. Make libvhost-user support VHOST_USER_SET_VRING_INFLIGHT.
> 
> The patch 5 supports vhost-user-blk to reconnect backend when
> connection closed.
> 
> The patch 6 tells qemu that we support reconnecting now.
> 
> To use it, we could start qemu with:
> 
> qemu-system-x86_64 \
>         -chardev socket,id=char0,path=/path/vhost.socket,reconnect=1,wait \
>         -device vhost-user-blk-pci,chardev=char0 \
> 
> and start vhost-user-blk backend with:
> 
> vhost-user-blk -b /path/file -s /path/vhost.socket
> 
> Then we can restart vhost-user-blk at any time during VM running.
> 
> Xie Yongji (6):
>   char-socket: Enable "wait" option for client mode
>   vhost-user: Add shared memory to record inflight I/O
>   libvhost-user: Introduce vu_queue_map_desc()
>   libvhost-user: Support recording inflight I/O in shared memory
>   vhost-user-blk: Add support for reconnecting backend
>   contrib/vhost-user-blk: enable inflight I/O recording

What is missing in all this is documentation.
Specifically docs/interop/vhost-user.txt.

At a high level the design is IMO a good one.

However I would prefer reading the protocol first before
the code.

So here's what I managed to figure out, and it matches
how I imagined it would work when I was still
thinking about out of order for net:

- backend allocates memory to keep its stuff around
- sends it to qemu so it can maintain it
- gets it back on reconnect

format and size etc are all up to the backend,
a good implementation would probably implement some
kind of versioning.

Is this what this implements?

>  chardev/char-socket.c                   |   5 +-
>  contrib/libvhost-user/libvhost-user.c   | 215 ++++++++++++++++++++----
>  contrib/libvhost-user/libvhost-user.h   |  19 +++
>  contrib/vhost-user-blk/vhost-user-blk.c |   3 +-
>  hw/block/vhost-user-blk.c               | 169 +++++++++++++++++--
>  hw/virtio/vhost-user.c                  |  69 ++++++++
>  hw/virtio/vhost.c                       |   8 +
>  include/hw/virtio/vhost-backend.h       |   4 +
>  include/hw/virtio/vhost-user-blk.h      |   4 +
>  include/hw/virtio/vhost-user.h          |   8 +
>  10 files changed, 452 insertions(+), 52 deletions(-)
> 
> -- 
> 2.17.1
