Received: from eggs.gnu.org ([209.51.188.92]:58961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMC-0008Fd-RD
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:08:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMA-0003jF-Ro
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:56 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:44167)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpbMA-0003TI-GV
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:54 -0500
Received: by mail-wr1-x42c.google.com with SMTP id z5so7630089wrt.11
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:07:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id n6sm2847250wmk.9.2019.02.01.08.07.28
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 01 Feb 2019 08:07:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 16:06:32 +0000
Message-Id: <20190201160653.13829-27-peter.maydell@linaro.org>
In-Reply-To: <20190201160653.13829-1-peter.maydell@linaro.org>
References: <20190201160653.13829-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 26/47] target/arm/translate-a64: Don't
 underdecode PRFM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The PRFM prefetch insn in the load/store with imm9 encodings
requires idx field 0b00; we were underdecoding this by
only checking !is_unpriv (which is equivalent to idx != 2).
Correctly UNDEF the unallocated encodings where idx == 0b01
and 0b11 as well as 0b10.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-id: 20190125182626.9221-3-peter.maydell@linaro.org
---
 target/arm/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e6df303e321..8e081758e03 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -2803,7 +2803,7 @@ static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
     } else {
         if (size == 3 && opc == 2) {
             /* PRFM - prefetch */
-            if (is_unpriv) {
+            if (idx != 0) {
                 unallocated_encoding(s);
                 return;
             }
-- 
2.20.1
