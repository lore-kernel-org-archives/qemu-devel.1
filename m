Received: from eggs.gnu.org ([209.51.188.92]:58832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbM8-0008Bo-VC
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbM7-0003fT-0v
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:52 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:43401)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpbM4-0003Vv-Vz
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:50 -0500
Received: by mail-wr1-x42d.google.com with SMTP id b4so751515wrq.10
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:07:34 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id n6sm2847250wmk.9.2019.02.01.08.07.32
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 01 Feb 2019 08:07:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 16:06:35 +0000
Message-Id: <20190201160653.13829-30-peter.maydell@linaro.org>
In-Reply-To: <20190201160653.13829-1-peter.maydell@linaro.org>
References: <20190201160653.13829-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 29/47] target/arm/translate-a64: Don't
 underdecode add/sub extended register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In the "add/subtract (extended register)" encoding group, the "opt"
field in bits [23:22] must be zero. Correctly UNDEF the unallocated
encodings where this field is not zero.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-id: 20190125182626.9221-6-peter.maydell@linaro.org
---
 target/arm/translate-a64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2cade64ed25..94907f0ae97 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -4201,6 +4201,7 @@ static void disas_add_sub_ext_reg(DisasContext *s, uint32_t insn)
     int imm3 = extract32(insn, 10, 3);
     int option = extract32(insn, 13, 3);
     int rm = extract32(insn, 16, 5);
+    int opt = extract32(insn, 22, 2);
     bool setflags = extract32(insn, 29, 1);
     bool sub_op = extract32(insn, 30, 1);
     bool sf = extract32(insn, 31, 1);
@@ -4209,7 +4210,7 @@ static void disas_add_sub_ext_reg(DisasContext *s, uint32_t insn)
     TCGv_i64 tcg_rd;
     TCGv_i64 tcg_result;
 
-    if (imm3 > 4) {
+    if (imm3 > 4 || opt != 0) {
         unallocated_encoding(s);
         return;
     }
-- 
2.20.1
