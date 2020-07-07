Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94CCC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:09:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B52A520738
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JoNj3OIw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B52A520738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsq9r-0007fb-SU
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsq70-0001YK-Dg
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:06:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25972
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsq6y-0006lb-Be
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594137983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8DAGkV6ZNIL1tG7KKSixN93yw+yuNrB9BJVkRRHacng=;
 b=JoNj3OIw9SrN07JAiu5T8TV5UqUsrULVn1JTZLcrCzZucS/HFUAd7+GdqY5VODjrUPoUWS
 txPxdiy/jPpBdh0sb/4X1cqCb1j1jVHg2ctzdP4UUbbC8q8OZf/OH6PX86EDyt6tQz7937
 qBj327/RhZMK+uQBTHJzPGlmFdaxm5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-ThKxmkCSMRKo6JXFZ2TYdg-1; Tue, 07 Jul 2020 12:06:19 -0400
X-MC-Unique: ThKxmkCSMRKo6JXFZ2TYdg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50DC6107ACF9;
 Tue,  7 Jul 2020 16:06:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB4825D9C9;
 Tue,  7 Jul 2020 16:06:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 770F011328A3; Tue,  7 Jul 2020 18:06:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 03/45] error: Document Error API usage rules
Date: Tue,  7 Jul 2020 18:05:31 +0200
Message-Id: <20200707160613.848843-4-armbru@redhat.com>
In-Reply-To: <20200707160613.848843-1-armbru@redhat.com>
References: <20200707160613.848843-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:46:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, groug@kaod.org,
 pbonzini@redhat.com
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
---
 include/qapi/error.h | 50 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index 6d079c58b7..3fed49747d 100644
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
@@ -95,14 +122,12 @@
  * Create a new error and pass it to the caller:
  *     error_setg(errp, "situation normal, all fouled up");
  *
- * Call a function and receive an error from it:
- *     Error *err = NULL;
- *     foo(arg, &err);
- *     if (err) {
+ * Call a function, receive an error from it, and pass it to caller
+ * when the function returns a value that indicates failure, say false:
+ *     if (!foo(arg, errp)) {
  *         handle the error...
  *     }
- *
- * Receive an error and pass it on to the caller:
+ * when it doesn't, say a void function:
  *     Error *err = NULL;
  *     foo(arg, &err);
  *     if (err) {
@@ -120,6 +145,19 @@
  *     foo(arg, errp);
  * for readability.
  *
+ * Receive an error, and handle it locally
+ * when the function returns a value that indicates failure, say false:
+ *     Error *err = NULL;
+ *     if (!foo(arg, &err)) {
+ *         handle the error...
+ *     }
+ * when it doesn't, say a void function:
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


