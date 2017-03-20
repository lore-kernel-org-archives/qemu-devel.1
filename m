Received: from eggs.gnu.org ([2001:4830:134:3::10]:41564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qy-0001zY-58
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qq-00059e-R9
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38839
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qq-00058s-JB
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:44 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8eWs014518
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:44 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29af6evvwk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:43 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 17:09:43 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:29 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-66-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 65/81] target-ppc,
 tcg: fix usermode segfault with pthread_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Sam Bobroff <sam.bobroff@au1.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

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
(cherry picked from commit 2635531f2006bfb0f943ad25b41e176709b79b37)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 linux-user/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index cc77ec4..65a769c 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -1708,10 +1708,12 @@ void cpu_loop(CPUPPCState *env)
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
@@ -1719,7 +1721,6 @@ void cpu_loop(CPUPPCState *env)
                    Avoid corrupting register state.  */
                 break;
             }
-            env->nip += 4;
             if (ret > (target_ulong)(-515)) {
                 env->crf[0] |= 0x1;
                 ret = -ret;
-- 
2.7.4
