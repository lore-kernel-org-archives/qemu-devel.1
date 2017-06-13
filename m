Received: from eggs.gnu.org ([2001:4830:134:3::10]:50880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKp4X-0004RG-Tn
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKp4X-0000SY-1v
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dKp4W-0000SE-QK
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:41 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 13 Jun 2017 13:53:09 -0300
Message-Id: <20170613165313.20954-12-ehabkost@redhat.com>
In-Reply-To: <20170613165313.20954-1-ehabkost@redhat.com>
References: <20170613165313.20954-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 11/15] Manual changes to use ERR_IS_* macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Change code that was missed by the Coccinelle patch for some reason.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/qdev-properties.c | 2 +-
 hw/mem/pc-dimm.c          | 2 +-
 migration/rdma.c          | 2 +-
 util/error.c              | 4 ++--
 util/qemu-option.c        | 6 +++---
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 9f1a497322..65ba36f4fb 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1107,7 +1107,7 @@ static void qdev_prop_set_globals_for_type(DeviceState *dev,
         if (err != NULL) {
             error_prepend(&err, "can't apply global %s.%s=%s: ",
                           prop->driver, prop->property, prop->value);
-            if (!dev->hotplugged && prop->errp) {
+            if (!dev->hotplugged && !ERR_IS_IGNORED(prop->errp)) {
                 error_propagate(prop->errp, err);
             } else {
                 assert(prop->user_provided);
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 4e5e2c9339..13f43ab658 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -139,7 +139,7 @@ static int pc_existing_dimms_capacity_internal(Object *obj, void *opaque)
                 cap->errp);
         }
 
-        if (cap->errp && *cap->errp) {
+        if (!ERR_IS_IGNORED(cap->errp) && ERR_IS_SET(cap->errp)) {
             return 1;
         }
     }
diff --git a/migration/rdma.c b/migration/rdma.c
index a33edbf29b..c6078bf51b 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -39,7 +39,7 @@
 #define ERROR(errp, fmt, ...) \
     do { \
         fprintf(stderr, "RDMA ERROR: " fmt "\n", ## __VA_ARGS__); \
-        if (errp && (*(errp) == NULL)) { \
+        if (!ERR_IS_IGNORED(errp) && !ERR_IS_SET(errp)) { \
             error_setg(errp, "RDMA ERROR: " fmt, ## __VA_ARGS__); \
         } \
     } while (0)
diff --git a/util/error.c b/util/error.c
index a1d998646a..4e804287eb 100644
--- a/util/error.c
+++ b/util/error.c
@@ -255,7 +255,7 @@ void error_free(Error *err)
 
 void error_free_or_abort(Error **errp)
 {
-    assert(errp && *errp);
+    assert(!ERR_IS_IGNORED(errp) && ERR_IS_SET(errp));
     error_free(*errp);
     *errp = NULL;
 }
@@ -266,7 +266,7 @@ void error_propagate(Error **dst_errp, Error *local_err)
         return;
     }
     error_handle_fatal(dst_errp, local_err);
-    if (dst_errp && !*dst_errp) {
+    if (!ERR_IS_IGNORED(dst_errp) && !ERR_IS_SET(dst_errp)) {
         *dst_errp = local_err;
     } else {
         error_free(local_err);
diff --git a/util/qemu-option.c b/util/qemu-option.c
index a7e62593b1..5f1c7af1c6 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -617,7 +617,7 @@ int qemu_opt_foreach(QemuOpts *opts, qemu_opt_loopfunc func, void *opaque,
         if (rc) {
             return rc;
         }
-        assert(!errp || !*errp);
+        assert(!ERR_IS_SET(errp));
     }
     return 0;
 }
@@ -945,7 +945,7 @@ static void qemu_opts_from_qdict_1(const char *key, QObject *obj, void *opaque)
     const char *value;
     int n;
 
-    if (!strcmp(key, "id") || *state->errp) {
+    if (!strcmp(key, "id") || ERR_IS_SET(state->errp)) {
         return;
     }
 
@@ -1113,7 +1113,7 @@ int qemu_opts_foreach(QemuOptsList *list, qemu_opts_loopfunc func,
         if (rc) {
             break;
         }
-        assert(!errp || !*errp);
+        assert(!ERR_IS_SET(errp));
     }
     loc_pop(&loc);
     return rc;
-- 
2.11.0.259.g40922b1
