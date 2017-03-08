Received: from eggs.gnu.org ([2001:4830:134:3::10]:52471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj7A-00078N-C0
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:27:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj77-0005oU-5g
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:27:20 -0500
Received: from mail-dm3nam03on0081.outbound.protection.outlook.com
	([104.47.41.81]:25600
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1clj76-0005oL-Ud
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:27:17 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed, 8 Mar 2017 15:53:59 -0500
Message-ID: <148900643904.27090.8331322427122591841.stgit@brijesh-build-machine>
In-Reply-To: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v4 16/20] sev: add DEBUG_ENCRYPT command
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

The command is used to encrypt a region of guest memory for debug.

The command will be used by gdbserver when writing the data into guest
memory for debug purposes (e.g setting breakpoint)

A typical usage looks like:
 cpu_memory_rw_debug
   cpu_physical_memory_rw_debug_internal
     sev_debug_encrypt

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 sev.c |   39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/sev.c b/sev.c
index f8d822d..52b75e3 100644
--- a/sev.c
+++ b/sev.c
@@ -350,16 +350,49 @@ err:
 }
 
 static int
+sev_debug_encrypt(SEVState *s, uint8_t *dst, const uint8_t *src, uint32_t len)
+{
+    int ret, error;
+    struct kvm_sev_dbg *dbg;
+
+    if (!s) {
+        return 1;
+    }
+
+    dbg = g_malloc0(sizeof(*dbg));
+    if (!dbg) {
+        return 1;
+    }
+
+    dbg->src_addr = (unsigned long)src;
+    dbg->dst_addr = (unsigned long)dst;
+    dbg->length = len;
+
+    ret = sev_ioctl(KVM_SEV_DBG_ENCRYPT, dbg, &error);
+    if (ret) {
+        fprintf(stderr, "failed DBG_ENCRYPT %d (%#x)\n", ret, error);
+        goto err;
+    }
+
+err:
+    g_free(dbg);
+
+    return ret;
+}
+
+static int
 sev_mem_write(uint8_t *dst, const uint8_t *src, uint32_t len, MemTxAttrs attrs)
 {
     SEVState *s = kvm_memcrypt_get_handle();
 
-    if (sev_get_current_state(s) == SEV_STATE_LAUNCHING) {
+    if (attrs.debug) {
+        return sev_debug_encrypt(s, dst, src, len);
+    } else if (sev_get_current_state(s) == SEV_STATE_LAUNCHING) {
         memcpy(dst, src, len);
         return sev_launch_update_data(s, dst, len);
+    } else {
+        return 1;
     }
-
-    return 1;
 }
 
 static int
