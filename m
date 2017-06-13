Received: from eggs.gnu.org ([2001:4830:134:3::10]:50914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKp4Z-0004TA-Ta
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKp4Y-0000TD-Vr
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dKp4Y-0000Sm-Ml
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:42 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 13 Jun 2017 13:53:10 -0300
Message-Id: <20170613165313.20954-13-ehabkost@redhat.com>
In-Reply-To: <20170613165313.20954-1-ehabkost@redhat.com>
References: <20170613165313.20954-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 12/15] error: Make IGNORED_ERRORS not a NULL
 pointer
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

Use a trick to make we have a non-NULL errp if IGNORED_ERRORS is used:
instead of passing NULL, pass an existing pointer that points to a
special &error_ignored_unset value.  This will let the error API to flag
error state on *errp but won't require error_free() to be called later.

This will allow us to simplify the documented method to propagate errors
from:

    Error *err = NULL;
    foo(arg, &err);
    if (err) {
        handle the error...
        error_propagate(errp, err);
    }

to:

    foo(arg, errp);
    if (ERR_IS_SET(errp)) {
        handle the error...
    }

This will allow us to stop using local_err variables and
error_propagate() on hundreds of cases.

* TODO: API documentation needs to be updated.
* TODO: probably we should add assert(errp) lines to the ERR_IS_* macros,
        as err_set*() will now break if errp is NULL.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qapi/error.h   | 20 +++++++++++++++++---
 tests/test-qapi-util.c | 14 +++++++-------
 util/error.c           | 13 ++++++++++++-
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index 1000853051..d1378396dd 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -117,10 +117,24 @@
 
 #include "qapi-types.h"
 
-#define IGNORE_ERRORS (NULL)
 
-#define ERR_IS_SET(e) (!!*(e))
-#define ERR_IS_IGNORED(e) (!(e))
+/*
+ * Special error value to indicate errors will be ignored, and no
+ * error was set.
+ */
+extern Error ignored_error_unset;
+
+/*
+ * Special error destination to indicate errors will be ignored,
+ * but an error value was set.
+ */
+extern Error ignored_error_set;
+
+
+#define IGNORE_ERRORS (& (Error *) { &ignored_error_unset })
+
+#define ERR_IS_SET(e) (*(e) && *(e) != &ignored_error_unset)
+#define ERR_IS_IGNORED(e) (!(e) || *(e) == &ignored_error_unset || *(e) == &ignored_error_set)
 
 /*
  * Overall category of an error.
diff --git a/tests/test-qapi-util.c b/tests/test-qapi-util.c
index fe232ef9ed..0305b9201b 100644
--- a/tests/test-qapi-util.c
+++ b/tests/test-qapi-util.c
@@ -77,25 +77,25 @@ static void test_parse_qapi_name(void)
 
 static void successfn(Error **errp)
 {
-    g_assert(ERR_IS_IGNORED(errp) || !ERR_IS_SET(errp));
+    g_assert(!ERR_IS_SET(errp));
 }
 
 static void fail1(Error **errp)
 {
-    g_assert(ERR_IS_IGNORED(errp) || !ERR_IS_SET(errp));
+    g_assert(!ERR_IS_SET(errp));
 
     error_setg(errp, "error1");
 
-    g_assert(ERR_IS_IGNORED(errp) || ERR_IS_SET(errp));
+    g_assert(ERR_IS_SET(errp));
 }
 
 static void fail2(Error **errp)
 {
-    g_assert(ERR_IS_IGNORED(errp) || !ERR_IS_SET(errp));
+    g_assert(!ERR_IS_SET(errp));
 
     error_setg(errp, "error2");
 
-    g_assert(ERR_IS_IGNORED(errp) || ERR_IS_SET(errp));
+    g_assert(ERR_IS_SET(errp));
 }
 
 static void multifn(Error **errp)
@@ -124,13 +124,13 @@ static void test_propagate(void (*fn)(Error **), Error **errp)
     bool failed;
     Error *local_err = NULL;
 
-    g_assert(ERR_IS_IGNORED(errp) || !ERR_IS_SET(errp));
+    g_assert(!ERR_IS_SET(errp));
 
     fn(&local_err);
     failed = !!local_err;
     error_propagate(errp, local_err);
 
-    g_assert(ERR_IS_IGNORED(errp) || (failed == !!ERR_IS_SET(errp)));
+    g_assert((failed == !!ERR_IS_SET(errp)));
 }
 
 static void test_error_api(void)
diff --git a/util/error.c b/util/error.c
index 4e804287eb..2e16ad371c 100644
--- a/util/error.c
+++ b/util/error.c
@@ -28,6 +28,8 @@ struct Error
 
 Error *error_abort;
 Error *error_fatal;
+Error ignored_error_unset;
+Error ignored_error_set;
 
 static void error_handle_fatal(Error **errp, Error *err)
 {
@@ -52,6 +54,7 @@ static void error_setv(Error **errp,
     int saved_errno = errno;
 
     if (ERR_IS_IGNORED(errp)) {
+        *errp = &ignored_error_set;
         return;
     }
     assert(!ERR_IS_SET(errp));
@@ -104,6 +107,7 @@ void error_setg_errno_internal(Error **errp,
     int saved_errno = errno;
 
     if (ERR_IS_IGNORED(errp)) {
+        *errp = &ignored_error_set;
         return;
     }
 
@@ -127,6 +131,8 @@ void error_vprepend(Error **errp, const char *fmt, va_list ap)
 {
     GString *newmsg;
 
+    assert(ERR_IS_SET(errp));
+
     if (ERR_IS_IGNORED(errp)) {
         return;
     }
@@ -153,6 +159,8 @@ void error_append_hint(Error **errp, const char *fmt, ...)
     int saved_errno = errno;
     Error *err;
 
+    assert(ERR_IS_SET(errp));
+
     if (ERR_IS_IGNORED(errp)) {
         return;
     }
@@ -179,6 +187,7 @@ void error_setg_win32_internal(Error **errp,
     char *suffix = NULL;
 
     if (ERR_IS_IGNORED(errp)) {
+        *errp = &ignored_error_set;
         return;
     }
 
@@ -266,7 +275,9 @@ void error_propagate(Error **dst_errp, Error *local_err)
         return;
     }
     error_handle_fatal(dst_errp, local_err);
-    if (!ERR_IS_IGNORED(dst_errp) && !ERR_IS_SET(dst_errp)) {
+    if (ERR_IS_IGNORED(dst_errp)) {
+        *dst_errp = &ignored_error_set;
+    } else if (!ERR_IS_SET(dst_errp)) {
         *dst_errp = local_err;
     } else {
         error_free(local_err);
-- 
2.11.0.259.g40922b1
