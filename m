Received: from eggs.gnu.org ([2001:4830:134:3::10]:52557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6acO-0001kR-RU
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:37:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6acM-0006hc-B4
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:37:48 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:33998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d6acM-0006h4-47
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:37:46 -0400
Received: by mail-wm0-x235.google.com with SMTP id u65so1973321wmu.1
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 03:37:44 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  5 May 2017 11:38:14 +0100
Message-Id: <20170505103822.20641-2-alex.bennee@linaro.org>
In-Reply-To: <20170505103822.20641-1-alex.bennee@linaro.org>
References: <20170505103822.20641-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v1 1/9] target/arm/arm-powertctl: drop BQL
 assertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, boost.lists@gmail.com, pavel.dovgaluk@ispras.ru
Cc: cota@braap.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

The powerctl code is run in the context of the vCPU changing power
state. It does not need the BQL to protect its changes.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/arm-powerctl.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index 25207cb850..9661a59dad 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -124,7 +124,6 @@ static void arm_set_cpu_on_async_work(CPUState *target_cpu_state,
     g_free(info);
 
     /* Finally set the power status */
-    assert(qemu_mutex_iothread_locked());
     target_cpu->power_state = PSCI_ON;
 }
 
@@ -135,8 +134,6 @@ int arm_set_cpu_on(uint64_t cpuid, uint64_t entry, uint64_t context_id,
     ARMCPU *target_cpu;
     struct CpuOnInfo *info;
 
-    assert(qemu_mutex_iothread_locked());
-
     DPRINTF("cpu %" PRId64 " (EL %d, %s) @ 0x%" PRIx64 " with R0 = 0x%" PRIx64
             "\n", cpuid, target_el, target_aa64 ? "aarch64" : "aarch32", entry,
             context_id);
@@ -227,7 +224,6 @@ static void arm_set_cpu_off_async_work(CPUState *target_cpu_state,
 {
     ARMCPU *target_cpu = ARM_CPU(target_cpu_state);
 
-    assert(qemu_mutex_iothread_locked());
     target_cpu->power_state = PSCI_OFF;
     target_cpu_state->halted = 1;
     target_cpu_state->exception_index = EXCP_HLT;
@@ -238,8 +234,6 @@ int arm_set_cpu_off(uint64_t cpuid)
     CPUState *target_cpu_state;
     ARMCPU *target_cpu;
 
-    assert(qemu_mutex_iothread_locked());
-
     DPRINTF("cpu %" PRId64 "\n", cpuid);
 
     /* change to the cpu we are powering up */
@@ -274,8 +268,6 @@ int arm_reset_cpu(uint64_t cpuid)
     CPUState *target_cpu_state;
     ARMCPU *target_cpu;
 
-    assert(qemu_mutex_iothread_locked());
-
     DPRINTF("cpu %" PRId64 "\n", cpuid);
 
     /* change to the cpu we are resetting */
-- 
2.11.0
