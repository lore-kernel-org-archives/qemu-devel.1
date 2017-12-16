Received: from eggs.gnu.org ([2001:4830:134:3::10]:45891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTe-0005xS-2b
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTa-0008NN-6J
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eQGTZ-0008Me-TE
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:18 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBGHdbEV118520
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:14 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ew0wn2j6m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:14 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sat, 16 Dec 2017 10:42:13 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sat, 16 Dec 2017 12:41:27 -0500
In-Reply-To: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1513446109-9013-11-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 10/32] tpm-be: update optional function
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
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

QEMU code doesn't generally have assert() for mandatory
callbacks/function pointers, probably because the crash is pretty
obvious. Document the methods instead of going into the code.

Make get_tpm_options() mandatory to implement (since all
backend implementation have it).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 backends/tpm.c               | 9 +--------
 include/sysemu/tpm_backend.h | 5 ++++-
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/backends/tpm.c b/backends/tpm.c
index 7e636fb..7777467 100644
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
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 904e5b1..ce8dee5 100644
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
--=20
2.5.5
