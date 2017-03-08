Received: from eggs.gnu.org ([2001:4830:134:3::10]:52491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj7D-0007Aw-8e
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:27:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj7A-0005pf-3I
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:27:23 -0500
Received: from mail-dm3nam03on0044.outbound.protection.outlook.com
	([104.47.41.44]:60518
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1clj79-0005pP-RO
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:27:20 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed, 8 Mar 2017 15:52:26 -0500
Message-ID: <148900634659.27090.2157657994637303677.stgit@brijesh-build-machine>
In-Reply-To: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v4 07/20] kvm: add memory encryption api
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com, mst@redhat.com, p.fedin@samsung.com, qemu-devel@nongnu.org, lcapitulino@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Cc: Thomas.Lendacky@amd.com, brijesh.singh@amd.com

Add high level API's to provide guest memory encryption support.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 include/sysemu/kvm.h |    7 +++++++
 kvm-all.c            |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kvm-stub.c           |   31 ++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 24281fc..6f88a06 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -227,6 +227,13 @@ int kvm_init_vcpu(CPUState *cpu);
 int kvm_cpu_exec(CPUState *cpu);
 int kvm_destroy_vcpu(CPUState *cpu);
 
+bool kvm_memcrypt_enabled(void);
+void *kvm_memcrypt_get_handle(void);
+void kvm_memcrypt_set_debug_ops(MemoryRegion *mr);
+int kvm_memcrypt_create_launch_context(void);
+int kvm_memcrypt_release_launch_context(void);
+int kvm_memcrypt_encrypt_launch_data(uint8_t *ptr, uint64_t len);
+
 #ifdef NEED_CPU_H
 #include "cpu.h"
 
diff --git a/kvm-all.c b/kvm-all.c
index 9040bd5..bba0f39 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -36,6 +36,7 @@
 #include "qemu/event_notifier.h"
 #include "trace-root.h"
 #include "hw/irq.h"
+#include "sysemu/security-policy.h"
 
 #include "hw/boards.h"
 
@@ -101,6 +102,13 @@ struct KVMState
 #endif
     KVMMemoryListener memory_listener;
     QLIST_HEAD(, KVMParkedVcpu) kvm_parked_vcpus;
+
+    /* memory encryption support */
+    void *ehandle;
+    int (*create_launch_context)(void *ehandle);
+    int (*release_launch_context)(void *ehandle);
+    int (*encrypt_launch_data)(void *ehandle, uint8_t *dst, uint64_t len);
+    void (*memcrypt_debug_ops)(void *ehandle, MemoryRegion *mr);
 };
 
 KVMState *kvm_state;
@@ -128,6 +136,50 @@ static const KVMCapabilityInfo kvm_required_capabilites[] = {
     KVM_CAP_LAST_INFO
 };
 
+bool kvm_memcrypt_enabled(void)
+{
+    return kvm_state->ehandle ? true : false;
+}
+
+int kvm_memcrypt_create_launch_context(void)
+{
+    if (kvm_state->create_launch_context) {
+        return kvm_state->create_launch_context(kvm_state->ehandle);
+    }
+
+    return 1;
+}
+
+int kvm_memcrypt_release_launch_context(void)
+{
+    if (kvm_state->release_launch_context) {
+        return kvm_state->release_launch_context(kvm_state->ehandle);
+    }
+
+    return 1;
+}
+
+int kvm_memcrypt_encrypt_launch_data(uint8_t *dst, uint64_t len)
+{
+    if (kvm_state->encrypt_launch_data) {
+        return kvm_state->encrypt_launch_data(kvm_state->ehandle, dst, len);
+    }
+
+    return 1;
+}
+
+void kvm_memcrypt_set_debug_ops(MemoryRegion *mr)
+{
+    if (kvm_state->memcrypt_debug_ops) {
+        return kvm_state->memcrypt_debug_ops(kvm_state->ehandle, mr);
+    }
+}
+
+void *kvm_memcrypt_get_handle(void)
+{
+    return kvm_state->ehandle;
+}
+
 int kvm_get_max_memslots(void)
 {
     KVMState *s = KVM_STATE(current_machine->accelerator);
diff --git a/kvm-stub.c b/kvm-stub.c
index ef0c734..20920aa 100644
--- a/kvm-stub.c
+++ b/kvm-stub.c
@@ -105,6 +105,37 @@ int kvm_on_sigbus(int code, void *addr)
     return 1;
 }
 
+bool kvm_memcrypt_enabled(void)
+{
+    return false;
+}
+
+void *kvm_memcrypt_get_handle(void)
+{
+    return NULL;
+}
+
+void kvm_memcrypt_set_debug_ops(MemoryRegion *mr)
+{
+    return;
+}
+
+int kvm_memcrypt_create_launch_context(void)
+{
+    return 1;
+}
+
+int kvm_memcrypt_release_launch_context(void)
+{
+    return 1;
+}
+
+int kvm_memcrypt_encrypt_launch_data(uint8_t *ptr, uint64_t len)
+{
+    return 1;
+}
+
+
 #ifndef CONFIG_USER_ONLY
 int kvm_irqchip_add_msi_route(KVMState *s, int vector, PCIDevice *dev)
 {
