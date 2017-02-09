Received: from eggs.gnu.org ([2001:4830:134:3::10]:49302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cbhlL-0003KW-0f
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:59:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cbhlH-0002yQ-NT
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:59:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cbhlH-0002yI-Cq
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:59:19 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v195wT01127469
	for <qemu-devel@nongnu.org>; Thu, 9 Feb 2017 00:59:17 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28g0fkbs6q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 00:59:17 -0500
Received: from localhost
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 9 Feb 2017 11:29:14 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id 7F47CE0024
	for <qemu-devel@nongnu.org>; Thu,  9 Feb 2017 11:30:38 +0530 (IST)
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
	by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v195xBZn36765830
	for <qemu-devel@nongnu.org>; Thu, 9 Feb 2017 11:29:11 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
	by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v195x9Ub012428
	for <qemu-devel@nongnu.org>; Thu, 9 Feb 2017 11:29:10 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu,  9 Feb 2017 11:28:50 +0530
In-Reply-To: <1486619931-1086-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1486619931-1086-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1486619931-1086-3-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 2/3] risu_ppc64le: zero the xer register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, joserz@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com

Observed failures running with P9 mambo model, and figured out that the
xer wasn't initialized.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 risugen_ppc64.pm | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/risugen_ppc64.pm b/risugen_ppc64.pm
index 0532e3a..03f9317 100644
--- a/risugen_ppc64.pm
+++ b/risugen_ppc64.pm
@@ -168,6 +168,9 @@ sub clear_vr_registers()
     insn32(0x3ac10020);
     # li r23, 0
     write_mov_ri(23, 0);
+    # zero the xer register
+    # mtxer   r23
+    insn32(0x7ee103a6);
     # std r23, 0(r22)
     insn32(0xfaf60000);
 
-- 
2.7.4
