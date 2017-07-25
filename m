Received: from eggs.gnu.org ([2001:4830:134:3::10]:34524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1da8ZY-0002ZZ-AU
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 18:45:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1da8ZV-0003Yn-9e
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 18:45:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1da8ZU-0003XL-WB
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 18:44:57 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6PMiqXA033562
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 18:44:54 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bxavfubnq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 18:44:54 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 25 Jul 2017 23:44:51 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 26 Jul 2017 00:44:42 +0200
In-Reply-To: <20170725224442.13383-1-pasic@linux.vnet.ibm.com>
References: <20170725224442.13383-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170725224442.13383-3-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 2/2] s390x/css: fix bits must be zero check for
 TIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

According to the PoP bit positions 0-3 and 8-32 of the format-1 CCW must
contain zeros.  Bits 0-3 are already covered by cmd_code validity
checking, and bit 32 is covered by the CCW address checking.

Bits 8-31 correspond to CCW1.flags and CCW1.count.  Currently we only
check for the absence of certain flags.  Let's fix this.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 hw/s390x/css.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index d17e21b7af..1f04ce4a1b 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -884,7 +884,8 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
             ret = -EINVAL;
             break;
         }
-        if (ccw.flags & (CCW_FLAG_CC | CCW_FLAG_DC)) {
+        if (ccw.flags || ccw.count) {
+            /* We have already sanitized these if fmt 0. */
             ret = -EINVAL;
             break;
         }
-- 
2.11.2
