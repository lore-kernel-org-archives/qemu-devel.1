Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A816C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 545412077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vm2s9QvE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545412077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieKhI-0005Ug-6P
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 10:11:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47265)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ieKY2-0003ZB-GX
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:02:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ieKXx-0001OO-3x
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:02:06 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35402)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ieKXw-0001Nt-Sy
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:02:01 -0500
Received: by mail-wm1-x342.google.com with SMTP id c20so13811563wmb.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 07:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Ft7K9jTEk6HhMYPt6hQBBzpDQMmZcbUpSDG664CJFNU=;
 b=Vm2s9QvEcWz3gO44MeWeq47IPkeOVYMKi20q2MB/rwXIeL5xYBy1D3j6hkxz5w8InU
 MA+7fvyItnGwsw6aAvomdAe1uEmTo+ZbGfierBImcs09dhBWhAq+gaWi15AvKYMwf/6R
 UHEkz6TvMNr9N8nQXX2jq6JUgxbJUd19Iy6lltXnoSFeQ+kqbf5rcDuoWroyUq2KboAL
 DGX5Nmv5fae1QNcVcszcS8h4GmohHvF347TCjGcNk7tjM6Hwv9sL0FwFD3gqGAcb7Mfb
 mmlM0DUqU2/3EZtpQ73/WlksHspv6bkl/GzA198wulsZJ13yX4gOLlYTAZZ71LVd3rLm
 AD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=Ft7K9jTEk6HhMYPt6hQBBzpDQMmZcbUpSDG664CJFNU=;
 b=XpeYXUWDyiHcF7KvjDSLsz/uIWCbqHHiTu/JO0Q1l4ET3p65aJAQN8qxM0YiO5EvHs
 ZTdv8YQ0i21hAaUrPZ6LVlZ6UY71LvTNiJq5EB04e00caLD9wUiM6wRAEb6R+I1rwbIi
 gCqoy3snGCfMNRKiYgPmX0Q0K4GFi4ytkX5cOlM1tT0VjvFY+hWrEkJ8w5fVVLOvGrxJ
 zbjVde3nRfRpyGR/VPEAnOfj/SDPaZPReTerYcoHtENVVJ2Nk5FO407Wr5RLfQOGGldK
 PYs8mh1mEenwk8jeG/NpqQNfadcrDZ73gJ17HFFg2ht7YSk6MFP5kAkDCKgPpman29Xf
 xnCQ==
X-Gm-Message-State: APjAAAVzfYBD8vq0m9gcyfOoKViicKfUXRF32R+dMRw9tHdO+hNeyops
 dNSog43OwKLwJs1eHmy7X2w7qLZ9
X-Google-Smtp-Source: APXvYqy7OFL5C+heQGi721sNwZ3M5HBb8w6yHIXPjw0rmWNKwoiK1KU9Fzb6RicvHKveOdyGsGVIww==
X-Received: by 2002:a7b:c0d8:: with SMTP id s24mr26650801wmh.30.1575903719051; 
 Mon, 09 Dec 2019 07:01:59 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g9sm27219371wro.67.2019.12.09.07.01.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 09 Dec 2019 07:01:58 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/18] qom: introduce object_register_sugar_prop
Date: Mon,  9 Dec 2019 16:01:37 +0100
Message-Id: <1575903705-12925-11-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
References: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: thuth@redhat.com, elmarco@redhat.com
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
index d51b57f..bfb4413 100644
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
index 58aad4f..d6c77bc 100644
--- a/vl.c
+++ b/vl.c
@@ -897,13 +897,9 @@ static void configure_rtc(QemuOpts *opts)
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



