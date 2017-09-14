Received: from eggs.gnu.org ([2001:4830:134:3::10]:46413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJX-00084g-PU
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJW-0007vm-Ib
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:35 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dsYJW-0007iP-Bb
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 13:52:34 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dsYJV-0005sV-9U
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 18:52:33 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2017 18:52:48 +0100
Message-Id: <1505411573-27848-14-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1505411573-27848-1-git-send-email-peter.maydell@linaro.org>
References: <1505411573-27848-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 13/18] AArch64: Fix single stepping of ERET
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

From: Jaroslaw Pelczar <j.pelczar@samsung.com>

Previously when single stepping through ERET instruction via GDB
would result in debugger entering the "next" PC after ERET instruction.
When debugging in kernel mode, this will also cause unintended behavior,
because debugger will try to access memory from EL0 point of view.

Signed-off-by: Jaroslaw Pelczar <j.pelczar@samsung.com>
Message-id: 001c01d32895$483027f0$d89077d0$@samsung.com
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 9017e30..1bc12d9 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11348,6 +11348,7 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         default:
             gen_a64_set_pc_im(dc->pc);
             /* fall through */
+        case DISAS_EXIT:
         case DISAS_JUMP:
             if (dc->base.singlestep_enabled) {
                 gen_exception_internal(EXCP_DEBUG);
-- 
2.7.4
