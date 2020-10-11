Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A20C43457
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 07:39:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BC3D207E8
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 07:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="br1lR/2w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC3D207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRVwa-0003LY-IP
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 03:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kRVt0-0006Dx-OB
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 03:35:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38902)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kRVst-0003Gc-Sl
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 03:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602401710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZTl0kR94cDCo2wcg1ej3auFcYnpluSbKmityLUPHEcw=;
 b=br1lR/2wAlgKNdR3UvHzwp5f6Q09P5HB1SM6krJpBV8e2KCA2Me53h3smJAnBquaZOxvPS
 dxulmz1UTd4ffFo8qJqI/qX0wYsdj1Kd/N1CcrOSa4oRRtZso+WMutG1zkkyqXe5z5L+fz
 SnEem56WT+Jql3Kz5swqEIKgOrRrlA0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-S9O-7PqTP-W8cEPRCII9BA-1; Sun, 11 Oct 2020 03:35:08 -0400
X-MC-Unique: S9O-7PqTP-W8cEPRCII9BA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47D47427FA;
 Sun, 11 Oct 2020 07:35:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B772709BB;
 Sun, 11 Oct 2020 07:35:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1F41A112CE12; Sun, 11 Oct 2020 09:35:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 4/7] keyval: Parse help options
Date: Sun, 11 Oct 2020 09:35:02 +0200
Message-Id: <20201011073505.1185335-5-armbru@redhat.com>
In-Reply-To: <20201011073505.1185335-1-armbru@redhat.com>
References: <20201011073505.1185335-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 00:55:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kevin Wolf <kwolf@redhat.com>

This adds a special meaning for 'help' and '?' as options to the keyval
parser. Instead of being an error (because of a missing value) or a
value for an implied key, they now request help, which is a new boolean
output of the parser in addition to the QDict.

A new parameter 'p_help' is added to keyval_parse() that contains on
return whether help was requested. If NULL is passed, requesting help
results in an error and all other cases work like before.

Turning previous error cases into help is a compatible extension. The
behaviour potentially changes for implied keys: They could previously
get 'help' as their value, which is now interpreted as requesting help.

This is not a problem in practice because 'help' and '?' are not a valid
values for the implied key of any option parsed with keyval_parse():

* audiodev: union Audiodev, implied key "driver" is enum AudiodevDriver,
  "help" and "?" are not among its values

* display: union DisplayOptions, implied key "type" is enum
  DisplayType, "help" and "?" are not among its values

* blockdev: union BlockdevOptions, implied key "driver is enum
  BlockdevDriver, "help" and "?" are not among its values

* export: union BlockExport, implied key "type" is enum BlockExportType,
  "help" and "?" are not among its values

* monitor: struct MonitorOptions, implied key "mode" is enum MonitorMode,
  "help" and "?" are not among its values

* nbd-server: struct NbdServerOptions, no implied key.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qemu/help_option.h           |  11 ++
 include/qemu/option.h                |   2 +-
 qapi/qobject-input-visitor.c         |   2 +-
 storage-daemon/qemu-storage-daemon.c |   2 +-
 tests/test-keyval.c                  | 184 ++++++++++++++++++---------
 util/keyval.c                        |  63 +++++++--
 6 files changed, 186 insertions(+), 78 deletions(-)

diff --git a/include/qemu/help_option.h b/include/qemu/help_option.h
index 328d2a89fd..ca6389a154 100644
--- a/include/qemu/help_option.h
+++ b/include/qemu/help_option.h
@@ -19,4 +19,15 @@ static inline bool is_help_option(const char *s)
     return !strcmp(s, "?") || !strcmp(s, "help");
 }
 
+static inline int starts_with_help_option(const char *s)
+{
+    if (*s == '?') {
+        return 1;
+    }
+    if (g_str_has_prefix(s, "help")) {
+        return 4;
+    }
+    return 0;
+}
+
 #endif
