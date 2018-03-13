Received: from eggs.gnu.org ([2001:4830:134:3::10]:60664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUe-0001Kc-Pe
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUd-0000oF-Kf
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:28 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:39010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evjUd-0000n7-96
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:27 -0400
Received: by mail-wr0-x243.google.com with SMTP id k3so2974384wrg.6
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 05:57:27 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 13:56:27 +0100
Message-Id: <1520945798-50640-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
References: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 11/22] sev/i386: register the guest memory range
 which may contain encrypted data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Brijesh Singh <brijesh.singh@amd.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Brijesh Singh <brijesh.singh@amd.com>

When SEV is enabled, the hardware encryption engine uses a tweak such
that the two identical plaintext at different location will have a
different ciphertexts. So swapping or moving a ciphertexts of two guest
pages will not result in plaintexts being swapped. Hence relocating
a physical backing pages of the SEV guest will require some additional
steps in KVM driver. The KVM_MEMORY_ENCRYPT_{UN,}REG_REGION ioctl can be
used to register/unregister the guest memory region which may contain the
encrypted data. KVM driver will internally handle the relocating physical
backing pages of registered memory regions.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c        | 42 ++++++++++++++++++++++++++++++++++++++++++
 target/i386/trace-events |  2 ++
 2 files changed, 44 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 91b5190..c63012a 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -106,6 +106,46 @@ fw_error_to_str(int code)
 }
 
 static void
+sev_ram_block_added(RAMBlockNotifier *n, void *host, size_t size)
+{
+    int r;
+    struct kvm_enc_region range;
+
+    range.addr = (__u64)host;
+    range.size = size;
+
+    trace_kvm_memcrypt_register_region(host, size);
+    r = kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_REG_REGION, &range);
+    if (r) {
+        error_report("%s: failed to register region (%p+%#lx) error '%s'",
+                     __func__, host, size, strerror(errno));
+        exit(1);
+    }
+}
+
+static void
+sev_ram_block_removed(RAMBlockNotifier *n, void *host, size_t size)
+{
+    int r;
+    struct kvm_enc_region range;
+
+    range.addr = (__u64)host;
+    range.size = size;
+
+    trace_kvm_memcrypt_unregister_region(host, size);
+    r = kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_UNREG_REGION, &range);
+    if (r) {
+        error_report("%s: failed to unregister region (%p+%#lx)",
+                     __func__, host, size);
+    }
+}
+
+static struct RAMBlockNotifier sev_ram_notifier = {
+    .ram_block_added = sev_ram_block_added,
+    .ram_block_removed = sev_ram_block_removed,
+};
+
+static void
 qsev_guest_finalize(Object *obj)
 {
 }
@@ -436,6 +476,8 @@ sev_guest_init(const char *id)
         goto err;
     }
 
+    ram_block_notifier_add(&sev_ram_notifier);
+
     return s;
 err:
     g_free(sev_state);
diff --git a/target/i386/trace-events b/target/i386/trace-events
index 797b716..ffa3d22 100644
--- a/target/i386/trace-events
+++ b/target/i386/trace-events
@@ -8,3 +8,5 @@ kvm_x86_update_msi_routes(int num) "Updated %d MSI routes"
 
 # target/i386/sev.c
 kvm_sev_init(void) ""
+kvm_memcrypt_register_region(void *addr, size_t len) "addr %p len 0x%lu"
+kvm_memcrypt_unregister_region(void *addr, size_t len) "addr %p len 0x%lu"
-- 
1.8.3.1
