Received: from eggs.gnu.org ([2001:4830:134:3::10]:39516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1fwKVu-0007Hn-Pf
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 01:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1fwKVq-0004BM-Q2
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 01:01:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42706
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1fwKVq-0004AN-KS
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 01:01:26 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w824x3xi095150
	for <qemu-devel@nongnu.org>; Sun, 2 Sep 2018 01:01:24 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2m880d2567-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 02 Sep 2018 01:01:24 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Sat, 1 Sep 2018 23:01:23 -0600
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Sun,  2 Sep 2018 02:01:12 -0300
Message-Id: <20180902050112.28066-1-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] Fix a deadlock case in the CPU hotplug flow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, bharata@linux.vnet.ibm.com

From: Jose Ricardo Ziviani <joserz@linux.ibm.com>

We need to set cs->halted to 1 before calling ppc_set_compat. The reason
is that ppc_set_compat kicks up the new thread created to manage the
hotplugged KVM virtual CPU and the code drives directly to KVM_RUN
ioctl. When cs->halted is 1, the code:

int kvm_cpu_exec(CPUState *cpu)
...
     if (kvm_arch_process_async_events(cpu)) {
         atomic_set(&cpu->exit_request, 0);
         return EXCP_HLT;
     }
...

returns before it reaches KVM_RUN, giving time to the main thread to
finish its job. Otherwise we can fall in a deadlock because the KVM
thread will issue the KVM_RUN ioctl while the main thread is setting up
KVM registers. Depending on how these jobs are scheduled we'll end up
freezing QEMU.

The following output shows kvm_vcpu_ioctl sleeping because it cannot get
the mutex and never will.
PS: kvm_vcpu_ioctl was triggered kvm_set_one_reg - compat_pvr.

STATE: TASK_UNINTERRUPTIBLE|TASK_WAKEKILL

PID: 61564  TASK: c000003e981e0780  CPU: 48  COMMAND: "qemu-system-ppc"
 #0 [c000003e982679a0] __schedule at c000000000b10a44
 #1 [c000003e98267a60] schedule at c000000000b113a8
 #2 [c000003e98267a90] schedule_preempt_disabled at c000000000b11910
 #3 [c000003e98267ab0] __mutex_lock at c000000000b132ec
 #4 [c000003e98267bc0] kvm_vcpu_ioctl at c00800000ea03140 [kvm]
 #5 [c000003e98267d20] do_vfs_ioctl at c000000000407d30
 #6 [c000003e98267dc0] ksys_ioctl at c000000000408674
 #7 [c000003e98267e10] sys_ioctl at c0000000004086f8
 #8 [c000003e98267e30] system_call at c00000000000b488

crash> struct -x kvm.vcpus 0xc000003da0000000
vcpus = {0xc000003db4880000, 0xc000003d52b80000, 0xc0000039e9c80000, 0xc000003d0e200000, 0xc000003d58280000, 0x0, 0x0, ...}

crash> struct -x kvm_vcpu.mutex.owner 0xc000003d58280000
  mutex.owner = {
    counter = 0xc000003a23a5c881 <- flag 1: waiters
  },

crash> bt 0xc000003a23a5c880
PID: 61579  TASK: c000003a23a5c880  CPU: 9   COMMAND: "CPU 4/KVM"
(active)

crash> struct -x kvm_vcpu.mutex.wait_list 0xc000003d58280000
  mutex.wait_list = {
    next = 0xc000003e98267b10,
    prev = 0xc000003e98267b10
  },

crash> struct -x mutex_waiter.task 0xc000003e98267b10
  task = 0xc000003e981e0780

The following command-line was used to reproduce the problem (note: gdb
and trace can change the results).

 $ qemu-ppc/build/ppc64-softmmu/qemu-system-ppc64 -cpu host \
     -enable-kvm -m 4096 \
     -smp 4,maxcpus=8,sockets=1,cores=2,threads=4 \
     -display none -nographic \
     -drive file=disk1.qcow2,format=qcow2
 ...
 (qemu) device_add host-spapr-cpu-core,core-id=4
[no interaction is possible after it, only SIGKILL to take the terminal
back]

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.ibm.com>
---
 hw/ppc/spapr_cpu_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 876f0b3d9d..a73b244a3f 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -34,16 +34,16 @@ static void spapr_cpu_reset(void *opaque)
 
     cpu_reset(cs);
 
-    /* Set compatibility mode to match the boot CPU, which was either set
-     * by the machine reset code or by CAS. This should never fail.
-     */
-    ppc_set_compat(cpu, POWERPC_CPU(first_cpu)->compat_pvr, &error_abort);
-
     /* All CPUs start halted.  CPU0 is unhalted from the machine level
      * reset code and the rest are explicitly started up by the guest
      * using an RTAS call */
     cs->halted = 1;
 
+    /* Set compatibility mode to match the boot CPU, which was either set
+     * by the machine reset code or by CAS. This should never fail.
+     */
+    ppc_set_compat(cpu, POWERPC_CPU(first_cpu)->compat_pvr, &error_abort);
+
     env->spr[SPR_HIOR] = 0;
 
     lpcr = env->spr[SPR_LPCR];
-- 
2.17.1
