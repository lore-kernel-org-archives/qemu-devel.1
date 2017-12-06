Received: from eggs.gnu.org ([2001:4830:134:3::10]:49853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eMfvw-0006CA-2K
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eMfvs-0002cB-Rt
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:44 -0500
Received: from mail-sn1nam01on0068.outbound.protection.outlook.com
	([104.47.32.68]:40576
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1eMfvs-0002ai-Kt
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:40 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed,  6 Dec 2017 14:03:35 -0600
Message-Id: <20171206200346.116537-13-brijesh.singh@amd.com>
In-Reply-To: <20171206200346.116537-1-brijesh.singh@amd.com>
References: <20171206200346.116537-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 12/23] kvm: introduce memory encryption APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Edgar E . Iglesias " <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Brijesh Singh <brijesh.singh@amd.com>

Inorder to integerate the Secure Encryption Virtualization (SEV) support
add few high-level memory encryption APIs which can be used for encrypting
the guest memory region.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 accel/kvm/kvm-all.c    | 30 ++++++++++++++++++++++++++++++
 accel/stubs/kvm-stub.c | 14 ++++++++++++++
 include/sysemu/kvm.h   | 25 +++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index a9b16846675e..54a0fd6097fb 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -107,6 +107,8 @@ struct KVMState
 
     /* memory encryption */
     void *memcrypt_handle;
+    int (*memcrypt_encrypt_data)(void *handle, uint8_t *ptr, uint64_t len);
+    void (*memcrypt_debug_ops)(void *handle, MemoryRegion *mr);
 };
 
 KVMState *kvm_state;
@@ -142,6 +144,34 @@ int kvm_get_max_memslots(void)
     return s->nr_slots;
 }
 
+bool kvm_memcrypt_enabled(void)
+{
+    if (kvm_state && kvm_state->memcrypt_handle) {
+        return true;
+    }
+
+    return false;
+}
+
+int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len)
+{
+    if (kvm_state->memcrypt_handle &&
+        kvm_state->memcrypt_encrypt_data) {
+        return kvm_state->memcrypt_encrypt_data(kvm_state->memcrypt_handle,
+                                              ptr, len);
+    }
+
+    return 1;
+}
+
+void kvm_memcrypt_set_debug_ops(MemoryRegion *mr)
+{
+    if (kvm_state->memcrypt_handle &&
+        kvm_state->memcrypt_debug_ops) {
+        kvm_state->memcrypt_debug_ops(kvm_state->memcrypt_handle, mr);
+    }
+}
+
 static KVMSlot *kvm_get_free_slot(KVMMemoryListener *kml)
 {
     KVMState *s = kvm_state;
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index c964af3e1c97..5739712a67e3 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -105,6 +105,20 @@ int kvm_on_sigbus(int code, void *addr)
     return 1;
 }
 
+bool kvm_memcrypt_enabled(void)
+{
+    return false;
+}
+
+int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len)
+{
+  return 1;
+}
+
+void kvm_memcrypt_set_debug_ops(MemoryRegion *mr)
+{
+}
+
 #ifndef CONFIG_USER_ONLY
 int kvm_irqchip_add_msi_route(KVMState *s, int vector, PCIDevice *dev)
 {
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index bbf12a172339..4a5db5dde390 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -231,6 +231,31 @@ int kvm_destroy_vcpu(CPUState *cpu);
  */
 bool kvm_arm_supports_user_irq(void);
 
+/**
+ * kvm_memcrypt_enabled - return boolean indicating whether memory encryption
+ *                        is enabled
+ * Returns: 1 memory encryption is enabled
+ *          0 memory encryption is disabled
+ */
+bool kvm_memcrypt_enabled(void);
+
+/**
+ * kvm_memcrypt_encrypt_data: encrypt the memory range
+ *
+ * Return: 1 failed to encrypt the range
+ *         0 succesfully encrypted memory region
+ */
+int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len);
+
+/**
+ * kvm_memcrypt_set_debug_ram_ops: set debug_ram_ops callback
+ *
+ * When debug_ram_ops is set, debug access to this memory region will use
+ * memory encryption APIs.
+ */
+void kvm_memcrypt_set_debug_ops(MemoryRegion *mr);
+
+
 #ifdef NEED_CPU_H
 #include "cpu.h"
 
-- 
2.9.5
