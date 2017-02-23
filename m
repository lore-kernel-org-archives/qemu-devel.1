Received: from eggs.gnu.org ([2001:4830:134:3::10]:33926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cgsCj-0003Id-SX
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 07:09:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cgsCe-0000EZ-Ru
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 07:09:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cgsCe-0000EP-JY
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 07:08:56 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1NC8rR6075778
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 07:08:55 -0500
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28srg4r5ws-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 07:08:54 -0500
Received: from localhost
	by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 23 Feb 2017 12:08:33 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Thu, 23 Feb 2017 13:08:27 +0100
In-Reply-To: <20170223120827.8942-1-cornelia.huck@de.ibm.com>
References: <20170223120827.8942-1-cornelia.huck@de.ibm.com>
Message-Id: <20170223120827.8942-2-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] s390x/css: handle format-0 TIC CCW
 correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

For TIC CCW, bit positions 8-32 of the format-1 CCW must contain zeros;
otherwise, a program-check condition is generated. For format-0 TIC CCWs,
bits 32-63 are ignored.

To convert TIC from format-0 CCW to format-1 CCW correctly, let's clear
bits 8-32 to guarantee compatibility.

Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/css.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 0f2580d644..e32b2a4d42 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -368,13 +368,16 @@ static CCW1 copy_ccw_from_guest(hwaddr addr, bool fmt1)
         ret.cda = be32_to_cpu(tmp1.cda);
     } else {
         cpu_physical_memory_read(addr, &tmp0, sizeof(tmp0));
-        ret.cmd_code = tmp0.cmd_code;
-        ret.flags = tmp0.flags;
-        ret.count = be16_to_cpu(tmp0.count);
-        ret.cda = be16_to_cpu(tmp0.cda1) | (tmp0.cda0 << 16);
-        if ((ret.cmd_code & 0x0f) == CCW_CMD_TIC) {
-            ret.cmd_code &= 0x0f;
+        if ((tmp0.cmd_code & 0x0f) == CCW_CMD_TIC) {
+            ret.cmd_code = CCW_CMD_TIC;
+            ret.flags = 0;
+            ret.count = 0;
+        } else {
+            ret.cmd_code = tmp0.cmd_code;
+            ret.flags = tmp0.flags;
+            ret.count = be16_to_cpu(tmp0.count);
         }
+        ret.cda = be16_to_cpu(tmp0.cda1) | (tmp0.cda0 << 16);
     }
     return ret;
 }
-- 
2.11.0
