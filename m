Received: from eggs.gnu.org ([2001:4830:134:3::10]:35303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dTQTi-0002Sy-AG
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dTQTg-0001nO-TO
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:27:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dTQTg-0001n2-K7
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:27:12 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  7 Jul 2017 12:26:57 +0200
Message-Id: <1499423224-23060-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1499423224-23060-1-git-send-email-thuth@redhat.com>
References: <1499423224-23060-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [RFC PATCH v2 1/8] pc-bios/s390-ccw: Move libc
 functions to separate header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

The upcoming netboot code will use the libc from SLOF. To be able
to still use s390-ccw.h there, the libc related functions in this
header have to be moved to a different location.
And while we're at it, remove the duplicate memcpy() function from
sclp.c.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/bootmap.c     |  1 +
 pc-bios/s390-ccw/libc.h        | 43 ++++++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/main.c        |  1 +
 pc-bios/s390-ccw/s390-ccw.h    | 29 ----------------------------
 pc-bios/s390-ccw/sclp.c        | 10 ++--------
 pc-bios/s390-ccw/virtio-scsi.c |  1 +
 pc-bios/s390-ccw/virtio.c      |  1 +
 7 files changed, 49 insertions(+), 37 deletions(-)
 create mode 100644 pc-bios/s390-ccw/libc.h

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 523fa78..458d3da 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -8,6 +8,7 @@
  * directory.
  */
 
+#include "libc.h"
 #include "s390-ccw.h"
 #include "bootmap.h"
 #include "virtio.h"
diff --git a/pc-bios/s390-ccw/libc.h b/pc-bios/s390-ccw/libc.h
new file mode 100644
index 0000000..9076bb7
--- /dev/null
+++ b/pc-bios/s390-ccw/libc.h
@@ -0,0 +1,43 @@
+/*
+ * libc-style definitions and functions
+ *
+ * This code is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#ifndef S390_CCW_LIBC_H
+#define S390_CCW_LIBC_H
+
+typedef long               size_t;
+typedef int                bool;
+typedef unsigned char      uint8_t;
+typedef unsigned short     uint16_t;
+typedef unsigned int       uint32_t;
+typedef unsigned long long uint64_t;
+
+static inline void *memset(void *s, int c, size_t n)
+{
+    int i;
+    unsigned char *p = s;
+
+    for (i = 0; i < n; i++) {
+        p[i] = c;
+    }
+
+    return s;
+}
+
+static inline void *memcpy(void *s1, const void *s2, size_t n)
+{
+    uint8_t *p1 = s1;
+    const uint8_t *p2 = s2;
+
+    while (n--) {
+        p1[n] = p2[n];
+    }
+    return s1;
+}
+
+#endif
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 1cacc1b..40cba8d 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -8,6 +8,7 @@
  * directory.
  */
 
+#include "libc.h"
 #include "s390-ccw.h"
 #include "virtio.h"
 
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 2089274..43e2d42 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -18,12 +18,6 @@ typedef unsigned short     u16;
 typedef unsigned int       u32;
 typedef unsigned long long u64;
 typedef unsigned long      ulong;
-typedef long               size_t;
-typedef int                bool;
-typedef unsigned char      uint8_t;
-typedef unsigned short     uint16_t;
-typedef unsigned int       uint32_t;
-typedef unsigned long long uint64_t;
 typedef unsigned char      __u8;
 typedef unsigned short     __u16;
 typedef unsigned int       __u32;
@@ -88,18 +82,6 @@ ulong get_second(void);
 /* bootmap.c */
 void zipl_load(void);
 
-static inline void *memset(void *s, int c, size_t n)
-{
-    int i;
-    unsigned char *p = s;
-
-    for (i = 0; i < n; i++) {
-        p[i] = c;
-    }
-
-    return s;
-}
-
 static inline void fill_hex(char *out, unsigned char val)
 {
     const char hex[] = "0123456789abcdef";
@@ -169,17 +151,6 @@ static inline void sleep(unsigned int seconds)
     }
 }
 
-static inline void *memcpy(void *s1, const void *s2, size_t n)
-{
-    uint8_t *p1 = s1;
-    const uint8_t *p2 = s2;
-
-    while (n--) {
-        p1[n] = p2[n];
-    }
-    return s1;
-}
-
 static inline void IPL_assert(bool term, const char *message)
 {
     if (!term) {
diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
index a1639ba..aa1c862 100644
--- a/pc-bios/s390-ccw/sclp.c
+++ b/pc-bios/s390-ccw/sclp.c
@@ -8,6 +8,7 @@
  * directory.
  */
 
+#include "libc.h"
 #include "s390-ccw.h"
 #include "sclp.h"
 
@@ -59,13 +60,6 @@ static int _strlen(const char *str)
     return i;
 }
 
-static void _memcpy(char *dest, const char *src, int len)
-{
-    int i;
-    for (i = 0; i < len; i++)
-        dest[i] = src[i];
-}
-
 void sclp_print(const char *str)
 {
     int len = _strlen(str);
@@ -76,7 +70,7 @@ void sclp_print(const char *str)
     sccb->ebh.length = sizeof(EventBufferHeader) + len;
     sccb->ebh.type = SCLP_EVENT_ASCII_CONSOLE_DATA;
     sccb->ebh.flags = 0;
-    _memcpy(sccb->data, str, len);
+    memcpy(sccb->data, str, len);
 
     sclp_service_call(SCLP_CMD_WRITE_EVENT_DATA, sccb);
 }
diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scsi.c
index f61ecf0..c92f5d3 100644
--- a/pc-bios/s390-ccw/virtio-scsi.c
+++ b/pc-bios/s390-ccw/virtio-scsi.c
@@ -9,6 +9,7 @@
  * directory.
  */
 
+#include "libc.h"
 #include "s390-ccw.h"
 #include "virtio.h"
 #include "scsi.h"
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index 6ee93d5..8768331 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -8,6 +8,7 @@
  * directory.
  */
 
+#include "libc.h"
 #include "s390-ccw.h"
 #include "virtio.h"
 #include "virtio-scsi.h"
-- 
1.8.3.1
