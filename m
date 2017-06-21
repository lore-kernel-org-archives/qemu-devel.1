Received: from eggs.gnu.org ([2001:4830:134:3::10]:33933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNVhL-0006We-8p
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:48:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNVhK-0002P4-D4
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:48:51 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNVhK-0002Ox-9S
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 22:48:50 -0400
Received: by mail-qt0-x244.google.com with SMTP id o21so25678309qtb.1
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 19:48:50 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 20 Jun 2017 19:48:25 -0700
Message-Id: <20170621024831.26019-11-rth@twiddle.net>
In-Reply-To: <20170621024831.26019-1-rth@twiddle.net>
References: <20170621024831.26019-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 10/16] tcg: Avoid loops against variable bounds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net

Copy s->nb_globals or s->nb_temps to a local variable for the purposes
of iteration.  This should allow the compiler to use low-overhead
looping constructs on some hosts.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/tcg.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index e78140b..c228f1e 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -943,23 +943,16 @@ void tcg_gen_callN(TCGContext *s, void *func, TCGArg ret,
 
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
@@ -2050,9 +2043,9 @@ static void temp_save(TCGContext *s, TCGTemp *ts, TCGRegSet allocated_regs)
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
@@ -2062,9 +2055,9 @@ static void save_globals(TCGContext *s, TCGRegSet allocated_regs)
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
2.9.4
