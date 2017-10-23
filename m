Received: from eggs.gnu.org ([2001:4830:134:3::10]:41607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1e6bQm-0006Ek-UA
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 08:02:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1e6bQh-0008AH-2U
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 08:02:08 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:14962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1e6bQg-0008A1-SU
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 08:02:03 -0400
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Mon, 23 Oct 2017 12:24:59 +0200
Message-Id: <20171023120200.DE9BC74569A@zero.eik.bme.hu>
Subject: [Qemu-devel] [PATCH v2] Fix compile with --disable-tpm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Philippe Mathieu-Daude <f4bug@amsat.org>

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 tpm.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/tpm.c b/tpm.c
index 45520f5..ed78ead 100644
--- a/tpm.c
+++ b/tpm.c
@@ -30,8 +30,6 @@ void tpm_register_model(enum TpmModel model)
     tpm_models[model] = true;
 }
 
-#ifdef CONFIG_TPM
-
 static const TPMBackendClass *
 tpm_be_find_by_type(enum TpmType type)
 {
@@ -48,6 +46,8 @@ tpm_be_find_by_type(enum TpmType type)
     return TPM_BACKEND_CLASS(oc);
 }
 
+#ifdef CONFIG_TPM
+
 /*
  * Walk the list of available TPM backend drivers and display them on the
  * screen.
@@ -146,20 +146,6 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
 }
 
 /*
- * Walk the list of TPM backend drivers that are in use and call their
- * destroy function to have them cleaned up.
- */
-void tpm_cleanup(void)
-{
-    TPMBackend *drv, *next;
-
-    QLIST_FOREACH_SAFE(drv, &tpm_backends, list, next) {
-        QLIST_REMOVE(drv, list);
-        object_unref(OBJECT(drv));
-    }
-}
-
-/*
  * Initialize the TPM. Process the tpmdev command line options describing the
  * TPM backend.
  */
@@ -195,6 +181,20 @@ int tpm_config_parse(QemuOptsList *opts_list, const char *optarg)
 #endif /* CONFIG_TPM */
 
 /*
+ * Walk the list of TPM backend drivers that are in use and call their
+ * destroy function to have them cleaned up.
+ */
+void tpm_cleanup(void)
+{
+    TPMBackend *drv, *next;
+
+    QLIST_FOREACH_SAFE(drv, &tpm_backends, list, next) {
+        QLIST_REMOVE(drv, list);
+        object_unref(OBJECT(drv));
+    }
+}
+
+/*
  * Walk the list of active TPM backends and collect information about them
  * following the schema description in qapi-schema.json.
  */
@@ -208,8 +208,9 @@ TPMInfoList *qmp_query_tpm(Error **errp)
             continue;
         }
         info = g_new0(TPMInfoList, 1);
+#ifdef CONFIG_TPM
         info->value = tpm_backend_query_tpm(drv);
-
+#endif
         if (!cur_item) {
             head = cur_item = info;
         } else {
-- 
2.7.6
