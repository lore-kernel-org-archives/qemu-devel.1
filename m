Received: from eggs.gnu.org ([2001:4830:134:3::10]:46727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1d5WMd-0000mw-Dw
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1d5WMZ-00066B-1v
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:53:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:28100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1d5WMY-0005ug-PV
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:53:02 -0400
From: Amarnath Valluri <amarnath.valluri@intel.com>
Date: Tue,  2 May 2017 14:52:47 +0300
Message-Id: <1493725969-19518-7-git-send-email-amarnath.valluri@intel.com>
In-Reply-To: <1493725969-19518-1-git-send-email-amarnath.valluri@intel.com>
References: <1493725969-19518-1-git-send-email-amarnath.valluri@intel.com>
Subject: [Qemu-devel] [PATCH v3 6/8] tpm-backend: Move realloc_buffer()
 implementation to base class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, patrick.ohly@intel.com, marcandre.lureau@gmail.com, berrange@redhat.com, Amarnath Valluri <amarnath.valluri@intel.com>

Provide base implementation of realloc_buffer(), so that backend implementations
can resue.

Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
---
 backends/tpm.c           |  9 ++++++++-
 hw/tpm/tpm_passthrough.c | 12 ------------
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/backends/tpm.c b/backends/tpm.c
index 4a6358e..f048c1d 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -88,8 +88,15 @@ bool tpm_backend_had_startup_error(TPMBackend *s)
 size_t tpm_backend_realloc_buffer(TPMBackend *s, TPMSizedBuffer *sb)
 {
     TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
+    if (!k->ops->realloc_buffer) {
+        size_t wanted_size = 4096; /* Linux tpm.c buffer size */
 
-    assert(k->ops->realloc_buffer);
+        if (sb->size != wanted_size) {
+            sb->buffer = g_realloc(sb->buffer, wanted_size);
+            sb->size = wanted_size;
+        }
+        return sb->size;
+    }
 
     return k->ops->realloc_buffer(sb);
 }
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 2efced1..a7da0f8 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -258,17 +258,6 @@ static bool tpm_passthrough_get_startup_error(TPMBackend *tb)
     return tpm_pt->had_startup_error;
 }
 
-static size_t tpm_passthrough_realloc_buffer(TPMSizedBuffer *sb)
-{
-    size_t wanted_size = 4096; /* Linux tpm.c buffer size */
-
-    if (sb->size != wanted_size) {
-        sb->buffer = g_realloc(sb->buffer, wanted_size);
-        sb->size = wanted_size;
-    }
-    return sb->size;
-}
-
 static void tpm_passthrough_cancel_cmd(TPMBackend *tb)
 {
     TPMPassthruState *tpm_pt = TPM_PASSTHROUGH(tb);
@@ -470,7 +459,6 @@ static const TPMDriverOps tpm_passthrough_driver = {
     .opts                     = tpm_passthrough_cmdline_opts,
     .desc                     = tpm_passthrough_create_desc,
     .create                   = tpm_passthrough_create,
-    .realloc_buffer           = tpm_passthrough_realloc_buffer,
     .reset                    = tpm_passthrough_reset,
     .had_startup_error        = tpm_passthrough_get_startup_error,
     .cancel_cmd               = tpm_passthrough_cancel_cmd,
-- 
2.7.4
