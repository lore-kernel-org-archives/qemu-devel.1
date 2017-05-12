Received: from eggs.gnu.org ([2001:4830:134:3::10]:45683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d9KAb-0001IK-68
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:40:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d9KAa-00047X-4n
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:40:25 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d9KAa-00047E-07
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:40:24 -0400
Received: by mail-qt0-x243.google.com with SMTP id j13so8690782qta.3
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 16:40:23 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 12 May 2017 16:40:07 -0700
Message-Id: <20170512234009.32557-8-rth@twiddle.net>
In-Reply-To: <20170512234009.32557-1-rth@twiddle.net>
References: <20170512234009.32557-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 7/9] target/s390x: mask the SIGP order_code
 using SIGP_ORDER_MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Aurelien Jarno <aurelien@aurel32.net>

From: Aurelien Jarno <aurelien@aurel32.net>

For that move the definition from kvm.c to cpu.h

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Message-Id: <20170509082800.10756-2-aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/cpu.h         | 3 +++
 target/s390x/kvm.c         | 2 --
 target/s390x/misc_helper.c | 3 +--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index bbed320..240b8a5 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -1078,6 +1078,9 @@ struct sysib_322 {
 #define SIGP_MODE_Z_ARCH_TRANS_ALL_PSW 1
 #define SIGP_MODE_Z_ARCH_TRANS_CUR_PSW 2
 
+/* SIGP order code mask corresponding to bit positions 56-63 */
+#define SIGP_ORDER_MASK 0x000000ff
+
 void load_psw(CPUS390XState *env, uint64_t mask, uint64_t addr);
 int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
                   target_ulong *raddr, int *flags, bool exc);
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 1a249d8..fb10542 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1764,8 +1764,6 @@ static int sigp_set_architecture(S390CPU *cpu, uint32_t param,
     return SIGP_CC_ORDER_CODE_ACCEPTED;
 }
 
-#define SIGP_ORDER_MASK 0x000000ff
-
 static int handle_sigp(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
 {
     CPUS390XState *env = &cpu->env;
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index bd94242..23ec52c 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -517,8 +517,7 @@ uint32_t HELPER(sigp)(CPUS390XState *env, uint64_t order_code, uint32_t r1,
     /* Remember: Use "R1 or R1 + 1, whichever is the odd-numbered register"
        as parameter (input). Status (output) is always R1. */
 
-    /* sigp contains the order code in bit positions 56-63, mask it here. */
-    switch (order_code & 0xff) {
+    switch (order_code & SIGP_ORDER_MASK) {
     case SIGP_SET_ARCH:
         /* switch arch */
         break;
-- 
2.9.3
