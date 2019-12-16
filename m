Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE18FC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:43:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CEF9206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vCBAvyjb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CEF9206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtSk-0006Ms-8y
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:43:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFC-00057x-Kc
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFB-0007Xr-4l
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:14 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37045)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtFA-0007VW-TN
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:13 -0500
Received: by mail-wm1-x343.google.com with SMTP id f129so7408548wmf.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p7o2n9/PzTThkUIGsul6JE1J+WZ+8RW0aju3sT2a0oM=;
 b=vCBAvyjbdXIsq3RG5Fxsj80UJgX0iVv0CRKMWQturGfUPTIvVzSv7By86SyicoXUd1
 tltWjeanfs40KqQjaFYR9UezDJixjB0xMg5clNbf6/aHpX7zMaytviRRyLEQUFOiCusJ
 M5CXQWBZq+6OZsAIMcwV0dr7+4oLyal4UsHub9M7OX2RN6ij9OEmo0NwUf8SUWLd7Rqz
 fveeZWLAsTRpH0zJvDgKKJPFpc40t+E1HAByLht/n03VVLRoj8Np1DfzL7tvcAQkAaAL
 G+f42pPka33CWoZNoXRt5WKhQKyA9nZRK449hMDhhQhWLEFtMs7XUP9Ma4cRuD+f5dgZ
 tNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=p7o2n9/PzTThkUIGsul6JE1J+WZ+8RW0aju3sT2a0oM=;
 b=gaJJifC2HMOS3FBEDaW4C3FKomqAjUN9A6YKrLH3FvaCPz2kzSwWMaU8Q0zHLxYAgF
 6iEcz5YSTmtyxdd7IJvndi3V8F++oXH8Fq20f/8j4L336+FfWciG0dH17Ay5ucSDdzB5
 QaG4mjckvTMRROu/a+N3AB9iV3xXuHsmmcCxulkAcvx1PLOdx6FKvGxYfihh1ZfK9tN4
 dSJYkDGw0cHNIqqcsanQkBBTYIsR0IoUR+rSA7DJ5uKweM+59SLXeAVVpaMC1WKbktPO
 U6u/L93xQHAq+6F3Yy/znjjbET0aUlp34cg7kcPjgTA4UdrbQ1ODdjfuNHaYS3rzElDE
 qAyQ==
X-Gm-Message-State: APjAAAWrTgDdqLjv2KKChr7a4xNwhePc3hhQwbJVC3vdHP8znglrA0oN
 RoZui74l6DukDRGquKonkKkMHOG4
X-Google-Smtp-Source: APXvYqx5ZiEbEwVYqoOYAY8yR7pqoD8frrMmNrpzpwxpcL/qLSxl2wJ6gta/KNR2FzdQcX1u9gnDZQ==
X-Received: by 2002:a1c:740b:: with SMTP id p11mr33183560wmc.78.1576513751689; 
 Mon, 16 Dec 2019 08:29:11 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/62] tcg: convert "-accel threads" to a QOM property
Date: Mon, 16 Dec 2019 17:28:08 +0100
Message-Id: <1576513726-53700-25-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace the ad-hoc qemu_tcg_configure with generic code invoking QOM
property getters and setters.  More properties (and thus more valid
-accel suboptions) will be added in the next patches, which will move
accelerator-related "-machine" options to accelerators.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/tcg-all.c   | 52 +++++++++++++++++++++++++++++++++++++--------------
 include/sysemu/cpus.h |  2 --
 vl.c                  | 32 ++++++++++++++++---------------
 3 files changed, 55 insertions(+), 31 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 6b000f0..7829f02 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -34,7 +34,17 @@
 #include "include/qapi/error.h"
 #include "include/qemu/error-report.h"
 #include "include/hw/boards.h"
-#include "qemu/option.h"
+
+typedef struct TCGState {
+    AccelState parent_obj;
+
+    bool mttcg_enabled;
+} TCGState;
+
+#define TYPE_TCG_ACCEL ACCEL_CLASS_NAME("tcg")
+
+#define TCG_STATE(obj) \
+        OBJECT_CHECK(TCGState, (obj), TYPE_TCG_ACCEL)
 
 unsigned long tcg_tb_size;
 
@@ -107,23 +117,33 @@ static bool default_mttcg_enabled(void)
 
 static void tcg_accel_instance_init(Object *obj)
 {
-    mttcg_enabled = default_mttcg_enabled();
+    TCGState *s = TCG_STATE(obj);
+
+    s->mttcg_enabled = default_mttcg_enabled();
 }
 
 static int tcg_init(MachineState *ms)
 {
+    TCGState *s = TCG_STATE(current_machine->accelerator);
+
     tcg_exec_init(tcg_tb_size * 1024 * 1024);
     cpu_interrupt_handler = tcg_handle_interrupt;
+    mttcg_enabled = s->mttcg_enabled;
     return 0;
 }
 
