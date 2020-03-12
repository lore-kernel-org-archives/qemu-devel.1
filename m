Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F8AC5ACBF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 09:03:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F39DD2071C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 09:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39DD2071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCJkG-0004Q1-1r
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 05:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jCJhI-00074V-4Y
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 05:00:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jCJhB-0004s7-Qp
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 05:00:08 -0400
Received: from relay.sw.ru ([185.231.240.75]:48452)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jCJhB-0004qi-FP
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 05:00:01 -0400
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1jCJgs-0004Ve-Uu; Thu, 12 Mar 2020 11:59:43 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 01/10] error: auto propagated local_err
Date: Thu, 12 Mar 2020 11:59:27 +0300
Message-Id: <20200312085936.9552-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200312085936.9552-1-vsementsov@virtuozzo.com>
References: <20200312085936.9552-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 Laszlo Ersek <lersek@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 armbru@redhat.com, Stefano Stabellini <sstabellini@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce a new ERRP_AUTO_PROPAGATE macro, to be used at start of
functions with an errp OUT parameter.

It has three goals:

1. Fix issue with error_fatal and error_prepend/error_append_hint: user
can't see this additional information, because exit() happens in
error_setg earlier than information is added. [Reported by Greg Kurz]

2. Fix issue with error_abort and error_propagate: when we wrap
error_abort by local_err+error_propagate, the resulting coredump will
refer to error_propagate and not to the place where error happened.
(the macro itself doesn't fix the issue, but it allows us to [3.] drop
the local_err+error_propagate pattern, which will definitely fix the
issue) [Reported by Kevin Wolf]

3. Drop local_err+error_propagate pattern, which is used to workaround
void functions with errp parameter, when caller wants to know resulting
status. (Note: actually these functions could be merely updated to
return int error code).

To achieve these goals, later patches will add invocations
of this macro at the start of functions with either use
error_prepend/error_append_hint (solving 1) or which use
local_err+error_propagate to check errors, switching those
functions to use *errp instead (solving 2 and 3).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Paul Durrant <paul@xen.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
---

