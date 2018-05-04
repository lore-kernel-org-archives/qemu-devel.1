Received: from eggs.gnu.org ([2001:4830:134:3::10]:34094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fEV60-0004LG-2l
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:25:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fEV5z-0007Ee-17
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:25:36 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  4 May 2018 09:25:05 +0200
Message-Id: <20180504072514.8450-7-cohuck@redhat.com>
In-Reply-To: <20180504072514.8450-1-cohuck@redhat.com>
References: <20180504072514.8450-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 06/15] pc-bios/s390-ccw: size_t should be
 unsigned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

From: Thomas Huth <thuth@redhat.com>

"size_t" should be an unsigned type according to the C standard.
Thus we should also use this convention in the s390-ccw firmware to avoid
confusion. I checked the sources, and apart from one spot in libc.c, the
code should all be fine with this change.

Buglink: https://bugs.launchpad.net/qemu/+bug/1753437
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/libc.c | 2 +-
 pc-bios/s390-ccw/libc.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/pc-bios/s390-ccw/libc.c b/pc-bios/s390-ccw/libc.c
index 38ea77d7aa..a786566c4c 100644
--- a/pc-bios/s390-ccw/libc.c
+++ b/pc-bios/s390-ccw/libc.c
@@ -63,7 +63,7 @@ uint64_t atoui(const char *str)
  */
 char *uitoa(uint64_t num, char *str, size_t len)
 {
-    size_t num_idx = 1; /* account for NUL */
+    long num_idx = 1; /* account for NUL */
     uint64_t tmp = num;
 
     IPL_assert(str != NULL, "uitoa: no space allocated to store string");
diff --git a/pc-bios/s390-ccw/libc.h b/pc-bios/s390-ccw/libc.h
index 63ece70c6b..818517ff5d 100644
--- a/pc-bios/s390-ccw/libc.h
+++ b/pc-bios/s390-ccw/libc.h
@@ -12,7 +12,7 @@
 #ifndef S390_CCW_LIBC_H
 #define S390_CCW_LIBC_H
 
-typedef long               size_t;
+typedef unsigned long      size_t;
 typedef int                bool;
 typedef unsigned char      uint8_t;
 typedef unsigned short     uint16_t;
-- 
2.14.3
