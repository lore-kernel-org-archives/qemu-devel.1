Received: from eggs.gnu.org ([2001:4830:134:3::10]:41145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dIxLK-00061E-OH
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:19:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dIxLH-0003Vx-Dt
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:19:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34758
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dIxLH-0003Sa-8m
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:19:15 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v58DJ7U1073742
	for <qemu-devel@nongnu.org>; Thu, 8 Jun 2017 09:19:12 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ay72frxp9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 09:19:12 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 8 Jun 2017 14:19:09 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu,  8 Jun 2017 15:18:57 +0200
In-Reply-To: <1496927940-13301-1-git-send-email-borntraeger@de.ibm.com>
References: <1496927940-13301-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1496927940-13301-3-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 2/5] s390x/css: fence off MIDA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cornelia.huck@de.ibm.com>, Stefan Hajnoczi <stefanha@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

MIDA (modified indirect data addressing) is an optional facility, and
we (currently) don't support it. Let's post an operand exception if
the guest tries to set it in the orb and a channel program check
if it is set in a ccw, as specified in the Principles of Operation.

Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/css.c            | 5 +++++
 include/hw/s390x/ioinst.h | 1 +
 target/s390x/ioinst.c     | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index cc76c53..599805d 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -433,6 +433,11 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
         return -EINVAL;
     }
 
+    /* We don't support MIDA. */
+    if (ccw.flags & CCW_FLAG_MIDA) {
+        return -EINVAL;
+    }
+
     if (ccw.flags & CCW_FLAG_SUSPEND) {
         return suspend_allowed ? -EINPROGRESS : -EINVAL;
     }
diff --git a/include/hw/s390x/ioinst.h b/include/hw/s390x/ioinst.h
index c559f53..92d1565 100644
--- a/include/hw/s390x/ioinst.h
+++ b/include/hw/s390x/ioinst.h
@@ -182,6 +182,7 @@ typedef struct CCW1 {
 #define CCW_FLAG_PCI             0x08
 #define CCW_FLAG_IDA             0x04
 #define CCW_FLAG_SUSPEND         0x02
+#define CCW_FLAG_MIDA            0x01
 
 #define CCW_CMD_NOOP             0x03
 #define CCW_CMD_BASIC_SENSE      0x04
diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index 62a7771..d5e6b80 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -201,6 +201,10 @@ static int ioinst_orb_valid(ORB *orb)
         (orb->ctrl1 & ORB_CTRL1_MASK_INVALID)) {
         return 0;
     }
+    /* We don't support MIDA. */
+    if (orb->ctrl1 & ORB_CTRL1_MASK_MIDAW) {
+        return 0;
+    }
     if ((orb->cpa & HIGH_ORDER_BIT) != 0) {
         return 0;
     }
-- 
2.7.4