Cc: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Greg Kurz <groug@kaod.org>
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Paul Durrant <paul@xen.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Philippe Mathieu-Daudé" <philmd@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
Cc: xen-devel@lists.xenproject.org

 include/qapi/error.h | 205 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 173 insertions(+), 32 deletions(-)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index ad5b6e896d..30140d9bfe 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -15,6 +15,8 @@
 /*
  * Error reporting system loosely patterned after Glib's GError.
  *
+ * = Deal with Error object =
+ *
  * Create an error:
  *     error_setg(&err, "situation normal, all fouled up");
  *
@@ -47,28 +49,91 @@
  * reporting it (primarily useful in testsuites):
  *     error_free_or_abort(&err);
  *
- * Pass an existing error to the caller:
- *     error_propagate(errp, err);
- * where Error **errp is a parameter, by convention the last one.
+ * = Deal with Error ** function parameter =
  *
- * Pass an existing error to the caller with the message modified:
- *     error_propagate_prepend(errp, err);
+ * A function may use the error system to return errors. In this case, the
+ * function defines an Error **errp parameter, by convention the last one (with
+ * exceptions for functions using ... or va_list).
  *
- * Avoid
- *     error_propagate(errp, err);
- *     error_prepend(errp, "Could not frobnicate '%s': ", name);
- * because this fails to prepend when @errp is &error_fatal.
+ * The caller may then pass in the following errp values:
  *
- * Create a new error and pass it to the caller:
+ * 1. &error_abort
+ *    Any error will result in abort().
+ * 2. &error_fatal
+ *    Any error will result in exit() with a non-zero status.
+ * 3. NULL
+ *    No error reporting through errp parameter.
+ * 4. The address of a NULL-initialized Error *err
+ *    Any error will populate errp with an error object.
+ *
+ * The following rules then implement the correct semantics desired by the
+ * caller.
+ *
+ * Create a new error to pass to the caller:
  *     error_setg(errp, "situation normal, all fouled up");
  *
- * Call a function and receive an error from it:
+ * Calling another errp-based function:
+ *     f(..., errp);
+ *
+ * == Checking success of subcall ==
+ *
+ * If a function returns a value indicating an error in addition to setting
+ * errp (which is recommended), then you don't need any additional code, just
+ * do:
+ *
+ *     int ret = f(..., errp);
+ *     if (ret < 0) {
+ *         ... handle error ...
+ *         return ret;
+ *     }
+ *
+ * If a function returns nothing (not recommended for new code), the only way
+ * to check success is by consulting errp; doing this safely requires the use
+ * of the ERRP_AUTO_PROPAGATE macro, like this:
+ *
+ *     int our_func(..., Error **errp) {
+ *         ERRP_AUTO_PROPAGATE();
+ *         ...
+ *         subcall(..., errp);
+ *         if (*errp) {
+ *             ...
+ *             return -EINVAL;
+ *         }
+ *         ...
+ *     }
+ *
+ * ERRP_AUTO_PROPAGATE takes care of wrapping the original errp as needed, so
+ * that the rest of the function can directly use errp (including
+ * dereferencing), where any errors will then be propagated on to the original
+ * errp when leaving the function.
+ *
+ * In some cases, we need to check result of subcall, but do not want to
+ * propagate the Error object to our caller. In such cases we don't need
+ * ERRP_AUTO_PROPAGATE, but just a local Error object:
+ *
+ * Receive an error and not pass it:
  *     Error *err = NULL;
- *     foo(arg, &err);
+ *     subcall(arg, &err);
  *     if (err) {
  *         handle the error...
+ *         error_free(err);
  *     }
  *
+ * Note that older code that did not use ERRP_AUTO_PROPAGATE would instead need
+ * a local Error * variable and the use of error_propagate() to properly handle
+ * all possible caller values of errp. Now this is DEPRECATED* (see below).
+ *
+ * Note that any function that wants to modify an error object, such as by
+ * calling error_append_hint or error_prepend, must use ERRP_AUTO_PROPAGATE, in
+ * order for a caller's use of &error_fatal to see the additional information.
+ *
+ * In rare cases, we need to pass existing Error object to the caller by hand:
+ *     error_propagate(errp, err);
+ *
+ * Pass an existing error to the caller with the message modified:
+ *     error_propagate_prepend(errp, err);
+ *
+ *
  * Call a function ignoring errors:
  *     foo(arg, NULL);
  *
@@ -78,26 +143,6 @@
  * Call a function treating errors as fatal:
  *     foo(arg, &error_fatal);
  *
- * Receive an error and pass it on to the caller:
- *     Error *err = NULL;
- *     foo(arg, &err);
- *     if (err) {
- *         handle the error...
- *         error_propagate(errp, err);
- *     }
- * where Error **errp is a parameter, by convention the last one.
- *
- * Do *not* "optimize" this to
- *     foo(arg, errp);
- *     if (*errp) { // WRONG!
- *         handle the error...
- *     }
- * because errp may be NULL!
- *
- * But when all you do with the error is pass it on, please use
- *     foo(arg, errp);
- * for readability.
- *
  * Receive and accumulate multiple errors (first one wins):
  *     Error *err = NULL, *local_err = NULL;
  *     foo(arg, &err);
@@ -114,6 +159,61 @@
  *         handle the error...
  *     }
  * because this may pass a non-null err to bar().
+ *
+ * DEPRECATED*
+ *
+ * The following pattern of receiving, checking, and then forwarding an error
+ * to the caller by hand is now deprecated:
+ *
+ *     Error *err = NULL;
+ *     foo(arg, &err);
+ *     if (err) {
+ *         handle the error...
+ *         error_propagate(errp, err);
+ *     }
+ *
+ * Instead, use ERRP_AUTO_PROPAGATE macro.
+ *
+ * The old pattern is deprecated because of two things:
+ *
+ * 1. Issue with error_abort and error_propagate: when we wrap error_abort by
+ * local_err+error_propagate, the resulting coredump will refer to
+ * error_propagate and not to the place where error happened.
+ *
+ * 2. A lot of extra code of the same pattern
+ *
+ * How to update old code to use ERRP_AUTO_PROPAGATE?
+ *
+ * All you need is to add ERRP_AUTO_PROPAGATE() invocation at function start,
+ * than you may safely dereference errp to check errors and do not need any
+ * additional local Error variables or calls to error_propagate().
+ *
+ * Example:
+ *
+ * old code
+ *
+ *     void fn(..., Error **errp) {
+ *         Error *err = NULL;
+ *         foo(arg, &err);
+ *         if (err) {
+ *             handle the error...
+ *             error_propagate(errp, err);
+ *             return;
+ *         }
+ *         ...
+ *     }
+ *
+ * updated code
+ *
+ *     void fn(..., Error **errp) {
+ *         ERRP_AUTO_PROPAGATE();
+ *         foo(arg, errp);
+ *         if (*errp) {
+ *             handle the error...
+ *             return;
+ *         }
+ *         ...
+ *     }
  */
 
 #ifndef ERROR_H
@@ -322,6 +422,47 @@ void error_set_internal(Error **errp,
                         ErrorClass err_class, const char *fmt, ...)
     GCC_FMT_ATTR(6, 7);
 
+typedef struct ErrorPropagator {
+    Error *local_err;
+    Error **errp;
+} ErrorPropagator;
+
+static inline void error_propagator_cleanup(ErrorPropagator *prop)
+{
+    error_propagate(prop->errp, prop->local_err);
+}
+
+G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(ErrorPropagator, error_propagator_cleanup);
+
+/*
+ * ERRP_AUTO_PROPAGATE
+ *
+ * This macro exists to assist with proper error handling in a function which
+ * uses an Error **errp parameter.  It must be used as the first line of a
+ * function which modifies an error (with error_prepend, error_append_hint, or
+ * similar) or which wants to dereference *errp.  It is still safe (but
+ * useless) to use in other functions.
+ *
+ * If errp is NULL or points to error_fatal, it is rewritten to point to a
+ * local Error object, which will be automatically propagated to the original
+ * errp on function exit (see error_propagator_cleanup).
+ *
+ * After invocation of this macro it is always safe to dereference errp
+ * (as it's not NULL anymore) and to add information by error_prepend or
+ * error_append_hint (as, if it was error_fatal, we swapped it with a
+ * local_error to be propagated on cleanup).
+ *
+ * Note: we don't wrap the error_abort case, as we want resulting coredump
+ * to point to the place where the error happened, not to error_propagate.
+ */
+#define ERRP_AUTO_PROPAGATE() \
+    g_auto(ErrorPropagator) _auto_errp_prop = {.errp = errp}; \
+    do { \
+        if (!errp || errp == &error_fatal) { \
+            errp = &_auto_errp_prop.local_err; \
+        } \
+    } while (0)
+
 /*
  * Special error destination to abort on error.
  * See error_setg() and error_propagate() for details.
-- 
2.21.0


