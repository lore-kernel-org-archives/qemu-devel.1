Received: from eggs.gnu.org ([209.51.188.92]:51577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1ghC1T-0000hV-Gb
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:27:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1ghC1S-0004CG-Nc
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:27:47 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1ghC1S-0004Am-Hf
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:27:46 -0500
Received: by mail-pf1-x444.google.com with SMTP id w73so3515904pfk.10
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 03:27:45 -0800 (PST)
From: elohimes@gmail.com
Date: Wed,  9 Jan 2019 19:27:21 +0800
Message-Id: <20190109112728.9214-1-xieyongji@baidu.com>
Subject: [Qemu-devel] [PATCH v4 for-4.0 0/7] vhost-user-blk: Add support for
 backend reconnecting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com, jasowang@redhat.com, maxime.coquelin@redhat.com, yury-kotov@yandex-team.ru, wrfsh@yandex-team.ru
Cc: qemu-devel@nongnu.org, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

From: Xie Yongji <xieyongji@baidu.com>

This patchset is aimed at supporting qemu to reconnect
vhost-user-blk backend after vhost-user-blk backend crash or
restart.

The patch 1 uses exisiting wait/nowait options to make QEMU not
do a connect on client sockets during initialization of the chardev.

The patch 2 introduces two new messages VHOST_USER_GET_INFLIGHT_FD
and VHOST_USER_SET_INFLIGHT_FD to support providing shared
memory to backend.

The patch 3,4 are the corresponding libvhost-user patches of
patch 2. Make libvhost-user support VHOST_USER_GET_INFLIGHT_FD
and VHOST_USER_SET_INFLIGHT_FD.

The patch 5 allows vhost-user-blk to use the two new messages
to get/set inflight buffer from/to backend.

The patch 6 supports vhost-user-blk to reconnect backend when
connection closed.

The patch 7 introduces VHOST_USER_PROTOCOL_F_SLAVE_SHMFD
to vhost-user-blk backend which is used to tell qemu that
we support reconnecting now.

To use it, we could start qemu with:

qemu-system-x86_64 \
        -chardev socket,id=char0,path=/path/vhost.socket,nowait,reconnect=1, \
        -device vhost-user-blk-pci,chardev=char0 \

and start vhost-user-blk backend with:

vhost-user-blk -b /path/file -s /path/vhost.socket

Then we can restart vhost-user-blk at any time during VM running.

V3 to V4:
- Drop messages VHOST_USER_GET_SHM_SIZE and VHOST_USER_SET_SHM_FD
- Introduce two new messages VHOST_USER_GET_INFLIGHT_FD
  and VHOST_USER_SET_INFLIGHT_FD
- Allocate inflight buffer in backend rather than in qemu
- Document a recommended format for inflight buffer

V2 to V3:
- Using exisiting wait/nowait options to control connection on
  client sockets instead of introducing "disconnected" option.
- Support the case that vhost-user backend restart during initialzation
  of vhost-user-blk device.

V1 to V2:
- Introduce "disconnected" option for chardev instead of reuse "wait"
  option
- Support the case that QEMU starts before vhost-user backend
- Drop message VHOST_USER_SET_VRING_INFLIGHT
- Introduce two new messages VHOST_USER_GET_SHM_SIZE
  and VHOST_USER_SET_SHM_FD

Xie Yongji (7):
  char-socket: Enable "nowait" option on client sockets
  vhost-user: Support transferring inflight buffer between qemu and
    backend
  libvhost-user: Introduce vu_queue_map_desc()
  libvhost-user: Support tracking inflight I/O in shared memory
  vhost-user-blk: Add support to get/set inflight buffer
  vhost-user-blk: Add support to reconnect backend
  contrib/vhost-user-blk: enable inflight I/O tracking

 Makefile                                |   2 +-
 chardev/char-socket.c                   |  56 ++--
 contrib/libvhost-user/libvhost-user.c   | 346 ++++++++++++++++++++----
 contrib/libvhost-user/libvhost-user.h   |  29 ++
 contrib/vhost-user-blk/vhost-user-blk.c |   3 +-
 docs/interop/vhost-user.txt             |  60 ++++
 hw/block/vhost-user-blk.c               | 223 ++++++++++++---
 hw/virtio/vhost-user.c                  | 108 ++++++++
 hw/virtio/vhost.c                       | 108 ++++++++
 include/hw/virtio/vhost-backend.h       |   9 +
 include/hw/virtio/vhost-user-blk.h      |   5 +
 include/hw/virtio/vhost.h               |  19 ++
 qapi/char.json                          |   3 +-
 qemu-options.hx                         |   9 +-
 14 files changed, 851 insertions(+), 129 deletions(-)

-- 
2.17.1
