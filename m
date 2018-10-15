Received: from eggs.gnu.org ([2001:4830:134:3::10]:39586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gC1RB-0004G9-5Z
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gC1R7-00028K-8S
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gC1R5-00021K-76
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:53:25 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 15 Oct 2018 13:53:03 +0200
Message-Id: <20181015115309.17089-30-armbru@redhat.com>
In-Reply-To: <20181015115309.17089-1-armbru@redhat.com>
References: <20181015115309.17089-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 29/35] tpm: Clean up error reporting in
 tpm_init_tpmdev()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>

Calling error_report() in a function that takes an Error ** argument
is suspicious.  tpm_init_tpmdev() does that, and then fails without
setting an error.  Its caller main(), via tpm_init() and
qemu_opts_foreach(), is fine with it, but clean it up anyway.

Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/sysemu/tpm.h |  2 +-
 stubs/tpm.c          |  3 +--
 tpm.c                | 22 +++++++++-------------
 vl.c                 |  4 +---
 4 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index 9ae1ab6da3..17a97ed77a 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -16,7 +16,7 @@
 #include "qom/object.h"
=20
 int tpm_config_parse(QemuOptsList *opts_list, const char *optarg);
-int tpm_init(void);
+void tpm_init(void);
 void tpm_cleanup(void);
=20
 typedef enum TPMVersion {
diff --git a/stubs/tpm.c b/stubs/tpm.c
index 6729bc8517..80939cd3db 100644
--- a/stubs/tpm.c
+++ b/stubs/tpm.c
@@ -9,9 +9,8 @@
 #include "qapi/qapi-commands-tpm.h"
 #include "sysemu/tpm.h"
=20
-int tpm_init(void)
+void tpm_init(void)
 {
-    return 0;
 }
=20
 void tpm_cleanup(void)
diff --git a/tpm.c b/tpm.c
index 93031723ad..9c9e20bbb7 100644
--- a/tpm.c
+++ b/tpm.c
@@ -89,19 +89,19 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *opt=
s, Error **errp)
     int i;
=20
     if (!QLIST_EMPTY(&tpm_backends)) {
-        error_report("Only one TPM is allowed.");
+        error_setg(errp, "Only one TPM is allowed.");
         return 1;
     }
=20
     id =3D qemu_opts_id(opts);
     if (id =3D=3D NULL) {
-        error_report(QERR_MISSING_PARAMETER, "id");
+        error_setg(errp, QERR_MISSING_PARAMETER, "id");
         return 1;
     }
=20
     value =3D qemu_opt_get(opts, "type");
     if (!value) {
-        error_report(QERR_MISSING_PARAMETER, "type");
+        error_setg(errp, QERR_MISSING_PARAMETER, "type");
         tpm_display_backend_drivers();
         return 1;
     }
@@ -109,8 +109,8 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *opt=
s, Error **errp)
     i =3D qapi_enum_parse(&TpmType_lookup, value, -1, NULL);
     be =3D i >=3D 0 ? tpm_be_find_by_type(i) : NULL;
     if (be =3D=3D NULL) {
-        error_report(QERR_INVALID_PARAMETER_VALUE,
-                     "type", "a TPM backend type");
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "type",
+                   "a TPM backend type");
         tpm_display_backend_drivers();
         return 1;
     }
@@ -118,7 +118,7 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *opt=
s, Error **errp)
     /* validate backend specific opts */
     qemu_opts_validate(opts, be->opts, &local_err);
     if (local_err) {
-        error_report_err(local_err);
+        error_propagate(errp, local_err);
         return 1;
     }
=20
@@ -151,14 +151,10 @@ void tpm_cleanup(void)
  * Initialize the TPM. Process the tpmdev command line options describin=
g the
  * TPM backend.
  */
-int tpm_init(void)
+void tpm_init(void)
 {
-    if (qemu_opts_foreach(qemu_find_opts("tpmdev"),
-                          tpm_init_tpmdev, NULL, NULL)) {
-        return -1;
-    }
-
-    return 0;
+    qemu_opts_foreach(qemu_find_opts("tpmdev"),
+                      tpm_init_tpmdev, NULL, &error_fatal);
 }
=20
 /*
diff --git a/vl.c b/vl.c
index 8e0006d49c..abfe991ed6 100644
--- a/vl.c
+++ b/vl.c
@@ -4359,9 +4359,7 @@ int main(int argc, char **argv, char **envp)
                       user_creatable_add_opts_foreach,
                       object_create_delayed, &error_fatal);
=20
-    if (tpm_init() < 0) {
-        exit(1);
-    }
+    tpm_init();
=20
     /* init the bluetooth world */
     if (foreach_device_config(DEV_BT, bt_parse))
--=20
2.17.1
