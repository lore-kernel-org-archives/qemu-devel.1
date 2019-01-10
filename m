Received: from eggs.gnu.org ([209.51.188.92]:56542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ghXkU-0008EO-3w
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:39:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ghXkR-0003j3-KF
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:39:42 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ghXkG-0003f6-L5
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:39:31 -0500
Received: by mail-wm1-x343.google.com with SMTP id y185so13019124wmd.1
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 02:39:28 -0800 (PST)
MIME-Version: 1.0
References: <20190109112728.9214-1-xieyongji@baidu.com>
In-Reply-To: <20190109112728.9214-1-xieyongji@baidu.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 10 Jan 2019 14:39:13 +0400
Message-ID: <CAJ+F1CLPFUnJANJs3SSine9YRXXqpR+gh6wHOLD=ivWpyURmJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: Yongji Xie <elohimes@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Jason Wang <jasowang@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, yury-kotov@yandex-team.ru, wrfsh@yandex-team.ru, nixun@baidu.com, QEMU <qemu-devel@nongnu.org>, lilin24@baidu.com, zhangyu31@baidu.com, chaiwen@baidu.com, Xie Yongji <xieyongji@baidu.com>

Hi

On Wed, Jan 9, 2019 at 3:28 PM <elohimes@gmail.com> wrote:
>
> From: Xie Yongji <xieyongji@baidu.com>
>
> This patchset is aimed at supporting qemu to reconnect
> vhost-user-blk backend after vhost-user-blk backend crash or
> restart.
>
> The patch 1 uses exisiting wait/nowait options to make QEMU not
> do a connect on client sockets during initialization of the chardev.
>
> The patch 2 introduces two new messages VHOST_USER_GET_INFLIGHT_FD
> and VHOST_USER_SET_INFLIGHT_FD to support providing shared
> memory to backend.
>
> The patch 3,4 are the corresponding libvhost-user patches of
> patch 2. Make libvhost-user support VHOST_USER_GET_INFLIGHT_FD
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
>         -chardev socket,id=3Dchar0,path=3D/path/vhost.socket,nowait,recon=
nect=3D1, \
>         -device vhost-user-blk-pci,chardev=3Dchar0 \
>
> and start vhost-user-blk backend with:
>
> vhost-user-blk -b /path/file -s /path/vhost.socket
>
> Then we can restart vhost-user-blk at any time during VM running.
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
>   char-socket: Enable "nowait" option on client sockets

This patch breaks make check.

It would be nice to add a test for the new nowait behaviour.

>   vhost-user: Support transferring inflight buffer between qemu and
>     backend
>   libvhost-user: Introduce vu_queue_map_desc()
>   libvhost-user: Support tracking inflight I/O in shared memory
>   vhost-user-blk: Add support to get/set inflight buffer
>   vhost-user-blk: Add support to reconnect backend
>   contrib/vhost-user-blk: enable inflight I/O tracking
>
>  Makefile                                |   2 +-
>  chardev/char-socket.c                   |  56 ++--
>  contrib/libvhost-user/libvhost-user.c   | 346 ++++++++++++++++++++----
>  contrib/libvhost-user/libvhost-user.h   |  29 ++
>  contrib/vhost-user-blk/vhost-user-blk.c |   3 +-
>  docs/interop/vhost-user.txt             |  60 ++++
>  hw/block/vhost-user-blk.c               | 223 ++++++++++++---
>  hw/virtio/vhost-user.c                  | 108 ++++++++
>  hw/virtio/vhost.c                       | 108 ++++++++
>  include/hw/virtio/vhost-backend.h       |   9 +
>  include/hw/virtio/vhost-user-blk.h      |   5 +
>  include/hw/virtio/vhost.h               |  19 ++
>  qapi/char.json                          |   3 +-
>  qemu-options.hx                         |   9 +-
>  14 files changed, 851 insertions(+), 129 deletions(-)
>
> --
> 2.17.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
