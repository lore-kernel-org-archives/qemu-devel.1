Received: from eggs.gnu.org ([2001:4830:134:3::10]:34040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1cRZQy-0001Un-LV
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:04:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1cRZQx-00063k-T7
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:04:28 -0500
From: Wei Huang <wei@redhat.com>
Date: Thu, 12 Jan 2017 02:04:14 -0500
Message-Id: <1484204658-28058-1-git-send-email-wei@redhat.com>
Subject: [Qemu-devel] [PATCH V1 0/4] Add vPMU vPMU support under TCG mode
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

QEMU has implemented cycle count support for guest VM under TCG mode.
But this feature is not complete. In fact using perf inside a
64-bit Linux guest VM (under TCG) can cause the following kernel panic
because some PMU registers are not implemented.

[  329.445970] [<fffffe000009e600>] armv8pmu_enable_event+0x58/0x8c
[  329.446713] [<fffffe0000621e74>] armpmu_start+0x4c/0x74

This patchset solves the problem by adding support for missing vPMU
registers. Basic perf test can work now under TCG by applying this
patchset.

[root@localhost ~]# perf stat ls
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

Thanks,
-Wei

Wei Huang (4):
  target-arm: Add support for PMU register PMSELR_EL0
  target-arm: Add support for AArch64 PMU register PMXEVTYPER_EL0
  target-arm: Add support for PMU register PMINTENSET_EL1
  target-arm: Hook up TCG vPMU with CPU pmu option

 target/arm/cpu.c    |  2 +-
 target/arm/cpu.h    |  1 +
 target/arm/helper.c | 41 +++++++++++++++++++++++++++++++++++------
 3 files changed, 37 insertions(+), 7 deletions(-)

-- 
1.8.3.1
