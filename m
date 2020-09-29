Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB11C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 17:32:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F39772075F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 17:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2018yN5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39772075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNJU9-0006Lr-Qk
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 13:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kNJPF-0001R4-Nj
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 13:27:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35386)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kNJP8-0004dP-44
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 13:27:13 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601400425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Ze3IpCeeBHJINX0rGJsKfFQVsbG9FJIgTnLJjyKRNM=;
 b=G2018yN5nO9hrbpCTPYu7zj1ApGaFU6lh/XewWUnyOPWAz8En69YQQMKT04quZSJwYgCKP
 ap3qomdlmyrltxNsruamd4ngGVwh+vwgrOLOVxWbGddppuyoEVVLIVcx+NyA+oeYQSOm4d
 jIj8tCN8AZbE6alJ3ABDhHe7AOfQxx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-j74OhANDMuGk5ycRui0GGA-1; Tue, 29 Sep 2020 13:27:03 -0400
X-MC-Unique: j74OhANDMuGk5ycRui0GGA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09B8D801AE2;
 Tue, 29 Sep 2020 17:27:02 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-115-44.ams2.redhat.com [10.36.115.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94B70100238C;
 Tue, 29 Sep 2020 17:27:00 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/4] keyval: Parse help options
Date: Tue, 29 Sep 2020 19:26:46 +0200
Message-Id: <20200929172649.158086-2-kwolf@redhat.com>
In-Reply-To: <20200929172649.158086-1-kwolf@redhat.com>
References: <20200929172649.158086-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds a new parameter 'help' to keyval_parse() that enables parsing
of help options. If NULL is passed, the function behaves the same as
before. But if a bool pointer is given, it contains the information
whether an option "help" without value was given (which would otherwise
either result in an error or be interpreted as the value for an implied
key).

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/qemu/option.h                |   2 +-
 qapi/qobject-input-visitor.c         |   2 +-
 storage-daemon/qemu-storage-daemon.c |   2 +-
 tests/test-keyval.c                  | 157 ++++++++++++++++-----------
 util/keyval.c                        |  28 ++++-
 5 files changed, 123 insertions(+), 68 deletions(-)

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
index e6157ff518..bb9cb740f0 100644
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
index e331a84149..1ac65c371e 100644
--- a/tests/test-keyval.c
+++ b/tests/test-keyval.c
@@ -27,27 +27,28 @@ static void test_keyval_parse(void)
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
 
@@ -56,25 +57,25 @@ static void test_keyval_parse(void)
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
@@ -84,25 +85,25 @@ static void test_keyval_parse(void)
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
@@ -115,48 +116,48 @@ static void test_keyval_parse(void)
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
@@ -164,7 +165,7 @@ static void test_keyval_parse(void)
     qobject_unref(qdict);
 
     /* Implied dotted key */
-    qdict = keyval_parse("val", "eins.zwei", &error_abort);
+    qdict = keyval_parse("val", "eins.zwei", NULL, &error_abort);
     g_assert_cmpuint(qdict_size(qdict), ==, 1);
     sub_qdict = qdict_get_qdict(qdict, "eins");
     g_assert(sub_qdict);
@@ -173,19 +174,52 @@ static void test_keyval_parse(void)
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
 
     /* Empty key is not an implied key */
-    qdict = keyval_parse("=val", "implied", &err);
+    qdict = keyval_parse("=val", "implied", NULL, &err);
     error_free_or_abort(&err);
     g_assert(!qdict);
+
+    /* "help" is only a help option if it has no value */
+    qdict = keyval_parse("help=on", NULL, &help, &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 1);
+    g_assert_cmpstr(qdict_get_try_str(qdict, "help"), ==, "on");
+    g_assert_false(help);
+    qobject_unref(qdict);
+
+    /* "help" as the only option */
+    qdict = keyval_parse("help", NULL, &help, &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 0);
+    g_assert_true(help);
+    qobject_unref(qdict);
+
+    /* "help" is not a value for the implied key if &help is given */
+    qdict = keyval_parse("help", "implied", &help, &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 0);
+    g_assert_true(help);
+    qobject_unref(qdict);
+
+    /* "help" is a value for the implied key when passing NULL for help */
+    qdict = keyval_parse("help", "implied", NULL, &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 1);
+    g_assert_cmpstr(qdict_get_try_str(qdict, "implied"), ==, "help");
+    qobject_unref(qdict);
+
+    /* Other keys before and after help are still parsed normally */
+    qdict = keyval_parse("val,help,foo=bar", "implied", &help, &error_abort);
+    g_assert_cmpuint(qdict_size(qdict), ==, 2);
+    g_assert_cmpstr(qdict_get_try_str(qdict, "implied"), ==, "val");
+    g_assert_cmpstr(qdict_get_try_str(qdict, "foo"), ==, "bar");
+    g_assert_true(help);
+    qobject_unref(qdict);
 }
 
 static void check_list012(QList *qlist)
