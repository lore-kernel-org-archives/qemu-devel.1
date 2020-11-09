Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530D8C56201
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCF732068D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Flm5sAA5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF732068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc7Yf-0007un-MR
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 08:50:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kc7Oe-00054c-E4
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:39:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46716)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kc7Oc-0000mf-8b
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604929185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wBcRfdslejd3RJsY6JwM1wVDqzPn+e9pnKz9YiNEbak=;
 b=Flm5sAA5LdGSEbbJZ0P/oTq6bKoldDAqD9wuxnhIbw8dLJ/MROz/6dTgjLPnCAtLRq/iq1
 YuvLuW1HThcE5+qZtqqc61knEaIyiCUbkJDukwBb4f25Kw+dtIzd6fnx/cBDWiMmWHJNsG
 XNnWnJu+Jv0UJuSwjGSfdS42Cp2WAsM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-OG2s4d_iPpy5ms4W7hx0CQ-1; Mon, 09 Nov 2020 08:39:39 -0500
X-MC-Unique: OG2s4d_iPpy5ms4W7hx0CQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3B954239D
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 13:39:37 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 96A8F6EF40;
 Mon,  9 Nov 2020 13:39:37 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/6] qemu-option: warn for short-form boolean options
Date: Mon,  9 Nov 2020 08:39:31 -0500
Message-Id: <20201109133931.979563-7-pbonzini@redhat.com>
In-Reply-To: <20201109133931.979563-1-pbonzini@redhat.com>
References: <20201109133931.979563-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
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

Options such as "server" or "nowait", that are commonly found in -chardev,
are sugar for "server=on" and "wait=off".  This is quite surprising and
also does not have any notion of typing attached.  It is even possible to
do "-device e1000,noid" and get a device with "id=off".

Deprecate it and print a warning when it is encountered.  In general,
this short form for boolean options only seems to be in wide use for
-chardev and -spice.

The extra boolean argument is not my favorite.  In 6.0 I plan to remove
qemu_opts_set_defaults by switching -M to keyval, and therefore quite
a bit of QemuOpts code will go away.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/system/deprecated.rst |  6 ++++++
 tests/test-qemu-opts.c     |  2 +-
 util/qemu-option.c         | 29 ++++++++++++++++++-----------
 3 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 8c1dc7645d..f45938a5ff 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -146,6 +146,12 @@ Drives with interface types other than ``if=none`` are for onboard
 devices.  It is possible to use drives the board doesn't pick up with
 -device.  This usage is now deprecated.  Use ``if=none`` instead.
 
+Short-form boolean options (since 5.2)
+''''''''''''''''''''''''''''''''''''''
+
+Boolean options such as ``share=on``/``share=off`` can be written
+in short form as ``share`` and ``noshare``.  This is deprecated
+and will cause a warning.
 
 QEMU Machine Protocol (QMP) commands
 ------------------------------------
diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
index 322b32871b..e12fb51032 100644
--- a/tests/test-qemu-opts.c
+++ b/tests/test-qemu-opts.c
@@ -519,7 +519,7 @@ static void test_opts_parse(void)
     error_free_or_abort(&err);
     g_assert(!opts);
 
