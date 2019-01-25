Received: from eggs.gnu.org ([209.51.188.92]:54577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gn6Bo-0004Ni-DZ
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:26:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gn6Bi-0002dP-A9
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:26:52 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gn6Bh-0002SR-V2
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:26:46 -0500
Received: by mail-wr1-x442.google.com with SMTP id l9so11272828wrt.13
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 10:26:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Jan 2019 18:26:21 +0000
Message-Id: <20190125182626.9221-3-peter.maydell@linaro.org>
In-Reply-To: <20190125182626.9221-1-peter.maydell@linaro.org>
References: <20190125182626.9221-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/7] target/arm/translate-a64: Don't
 underdecode PRFM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Laurent Desnogues <laurent.desnogues@gmail.com>

The PRFM prefetch insn in the load/store with imm9 encodings
requires idx field 0b00; we were underdecoding this by
only checking !is_unpriv (which is equivalent to idx != 2).
Correctly UNDEF the unallocated encodings where idx == 0b01
and 0b11 as well as 0b10.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
