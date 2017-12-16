Received: from eggs.gnu.org ([2001:4830:134:3::10]:46127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGU4-0006Pu-2y
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGU0-0000Ku-8u
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eQGTz-0000Ka-Vw
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:44 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBGHdZNC135219
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:43 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ew0hhb4fk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:42 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sat, 16 Dec 2017 10:42:42 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sat, 16 Dec 2017 12:41:45 -0500
In-Reply-To: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1513446109-9013-29-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 28/32] tpm: Move getting TPM buffer size to
 backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>

Rather than setting the size of the TPM buffer in the front-end,
query the backend for the size of the buffer. In this patch we
just move the hard-coded buffer size of 4096 to the backends.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
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
@@ -139,6 +139,13 @@ TPMVersion tpm_backend_get_tpm_version(TPMBackend *s=
)
     return k->get_tpm_version(s);
 }
=20
+size_t tpm_backend_get_buffer_size(TPMBackend *s)
+{
+    TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
+
+    return k->get_buffer_size(s);
+}
+
 TPMInfo *tpm_backend_query_tpm(TPMBackend *s)
 {
     TPMInfo *info =3D g_new0(TPMInfo, 1);
diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 24cb611..44a769d 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -356,6 +356,11 @@ static TPMVersion tpm_emulator_get_tpm_version(TPMBa=
ckend *tb)
     return tpm_emu->tpm_version;
 }
=20
+static size_t tpm_emulator_get_buffer_size(TPMBackend *tb)
+{
+    return 4096;
+}
+
 static int tpm_emulator_block_migration(TPMEmulator *tpm_emu)
 {
     Error *err =3D NULL;
@@ -556,6 +561,7 @@ static void tpm_emulator_class_init(ObjectClass *klas=
s, void *data)
     tbc->get_tpm_established_flag =3D tpm_emulator_get_tpm_established_f=
lag;
     tbc->reset_tpm_established_flag =3D tpm_emulator_reset_tpm_establish=
ed_flag;
     tbc->get_tpm_version =3D tpm_emulator_get_tpm_version;
+    tbc->get_buffer_size =3D tpm_emulator_get_buffer_size;
     tbc->get_tpm_options =3D tpm_emulator_get_tpm_options;
=20
     tbc->handle_request =3D tpm_emulator_handle_request;
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 73554aa..daac67d 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -199,6 +199,11 @@ static TPMVersion tpm_passthrough_get_tpm_version(TP=
MBackend *tb)
     return tpm_pt->tpm_version;
 }
=20
+static size_t tpm_passthrough_get_buffer_size(TPMBackend *tb)
+{
+    return 4096;
+}
+
 /*
  * Unless path or file descriptor set has been provided by user,
  * determine the sysfs cancel file following kernel documentation
@@ -354,6 +359,7 @@ static void tpm_passthrough_class_init(ObjectClass *k=
lass, void *data)
     tbc->reset_tpm_established_flag =3D
         tpm_passthrough_reset_tpm_established_flag;
     tbc->get_tpm_version =3D tpm_passthrough_get_tpm_version;
+    tbc->get_buffer_size =3D tpm_passthrough_get_buffer_size;
     tbc->get_tpm_options =3D tpm_passthrough_get_tpm_options;
     tbc->handle_request =3D tpm_passthrough_handle_request;
 }
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 98c11a4..bd22e69 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -88,6 +88,8 @@ typedef struct TPMState {
=20
     TPMBackend *be_driver;
     TPMVersion be_tpm_version;
+
+    size_t be_buffer_size;
 } TPMState;
=20
 #define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS)
@@ -977,10 +979,9 @@ static int tpm_tis_do_startup_tpm(TPMState *s)
     return tpm_backend_startup_tpm(s->be_driver);
 }
=20
-static void tpm_tis_realloc_buffer(TPMSizedBuffer *sb)
+static void tpm_tis_realloc_buffer(TPMSizedBuffer *sb,
+                                   size_t wanted_size)
 {
-    size_t wanted_size =3D 4096; /* Linux tpm.c buffer size */
-
     if (sb->size !=3D wanted_size) {
         sb->buffer =3D g_realloc(sb->buffer, wanted_size);
         sb->size =3D wanted_size;
@@ -1011,6 +1012,7 @@ static void tpm_tis_reset(DeviceState *dev)
     int c;
=20
     s->be_tpm_version =3D tpm_backend_get_tpm_version(s->be_driver);
+    s->be_buffer_size =3D tpm_backend_get_buffer_size(s->be_driver);
=20
     tpm_backend_reset(s->be_driver);
=20
@@ -1037,9 +1039,9 @@ static void tpm_tis_reset(DeviceState *dev)
         s->loc[c].state =3D TPM_TIS_STATE_IDLE;
=20
         s->loc[c].w_offset =3D 0;
-        tpm_tis_realloc_buffer(&s->loc[c].w_buffer);
+        tpm_tis_realloc_buffer(&s->loc[c].w_buffer, s->be_buffer_size);
         s->loc[c].r_offset =3D 0;
-        tpm_tis_realloc_buffer(&s->loc[c].r_buffer);
+        tpm_tis_realloc_buffer(&s->loc[c].r_buffer, s->be_buffer_size);
     }
=20
     tpm_tis_do_startup_tpm(s);
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 590e8b4..7c98b61 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -81,6 +81,8 @@ struct TPMBackendClass {
=20
     TPMVersion (*get_tpm_version)(TPMBackend *t);
=20
+    size_t (*get_buffer_size)(TPMBackend *t);
+
     TpmTypeOptions *(*get_tpm_options)(TPMBackend *t);
=20
     void (*handle_request)(TPMBackend *s, TPMBackendCmd *cmd);
@@ -183,6 +185,16 @@ int tpm_backend_reset_tpm_established_flag(TPMBacken=
d *s, uint8_t locty);
 TPMVersion tpm_backend_get_tpm_version(TPMBackend *s);
=20
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
--=20
2.5.5
