Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0647C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:19:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F113D20735
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mk2cXzFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F113D20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZy5a-000651-1G
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:19:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZy1W-0002FZ-TT
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:15:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57336)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZy1S-0002vx-T3
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:15:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604416498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iIXZc7JoR5bpYG+uhyyignMWIehfTtEWJo7IhSVzeAc=;
 b=Mk2cXzFSAZsugyUdd9OGTVtT0TVhhcYHK9S3IN5cRefUyer3UnIfhNCT9m8krszuRMfFSk
 2LBeqhjN9BdexCTXYjCXJjCBz5u/UnYVnMEYwvAywXrFfJ1cBJegU8+R18JFCUGnWi1KrR
 B6ZhvAulXFhfpnuYDXG0zGcFHh50D8Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-OLdSudozN0izGz3SGq7Lcw-1; Tue, 03 Nov 2020 10:14:55 -0500
X-MC-Unique: OLdSudozN0izGz3SGq7Lcw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47ACF1018F7D
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2020 15:14:54 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED3AB10016DA;
 Tue,  3 Nov 2020 15:14:53 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.2 2/4] qemu-option: move help handling to
 get_opt_name_value
Date: Tue,  3 Nov 2020 10:14:50 -0500
Message-Id: <20201103151452.416784-3-pbonzini@redhat.com>
In-Reply-To: <20201103151452.416784-1-pbonzini@redhat.com>
References: <20201103151452.416784-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Right now, help options are parsed normally and then checked
specially in opt_validate---but only if coming from
qemu_opts_parse or qemu_opts_parse_noisily, not if coming
from qemu_opt_set.

Instead, move the check from opt_validate to the common workhorses
of qemu_opts_parse and qemu_opts_parse_noisily, opts_do_parse and
get_opt_name_value.

This will come in handy in a subsequent patch, which will
raise a warning for "-object memory-backend-ram,share"
("flag" option with no =on/=off part) but not for
"-object memory-backend-ram,help".

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/qemu-option.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index b9f93a7f8b..5824b7afe2 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -520,17 +520,13 @@ static QemuOpt *opt_create(QemuOpts *opts, const char *name, char *value,
     return opt;
 }
 
-static bool opt_validate(QemuOpt *opt, bool *help_wanted,
-                         Error **errp)
+static bool opt_validate(QemuOpt *opt, Error **errp)
 {
     const QemuOptDesc *desc;
 
     desc = find_desc_by_name(opt->opts->list->desc, opt->name);
     if (!desc && !opts_accepts_any(opt->opts)) {
         error_setg(errp, QERR_INVALID_PARAMETER, opt->name);
-        if (help_wanted && is_help_option(opt->name)) {
-            *help_wanted = true;
-        }
         return false;
     }
 
@@ -547,7 +543,7 @@ bool qemu_opt_set(QemuOpts *opts, const char *name, const char *value,
 {
     QemuOpt *opt = opt_create(opts, name, g_strdup(value), false);
 
-    if (!opt_validate(opt, NULL, errp)) {
+    if (!opt_validate(opt, errp)) {
         qemu_opt_del(opt);
         return false;
     }
@@ -783,14 +779,17 @@ void qemu_opts_print(QemuOpts *opts, const char *separator)
 
 static const char *get_opt_name_value(const char *params,
                                       const char *firstname,
+                                      bool *help_wanted,
                                       char **name, char **value)
 {
-    const char *p, *pe, *pc;
-
-    pe = strchr(params, '=');
-    pc = strchr(params, ',');
+    const char *p;
+    size_t len;
 
-    if (!pe || (pc && pc < pe)) {
+    len = strcspn(params, "=,");
+    if (params[len] != '=') {
+        if (help_wanted && starts_with_help_option(params) == len) {
+            *help_wanted = true;
+        }
         /* found "foo,more" */
         if (firstname) {
             /* implicitly named first option */
@@ -830,7 +829,10 @@ static bool opts_do_parse(QemuOpts *opts, const char *params,
     QemuOpt *opt;
 
     for (p = params; *p;) {
-        p = get_opt_name_value(p, firstname, &option, &value);
+        p = get_opt_name_value(p, firstname, help_wanted, &option, &value);
+        if (help_wanted && *help_wanted) {
+            return false;
+        }
         firstname = NULL;
 
         if (!strcmp(option, "id")) {
@@ -841,7 +843,7 @@ static bool opts_do_parse(QemuOpts *opts, const char *params,
 
         opt = opt_create(opts, option, value, prepend);
         g_free(option);
-        if (!opt_validate(opt, help_wanted, errp)) {
+        if (!opt_validate(opt, errp)) {
             qemu_opt_del(opt);
             return false;
         }
@@ -856,7 +858,7 @@ static char *opts_parse_id(const char *params)
     char *name, *value;
 
     for (p = params; *p;) {
-        p = get_opt_name_value(p, NULL, &name, &value);
+        p = get_opt_name_value(p, NULL, NULL, &name, &value);
         if (!strcmp(name, "id")) {
             g_free(name);
             return value;
@@ -872,11 +874,10 @@ bool has_help_option(const char *params)
 {
     const char *p;
     char *name, *value;
-    bool ret;
+    bool ret = false;
 
     for (p = params; *p;) {
-        p = get_opt_name_value(p, NULL, &name, &value);
-        ret = is_help_option(name);
+        p = get_opt_name_value(p, NULL, &ret, &name, &value);
         g_free(name);
         g_free(value);
         if (ret) {
-- 
2.26.2



