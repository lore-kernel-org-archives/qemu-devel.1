Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A0BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:02:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 040A520775
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KS3XlNXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040A520775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtI8o-0002ki-5B
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtHkn-0005Cb-W9
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:37:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55769
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtHkk-0003Kc-V4
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594244236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1dzAsYzbiYxfgWsmubvLg6r/7WdXTK1siPirRgE8kbA=;
 b=KS3XlNXcJqyQ0XlKKfPyMNz9p1M9A+mpy04LU8JUD0bGg4QhSE2/6Gx/tXgoN35FGNqwsf
 xYgIUrc9Y+Oh1MKfTVJ88mUvvEwFNMe3zlVCQDt8k5/NQpNMGwJXDThNkksH41NeG+cOiQ
 IPHQD32tIdyiK224KgnC89nzQlxCFzk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-GUUZqqDQPNy6X2mnf5Q_TA-1; Tue, 07 Jul 2020 17:25:10 -0400
X-MC-Unique: GUUZqqDQPNy6X2mnf5Q_TA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96BCC107ACF2;
 Tue,  7 Jul 2020 21:25:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FEDF19D81;
 Tue,  7 Jul 2020 21:25:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C284811328A3; Tue,  7 Jul 2020 23:25:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/53] error: Document Error API usage rules
Date: Tue,  7 Jul 2020 23:24:13 +0200
Message-Id: <20200707212503.1495927-4-armbru@redhat.com>
In-Reply-To: <20200707212503.1495927-1-armbru@redhat.com>
References: <20200707212503.1495927-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This merely codifies existing practice, with one exception: the rule
advising against returning void, where existing practice is mixed.

When the Error API was created, we adopted the (unwritten) rule to
return void when the function returns no useful value on success,
unlike GError, which recommends to return true on success and false on
error then.

When a function returns a distinct error value, say false, a checked
call that passes the error up looks like

    if (!frobnicate(..., errp)) {
        handle the error...
    }

When it returns void, we need

    Error *err = NULL;

    frobnicate(..., &err);
    if (err) {
        handle the error...
        error_propagate(errp, err);
    }

Not only is this more verbose, it also creates an Error object even
when @errp is null, &error_abort or &error_fatal.

People got tired of the additional boilerplate, and started to ignore
the unwritten rule.  The result is confusion among developers about
the preferred usage.

Make the rule advising against returning void official by putting it
in writing.  This will hopefully reduce confusion.

Update the examples accordingly.

The remainder of this series will update a substantial amount of code
to honor the rule.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <20200707160613.848843-4-armbru@redhat.com>
[Tweak prose as per advice from Eric]
---
 include/qapi/error.h | 52 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index 6d079c58b7..2c189abb04 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -15,6 +15,33 @@
 /*
  * Error reporting system loosely patterned after Glib's GError.
  *
+ * = Rules =
+ *
+ * - Functions that use Error to report errors have an Error **errp
+ *   parameter.  It should be the last parameter, except for functions
+ *   taking variable arguments.
+ *
+ * - You may pass NULL to not receive the error, &error_abort to abort
+ *   on error, &error_fatal to exit(1) on error, or a pointer to a
+ *   variable containing NULL to receive the error.
+ *
+ * - Separation of concerns: the function is responsible for detecting
+ *   errors and failing cleanly; handling the error is its caller's
+ *   job.  Since the value of @errp is about handling the error, the
+ *   function should not examine it.
+ *
+ * - On success, the function should not touch *errp.  On failure, it
+ *   should set a new error, e.g. with error_setg(errp, ...), or
+ *   propagate an existing one, e.g. with error_propagate(errp, ...).
+ *
+ * - Whenever practical, also return a value that indicates success /
+ *   failure.  This can make the error checking more concise, and can
+ *   avoid useless error object creation and destruction.  Note that
+ *   we still have many functions returning void.  We recommend
+ *   • bool-valued functions return true on success / false on failure,
+ *   • pointer-valued functions return non-null / null pointer, and
+ *   • integer-valued functions return non-negative / negative.
+ *
  * = Creating errors =
  *
  * Create an error:
@@ -95,14 +122,13 @@
  * Create a new error and pass it to the caller:
  *     error_setg(errp, "situation normal, all fouled up");
  *
- * Call a function and receive an error from it:
- *     Error *err = NULL;
- *     foo(arg, &err);
- *     if (err) {
+ * Call a function, receive an error from it, and pass it to the caller
+ * - when the function returns a value that indicates failure, say
+ *   false:
+ *     if (!foo(arg, errp)) {
  *         handle the error...
  *     }
- *
- * Receive an error and pass it on to the caller:
+ * - when it does not, say because it is a void function:
  *     Error *err = NULL;
  *     foo(arg, &err);
  *     if (err) {
@@ -120,6 +146,20 @@
  *     foo(arg, errp);
  * for readability.
  *
+ * Receive an error, and handle it locally
+ * - when the function returns a value that indicates failure, say
+ *   false:
+ *     Error *err = NULL;
+ *     if (!foo(arg, &err)) {
+ *         handle the error...
+ *     }
+ * - when it does not, say because it is a void function:
+ *     Error *err = NULL;
+ *     foo(arg, &err);
+ *     if (err) {
+ *         handle the error...
+ *     }
+ *
  * Receive and accumulate multiple errors (first one wins):
  *     Error *err = NULL, *local_err = NULL;
  *     foo(arg, &err);
-- 
2.26.2


