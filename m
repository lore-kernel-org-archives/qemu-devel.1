Received: from eggs.gnu.org ([2001:4830:134:3::10]:49102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1egDRa-0005ee-Gj
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:42:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1egDRW-0003Ut-9j
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:42:10 -0500
Received: from mail-dm3nam03on0053.outbound.protection.outlook.com
	([104.47.41.53]:39184
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1egDRW-0003UE-34
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:42:06 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Mon, 29 Jan 2018 11:41:20 -0600
Message-Id: <20180129174132.108925-12-brijesh.singh@amd.com>
In-Reply-To: <20180129174132.108925-1-brijesh.singh@amd.com>
References: <20180129174132.108925-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 11/23] sev: register the guest memory range
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
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>

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
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 accel/kvm/sev.c        | 41 +++++++++++++++++++++++++++++++++++++++++
 accel/kvm/trace-events |  2 ++
 2 files changed, 43 insertions(+)

diff --git a/accel/kvm/sev.c b/accel/kvm/sev.c
index be1791e510b3..5ae37caeb361 100644
--- a/accel/kvm/sev.c
+++ b/accel/kvm/sev.c
@@ -85,6 +85,45 @@ fw_error_to_str(int code)
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
+        error_report("%s: failed to register region (%p+%#lx)",
+                     __func__, host, size);
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
@@ -288,6 +327,8 @@ sev_guest_init(const char *id)
         goto err;
     }
 
+    ram_block_notifier_add(&sev_ram_notifier);
+
     return s;
 err:
     g_free(s);
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index ea487e5a5913..364c84bd7a73 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -15,3 +15,5 @@ kvm_irqchip_release_virq(int virq) "virq %d"
 
 # sev.c
 kvm_sev_init(void) ""
+kvm_memcrypt_register_region(void *addr, size_t len) "addr %p len 0x%lu"
+kvm_memcrypt_unregister_region(void *addr, size_t len) "addr %p len 0x%lu"
-- 
2.9.5
