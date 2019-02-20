Received: from eggs.gnu.org ([209.51.188.92]:34151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gwY2F-00068I-HR
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 15:00:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gwY2E-0003fv-AL
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 15:00:03 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gwY2E-0003cH-3K
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 15:00:02 -0500
Received: by mail-qt1-f195.google.com with SMTP id s1so2578561qte.5
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 12:00:02 -0800 (PST)
Date: Wed, 20 Feb 2019 14:59:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190220145851-mutt-send-email-mst@kernel.org>
References: <20190218102748.2242-1-xieyongji@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218102748.2242-1-xieyongji@baidu.com>
Subject: Re: [Qemu-devel] [PATCH v6 0/7] vhost-user-blk: Add support for
 backend reconnecting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: elohimes@gmail.com
Cc: stefanha@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com, jasowang@redhat.com, maxime.coquelin@redhat.com, yury-kotov@yandex-team.ru, wrfsh@yandex-team.ru, qemu-devel@nongnu.org, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Mon, Feb 18, 2019 at 06:27:41PM +0800, elohimes@gmail.com wrote:
> From: Xie Yongji <xieyongji@baidu.com>
> 
> This patchset is aimed at supporting qemu to reconnect
> vhost-user-blk backend after vhost-user-blk backend crash or
> restart.
> 
> The patch 1 introduces two new messages VHOST_USER_GET_INFLIGHT_FD
> and VHOST_USER_SET_INFLIGHT_FD to support transferring shared
> buffer between qemu and backend.
> 
> The patch 2 deletes some redundant check in contrib/libvhost-user.c.
> 
> The patch 3,4 are the corresponding libvhost-user patches of
> patch 1. Make libvhost-user support VHOST_USER_GET_INFLIGHT_FD
> and VHOST_USER_SET_INFLIGHT_FD.
> 
> The patch 5 allows vhost-user-blk to use the two new messages
> to get/set inflight buffer from/to backend.
> 
> The patch 6 supports vhost-user-blk to reconnect backend when
> connection closed.
> 
> The patch 7 introduces VHOST_USER_PROTOCOL_F_SLAVE_SHMFD
> to vhost-user-blk backend which is used to tell qemu that
> we support reconnecting now.
> 
> To use it, we could start qemu with:
> 
> qemu-system-x86_64 \
>         -chardev socket,id=char0,path=/path/vhost.socket,reconnect=1, \
>         -device vhost-user-blk-pci,chardev=char0 \
> 
> and start vhost-user-blk backend with:
> 
> vhost-user-blk -b /path/file -s /path/vhost.socket
> 
> Then we can restart vhost-user-blk at any time during VM running.

Sorry is elohimes@gmail.com also an address that belongs to
Xie Yongji?

If not we need a signed off by from that address'
owner as well.

Thanks!



> V5 to V6:
> - Document the layout in inflight buffer for packed virtqueue
> - Rework the layout in inflight buffer for split virtqueue
> - Remove version field in VhostUserInflight
> - Add a patch to remove some redundant check in
>   contrib/libvhost-user.c
> - Document more details in vhost-user.txt
> 
> V4 to V5:
> - Drop patch that enables "nowait" option on client sockets
> - Support resubmitting inflight I/O in order
> - Make inflight I/O tracking more robust
> - Remove align field and add queue size field in VhostUserInflight
> - Document more details in vhost-user.txt
> 
> V3 to V4:
> - Drop messages VHOST_USER_GET_SHM_SIZE and VHOST_USER_SET_SHM_FD
> - Introduce two new messages VHOST_USER_GET_INFLIGHT_FD
>   and VHOST_USER_SET_INFLIGHT_FD
> - Allocate inflight buffer in backend rather than in qemu
> - Document a recommended format for inflight buffer
> 
> V2 to V3:
> - Using exisiting wait/nowait options to control connection on
>   client sockets instead of introducing "disconnected" option.
> - Support the case that vhost-user backend restart during initialzation
>   of vhost-user-blk device.
> 
> V1 to V2:
> - Introduce "disconnected" option for chardev instead of reuse "wait"
>   option
> - Support the case that QEMU starts before vhost-user backend
> - Drop message VHOST_USER_SET_VRING_INFLIGHT
> - Introduce two new messages VHOST_USER_GET_SHM_SIZE
>   and VHOST_USER_SET_SHM_FD
> 
> Xie Yongji (7):
>   vhost-user: Support transferring inflight buffer between qemu and
>     backend
>   libvhost-user: Remove unnecessary FD flag check for event file
>     descriptors
>   libvhost-user: Introduce vu_queue_map_desc()
>   libvhost-user: Support tracking inflight I/O in shared memory
>   vhost-user-blk: Add support to get/set inflight buffer
>   vhost-user-blk: Add support to reconnect backend
>   contrib/vhost-user-blk: enable inflight I/O tracking
> 
>  Makefile                                |   2 +-
>  contrib/libvhost-user/libvhost-user.c   | 400 ++++++++++++++++++++----
>  contrib/libvhost-user/libvhost-user.h   |  58 ++++
>  contrib/vhost-user-blk/vhost-user-blk.c |   3 +-
>  docs/interop/vhost-user.txt             | 264 ++++++++++++++++
>  hw/block/vhost-user-blk.c               | 229 +++++++++++---
>  hw/virtio/vhost-user.c                  | 107 +++++++
>  hw/virtio/vhost.c                       |  96 ++++++
>  include/hw/virtio/vhost-backend.h       |  10 +
>  include/hw/virtio/vhost-user-blk.h      |   5 +
>  include/hw/virtio/vhost.h               |  18 ++
>  11 files changed, 1084 insertions(+), 108 deletions(-)
> 
> -- 
> 2.17.1
