Received: from eggs.gnu.org ([2001:4830:134:3::10]:53672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ee3IB-0003uN-4O
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 13:27:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1ee3I7-0006PM-V0
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 13:27:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35724
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1ee3I7-0006PE-PA
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 13:27:27 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0NIO12c055150
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 13:27:27 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fp7vny3ar-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 13:27:26 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Tue, 23 Jan 2018 11:27:25 -0700
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Tue, 23 Jan 2018 13:26:47 -0500
In-Reply-To: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1516732013-18272-5-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 04/10] s390-ccw: update libc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, thuth@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com

Moved:
  memcmp from bootmap.h to libc.h (renamed from _memcmp)
  strlen from sclp.c to libc.h (renamed from _strlen)

Added C standard functions:
  atoi
  isdigit

Added non C-standard function:
  itostr

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
---
 pc-bios/s390-ccw/Makefile  |   2 +-
 pc-bios/s390-ccw/bootmap.c |   4 +-
 pc-bios/s390-ccw/bootmap.h |  16 +------
 pc-bios/s390-ccw/libc.c    | 116 +++++++++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/libc.h    |  35 +++++++++++++-
 pc-bios/s390-ccw/main.c    |  17 +------
 pc-bios/s390-ccw/sclp.c    |  10 +---
 7 files changed, 156 insertions(+), 44 deletions(-)
 create mode 100644 pc-bios/s390-ccw/libc.c

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 6d0c2ee..9f7904f 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -9,7 +9,7 @@ $(call set-vpath, $(SRC_PATH)/pc-bios/s390-ccw)
 
 .PHONY : all clean build-all
 
-OBJECTS = start.o main.o bootmap.o sclp.o virtio.o virtio-scsi.o virtio-blkdev.o
+OBJECTS = start.o main.o bootmap.o sclp.o virtio.o virtio-scsi.o virtio-blkdev.o libc.o
 QEMU_CFLAGS := $(filter -W%, $(QEMU_CFLAGS))
 QEMU_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -msoft-float
 QEMU_CFLAGS += -march=z900 -fPIE -fno-strict-aliasing
diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index b01e0f6..0da4c7f 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -494,7 +494,7 @@ static bool is_iso_bc_entry_compatible(IsoBcSection *s)
                     "Failed to read image sector 0");
 
     /* Checking bytes 8 - 32 for S390 Linux magic */
-    return !_memcmp(magic_sec + 8, linux_s390_magic, 24);
+    return !memcmp(magic_sec + 8, linux_s390_magic, 24);
 }
 
 /* Location of the current sector of the directory */
@@ -623,7 +623,7 @@ static uint32_t find_iso_bc(void)
         if (vd->type == VOL_DESC_TYPE_BOOT) {
             IsoVdElTorito *et = &vd->vd.boot;
 
-            if (!_memcmp(&et->el_torito[0], el_torito_magic, 32)) {
+            if (!memcmp(&et->el_torito[0], el_torito_magic, 32)) {
                 return bswap32(et->bc_offset);
             }
         }
diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
index 460ec1a..a3a58f4 100644
--- a/pc-bios/s390-ccw/bootmap.h
+++ b/pc-bios/s390-ccw/bootmap.h
@@ -344,20 +344,6 @@ static inline bool magic_match(const void *data, const void *magic)
     return *((uint32_t *)data) == *((uint32_t *)magic);
 }
 
