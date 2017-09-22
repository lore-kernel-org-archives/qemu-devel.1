Received: from eggs.gnu.org ([2001:4830:134:3::10]:56392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1dvN8X-0000bS-Q6
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1dvN8U-0005q4-JA
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:32:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:27337)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1dvN8U-0005pe-9u
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:32:50 -0400
From: Amarnath Valluri <amarnath.valluri@intel.com>
Date: Fri, 22 Sep 2017 15:33:37 +0300
Message-Id: <1506083624-20621-2-git-send-email-amarnath.valluri@intel.com>
In-Reply-To: <1506083624-20621-1-git-send-email-amarnath.valluri@intel.com>
References: <1506083624-20621-1-git-send-email-amarnath.valluri@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 1/8] tpm-backend: Remove unneeded member
 variable from backend class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Amarnath Valluri <amarnath.valluri@intel.com>

TPMDriverOps inside TPMBackend is not required, as it is supposed to be a class
member. The only possible reason for keeping in TPMBackend was, to get the
backend type in tpm.c where dedicated backend api, tpm_backend_get_type() is
present.

Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_passthrough.c     | 4 ----
 include/sysemu/tpm_backend.h | 1 -
 tpm.c                        | 2 +-
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 9234eb3..a0baf5f 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -46,8 +46,6 @@
 #define TPM_PASSTHROUGH(obj) \
     OBJECT_CHECK(TPMPassthruState, (obj), TYPE_TPM_PASSTHROUGH)
 
-static const TPMDriverOps tpm_passthrough_driver;
-
 /* data structures */
 typedef struct TPMPassthruThreadParams {
     TPMState *tpm_state;
@@ -462,8 +460,6 @@ static TPMBackend *tpm_passthrough_create(QemuOpts *opts, const char *id)
     /* let frontend set the fe_model to proper value */
     tb->fe_model = -1;
 
-    tb->ops = &tpm_passthrough_driver;
-
     if (tpm_passthrough_handle_device_opts(opts, tb)) {
         goto err_exit;
     }
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index b0a9731..3708413 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -50,7 +50,6 @@ struct TPMBackend {
     enum TpmModel fe_model;
     char *path;
     char *cancel_path;
-    const TPMDriverOps *ops;
 
     QLIST_ENTRY(TPMBackend) list;
 };
diff --git a/tpm.c b/tpm.c
index 2d830d0..abedf3f 100644
--- a/tpm.c
+++ b/tpm.c
@@ -211,7 +211,7 @@ static TPMInfo *qmp_query_tpm_inst(TPMBackend *drv)
     res->model = drv->fe_model;
     res->options = g_new0(TpmTypeOptions, 1);
 
-    switch (drv->ops->type) {
+    switch (tpm_backend_get_type(drv)) {
     case TPM_TYPE_PASSTHROUGH:
         res->options->type = TPM_TYPE_OPTIONS_KIND_PASSTHROUGH;
         tpo = g_new0(TPMPassthroughOptions, 1);
-- 
2.7.4
