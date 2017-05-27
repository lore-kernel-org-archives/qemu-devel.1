Received: from eggs.gnu.org ([2001:4830:134:3::10]:48485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dEUvq-0004yq-E0
	for qemu-devel@nongnu.org; Sat, 27 May 2017 02:10:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dEUvn-0006Sr-9A
	for qemu-devel@nongnu.org; Sat, 27 May 2017 02:10:34 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dEUvm-0006SZ-LE
	for qemu-devel@nongnu.org; Sat, 27 May 2017 02:10:31 -0400
From: Gonglei <arei.gonglei@huawei.com>
Date: Sat, 27 May 2017 14:10:08 +0800
Message-ID: <1495865408-13848-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] kvm: don't register smram_listener when smm is
 off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, yechuan@huawei.com, Gonglei <arei.gonglei@huawei.com>

If the user set disable smm by '-machine smm=off', we
should not register smram_listener so that we can
avoid waster memory in kvm since the added sencond
address space.

Meanwhile we should assign value of the global kvm_state
before invoking the kvm_arch_init(), because
pc_machine_is_smm_enabled() may use it by kvm_has_mm().

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 kvm-all.c         | 4 ++--
 target/i386/kvm.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/kvm-all.c b/kvm-all.c
index 90b8573..92bdf2c 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -1746,6 +1746,8 @@ static int kvm_init(MachineState *ms)
     kvm_ioeventfd_any_length_allowed =
         (kvm_check_extension(s, KVM_CAP_IOEVENTFD_ANY_LENGTH) > 0);
 
+    kvm_state = s;
+
     ret = kvm_arch_init(ms, s);
     if (ret < 0) {
         goto err;
@@ -1755,8 +1757,6 @@ static int kvm_init(MachineState *ms)
         kvm_irqchip_create(ms, s);
     }
 
-    kvm_state = s;
-
     if (kvm_eventfds_allowed) {
         s->memory_listener.listener.eventfd_add = kvm_mem_ioeventfd_add;
         s->memory_listener.listener.eventfd_del = kvm_mem_ioeventfd_del;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 011d4a5..cb5b47e 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1254,7 +1254,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
-    if (kvm_check_extension(s, KVM_CAP_X86_SMM)) {
+    if (kvm_check_extension(s, KVM_CAP_X86_SMM) &&
+            pc_machine_is_smm_enabled(PC_MACHINE(ms))) {
         smram_machine_done.notify = register_smram_listener;
         qemu_add_machine_init_done_notifier(&smram_machine_done);
     }
-- 
1.8.3.1
