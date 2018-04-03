Received: from eggs.gnu.org ([2001:4830:134:3::10]:34688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f3HQg-0004LZ-Dc
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 04:36:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f3HQf-0002lV-Do
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 04:36:34 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue,  3 Apr 2018 10:36:24 +0200
Message-Id: <20180403083625.15297-3-cohuck@redhat.com>
In-Reply-To: <20180403083625.15297-1-cohuck@redhat.com>
References: <20180403083625.15297-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.12 2/3] pc-bios/s390-ccw: Increase virtio
 timeout to 30 seconds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The current timeout is set to only three seconds - and considering that
vring_wait_reply() or rather get_second() is not doing any rounding,
the real timeout is likely rather 2 seconds in most cases. When the
host is really badly loaded, it's possible that we hit this timeout by
mistake; it's even more likely if we run the guest in TCG mode instead
of KVM.

So let's increase the timeout to 30 seconds instead to ease this situation
(30 seconds is also the timeout that is used by the Linux SCSI subsystem
for example, so this seems to be a sane value for block IO timeout).

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1549079
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1522316251-16399-1-git-send-email-thuth@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
[CH: tweaked commit message]
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 pc-bios/s390-ccw/virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index 817e7f56ea..cdb66f459e 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -14,7 +14,7 @@
 #include "virtio-scsi.h"
 #include "bswap.h"
 
-#define VRING_WAIT_REPLY_TIMEOUT 3
+#define VRING_WAIT_REPLY_TIMEOUT 30
 
 static VRing block[VIRTIO_MAX_VQS];
 static char ring_area[VIRTIO_RING_SIZE * VIRTIO_MAX_VQS]
-- 
2.14.3
