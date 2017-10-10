Received: from eggs.gnu.org ([2001:4830:134:3::10]:60438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1iqC-0002CO-79
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1iqB-0004M5-Cx
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:12 -0400
Received: from mail-pf0-x22b.google.com ([2607:f8b0:400e:c00::22b]:45292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e1iqB-0004LI-7d
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:11 -0400
Received: by mail-pf0-x22b.google.com with SMTP id d28so768015pfe.2
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 17:56:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  9 Oct 2017 17:55:42 -0700
Message-Id: <20171010005600.28735-6-richard.henderson@linaro.org>
In-Reply-To: <20171010005600.28735-1-richard.henderson@linaro.org>
References: <20171010005600.28735-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 05/23] cpu-exec: rename have_tb_lock to
 acquired_tb_lock in tb_find
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Reusing the have_tb_lock name, which is also defined in translate-all.c,
makes code reviewing unnecessarily harder.

Avoid potential confusion by renaming the local have_tb_lock variable
to something else.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index ff6866624a..32104b8d8c 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -372,7 +372,7 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
     TranslationBlock *tb;
     target_ulong cs_base, pc;
     uint32_t flags;
-    bool have_tb_lock = false;
+    bool acquired_tb_lock = false;
 
     /* we record a subset of the CPU state. It will
        always be the same before a given translated block
@@ -391,7 +391,7 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
              */
             mmap_lock();
             tb_lock();
-            have_tb_lock = true;
+            acquired_tb_lock = true;
 
             /* There's a chance that our desired tb has been translated while
              * taking the locks so we check again inside the lock.
@@ -419,15 +419,15 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
 #endif
     /* See if we can patch the calling TB. */
     if (last_tb && !qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) {
-        if (!have_tb_lock) {
+        if (!acquired_tb_lock) {
             tb_lock();
-            have_tb_lock = true;
+            acquired_tb_lock = true;
         }
         if (!tb->invalid) {
             tb_add_jump(last_tb, tb_exit, tb);
         }
     }
-    if (have_tb_lock) {
+    if (acquired_tb_lock) {
         tb_unlock();
     }
     return tb;
-- 
2.13.6
