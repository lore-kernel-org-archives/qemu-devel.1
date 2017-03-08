Received: from eggs.gnu.org ([2001:4830:134:3::10]:52518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj7J-0007Fi-DO
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:27:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj7G-0005r6-7j
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:27:29 -0500
Received: from mail-by2nam03on0072.outbound.protection.outlook.com
	([104.47.42.72]:32926
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1clj7F-0005qp-Sf
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:27:26 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed, 8 Mar 2017 15:53:49 -0500
Message-ID: <148900642968.27090.13322958747245445508.stgit@brijesh-build-machine>
In-Reply-To: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v4 15/20] sev: add DEBUG_DECRYPT command
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

The command is used to decrypt a page of guest memory for debug.

The command will be used by qemu monitor dump and gdbserver to access
the guest memory for debug purposes. A typical usage look like:

 cpu_physical_memory_rw_debug
   cpu_physical_memory_rw_debug_internal
     sev_debug_decrypt

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 sev.c |   36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/sev.c b/sev.c
index d32391e..f8d822d 100644
--- a/sev.c
+++ b/sev.c
@@ -320,6 +320,36 @@ err_1:
 }
 
 static int
+sev_debug_decrypt(SEVState *s, uint8_t *dst, const uint8_t *src, uint32_t len)
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
+    ret = sev_ioctl(KVM_SEV_DBG_DECRYPT, dbg, &error);
+    if (ret) {
+        fprintf(stderr, "failed DBG_DECRYPT %d (%#x)\n", ret, error);
+        goto err;
+    }
+
+err:
+    g_free(dbg);
+    return ret;
+}
+
+static int
 sev_mem_write(uint8_t *dst, const uint8_t *src, uint32_t len, MemTxAttrs attrs)
 {
     SEVState *s = kvm_memcrypt_get_handle();
@@ -335,7 +365,11 @@ sev_mem_write(uint8_t *dst, const uint8_t *src, uint32_t len, MemTxAttrs attrs)
 static int
 sev_mem_read(uint8_t *dst, const uint8_t *src, uint32_t len, MemTxAttrs attrs)
 {
-    return 0;
+    SEVState *s = kvm_memcrypt_get_handle();
+
+    assert(attrs.debug);
+
+    return sev_debug_decrypt(s, dst, src, len);
 }
 
 void *