diff --git a/include/qemu/option.h b/include/qemu/option.h
index 05e8a15c73..ac69352e0e 100644
--- a/include/qemu/option.h
+++ b/include/qemu/option.h
@@ -149,6 +149,6 @@ void qemu_opts_free(QemuOptsList *list);
 QemuOptsList *qemu_opts_append(QemuOptsList *dst, QemuOptsList *list);
 
 QDict *keyval_parse(const char *params, const char *implied_key,
-                    Error **errp);
+                    bool *help, Error **errp);
 
 #endif
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index f918a05e5f..7b184b50a7 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -757,7 +757,7 @@ Visitor *qobject_input_visitor_new_str(const char *str,
         assert(args);
         v = qobject_input_visitor_new(QOBJECT(args));
     } else {
-        args = keyval_parse(str, implied_key, errp);
+        args = keyval_parse(str, implied_key, NULL, errp);
         if (!args) {
             return NULL;
         }
diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu-storage-daemon.c
index 1ae1cda481..6f0e0cfb36 100644
--- a/storage-daemon/qemu-storage-daemon.c
+++ b/storage-daemon/qemu-storage-daemon.c
@@ -278,7 +278,7 @@ static void process_options(int argc, char *argv[])
                 }
                 qemu_opts_del(opts);
 
-                args = keyval_parse(optarg, "qom-type", &error_fatal);
+                args = keyval_parse(optarg, "qom-type", NULL, &error_fatal);
                 user_creatable_add_dict(args, true, &error_fatal);
                 qobject_unref(args);
                 break;
diff --git a/tests/test-keyval.c b/tests/test-keyval.c
index 04c62cf045..7b459900af 100644
--- a/tests/test-keyval.c
+++ b/tests/test-keyval.c
@@ -1,3 +1,4 @@
+
 /*
  * Unit tests for parsing of KEY=VALUE,... strings
  *
@@ -27,27 +28,28 @@ static void test_keyval_parse(void)
     QDict *qdict, *sub_qdict;
     char long_key[129];
     char *params;
+    bool help;
 
     /* Nothing */
-    qdict = keyval_parse("", NULL, &error_abort);
+    qdict = keyval_parse("", NULL, NULL, &error_abort);
     g_assert_cmpuint(qdict_size(qdict), ==, 0);
     qobject_unref(qdict);
 
     /* Empty key (qemu_opts_parse() accepts this) */
-    qdict = keyval_parse("=val", NULL, &err);
+    qdict = keyval_parse("=val", NULL, NULL, &err);
     error_free_or_abort(&err);
     g_assert(!qdict);
 
     /* Empty key fragment */
-    qdict = keyval_parse(".", NULL, &err);
+    qdict = keyval_parse(".", NULL, NULL, &err);
     error_free_or_abort(&err);
     g_assert(!qdict);
-    qdict = keyval_parse("key.", NULL, &err);
+    qdict = keyval_parse("key.", NULL, NULL, &err);
     error_free_or_abort(&err);
     g_assert(!qdict);
 
     /* Invalid non-empty key (qemu_opts_parse() doesn't care) */
-    qdict = keyval_parse("7up=val", NULL, &err);
+    qdict = keyval_parse("7up=val", NULL, NULL, &err);
     error_free_or_abort(&err);
     g_assert(!qdict);
 
@@ -56,25 +58,25 @@ static void test_keyval_parse(void)
     long_key[127] = 'z';
     long_key[128] = 0;
     params = g_strdup_printf("k.%s=v", long_key);
-    qdict = keyval_parse(params + 2, NULL, &err);
+    qdict = keyval_parse(params + 2, NULL, NULL, &err);
     error_free_or_abort(&err);
     g_assert(!qdict);
 
     /* Overlong key fragment */
-    qdict = keyval_parse(params, NULL, &err);
+    qdict = keyval_parse(params, NULL, NULL, &err);
     error_free_or_abort(&err);
     g_assert(!qdict);
     g_free(params);
 
     /* Long key (qemu_opts_parse() accepts and truncates silently) */
     params = g_strdup_printf("k.%s=v", long_key + 1);
-    qdict = keyval_parse(params + 2, NULL, &error_abort);
+    qdict = keyval_parse(params + 2, NULL, NULL, &error_abort);
     g_assert_cmpuint(qdict_size(qdict), ==, 1);
     g_assert_cmpstr(qdict_get_try_str(qdict, long_key + 1), ==, "v");
     qobject_unref(qdict);
 
     /* Long key fragment */
