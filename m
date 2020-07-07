Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898EEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 21:55:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52F902065D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 21:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H91TtOn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F902065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtI2B-0008RH-H0
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 17:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtHgh-0006pX-H4
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:33:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30223
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtHgg-0002mb-3J
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594243984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YiLPYp1sEs9XnIGPixoR+PI+DF0cIKbikqe4x2SJFVs=;
 b=H91TtOn254V9hIsgUk4cIBzWU5oNQHRl0bo8REH81l7CfLUzfrh+I1KYOHRhyJYerqV4M+
 /5bfY1TvYlRqfSZye0bw9ADovBQgN/RXdi2lGWCh95cQgrqMSbReDizdjsCjLdJNjb19T6
 S1uOawyb56V5CTDdi6n2Ob28XFpX340=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-16pv9xpEPzOAWHAlwKlJDw-1; Tue, 07 Jul 2020 17:25:15 -0400
X-MC-Unique: 16pv9xpEPzOAWHAlwKlJDw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A71D87950B;
 Tue,  7 Jul 2020 21:25:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AEEA5C1D0;
 Tue,  7 Jul 2020 21:25:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E6D2B112FB79; Tue,  7 Jul 2020 23:25:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/53] qemu-option: Simplify around find_default_by_name()
Date: Tue,  7 Jul 2020 23:24:20 +0200
Message-Id: <20200707212503.1495927-11-armbru@redhat.com>
In-Reply-To: <20200707212503.1495927-1-armbru@redhat.com>
References: <20200707212503.1495927-1-armbru@redhat.com>
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200707160613.848843-11-armbru@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 util/qemu-option.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index 14e211ddd8..e7b540a21b 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -277,7 +277,6 @@ static void qemu_opt_del_all(QemuOpts *opts, const char *name)
 const char *qemu_opt_get(QemuOpts *opts, const char *name)
 {
     QemuOpt *opt;
-    const char *def_val;
 
     if (opts == NULL) {
         return NULL;
@@ -285,12 +284,10 @@ const char *qemu_opt_get(QemuOpts *opts, const char *name)
 
     opt = qemu_opt_find(opts, name);
     if (!opt) {
-        def_val = find_default_by_name(opts, name);
-        if (def_val) {
-            return def_val;
-        }
+        return find_default_by_name(opts, name);
     }
-    return opt ? opt->str : NULL;
+
+    return opt->str;
 }
 
 void qemu_opt_iter_init(QemuOptsIter *iter, QemuOpts *opts, const char *name)
@@ -319,8 +316,7 @@ const char *qemu_opt_iter_next(QemuOptsIter *iter)
 char *qemu_opt_get_del(QemuOpts *opts, const char *name)
 {
     QemuOpt *opt;
-    const char *def_val;
-    char *str = NULL;
+    char *str;
 
     if (opts == NULL) {
         return NULL;
@@ -328,11 +324,7 @@ char *qemu_opt_get_del(QemuOpts *opts, const char *name)
 
     opt = qemu_opt_find(opts, name);
     if (!opt) {
-        def_val = find_default_by_name(opts, name);
-        if (def_val) {
-            str = g_strdup(def_val);
-        }
-        return str;
+        return g_strdup(find_default_by_name(opts, name));
     }
     str = opt->str;
     opt->str = NULL;
-- 
2.26.2


