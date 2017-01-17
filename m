Received: from eggs.gnu.org ([2001:4830:134:3::10]:58774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cTcmy-0000j0-TT
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 18:03:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cTcmx-0003IC-88
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 18:03:40 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:34832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cTcmx-0003Hs-3A
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 18:03:39 -0500
Received: by mail-pf0-x242.google.com with SMTP id f144so17069670pfa.2
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 15:03:38 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 17 Jan 2017 15:03:32 -0800
Message-Id: <20170117230332.16279-3-rth@twiddle.net>
In-Reply-To: <20170117230332.16279-1-rth@twiddle.net>
References: <20170117230332.16279-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 2/2] tcg/i386: Always use TZCNT when available
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

I think this is cleaner than sometimes using BSF.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/i386/tcg-target.inc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 6489b73..5918008 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -1143,10 +1143,14 @@ static void tcg_out_movcond64(TCGContext *s, TCGCond cond, TCGReg dest,
 static void tcg_out_ctz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
                         TCGArg arg2, bool const_a2)
 {
-    if (const_a2) {
-        tcg_debug_assert(have_bmi1);
-        tcg_debug_assert(arg2 == (rexw ? 64 : 32));
+    if (have_bmi1) {
         tcg_out_modrm(s, OPC_TZCNT + rexw, dest, arg1);
+        if (const_a2) {
+            tcg_debug_assert(arg2 == (rexw ? 64 : 32));
+        } else {
+            tcg_debug_assert(dest != arg2);
+            tcg_out_cmov(s, TCG_COND_LTU, rexw, dest, arg2);
+        }
     } else {
         tcg_debug_assert(dest != arg2);
         tcg_out_modrm(s, OPC_BSF + rexw, dest, arg1);
-- 
2.9.3
