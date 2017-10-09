Received: from eggs.gnu.org ([2001:4830:134:3::10]:55219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gzv-0006e3-An
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:58:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gzu-0005Q6-HY
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:58:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1gzu-0005Pg-B9
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:58:06 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 00:56:10 +0200
Message-Id: <20171009225623.29232-30-marcandre.lureau@redhat.com>
In-Reply-To: <20171009225623.29232-1-marcandre.lureau@redhat.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 29/42] tpm-be: update optional function pointers
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
---
 include/sysemu/tpm_backend.h | 5 ++++-
 backends/tpm.c               | 9 +--------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index a893e586ae..594bb50782 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -66,15 +66,18 @@ struct TPMBackendClass {
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
2.14.1.146.gd35faa819