-    qdict = keyval_parse(params, NULL, &error_abort);
+    qdict = keyval_parse(params, NULL, NULL, &error_abort);
     g_assert_cmpuint(qdict_size(qdict), ==, 1);
     sub_qdict = qdict_get_qdict(qdict, "k");
     g_assert(sub_qdict);
@@ -84,25 +86,25 @@ static void test_keyval_parse(void)
     g_free(params);
 
     /* Crap after valid key */
-    qdict = keyval_parse("key[0]=val", NULL, &err);
+    qdict = keyval_parse("key[0]=val", NULL, NULL, &err);
     error_free_or_abort(&err);
     g_assert(!qdict);
 
     /* Multiple keys, last one wins */
-    qdict = keyval_parse("a=1,b=2,,x,a=3", NULL, &error_abort);
+    qdict = keyval_parse("a=1,b=2,,x,a=3", NULL, NULL, &error_abort);
     g_assert_cmpuint(qdict_size(qdict), ==, 2);
     g_assert_cmpstr(qdict_get_try_str(qdict, "a"), ==, "3");
     g_assert_cmpstr(qdict_get_try_str(qdict, "b"), ==, "2,x");
     qobject_unref(qdict);
 
     /* Even when it doesn't in qemu_opts_parse() */
-    qdict = keyval_parse("id=foo,id=bar", NULL, &error_abort);
+    qdict = keyval_parse("id=foo,id=bar", NULL, NULL, &error_abort);
     g_assert_cmpuint(qdict_size(qdict), ==, 1);
     g_assert_cmpstr(qdict_get_try_str(qdict, "id"), ==, "bar");
     qobject_unref(qdict);
 
     /* Dotted keys */
-    qdict = keyval_parse("a.b.c=1,a.b.c=2,d=3", NULL, &error_abort);
+    qdict = keyval_parse("a.b.c=1,a.b.c=2,d=3", NULL, NULL, &error_abort);
     g_assert_cmpuint(qdict_size(qdict), ==, 2);
     sub_qdict = qdict_get_qdict(qdict, "a");
     g_assert(sub_qdict);
@@ -115,48 +117,48 @@ static void test_keyval_parse(void)
     qobject_unref(qdict);
 
     /* Inconsistent dotted keys */
-    qdict = keyval_parse("a.b=1,a=2", NULL, &err);
+    qdict = keyval_parse("a.b=1,a=2", NULL, NULL, &err);
     error_free_or_abort(&err);
     g_assert(!qdict);
-    qdict = keyval_parse("a.b=1,a.b.c=2", NULL, &err);
+    qdict = keyval_parse("a.b=1,a.b.c=2", NULL, NULL, &err);
     error_free_or_abort(&err);
     g_assert(!qdict);
 
     /* Trailing comma is ignored */
-    qdict = keyval_parse("x=y,", NULL, &error_abort);
+    qdict = keyval_parse("x=y,", NULL, NULL, &error_abort);
     g_assert_cmpuint(qdict_size(qdict), ==, 1);
     g_assert_cmpstr(qdict_get_try_str(qdict, "x"), ==, "y");
     qobject_unref(qdict);
 
     /* Except when it isn't */
-    qdict = keyval_parse(",", NULL, &err);
+    qdict = keyval_parse(",", NULL, NULL, &err);
     error_free_or_abort(&err);
     g_assert(!qdict);
 
     /* Value containing ,id= not misinterpreted as qemu_opts_parse() does */
-    qdict = keyval_parse("x=,,id=bar", NULL, &error_abort);
+    qdict = keyval_parse("x=,,id=bar", NULL, NULL, &error_abort);
     g_assert_cmpuint(qdict_size(qdict), ==, 1);
     g_assert_cmpstr(qdict_get_try_str(qdict, "x"), ==, ",id=bar");
     qobject_unref(qdict);
 
     /* Anti-social ID is left to caller (qemu_opts_parse() rejects it) */
