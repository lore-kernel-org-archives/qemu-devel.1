Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F5BC17442
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:47:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4718B222C9
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCS/BAhe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4718B222C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUtvx-0007XW-1Q
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 09:47:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54537)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iUtnh-0005pK-Im
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iUtng-0006Kw-A3
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:17 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38344)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iUtng-0006Ke-26
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:16 -0500
Received: by mail-wr1-x444.google.com with SMTP id i12so2648269wro.5
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 06:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=cIfZoKMkbTbdhoYje0A8wEbwWm6iqWmZiic8eSGDlZA=;
 b=QCS/BAheEgIiJ/pn0fdSoGjEWMUcqw1/81Df3vGJxN8iLKCn3uPm20N5Kk0ruRJDBy
 YsDtWVWjzHG6qWd9oEek/Fxu2O2dtkHWGvBFtSZJNdipdPEWFFH1gq2zeQUIZSh1JWA/
 yi1SnLFDLU64YUBU82n+qK8EPDTllIv7HdkBWv3iSv3PgN8tRHdcgZsZuOwgDe6KWpPj
 vtkWg46mdpHccuQ+BhOaEWCF196e+dr8hZZ0ULCJ2ZrEE/k0qGRoyWkF50VBR/xoWBBn
 FSJw4JdSylnYjso67r9TBGrmnDCwnCGmR/yaKVOaL8V5q4A/UQBpzGcsG5ipaU3c3ZEo
 z/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=cIfZoKMkbTbdhoYje0A8wEbwWm6iqWmZiic8eSGDlZA=;
 b=tbQgHvXYzKBQuh8zMz1cnX4SihgGvzQem1zRaBbD/CFfZz5YGsJrAlZv4TaItTI2B9
 sYix2RbcwucWIZ2DllotgPqcjFEVkJyb43SHWXcKJh6quvFD3oJf8H8/MlYWFUr54hMi
 nRXbDj/ShrWn+RGqSKPA8/eG4dqj2iwhI231aTjooYkp629hZJBjhYCO+3o8VVHpUMrx
 /NPbrw3aHKEAMIjvrS3BrikG/K/9200PeClb8P0c4RT/qr5FOtCGkFt4sVzIAIzrshRo
 6sGckcdTlBDQSpgO33ZiOYu6kTf4OcSY7TbK5f74hXkdyEXFNbDt9DQkJqeSKj9uEPkP
 2RZQ==
X-Gm-Message-State: APjAAAWbAIyTEExA8roccKMVgAQgU2HYQ/EcXP4WUY17H2fPgTCDHp8f
 uI5DcUr9/A6W8//f8n08gbQUSO3N
X-Google-Smtp-Source: APXvYqwAzcMj54Zgb/yKGGEvENL1FyL4ReJ86GIwaA9v8vPLPCgp2rOpbMHLL1fnV+IG3cmc+lfQTw==
X-Received: by 2002:adf:9ec7:: with SMTP id b7mr3181836wrf.221.1573655954119; 
 Wed, 13 Nov 2019 06:39:14 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s11sm2965823wrr.43.2019.11.13.06.39.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Nov 2019 06:39:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/16] qom: introduce object_register_sugar_prop
Date: Wed, 13 Nov 2019 15:38:57 +0100
Message-Id: <1573655945-14912-9-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: thuth@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similar to the existing "-rtc driftfix" option, we will convert some
legacy "-machine" command line options to global properties on accelerators.
Because accelerators are not devices, we cannot use qdev_prop_register_global.
Instead, provide a slot in the generic object_compat_props arrays for
command line syntactic sugar.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h |  1 +
 qom/object.c         | 23 +++++++++++++++++++++--
 vl.c                 | 10 +++-------
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 128d00c..230b18f 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -679,6 +679,7 @@ void object_apply_global_props(Object *obj, const GPtrArray *props,
                                Error **errp);
 void object_set_machine_compat_props(GPtrArray *compat_props);
 void object_set_accelerator_compat_props(GPtrArray *compat_props);
+void object_register_sugar_prop(const char *driver, const char *prop, const char *value);
 void object_apply_compat_props(Object *obj);
 
 /**
diff --git a/qom/object.c b/qom/object.c
index 6fa9c61..c7825dd 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -414,10 +414,29 @@ void object_apply_global_props(Object *obj, const GPtrArray *props, Error **errp
  * Global property defaults
  * Slot 0: accelerator's global property defaults
  * Slot 1: machine's global property defaults
+ * Slot 2: global properties from legacy command line option
  * Each is a GPtrArray of of GlobalProperty.
  * Applied in order, later entries override earlier ones.
  */
-static GPtrArray *object_compat_props[2];
+static GPtrArray *object_compat_props[3];
+
+/*
+ * Retrieve @GPtrArray for global property defined with options
+ * other than "-global".  These are generally used for syntactic
+ * sugar and legacy command line options.
+ */
+void object_register_sugar_prop(const char *driver, const char *prop, const char *value)
+{
+    GlobalProperty *g;
+    if (!object_compat_props[2]) {
+        object_compat_props[2] = g_ptr_array_new();
+    }
+    g = g_new(GlobalProperty, 1);
+    g->driver = g_strdup(driver);
+    g->property = g_strdup(prop);
+    g->value = g_strdup(value);
+    g_ptr_array_add(object_compat_props[2], g);
+}
 
 /*
  * Set machine's global property defaults to @compat_props.
@@ -445,7 +464,7 @@ void object_apply_compat_props(Object *obj)
 
     for (i = 0; i < ARRAY_SIZE(object_compat_props); i++) {
         object_apply_global_props(obj, object_compat_props[i],
-                                  &error_abort);
+                                  i == 2 ? &error_fatal : &error_abort);
     }
 }
 
diff --git a/vl.c b/vl.c
index 843b263..cb993dd 100644
--- a/vl.c
+++ b/vl.c
@@ -896,13 +896,9 @@ static void configure_rtc(QemuOpts *opts)
     value = qemu_opt_get(opts, "driftfix");
     if (value) {
         if (!strcmp(value, "slew")) {
-            static GlobalProperty slew_lost_ticks = {
-                .driver   = "mc146818rtc",
-                .property = "lost_tick_policy",
-                .value    = "slew",
-            };
-
-            qdev_prop_register_global(&slew_lost_ticks);
+            object_register_sugar_prop("mc146818rtc",
+                                       "lost_tick_policy",
+                                       "slew");
         } else if (!strcmp(value, "none")) {
             /* discard is default */
         } else {
-- 
1.8.3.1



