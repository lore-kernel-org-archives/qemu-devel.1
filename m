Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93615C388F9
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:17:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F278220735
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTw8nn+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F278220735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZy3U-0003kL-TN
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:17:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZy1V-0002ES-Uo
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:15:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZy1S-0002vY-RM
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:15:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604416497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xX3PJZ/vpF37kgHozJbvLL9WXGA1QJlGImPglV7fUf4=;
 b=BTw8nn+CnWqA4eMK3AkbTFielxSlXYSEoCnqYHXdbwG7Babk8heSJPOfht+dcbJ34CnLIL
 K857es918SNPXyIyl0Jk10bXWiUjZKu5lBx6xc1weipIoSyWGmj3aKVb51cAy1/T8QbkTz
 HGaoDf98YgcB/7z9h2OQm4xK1MLdF+w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-D_8eCKaSPsW-USEbPWdJHQ-1; Tue, 03 Nov 2020 10:14:56 -0500
X-MC-Unique: D_8eCKaSPsW-USEbPWdJHQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33E9E80B72B
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2020 15:14:55 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D7FDC10016DA;
 Tue,  3 Nov 2020 15:14:54 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.2 4/4] qemu-option: warn for short-form boolean options
Date: Tue,  3 Nov 2020 10:14:52 -0500
Message-Id: <20201103151452.416784-5-pbonzini@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Deprecate all this, except for -chardev and -spice where it is in
wide use.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char.c             |  1 +
 docs/system/deprecated.rst |  7 +++++++
 include/qemu/option.h      |  1 +
 tests/test-qemu-opts.c     |  1 +
 ui/spice-core.c            |  1 +
 util/qemu-option.c         | 22 +++++++++++++++-------
 6 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index 78553125d3..108da615df 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -829,6 +829,7 @@ Chardev *qemu_chr_find(const char *name)
 
 QemuOptsList qemu_chardev_opts = {
     .name = "chardev",
+    .allow_flag_options = true, /* server, nowait, etc. */
     .implied_opt_name = "backend",
     .head = QTAILQ_HEAD_INITIALIZER(qemu_chardev_opts.head),
     .desc = {
diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 32a0e620db..0e7edf7e56 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -146,6 +146,13 @@ Drives with interface types other than ``if=none`` are for onboard
 devices.  It is possible to use drives the board doesn't pick up with
 -device.  This usage is now deprecated.  Use ``if=none`` instead.
 
+Short-form boolean options (since 5.2)
+''''''''''''''''''''''''''''''''''''''
+
+Boolean options such as ``share=on``/``share=off`` can be written
+in short form as ``share`` and ``noshare``.  This is deprecated
+for all command-line options except ``-chardev` and ``-spice``, for
+which the short form was in wide use.
 
 QEMU Machine Protocol (QMP) commands
 ------------------------------------
diff --git a/include/qemu/option.h b/include/qemu/option.h
index ac69352e0e..046ac06a1f 100644
--- a/include/qemu/option.h
+++ b/include/qemu/option.h
@@ -65,6 +65,7 @@ struct QemuOptsList {
     const char *name;
     const char *implied_opt_name;
     bool merge_lists;  /* Merge multiple uses of option into a single list? */
+    bool allow_flag_options; /* Whether to warn for short-form boolean options */
     QTAILQ_HEAD(, QemuOpts) head;
     QemuOptDesc desc[];
 };
diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
index 297ffe79dd..a74c475773 100644
--- a/tests/test-qemu-opts.c
+++ b/tests/test-qemu-opts.c
@@ -77,6 +77,7 @@ static QemuOptsList opts_list_02 = {
 static QemuOptsList opts_list_03 = {
     .name = "opts_list_03",
     .implied_opt_name = "implied",
+    .allow_flag_options = true,
     .head = QTAILQ_HEAD_INITIALIZER(opts_list_03.head),
     .desc = {
         /* no elements => accept any params */
diff --git a/ui/spice-core.c b/ui/spice-core.c
index eea52f5389..08f834fa41 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -397,6 +397,7 @@ static SpiceChannelList *qmp_query_spice_channels(void)
 
 static QemuOptsList qemu_spice_opts = {
     .name = "spice",
+    .allow_flag_options = true, /* disable-agent-file-xfer, sasl, unix, etc. */
     .head = QTAILQ_HEAD_INITIALIZER(qemu_spice_opts.head),
     .merge_lists = true,
     .desc = {
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 5824b7afe2..8b6050fbf7 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -779,16 +779,19 @@ void qemu_opts_print(QemuOpts *opts, const char *separator)
 
 static const char *get_opt_name_value(const char *params,
                                       const char *firstname,
+                                      bool warn_on_flag,
                                       bool *help_wanted,
                                       char **name, char **value)
 {
     const char *p;
+    const char *prefix = "";
     size_t len;
 
     len = strcspn(params, "=,");
     if (params[len] != '=') {
         if (help_wanted && starts_with_help_option(params) == len) {
             *help_wanted = true;
+            warn_on_flag = false;
         }
         /* found "foo,more" */
         if (firstname) {
@@ -801,9 +804,14 @@ static const char *get_opt_name_value(const char *params,
             if (strncmp(*name, "no", 2) == 0) {
                 memmove(*name, *name + 2, strlen(*name + 2) + 1);
                 *value = g_strdup("off");
+                prefix = "no";
             } else {
                 *value = g_strdup("on");
             }
+            if (warn_on_flag) {
+                error_report("short-form boolean option '%s%s' deprecated", prefix, *name);
+                error_printf("Please use %s=%s instead\n", *name, *value);
+            }
         }
     } else {
         /* found "foo=bar,more" */
@@ -822,14 +830,14 @@ static const char *get_opt_name_value(const char *params,
 
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
@@ -858,7 +866,7 @@ static char *opts_parse_id(const char *params)
     char *name, *value;
 
     for (p = params; *p;) {
-        p = get_opt_name_value(p, NULL, NULL, &name, &value);
+        p = get_opt_name_value(p, NULL, false, NULL, &name, &value);
         if (!strcmp(name, "id")) {
             g_free(name);
             return value;
@@ -877,7 +885,7 @@ bool has_help_option(const char *params)
     bool ret = false;
 
     for (p = params; *p;) {
-        p = get_opt_name_value(p, NULL, &ret, &name, &value);
+        p = get_opt_name_value(p, NULL, false, &ret, &name, &value);
         g_free(name);
         g_free(value);
         if (ret) {
@@ -897,7 +905,7 @@ bool has_help_option(const char *params)
 bool qemu_opts_do_parse(QemuOpts *opts, const char *params,
                        const char *firstname, Error **errp)
 {
-    return opts_do_parse(opts, params, firstname, false, NULL, errp);
+    return opts_do_parse(opts, params, firstname, false, false, NULL, errp);
 }
 
 static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
@@ -925,8 +933,8 @@ static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
         return NULL;
     }
 
-    if (!opts_do_parse(opts, params, firstname, defaults, help_wanted,
-                       errp)) {
+    if (!opts_do_parse(opts, params, firstname, defaults,
+                       !list->allow_flag_options, help_wanted, errp)) {
         qemu_opts_del(opts);
         return NULL;
     }
-- 
2.26.2


