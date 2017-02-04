Received: from eggs.gnu.org ([2001:4830:134:3::10]:42202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cZpv9-0003nq-TL
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 21:17:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cZpv6-0000Bq-OY
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 21:17:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57282
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cZpv6-0000BW-Jt
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 21:17:44 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1428avh012132
	for <qemu-devel@nongnu.org>; Fri, 3 Feb 2017 21:17:44 -0500
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28cxs44rgm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 21:17:43 -0500
Received: from localhost
	by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Sat, 4 Feb 2017 00:17:41 -0200
Received: from d24relay04.br.ibm.com (d24relay04.br.ibm.com [9.18.232.146])
	by d24dlp02.br.ibm.com (Postfix) with ESMTP id DA6EC1DC0054
	for <qemu-devel@nongnu.org>; Fri,  3 Feb 2017 21:17:40 -0500 (EST)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
	by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v142Hduf12648682
	for <qemu-devel@nongnu.org>; Sat, 4 Feb 2017 00:17:39 -0200
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
	by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v142HdCH012024
	for <qemu-devel@nongnu.org>; Sat, 4 Feb 2017 00:17:39 -0200
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Sat,  4 Feb 2017 00:17:18 -0200
In-Reply-To: <1486174642-14883-1-git-send-email-joserz@linux.vnet.ibm.com>
References: <1486174642-14883-1-git-send-email-joserz@linux.vnet.ibm.com>
Message-Id: <1486174642-14883-4-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH Risu 3/7] risu_ppc64le: implement sign extend
 for small neg constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nikunj@linux.vnet.ibm.com

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 risugen_ppc64.pm | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/risugen_ppc64.pm b/risugen_ppc64.pm
index 40f3d4f..561c17b 100644
--- a/risugen_ppc64.pm
+++ b/risugen_ppc64.pm
@@ -75,6 +75,13 @@ sub write_add_ri($$$)
     insn32((0xe << 26) | ($rt << 21) | ($ra << 16) | ($imm & 0xffff));
 }
 
+sub write_sxt32($$)
+{
+    my ($ra, $rs) = @_;
+
+    insn32((0x1f << 26) | ($rs << 21) | ($ra << 16) | 0x7b4);
+}
+
 sub write_mov_ri($$)
 {
     # We always use a MOVW/MOVT pair, for simplicity.
@@ -87,10 +94,10 @@ sub write_mov_ri($$)
         write_mov_ri16($rd, $imm);
     }
 
-    #if ($is_aarch64 && $imm < 0) {
+    if ($imm < 0) {
         # sign extend to allow small negative imm constants
-    #    write_sxt32($rd, $rd);
-    #}
+        write_sxt32($rd, $rd);
+    }
 }
 
 sub write_random_ppc64_fpdata()
-- 
2.7.4
