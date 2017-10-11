Received: from eggs.gnu.org ([2001:4830:134:3::10]:34244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e2OhP-0003Tb-IK
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 17:37:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e2OhK-0003dH-Lm
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 17:37:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58954
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e2OhK-0003d1-Fo
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 17:37:50 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9BLYY53068888
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 17:37:47 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dht8njn3y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 17:37:47 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 11 Oct 2017 17:37:46 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 11 Oct 2017 17:37:30 -0400
In-Reply-To: <1507757851-12580-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1507757851-12580-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1507757851-12580-4-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 3/4] tpm: Introduce condition in TPM
 backend for notification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com, marcandre.lureau@gmail.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

TPM backends will suspend independently of the frontends. Also
here we need to be able to wait for the TPM command to have been
completely processed.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 backends/tpm.c               | 16 ++++++++++++++++
 hw/tpm/tpm_emulator.c        |  3 +++
 include/sysemu/tpm_backend.h | 14 ++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/backends/tpm.c b/backends/tpm.c
index 37c84b7..334836b 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -52,10 +52,22 @@ int tpm_backend_init(TPMBackend *s, TPMState *state,
     s->tpm_state = state;
     s->recv_data_callback = datacb;
     s->had_startup_error = false;
+    s->tpm_busy = false;
+
+    qemu_mutex_init(&s->state_lock);
+    qemu_cond_init(&s->cmd_complete);
 
     return k->ops->init ? k->ops->init(s) : 0;
 }
 
+void tpm_backend_cmd_completed(TPMBackend *s)
+{
+    qemu_mutex_lock(&s->state_lock);
+    s->tpm_busy = false;
+    qemu_cond_signal(&s->cmd_complete);
+    qemu_mutex_unlock(&s->state_lock);
+}
+
 int tpm_backend_startup_tpm(TPMBackend *s)
 {
     int res = 0;
@@ -82,6 +94,10 @@ bool tpm_backend_had_startup_error(TPMBackend *s)
 
 void tpm_backend_deliver_request(TPMBackend *s)
 {
+    qemu_mutex_lock(&s->state_lock);
+    s->tpm_busy = true;
+    qemu_mutex_unlock(&s->state_lock);
+
     g_thread_pool_push(s->thread_pool, (gpointer)TPM_BACKEND_CMD_PROCESS_CMD,
                        NULL);
 }
diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 95e1e04..556b8c8 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -200,6 +200,9 @@ static void tpm_emulator_handle_request(TPMBackend *tb, TPMBackendCmd cmd)
         tb->recv_data_callback(tb->tpm_state, tb->tpm_state->locty_number,
                                selftest_done);
 
+        /* result delivered */
+        tpm_backend_cmd_completed(tb);
+
         break;
     case TPM_BACKEND_CMD_INIT:
     case TPM_BACKEND_CMD_END:
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 2c798a1..cdc4742 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -18,6 +18,7 @@
 #include "qapi-types.h"
 #include "qemu/option.h"
 #include "sysemu/tpm.h"
+#include "qemu/thread.h"
 
 #define TYPE_TPM_BACKEND "tpm-backend"
 #define TPM_BACKEND(obj) \
@@ -54,6 +55,10 @@ struct TPMBackend {
     enum TpmModel fe_model;
 
     QLIST_ENTRY(TPMBackend) list;
+
+    QemuMutex state_lock;
+    QemuCond cmd_complete; /* signaled once tpm_busy is false */
+    bool tpm_busy;
 };
 
 struct TPMBackendClass {
@@ -213,6 +218,15 @@ TPMVersion tpm_backend_get_tpm_version(TPMBackend *s);
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
 TPMBackend *qemu_find_tpm(const char *id);
 
 const TPMDriverOps *tpm_get_backend_driver(const char *type);
-- 
2.5.5
