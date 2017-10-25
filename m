Received: from eggs.gnu.org ([2001:4830:134:3::10]:45485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6P-0008CK-Rr
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6L-00081i-T1
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:35:57 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:52546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7I6L-0007za-N1
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:35:53 -0400
Received: by mail-wr0-x241.google.com with SMTP id k62so23306625wrc.9
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 02:35:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 11:34:54 +0200
Message-Id: <20171025093535.10175-11-richard.henderson@linaro.org>
In-Reply-To: <20171025093535.10175-1-richard.henderson@linaro.org>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/51] tcg: Avoid loops against variable bounds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Copy s->nb_globals or s->nb_temps to a local variable for the purposes
of iteration.  This should allow the compiler to use low-overhead
looping constructs on some hosts.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/tcg.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index d08e34a9d8..840e65c0d4 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1159,23 +1159,16 @@ void tcg_gen_callN(TCGContext *s, void *func, TCGArg ret,
 
 static void tcg_reg_alloc_start(TCGContext *s)
 {
-    int i;
+    int i, n;
     TCGTemp *ts;
-    for(i = 0; i < s->nb_globals; i++) {
+
+    for (i = 0, n = s->nb_globals; i < n; i++) {
         ts = &s->temps[i];
-        if (ts->fixed_reg) {
-            ts->val_type = TEMP_VAL_REG;
-        } else {
-            ts->val_type = TEMP_VAL_MEM;
-        }
+        ts->val_type = (ts->fixed_reg ? TEMP_VAL_REG : TEMP_VAL_MEM);
     }
-    for(i = s->nb_globals; i < s->nb_temps; i++) {
+    for (n = s->nb_temps; i < n; i++) {
         ts = &s->temps[i];
-        if (ts->temp_local) {
-            ts->val_type = TEMP_VAL_MEM;
-        } else {
-            ts->val_type = TEMP_VAL_DEAD;
-        }
+        ts->val_type = (ts->temp_local ? TEMP_VAL_MEM : TEMP_VAL_DEAD);
         ts->mem_allocated = 0;
         ts->fixed_reg = 0;
     }
@@ -2277,9 +2270,9 @@ static void temp_save(TCGContext *s, TCGTemp *ts, TCGRegSet allocated_regs)
    temporary registers needs to be allocated to store a constant. */
 static void save_globals(TCGContext *s, TCGRegSet allocated_regs)
 {
-    int i;
+    int i, n;
 
-    for (i = 0; i < s->nb_globals; i++) {
+    for (i = 0, n = s->nb_globals; i < n; i++) {
         temp_save(s, &s->temps[i], allocated_regs);
     }
 }
@@ -2289,9 +2282,9 @@ static void save_globals(TCGContext *s, TCGRegSet allocated_regs)
    temporary registers needs to be allocated to store a constant. */
 static void sync_globals(TCGContext *s, TCGRegSet allocated_regs)
 {
-    int i;
+    int i, n;
 
-    for (i = 0; i < s->nb_globals; i++) {
+    for (i = 0, n = s->nb_globals; i < n; i++) {
         TCGTemp *ts = &s->temps[i];
         tcg_debug_assert(ts->val_type != TEMP_VAL_REG
                          || ts->fixed_reg
-- 
2.13.6
