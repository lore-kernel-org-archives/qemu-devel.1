Received: from eggs.gnu.org ([2001:4830:134:3::10]:48399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCe-0001Tk-0P
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCb-0005kE-8C
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53635
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCa-0005jW-Va
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:21 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0E9w6081539
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:20 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmurncru1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:20 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:16:19 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:24 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-50-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 49/79] tests: check-qom-proplist: add checks
 for cmdline-created objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Daniel Berrange <berrange@redhat.com>

check-qom-proplist originally added tests for verifying that
object-creation helpers object_new_with_{props,propv} behaved in
similar fashion to the "traditional" method involving setting each
individual property separately after object creation rather than
via a single call.

Another similar "helper" for creating Objects exists in the form of
objects specified via -object command-line parameters. By that
rationale, we extend check-qom-proplist to include similar checks
for command-line-created objects by employing the same
qemu_opts_parse()-based parsing the vl.c employs.

This parser has a side-effect of parsing the object's options into
a QemuOpt structure and registering this in the global QemuOptsList
using the Object's ID. This can conflict with future Object instances
that attempt to use the same ID if we don't ensure this is cleaned
up as part of Object finalization, so we include a FIXME stub to test
for this case, which will then be resolved in a subsequent patch.

Suggested-by: Daniel Berrange <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Daniel Berrange <berrange@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1496531612-22166-2-git-send-email-mdroth@linux.vnet.ibm.com>
[Comment formatting tidied up]
Signed-off-by: Markus Armbruster <armbru@redhat.com>

(cherry picked from commit a1af255f065ccf3f47a7bfe88f1dbc9eeca36935)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/check-qom-proplist.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
index a16cefc..e3b3ae4 100644
--- a/tests/check-qom-proplist.c
+++ b/tests/check-qom-proplist.c
@@ -23,6 +23,9 @@
 #include "qapi/error.h"
 #include "qom/object.h"
 #include "qemu/module.h"
+#include "qemu/option.h"
+#include "qemu/config-file.h"
+#include "qom/object_interfaces.h"
 
 
 #define TYPE_DUMMY "qemu-dummy"
@@ -162,6 +165,10 @@ static const TypeInfo dummy_info = {
     .instance_finalize = dummy_finalize,
     .class_size = sizeof(DummyObjectClass),
     .class_init = dummy_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_USER_CREATABLE },
+        { }
+    }
 };
 
 
@@ -320,6 +327,14 @@ static const TypeInfo dummy_backend_info = {
     .class_size = sizeof(DummyBackendClass),
 };
 
+static QemuOptsList qemu_object_opts = {
+    .name = "object",
+    .implied_opt_name = "qom-type",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_object_opts.head),
+    .desc = {
+        { }
+    },
+};
 
 
 static void test_dummy_createv(void)
@@ -388,6 +403,46 @@ static void test_dummy_createlist(void)
     object_unparent(OBJECT(dobj));
 }
 
+static void test_dummy_createcmdl(void)
+{
+    QemuOpts *opts;
+    DummyObject *dobj;
+    Error *err = NULL;
+    const char *params = TYPE_DUMMY \
+                         ",id=dev0," \
+                         "bv=yes,sv=Hiss hiss hiss,av=platypus";
+
+    qemu_add_opts(&qemu_object_opts);
+    opts = qemu_opts_parse(&qemu_object_opts, params, true, &err);
+    g_assert(err == NULL);
+    g_assert(opts);
+
+    dobj = DUMMY_OBJECT(user_creatable_add_opts(opts, &err));
+    g_assert(err == NULL);
+    g_assert(dobj);
+    g_assert_cmpstr(dobj->sv, ==, "Hiss hiss hiss");
+    g_assert(dobj->bv == true);
+    g_assert(dobj->av == DUMMY_PLATYPUS);
+
+    user_creatable_del("dev0", &err);
+    g_assert(err == NULL);
+    error_free(err);
+
+    /*
+     * cmdline-parsing via qemu_opts_parse() results in a QemuOpts entry
+     * corresponding to the Object's ID to be added to the QemuOptsList
+     * for objects. To avoid having this entry conflict with future
+     * Objects using the same ID (which can happen in cases where
+     * qemu_opts_parse() is used to parse the object params, such as
+     * with hmp_object_add() at the time of this comment), we need to
+     * check for this in user_creatable_del() and remove the QemuOpts if
+     * it is present.
+     *
+     * FIXME: add an assert to verify that the QemuOpts is cleaned up
+     * once the corresponding cleanup code is added.
+     */
+}
+
 static void test_dummy_badenum(void)
 {
     Error *err = NULL;
@@ -525,6 +580,7 @@ int main(int argc, char **argv)
 
     g_test_add_func("/qom/proplist/createlist", test_dummy_createlist);
     g_test_add_func("/qom/proplist/createv", test_dummy_createv);
+    g_test_add_func("/qom/proplist/createcmdline", test_dummy_createcmdl);
     g_test_add_func("/qom/proplist/badenum", test_dummy_badenum);
     g_test_add_func("/qom/proplist/getenum", test_dummy_getenum);
     g_test_add_func("/qom/proplist/iterator", test_dummy_iterator);
-- 
2.7.4
