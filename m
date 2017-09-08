Received: from eggs.gnu.org ([2001:4830:134:3::10]:51516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <j.pelczar@samsung.com>) id 1dqHQW-00076T-IF
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:26:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <j.pelczar@samsung.com>) id 1dqHQS-00013N-1W
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:26:24 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <j.pelczar@samsung.com>)
	id 1dqHQR-000129-R6
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:26:19 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
	20170908112616euoutp025121cda0b9cc847654e9bf8ed1f4ab4d~iX0VTP3Z61996519965euoutp02I
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 11:26:16 +0000 (GMT)
Received: from eusmges4.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20170908112616eucas1p1537ccf55d4abe3396cf4559eb829baf5~iX0Ul-9dP2948829488eucas1p1g
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 11:26:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20170908112615eucas1p12372f91b57dad31cdcfad2d7b5683c7a~iX0TtG3Te3026230262eucas1p1c
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 11:26:15 +0000 (GMT)
Received: from AMDN1843 ([106.120.52.68]) by eusync3.samsung.com (Oracle
	Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
	with ESMTPA id <0OVY00JXFL3QR360@eusync3.samsung.com> for
	qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:26:15 +0100 (BST)
From: Jaroslaw Pelczar <j.pelczar@samsung.com>
Date: Fri, 08 Sep 2017 13:26:14 +0200
Message-id: <001c01d32895$483027f0$d89077d0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset="us-ascii"
Content-transfer-encoding: 7bit
Content-language: pl
References: <CGME20170908112615eucas1p12372f91b57dad31cdcfad2d7b5683c7a@eucas1p1.samsung.com>
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
