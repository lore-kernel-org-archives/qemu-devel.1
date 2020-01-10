Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BB3C33CA3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 19:46:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A13D205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 19:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A13D205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iq0F7-0007ah-Kq
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 14:46:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iq0Ao-0001mQ-Dr
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 14:42:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iq0Am-0004xk-Fh
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 14:42:22 -0500
Received: from relay.sw.ru ([185.231.240.75]:53972)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iq0Am-0004ma-5b; Fri, 10 Jan 2020 14:42:20 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iq0AU-0008Ob-Dz; Fri, 10 Jan 2020 22:42:02 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 02/11] error: auto propagated local_err
Date: Fri, 10 Jan 2020 22:41:49 +0300
Message-Id: <20200110194158.14190-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200110194158.14190-1-vsementsov@virtuozzo.com>
References: <20200110194158.14190-1-vsementsov@virtuozzo.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Laszlo Ersek <lersek@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Greg Kurz <groug@kaod.org>,
 Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Here is introduced ERRP_AUTO_PROPAGATE macro, to be used at start of
functions with errp OUT parameter.

It has three goals:

1. Fix issue with error_fatal & error_prepend/error_append_hint: user
can't see this additional information, because exit() happens in
error_setg earlier than information is added. [Reported by Greg Kurz]

2. Fix issue with error_abort & error_propagate: when we wrap
error_abort by local_err+error_propagate, resulting coredump will
refer to error_propagate and not to the place where error happened.
(the macro itself doesn't fix the issue, but it allows to [3.] drop all
local_err+error_propagate pattern, which will definitely fix the issue)
[Reported by Kevin Wolf]

3. Drop local_err+error_propagate pattern, which is used to workaround
void functions with errp parameter, when caller wants to know resulting
status. (Note: actually these functions could be merely updated to
return int error code).

To achieve these goals, we need to add invocation of the macro at start
of functions, which needs error_prepend/error_append_hint (1.); add
invocation of the macro at start of functions which do
local_err+error_propagate scenario the check errors, drop local errors
from them and just use *errp instead (2., 3.).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

CC: Cornelia Huck <cohuck@redhat.com>
CC: Eric Blake <eblake@redhat.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: Greg Kurz <groug@kaod.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Stefano Stabellini <sstabellini@kernel.org>
CC: Anthony Perard <anthony.perard@citrix.com>
CC: Paul Durrant <paul@xen.org>
CC: "Philippe Mathieu-Daudé" <philmd@redhat.com>
CC: Laszlo Ersek <lersek@redhat.com>
CC: Gerd Hoffmann <kraxel@redhat.com>
CC: Stefan Berger <stefanb@linux.ibm.com>
CC: Markus Armbruster <armbru@redhat.com>
CC: Michael Roth <mdroth@linux.vnet.ibm.com>
CC: qemu-block@nongnu.org
CC: xen-devel@lists.xenproject.org

 include/qapi/error.h | 84 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index fa8d51fd6d..532b9afb9e 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -78,7 +78,7 @@
  * Call a function treating errors as fatal:
  *     foo(arg, &error_fatal);
  *
- * Receive an error and pass it on to the caller:
+ * Receive an error and pass it on to the caller (DEPRECATED*):
  *     Error *err = NULL;
  *     foo(arg, &err);
  *     if (err) {
@@ -98,6 +98,50 @@
  *     foo(arg, errp);
  * for readability.
  *
+ * DEPRECATED* This pattern is deprecated now, use ERRP_AUTO_PROPAGATE macro
+ * instead (defined below).
+ * It's deprecated because of two things:
+ *
+ * 1. Issue with error_abort & error_propagate: when we wrap error_abort by
+ * local_err+error_propagate, resulting coredump will refer to error_propagate
+ * and not to the place where error happened.
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
+ *
+ *
  * Receive and accumulate multiple errors (first one wins):
  *     Error *err = NULL, *local_err = NULL;
  *     foo(arg, &err);
@@ -348,6 +392,44 @@ void error_set_internal(Error **errp,
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
+ * This macro is created to be the first line of a function which use
+ * Error **errp parameter to report error. It's needed only in cases where we
+ * want to use error_prepend, error_append_hint or dereference *errp. It's
+ * still safe (but useless) in other cases.
+ *
+ * If errp is NULL or points to error_fatal, it is rewritten to point to a
+ * local Error object, which will be automatically propagated to the original
+ * errp on function exit (see error_propagator_cleanup).
+ *
+ * After invocation of this macro it is always safe to dereference errp
+ * (as it's not NULL anymore) and to add information (by error_prepend or
+ * error_append_hint)
+ * (as, if it was error_fatal, we swapped it with a local_error to be
+ * propagated on cleanup).
+ *
+ * Note: we don't wrap the error_abort case, as we want resulting coredump
+ * to point to the place where the error happened, not to error_propagate.
+ */
+#define ERRP_AUTO_PROPAGATE()                                  \
+    g_auto(ErrorPropagator) _auto_errp_prop = {.errp = errp};  \
+    errp = ((errp == NULL || *errp == error_fatal)             \
+            ? &_auto_errp_prop.local_err : errp)
+
 /*
  * Special error destination to abort on error.
  * See error_setg() and error_propagate() for details.
-- 
2.21.0


