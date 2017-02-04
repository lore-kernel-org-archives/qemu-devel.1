Received: from eggs.gnu.org ([2001:4830:134:3::10]:42212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cZpvA-0003ns-HP
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 21:17:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cZpv7-0000CI-DC
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 21:17:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cZpv7-0000Bb-2z
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 21:17:45 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1428bvg015614
	for <qemu-devel@nongnu.org>; Fri, 3 Feb 2017 21:17:44 -0500
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28cuc6wdnm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 21:17:43 -0500
Received: from localhost
	by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Sat, 4 Feb 2017 00:17:40 -0200
Received: from d24relay04.br.ibm.com (d24relay04.br.ibm.com [9.18.232.146])
	by d24dlp02.br.ibm.com (Postfix) with ESMTP id 480E71DC0054
	for <qemu-devel@nongnu.org>; Fri,  3 Feb 2017 21:17:38 -0500 (EST)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
	by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v142Hb9J26804280
	for <qemu-devel@nongnu.org>; Sat, 4 Feb 2017 00:17:37 -0200
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
	by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v142HbYq012010
	for <qemu-devel@nongnu.org>; Sat, 4 Feb 2017 00:17:37 -0200
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Sat,  4 Feb 2017 00:17:17 -0200
In-Reply-To: <1486174642-14883-1-git-send-email-joserz@linux.vnet.ibm.com>
References: <1486174642-14883-1-git-send-email-joserz@linux.vnet.ibm.com>
Message-Id: <1486174642-14883-3-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH Risu 2/7] risu_ppc64le: fix 32-bit mov immediate
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

Two instructions are necessary but the high value should be written
first, shifted 16 bit left, and then or'ed the lower value. This commit
fixes the problem.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 risugen_ppc64.pm | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/risugen_ppc64.pm b/risugen_ppc64.pm
index ca052de..40f3d4f 100644
--- a/risugen_ppc64.pm
+++ b/risugen_ppc64.pm
@@ -61,8 +61,8 @@ sub write_mov_ri32($$)
 {
     my ($rd, $imm) = @_;
 
-    # li rd,immediate@h
-    write_mov_ri16($rd, ($imm >> 16) & 0xffff);
+    # lis rd,immediate@h
+    insn32(0xf << 26 | $rd << 21 | ($imm >> 16));
     # ori rd,rd,immediate@l
     insn32((0x18 << 26) | ($rd << 21) | ($rd << 16) | ($imm & 0xffff));
 }
-- 
2.7.4
