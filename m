Received: from eggs.gnu.org ([2001:4830:134:3::10]:50618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e2yPB-0007Lz-Aq
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 07:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e2yP8-0002ti-Dy
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 07:45:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e2yP8-0002t8-46
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 07:45:26 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9DBhm69080234
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 07:45:22 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2djtvbfjed-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 07:45:21 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 13 Oct 2017 07:45:20 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 13 Oct 2017 07:44:56 -0400
In-Reply-To: <1507895100-26457-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1507895100-26457-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1507895100-26457-8-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v3 07/11] tpm-backend: Move realloc_buffer()
 implementation to tpm-tis model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, amarnath.valluri@intel.com, marcandre.lureau@gmail.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Amarnath Valluri <amarnath.valluri@intel.com>

buffer reallocation is very unlikely to be backend specific. Hence move i=
nside
the tis.

Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 backends/tpm.c               |  9 ---------
 hw/tpm/tpm_passthrough.c     | 12 ------------
 hw/tpm/tpm_tis.c             | 14 ++++++++++++--
 include/sysemu/tpm_backend.h | 12 ------------
 4 files changed, 12 insertions(+), 35 deletions(-)

diff --git a/backends/tpm.c b/backends/tpm.c
index de313c9..37c84b7 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -80,15 +80,6 @@ bool tpm_backend_had_startup_error(TPMBackend *s)
     return s->had_startup_error;
 }
=20
-size_t tpm_backend_realloc_buffer(TPMBackend *s, TPMSizedBuffer *sb)
-{
-    TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
-
-    assert(k->ops->realloc_buffer);
-
-    return k->ops->realloc_buffer(sb);
-}
-
 void tpm_backend_deliver_request(TPMBackend *s)
 {
     g_thread_pool_push(s->thread_pool, (gpointer)TPM_BACKEND_CMD_PROCESS=
_CMD,
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 84fc49a..22d3460 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -247,17 +247,6 @@ static int tpm_passthrough_reset_tpm_established_fla=
g(TPMBackend *tb,
     return 0;
 }
=20
-static size_t tpm_passthrough_realloc_buffer(TPMSizedBuffer *sb)
-{
-    size_t wanted_size =3D 4096; /* Linux tpm.c buffer size */
-
-    if (sb->size !=3D wanted_size) {
-        sb->buffer =3D g_realloc(sb->buffer, wanted_size);
-        sb->size =3D wanted_size;
-    }
-    return sb->size;
-}
-
 static void tpm_passthrough_cancel_cmd(TPMBackend *tb)
 {
     TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
@@ -435,7 +424,6 @@ static const TPMDriverOps tpm_passthrough_driver =3D =
{
     .opts                     =3D tpm_passthrough_cmdline_opts,
     .desc                     =3D "Passthrough TPM backend driver",
     .create                   =3D tpm_passthrough_create,
-    .realloc_buffer           =3D tpm_passthrough_realloc_buffer,
     .reset                    =3D tpm_passthrough_reset,
     .cancel_cmd               =3D tpm_passthrough_cancel_cmd,
     .get_tpm_established_flag =3D tpm_passthrough_get_tpm_established_fl=
ag,
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index a6440fe..d5118e7 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -963,6 +963,16 @@ static int tpm_tis_do_startup_tpm(TPMState *s)
     return tpm_backend_startup_tpm(s->be_driver);
 }
=20
+static void tpm_tis_realloc_buffer(TPMSizedBuffer *sb)
+{
+    size_t wanted_size =3D 4096; /* Linux tpm.c buffer size */
+
+    if (sb->size !=3D wanted_size) {
+        sb->buffer =3D g_realloc(sb->buffer, wanted_size);
+        sb->size =3D wanted_size;
+    }
+}
+
 /*
  * Get the TPMVersion of the backend device being used
  */
@@ -1010,9 +1020,9 @@ static void tpm_tis_reset(DeviceState *dev)
         tis->loc[c].state =3D TPM_TIS_STATE_IDLE;
=20
         tis->loc[c].w_offset =3D 0;
-        tpm_backend_realloc_buffer(s->be_driver, &tis->loc[c].w_buffer);
+        tpm_tis_realloc_buffer(&tis->loc[c].w_buffer);
         tis->loc[c].r_offset =3D 0;
-        tpm_backend_realloc_buffer(s->be_driver, &tis->loc[c].r_buffer);
+        tpm_tis_realloc_buffer(&tis->loc[c].r_buffer);
     }
=20
     tpm_tis_do_startup_tpm(s);
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index e96c191..2c798a1 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -84,8 +84,6 @@ struct TPMDriverOps {
     /* start up the TPM on the backend */
     int (*startup_tpm)(TPMBackend *t);
=20
-    size_t (*realloc_buffer)(TPMSizedBuffer *sb);
-
     void (*reset)(TPMBackend *t);
=20
     void (*cancel_cmd)(TPMBackend *t);
@@ -140,16 +138,6 @@ int tpm_backend_startup_tpm(TPMBackend *s);
 bool tpm_backend_had_startup_error(TPMBackend *s);
=20
 /**
- * tpm_backend_realloc_buffer:
- * @s: the backend
- * @sb: the TPMSizedBuffer to re-allocated to the size suitable for the
- *      backend.
- *
- * This function returns the size of the allocated buffer
- */
-size_t tpm_backend_realloc_buffer(TPMBackend *s, TPMSizedBuffer *sb);
-
-/**
  * tpm_backend_deliver_request:
  * @s: the backend to send the request to
  *
--=20
2.5.5
