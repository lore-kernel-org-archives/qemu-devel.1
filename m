Received: from eggs.gnu.org ([2001:4830:134:3::10]:48585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1fb814-0000BK-Fr
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:26:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1fb811-0001Qm-Ib
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:26:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50400
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1fb811-0001Pi-C8
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:25:59 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w65HNfdr173718
	for <qemu-devel@nongnu.org>; Thu, 5 Jul 2018 13:25:58 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2k1pupj495-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 13:25:58 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Thu, 5 Jul 2018 13:25:58 -0400
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Thu,  5 Jul 2018 13:25:37 -0400
In-Reply-To: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
Message-Id: <1530811543-6881-10-git-send-email-jjherne@linux.ibm.com>
Subject: [Qemu-devel] [RFC 09/15] s390-bios: ptr2u32 and u32toptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com

From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>

Introduce inline functions to convert between pointers and unsigned 32-bit
ints. These are used to hide the ugliness required to  avoid compiler
warnings.

Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 pc-bios/s390-ccw/libc.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/pc-bios/s390-ccw/libc.h b/pc-bios/s390-ccw/libc.h
index 818517f..e198f0b 100644
--- a/pc-bios/s390-ccw/libc.h
+++ b/pc-bios/s390-ccw/libc.h
@@ -19,6 +19,18 @@ typedef unsigned short     uint16_t;
 typedef unsigned int       uint32_t;
 typedef unsigned long long uint64_t;
 
+/* Avoids compiler warnings when casting a pointer to a u32 */
+static inline uint32_t ptr2u32(void *ptr)
+{
+    return (uint32_t)(uint64_t)ptr;
+}
+
+/* Avoids compiler warnings when casting a u32 to a pointer */
+static inline void *u32toptr(uint32_t n)
+{
+    return (void *)(uint64_t)n;
+}
+
 static inline void *memset(void *s, int c, size_t n)
 {
     size_t i;
-- 
2.7.4