-    qdict = keyval_parse("id=666", NULL, &error_abort);
+    qdict = keyval_parse("id=666", NULL, NULL, &error_abort);
     g_assert_cmpuint(qdict_size(qdict), ==, 1);
     g_assert_cmpstr(qdict_get_try_str(qdict, "id"), ==, "666");
     qobject_unref(qdict);
 
     /* Implied value not supported (unlike qemu_opts_parse()) */
-    qdict = keyval_parse("an,noaus,noaus=", NULL, &err);
+    qdict = keyval_parse("an,noaus,noaus=", NULL, NULL, &err);
     error_free_or_abort(&err);
     g_assert(!qdict);
 
     /* Implied value, key "no" (qemu_opts_parse(): negated empty key) */
-    qdict = keyval_parse("no", NULL, &err);
+    qdict = keyval_parse("no", NULL, NULL, &err);
     error_free_or_abort(&err);
     g_assert(!qdict);
 
     /* Implied key */
-    qdict = keyval_parse("an,aus=off,noaus=", "implied", &error_abort);
+    qdict = keyval_parse("an,aus=off,noaus=", "implied", NULL, &error_abort);
     g_assert_cmpuint(qdict_size(qdict), ==, 3);
     g_assert_cmpstr(qdict_get_try_str(qdict, "implied"), ==, "an");
     g_assert_cmpstr(qdict_get_try_str(qdict, "aus"), ==, "off");
@@ -164,7 +166,7 @@ static void test_keyval_parse(void)
     qobject_unref(qdict);
 
     /* Implied dotted key */
-    qdict = keyval_parse("val", "eins.zwei", &error_abort);
+    qdict = keyval_parse("val", "eins.zwei", NULL, &error_abort);
     g_assert_cmpuint(qdict_size(qdict), ==, 1);
     sub_qdict = qdict_get_qdict(qdict, "eins");
     g_assert(sub_qdict);
@@ -173,24 +175,81 @@ static void test_keyval_parse(void)
     qobject_unref(qdict);
 
     /* Implied key with empty value (qemu_opts_parse() accepts this) */
-    qdict = keyval_parse(",", "implied", &err);
+    qdict = keyval_parse(",", "implied", NULL, &err);
     error_free_or_abort(&err);
     g_assert(!qdict);
 
     /* Likewise (qemu_opts_parse(): implied key with comma value) */
-    qdict = keyval_parse(",,,a=1", "implied", &err);
+    qdict = keyval_parse(",,,a=1", "implied", NULL, &err);
     error_free_or_abort(&err);
     g_assert(!qdict);
 
     /* Implied key's value can't have comma (qemu_opts_parse(): it can) */
-    qdict = keyval_parse("val,,ue", "implied", &err);
+    qdict = keyval_parse("val,,ue", "implied", NULL, &err);
     error_free_or_abort(&err);
     g_assert(!qdict);
 
     /* Empty key is not an implied key */
-    qdict = keyval_parse("=val", "implied", &err);
+    qdict = keyval_parse("=val", "implied", NULL, &err);
     error_free_or_abort(&err);
     g_assert(!qdict);
