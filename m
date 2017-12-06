Received: from eggs.gnu.org ([2001:4830:134:3::10]:49781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eMfvt-00065o-4W
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eMfvp-0002Xl-Uv
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:41 -0500
Received: from mail-sn1nam01on0078.outbound.protection.outlook.com
	([104.47.32.78]:16064
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1eMfvp-0002Wz-N1
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:37 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed,  6 Dec 2017 14:03:34 -0600
Message-Id: <20171206200346.116537-12-brijesh.singh@amd.com>
In-Reply-To: <20171206200346.116537-1-brijesh.singh@amd.com>
References: <20171206200346.116537-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 11/23] sev: register the guest memory range
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
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Edgar E . Iglesias " <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Brijesh Singh <brijesh.singh@amd.com>

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
 accel/kvm/sev.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/accel/kvm/sev.c b/accel/kvm/sev.c
index 37020751bd14..7b5318993969 100644
--- a/accel/kvm/sev.c
+++ b/accel/kvm/sev.c
@@ -84,6 +84,43 @@ fw_error_to_str(int code)
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
+    r = kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_REG_REGION, &range);
+    if (r) {
+        error_report("%s: failed to register region (%#llx+%#llx)",
+                     __func__, range.addr, range.size);
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
+    r = kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_UNREG_REGION, &range);
+    if (r) {
+        error_report("%s: failed to unregister region (%#llx+%#llx)",
+                     __func__, range.addr, range.size);
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
@@ -286,6 +323,8 @@ sev_guest_init(const char *id)
         goto err;
     }
 
+    ram_block_notifier_add(&sev_ram_notifier);
+
     return s;
 err:
     g_free(s);
-- 
2.9.5
