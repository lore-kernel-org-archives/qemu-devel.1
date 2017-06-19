Received: from eggs.gnu.org ([2001:4830:134:3::10]:33318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN1GC-0008LL-Fb
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN1GB-0002Ct-KN
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:48 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:36371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dN1GB-0002CZ-Fo
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 14:18:47 -0400
Received: by mail-pg0-x241.google.com with SMTP id e187so8690768pgc.3
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 11:18:47 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 19 Jun 2017 11:18:31 -0700
Message-Id: <20170619181839.25249-5-rth@twiddle.net>
In-Reply-To: <20170619181839.25249-1-rth@twiddle.net>
References: <20170619181839.25249-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 04/12] tcg/aarch64: Use ADR in tcg_out_movi
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

The new placement of the TB means that we can use one insn
to load the return value for exit_tb returning the TB pointer.

Tested-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/aarch64/tcg-target.inc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 5f18545..1fa3bcc 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -616,7 +616,12 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
     /* Look for host pointer values within 4G of the PC.  This happens
        often when loading pointers to QEMU's own data structures.  */
     if (type == TCG_TYPE_I64) {
-        tcg_target_long disp = (value >> 12) - ((intptr_t)s->code_ptr >> 12);
+        tcg_target_long disp = value - (intptr_t)s->code_ptr;
+        if (disp == sextract64(disp, 0, 21)) {
+            tcg_out_insn(s, 3406, ADR, rd, disp);
+            return;
+        }
+        disp = (value >> 12) - ((intptr_t)s->code_ptr >> 12);
         if (disp == sextract64(disp, 0, 21)) {
             tcg_out_insn(s, 3406, ADRP, rd, disp);
             if (value & 0xfff) {
-- 
2.9.4
