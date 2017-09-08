Received: from eggs.gnu.org ([2001:4830:134:3::10]:41472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <j.pelczar@samsung.com>) id 1dqH3J-0000L6-0P
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:02:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <j.pelczar@samsung.com>) id 1dqH3E-0007CO-29
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:02:25 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <j.pelczar@samsung.com>)
	id 1dqH3D-0007AV-Qz
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:02:19 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
	20170908110213euoutp020e21e67643daf0809622c276e073806a~iXfVaFarQ1379013790euoutp02S
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 11:02:13 +0000 (GMT)
Received: from eusmges5.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20170908110213eucas1p15f11ee99d4d032b88294fa57198eb348~iXfUwHfTJ3259532595eucas1p1Q
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 11:02:13 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20170908110212eucas1p27c5eecf44c5501d23b322d3679a4f12d~iXfUDRbUM2183721837eucas1p2F
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 11:02:12 +0000 (GMT)
Received: from AMDN1843 ([106.120.52.68]) by eusync4.samsung.com (Oracle
	Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
	with ESMTPA id <0OVY00J6NJZOUG50@eusync4.samsung.com> for
	qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:02:12 +0100 (BST)
From: Jaroslaw Pelczar <j.pelczar@samsung.com>
Date: Fri, 08 Sep 2017 13:02:11 +0200
Message-id: <001801d32891$ec40b930$c4c22b90$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset="us-ascii"
Content-transfer-encoding: 7bit
Content-language: pl
References: <CGME20170908110212eucas1p27c5eecf44c5501d23b322d3679a4f12d@eucas1p2.samsung.com>
Subject: [Qemu-devel] [PATCH 1/1] AArch64: Fix single stepping of ERET
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Previously when single stepping through ERET instruction via GDB
would result in debugger entering the "next" PC after ERET instruction.
When debugging in kernel mode, this will also cause unintended behavior,
because debugger will try to access memory from EL0 point of view.

Signed-off-by: Jaroslaw Pelczar <j.pelczar@samsung.com>
---
 target/arm/translate-a64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 9017e30510..1bc12d93ca 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11348,6 +11348,7 @@ static void aarch64_tr_tb_stop(DisasContextBase
*dcbase, CPUState *cpu)
         default:
             gen_a64_set_pc_im(dc->pc);
             /* fall through */
+        case DISAS_EXIT:
         case DISAS_JUMP:
             if (dc->base.singlestep_enabled) {
                 gen_exception_internal(EXCP_DEBUG);
-- 
2.14.1
