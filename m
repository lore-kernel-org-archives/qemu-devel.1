Received: from eggs.gnu.org ([209.51.188.92]:52868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.streetman@canonical.com>) id 1hGT6Q-0001e0-Gx
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:46:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.streetman@canonical.com>) id 1hGT6P-0005Hz-Bi
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:46:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dan.streetman@canonical.com>)
	id 1hGT6P-00058j-2s
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:46:41 -0400
Received: from mail-yb1-f199.google.com ([209.85.219.199])
	by youngberry.canonical.com with esmtps
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <dan.streetman@canonical.com>) id 1hGT6N-00006W-37
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 18:46:39 +0000
Received: by mail-yb1-f199.google.com with SMTP id n18so16391575yba.9
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 11:46:39 -0700 (PDT)
From: Dan Streetman <dan.streetman@canonical.com>
Date: Tue, 16 Apr 2019 14:46:22 -0400
Message-Id: <20190416184624.15397-1-dan.streetman@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/2] vhost-user race condition on shutdown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org

From: Dan Streetman <ddstreet@canonical.com>

Buglink: https://launchpad.net/bugs/1823458

This is a race condition between the normal shutdown of a guest
and the handling of its vhost-user net being externally closed.
It's explained in more detail at the bug link; the short version
is that there are 2 problems, fixed by the 2 patches.  The first
patch fixes the race condition where multiple threads call
vhost_net_stop(), and the second patch prevents vhost-user from
calling vhost_net_cleanup() on CHR_EVENT_CLOSED, because it will
be cleaned up later and its fields will be accessed when
vhost_net_stop() is called later.

As explained in the bug report, this requires a rather complicated
setup to reproduce, and I'm not able to create a setup to reproduce
it myself.  However this has been reported to me/Canonical, and the
reporter is able to reproduce it consistently, so I've used them for
debug and testing.  This reproduction was done with the older 2.5
qemu, from Ubuntu Xenial; but the problem does still appear to exist
in upstream qemu, based on review of the code, which is why I'm sending
these patches.

Dan Streetman (2):
  add VirtIONet vhost_stopped flag to prevent multiple stops
  do not call vhost_net_cleanup() on running net from char user event

 hw/net/virtio-net.c            | 3 ++-
 include/hw/virtio/virtio-net.h | 1 +
 net/vhost-user.c               | 1 -
 3 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.20.1
