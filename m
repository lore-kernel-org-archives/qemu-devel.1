Received: from eggs.gnu.org ([2001:4830:134:3::10]:37565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV1-0002x1-DG
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV0-0007v7-1X
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:03 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Feb 2017 17:33:23 +1100
Message-Id: <20170222063348.32176-19-david@gibson.dropbear.id.au>
In-Reply-To: <20170222063348.32176-1-david@gibson.dropbear.id.au>
References: <20170222063348.32176-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 18/43] target-ppc,
 tcg: fix usermode segfault with pthread_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, imammedo@redhat.com, Sam Bobroff <sam.bobroff@au1.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Sam Bobroff <sam.bobroff@au1.ibm.com>

Programs run under qemu-ppc64 on an x86_64 host currently segfault
if they use pthread_create() due to the adjustment made to the NIP in
commit bd6fefe71cec5a0c7d2be4ac96307f25db56abf9.

This patch changes cpu_loop() to set the NIP back to the
pre-incremented value before calling do_syscall(), which causes the
correct address to be used for the new thread and corrects the fault.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 linux-user/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 4fd49ce..9645122 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -1712,10 +1712,12 @@ void cpu_loop(CPUPPCState *env)
              * in syscalls.
              */
             env->crf[0] &= ~0x1;
+            env->nip += 4;
             ret = do_syscall(env, env->gpr[0], env->gpr[3], env->gpr[4],
                              env->gpr[5], env->gpr[6], env->gpr[7],
                              env->gpr[8], 0, 0);
             if (ret == -TARGET_ERESTARTSYS) {
+                env->nip -= 4;
                 break;
             }
             if (ret == (target_ulong)(-TARGET_QEMU_ESIGRETURN)) {
@@ -1723,7 +1725,6 @@ void cpu_loop(CPUPPCState *env)
                    Avoid corrupting register state.  */
                 break;
             }
-            env->nip += 4;
             if (ret > (target_ulong)(-515)) {
                 env->crf[0] |= 0x1;
                 ret = -ret;
-- 
2.9.3
