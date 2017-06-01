Received: from eggs.gnu.org ([2001:4830:134:3::10]:59926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dGPQw-00049K-Vj
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dGPQv-0005pw-A1
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:35 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dGPQv-0005pq-36
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:33 -0400
Received: by mail-wm0-x243.google.com with SMTP id b84so11065812wmh.0
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 05:42:32 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  1 Jun 2017 14:41:51 +0200
Message-Id: <1496320911-51305-34-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
References: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 33/33] kvm: don't register smram_listener when
 smm is off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gonglei <arei.gonglei@huawei.com>

From: Gonglei <arei.gonglei@huawei.com>

If the user set disable smm by '-machine smm=off', we
should not register smram_listener so that we can
avoid waster memory in kvm since the added sencond
address space.

Meanwhile we should assign value of the global kvm_state
before invoking the kvm_arch_init(), because
pc_machine_is_smm_enabled() may use it by kvm_has_mm().

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
Message-Id: <1496316915-121196-1-git-send-email-arei.gonglei@huawei.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 kvm-all.c         | 4 ++--
 target/i386/kvm.c | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/kvm-all.c b/kvm-all.c
index 2598b1f..fb87bdc 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -1748,6 +1748,8 @@ static int kvm_init(MachineState *ms)
     kvm_ioeventfd_any_length_allowed =
         (kvm_check_extension(s, KVM_CAP_IOEVENTFD_ANY_LENGTH) > 0);
 
+    kvm_state = s;
+
     ret = kvm_arch_init(ms, s);
     if (ret < 0) {
         goto err;
@@ -1757,8 +1759,6 @@ static int kvm_init(MachineState *ms)
         kvm_irqchip_create(ms, s);
     }
 
-    kvm_state = s;
-
     if (kvm_eventfds_allowed) {
         s->memory_listener.listener.eventfd_add = kvm_mem_ioeventfd_add;
         s->memory_listener.listener.eventfd_del = kvm_mem_ioeventfd_del;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 6e7c197..8e3bbc5 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1255,7 +1255,9 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
-    if (kvm_check_extension(s, KVM_CAP_X86_SMM)) {
+    if (kvm_check_extension(s, KVM_CAP_X86_SMM) &&
+        object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE) &&
+        pc_machine_is_smm_enabled(PC_MACHINE(ms))) {
         smram_machine_done.notify = register_smram_listener;
         qemu_add_machine_init_done_notifier(&smram_machine_done);
     }
-- 
1.8.3.1
