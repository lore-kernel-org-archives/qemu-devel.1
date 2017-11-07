Received: from eggs.gnu.org ([2001:4830:134:3::10]:41041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eC77A-0001yR-0Y
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 11:52:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eC775-0005az-C2
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 11:52:40 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:44059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eC775-0005Z3-49
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 11:52:35 -0500
Received: by mail-wm0-x242.google.com with SMTP id n74so15071207wmi.1
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 08:52:34 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  7 Nov 2017 16:52:26 +0000
Message-Id: <20171107165226.22546-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] accel/tcg/translate-all: expand
 cpu_restore_state retaddr check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

We are still seeing signals during translation time when we walk over
a page protection boundary. This expands the check to ensure the
retaddr is inside the code generation buffer. The original suggestion
was to check versus tcg_ctx.code_gen_ptr but as we now segment the
translation buffer we have to settle for just a general check for
being inside.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
---
 accel/tcg/translate-all.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 34c5e28d07..eb255af402 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -357,16 +357,20 @@ bool cpu_restore_state(CPUState *cpu, uintptr_t retaddr)
     TranslationBlock *tb;
     bool r = false;
 
-    /* A retaddr of zero is invalid so we really shouldn't have ended
-     * up here. The target code has likely forgotten to check retaddr
-     * != 0 before attempting to restore state. We return early to
-     * avoid blowing up on a recursive tb_lock(). The target must have
-     * previously survived a failed cpu_restore_state because
-     * tb_find_pc(0) would have failed anyway. It still should be
-     * fixed though.
+    /* The retaddr has to be in the region of current code buffer. If
+     * it's not we will not be able to resolve it here. If it is zero
+     * the calling code has likely forgotten to check retaddr before
+     * calling here. If it is not in the translated code we could be
+     * faulting during translation itself.
+     *
+     * Either way we need return early to avoid blowing up on a
+     * recursive tb_lock() as we can't resolve it here.
      */
 
-    if (!retaddr) {
+    if (!retaddr ||
+        (retaddr < (uintptr_t) tcg_init_ctx.code_gen_buffer) ||
+        (retaddr > (uintptr_t) (tcg_init_ctx.code_gen_buffer +
+                                tcg_init_ctx.code_gen_buffer_size))) {
         return r;
     }
 
-- 
2.14.2
