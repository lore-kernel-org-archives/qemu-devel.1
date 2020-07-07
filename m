Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7CCC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:07:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D05D2065D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDAz/Ohx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D05D2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsq8B-00049g-R7
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsq71-0001aV-4P
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:06:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32972
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsq6z-0006mG-Ak
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594137984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Psc2/qtFuObz4HxWFph7CzkwSzBHiFg3VdLcX7BaxxI=;
 b=gDAz/OhxcX1lvrVc2nr50IXgHG2cjCUvLFb5+q9gQET3nbwz7XB3GncXrh6AJj4mH05E+/
 OP90UPhD+r2HxJRuOmemp4Ql4NNm7ie3rUOV746BNaY5y3lmX7jkmed61Grtl+Q6J43Msd
 kwZHDeovIjICtx8WGU1CpNnKrBvHGdM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-pWWl-KyEOFOHjkAvXuhNXg-1; Tue, 07 Jul 2020 12:06:23 -0400
X-MC-Unique: pWWl-KyEOFOHjkAvXuhNXg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17C6B461;
 Tue,  7 Jul 2020 16:06:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D902C5C1B2;
 Tue,  7 Jul 2020 16:06:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 97E3E1141CC6; Tue,  7 Jul 2020 18:06:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 11/45] qemu-option: Factor out helper opt_create()
Date: Tue,  7 Jul 2020 18:05:39 +0200
Message-Id: <20200707160613.848843-12-armbru@redhat.com>
In-Reply-To: <20200707160613.848843-1-armbru@redhat.com>
References: <20200707160613.848843-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 06:04:49
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

There is just one use so far.  The next commit will add more.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 util/qemu-option.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index e7b540a21b..1023fe7527 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -499,6 +499,23 @@ int qemu_opt_unset(QemuOpts *opts, const char *name)
     }
 }
 
+static QemuOpt *opt_create(QemuOpts *opts, const char *name, char *value,
+                           bool prepend)
+{
+    QemuOpt *opt = g_malloc0(sizeof(*opt));
+
+    opt->name = g_strdup(name);
+    opt->str = value;
+    opt->opts = opts;
+    if (prepend) {
+        QTAILQ_INSERT_HEAD(&opts->head, opt, next);
+    } else {
+        QTAILQ_INSERT_TAIL(&opts->head, opt, next);
+    }
+
+    return opt;
+}
+
 static void opt_set(QemuOpts *opts, const char *name, char *value,
                     bool prepend, bool *help_wanted, Error **errp)
 {
@@ -516,16 +533,8 @@ static void opt_set(QemuOpts *opts, const char *name, char *value,
         return;
     }
 
-    opt = g_malloc0(sizeof(*opt));
-    opt->name = g_strdup(name);
-    opt->opts = opts;
-    if (prepend) {
-        QTAILQ_INSERT_HEAD(&opts->head, opt, next);
-    } else {
-        QTAILQ_INSERT_TAIL(&opts->head, opt, next);
-    }
+    opt = opt_create(opts, name, value, prepend);
     opt->desc = desc;
-    opt->str = value;
     qemu_opt_parse(opt, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-- 
2.26.2


