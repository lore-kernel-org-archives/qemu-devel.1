Received: from eggs.gnu.org ([2001:4830:134:3::10]:52343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj6p-0006qu-Tt
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:27:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj6m-0005kc-O9
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:26:59 -0500
Received: from mail-sn1nam02on0051.outbound.protection.outlook.com
	([104.47.36.51]:2592
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1clj6m-0005jE-Eg
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:26:56 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed, 8 Mar 2017 15:53:35 -0500
Message-ID: <148900641547.27090.18164660067628886320.stgit@brijesh-build-machine>
In-Reply-To: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v4 14/20] sev: add LAUNCH_FINISH command
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

The command is used to finalize the SEV guest launch process.

The command returns a measurement value of the data encrypted through
the LAUNCH_UPDATE command. This measurement can be handed to the guest
owner to verify that the guest was launched into SEV-enabled mode.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 include/sysemu/sev.h |    1 +
 kvm-all.c            |    1 +
 sev.c                |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+)

diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
index c614cc0..7632202 100644
--- a/include/sysemu/sev.h
+++ b/include/sysemu/sev.h
@@ -97,5 +97,6 @@ void *sev_guest_init(const char *keyid);
 void sev_set_debug_ops(void *handle, MemoryRegion *mr);
 int sev_create_launch_context(void *handle);
 int sev_encrypt_launch_buffer(void *handle, uint8_t *ptr, uint64_t len);
+int sev_release_launch_context(void *handle);
 #endif
 
diff --git a/kvm-all.c b/kvm-all.c
index 5e98534..92b4fbf 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -1828,6 +1828,7 @@ static int kvm_init(MachineState *ms)
             kvm_state->memcrypt_debug_ops = sev_set_debug_ops;
             kvm_state->create_launch_context = sev_create_launch_context;
             kvm_state->encrypt_launch_data = sev_encrypt_launch_buffer;
+            kvm_state->release_launch_context = sev_release_launch_context;
             g_free(id);
         }
     }
diff --git a/sev.c b/sev.c
index b391012..d32391e 100644
--- a/sev.c
+++ b/sev.c
@@ -253,6 +253,72 @@ err:
     return ret;
 }
 
+static void
+print_hex_dump(const char *prefix_str, uint8_t *data, int len)
+{
+    int i;
+
+    DPRINTF("%s: ", prefix_str);
+    for (i = 0; i < len; i++) {
+        DPRINTF("%02hhx", *data++);
+    }
+    DPRINTF("\n");
+}
+
+static int
+sev_launch_finish(SEVState *s)
+{
+    uint8_t *data;
+    int error, ret;
+    struct kvm_sev_launch_measure *measure;
+
+    if (!s) {
+        return 1;
+    }
+
+    measure = g_malloc0(sizeof(*measure));
+    if (!measure) {
+        return 1;
+    }
+
+    /* query measurement blob length */
+    ret = sev_ioctl(KVM_SEV_LAUNCH_MEASURE, measure, &error);
+    if (!measure->length) {
+        fprintf(stderr, "Error: failed to get launch measurement length\n");
+        ret = 1;
+        goto err_1;
+    }
+
+    data = g_malloc0(measure->length);
+    if (!data) {
+        goto err_1;
+    }
+    measure->address = (unsigned long)data;
+    /* get measurement */
+    ret = sev_ioctl(KVM_SEV_LAUNCH_MEASURE, measure, &error);
+    if (ret) {
+        fprintf(stderr, "failed LAUNCH_MEASURE %d (%#x)\n", ret, error);
+        goto err_2;
+    }
+
+    print_hex_dump("SEV: MEASUREMENT", data, measure->length);
+
+    /* finalize the launch */
+    ret = sev_ioctl(KVM_SEV_LAUNCH_FINISH, 0, &error);
+    if (ret) {
+        fprintf(stderr, "failed LAUNCH_FINISH %d (%#x)\n", ret, error);
+        goto err_2;
+    }
+
+    DPRINTF("SEV: LAUNCH_FINISH\n");
+err_2:
+    g_free(data);
+err_1:
+    g_free(measure);
+
+    return ret;
+}
+
 static int
 sev_mem_write(uint8_t *dst, const uint8_t *src, uint32_t len, MemTxAttrs attrs)
 {
@@ -334,6 +400,12 @@ sev_encrypt_launch_buffer(void *handle, uint8_t *ptr, uint64_t len)
     return sev_launch_update_data((SEVState *)handle, ptr, len);
 }
 
+int
+sev_release_launch_context(void *handle)
+{
+    return sev_launch_finish((SEVState *)handle);
+}
+
 bool
 sev_enabled(void)
 {
