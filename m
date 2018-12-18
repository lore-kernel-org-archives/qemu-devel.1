Received: from eggs.gnu.org ([2001:4830:134:3::10]:53115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gZCB6-0007QY-1B
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:00:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gZCB0-0001Z4-4a
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:00:39 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39921)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gZCAz-0001YN-UU
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:00:34 -0500
Received: by mail-pf1-x442.google.com with SMTP id r136so841916pfc.6
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 02:00:33 -0800 (PST)
From: elohimes@gmail.com
Date: Tue, 18 Dec 2018 17:59:55 +0800
Message-Id: <20181218100002.11219-1-xieyongji@baidu.com>
Subject: [Qemu-devel] [PATCH v2 for-4.0 0/7] vhost-user-blk: Add support for
 backend reconnecting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, yury-kotov@yandex-team.ru, maxime.coquelin@redhat.com
Cc: qemu-devel@nongnu.org, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

From: Xie Yongji <xieyongji@baidu.com>

This patchset is aimed at supporting qemu to reconnect
vhost-user-blk backend after vhost-user-blk backend crash or
restart.

The patch 1 adds a "disconnected" option to init the chardev socket
in disconnected state.

The patch 2 introduces two new messages VHOST_USER_GET_SHM_SIZE
and VHOST_USER_SET_SHM_FD to support providing shared
memory to backend.

The patch 3,4 are the corresponding libvhost-user patches of
patch 2. Make libvhost-user support VHOST_USER_GET_SHM_SIZE
and VHOST_USER_SET_SHM_FD.

The patch 5 allows vhost-user-blk to use the two new messages
to provide shared memory to backend.

The patch 6 supports vhost-user-blk to reconnect backend when
connection closed.

The patch 7 introduces VHOST_USER_PROTOCOL_F_SLAVE_SHMFD
to vhost-user-blk backend which is used to tell qemu that
we support reconnecting now.

To use it, we could start qemu with:

qemu-system-x86_64 \
        -chardev socket,id=char0,path=/path/vhost.socket,disconnected,reconnect=1, \
        -device vhost-user-blk-pci,chardev=char0 \

and start vhost-user-blk backend with:

vhost-user-blk -b /path/file -s /path/vhost.socket

Then we can restart vhost-user-blk at any time during VM running.

V1 to V2:
- Introduce "disconnected" option for chardev instead of reuse "wait"
  option
- Support the case that QEMU starts before vhost-user backend
- Drop message VHOST_USER_SET_VRING_INFLIGHT
- Introduce two new messages VHOST_USER_GET_SHM_SIZE
  and VHOST_USER_SET_SHM_FD

Xie Yongji (7):
  chardev: Add disconnected option for chardev socket
  vhost-user: Support providing shared memory to backend
  libvhost-user: Introduce vu_queue_map_desc()
  libvhost-user: Support recording inflight I/O in shared memory
  vhost-user-blk: Add support to provide shared memory to backend
  vhost-user-blk: Add support to reconnect backend
  contrib/vhost-user-blk: enable inflight I/O recording

 chardev/char-socket.c                   |  10 +
 chardev/char.c                          |   3 +
 contrib/libvhost-user/libvhost-user.c   | 309 ++++++++++++++++++++----
 contrib/libvhost-user/libvhost-user.h   |  33 +++
 contrib/vhost-user-blk/vhost-user-blk.c |   3 +-
 docs/interop/vhost-user.txt             |  41 ++++
 hw/block/vhost-user-blk.c               | 205 ++++++++++++++--
 hw/virtio/vhost-user.c                  |  86 +++++++
 hw/virtio/vhost.c                       | 117 +++++++++
 include/hw/virtio/vhost-backend.h       |   9 +
 include/hw/virtio/vhost-user-blk.h      |   5 +
 include/hw/virtio/vhost.h               |  19 ++
 qapi/char.json                          |   3 +
 qemu-options.hx                         |  28 ++-
 14 files changed, 790 insertions(+), 81 deletions(-)

-- 
2.17.1
