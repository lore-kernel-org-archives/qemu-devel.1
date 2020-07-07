Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FA0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 21:35:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F29F206A1
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 21:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPHzjB3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F29F206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtHjE-0001qh-KF
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 17:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtHbM-0007lc-UR
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:27:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60985
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtHbK-00022J-Q1
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594243654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A2RoCCvKMEUJs8Z9t1M7vECuNMh4EUVbdT+Fsvj4Ark=;
 b=VPHzjB3iXSGQImlZI4uUY0mzo9LEWPcM26PrLOUieoabDmnXs9gIQcuYW2ZfghjYaglbk7
 wvxMymdKc3fi4nbwMGs/BVbY3Jw21KftaVxFfYVkQ5+hv16vBQPik38n78NzlhXBMVQmK3
 tudpjs4OMLxBNkw5g+wxxrAXAQQtqLY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-42hJcmjmPeuUGXv80_irZQ-1; Tue, 07 Jul 2020 17:25:10 -0400
X-MC-Unique: 42hJcmjmPeuUGXv80_irZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86D76100CCC0;
 Tue,  7 Jul 2020 21:25:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D6F7510013C2;
 Tue,  7 Jul 2020 21:25:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D743911326F3; Tue,  7 Jul 2020 23:25:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/53] qemu-option: Make uses of find_desc_by_name() more
 similar
Date: Tue,  7 Jul 2020 23:24:18 +0200
Message-Id: <20200707212503.1495927-9-armbru@redhat.com>
In-Reply-To: <20200707212503.1495927-1-armbru@redhat.com>
References: <20200707212503.1495927-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
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

This is to make the next commit easier to review.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <20200707160613.848843-9-armbru@redhat.com>
---
 util/qemu-option.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index fd1fd23521..1df55bc881 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -270,6 +270,7 @@ static void qemu_opt_del_all(QemuOpts *opts, const char *name)
 const char *qemu_opt_get(QemuOpts *opts, const char *name)
 {
     QemuOpt *opt;
+    const QemuOptDesc *desc;
 
     if (opts == NULL) {
         return NULL;
@@ -277,7 +278,7 @@ const char *qemu_opt_get(QemuOpts *opts, const char *name)
 
     opt = qemu_opt_find(opts, name);
     if (!opt) {
-        const QemuOptDesc *desc = find_desc_by_name(opts->list->desc, name);
+        desc = find_desc_by_name(opts->list->desc, name);
         if (desc && desc->def_value_str) {
             return desc->def_value_str;
         }
@@ -348,6 +349,7 @@ static bool qemu_opt_get_bool_helper(QemuOpts *opts, const char *name,
                                      bool defval, bool del)
 {
     QemuOpt *opt;
+    const QemuOptDesc *desc;
     bool ret = defval;
 
     if (opts == NULL) {
@@ -356,7 +358,7 @@ static bool qemu_opt_get_bool_helper(QemuOpts *opts, const char *name,
 
     opt = qemu_opt_find(opts, name);
     if (opt == NULL) {
-        const QemuOptDesc *desc = find_desc_by_name(opts->list->desc, name);
+        desc = find_desc_by_name(opts->list->desc, name);
         if (desc && desc->def_value_str) {
             parse_option_bool(name, desc->def_value_str, &ret, &error_abort);
         }
@@ -384,6 +386,7 @@ static uint64_t qemu_opt_get_number_helper(QemuOpts *opts, const char *name,
                                            uint64_t defval, bool del)
 {
     QemuOpt *opt;
+    const QemuOptDesc *desc;
     uint64_t ret = defval;
 
     if (opts == NULL) {
@@ -392,7 +395,7 @@ static uint64_t qemu_opt_get_number_helper(QemuOpts *opts, const char *name,
 
     opt = qemu_opt_find(opts, name);
     if (opt == NULL) {
-        const QemuOptDesc *desc = find_desc_by_name(opts->list->desc, name);
+        desc = find_desc_by_name(opts->list->desc, name);
         if (desc && desc->def_value_str) {
             parse_option_number(name, desc->def_value_str, &ret, &error_abort);
         }
@@ -421,6 +424,7 @@ static uint64_t qemu_opt_get_size_helper(QemuOpts *opts, const char *name,
                                          uint64_t defval, bool del)
 {
     QemuOpt *opt;
+    const QemuOptDesc *desc;
     uint64_t ret = defval;
 
     if (opts == NULL) {
@@ -429,7 +433,7 @@ static uint64_t qemu_opt_get_size_helper(QemuOpts *opts, const char *name,
 
     opt = qemu_opt_find(opts, name);
     if (opt == NULL) {
-        const QemuOptDesc *desc = find_desc_by_name(opts->list->desc, name);
+        desc = find_desc_by_name(opts->list->desc, name);
         if (desc && desc->def_value_str) {
             parse_option_size(name, desc->def_value_str, &ret, &error_abort);
         }
@@ -540,18 +544,18 @@ void qemu_opt_set_bool(QemuOpts *opts, const char *name, bool val,
                        Error **errp)
 {
     QemuOpt *opt;
-    const QemuOptDesc *desc = opts->list->desc;
+    const QemuOptDesc *desc;
 
-    opt = g_malloc0(sizeof(*opt));
-    opt->desc = find_desc_by_name(desc, name);
-    if (!opt->desc && !opts_accepts_any(opts)) {
+    desc = find_desc_by_name(opts->list->desc, name);
+    if (!desc && !opts_accepts_any(opts)) {
         error_setg(errp, QERR_INVALID_PARAMETER, name);
-        g_free(opt);
         return;
     }
 
+    opt = g_malloc0(sizeof(*opt));
     opt->name = g_strdup(name);
     opt->opts = opts;
+    opt->desc = desc;
     opt->value.boolean = !!val;
     opt->str = g_strdup(val ? "on" : "off");
     QTAILQ_INSERT_TAIL(&opts->head, opt, next);
@@ -561,18 +565,18 @@ void qemu_opt_set_number(QemuOpts *opts, const char *name, int64_t val,
                          Error **errp)
 {
     QemuOpt *opt;
-    const QemuOptDesc *desc = opts->list->desc;
+    const QemuOptDesc *desc;
 
-    opt = g_malloc0(sizeof(*opt));
-    opt->desc = find_desc_by_name(desc, name);
-    if (!opt->desc && !opts_accepts_any(opts)) {
+    desc = find_desc_by_name(opts->list->desc, name);
+    if (!desc && !opts_accepts_any(opts)) {
         error_setg(errp, QERR_INVALID_PARAMETER, name);
-        g_free(opt);
         return;
     }
 
+    opt = g_malloc0(sizeof(*opt));
     opt->name = g_strdup(name);
     opt->opts = opts;
+    opt->desc = desc;
     opt->value.uint = val;
     opt->str = g_strdup_printf("%" PRId64, val);
     QTAILQ_INSERT_TAIL(&opts->head, opt, next);
-- 
2.26.2


