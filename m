Received: from eggs.gnu.org ([2001:4830:134:3::10]:60460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUY-0001DG-Fd
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUX-0000hn-GQ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:22 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:40699)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evjUX-0000h9-9V
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:21 -0400
Received: by mail-wr0-x243.google.com with SMTP id m4so9587635wrb.7
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 05:57:21 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 13:56:22 +0100
Message-Id: <1520945798-50640-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
References: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 06/22] kvm: introduce memory encryption APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Brijesh Singh <brijesh.singh@amd.com>, kvm@vger.kernel.org

From: Brijesh Singh <brijesh.singh@amd.com>

Inorder to integerate the Secure Encryption Virtualization (SEV) support
add few high-level memory encryption APIs which can be used for encrypting
the guest memory region.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c    | 14 ++++++++++++++
 accel/kvm/sev-stub.c   |  5 +++++
 accel/stubs/kvm-stub.c |  5 +++++
 include/sysemu/kvm.h   |  8 ++++++++
 include/sysemu/sev.h   |  1 +
 5 files changed, 33 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index e0e43fd..ffee68e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -107,6 +107,7 @@ struct KVMState
 
     /* memory encryption */
     void *memcrypt_handle;
+    int (*memcrypt_encrypt_data)(void *handle, uint8_t *ptr, uint64_t len);
 };
 
 KVMState *kvm_state;
@@ -151,6 +152,17 @@ bool kvm_memcrypt_enabled(void)
     return false;
 }
 
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
 static KVMSlot *kvm_get_free_slot(KVMMemoryListener *kml)
 {
     KVMState *s = kvm_state;
@@ -1659,6 +1671,8 @@ static int kvm_init(MachineState *ms)
             ret = -1;
             goto err;
         }
+
+        kvm_state->memcrypt_encrypt_data = sev_encrypt_data;
     }
 
     ret = kvm_arch_init(ms, s);
diff --git a/accel/kvm/sev-stub.c b/accel/kvm/sev-stub.c
index 4a5cc55..4f97452 100644
--- a/accel/kvm/sev-stub.c
+++ b/accel/kvm/sev-stub.c
@@ -15,6 +15,11 @@
 #include "qemu-common.h"
 #include "sysemu/sev.h"
 
+int sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len)
+{
+    abort();
+}
+
 void *sev_guest_init(const char *id)
 {
     return NULL;
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index f83192d..02d5170 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -110,6 +110,11 @@ bool kvm_memcrypt_enabled(void)
     return false;
 }
 
+int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len)
+{
+  return 1;
+}
+
 #ifndef CONFIG_USER_ONLY
 int kvm_irqchip_add_msi_route(KVMState *s, int vector, PCIDevice *dev)
 {
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 84017a0..23669c4 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -239,6 +239,14 @@ bool kvm_arm_supports_user_irq(void);
  */
 bool kvm_memcrypt_enabled(void);
 
+/**
+ * kvm_memcrypt_encrypt_data: encrypt the memory range
+ *
+ * Return: 1 failed to encrypt the range
+ *         0 succesfully encrypted memory region
+ */
+int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len);
+
 
 #ifdef NEED_CPU_H
 #include "cpu.h"
diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
index f7a6057..98c1ec8 100644
--- a/include/sysemu/sev.h
+++ b/include/sysemu/sev.h
@@ -17,4 +17,5 @@
 #include "sysemu/kvm.h"
 
 void *sev_guest_init(const char *id);
+int sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len);
 #endif
-- 
1.8.3.1
