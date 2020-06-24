Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11A6C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:11:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D4862082F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gux+olTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D4862082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo8vV-0000R7-Hq
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 13:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo8Vf-0004IA-Hd
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:44:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52838
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo8VD-000587-As
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593017036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T1CxzJSuKww59L0K/c7s+dgCYGor5N5jJqNWHGKncnU=;
 b=Gux+olTFf81hggoEs1hhWc0diWGcPFM/a5xWnpuYboaQve5D0NY9ULt93eQnJHMUXMLEep
 LHxewyqYCxTj58bqt0aMlPipZP/io25MJO1xdiDMSPxJhSQLXMfAPiIXwOrs91HgKC4LUt
 3HvWjuDpEM3aeN5PstSmvFeVyLVuli4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-nxtTIbj-PJmxS0gblNKqFA-1; Wed, 24 Jun 2020 12:43:52 -0400
X-MC-Unique: nxtTIbj-PJmxS0gblNKqFA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4C92800597;
 Wed, 24 Jun 2020 16:43:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D24E7E59F;
 Wed, 24 Jun 2020 16:43:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0AD4B1138478; Wed, 24 Jun 2020 18:43:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/46] qemu-option: Make uses of find_desc_by_name() more
 similar
Date: Wed, 24 Jun 2020 18:43:09 +0200
Message-Id: <20200624164344.3778251-12-armbru@redhat.com>
In-Reply-To: <20200624164344.3778251-1-armbru@redhat.com>
References: <20200624164344.3778251-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 03:27:53
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

This is to make the next commit easier to review.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 util/qemu-option.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index 6119f971a4..9941005c91 100644
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


