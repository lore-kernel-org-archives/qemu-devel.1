Received: from eggs.gnu.org ([2001:4830:134:3::10]:36752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eCVc6-0000Z4-I3
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 14:02:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eCVc3-0000PL-Fx
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 14:02:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46434
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eCVc3-0000P5-9u
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 14:02:11 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA8J0DN7032118
	for <qemu-devel@nongnu.org>; Wed, 8 Nov 2017 14:02:08 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e45ptefn6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 14:02:07 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 8 Nov 2017 12:02:07 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed,  8 Nov 2017 14:01:55 -0500
In-Reply-To: <1510167719-4357-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510167719-4357-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1510167719-4357-2-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 1/5] tpm: Move getting TPM buffer size to
 backends
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

Rather than setting the size of the TPM buffer in the front-end,
query the backend for the size of the buffer. In this patch we
just move the hard-coded buffer size of 4096 to the backends.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 backends/tpm.c               |  7 +++++++
 hw/tpm/tpm_emulator.c        |  6 ++++++
 hw/tpm/tpm_passthrough.c     |  6 ++++++
 hw/tpm/tpm_tis.c             | 12 +++++++-----
 include/sysemu/tpm_backend.h | 12 ++++++++++++
 5 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/backends/tpm.c b/backends/tpm.c
index 7777467..cb49185 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -139,6 +139,13 @@ TPMVersion tpm_backend_get_tpm_version(TPMBackend *s)
     return k->get_tpm_version(s);
 }
 
+size_t tpm_backend_get_buffer_size(TPMBackend *s)
+{
+    TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
+
+    return k->get_buffer_size(s);
+}
+
 TPMInfo *tpm_backend_query_tpm(TPMBackend *s)
 {
     TPMInfo *info = g_new0(TPMInfo, 1);
diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 24cb611..44a769d 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -356,6 +356,11 @@ static TPMVersion tpm_emulator_get_tpm_version(TPMBackend *tb)
     return tpm_emu->tpm_version;
 }
 
+static size_t tpm_emulator_get_buffer_size(TPMBackend *tb)
+{
+    return 4096;
+}
+
 static int tpm_emulator_block_migration(TPMEmulator *tpm_emu)
 {
     Error *err = NULL;
@@ -556,6 +561,7 @@ static void tpm_emulator_class_init(ObjectClass *klass, void *data)
     tbc->get_tpm_established_flag = tpm_emulator_get_tpm_established_flag;
     tbc->reset_tpm_established_flag = tpm_emulator_reset_tpm_established_flag;
     tbc->get_tpm_version = tpm_emulator_get_tpm_version;
+    tbc->get_buffer_size = tpm_emulator_get_buffer_size;
     tbc->get_tpm_options = tpm_emulator_get_tpm_options;
 
     tbc->handle_request = tpm_emulator_handle_request;
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 73554aa..daac67d 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -199,6 +199,11 @@ static TPMVersion tpm_passthrough_get_tpm_version(TPMBackend *tb)
     return tpm_pt->tpm_version;
 }
 
+static size_t tpm_passthrough_get_buffer_size(TPMBackend *tb)
+{
+    return 4096;
+}
+
 /*
  * Unless path or file descriptor set has been provided by user,
  * determine the sysfs cancel file following kernel documentation
@@ -354,6 +359,7 @@ static void tpm_passthrough_class_init(ObjectClass *klass, void *data)
     tbc->reset_tpm_established_flag =
         tpm_passthrough_reset_tpm_established_flag;
     tbc->get_tpm_version = tpm_passthrough_get_tpm_version;
+    tbc->get_buffer_size = tpm_passthrough_get_buffer_size;
     tbc->get_tpm_options = tpm_passthrough_get_tpm_options;
     tbc->handle_request = tpm_passthrough_handle_request;
 }
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index cc32fcd..a1c8323 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -88,6 +88,8 @@ typedef struct TPMState {
 
     TPMBackend *be_driver;
     TPMVersion be_tpm_version;
+
+    size_t be_buffer_size;
 } TPMState;
 
 #define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS)
@@ -977,10 +979,9 @@ static int tpm_tis_do_startup_tpm(TPMState *s)
     return tpm_backend_startup_tpm(s->be_driver);
 }
 
-static void tpm_tis_realloc_buffer(TPMSizedBuffer *sb)
+static void tpm_tis_realloc_buffer(TPMSizedBuffer *sb,
+                                   size_t wanted_size)
 {
-    size_t wanted_size = 4096; /* Linux tpm.c buffer size */
-
     if (sb->size != wanted_size) {
         sb->buffer = g_realloc(sb->buffer, wanted_size);
         sb->size = wanted_size;
@@ -1007,6 +1008,7 @@ static void tpm_tis_reset(DeviceState *dev)
     int c;
 
     s->be_tpm_version = tpm_backend_get_tpm_version(s->be_driver);
+    s->be_buffer_size = tpm_backend_get_buffer_size(s->be_driver);
 
     tpm_backend_reset(s->be_driver);
 
@@ -1033,9 +1035,9 @@ static void tpm_tis_reset(DeviceState *dev)
         s->loc[c].state = TPM_TIS_STATE_IDLE;
 
         s->loc[c].w_offset = 0;
-        tpm_tis_realloc_buffer(&s->loc[c].w_buffer);
+        tpm_tis_realloc_buffer(&s->loc[c].w_buffer, s->be_buffer_size);
         s->loc[c].r_offset = 0;
-        tpm_tis_realloc_buffer(&s->loc[c].r_buffer);
+        tpm_tis_realloc_buffer(&s->loc[c].r_buffer, s->be_buffer_size);
     }
 
     tpm_tis_do_startup_tpm(s);
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 590e8b4..7c98b61 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -81,6 +81,8 @@ struct TPMBackendClass {
 
     TPMVersion (*get_tpm_version)(TPMBackend *t);
 
+    size_t (*get_buffer_size)(TPMBackend *t);
+
     TpmTypeOptions *(*get_tpm_options)(TPMBackend *t);
 
     void (*handle_request)(TPMBackend *s, TPMBackendCmd *cmd);
@@ -183,6 +185,16 @@ int tpm_backend_reset_tpm_established_flag(TPMBackend *s, uint8_t locty);
 TPMVersion tpm_backend_get_tpm_version(TPMBackend *s);
 
 /**
+ * tpm_backend_get_buffer_size:
+ * @s: the backend to call into
+ *
+ * Get the TPM's buffer size.
+ *
+ * Returns buffer size.
+ */
+size_t tpm_backend_get_buffer_size(TPMBackend *s);
+
+/**
  * tpm_backend_query_tpm:
  * @s: the backend
  *
-- 
2.5.5
