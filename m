Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26ECC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 15:25:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97DB724249
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 15:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97DB724249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ict04-0003yj-AH
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 10:25:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icsw7-0000Ev-2M
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:21:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icsw3-0005uL-JG
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:20:57 -0500
Received: from relay.sw.ru ([185.231.240.75]:43510)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1icsw0-0005a2-0J
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:20:52 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1icsvZ-00007O-SG; Thu, 05 Dec 2019 18:20:26 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 03/21] error: rename errp to errp_in where it is IN-argument
Date: Thu,  5 Dec 2019 18:20:01 +0300
Message-Id: <20191205152019.8454-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191205152019.8454-1-vsementsov@virtuozzo.com>
References: <20191205152019.8454-1-vsementsov@virtuozzo.com>
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
Cc: vsementsov@virtuozzo.com, armbru@redhat.com,
 Michael Roth <mdroth@linux.vnet.ibm.com>
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
---
 include/qapi/error.h | 6 +++---
 util/error.c         | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index 3f95141a01..ad5b6e896d 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -233,13 +233,13 @@ void error_propagate_prepend(Error **dst_errp, Error *local_err,
  * Prepend some text to @errp's human-readable error message.
  * The text is made by formatting @fmt, @ap like vprintf().
  */
-void error_vprepend(Error **errp, const char *fmt, va_list ap);
+void error_vprepend(Error *const *errp, const char *fmt, va_list ap);
 
 /*
  * Prepend some text to @errp's human-readable error message.
  * The text is made by formatting @fmt, ... like printf().
  */
-void error_prepend(Error **errp, const char *fmt, ...)
+void error_prepend(Error *const *errp, const char *fmt, ...)
     GCC_FMT_ATTR(2, 3);
 
 /*
@@ -256,7 +256,7 @@ void error_prepend(Error **errp, const char *fmt, ...)
  * May be called multiple times.  The resulting hint should end with a
  * newline.
  */
-void error_append_hint(Error **errp, const char *fmt, ...)
+void error_append_hint(Error *const *errp, const char *fmt, ...)
     GCC_FMT_ATTR(2, 3);
 
 /*
diff --git a/util/error.c b/util/error.c
index d4532ce318..b6c89d1412 100644
--- a/util/error.c
+++ b/util/error.c
@@ -121,7 +121,7 @@ void error_setg_file_open_internal(Error **errp,
                               "Could not open '%s'", filename);
 }
 
-void error_vprepend(Error **errp, const char *fmt, va_list ap)
+void error_vprepend(Error *const *errp, const char *fmt, va_list ap)
 {
     GString *newmsg;
 
@@ -136,7 +136,7 @@ void error_vprepend(Error **errp, const char *fmt, va_list ap)
     (*errp)->msg = g_string_free(newmsg, 0);
 }
 
-void error_prepend(Error **errp, const char *fmt, ...)
+void error_prepend(Error *const *errp, const char *fmt, ...)
 {
     va_list ap;
 
@@ -145,7 +145,7 @@ void error_prepend(Error **errp, const char *fmt, ...)
     va_end(ap);
 }
 
-void error_append_hint(Error **errp, const char *fmt, ...)
+void error_append_hint(Error *const *errp, const char *fmt, ...)
 {
     va_list ap;
     int saved_errno = errno;
-- 
2.21.0


