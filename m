Received: from eggs.gnu.org ([2001:4830:134:3::10]:58843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d5XyX-0001Hf-Ki
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d5XyU-0001nv-IV
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:36:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39967
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d5XyU-0001nW-Cl
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:36:18 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v42DYJEI045192
	for <qemu-devel@nongnu.org>; Tue, 2 May 2017 09:36:17 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a6hy1urue-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 09:36:17 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 2 May 2017 14:36:15 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue,  2 May 2017 15:35:57 +0200
In-Reply-To: <20170502133604.17735-1-cornelia.huck@de.ibm.com>
References: <20170502133604.17735-1-cornelia.huck@de.ibm.com>
Message-Id: <20170502133604.17735-6-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 05/12] pc-bios/s390-ccw: Make ebcdic/ascii
 conversion public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, "Eugene (jno) Dvurechenski" <jno@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: "Eugene (jno) Dvurechenski" <jno@linux.vnet.ibm.com>

Make the ebcdic_to_ascii function public to the rest of the
"bios" code, as the volume label is no more the single thing
to be converted.

Signed-off-by: Eugene (jno) Dvurechenski <jno@linux.vnet.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 pc-bios/s390-ccw/bootmap.h  | 22 ----------------------
 pc-bios/s390-ccw/main.c     | 11 +++++++++++
 pc-bios/s390-ccw/s390-ccw.h | 13 +++++++++++++
 3 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
index bea168714b..9073de2238 100644
--- a/pc-bios/s390-ccw/bootmap.h
+++ b/pc-bios/s390-ccw/bootmap.h
@@ -264,28 +264,6 @@ typedef enum {
 
 /* utility code below */
 
-static const unsigned char ebc2asc[256] =
-      /* 0123456789abcdef0123456789abcdef */
-        "................................" /* 1F */
-        "................................" /* 3F */
-        " ...........<(+|&.........!$*);." /* 5F first.chr.here.is.real.space */
-        "-/.........,%_>?.........`:#@'=\""/* 7F */
-        ".abcdefghi.......jklmnopqr......" /* 9F */
-        "..stuvwxyz......................" /* BF */
-        ".ABCDEFGHI.......JKLMNOPQR......" /* DF */
-        "..STUVWXYZ......0123456789......";/* FF */
-
-static inline void ebcdic_to_ascii(const char *src,
-                                   char *dst,
-                                   unsigned int size)
-{
-    unsigned int i;
-    for (i = 0; i < size; i++) {
-        unsigned c = src[i];
-        dst[i] = ebc2asc[c];
-    }
-}
-
 static inline void print_volser(const void *volser)
 {
     char ascii[8];
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 0946766d86..393d732353 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -15,6 +15,17 @@ char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
 static SubChannelId blk_schid = { .one = 1 };
 IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
 
+const unsigned char ebc2asc[256] =
+      /* 0123456789abcdef0123456789abcdef */
+        "................................" /* 1F */
+        "................................" /* 3F */
+        " ...........<(+|&.........!$*);." /* 5F first.chr.here.is.real.space */
+        "-/.........,%_>?.........`:#@'=\""/* 7F */
+        ".abcdefghi.......jklmnopqr......" /* 9F */
+        "..stuvwxyz......................" /* BF */
+        ".ABCDEFGHI.......JKLMNOPQR......" /* DF */
+        "..STUVWXYZ......0123456789......";/* FF */
+
 /*
  * Priniciples of Operations (SA22-7832-09) chapter 17 requires that
  * a subsystem-identification is at 184-187 and bytes 188-191 are zero
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index ded67bcbc6..4e0aab27d3 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -189,4 +189,17 @@ static inline void IPL_check(bool term, const char *message)
     }
 }
 
+extern const unsigned char ebc2asc[256];
+static inline void ebcdic_to_ascii(const char *src,
+                                   char *dst,
+                                   unsigned int size)
+{
+    unsigned int i;
+
+    for (i = 0; i < size; i++) {
+        unsigned c = src[i];
+        dst[i] = ebc2asc[c];
+    }
+}
+
 #endif /* S390_CCW_H */
-- 
2.11.0
