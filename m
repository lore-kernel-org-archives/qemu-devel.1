Received: from eggs.gnu.org ([2001:4830:134:3::10]:50367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sandipan@linux.vnet.ibm.com>) id 1et6Ip-0004Or-6g
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 01:42:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sandipan@linux.vnet.ibm.com>) id 1et6Il-000829-9Z
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 01:42:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38654
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sandipan@linux.vnet.ibm.com>)
	id 1et6Il-00081g-4S
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 01:42:19 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w266dgdj035588
	for <qemu-devel@nongnu.org>; Tue, 6 Mar 2018 01:42:18 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ghknjcgjf-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 01:42:17 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sandipan@linux.vnet.ibm.com>;
	Tue, 6 Mar 2018 06:42:16 -0000
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
Date: Tue,  6 Mar 2018 12:12:08 +0530
Message-Id: <20180306064210.26157-1-sandipan@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH risu 1/3] ppc64.risu: Add missing byte and
 dword loads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, joserz@linux.vnet.ibm.com
Cc: nikunj@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com, qemu-devel@nongnu.org

The patterns for the following instructions are added:
 * Load Byte and Zero (lbz)
 * Load Byte and Zero with Update (lbzu)
 * Load Byte and Zero Indexed (lbzx)
 * Load Byte and Zero with Update Indexed (lbzux)
 * Load Doubleword (ld)

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
---
 ppc64.risu | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/ppc64.risu b/ppc64.risu
index e2fd4f6..13b95ac 100644
--- a/ppc64.risu
+++ b/ppc64.risu
@@ -887,6 +887,31 @@ FTSQRT PPC64LE 111111 bf:3 0000000 frb:5 00101000000
 ISEL PPC64LE 011111 rt:5 ra:5 rb:5 bc:5 011110 \
 !constraints { $rt != 1 && $ra != 1 && $rb != 1 && $rt != 13 && $ra != 13 && $rb != 13; }
 
+# format:D book:I page:48 v:P1 lbz Load Byte & Zero
+LBZ PPC64LE 100010 rt:5 ra:5 imm:16 \
+!constraints { $rt != 1 && $ra != 1 && $rt != 13 && $ra != 13 && $ra != 0 && $ra != $rt && $imm <= 32752; } \
+!memory { reg_plus_imm($ra, $imm); }
+
+# format:D book:I page:48 v:P1 lbzu Load Byte & Zero with Update
+LBZU PPC64LE 100011 rt:5 ra:5 imm:16 \
+!constraints { $rt != 1 && $ra != 1 && $rt != 13 && $ra != 13 && $ra != 0 && $ra != $rt && $imm <= 32752; } \
+!memory { reg_plus_imm($ra, $imm); }
+
+# format:X book:I page:49 v:P1 lbzux Load Byte & Zero with Update Indexed
+LBZUX PPC64LE 011111 rt:5 ra:5 rb:5 00011101110 \
+!constraints { $rt != 1 && $ra != 1 && $rb != 1 && $rt != 13 && $ra != 13 && $rb != 13 && $ra != 0 && $ra != $rt && $ra != $rb && $rt != $rb; } \
+!memory { reg_plus_reg($ra, $rb); }
+
+# format:X book:I page:49 v:P1 lbzx Load Byte & Zero Indexed
+LBZX PPC64LE 011111 rt:5 ra:5 rb:5 00010101110 \
+!constraints { $rt != 1 && $ra != 1 && $rb != 1 && $rt != 13 && $ra != 13 && $rb != 13 && $ra != 0 && $ra != $rt && $ra != $rb && $rt != $rb; } \
+!memory { reg_plus_reg($ra, $rb); }
+
+# format:DS book:I page:53 PPC ld Load Dword
+LD PPC64LE 111010 rt:5 ra:5 imm:14 00 \
+!constraints { $rt != 1 && $ra != 1 && $rt != 13 && $ra != 13 && $ra != 0 && $ra != $rt && $imm <= 8176; } \
+!memory { reg_plus_imm($ra, $imm << 2); }
+
 # format:X book:I page:62 v2.06 ldbrx Load Dword Byte-Reverse Indexed
 LDBRX PPC64LE 011111 rt:5 ra:5 rb:5 10000101000 \
 !constraints { $rt != 1 && $ra != 1 && $rb != 1 && $rt != 13 && $ra != 13 && $rb != 13 && $ra != 0 && $ra != $rt && $ra != $rb && $rt != $rb; } \
-- 
2.14.3
