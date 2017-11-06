Received: from eggs.gnu.org ([2001:4830:134:3::10]:39464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmJu-0006xR-2M
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmJp-0004Yg-04
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eBmJo-0004Xe-Nz
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:20 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  6 Nov 2017 19:39:07 +0100
Message-Id: <20171106183925.16747-11-marcandre.lureau@redhat.com>
In-Reply-To: <20171106183925.16747-1-marcandre.lureau@redhat.com>
References: <20171106183925.16747-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 10/28] tpm-be: update optional function
 pointers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com, stefanb@linux.vnet.ibm.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

QEMU code doesn't generally have assert() for mandatory
callbacks/function pointers, probably because the crash is pretty
obvious. Document the methods instead of going into the code.

Make get_tpm_options() mandatory to implement (since all
backend implementation have it).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 include/sysemu/tpm_backend.h | 5 ++++-
 backends/tpm.c               | 9 +--------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 904e5b1026..ce8dee58cf 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -65,15 +65,18 @@ struct TPMBackendClass {
=20
     TPMBackend *(*create)(QemuOpts *opts, const char *id);
=20
-    /* start up the TPM on the backend */
+    /* start up the TPM on the backend - optional */
     int (*startup_tpm)(TPMBackend *t);
=20
+    /* optional */
     void (*reset)(TPMBackend *t);
=20
     void (*cancel_cmd)(TPMBackend *t);
=20
+    /* optional */
     bool (*get_tpm_established_flag)(TPMBackend *t);
=20
+    /* optional */
     int (*reset_tpm_established_flag)(TPMBackend *t, uint8_t locty);
=20
     TPMVersion (*get_tpm_version)(TPMBackend *t);
diff --git a/backends/tpm.c b/backends/tpm.c
index 7e636fbc7a..7777467c44 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -33,7 +33,6 @@ static void tpm_backend_worker_thread(gpointer data, gp=
ointer user_data)
     TPMBackend *s =3D TPM_BACKEND(user_data);
     TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
=20
-    assert(k->handle_request !=3D NULL);
     k->handle_request(s, (TPMBackendCmd *)data);
=20
     qemu_bh_schedule(s->bh);
@@ -114,8 +113,6 @@ void tpm_backend_cancel_cmd(TPMBackend *s)
 {
     TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
=20
-    assert(k->cancel_cmd);
-
     k->cancel_cmd(s);
 }
=20
@@ -139,8 +136,6 @@ TPMVersion tpm_backend_get_tpm_version(TPMBackend *s)
 {
     TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
=20
-    assert(k->get_tpm_version);
-
     return k->get_tpm_version(s);
 }
=20
@@ -152,9 +147,7 @@ TPMInfo *tpm_backend_query_tpm(TPMBackend *s)
=20
     info->id =3D g_strdup(s->id);
     info->model =3D tic->model;
-    if (k->get_tpm_options) {
-        info->options =3D k->get_tpm_options(s);
-    }
+    info->options =3D k->get_tpm_options(s);
=20
     return info;
 }
--=20
2.15.0.rc0.40.gaefcc5f6f
