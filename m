Received: from eggs.gnu.org ([2001:4830:134:3::10]:35714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1emLeV-0004JX-2A
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:40:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1emLeR-0003Wx-4H
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:40:51 -0500
Received: from mail-bn3nam01on0057.outbound.protection.outlook.com
	([104.47.33.57]:6976
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1emLeQ-0003Wg-TP
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:40:47 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Thu, 15 Feb 2018 09:39:38 -0600
Message-Id: <20180215153955.3253-13-brijesh.singh@amd.com>
In-Reply-To: <20180215153955.3253-1-brijesh.singh@amd.com>
References: <20180215153955.3253-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v9 12/29] sev/i386: register the guest memory
 range which may contain encrypted data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>, Brijesh Singh <brijesh.singh@amd.com>, Richard Henderson <rth@twiddle.net>

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
---
 target/i386/sev.c        | 41 +++++++++++++++++++++++++++++++++++++++++
 target/i386/trace-events |  2 ++
 2 files changed, 43 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index f9a8748d19c1..de5c8d4675a6 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -88,6 +88,45 @@ fw_error_to_str(int code)
     return sev_fw_errlist[code];
 }
 
+static void
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
 static void
 qsev_guest_finalize(Object *obj)
 {
@@ -404,6 +443,8 @@ sev_guest_init(const char *id)
     x86_reduced_phys_bits = reduced_phys_bits;
     x86_cbitpos = cbitpos;
     sev_active = true;
+    ram_block_notifier_add(&sev_ram_notifier);
+
     return s;
 err:
     g_free(s);
diff --git a/target/i386/trace-events b/target/i386/trace-events
index 797b716751b7..ffa3d2250425 100644
--- a/target/i386/trace-events
+++ b/target/i386/trace-events
@@ -8,3 +8,5 @@ kvm_x86_update_msi_routes(int num) "Updated %d MSI routes"
 
 # target/i386/sev.c
 kvm_sev_init(void) ""
+kvm_memcrypt_register_region(void *addr, size_t len) "addr %p len 0x%lu"
+kvm_memcrypt_unregister_region(void *addr, size_t len) "addr %p len 0x%lu"
-- 
2.14.3
