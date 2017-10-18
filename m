Received: from eggs.gnu.org ([2001:4830:134:3::10]:35794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qy1-0003Qo-HD
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qxx-00023t-KE
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:13 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:46874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1e4qxx-00023A-Cc
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:09 -0400
Received: by mail-wr0-x243.google.com with SMTP id l1so5596207wrc.3
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 09:13:09 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Oct 2017 18:12:00 +0200
Message-Id: <1508343141-31835-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
References: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 08/29] pc: make sure that plugged CPUs are of
 the same type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

heterogeneous cpus are not supported and hotplugging different
cpu model crashes QEMU:

  qemu-system-x86_64 -cpu qemu64 -smp 1,maxcpus=2
  (qemu) device_add host-x86_64-cpu,socket-id=1,core-id=0,thread-id=0,id=foo
  (qemu) info cpus
  error: failed to get MSR 0x38d
  qemu-system-x86_64: target/i386/kvm.c:2121: kvm_get_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs' failed.
  Aborted (core dumped)

Gracefully fail hotplug process in case of user mistake.

Reported-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1507638879-200718-1-git-send-email-imammedo@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 05985d4..8e307f7 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1876,8 +1876,15 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     CPUArchId *cpu_slot;
     X86CPUTopoInfo topo;
     X86CPU *cpu = X86_CPU(dev);
+    MachineState *ms = MACHINE(hotplug_dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
 
+    if(!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
+        error_setg(errp, "Invalid CPU type, expected cpu type: '%s'",
+                   ms->cpu_type);
+        return;
+    }
+
     /* if APIC ID is not set, set it based on socket/core/thread properties */
     if (cpu->apic_id == UNASSIGNED_APIC_ID) {
         int max_socket = (max_cpus - 1) / smp_threads / smp_cores;
-- 
1.8.3.1
