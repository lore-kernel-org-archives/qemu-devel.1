Received: from eggs.gnu.org ([2001:4830:134:3::10]:36250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5FAP-0007QC-1D
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5FAK-0007Ox-S7
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e5FAK-0007NS-IH
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:32 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9JI0Tsc105518
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:03:28 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dq0xbg6ub-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:03:28 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 19 Oct 2017 14:03:27 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 19 Oct 2017 14:02:38 -0400
In-Reply-To: <1508436175-1596-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1508436175-1596-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1508436175-1596-5-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 04/21] tpm: lookup tpm backend class in
 tpm_driver_find_by_type()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, marcandre.lureau@gmail.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

One step towards removing TPMDriverOps and driver registration.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 tpm.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/tpm.c b/tpm.c
index bc7d747..04de8da 100644
--- a/tpm.c
+++ b/tpm.c
@@ -47,6 +47,24 @@ void tpm_register_driver(const TPMDriverOps *tdo)
     be_drivers[tdo->type] =3D tdo;
 }
=20
+static const TPMDriverOps *
+tpm_driver_find_by_type(enum TpmType type)
+{
+    ObjectClass *oc;
+    TPMBackendClass *bc;
+    char *typename =3D g_strdup_printf("tpm-%s", TpmType_str(type));
+
+    oc =3D object_class_by_name(typename);
+    g_free(typename);
+
+    if (!object_class_dynamic_cast(oc, TYPE_TPM_BACKEND)) {
+        return NULL;
+    }
+
+    bc =3D TPM_BACKEND_CLASS(oc);
+    return bc->ops;
+}
+
 /*
  * Walk the list of available TPM backend drivers and display them on th=
e
  * screen.
@@ -58,11 +76,11 @@ static void tpm_display_backend_drivers(void)
     fprintf(stderr, "Supported TPM types (choose only one):\n");
=20
     for (i =3D 0; i < TPM_TYPE__MAX; i++) {
-        if (be_drivers[i] =3D=3D NULL) {
+        const TPMDriverOps *ops =3D tpm_driver_find_by_type(i);
+        if (!ops) {
             continue;
         }
-        fprintf(stderr, "%12s   %s\n",
-                TpmType_str(i), be_drivers[i]->desc);
+        fprintf(stderr, "%12s   %s\n", TpmType_str(i), ops->desc);
     }
     fprintf(stderr, "\n");
 }
@@ -196,11 +214,6 @@ int tpm_config_parse(QemuOptsList *opts_list, const =
char *optarg)
=20
 #endif /* CONFIG_TPM */
=20
-static const TPMDriverOps *tpm_driver_find_by_type(enum TpmType type)
-{
-    return be_drivers[type];
-}
-
 /*
  * Walk the list of active TPM backends and collect information about th=
em
  * following the schema description in qapi-schema.json.
--=20
2.5.5
