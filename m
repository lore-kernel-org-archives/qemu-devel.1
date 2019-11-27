Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8053BC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:42:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B649207DD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B649207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41739 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia2Gw-0003Yh-AB
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 13:42:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42172)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ia2Bg-0007jc-6G
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 13:37:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ia2Be-0000C2-Hf
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 13:37:15 -0500
Received: from relay.sw.ru ([185.231.240.75]:51034)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ia2Be-0000B8-9F
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 13:37:14 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1ia2BV-0002k8-1Q; Wed, 27 Nov 2019 21:37:05 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6] error: rename errp to errp_in where it is IN-argument
Date: Wed, 27 Nov 2019 21:37:04 +0300
Message-Id: <20191127183704.14825-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
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
Cc: vsementsov@virtuozzo.com, mdroth@linux.vnet.ibm.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Error **errp is almost always OUT-argument: it's assumed to be NULL, or
pointer to NULL-initialized pointer, or pointer to error_abort or
error_fatal, for callee to report error.

But very few functions instead get Error **errp as IN-argument:
it's assumed to be set (or, maybe, NULL), and callee should clean it,
or add some information.

In such cases, rename errp to errp_in.

This patch updates only error API functions. There still a few
functions with errp-in semantics, they will be updated in further
commits.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---

v6: fix s/errp/errp_in/ in comments corresponding to changed functions
    [Eric]
    add Eric's r-b

 include/qapi/error.h | 16 ++++++++--------
 util/error.c         | 30 +++++++++++++++---------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index 3f95141a01..df518644fc 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -230,16 +230,16 @@ void error_propagate_prepend(Error **dst_errp, Error *local_err,
                              const char *fmt, ...);
 
 /*
- * Prepend some text to @errp's human-readable error message.
+ * Prepend some text to @errp_in's human-readable error message.
  * The text is made by formatting @fmt, @ap like vprintf().
  */
-void error_vprepend(Error **errp, const char *fmt, va_list ap);
+void error_vprepend(Error **errp_in, const char *fmt, va_list ap);
 
 /*
- * Prepend some text to @errp's human-readable error message.
+ * Prepend some text to @errp_in's human-readable error message.
  * The text is made by formatting @fmt, ... like printf().
  */
-void error_prepend(Error **errp, const char *fmt, ...)
+void error_prepend(Error **errp_in, const char *fmt, ...)
     GCC_FMT_ATTR(2, 3);
 
 /*
@@ -250,13 +250,13 @@ void error_prepend(Error **errp, const char *fmt, ...)
  * Intended use is adding helpful hints on the human user interface,
  * e.g. a list of valid values.  It's not for clarifying a confusing
  * error message.
- * @errp may be NULL, but not &error_fatal or &error_abort.
+ * @errp_in may be NULL, but not &error_fatal or &error_abort.
  * Trivially the case if you call it only after error_setg() or
  * error_propagate().
  * May be called multiple times.  The resulting hint should end with a
  * newline.
  */
-void error_append_hint(Error **errp, const char *fmt, ...)
+void error_append_hint(Error **errp_in, const char *fmt, ...)
     GCC_FMT_ATTR(2, 3);
 
 /*
@@ -281,9 +281,9 @@ Error *error_copy(const Error *err);
 void error_free(Error *err);
 
 /*
- * Convenience function to assert that *@errp is set, then silently free it.
+ * Convenience function to assert that *@errp_in is set, then silently free it.
  */
-void error_free_or_abort(Error **errp);
+void error_free_or_abort(Error **errp_in);
 
 /*
  * Convenience function to warn_report() and free @err.
diff --git a/util/error.c b/util/error.c
index d4532ce318..275586faa8 100644
--- a/util/error.c
+++ b/util/error.c
@@ -121,41 +121,41 @@ void error_setg_file_open_internal(Error **errp,
                               "Could not open '%s'", filename);
 }
 
-void error_vprepend(Error **errp, const char *fmt, va_list ap)
+void error_vprepend(Error **errp_in, const char *fmt, va_list ap)
 {
     GString *newmsg;
 
-    if (!errp) {
+    if (!errp_in) {
         return;
     }
 
     newmsg = g_string_new(NULL);
     g_string_vprintf(newmsg, fmt, ap);
-    g_string_append(newmsg, (*errp)->msg);
-    g_free((*errp)->msg);
-    (*errp)->msg = g_string_free(newmsg, 0);
+    g_string_append(newmsg, (*errp_in)->msg);
+    g_free((*errp_in)->msg);
+    (*errp_in)->msg = g_string_free(newmsg, 0);
 }
 
-void error_prepend(Error **errp, const char *fmt, ...)
+void error_prepend(Error **errp_in, const char *fmt, ...)
 {
     va_list ap;
 
     va_start(ap, fmt);
-    error_vprepend(errp, fmt, ap);
+    error_vprepend(errp_in, fmt, ap);
     va_end(ap);
 }
 
-void error_append_hint(Error **errp, const char *fmt, ...)
+void error_append_hint(Error **errp_in, const char *fmt, ...)
 {
     va_list ap;
     int saved_errno = errno;
     Error *err;
 
-    if (!errp) {
+    if (!errp_in) {
         return;
     }
-    err = *errp;
-    assert(err && errp != &error_abort && errp != &error_fatal);
+    err = *errp_in;
+    assert(err && errp_in != &error_abort && errp_in != &error_fatal);
 
     if (!err->hint) {
         err->hint = g_string_new(NULL);
@@ -271,11 +271,11 @@ void error_free(Error *err)
     }
 }
 
-void error_free_or_abort(Error **errp)
+void error_free_or_abort(Error **errp_in)
 {
-    assert(errp && *errp);
-    error_free(*errp);
-    *errp = NULL;
+    assert(errp_in && *errp_in);
+    error_free(*errp_in);
+    *errp_in = NULL;
 }
 
 void error_propagate(Error **dst_errp, Error *local_err)
-- 
2.21.0


