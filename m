Received: from eggs.gnu.org ([2001:4830:134:3::10]:36739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcCq-00019z-EM
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcCp-0003jO-19
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:20 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:39938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fNcCo-0003i4-Q1
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:18 -0400
Received: by mail-wm0-x235.google.com with SMTP id x2-v6so31856289wmh.5
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 03:50:18 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 29 May 2018 12:49:35 +0200
Message-Id: <20180529105011.1914-3-edgar.iglesias@gmail.com>
In-Reply-To: <20180529105011.1914-1-edgar.iglesias@gmail.com>
References: <20180529105011.1914-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 02/38] target-microblaze: dec_store: Use bool
 instead of unsigned int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Use bool instead of unsigned int to represent flags.
Also, use extract32 instead of open coding the bit extract.

No functional change.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index a8a5eaebec..413e683aec 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1027,14 +1027,15 @@ static void dec_store(DisasContext *dc)
 {
     TCGv t, *addr, swx_addr;
     TCGLabel *swx_skip = NULL;
-    unsigned int size, rev = 0, ex = 0;
+    unsigned int size;
+    bool rev = false, ex = false;
     TCGMemOp mop;
 
     mop = dc->opcode & 3;
     size = 1 << mop;
     if (!dc->type_b) {
-        rev = (dc->ir >> 9) & 1;
-        ex = (dc->ir >> 10) & 1;
+        rev = extract32(dc->ir, 9, 1);
+        ex = extract32(dc->ir, 10, 1);
     }
     mop |= MO_TE;
     if (rev) {
-- 
2.14.1