-    /* Implied value */
+    /* Implied value (qemu_opts_parse does not warn) */
     opts = qemu_opts_parse(&opts_list_03, "an,noaus,noaus=",
                            false, &error_abort);
     g_assert_cmpuint(opts_count(opts), ==, 3);
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 0ddf1f7b45..23238f00ea 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -756,10 +756,12 @@ void qemu_opts_print(QemuOpts *opts, const char *separator)
 
 static const char *get_opt_name_value(const char *params,
                                       const char *firstname,
+                                      bool warn_on_flag,
                                       bool *help_wanted,
                                       char **name, char **value)
 {
     const char *p;
+    const char *prefix = "";
     size_t len;
     bool is_help = false;
 
@@ -776,10 +778,15 @@ static const char *get_opt_name_value(const char *params,
             if (strncmp(*name, "no", 2) == 0) {
                 memmove(*name, *name + 2, strlen(*name + 2) + 1);
                 *value = g_strdup("off");
+                prefix = "no";
             } else {
                 *value = g_strdup("on");
                 is_help = is_help_option(*name);
             }
+            if (!is_help && warn_on_flag) {
+                warn_report("short-form boolean option '%s%s' deprecated", prefix, *name);
+                error_printf("Please use %s=%s instead\n", *name, *value);
+            }
         }
     } else {
         /* found "foo=bar,more" */
@@ -801,14 +808,14 @@ static const char *get_opt_name_value(const char *params,
 
 static bool opts_do_parse(QemuOpts *opts, const char *params,
                           const char *firstname, bool prepend,
-                          bool *help_wanted, Error **errp)
+                          bool warn_on_flag, bool *help_wanted, Error **errp)
 {
     char *option, *value;
     const char *p;
     QemuOpt *opt;
 
     for (p = params; *p;) {
-        p = get_opt_name_value(p, firstname, help_wanted, &option, &value);
+        p = get_opt_name_value(p, firstname, warn_on_flag, help_wanted, &option, &value);
         if (help_wanted && *help_wanted) {
             return false;
         }
@@ -837,7 +844,7 @@ static char *opts_parse_id(const char *params)
     char *name, *value;
 
     for (p = params; *p;) {
-        p = get_opt_name_value(p, NULL, NULL, &name, &value);
+        p = get_opt_name_value(p, NULL, false, NULL, &name, &value);
         if (!strcmp(name, "id")) {
             g_free(name);
             return value;
@@ -856,7 +863,7 @@ bool has_help_option(const char *params)
     bool ret;
 
     for (p = params; *p;) {
-        p = get_opt_name_value(p, NULL, &ret, &name, &value);
+        p = get_opt_name_value(p, NULL, false, &ret, &name, &value);
         g_free(name);
         g_free(value);
         if (ret) {
@@ -876,12 +883,12 @@ bool has_help_option(const char *params)
 bool qemu_opts_do_parse(QemuOpts *opts, const char *params,
                        const char *firstname, Error **errp)
 {
-    return opts_do_parse(opts, params, firstname, false, NULL, errp);
+    return opts_do_parse(opts, params, firstname, false, false, NULL, errp);
 }
 
 static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
                             bool permit_abbrev, bool defaults,
-                            bool *help_wanted, Error **errp)
+                            bool warn_on_flag, bool *help_wanted, Error **errp)
 {
     const char *firstname;
     char *id = opts_parse_id(params);
@@ -904,8 +911,8 @@ static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
         return NULL;
     }
 
-    if (!opts_do_parse(opts, params, firstname, defaults, help_wanted,
-                       errp)) {
+    if (!opts_do_parse(opts, params, firstname, defaults,
+                       warn_on_flag, help_wanted, errp)) {
         qemu_opts_del(opts);
         return NULL;
     }
@@ -923,7 +930,7 @@ static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
 QemuOpts *qemu_opts_parse(QemuOptsList *list, const char *params,
                           bool permit_abbrev, Error **errp)
 {
-    return opts_parse(list, params, permit_abbrev, false, NULL, errp);
+    return opts_parse(list, params, permit_abbrev, false, false, NULL, errp);
 }
 
 /**
@@ -941,7 +948,7 @@ QemuOpts *qemu_opts_parse_noisily(QemuOptsList *list, const char *params,
     QemuOpts *opts;
     bool help_wanted = false;
 
-    opts = opts_parse(list, params, permit_abbrev, false,
+    opts = opts_parse(list, params, permit_abbrev, false, true,
                       opts_accepts_any(list) ? NULL : &help_wanted,
                       &err);
     if (!opts) {
@@ -960,7 +967,7 @@ void qemu_opts_set_defaults(QemuOptsList *list, const char *params,
 {
     QemuOpts *opts;
 
-    opts = opts_parse(list, params, permit_abbrev, true, NULL, NULL);
+    opts = opts_parse(list, params, permit_abbrev, true, false, NULL, NULL);
     assert(opts);
 }
 
-- 
2.26.2


