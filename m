Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD58DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 862B62073E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dD0L+Y3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862B62073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo8WH-0005A7-Mm
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 12:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo8V5-0002ci-VP
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:43:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55743
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo8V4-00053N-94
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593017029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/iUY16+Y4OKPSUTd7Sn5YJA+VIxGZ/2x5D/1We9ZON8=;
 b=dD0L+Y3omW5rQOeNcQSsg+aGwPq3CVNHHn0o+WjCGVPADYgl2KYO6G8bP4Tc+KCkFfoJhL
 3SvbPiVHnK8IiytvtwFphqGMzr/j1lswzo6yEs7D86hJ35r6hrdRUiIpPcMEW6z420FkWb
 KIzkZUbBQhksijhVdqViXK3A9Znpg1g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-O7Du41nKPWOqoAF-B7N-Cw-1; Wed, 24 Jun 2020 12:43:47 -0400
X-MC-Unique: O7Du41nKPWOqoAF-B7N-Cw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4998804016;
 Wed, 24 Jun 2020 16:43:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B0738927C;
 Wed, 24 Jun 2020 16:43:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D7F0D113846F; Wed, 24 Jun 2020 18:43:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/46] error: Document Error API usage rules
Date: Wed, 24 Jun 2020 18:43:00 +0200
Message-Id: <20200624164344.3778251-3-armbru@redhat.com>
In-Reply-To: <20200624164344.3778251-1-armbru@redhat.com>
References: <20200624164344.3778251-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 ehabkost@redhat.com, qemu-block@nongnu.org, pbonzini@redhat.com
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

The written rule will hopefully reduce the confusion.

The remainder of this series will update a substantial amount of code
to honor the rule.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/error.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index 1a5ea25e12..c3d84d610a 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -15,6 +15,32 @@
 /*
  * Error reporting system loosely patterned after Glib's GError.
  *
+ * Rules:
+ *
+ * - Functions that use Error to report errors have an Error **errp
+ *   parameter.  It should be the last parameter, except for functions
+ *   taking variable arguments.
+ *
+ * - You may pass NULL to not receive the error, &error_abort to abort
+ *   on error, &error_fatal to exit(1) on error, or a pointer to a
+ *   variable containing NULL to receive the error.
+ *
+ * - The value of @errp should not affect control flow.
+ *
+ * - On success, the function should not use @errp.  On failure, it
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
+ * How to:
+ *
  * Create an error:
  *     error_setg(errp, "situation normal, all fouled up");
  *
-- 
2.26.2


