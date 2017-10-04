Received: from eggs.gnu.org ([2001:4830:134:3::10]:37101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dzlo9-00026c-49
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:42:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dzlo5-0003It-UW
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:42:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dzlo5-0003Hn-Mf
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:41:57 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v94FeqwV037353
	for <qemu-devel@nongnu.org>; Wed, 4 Oct 2017 11:41:56 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dcyft4c8u-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 11:41:56 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 4 Oct 2017 16:41:54 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed,  4 Oct 2017 17:41:38 +0200
In-Reply-To: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
References: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
Message-Id: <20171004154144.88995-3-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 2/8] s390x/css: IO instr handler ending
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
flow control let us introduce a struct which tells the instruction
handler function how to end the instruction, in a more straight-forward
and less ambiguous way.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 include/hw/s390x/css.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 0653d3c9be..66916b6546 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -75,6 +75,18 @@ typedef struct CMBE {
     uint32_t reserved[7];
 } QEMU_PACKED CMBE;
 
+/* IO instructions conclude according this */
+typedef struct IOInstEnding {
+        /*
+         * General semantic of cc codes of IO instructions is (brief):
+         * 0 -- produced expected result
+         * 1 --  status conditions were present or produced alternate result
+         * 2 -- ineffective, because busy with previously initiated function
+         * 3 -- ineffective, not operational
+         */
+        int cc;
+} IOInstEnding;
+
 typedef struct SubchDev SubchDev;
 struct SubchDev {
     /* channel-subsystem related things: */
-- 
2.13.5
