Received: from eggs.gnu.org ([2001:4830:134:3::10]:58248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1eGtW0-0004kO-Er
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:22:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1eGtVz-0007yQ-Hb
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:22:04 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:42561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1eGtVz-0007xn-Af
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:22:03 -0500
Received: by mail-lf0-x241.google.com with SMTP id m1so11692656lfj.9
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 13:22:03 -0800 (PST)
From: riku.voipio@linaro.org
Date: Mon, 20 Nov 2017 23:21:39 +0200
Message-Id: <f2d34df3c1a88a2cf86eb0afc88c369d799ae431.1511212753.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1511212753.git.riku.voipio@linaro.org>
References: <cover.1511212753.git.riku.voipio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/15] linux-user/s390x: Mask si_addr for SIGSEGV
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

For s390x, the address passed to a signal handler in the
siginfo_t si_addr field is masked (in the kernel this is done in
do_sigbus() and do_sigsegv() in arch/s390/mm/fault.c). Implement
this architecture-specific oddity in linux-user.

This is one of the issues described in
https://bugs.launchpad.net/qemu/+bug/1705118

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index aa02f25b85..b6dd9efd2d 100644
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
2.14.2
