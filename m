Received: from eggs.gnu.org ([2001:4830:134:3::10]:58969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eJQRw-0003Wb-BS
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 15:56:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eJQRs-0003Vf-DM
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 15:56:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48998
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eJQRs-0003UK-7W
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 15:56:16 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vARKsIId043122
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 15:56:13 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2egsng191f-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 15:56:13 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Mon, 27 Nov 2017 15:56:12 -0500
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Mon, 27 Nov 2017 15:55:32 -0500
In-Reply-To: <1511816136-30068-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1511816136-30068-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1511816136-30068-2-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 1/5] s390-ccw: update libc.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

Moved:
  memcmp from bootmap.h to libc.h (renamed from _memcmp)
  strlen from sclp.c to libc.h (renamed from _strlen)

Added C standard functions:
  isdigit
  atoi

Added non-C standard function:
  itostr

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: frankja@linux.vnet.ibm.com
---
 pc-bios/s390-ccw/bootmap.c |  4 +-
 pc-bios/s390-ccw/bootmap.h | 16 +-------
 pc-bios/s390-ccw/libc.h    | 94 ++++++++++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/main.c    | 17 +--------
 pc-bios/s390-ccw/sclp.c    | 10 +----
 5 files changed, 99 insertions(+), 42 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 67a6123..6f8e30f 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -512,7 +512,7 @@ static bool is_iso_bc_entry_compatible(IsoBcSection *s)
                     "Failed to read image sector 0");
 
     /* Checking bytes 8 - 32 for S390 Linux magic */
-    return !_memcmp(magic_sec + 8, linux_s390_magic, 24);
+    return !memcmp(magic_sec + 8, linux_s390_magic, 24);
 }
 
 /* Location of the current sector of the directory */
@@ -641,7 +641,7 @@ static uint32_t find_iso_bc(void)
         if (vd->type == VOL_DESC_TYPE_BOOT) {
             IsoVdElTorito *et = &vd->vd.boot;
 
-            if (!_memcmp(&et->el_torito[0], el_torito_magic, 32)) {
+            if (!memcmp(&et->el_torito[0], el_torito_magic, 32)) {
                 return bswap32(et->bc_offset);
             }
         }
diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
index cf99a4c..4980838 100644
--- a/pc-bios/s390-ccw/bootmap.h
+++ b/pc-bios/s390-ccw/bootmap.h
@@ -310,20 +310,6 @@ static inline bool magic_match(const void *data, const void *magic)
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
@@ -416,7 +402,7 @@ const uint8_t vol_desc_magic[] = "CD001";
 
 static inline bool is_iso_vd_valid(IsoVolDesc *vd)
 {
-    return !_memcmp(&vd->ident[0], vol_desc_magic, 5) &&
+    return !memcmp(&vd->ident[0], vol_desc_magic, 5) &&
            vd->version == 0x1 &&
            vd->type <= VOL_DESC_TYPE_PARTITION;
 }
diff --git a/pc-bios/s390-ccw/libc.h b/pc-bios/s390-ccw/libc.h
index 0142ea8..703c34d 100644
--- a/pc-bios/s390-ccw/libc.h
+++ b/pc-bios/s390-ccw/libc.h
@@ -42,4 +42,98 @@ static inline void *memcpy(void *s1, const void *s2, size_t n)
     return s1;
 }
 
+static inline int memcmp(const void *s1, const void *s2, size_t n)
+{
+    int i;
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
+/* atoi
+ *
+ * Given a string, convert it to an integer. Any
+ * non-numerical value will end the conversion.
+ *
+ * @str - the string to be converted
+ *
+ * @return - an integer converted from the string str
+ */
+static inline int atoi(const char *str)
+{
+    int i;
+    int val = 0;
+
+    for (i = 0; str[i]; i++) {
+        char c = str[i];
+        if (!isdigit(c)) {
+            break;
+        }
+        val *= 10;
+        val += c - '0';
+    }
+
+    return val;
+}
+
+/* itostr
+ *
+ * Given an integer, convert it to a string. The string must be allocated
+ * beforehand. The resulting string will be null terminated and returned.
+ *
+ * @str - the integer to be converted
+ * @num - a pointer to a string to store the conversion
+ *
+ * @return - the string of the converted integer
+ */
+static inline char *itostr(int num, char *str)
+{
+    int i;
+    int len = 0;
+    long tens = 1;
+
+    /* Handle 0 */
+    if (num == 0) {
+        str[0] = '0';
+        str[1] = '\0';
+        return str;
+    }
+
+    /* Count number of digits */
+    while (num / tens != 0) {
+        tens *= 10;
+        len++;
+    }
+
+    /* Convert int -> string */
+    for (i = 0; i < len; i++) {
+        tens /= 10;
+        str[i] = num / tens % 10 + '0';
+    }
+
+    str[i] = '\0';
+
+    return str;
+}
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
