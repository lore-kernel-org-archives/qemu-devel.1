Received: from eggs.gnu.org ([2001:4830:134:3::10]:35695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f6zjD-0007vF-Bq
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f6zj7-0000rE-Nd
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:31:03 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 13 Apr 2018 16:30:47 +0200
Message-Id: <1523629847-22369-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.13] pc-bios/s390-ccw: size_t should be
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
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>

"size_t" should be an unsigned type - the signed counterpart is called
"ssize_t" in the C standard instead. Thus we should also use this
convention in the s390-ccw firmware to avoid confusion. I checked the
sources, and apart from one spot in libc.c (which now uses ssize_t with
this patch), the code should all be fine with this change.

Buglink: https://bugs.launchpad.net/qemu/+bug/1753437
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/libc.c | 2 +-
 pc-bios/s390-ccw/libc.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/pc-bios/s390-ccw/libc.c b/pc-bios/s390-ccw/libc.c
index 38ea77d..827d204 100644
--- a/pc-bios/s390-ccw/libc.c
+++ b/pc-bios/s390-ccw/libc.c
@@ -63,7 +63,7 @@ uint64_t atoui(const char *str)
  */
 char *uitoa(uint64_t num, char *str, size_t len)
 {
-    size_t num_idx = 1; /* account for NUL */
+    ssize_t num_idx = 1; /* account for NUL */
     uint64_t tmp = num;
 
     IPL_assert(str != NULL, "uitoa: no space allocated to store string");
diff --git a/pc-bios/s390-ccw/libc.h b/pc-bios/s390-ccw/libc.h
index 63ece70..57c4199 100644
--- a/pc-bios/s390-ccw/libc.h
+++ b/pc-bios/s390-ccw/libc.h
@@ -12,7 +12,8 @@
 #ifndef S390_CCW_LIBC_H
 #define S390_CCW_LIBC_H
 
-typedef long               size_t;
+typedef unsigned long      size_t;
+typedef signed long        ssize_t;
 typedef int                bool;
 typedef unsigned char      uint8_t;
 typedef unsigned short     uint16_t;
-- 
1.8.3.1