-void qemu_tcg_configure(QemuOpts *opts, Error **errp)
+static char *tcg_get_thread(Object *obj, Error **errp)
 {
-    const char *t = qemu_opt_get(opts, "thread");
-    if (!t) {
-        return;
-    }
-    if (strcmp(t, "multi") == 0) {
+    TCGState *s = TCG_STATE(obj);
+
+    return g_strdup(s->mttcg_enabled ? "multi" : "single");
+}
+
+static void tcg_set_thread(Object *obj, const char *value, Error **errp)
+{
+    TCGState *s = TCG_STATE(obj);
+
+    if (strcmp(value, "multi") == 0) {
         if (TCG_OVERSIZED_GUEST) {
             error_setg(errp, "No MTTCG when guest word size > hosts");
         } else if (use_icount) {
@@ -138,12 +158,12 @@ void qemu_tcg_configure(QemuOpts *opts, Error **errp)
                             "than the host provides");
                 error_printf("This may cause strange/hard to debug errors\n");
             }
-            mttcg_enabled = true;
+            s->mttcg_enabled = true;
         }
-    } else if (strcmp(t, "single") == 0) {
-        mttcg_enabled = false;
+    } else if (strcmp(value, "single") == 0) {
+        s->mttcg_enabled = false;
     } else {
-        error_setg(errp, "Invalid 'thread' setting %s", t);
+        error_setg(errp, "Invalid 'thread' setting %s", value);
     }
 }
 
@@ -153,15 +173,19 @@ static void tcg_accel_class_init(ObjectClass *oc, void *data)
     ac->name = "tcg";
     ac->init_machine = tcg_init;
     ac->allowed = &tcg_allowed;
-}
 
-#define TYPE_TCG_ACCEL ACCEL_CLASS_NAME("tcg")
+    object_class_property_add_str(oc, "thread",
+                                  tcg_get_thread,
+                                  tcg_set_thread,
+                                  NULL);
+}
 
 static const TypeInfo tcg_accel_type = {
     .name = TYPE_TCG_ACCEL,
     .parent = TYPE_ACCEL,
     .instance_init = tcg_accel_instance_init,
     .class_init = tcg_accel_class_init,
+    .instance_size = sizeof(TCGState),
 };
 
 static void register_accel_types(void)
diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
index 32c05f2..3c1da6a 100644
--- a/include/sysemu/cpus.h
+++ b/include/sysemu/cpus.h
@@ -40,6 +40,4 @@ extern int smp_threads;
 
 void list_cpus(const char *optarg);
 
-void qemu_tcg_configure(QemuOpts *opts, Error **errp);
-
 #endif
diff --git a/vl.c b/vl.c
index 0378b90..d581f11 100644
--- a/vl.c
+++ b/vl.c
@@ -295,17 +295,12 @@ static QemuOptsList qemu_accel_opts = {
     .implied_opt_name = "accel",
     .head = QTAILQ_HEAD_INITIALIZER(qemu_accel_opts.head),
     .desc = {
-        {
-            .name = "accel",
-            .type = QEMU_OPT_STRING,
-            .help = "Select the type of accelerator",
-        },
-        {
-            .name = "thread",
-            .type = QEMU_OPT_STRING,
-            .help = "Enable/disable multi-threaded TCG",
-        },
-        { /* end of list */ }
+        /*
+         * no elements => accept any
+         * sanity checking will happen later
+         * when setting accelerator properties
+         */
+        { }
     },
 };
 
@@ -2836,6 +2831,13 @@ static int do_configure_icount(void *opaque, QemuOpts *opts, Error **errp)
     return 0;
 }
 
+static int accelerator_set_property(void *opaque,
+                                const char *name, const char *value,
+                                Error **errp)
+{
+    return object_parse_property_opt(opaque, name, value, "accel", errp);
+}
+
 static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
 {
     bool *p_init_failed = opaque;
@@ -2850,6 +2852,10 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
         return 0;
     }
     accel = ACCEL(object_new_with_class(OBJECT_CLASS(ac)));
+    qemu_opt_foreach(opts, accelerator_set_property,
+                     accel,
+                     &error_fatal);
+
     ret = accel_init_machine(accel, current_machine);
     if (ret < 0) {
         *p_init_failed = true;
@@ -2857,10 +2863,6 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
                      acc, strerror(-ret));
         return 0;
     }
-
-    if (tcg_enabled()) {
-        qemu_tcg_configure(opts, &error_fatal);
-    }
     return 1;
 }
 
-- 
1.8.3.1



