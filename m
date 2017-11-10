Received: from eggs.gnu.org ([2001:4830:134:3::10]:33103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eDA2i-00040J-F9
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eDA2c-00058C-Bd
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eDA2c-00055d-1u
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:18 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAAEAq86017688
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 09:12:17 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e5bafy5vf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 09:12:16 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 10 Nov 2017 07:12:15 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 10 Nov 2017 09:11:49 -0500
In-Reply-To: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1510323112-2207-11-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 10/13] tpm: Introduce condition in TPM
 backend for notification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, marcandre.lureau@redhat.com
Cc: amarnath.valluri@intel.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

TPM backends will suspend independently of the frontends. Also
here we need to be able to wait for the TPM command to have been
completely processed.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 backends/tpm.c               | 19 +++++++++++++++++++
 include/sysemu/tpm_backend.h | 14 ++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/backends/tpm.c b/backends/tpm.c
index 91222c5..bf0e120 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -20,6 +20,14 @@
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
 
+void tpm_backend_cmd_completed(TPMBackend *s)
+{
+    qemu_mutex_lock(&s->state_lock);
+    s->tpm_busy = false;
+    qemu_cond_signal(&s->cmd_complete);
+    qemu_mutex_unlock(&s->state_lock);
+}
+
 static void tpm_backend_request_completed_bh(void *opaque)
 {
     TPMBackend *s = TPM_BACKEND(opaque);
@@ -36,6 +44,9 @@ static void tpm_backend_worker_thread(gpointer data, gpointer user_data)
     k->handle_request(s, (TPMBackendCmd *)data);
 
     qemu_bh_schedule(s->bh);
+
+    /* result delivered */
+    tpm_backend_cmd_completed(s);
 }
 
 static void tpm_backend_thread_end(TPMBackend *s)
@@ -64,6 +75,10 @@ int tpm_backend_init(TPMBackend *s, TPMIf *tpmif, Error **errp)
     object_ref(OBJECT(tpmif));
 
     s->had_startup_error = false;
+    s->tpm_busy = false;
+
+    qemu_mutex_init(&s->state_lock);
+    qemu_cond_init(&s->cmd_complete);
 
     return 0;
 }
@@ -93,6 +108,10 @@ bool tpm_backend_had_startup_error(TPMBackend *s)
 
 void tpm_backend_deliver_request(TPMBackend *s, TPMBackendCmd *cmd)
 {
+    qemu_mutex_lock(&s->state_lock);
+    s->tpm_busy = true;
+    qemu_mutex_unlock(&s->state_lock);
+
     g_thread_pool_push(s->thread_pool, cmd, NULL);
 }
 
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 0d6c994..39598e3 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -18,6 +18,7 @@
 #include "qapi-types.h"
 #include "qemu/option.h"
 #include "sysemu/tpm.h"
+#include "qemu/thread.h"
 
 #define TYPE_TPM_BACKEND "tpm-backend"
 #define TPM_BACKEND(obj) \
@@ -53,6 +54,10 @@ struct TPMBackend {
     char *id;
 
     QLIST_ENTRY(TPMBackend) list;
+
+    QemuMutex state_lock;
+    QemuCond cmd_complete; /* signaled once tpm_busy is false */
+    bool tpm_busy;
 };
 
 struct TPMBackendClass {
@@ -206,6 +211,15 @@ size_t tpm_backend_get_buffer_size(TPMBackend *s);
  */
 TPMInfo *tpm_backend_query_tpm(TPMBackend *s);
 
+/**
+ * tpm_backend_cmd_completed:
+ * @s: the backend
+ *
+ * Mark the backend as not busy and notify anyone interested
+ * in the state changed
+ */
+void tpm_backend_cmd_completed(TPMBackend *s);
+
 TPMBackend *qemu_find_tpm_be(const char *id);
 
 #endif
-- 
2.5.5