+
+    /* "help" by itself, without implied key */
+    qdict = keyval_parse("help", NULL, &help, &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 0);
+    g_assert(help);
+    qobject_unref(qdict);
+
+    /* "help" by itself, with implied key */
+    qdict = keyval_parse("help", "implied", &help, &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 0);
+    g_assert(help);
+    qobject_unref(qdict);
+
+    /* "help" when no help is available, without implied key */
+    qdict = keyval_parse("help", NULL, NULL, &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+
+    /* "help" when no help is available, with implied key */
+    qdict = keyval_parse("help", "implied", NULL, &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+
+    /* Key "help" */
+    qdict = keyval_parse("help=on", NULL, &help, &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 1);
+    g_assert_cmpstr(qdict_get_try_str(qdict, "help"), ==, "on");
+    g_assert(!help);
+    qobject_unref(qdict);
+
+    /* "help" followed by crap, without implied key */
+    qdict = keyval_parse("help.abc", NULL, &help, &err);
+    error_free_or_abort(&err);
+    g_assert(!qdict);
+
+    /* "help" followed by crap, with implied key */
+    qdict = keyval_parse("help.abc", "implied", &help, &err);
+    g_assert_cmpuint(qdict_size(qdict), ==, 1);
+    g_assert_cmpstr(qdict_get_try_str(qdict, "implied"), ==, "help.abc");
+    g_assert(!help);
+    qobject_unref(qdict);
+
+    /* "help" with other stuff, without implied key */
+    qdict = keyval_parse("number=42,help,foo=bar", NULL, &help, &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 2);
+    g_assert_cmpstr(qdict_get_try_str(qdict, "number"), ==, "42");
+    g_assert_cmpstr(qdict_get_try_str(qdict, "foo"), ==, "bar");
+    g_assert(help);
+    qobject_unref(qdict);
+
+    /* "help" with other stuff, with implied key */
+    qdict = keyval_parse("val,help,foo=bar", "implied", &help, &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 2);
+    g_assert_cmpstr(qdict_get_try_str(qdict, "implied"), ==, "val");
+    g_assert_cmpstr(qdict_get_try_str(qdict, "foo"), ==, "bar");
+    g_assert(help);
+    qobject_unref(qdict);
 }
 
 static void check_list012(QList *qlist)
@@ -215,26 +274,26 @@ static void test_keyval_parse_list(void)
     QDict *qdict, *sub_qdict;
 
     /* Root can't be a list */
-    qdict = keyval_parse("0=1", NULL, &err);
+    qdict = keyval_parse("0=1", NULL, NULL, &err);
     error_free_or_abort(&err);
     g_assert(!qdict);
 
     /* List elements need not be in order */
-    qdict = keyval_parse("list.0=null,list.2=zwei,list.1=eins",
-                         NULL, &error_abort);
+    qdict = keyval_parse("list.0=null,list.2=zwei,list.1=eins", NULL, NULL,
+                         &error_abort);
     g_assert_cmpint(qdict_size(qdict), ==, 1);
     check_list012(qdict_get_qlist(qdict, "list"));
     qobject_unref(qdict);
 
     /* Multiple indexes, last one wins */
     qdict = keyval_parse("list.1=goner,list.0=null,list.01=eins,list.2=zwei",
-                         NULL, &error_abort);
+                         NULL, NULL, &error_abort);
     g_assert_cmpint(qdict_size(qdict), ==, 1);
     check_list012(qdict_get_qlist(qdict, "list"));
     qobject_unref(qdict);
 
     /* List at deeper nesting */
-    qdict = keyval_parse("a.list.1=eins,a.list.00=null,a.list.2=zwei",
+    qdict = keyval_parse("a.list.1=eins,a.list.00=null,a.list.2=zwei", NULL,
                          NULL, &error_abort);
     g_assert_cmpint(qdict_size(qdict), ==, 1);
     sub_qdict = qdict_get_qdict(qdict, "a");
@@ -243,18 +302,19 @@ static void test_keyval_parse_list(void)
     qobject_unref(qdict);
 
     /* Inconsistent dotted keys: both list and dictionary */
-    qdict = keyval_parse("a.b.c=1,a.b.0=2", NULL, &err);
+    qdict = keyval_parse("a.b.c=1,a.b.0=2", NULL, NULL, &err);
     error_free_or_abort(&err);
     g_assert(!qdict);
-    qdict = keyval_parse("a.0.c=1,a.b.c=2", NULL, &err);
+    qdict = keyval_parse("a.0.c=1,a.b.c=2", NULL, NULL, &err);
     error_free_or_abort(&err);
     g_assert(!qdict);
 
     /* Missing list indexes */
-    qdict = keyval_parse("list.1=lonely", NULL, &err);
+    qdict = keyval_parse("list.1=lonely", NULL, NULL, &err);
     error_free_or_abort(&err);
     g_assert(!qdict);
-    qdict = keyval_parse("list.0=null,list.2=eins,list.02=zwei", NULL, &err);
+    qdict = keyval_parse("list.0=null,list.2=eins,list.02=zwei", NULL, NULL,
+                         &err);
     error_free_or_abort(&err);
     g_assert(!qdict);
 }
