Received: from eggs.gnu.org ([2001:4830:134:3::10]:57932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9U68-00063Z-24
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 06:48:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9U64-0004aA-Tw
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 06:48:44 -0400
Received: from mail.ispras.ru ([83.149.199.45]:39934)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9U64-0004Z3-MX
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 06:48:40 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 31 Oct 2017 13:48:40 +0300
Message-ID: <20171031104840.3079.81200.stgit@pasha-VirtualBox>
In-Reply-To: <20171031104741.3079.26584.stgit@pasha-VirtualBox>
References: <20171031104741.3079.26584.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFCPATCH11/20] target/arm/arm-powertctl: drop BQL
 assertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dovgaluk@ispras.ru

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

The powerctl code is run in the context of the vCPU changing power
state. It does not need the BQL to protect its changes.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 target/arm/arm-powerctl.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index 25207cb..9661a59 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -124,7 +124,6 @@ static void arm_set_cpu_on_async_work(CPUState *targe=
t_cpu_state,
     g_free(info);
=20
     /* Finally set the power status */
-    assert(qemu_mutex_iothread_locked());
     target_cpu->power_state =3D PSCI_ON;
 }
=20
@@ -135,8 +134,6 @@ int arm_set_cpu_on(uint64_t cpuid, uint64_t entry, ui=
nt64_t context_id,
     ARMCPU *target_cpu;
     struct CpuOnInfo *info;
=20
-    assert(qemu_mutex_iothread_locked());
-
     DPRINTF("cpu %" PRId64 " (EL %d, %s) @ 0x%" PRIx64 " with R0 =3D 0x%=
" PRIx64
             "\n", cpuid, target_el, target_aa64 ? "aarch64" : "aarch32",=
 entry,
             context_id);
@@ -227,7 +224,6 @@ static void arm_set_cpu_off_async_work(CPUState *targ=
et_cpu_state,
 {
     ARMCPU *target_cpu =3D ARM_CPU(target_cpu_state);
=20
-    assert(qemu_mutex_iothread_locked());
     target_cpu->power_state =3D PSCI_OFF;
     target_cpu_state->halted =3D 1;
     target_cpu_state->exception_index =3D EXCP_HLT;
@@ -238,8 +234,6 @@ int arm_set_cpu_off(uint64_t cpuid)
     CPUState *target_cpu_state;
     ARMCPU *target_cpu;
=20
-    assert(qemu_mutex_iothread_locked());
-
     DPRINTF("cpu %" PRId64 "\n", cpuid);
=20
     /* change to the cpu we are powering up */
@@ -274,8 +268,6 @@ int arm_reset_cpu(uint64_t cpuid)
     CPUState *target_cpu_state;
     ARMCPU *target_cpu;
=20
-    assert(qemu_mutex_iothread_locked());
-
     DPRINTF("cpu %" PRId64 "\n", cpuid);
=20
     /* change to the cpu we are resetting */
