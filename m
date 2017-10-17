Received: from eggs.gnu.org ([2001:4830:134:3::10]:55825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e4SVC-000738-Vc
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e4SV7-0004xg-2u
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:05:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1e4SV6-0004xF-Qp
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:05:45 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9HE5WdP039757
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 10:05:41 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dnk4w0r83-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 10:05:39 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 17 Oct 2017 15:05:00 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 17 Oct 2017 16:04:48 +0200
In-Reply-To: <20171017140453.51099-1-pasic@linux.vnet.ibm.com>
References: <20171017140453.51099-1-pasic@linux.vnet.ibm.com>
Message-Id: <20171017140453.51099-3-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 2/7] s390x/css: IO instr handler ending
 control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

CSS code needs to tell the IO instruction handlers located in how should
the emulated instruction be ended. Currently this is done by returning
generic (POSIX) error codes, and mapping them to outcomes like condition
codes. This makes bugs easy to create and hard to recognise.

As a preparation for moving a way form (mis)using generic error codes for
flow control let us introduce a type which tells the instruction
handler function how to end the instruction, in a more straight-forward
and less ambiguous way.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 include/hw/s390x/css.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 69b374730e..7e0dbd162f 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -99,6 +99,22 @@ typedef struct CcwDataStream {
     hwaddr cda;
 } CcwDataStream;
 
+/*
+ * IO instructions conclude according this. Currently we have only
+ * cc codes. Valid values are 0,1,2,3 and the generic semantic for
+ * IO instructions is described briefly. For more details consult the PoP.
+ */
+typedef enum IOInstEnding {
+    /* produced expected result */
+    IOINST_CC_EXPECTED = 0,
+    /* status conditions were present or produced alternate result */
+    IOINST_CC_STATUS_PRESENT = 1,
+    /* inst. ineffective because busy with previously initiated function */
+    IOINST_CC_BUSY = 2,
+    /* inst. ineffective because not operational */
+    IOINST_CC_NOT_OPERATIONAL = 3
+} IOInstEnding;
+
 typedef struct SubchDev SubchDev;
 struct SubchDev {
     /* channel-subsystem related things: */
-- 
2.13.5
