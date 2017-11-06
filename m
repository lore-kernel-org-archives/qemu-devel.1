Received: from eggs.gnu.org ([2001:4830:134:3::10]:35897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eBmCk-0002AH-DM
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:33:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eBmCj-0000nu-FB
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:33:02 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eBmCj-0000ky-9K
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:33:01 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  6 Nov 2017 18:33:23 +0000
Message-Id: <1509993206-26637-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1509993206-26637-1-git-send-email-peter.maydell@linaro.org>
References: <1509993206-26637-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/4] linux-user/s390x: Mask si_addr for SIGSEGV
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

For s390x, the address passed to a signal handler in the
siginfo_t si_addr field is masked (in the kernel this is done in
do_sigbus() and do_sigsegv() in arch/s390/mm/fault.c). Implement
this architecture-specific oddity in linux-user.

This is one of the issues described in
https://bugs.launchpad.net/qemu/+bug/1705118

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index aa02f25..b6dd9ef 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -3238,6 +3238,10 @@ void cpu_loop(CPUAlphaState *env)
 #endif /* TARGET_ALPHA */
 
 #ifdef TARGET_S390X
+
+/* s390x masks the fault address it reports in si_addr for SIGSEGV and SIGBUS */
+#define S390X_FAIL_ADDR_MASK -4096LL
+
 void cpu_loop(CPUS390XState *env)
 {
     CPUState *cs = CPU(s390_env_get_cpu(env));
@@ -3294,7 +3298,7 @@ void cpu_loop(CPUS390XState *env)
                 sig = TARGET_SIGSEGV;
                 /* XXX: check env->error_code */
                 n = TARGET_SEGV_MAPERR;
-                addr = env->__excp_addr;
+                addr = env->__excp_addr & S390X_FAIL_ADDR_MASK;
                 goto do_signal;
             case PGM_EXECUTE:
             case PGM_SPECIFICATION:
-- 
2.7.4
