Received: from eggsout.gnu.org ([209.51.188.92]:54114 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gfuur-00067b-Vl
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 17:59:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gfuun-0003wP-Rq
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 17:59:41 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gfuul-0003s9-QE
	for qemu-devel@nongnu.org; Sat, 05 Jan 2019 17:59:36 -0500
Received: by mail-pg1-x541.google.com with SMTP id s198so19035297pgs.2
	for <qemu-devel@nongnu.org>; Sat, 05 Jan 2019 14:59:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun,  6 Jan 2019 08:59:21 +1000
Message-Id: <20190105225921.16576-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] target/alpha: Fix user-only initialization of
 fpcr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: 1701835@bugs.launchpad.net

When the representation of fpcr was changed, the user-only
initialization was not updated to match.  Oops.

Fixes: f3d3aad4a92
Fixes: https://bugs.launchpad.net/bugs/1701835
Reported-by: Bruno Haible <bruno@clisp.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/cpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index a953897fcc..1fd95d6c0f 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -205,9 +205,9 @@ static void alpha_cpu_initfn(Object *obj)
     env->lock_addr = -1;
 #if defined(CONFIG_USER_ONLY)
     env->flags = ENV_FLAG_PS_USER | ENV_FLAG_FEN;
-    cpu_alpha_store_fpcr(env, (FPCR_INVD | FPCR_DZED | FPCR_OVFD
-                               | FPCR_UNFD | FPCR_INED | FPCR_DNOD
-                               | FPCR_DYN_NORMAL));
+    cpu_alpha_store_fpcr(env, (uint64_t)(FPCR_INVD | FPCR_DZED | FPCR_OVFD
+                                         | FPCR_UNFD | FPCR_INED | FPCR_DNOD
+                                         | FPCR_DYN_NORMAL) << 32);
 #else
     env->flags = ENV_FLAG_PAL_MODE | ENV_FLAG_FEN;
 #endif
-- 
2.17.2
