Received: from eggs.gnu.org ([2001:4830:134:3::10]:53558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1er90S-0001Sp-0R
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:11:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1er90N-0005yC-Tw
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:11:19 -0500
Received: from mail-sn1nam02on0057.outbound.protection.outlook.com
	([104.47.36.57]:26791
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1er90N-0005wc-Kn
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:11:15 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed, 28 Feb 2018 15:10:21 -0600
Message-Id: <20180228211028.83970-22-brijesh.singh@amd.com>
In-Reply-To: <20180228211028.83970-1-brijesh.singh@amd.com>
References: <20180228211028.83970-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v10 21/28] sev/i386: add debug encrypt and
 decrypt commands
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

KVM_SEV_DBG_DECRYPT and KVM_SEV_DBG_ENCRYPT commands are used for
decrypting and encrypting guest memory region. The command works only if
the guest policy allows the debugging.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 accel/kvm/kvm-all.c      |  1 +
 stubs/sev.c              |  4 ++++
 target/i386/sev.c        | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/trace-events |  1 +
 4 files changed, 63 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 4974c00c46fb..f53d4ca503b0 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1681,6 +1681,7 @@ static int kvm_init(MachineState *ms)
         }
 
         kvm_state->memcrypt_encrypt_data = sev_encrypt_data;
+        kvm_state->memcrypt_debug_ops = sev_set_debug_ops;
     }
 
     ret = kvm_arch_init(ms, s);
diff --git a/stubs/sev.c b/stubs/sev.c
index 2e20f3b73a5b..73f5c7f93a67 100644
--- a/stubs/sev.c
+++ b/stubs/sev.c
@@ -15,6 +15,10 @@
 #include "qemu-common.h"
 #include "sysemu/sev.h"
 
+void sev_set_debug_ops(void *handle, MemoryRegion *mr)
+{
+}
+
 int sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len)
 {
     return 1;
diff --git a/target/i386/sev.c b/target/i386/sev.c
index c341257fcc14..23c2b6183f33 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -24,6 +24,7 @@
 #define DEFAULT_SEV_DEVICE      "/dev/sev"
 
 static SEVState *sev_state;
+static MemoryRegionRAMReadWriteOps  sev_ops;
 
 static const char *const sev_fw_errlist[] = {
     "",
@@ -600,6 +601,46 @@ sev_vm_state_change(void *opaque, int running, RunState state)
     }
 }
 
+static int
+sev_dbg_enc_dec(uint8_t *dst, const uint8_t *src, uint32_t len, bool write)
+{
+    int ret, error;
+    struct kvm_sev_dbg dbg;
+
+    dbg.src_uaddr = (unsigned long)src;
+    dbg.dst_uaddr = (unsigned long)dst;
+    dbg.len = len;
+
+    trace_kvm_sev_debug(write ? "encrypt" : "decrypt", src, dst, len);
+    ret = sev_ioctl(sev_state->sev_fd,
+                    write ? KVM_SEV_DBG_ENCRYPT : KVM_SEV_DBG_DECRYPT,
+                    &dbg, &error);
+    if (ret) {
+        error_report("%s (%s) %#llx->%#llx+%#x ret=%d fw_error=%d '%s'",
+                     __func__, write ? "write" : "read", dbg.src_uaddr,
+                     dbg.dst_uaddr, dbg.len, ret, error,
+                     fw_error_to_str(error));
+    }
+
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
@@ -703,6 +744,22 @@ sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len)
     return 0;
 }
 
+void
+sev_set_debug_ops(void *handle, MemoryRegion *mr)
+{
+    SEVState *s = (SEVState *)handle;
+
+    /* If policy does not allow debug then no need to register ops */
+    if (s->policy & SEV_POLICY_NODBG) {
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
diff --git a/target/i386/trace-events b/target/i386/trace-events
index b1fbde6e40fe..00aa6e98d810 100644
--- a/target/i386/trace-events
+++ b/target/i386/trace-events
@@ -15,3 +15,4 @@ kvm_sev_launch_start(int policy, void *session, void *pdh) "policy 0x%x session
 kvm_sev_launch_update_data(void *addr, uint64_t len) "addr %p len 0x%" PRIu64
 kvm_sev_launch_measurement(const char *value) "data %s"
 kvm_sev_launch_finish(void) ""
+kvm_sev_debug(const char *op, const uint8_t *src, uint8_t *dst, int len) "(%s) src %p dst %p len %d"
-- 
2.14.3
