Received: from eggs.gnu.org ([2001:4830:134:3::10]:40044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e8Dee-0002f6-UA
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 19:03:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e8DeY-0003wT-S9
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 19:03:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56922
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e8DeY-0003vh-Jo
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 19:03:02 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9RMwlUk034069
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 19:02:56 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dv8bdnvvm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 19:02:55 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 27 Oct 2017 19:02:55 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 27 Oct 2017 19:02:37 -0400
In-Reply-To: <1509145361-11218-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1509145361-11218-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1509145361-11218-4-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 3/7] tpm: implement
 tpm_backend_wait_cmd_completed
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

Implement tpm_backend_wait_cmd_completed to synchronize with the
backend (thread) for the completion of a command.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 backends/tpm.c               | 10 ++++++++++
 include/sysemu/tpm_backend.h |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/backends/tpm.c b/backends/tpm.c
index 2f60166..6e26832 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -28,6 +28,16 @@ void tpm_backend_cmd_completed(TPMBackend *s)
     qemu_mutex_unlock(&s->state_lock);
 }
 
+void tpm_backend_wait_cmd_completed(TPMBackend *s)
+{
+    qemu_mutex_lock(&s->state_lock);
+
+    if (s->tpm_busy) {
+        qemu_cond_wait(&s->cmd_complete, &s->state_lock);
+    }
+    qemu_mutex_unlock(&s->state_lock);
+}
+
 static void tpm_backend_request_completed_bh(void *opaque)
 {
     TPMBackend *s = TPM_BACKEND(opaque);
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index e08c51d..8c271f4 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -207,6 +207,14 @@ TPMInfo *tpm_backend_query_tpm(TPMBackend *s);
  */
 void tpm_backend_cmd_completed(TPMBackend *s);
 
+/**
+ * tpm_backend_wait_cmd_completed:
+ * @s: the backend
+ *
+ * Wait the backend to not be busy anymore
+ */
+void tpm_backend_wait_cmd_completed(TPMBackend *s);
+
 TPMBackend *qemu_find_tpm_be(const char *id);
 
 void tpm_register_model(enum TpmModel model);
-- 
2.5.5
