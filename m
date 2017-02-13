Received: from eggs.gnu.org ([2001:4830:134:3::10]:45667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdO91-0005AL-NS
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdO90-0001fp-Nq
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:47 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cdO90-0001fK-Jl
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:46 -0500
Received: by mail-qt0-x241.google.com with SMTP id w20so14931603qtb.1
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 13:26:46 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 14 Feb 2017 08:25:33 +1100
Message-Id: <20170213212536.31871-22-rth@twiddle.net>
In-Reply-To: <20170213212536.31871-1-rth@twiddle.net>
References: <20170213212536.31871-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 21/24] target/openrisc: Optimize l.jal to next
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This allows the tcg optimizer to see, and fold, all of the
constants involved in a GOT base register load sequence.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/openrisc/translate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 66064e1..cda84b6 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -198,7 +198,11 @@ static void gen_jump(DisasContext *dc, int32_t n26, uint32_t reg, uint32_t op0)
         tcg_gen_movi_tl(jmp_pc, tmp_pc);
         break;
     case 0x01:     /* l.jal */
-        tcg_gen_movi_tl(cpu_R[9], (dc->pc + 8));
+        tcg_gen_movi_tl(cpu_R[9], dc->pc + 8);
+        /* Optimize jal being used to load the PC for PIC.  */
+        if (tmp_pc == dc->pc + 8) {
+            return;
+        }
         tcg_gen_movi_tl(jmp_pc, tmp_pc);
         break;
     case 0x03:     /* l.bnf */
-- 
2.9.3
