Received: from eggs.gnu.org ([2001:4830:134:3::10]:52667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gUnH4-0001Jr-I2
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:36:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gUnGz-00038x-Ud
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:36:38 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gUnGz-000364-Dr
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:36:33 -0500
Received: by mail-pf1-x442.google.com with SMTP id b7so11279920pfi.8
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 22:36:31 -0800 (PST)
From: elohimes@gmail.com
Date: Thu,  6 Dec 2018 14:35:46 +0800
Message-Id: <20181206063552.6701-1-xieyongji@baidu.com>
Subject: [Qemu-devel] [PATCH for-4.0 0/6] vhost-user-blk: Add support for
 backend reconnecting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

From: Xie Yongji <xieyongji@baidu.com>

This patchset is aimed at supporting qemu to reconnect
vhost-user-blk backend after vhost-user-blk backend crash or
restart.

The patch 1 tries to implenment the sync connection for
"reconnect socket".

The patch 2 introduces a new message VHOST_USER_SET_VRING_INFLIGHT
to support offering shared memory to backend to record
its inflight I/O.

The patch 3,4 are the corresponding libvhost-user patches of
patch 2. Make libvhost-user support VHOST_USER_SET_VRING_INFLIGHT.

The patch 5 supports vhost-user-blk to reconnect backend when
connection closed.

The patch 6 tells qemu that we support reconnecting now.

To use it, we could start qemu with:

qemu-system-x86_64 \
        -chardev socket,id=char0,path=/path/vhost.socket,reconnect=1,wait \
        -device vhost-user-blk-pci,chardev=char0 \

and start vhost-user-blk backend with:

vhost-user-blk -b /path/file -s /path/vhost.socket

Then we can restart vhost-user-blk at any time during VM running.

Xie Yongji (6):
  char-socket: Enable "wait" option for client mode
  vhost-user: Add shared memory to record inflight I/O
  libvhost-user: Introduce vu_queue_map_desc()
  libvhost-user: Support recording inflight I/O in shared memory
  vhost-user-blk: Add support for reconnecting backend
  contrib/vhost-user-blk: enable inflight I/O recording

 chardev/char-socket.c                   |   5 +-
 contrib/libvhost-user/libvhost-user.c   | 215 ++++++++++++++++++++----
 contrib/libvhost-user/libvhost-user.h   |  19 +++
 contrib/vhost-user-blk/vhost-user-blk.c |   3 +-
 hw/block/vhost-user-blk.c               | 169 +++++++++++++++++--
 hw/virtio/vhost-user.c                  |  69 ++++++++
 hw/virtio/vhost.c                       |   8 +
 include/hw/virtio/vhost-backend.h       |   4 +
 include/hw/virtio/vhost-user-blk.h      |   4 +
 include/hw/virtio/vhost-user.h          |   8 +
 10 files changed, 452 insertions(+), 52 deletions(-)

-- 
2.17.1
