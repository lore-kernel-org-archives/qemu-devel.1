Received: from eggs.gnu.org ([2001:4830:134:3::10]:33151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eDA2m-00044w-UP
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eDA2f-0005FM-7z
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54496
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eDA2f-0005EC-2q
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:21 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAAE9tFt076779
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 09:12:20 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e59kjkmyw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 09:12:19 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 10 Nov 2017 07:12:18 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 10 Nov 2017 09:11:50 -0500
In-Reply-To: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1510323112-2207-12-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 11/13] tpm: implement
 tpm_backend_wait_cmd_completed
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

Implement tpm_backend_wait_cmd_completed to synchronize with the
backend (thread) for the completion of a command.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 backends/tpm.c               | 10 ++++++++++
 include/sysemu/tpm_backend.h |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/backends/tpm.c b/backends/tpm.c
index bf0e120..5e4de27 100644
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
index 39598e3..1170cb9 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -220,6 +220,14 @@ TPMInfo *tpm_backend_query_tpm(TPMBackend *s);
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
 
 #endif
-- 
2.5.5
