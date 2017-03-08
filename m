Received: from eggs.gnu.org ([2001:4830:134:3::10]:51928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj5K-0005VJ-7M
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:25:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj5G-0005Mj-VO
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:25:26 -0500
Received: from mail-by2nam01on0088.outbound.protection.outlook.com
	([104.47.34.88]:29472
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1clj5G-0005MN-K4
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:25:22 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed, 8 Mar 2017 15:53:24 -0500
Message-ID: <148900640453.27090.13878279092984827505.stgit@brijesh-build-machine>
In-Reply-To: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v4 13/20] sev: add LAUNCH_UPDATE_DATA
 command
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

The command is used to encrypt a guest memory region using the VM Encryption
Key (VEK) created by LAUNCH_START command. The firmware will also update
the measurement with the contents of the memory region for attestation.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 include/sysemu/sev.h |    2 +-
 kvm-all.c            |    1 +
 sev.c                |   44 +++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
index 88cbea5..c614cc0 100644
--- a/include/sysemu/sev.h
+++ b/include/sysemu/sev.h
@@ -96,6 +96,6 @@ bool sev_enabled(void);
 void *sev_guest_init(const char *keyid);
 void sev_set_debug_ops(void *handle, MemoryRegion *mr);
 int sev_create_launch_context(void *handle);
-
+int sev_encrypt_launch_buffer(void *handle, uint8_t *ptr, uint64_t len);
 #endif
 
diff --git a/kvm-all.c b/kvm-all.c
index a13d62f..5e98534 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -1827,6 +1827,7 @@ static int kvm_init(MachineState *ms)
             }
             kvm_state->memcrypt_debug_ops = sev_set_debug_ops;
             kvm_state->create_launch_context = sev_create_launch_context;
+            kvm_state->encrypt_launch_data = sev_encrypt_launch_buffer;
             g_free(id);
         }
     }
diff --git a/sev.c b/sev.c
index c13bbfd..b391012 100644
--- a/sev.c
+++ b/sev.c
@@ -225,9 +225,45 @@ err:
 }
 
 static int
+sev_launch_update_data(SEVState *s, uint8_t *addr, uint64_t len)
+{
+    int ret, error;
+    struct kvm_sev_launch_update_data *update;
+
+    if (!s) {
+        return 1;
+    }
+
+    update = g_malloc0(sizeof(*update));
+    if (!update) {
+        return 1;
+    }
+
+    update->address = (__u64)addr;
+    update->length = len;
+    ret = sev_ioctl(KVM_SEV_LAUNCH_UPDATE_DATA, update, &error);
+    if (ret) {
+        fprintf(stderr, "failed LAUNCH_UPDATE_DATA %d (%#x)\n", ret, error);
+        goto err;
+    }
+
+    DPRINTF("SEV: LAUNCH_UPDATE_DATA %#lx+%#lx\n", (unsigned long)addr, len);
+err:
+    g_free(update);
+    return ret;
+}
+
+static int
 sev_mem_write(uint8_t *dst, const uint8_t *src, uint32_t len, MemTxAttrs attrs)
 {
-    return 0;
+    SEVState *s = kvm_memcrypt_get_handle();
+
+    if (sev_get_current_state(s) == SEV_STATE_LAUNCHING) {
+        memcpy(dst, src, len);
+        return sev_launch_update_data(s, dst, len);
+    }
+
+    return 1;
 }
 
 static int
@@ -292,6 +328,12 @@ sev_set_debug_ops(void *handle, MemoryRegion *mr)
     memory_region_set_ram_debug_ops(mr, &sev_ops);
 }
 
+int
+sev_encrypt_launch_buffer(void *handle, uint8_t *ptr, uint64_t len)
+{
+    return sev_launch_update_data((SEVState *)handle, ptr, len);
+}
+
 bool
 sev_enabled(void)
 {
