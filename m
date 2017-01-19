Received: from eggs.gnu.org ([2001:4830:134:3::10]:40605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cUGGV-0005UN-6a
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:12:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cUGGU-0001gN-CM
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:12:47 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:37080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cUGGU-0001fz-6c
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:12:46 -0500
Received: by mail-wm0-x22c.google.com with SMTP id c206so3175169wme.0
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 09:12:46 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 19 Jan 2017 17:05:01 +0000
Message-Id: <20170119170507.16185-22-alex.bennee@linaro.org>
In-Reply-To: <20170119170507.16185-1-alex.bennee@linaro.org>
References: <20170119170507.16185-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 21/27] target-arm: helpers which may affect
 global state need the BQL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mttcg@listserver.greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com
Cc: mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, rth@twiddle.net, peter.maydell@linaro.org, claudio.fontana@huawei.com, bamvor.zhangjian@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

As the arm_call_el_change_hook may affect global state (for example with
updating the global GIC state) we need to assert/take the BQL.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/helper.c    | 6 ++++++
 target/arm/op_helper.c | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b3875c7c6e..87809562b9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6672,6 +6672,12 @@ void arm_cpu_do_interrupt(CPUState *cs)
         arm_cpu_do_interrupt_aarch32(cs);
     }
 
+    /* Hooks may change global state so BQL should be held, also the
+     * BQL needs to be held for any modification of
+     * cs->interrupt_request.
+     */
+    g_assert(qemu_mutex_iothread_locked());
+
     arm_call_el_change_hook(cpu);
 
     if (!kvm_enabled()) {
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 1348789760..e1a883c595 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -488,7 +488,9 @@ void HELPER(cpsr_write_eret)(CPUARMState *env, uint32_t val)
      */
     env->regs[15] &= (env->thumb ? ~1 : ~3);
 
+    qemu_mutex_lock_iothread();
     arm_call_el_change_hook(arm_env_get_cpu(env));
+    qemu_mutex_unlock_iothread();
 }
 
 /* Access to user mode registers from privileged modes.  */
@@ -1020,7 +1022,9 @@ void HELPER(exception_return)(CPUARMState *env)
                       cur_el, new_el, env->pc);
     }
 
+    qemu_mutex_lock_iothread();
     arm_call_el_change_hook(arm_env_get_cpu(env));
+    qemu_mutex_unlock_iothread();
 
     return;
 
-- 
2.11.0
