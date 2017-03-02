Received: from eggs.gnu.org ([2001:4830:134:3::10]:59684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cjWnK-000813-DN
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:53:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cjWnJ-0002Vf-ET
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:53:46 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:37552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cjWnJ-0002V8-8A
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:53:45 -0500
Received: by mail-wm0-x22b.google.com with SMTP id n11so133207wma.0
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 11:53:45 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  2 Mar 2017 19:53:33 +0000
Message-Id: <20170302195337.31558-8-alex.bennee@linaro.org>
In-Reply-To: <20170302195337.31558-1-alex.bennee@linaro.org>
References: <20170302195337.31558-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 07/11] s390x/misc_helper.c: wrap IO
 instructions in BQL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Alexander Graf <agraf@suse.de>

Helpers that can trigger IO events (including interrupts) need to be
protected by the BQL. I've updated all the helpers that call into an
ioinst_handle_* functions.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/s390x/misc_helper.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 3cb942e8bb..93b0e61366 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "exec/memory.h"
 #include "qemu/host-utils.h"
@@ -551,61 +552,81 @@ uint32_t HELPER(sigp)(CPUS390XState *env, uint64_t order_code, uint32_t r1,
 void HELPER(xsch)(CPUS390XState *env, uint64_t r1)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
+    qemu_mutex_lock_iothread();
     ioinst_handle_xsch(cpu, r1);
+    qemu_mutex_unlock_iothread();
 }
 
 void HELPER(csch)(CPUS390XState *env, uint64_t r1)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
+    qemu_mutex_lock_iothread();
     ioinst_handle_csch(cpu, r1);
+    qemu_mutex_unlock_iothread();
 }
 
 void HELPER(hsch)(CPUS390XState *env, uint64_t r1)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
+    qemu_mutex_lock_iothread();
     ioinst_handle_hsch(cpu, r1);
+    qemu_mutex_unlock_iothread();
 }
 
 void HELPER(msch)(CPUS390XState *env, uint64_t r1, uint64_t inst)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
+    qemu_mutex_lock_iothread();
     ioinst_handle_msch(cpu, r1, inst >> 16);
+    qemu_mutex_unlock_iothread();
 }
 
 void HELPER(rchp)(CPUS390XState *env, uint64_t r1)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
+    qemu_mutex_lock_iothread();
     ioinst_handle_rchp(cpu, r1);
+    qemu_mutex_unlock_iothread();
 }
 
 void HELPER(rsch)(CPUS390XState *env, uint64_t r1)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
+    qemu_mutex_lock_iothread();
     ioinst_handle_rsch(cpu, r1);
+    qemu_mutex_unlock_iothread();
 }
 
 void HELPER(ssch)(CPUS390XState *env, uint64_t r1, uint64_t inst)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
+    qemu_mutex_lock_iothread();
     ioinst_handle_ssch(cpu, r1, inst >> 16);
+    qemu_mutex_unlock_iothread();
 }
 
 void HELPER(stsch)(CPUS390XState *env, uint64_t r1, uint64_t inst)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
+    qemu_mutex_lock_iothread();
     ioinst_handle_stsch(cpu, r1, inst >> 16);
+    qemu_mutex_unlock_iothread();
 }
 
 void HELPER(tsch)(CPUS390XState *env, uint64_t r1, uint64_t inst)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
+    qemu_mutex_lock_iothread();
     ioinst_handle_tsch(cpu, r1, inst >> 16);
+    qemu_mutex_unlock_iothread();
 }
 
 void HELPER(chsc)(CPUS390XState *env, uint64_t inst)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
+    qemu_mutex_lock_iothread();
     ioinst_handle_chsc(cpu, inst >> 16);
+    qemu_mutex_unlock_iothread();
 }
 #endif
 
-- 
2.11.0
