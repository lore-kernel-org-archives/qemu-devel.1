Received: from eggs.gnu.org ([2001:4830:134:3::10]:41249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNd-0005AE-47
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNZ-0005lD-9V
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1g9ZNY-0005j2-No
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:37 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  8 Oct 2018 19:31:20 +0200
Message-Id: <20181008173125.19678-27-armbru@redhat.com>
In-Reply-To: <20181008173125.19678-1-armbru@redhat.com>
References: <20181008173125.19678-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 26/31] tpm: Clean up error reporting in
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
 
 int tpm_config_parse(QemuOptsList *opts_list, const char *optarg);
-int tpm_init(void);
+void tpm_init(void);
 void tpm_cleanup(void);
 
 typedef enum TPMVersion {
diff --git a/stubs/tpm.c b/stubs/tpm.c
index 6729bc8517..80939cd3db 100644
--- a/stubs/tpm.c
+++ b/stubs/tpm.c
@@ -9,9 +9,8 @@
 #include "qapi/qapi-commands-tpm.h"
 #include "sysemu/tpm.h"
 
-int tpm_init(void)
+void tpm_init(void)
 {
-    return 0;
 }
 
 void tpm_cleanup(void)
diff --git a/tpm.c b/tpm.c
index 93031723ad..9c9e20bbb7 100644
--- a/tpm.c
+++ b/tpm.c
@@ -89,19 +89,19 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
     int i;
 
     if (!QLIST_EMPTY(&tpm_backends)) {
-        error_report("Only one TPM is allowed.");
+        error_setg(errp, "Only one TPM is allowed.");
         return 1;
     }
 
     id = qemu_opts_id(opts);
     if (id == NULL) {
-        error_report(QERR_MISSING_PARAMETER, "id");
+        error_setg(errp, QERR_MISSING_PARAMETER, "id");
         return 1;
     }
 
     value = qemu_opt_get(opts, "type");
     if (!value) {
-        error_report(QERR_MISSING_PARAMETER, "type");
+        error_setg(errp, QERR_MISSING_PARAMETER, "type");
         tpm_display_backend_drivers();
         return 1;
     }
@@ -109,8 +109,8 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
     i = qapi_enum_parse(&TpmType_lookup, value, -1, NULL);
     be = i >= 0 ? tpm_be_find_by_type(i) : NULL;
     if (be == NULL) {
-        error_report(QERR_INVALID_PARAMETER_VALUE,
-                     "type", "a TPM backend type");
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "type",
+                   "a TPM backend type");
         tpm_display_backend_drivers();
         return 1;
     }
@@ -118,7 +118,7 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
     /* validate backend specific opts */
     qemu_opts_validate(opts, be->opts, &local_err);
     if (local_err) {
-        error_report_err(local_err);
+        error_propagate(errp, local_err);
         return 1;
     }
 
@@ -151,14 +151,10 @@ void tpm_cleanup(void)
  * Initialize the TPM. Process the tpmdev command line options describing the
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
 
 /*
diff --git a/vl.c b/vl.c
index 5c159ca45c..b6f9212f09 100644
--- a/vl.c
+++ b/vl.c
@@ -4312,9 +4312,7 @@ int main(int argc, char **argv, char **envp)
                       user_creatable_add_opts_foreach,
                       object_create_delayed, &error_fatal);
 
-    if (tpm_init() < 0) {
-        exit(1);
-    }
+    tpm_init();
 
     /* init the bluetooth world */
     if (foreach_device_config(DEV_BT, bt_parse))
-- 
2.17.1
