Received: from eggs.gnu.org ([2001:4830:134:3::10]:45931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gNG6Z-0000fg-CP
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 06:46:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gNG6X-0005XE-KM
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 06:46:38 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gNG6P-0005Q9-FC
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 06:46:30 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Nov 2018 11:46:16 +0000
Message-Id: <20181115114616.26265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-3.1] linux-user/sparc/signal.c: Remove dead
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

Coverity complains (CID 1390847) about some dead code in
do_sigreturn(). This is an if (err) clause that can never be
true, copied from the kernel (where __get_user returns an error).
The one code path that could report an error is in the
currently commented-out pseudocode for handling FPU register
restoring, so move the if into that comment (and fix the
broken indent in the comment in the process).

(The new position for the error check is also the semantically
correct one -- we should not restore the signal mask from
the signal frame if we get an error here, so the check must
be done before set_sigmask(), not after.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/sparc/signal.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index 295e415b1e6..ead169fbaa2 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -282,7 +282,7 @@ long do_sigreturn(CPUSPARCState *env)
     uint32_t up_psr, pc, npc;
     target_sigset_t set;
     sigset_t host_set;
-    int err=0, i;
+    int i;
 
     sf_addr = env->regwptr[UREG_FP];
     trace_user_do_sigreturn(env, sf_addr);
@@ -320,10 +320,13 @@ long do_sigreturn(CPUSPARCState *env)
     }
 
     /* FIXME: implement FPU save/restore:
-         * __get_user(fpu_save, &sf->fpu_save);
-         * if (fpu_save)
-         *        err |= restore_fpu_state(env, fpu_save);
-         */
+     * __get_user(fpu_save, &sf->fpu_save);
+     * if (fpu_save) {
+     *     if (restore_fpu_state(env, fpu_save)) {
+     *         goto segv_and_exit;
+     *     }
+     * }
+     */
 
     /* This is pretty much atomic, no amount locking would prevent
          * the races which exist anyways.
@@ -336,9 +339,6 @@ long do_sigreturn(CPUSPARCState *env)
     target_to_host_sigset_internal(&host_set, &set);
     set_sigmask(&host_set);
 
-    if (err) {
-        goto segv_and_exit;
-    }
     unlock_user_struct(sf, sf_addr, 0);
     return -TARGET_QEMU_ESIGRETURN;
 
-- 
2.19.1