@@ -266,7 +326,7 @@ static void test_keyval_visit_bool(void)
     QDict *qdict;
     bool b;
 
-    qdict = keyval_parse("bool1=on,bool2=off", NULL, &error_abort);
+    qdict = keyval_parse("bool1=on,bool2=off", NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -278,7 +338,7 @@ static void test_keyval_visit_bool(void)
     visit_end_struct(v, NULL);
     visit_free(v);
 
-    qdict = keyval_parse("bool1=offer", NULL, &error_abort);
+    qdict = keyval_parse("bool1=offer", NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -296,7 +356,7 @@ static void test_keyval_visit_number(void)
     uint64_t u;
 
     /* Lower limit zero */
-    qdict = keyval_parse("number1=0", NULL, &error_abort);
+    qdict = keyval_parse("number1=0", NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -307,7 +367,7 @@ static void test_keyval_visit_number(void)
     visit_free(v);
 
     /* Upper limit 2^64-1 */
-    qdict = keyval_parse("number1=18446744073709551615,number2=-1",
+    qdict = keyval_parse("number1=18446744073709551615,number2=-1", NULL,
                          NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
@@ -321,8 +381,8 @@ static void test_keyval_visit_number(void)
     visit_free(v);
 
     /* Above upper limit */
-    qdict = keyval_parse("number1=18446744073709551616",
-                         NULL, &error_abort);
+    qdict = keyval_parse("number1=18446744073709551616", NULL, NULL,
+                         &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -332,8 +392,8 @@ static void test_keyval_visit_number(void)
     visit_free(v);
 
     /* Below lower limit */
-    qdict = keyval_parse("number1=-18446744073709551616",
-                         NULL, &error_abort);
+    qdict = keyval_parse("number1=-18446744073709551616", NULL, NULL,
+                         &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -343,8 +403,7 @@ static void test_keyval_visit_number(void)
     visit_free(v);
 
     /* Hex and octal */
-    qdict = keyval_parse("number1=0x2a,number2=052",
-                         NULL, &error_abort);
+    qdict = keyval_parse("number1=0x2a,number2=052", NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -357,8 +416,7 @@ static void test_keyval_visit_number(void)
     visit_free(v);
 
     /* Trailing crap */
-    qdict = keyval_parse("number1=3.14,number2=08",
-                         NULL, &error_abort);
+    qdict = keyval_parse("number1=3.14,number2=08", NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -378,7 +436,7 @@ static void test_keyval_visit_size(void)
     uint64_t sz;
 
     /* Lower limit zero */
-    qdict = keyval_parse("sz1=0", NULL, &error_abort);
+    qdict = keyval_parse("sz1=0", NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -394,7 +452,7 @@ static void test_keyval_visit_size(void)
     qdict = keyval_parse("sz1=9007199254740991,"
                          "sz2=9007199254740992,"
                          "sz3=9007199254740993",
-                         NULL, &error_abort);
+                         NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -411,7 +469,7 @@ static void test_keyval_visit_size(void)
     /* Close to signed upper limit 0x7ffffffffffffc00 (53 msbs set) */
     qdict = keyval_parse("sz1=9223372036854774784," /* 7ffffffffffffc00 */
                          "sz2=9223372036854775295", /* 7ffffffffffffdff */
-                         NULL, &error_abort);
+                         NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -426,7 +484,7 @@ static void test_keyval_visit_size(void)
     /* Close to actual upper limit 0xfffffffffffff800 (53 msbs set) */
     qdict = keyval_parse("sz1=18446744073709549568," /* fffffffffffff800 */
                          "sz2=18446744073709550591", /* fffffffffffffbff */
-                         NULL, &error_abort);
+                         NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -441,7 +499,7 @@ static void test_keyval_visit_size(void)
     /* Beyond limits */
     qdict = keyval_parse("sz1=-1,"
                          "sz2=18446744073709550592", /* fffffffffffffc00 */
-                         NULL, &error_abort);
+                         NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -454,7 +512,7 @@ static void test_keyval_visit_size(void)
 
     /* Suffixes */
     qdict = keyval_parse("sz1=8b,sz2=1.5k,sz3=2M,sz4=0.1G,sz5=16777215T",
-                         NULL, &error_abort);
+                         NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -473,7 +531,7 @@ static void test_keyval_visit_size(void)
     visit_free(v);
 
     /* Beyond limit with suffix */
-    qdict = keyval_parse("sz1=16777216T", NULL, &error_abort);
+    qdict = keyval_parse("sz1=16777216T", NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -483,7 +541,7 @@ static void test_keyval_visit_size(void)
     visit_free(v);
 
     /* Trailing crap */
-    qdict = keyval_parse("sz1=0Z,sz2=16Gi", NULL, &error_abort);
+    qdict = keyval_parse("sz1=0Z,sz2=16Gi", NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -502,7 +560,7 @@ static void test_keyval_visit_dict(void)
     QDict *qdict;
     int64_t i;
 
-    qdict = keyval_parse("a.b.c=1,a.b.c=2,d=3", NULL, &error_abort);
+    qdict = keyval_parse("a.b.c=1,a.b.c=2,d=3", NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -520,7 +578,7 @@ static void test_keyval_visit_dict(void)
     visit_end_struct(v, NULL);
     visit_free(v);
 
-    qdict = keyval_parse("a.b=", NULL, &error_abort);
+    qdict = keyval_parse("a.b=", NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -542,7 +600,7 @@ static void test_keyval_visit_list(void)
     QDict *qdict;
     char *s;
 
-    qdict = keyval_parse("a.0=,a.1=I,a.2.0=II", NULL, &error_abort);
+    qdict = keyval_parse("a.0=,a.1=I,a.2.0=II", NULL, NULL, &error_abort);
     /* TODO empty list */
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
@@ -566,7 +624,7 @@ static void test_keyval_visit_list(void)
     visit_end_struct(v, NULL);
     visit_free(v);
 
-    qdict = keyval_parse("a.0=,b.0.0=head", NULL, &error_abort);
+    qdict = keyval_parse("a.0=,b.0.0=head", NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -595,7 +653,7 @@ static void test_keyval_visit_optional(void)
     bool present;
     int64_t i;
 
-    qdict = keyval_parse("a.b=1", NULL, &error_abort);
+    qdict = keyval_parse("a.b=1", NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -631,7 +689,7 @@ static void test_keyval_visit_alternate(void)
      * the string variant if there is one, else an error.
      * TODO make it work for unambiguous cases like AltEnumBool below
      */
-    qdict = keyval_parse("a=1,b=2,c=on", NULL, &error_abort);
+    qdict = keyval_parse("a=1,b=2,c=on", NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -655,7 +713,7 @@ static void test_keyval_visit_any(void)
     QList *qlist;
     QString *qstr;
 
-    qdict = keyval_parse("a.0=null,a.1=1", NULL, &error_abort);
+    qdict = keyval_parse("a.0=null,a.1=1", NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
diff --git a/util/keyval.c b/util/keyval.c
index 8f33a36a7c..14fdd364fa 100644
--- a/util/keyval.c
+++ b/util/keyval.c
@@ -14,10 +14,11 @@
  * KEY=VALUE,... syntax:
  *
  *   key-vals     = [ key-val { ',' key-val } [ ',' ] ]
- *   key-val      = key '=' val
+ *   key-val      = key '=' val | help
  *   key          = key-fragment { '.' key-fragment }
  *   key-fragment = / [^=,.]+ /
  *   val          = { / [^,]+ / | ',,' }
+ *   help         = 'help | '?'
  *
  * Semantics defined by reduction to JSON:
  *
@@ -54,6 +55,9 @@
  *
  * The length of any key-fragment must be between 1 and 127.
  *
+ * If any key-val is help, the object is to be treated as a help
+ * request.
+ *
  * Design flaw: there is no way to denote an empty array or non-root
  * object.  While interpreting "key absent" as empty seems natural
  * (removing a key-val from the input string removes the member when
@@ -75,7 +79,7 @@
  *
  *   key-vals     = [ key-val-1st { ',' key-val } [ ',' ] ]
  *   key-val-1st  = val-no-key | key-val
- *   val-no-key   = / [^=,]+ /
+ *   val-no-key   = / [^=,]+ / - help
  *
  * where val-no-key is syntactic sugar for implied-key=val-no-key.
  *
@@ -89,6 +93,7 @@
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qstring.h"
 #include "qemu/cutils.h"
+#include "qemu/help_option.h"
 #include "qemu/option.h"
 
 /*
@@ -162,15 +167,20 @@ static QObject *keyval_parse_put(QDict *cur,
 }
 
 /*
- * Parse one KEY=VALUE from @params, store result in @qdict.
+ * Parse one parameter from @params.
+ *
+ * If we're looking at KEY=VALUE, store result in @qdict.
  * The first fragment of KEY applies to @qdict.  Subsequent fragments
  * apply to nested QDicts, which are created on demand.  @implied_key
  * is as in keyval_parse().
- * On success, return a pointer to the next KEY=VALUE, or else to '\0'.
+ *
+ * If we're looking at "help" or "?", set *help to true.
+ *
+ * On success, return a pointer to the next parameter, or else to '\0'.
  * On failure, return NULL.
  */
 static const char *keyval_parse_one(QDict *qdict, const char *params,
-                                    const char *implied_key,
+                                    const char *implied_key, bool *help,
                                     Error **errp)
 {
     const char *key, *key_end, *val_end, *s, *end;
@@ -184,11 +194,21 @@ static const char *keyval_parse_one(QDict *qdict, const char *params,
     key = params;
     val_end = NULL;
     len = strcspn(params, "=,");
-    if (implied_key && len && key[len] != '=') {
-        /* Desugar implied key */
-        key = implied_key;
-        val_end = params + len;
-        len = strlen(implied_key);
+    if (len && key[len] != '=') {
+        if (starts_with_help_option(key) == len) {
+            *help = true;
+            s = key + len;
+            if (*s == ',') {
+                s++;
+            }
+            return s;
+        }
+        if (implied_key) {
+            /* Desugar implied key */
+            key = implied_key;
+            val_end = params + len;
+            len = strlen(implied_key);
+        }
     }
     key_end = key + len;
 
@@ -398,21 +418,32 @@ static QObject *keyval_listify(QDict *cur, GSList *key_of_cur, Error **errp)
 
 /*
  * Parse @params in QEMU's traditional KEY=VALUE,... syntax.
+ *
  * If @implied_key, the first KEY= can be omitted.  @implied_key is
  * implied then, and VALUE can't be empty or contain ',' or '='.
+ *
+ * A parameter "help" or "?" without a value isn't added to the
+ * resulting dictionary, but instead is interpreted as help request.
+ * All other options are parsed and returned normally so that context
+ * specific help can be printed.
+ *
+ * If @p_help is not NULL, store whether help is requested there.
+ * If @p_help is NULL and help is requested, fail.
+ *
  * On success, return a dictionary of the parsed keys and values.
  * On failure, store an error through @errp and return NULL.
  */
 QDict *keyval_parse(const char *params, const char *implied_key,
-                    Error **errp)
+                    bool *p_help, Error **errp)
 {
     QDict *qdict = qdict_new();
     QObject *listified;
     const char *s;
+    bool help = false;
 
     s = params;
     while (*s) {
-        s = keyval_parse_one(qdict, s, implied_key, errp);
+        s = keyval_parse_one(qdict, s, implied_key, &help, errp);
         if (!s) {
             qobject_unref(qdict);
             return NULL;
@@ -420,6 +451,14 @@ QDict *keyval_parse(const char *params, const char *implied_key,
         implied_key = NULL;
     }
 
+    if (p_help) {
+        *p_help = help;
+    } else if (help) {
+        error_setg(errp, "Help is not available for this option");
+        qobject_unref(qdict);
+        return NULL;
+    }
+
     listified = keyval_listify(qdict, NULL, errp);
     if (!listified) {
         qobject_unref(qdict);
-- 
2.26.2


