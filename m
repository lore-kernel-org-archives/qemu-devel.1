Received: from eggs.gnu.org ([2001:4830:134:3::10]:51790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ejSFz-00066E-Ce
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:07:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ejSFv-0006zs-DP
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:07:35 -0500
Received: from mail-by2nam01on0043.outbound.protection.outlook.com
	([104.47.34.43]:21580
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1ejSFv-0006zW-3V
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:07:31 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed,  7 Feb 2018 10:06:33 -0600
Message-Id: <20180207160638.98872-21-brijesh.singh@amd.com>
In-Reply-To: <20180207160638.98872-1-brijesh.singh@amd.com>
References: <20180207160638.98872-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v7 21/26] sev: add debug encrypt and decrypt
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Brijesh Singh <brijesh.singh@amd.com>

KVM_SEV_DBG_DECRYPT and KVM_SEV_DBG_ENCRYPT commands are used for
decrypting and encrypting guest memory region. The command works only if
the guest policy allows the debugging.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 accel/kvm/kvm-all.c    |  1 +
 accel/kvm/sev.c        | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++
 accel/kvm/trace-events |  1 +
 include/sysemu/sev.h   |  1 +
 4 files changed, 75 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 37f7c442dc3f..7d3b7b4107eb 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1677,6 +1677,7 @@ static int kvm_init(MachineState *ms)
         }
 
         kvm_state->memcrypt_encrypt_data = sev_encrypt_data;
+        kvm_state->memcrypt_debug_ops = sev_set_debug_ops;
     }
 
     ret = kvm_arch_init(ms, s);
diff --git a/accel/kvm/sev.c b/accel/kvm/sev.c
index e422f43caa0b..7b57575e2f93 100644
--- a/accel/kvm/sev.c
+++ b/accel/kvm/sev.c
@@ -23,11 +23,13 @@
 
 #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
 #define DEFAULT_SEV_DEVICE      "/dev/sev"
+#define GUEST_POLICY_DBG_BIT    0x1
 
 static uint64_t me_mask;
 static bool sev_active;
 static int sev_fd;
 static SEVState *sev_state;
+static MemoryRegionRAMReadWriteOps  sev_ops;
 
 #define SEV_FW_MAX_ERROR      0x17
 
@@ -575,6 +577,51 @@ sev_vm_state_change(void *opaque, int running, RunState state)
     }
 }
 
+static int
+sev_dbg_enc_dec(uint8_t *dst, const uint8_t *src, uint32_t len, bool write)
+{
+    int ret, error;
+    struct kvm_sev_dbg *dbg;
+
+    dbg = g_malloc0(sizeof(*dbg));
+    if (!dbg) {
+        return 1;
+    }
+
+    dbg->src_uaddr = (unsigned long)src;
+    dbg->dst_uaddr = (unsigned long)dst;
+    dbg->len = len;
+
+    trace_kvm_sev_debug(write ? "encrypt" : "decrypt", src, dst, len);
+    ret = sev_ioctl(write ? KVM_SEV_DBG_ENCRYPT : KVM_SEV_DBG_DECRYPT,
+                    dbg, &error);
+    if (ret) {
+        error_report("%s (%s) %#llx->%#llx+%#x ret=%d fw_error=%d '%s'",
+                     __func__, write ? "write" : "read", dbg->src_uaddr,
+                     dbg->dst_uaddr, dbg->len, ret, error,
+                     fw_error_to_str(error));
+    }
+
+    g_free(dbg);
+    return ret;
+}
+
+static int
+sev_mem_read(uint8_t *dst, const uint8_t *src, uint32_t len, MemTxAttrs attrs)
+{
+    assert(attrs.debug);
+
+    return sev_dbg_enc_dec(dst, src, len, false);
+}
+
+static int
+sev_mem_write(uint8_t *dst, const uint8_t *src, uint32_t len, MemTxAttrs attrs)
+{
+    assert(attrs.debug);
+
+    return sev_dbg_enc_dec(dst, src, len, true);
+}
+
 void *
 sev_guest_init(const char *id)
 {
@@ -651,6 +698,31 @@ sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len)
     return 0;
 }
 
+void
+sev_set_debug_ops(void *handle, MemoryRegion *mr)
+{
+    int policy;
+    SEVState *s = (SEVState *)handle;
+
+    policy = object_property_get_int(OBJECT(s->sev_info),
+                                     "policy", &error_abort);
+
+    /*
+     * Check if guest policy supports debugging
+     * Bit 0 :
+     *   0 - debug allowed
+     *   1 - debug is not allowed
+     */
+    if (policy & GUEST_POLICY_DBG_BIT) {
+        return;
+    }
+
+    sev_ops.read = sev_mem_read;
+    sev_ops.write = sev_mem_write;
+
+    memory_region_set_ram_debug_ops(mr, &sev_ops);
+}
+
 static void
 sev_register_types(void)
 {
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index e810d75ea1b3..de6a12c51e06 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -22,3 +22,4 @@ kvm_sev_launch_start(int policy, void *session, void *pdh) "policy 0x%x session
 kvm_sev_launch_update_data(void *addr, uint64_t len) "addr %p len 0x%" PRIu64
 kvm_sev_launch_measurement(const char *value) "data %s"
 kvm_sev_launch_finish(void) ""
+kvm_sev_debug(const char *op, const uint8_t *src, uint8_t *dst, int len) "(%s) src %p dst %p len %d"
diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
index c173ad33f8bb..186ebca0f945 100644
--- a/include/sysemu/sev.h
+++ b/include/sysemu/sev.h
@@ -78,6 +78,7 @@ typedef struct SEVState SEVState;
 
 void *sev_guest_init(const char *id);
 int sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len);
+void sev_set_debug_ops(void *handle, MemoryRegion *mr);
 
 #endif
 
-- 
2.14.3
