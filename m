Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3D3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:53:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BA3320885
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HdN6uSdt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA3320885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr1Wl-0005Sj-Ng
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 11:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jr1Tc-0008Dt-3p
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:50:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50484
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jr1TT-0004nw-NF
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593705007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uRe8uuEMB4tVx1VfEpuZYYPLRfPxPaQE1jGSN5dqRAc=;
 b=HdN6uSdtCzbEDTflQYZuD/2bydjaJHPtQBok2SqrQx/D6iNJJVQ+XOMdFfLKwKyBX3yv9W
 SxdxbGnzMcMDOsGcdce1E3AVfoDJWRDZB06m3BGhUN9HcPrlmpCx8O9rEwzKFW0jEMpkI3
 5ckR3nQvllglWX/jVKFG5qJ8GseEp3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-k54hitH6MIC6TmD9PvkDVg-1; Thu, 02 Jul 2020 11:50:05 -0400
X-MC-Unique: k54hitH6MIC6TmD9PvkDVg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AFBC18FE860;
 Thu,  2 Jul 2020 15:50:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EABF27922F;
 Thu,  2 Jul 2020 15:50:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A760711358BD; Thu,  2 Jul 2020 17:50:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/44] qemu-option: Replace opt_set() by cleaner
 opt_validate()
Date: Thu,  2 Jul 2020 17:49:27 +0200
Message-Id: <20200702155000.3455325-12-armbru@redhat.com>
In-Reply-To: <20200702155000.3455325-1-armbru@redhat.com>
References: <20200702155000.3455325-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:42:59
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

opt_set() frees its argument @value on failure.  Slightly unclean;
functions ideally do nothing on failure.

To tidy this up, move opt_create() from opt_set() into its callers,
along with the cleanup.  Rename opt_set() to opt_validate(), noting
its similarity to qemu_opts_validate().  Drop redundant parameter
@opts; use opt->opts instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 util/qemu-option.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index 1023fe7527..d8233b3b35 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -516,36 +516,39 @@ static QemuOpt *opt_create(QemuOpts *opts, const char *name, char *value,
     return opt;
 }
 
-static void opt_set(QemuOpts *opts, const char *name, char *value,
-                    bool prepend, bool *help_wanted, Error **errp)
+static bool opt_validate(QemuOpt *opt, bool *help_wanted,
+                         Error **errp)
 {
-    QemuOpt *opt;
     const QemuOptDesc *desc;
     Error *local_err = NULL;
 
-    desc = find_desc_by_name(opts->list->desc, name);
-    if (!desc && !opts_accepts_any(opts)) {
-        g_free(value);
-        error_setg(errp, QERR_INVALID_PARAMETER, name);
-        if (help_wanted && is_help_option(name)) {
+    desc = find_desc_by_name(opt->opts->list->desc, opt->name);
+    if (!desc && !opts_accepts_any(opt->opts)) {
+        error_setg(errp, QERR_INVALID_PARAMETER, opt->name);
+        if (help_wanted && is_help_option(opt->name)) {
             *help_wanted = true;
         }
-        return;
+        return false;
     }
 
-    opt = opt_create(opts, name, value, prepend);
     opt->desc = desc;
     qemu_opt_parse(opt, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        qemu_opt_del(opt);
+        return false;
     }
+
+    return true;
 }
 
 void qemu_opt_set(QemuOpts *opts, const char *name, const char *value,
                   Error **errp)
 {
-    opt_set(opts, name, g_strdup(value), false, NULL, errp);
+    QemuOpt *opt = opt_create(opts, name, g_strdup(value), false);
+
+    if (!opt_validate(opt, NULL, errp)) {
+        qemu_opt_del(opt);
+    }
 }
 
 void qemu_opt_set_bool(QemuOpts *opts, const char *name, bool val,
@@ -817,9 +820,9 @@ static void opts_do_parse(QemuOpts *opts, const char *params,
                           const char *firstname, bool prepend,
                           bool *help_wanted, Error **errp)
 {
-    Error *local_err = NULL;
     char *option, *value;
     const char *p;
+    QemuOpt *opt;
 
     for (p = params; *p;) {
         p = get_opt_name_value(p, firstname, &option, &value);
@@ -831,10 +834,10 @@ static void opts_do_parse(QemuOpts *opts, const char *params,
             continue;
         }
 
-        opt_set(opts, option, value, prepend, help_wanted, &local_err);
+        opt = opt_create(opts, option, value, prepend);
         g_free(option);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (!opt_validate(opt, help_wanted, errp)) {
+            qemu_opt_del(opt);
             return;
         }
     }
-- 
2.26.2