-static inline int _memcmp(const void *s1, const void *s2, size_t n)
-{
-    int i;
-    const uint8_t *p1 = s1, *p2 = s2;
-
-    for (i = 0; i < n; i++) {
-        if (p1[i] != p2[i]) {
-            return p1[i] > p2[i] ? 1 : -1;
-        }
-    }
-
-    return 0;
-}
-
 static inline uint32_t iso_733_to_u32(uint64_t x)
 {
     return (uint32_t)x;
@@ -450,7 +436,7 @@ const uint8_t vol_desc_magic[] = "CD001";
 
 static inline bool is_iso_vd_valid(IsoVolDesc *vd)
 {
-    return !_memcmp(&vd->ident[0], vol_desc_magic, 5) &&
+    return !memcmp(&vd->ident[0], vol_desc_magic, 5) &&
            vd->version == 0x1 &&
            vd->type <= VOL_DESC_TYPE_PARTITION;
 }
diff --git a/pc-bios/s390-ccw/libc.c b/pc-bios/s390-ccw/libc.c
new file mode 100644
index 0000000..fc8562a
--- /dev/null
+++ b/pc-bios/s390-ccw/libc.c
@@ -0,0 +1,116 @@
+/*
+ * libc-style definitions and functions
+ *
+ * Copyright 2018 IBM Corp.
+ * Author(s): Collin L. Walling <walling@linux.vnet.ibm.com>
+ *
+ * This code is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include "libc.h"
+#include "s390-ccw.h"
+
+/**
+ * atoi:
+ * @str: the string to be converted.
+ *
+ * Given a string @str, convert it to an integer. Leading whitespace is
+ * ignored. The first character (after any whitespace) is checked for the
+ * negative sign. Any other non-numerical value will terminate the
+ * conversion.
+ *
+ * Returns: an integer converted from the string @str.
+ */
+int atoi(const char *str)
+{
+    int val = 0;
+    int sign = 1;
+
+    if (!str || !str[0]) {
+        return 0;
+    }
+
+    while (*str == ' ') {
+        str++;
+    }
+
+    if (*str == '-') {
+        sign = -1;
+        str++;
+    }
+
+    while (*str) {
+        if (!isdigit(*str)) {
+            break;
+        }
+        val = val * 10 + *str - '0';
+        str++;
+    }
+
+    return val * sign;
+}
+
+/**
+ * itostr:
+ * @num: an integer (base 10) to be converted.
+ * @str: a pointer to a string to store the conversion.
+ * @len: the length of the passed string.
+ *
+ * Given an integer @num, convert it to a string. The string @str must be
+ * allocated beforehand. The resulting string will be null terminated and
+ * returned.
+ *
+ * Returns: the string @str of the converted integer @num; NULL if @str
+ * is NULL or if there is not enough space allocated.
+ */
+static char *_itostr(int num, char *str, size_t len)
+{
+    int num_idx = 0;
+    int tmp = num;
+    char sign = 0;
+
+    if (!str) {
+        return NULL;
+    }
+
+    /* Get index to ones place */
+    while ((tmp /= 10) != 0) {
+        num_idx++;
+    }
+
+    if (num < 0) {
+        num *= -1;
+        sign = 1;
+    }
+
+    /* Check if we have enough space for num, sign, and null */
+    if (len <= num_idx + sign + 1) {
+        return NULL;
+    }
+
+    str[num_idx + sign + 1] = '\0';
+
+    /* Convert int to string */
+    while (num_idx >= 0) {
+        str[num_idx + sign] = num % 10 + '0';
+        num /= 10;
+        num_idx--;
+    }
+
+    if (sign) {
+        str[0] = '-';
+    }
+
+    return str;
+}
+
+char *itostr(int num, char *str, size_t len)
+{
+    char *tmp = _itostr(num, str, len);
+    IPL_assert(str != NULL, "cannot convert NULL to int");
+    IPL_assert(tmp != NULL, "array too small for integer to string conversion");
+    return tmp;
+}
diff --git a/pc-bios/s390-ccw/libc.h b/pc-bios/s390-ccw/libc.h
index 0142ea8..982c374 100644
--- a/pc-bios/s390-ccw/libc.h
+++ b/pc-bios/s390-ccw/libc.h
@@ -1,6 +1,8 @@
 /*
  * libc-style definitions and functions
  *
+ * Copyright (c) 2013 Alexander Graf <agraf@suse.de>
+ *
  * This code is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
  * Free Software Foundation; either version 2 of the License, or (at your
@@ -33,7 +35,7 @@ static inline void *memcpy(void *s1, const void *s2, size_t n)
 {
     uint8_t *dest = s1;
     const uint8_t *src = s2;
-    int i;
+    size_t i;
 
     for (i = 0; i < n; i++) {
         dest[i] = src[i];
@@ -42,4 +44,35 @@ static inline void *memcpy(void *s1, const void *s2, size_t n)
     return s1;
 }
 
+static inline int memcmp(const void *s1, const void *s2, size_t n)
+{
+    size_t i;
+    const uint8_t *p1 = s1, *p2 = s2;
+
+    for (i = 0; i < n; i++) {
+        if (p1[i] != p2[i]) {
+            return p1[i] > p2[i] ? 1 : -1;
+        }
+    }
+
+    return 0;
+}
+
+static inline size_t strlen(const char *str)
+{
+    size_t i;
+    for (i = 0; *str; i++) {
+        str++;
+    }
+    return i;
+}
+
+static inline int isdigit(int c)
+{
+    return (c >= '0') && (c <= '9');
+}
+
+int atoi(const char *str);
+char *itostr(int num, char *str, size_t len);
+
 #endif
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 401e9db..a8ef120 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -40,22 +40,7 @@ void panic(const char *string)
 
 unsigned int get_loadparm_index(void)
 {
-    const char *lp = loadparm;
-    int i;
-    unsigned int idx = 0;
-
-    for (i = 0; i < 8; i++) {
-        char c = lp[i];
-
-        if (c < '0' || c > '9') {
-            break;
-        }
-
-        idx *= 10;
-        idx += c - '0';
-    }
-
-    return idx;
+    return atoi(loadparm);
 }
 
 static bool find_dev(Schib *schib, int dev_no)
diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
index b1fc8ff..486fce1 100644
--- a/pc-bios/s390-ccw/sclp.c
+++ b/pc-bios/s390-ccw/sclp.c
@@ -65,14 +65,6 @@ void sclp_setup(void)
     sclp_set_write_mask();
 }
 
-static int _strlen(const char *str)
-{
-    int i;
-    for (i = 0; *str; i++)
-        str++;
-    return i;
-}
-
 long write(int fd, const void *str, size_t len)
 {
     WriteEventData *sccb = (void *)_sccb;
@@ -95,7 +87,7 @@ long write(int fd, const void *str, size_t len)
 
 void sclp_print(const char *str)
 {
-    write(1, str, _strlen(str));
+    write(1, str, strlen(str));
 }
 
 void sclp_get_loadparm_ascii(char *loadparm)
-- 
2.7.4
