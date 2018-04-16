Received: from eggs.gnu.org ([2001:4830:134:3::10]:38326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f7ypZ-000416-De
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 03:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f7ypV-0007D1-Eb
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 03:45:41 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 16 Apr 2018 09:45:20 +0200
Message-Id: <1523864720-4680-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.13] pc-bios/s390-ccw: size_t should be
 unsigned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

"size_t" should be an unsigned type according to the C standard.
Thus we should also use this convention in the s390-ccw firmware to avoid
confusion. I checked the sources, and apart from one spot in libc.c, the
code should all be fine with this change.

Buglink: https://bugs.launchpad.net/qemu/+bug/1753437
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Use long instead of ssize_t in uitoa()

 pc-bios/s390-ccw/libc.c | 2 +-
 pc-bios/s390-ccw/libc.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/pc-bios/s390-ccw/libc.c b/pc-bios/s390-ccw/libc.c
index 38ea77d..a786566 100644
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
index 63ece70..818517f 100644
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
1.8.3.1
