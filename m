Received: from eggs.gnu.org ([2001:4830:134:3::10]:57200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cawMg-0001f9-Oe
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 22:22:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cawMc-0000cB-Pp
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 22:22:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44067
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1cawMc-0000by-Jd
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 22:22:42 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v173JqFr138262
	for <qemu-devel@nongnu.org>; Mon, 6 Feb 2017 22:22:41 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28euqw7131-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 22:22:41 -0500
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Tue, 7 Feb 2017 13:22:38 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Tue,  7 Feb 2017 14:21:39 +1100
Message-Id: <7c016bdc97ed45dc2eb5002db98efcee26c4d8bf.1486437689.git.sam.bobroff@au1.ibm.com>
Subject: [Qemu-devel] [PATCH v2 1/1] target-ppc,
 tcg: fix usermode segfault with pthread_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: benh@kernel.crashing.org, david@gibson.dropbear.id.au, peter.maydell@linaro.org, laurent@vivier.eu, anibal.limon@linux.intel.com, qemu-devel@nongnu.org

Programs run under qemu-ppc64 on an x86_64 host currently segfault
if they use pthread_create() due to the adjustment made to the NIP in
commit bd6fefe71cec5a0c7d2be4ac96307f25db56abf9.

This patch changes cpu_loop() to set the NIP back to the
pre-incremented value before calling do_syscall(), which causes the
correct address to be used for the new thread and corrects the fault.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---

v2:

* Remove the NIP adjustment from the -TARGET_QEMU_ESIGRETURN case, it must
break out with the same NIP as do_syscall().

 linux-user/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 30049581ef..4ea49f68be 100644
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
2.11.0