@@ -210,26 +244,26 @@ static void test_keyval_parse_list(void)
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
@@ -238,18 +272,19 @@ static void test_keyval_parse_list(void)
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
@@ -261,7 +296,7 @@ static void test_keyval_visit_bool(void)
     QDict *qdict;
     bool b;
 
-    qdict = keyval_parse("bool1=on,bool2=off", NULL, &error_abort);
+    qdict = keyval_parse("bool1=on,bool2=off", NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -273,7 +308,7 @@ static void test_keyval_visit_bool(void)
     visit_end_struct(v, NULL);
     visit_free(v);
 
-    qdict = keyval_parse("bool1=offer", NULL, &error_abort);
+    qdict = keyval_parse("bool1=offer", NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -291,7 +326,7 @@ static void test_keyval_visit_number(void)
     uint64_t u;
 
     /* Lower limit zero */
-    qdict = keyval_parse("number1=0", NULL, &error_abort);
+    qdict = keyval_parse("number1=0", NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -302,7 +337,7 @@ static void test_keyval_visit_number(void)
     visit_free(v);
 
     /* Upper limit 2^64-1 */
-    qdict = keyval_parse("number1=18446744073709551615,number2=-1",
+    qdict = keyval_parse("number1=18446744073709551615,number2=-1", NULL,
                          NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
@@ -316,8 +351,8 @@ static void test_keyval_visit_number(void)
     visit_free(v);
 
     /* Above upper limit */
-    qdict = keyval_parse("number1=18446744073709551616",
-                         NULL, &error_abort);
+    qdict = keyval_parse("number1=18446744073709551616", NULL, NULL,
+                         &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -327,8 +362,8 @@ static void test_keyval_visit_number(void)
     visit_free(v);
 
     /* Below lower limit */
-    qdict = keyval_parse("number1=-18446744073709551616",
-                         NULL, &error_abort);
+    qdict = keyval_parse("number1=-18446744073709551616", NULL, NULL,
+                         &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -338,8 +373,7 @@ static void test_keyval_visit_number(void)
     visit_free(v);
 
     /* Hex and octal */
-    qdict = keyval_parse("number1=0x2a,number2=052",
-                         NULL, &error_abort);
+    qdict = keyval_parse("number1=0x2a,number2=052", NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -352,8 +386,7 @@ static void test_keyval_visit_number(void)
     visit_free(v);
 
     /* Trailing crap */
-    qdict = keyval_parse("number1=3.14,number2=08",
-                         NULL, &error_abort);
+    qdict = keyval_parse("number1=3.14,number2=08", NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -373,7 +406,7 @@ static void test_keyval_visit_size(void)
     uint64_t sz;
 
     /* Lower limit zero */
-    qdict = keyval_parse("sz1=0", NULL, &error_abort);
+    qdict = keyval_parse("sz1=0", NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -389,7 +422,7 @@ static void test_keyval_visit_size(void)
     qdict = keyval_parse("sz1=9007199254740991,"
                          "sz2=9007199254740992,"
                          "sz3=9007199254740993",
-                         NULL, &error_abort);
+                         NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -406,7 +439,7 @@ static void test_keyval_visit_size(void)
     /* Close to signed upper limit 0x7ffffffffffffc00 (53 msbs set) */
     qdict = keyval_parse("sz1=9223372036854774784," /* 7ffffffffffffc00 */
                          "sz2=9223372036854775295", /* 7ffffffffffffdff */
-                         NULL, &error_abort);
+                         NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -421,7 +454,7 @@ static void test_keyval_visit_size(void)
     /* Close to actual upper limit 0xfffffffffffff800 (53 msbs set) */
     qdict = keyval_parse("sz1=18446744073709549568," /* fffffffffffff800 */
                          "sz2=18446744073709550591", /* fffffffffffffbff */
-                         NULL, &error_abort);
+                         NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -436,7 +469,7 @@ static void test_keyval_visit_size(void)
     /* Beyond limits */
     qdict = keyval_parse("sz1=-1,"
                          "sz2=18446744073709550592", /* fffffffffffffc00 */
-                         NULL, &error_abort);
+                         NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -449,7 +482,7 @@ static void test_keyval_visit_size(void)
 
     /* Suffixes */
     qdict = keyval_parse("sz1=8b,sz2=1.5k,sz3=2M,sz4=0.1G,sz5=16777215T",
-                         NULL, &error_abort);
+                         NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -468,7 +501,7 @@ static void test_keyval_visit_size(void)
     visit_free(v);
 
     /* Beyond limit with suffix */
-    qdict = keyval_parse("sz1=16777216T", NULL, &error_abort);
+    qdict = keyval_parse("sz1=16777216T", NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -478,7 +511,7 @@ static void test_keyval_visit_size(void)
     visit_free(v);
 
     /* Trailing crap */
-    qdict = keyval_parse("sz1=0Z,sz2=16Gi", NULL, &error_abort);
+    qdict = keyval_parse("sz1=0Z,sz2=16Gi", NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -497,7 +530,7 @@ static void test_keyval_visit_dict(void)
     QDict *qdict;
     int64_t i;
 
-    qdict = keyval_parse("a.b.c=1,a.b.c=2,d=3", NULL, &error_abort);
+    qdict = keyval_parse("a.b.c=1,a.b.c=2,d=3", NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -515,7 +548,7 @@ static void test_keyval_visit_dict(void)
     visit_end_struct(v, NULL);
     visit_free(v);
 
-    qdict = keyval_parse("a.b=", NULL, &error_abort);
+    qdict = keyval_parse("a.b=", NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -537,7 +570,7 @@ static void test_keyval_visit_list(void)
     QDict *qdict;
     char *s;
 
-    qdict = keyval_parse("a.0=,a.1=I,a.2.0=II", NULL, &error_abort);
+    qdict = keyval_parse("a.0=,a.1=I,a.2.0=II", NULL, NULL, &error_abort);
     /* TODO empty list */
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
@@ -561,7 +594,7 @@ static void test_keyval_visit_list(void)
     visit_end_struct(v, NULL);
     visit_free(v);
 
-    qdict = keyval_parse("a.0=,b.0.0=head", NULL, &error_abort);
+    qdict = keyval_parse("a.0=,b.0.0=head", NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -590,7 +623,7 @@ static void test_keyval_visit_optional(void)
     bool present;
     int64_t i;
 
-    qdict = keyval_parse("a.b=1", NULL, &error_abort);
+    qdict = keyval_parse("a.b=1", NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -626,7 +659,7 @@ static void test_keyval_visit_alternate(void)
      * the string variant if there is one, else an error.
      * TODO make it work for unambiguous cases like AltEnumBool below
      */
-    qdict = keyval_parse("a=1,b=2,c=on", NULL, &error_abort);
+    qdict = keyval_parse("a=1,b=2,c=on", NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
@@ -650,7 +683,7 @@ static void test_keyval_visit_any(void)
     QList *qlist;
     QString *qstr;
 
-    qdict = keyval_parse("a.0=null,a.1=1", NULL, &error_abort);
+    qdict = keyval_parse("a.0=null,a.1=1", NULL, NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
diff --git a/util/keyval.c b/util/keyval.c
index 13def4af54..ffa31b4cd7 100644
--- a/util/keyval.c
+++ b/util/keyval.c
@@ -166,7 +166,7 @@ static QObject *keyval_parse_put(QDict *cur,
  * On failure, return NULL.
  */
 static const char *keyval_parse_one(QDict *qdict, const char *params,
-                                    const char *implied_key,
+                                    const char *implied_key, bool *help,
                                     Error **errp)
 {
     const char *key, *key_end, *s, *end;
@@ -179,6 +179,16 @@ static const char *keyval_parse_one(QDict *qdict, const char *params,
 
     key = params;
     len = strcspn(params, "=,");
+
+    if (help && key[len] != '=' && !strncmp(key, "help", len)) {
+        *help = true;
+        s = key + len;
+        if (key[len] != '\0') {
+            s++;
+        }
+        return s;
+    }
+
     if (implied_key && len && key[len] != '=') {
         /* Desugar implied key */
         key = implied_key;
@@ -388,21 +398,33 @@ static QObject *keyval_listify(QDict *cur, GSList *key_of_cur, Error **errp)
 
 /*
  * Parse @params in QEMU's traditional KEY=VALUE,... syntax.
+ *
  * If @implied_key, the first KEY= can be omitted.  @implied_key is
  * implied then, and VALUE can't be empty or contain ',' or '='.
+ *
+ * If @help is given, an option "help" without a value isn't added to
+ * the resulting dictionary, but instead sets @help to true. If no
+ * help option is found, @help is false on return. All other options
+ * are parsed and returned normally so that context specific help can
+ * be printed.
+ *
  * On success, return a dictionary of the parsed keys and values.
  * On failure, store an error through @errp and return NULL.
  */
 QDict *keyval_parse(const char *params, const char *implied_key,
-                    Error **errp)
+                    bool *help, Error **errp)
 {
     QDict *qdict = qdict_new();
     QObject *listified;
     const char *s;
 
+    if (help) {
+        *help = false;
+    }
+
     s = params;
     while (*s) {
-        s = keyval_parse_one(qdict, s, implied_key, errp);
+        s = keyval_parse_one(qdict, s, implied_key, help, errp);
         if (!s) {
             qobject_unref(qdict);
             return NULL;
-- 
2.25.4


