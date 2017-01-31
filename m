Received: from eggs.gnu.org ([2001:4830:134:3::10]:57524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1cYa9w-0007ZZ-If
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:15:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1cYa9v-00019g-Hu
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:15:52 -0500
From: Wei Huang <wei@redhat.com>
Date: Tue, 31 Jan 2017 10:15:40 -0500
Message-Id: <1485875745-27741-1-git-send-email-wei@redhat.com>
Subject: [Qemu-devel] [PATCH V2 0/5] Add vPMU vPMU support under TCG mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org

But this feature is not complete. In fact using perf inside a
64-bit Linux guest VM (under TCG) can cause the following kernel panic
because some PMU registers are not implemented.

[  329.445970] [<fffffe000009e600>] armv8pmu_enable_event+0x58/0x8c
[  329.446713] [<fffffe0000621e74>] armpmu_start+0x4c/0x74

This patchset solves the problem by adding support for missing vPMU
registers. Basic perf test can work (both ACPI and DT) now under TCG
by applying this patchset.

address@hidden ~]# perf stat ls
 Performance counter stats for 'ls':

        226.740256      task-clock (msec)         #    0.312 CPUs utilized    
                76      context-switches          #    0.335 K/sec
                 0      cpu-migrations            #    0.000 K/sec
                64      page-faults               #    0.282 K/sec
       186,031,410      cycles                    #    0.820 GHz      (36.40%)
   <not supported>      stalled-cycles-frontend
   <not supported>      stalled-cycles-backend
     <not counted>      instructions               (0.00%)
   <not supported>      branches
     <not counted>      branch-misses              (0.00%)

V1->V2:
  * Change most PMU registers to 64bit and the behavior of PMXEVTYPER
  * Add support for PMXEVCNTR_EL0
  * Misc fixes (DT, ID_AA64DFR0_EL1, ...) under TCG mode

Thanks,
-Wei

Wei Huang (5):
  target-arm: Add support for PMU register PMSELR_EL0
  target-arm: Add support for AArch64 PMU register PMXEVTYPER_EL0
  target-arm: Add support for PMU register PMXEVCNTR_EL0
  target-arm: Add support for PMU register PMINTENSET_EL1
  target-arm: Enable vPMU support under TCG mode

 hw/arm/virt.c       |  2 +-
 target/arm/cpu.c    |  2 +-
 target/arm/cpu.h    |  5 +++--
 target/arm/helper.c | 65 ++++++++++++++++++++++++++++++++++++++++-------------
 4 files changed, 55 insertions(+), 19 deletions(-)

-- 
1.8.3.1
