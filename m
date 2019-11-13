Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C19C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:44:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61ADB222D3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ocU7YEdc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61ADB222D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUtsm-0003e9-3S
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 09:44:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iUtnd-0005ia-T8
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iUtnc-0006JK-EY
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:13 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:41953)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iUtnc-0006Ix-8F
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:12 -0500
Received: by mail-wr1-x42e.google.com with SMTP id b18so1155319wrj.8
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 06:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=iszTbD52Pp95pGi+D6mfWjcoYn8y4e0DUxu7sGpWVv8=;
 b=ocU7YEdcWgUInMs8QTjOwNa8tyyTVUcEPaSdeDA0Gw0R6QO47jYGY9uKTHZXgiOjY8
 wG54mQQPoXOR/Wc/4Wse30XbZCtOBzgCdzpLU6Xe+mdibwFxyv8vZbVOXMR797QDrYyS
 tSn1Lt+oijU98DeHU0G9oQGy8hi3vU7H0Jr9aIscVF4pKKp0hcRllLdsiSt1G98122Ib
 8ChCmm9hc9tiGcz35d/1ssbvx0xo8XTo3S/BHY1cO6CtPv8ZonexA/RHocxORFnRSKi+
 VEMYB59VBBGya2V9jDiUL60R/hRE64COG53cbJs90MDnapW3c80PvC+hFOOVCI8a2Pcd
 xm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=iszTbD52Pp95pGi+D6mfWjcoYn8y4e0DUxu7sGpWVv8=;
 b=Vc1KiL4G6ynNndssIWtRfaRuIVVn57KuTZhXvUObFnSLqaQAojZ9f3YjkymOM33b3d
 Zwk3zXIVeDJzV+wL559q975ZKPAiBT25jzJG9N6VDlcYwk8fh6/TMMQT1UxrqZr+LW/O
 hlsRFzJi2DjjyAd6fXxjJcTKivTw5mHiV99TJMNobAKx1yFxiL+XR7SAUeo6A4o8lGYH
 7wxdROSB5lYJKLok89AAzQ7FtwQT5fXRm0w1CDMgu2H3gzekJLlEblmijB0g2C9VSDxQ
 f0s8BeDCWtavk2ZYgRQrQB3Cg6t7C549ALn4ZQTJhYXpP12FR4ueQC0sUG6mK729sIJ/
 AAbA==
X-Gm-Message-State: APjAAAX94X8EYCTr9wBeWq7zNlplNqLTQVOzyLQIY+2UsRaVn2qjfEL2
 oKYR/P3ksgTmIVTMgKJpMnZubXhW
X-Google-Smtp-Source: APXvYqwgMc+uvpb87z7h625e7xXIKMo3AkkxR3VPORNOPV09LQS88OHOfNz+fEykqzkLkjU+HDGErw==
X-Received: by 2002:a5d:48c8:: with SMTP id p8mr3336952wrs.318.1573655950228; 
 Wed, 13 Nov 2019 06:39:10 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s11sm2965823wrr.43.2019.11.13.06.39.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Nov 2019 06:39:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/16] vl: merge -accel processing into configure_accelerators
Date: Wed, 13 Nov 2019 15:38:52 +0100
Message-Id: <1573655945-14912-4-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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

The next step is to move the parsing of "-machine accel=..." into vl.c,
unifying it with the configure_accelerators() function that has just
been introduced.  This way, we will be able to desugar it into multiple
"-accel" options, without polluting accel/accel.c.

The CONFIG_TCG and CONFIG_KVM symbols are not available in vl.c, but
we can use accel_find instead to find their value at runtime.  Once we
know that the binary has one of TCG or KVM, the default accelerator
can be expressed simply as "tcg:kvm", because TCG never fails to initialize.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/accel.c          | 63 ++------------------------------------------------
 include/sysemu/accel.h |  4 +++-
 vl.c                   | 62 +++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 62 insertions(+), 67 deletions(-)

diff --git a/accel/accel.c b/accel/accel.c
index 5fa3171..74eda68 100644
--- a/accel/accel.c
+++ b/accel/accel.c
@@ -44,7 +44,7 @@ static const TypeInfo accel_type = {
 };
 
 /* Lookup AccelClass from opt_name. Returns NULL if not found */
-static AccelClass *accel_find(const char *opt_name)
+AccelClass *accel_find(const char *opt_name)
 {
     char *class_name = g_strdup_printf(ACCEL_CLASS_NAME("%s"), opt_name);
     AccelClass *ac = ACCEL_CLASS(object_class_by_name(class_name));
@@ -52,7 +52,7 @@ static AccelClass *accel_find(const char *opt_name)
     return ac;
 }
 
-static int accel_init_machine(AccelClass *acc, MachineState *ms)
+int accel_init_machine(AccelClass *acc, MachineState *ms)
 {
     ObjectClass *oc = OBJECT_CLASS(acc);
     const char *cname = object_class_get_name(oc);
@@ -71,65 +71,6 @@ static int accel_init_machine(AccelClass *acc, MachineState *ms)
     return ret;
 }
 
-void configure_accelerator(MachineState *ms, const char *progname)
-{
-    const char *accel;
-    char **accel_list, **tmp;
-    int ret;
-    bool accel_initialised = false;
-    bool init_failed = false;
-    AccelClass *acc = NULL;
-
-    accel = qemu_opt_get(qemu_get_machine_opts(), "accel");
-    if (accel == NULL) {
-        /* Select the default accelerator */
-        int pnlen = strlen(progname);
-        if (pnlen >= 3 && g_str_equal(&progname[pnlen - 3], "kvm")) {
-            /* If the program name ends with "kvm", we prefer KVM */
-            accel = "kvm:tcg";
-        } else {
-#if defined(CONFIG_TCG)
-            accel = "tcg";
-#elif defined(CONFIG_KVM)
-            accel = "kvm";
-#else
-            error_report("No accelerator selected and"
-                         " no default accelerator available");
-            exit(1);
-#endif
-        }
-    }
-
-    accel_list = g_strsplit(accel, ":", 0);
-
-    for (tmp = accel_list; !accel_initialised && tmp && *tmp; tmp++) {
-        acc = accel_find(*tmp);
-        if (!acc) {
-            continue;
-        }
-        ret = accel_init_machine(acc, ms);
-        if (ret < 0) {
-            init_failed = true;
-            error_report("failed to initialize %s: %s",
-                         acc->name, strerror(-ret));
-        } else {
-            accel_initialised = true;
-        }
-    }
-    g_strfreev(accel_list);
-
-    if (!accel_initialised) {
-        if (!init_failed) {
-            error_report("-machine accel=%s: No accelerator found", accel);
-        }
-        exit(1);
-    }
-
-    if (init_failed) {
-        error_report("Back to %s accelerator", acc->name);
-    }
-}
-
 void accel_setup_post(MachineState *ms)
 {
     AccelState *accel = ms->accelerator;
diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
index 8eb60b8..90b6213 100644
--- a/include/sysemu/accel.h
+++ b/include/sysemu/accel.h
@@ -66,7 +66,9 @@ typedef struct AccelClass {
 
 extern unsigned long tcg_tb_size;
 
-void configure_accelerator(MachineState *ms, const char *progname);
+AccelClass *accel_find(const char *opt_name);
+int accel_init_machine(AccelClass *acc, MachineState *ms);
+
 /* Called just before os_setup_post (ie just before drop OS privs) */
 void accel_setup_post(MachineState *ms);
 
diff --git a/vl.c b/vl.c
index 5367f23..fc9e70f 100644
--- a/vl.c
+++ b/vl.c
@@ -2845,8 +2845,62 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
     return 0;
 }
 
-static void configure_accelerators(void)
+static void configure_accelerators(const char *progname)
 {
+    const char *accel;
+    char **accel_list, **tmp;
+    int ret;
+    bool accel_initialised = false;
+    bool init_failed = false;
+    AccelClass *acc = NULL;
+
+    accel = qemu_opt_get(qemu_get_machine_opts(), "accel");
+    if (accel == NULL) {
+        /* Select the default accelerator */
+        if (!accel_find("tcg") && !accel_find("kvm")) {
+            error_report("No accelerator selected and"
+                         " no default accelerator available");
+            exit(1);
+        } else {
+            int pnlen = strlen(progname);
+            if (pnlen >= 3 && g_str_equal(&progname[pnlen - 3], "kvm")) {
+                /* If the program name ends with "kvm", we prefer KVM */
+                accel = "kvm:tcg";
+            } else {
+                accel = "tcg:kvm";
+            }
+        }
+    }
+
+    accel_list = g_strsplit(accel, ":", 0);
+
+    for (tmp = accel_list; !accel_initialised && tmp && *tmp; tmp++) {
+        acc = accel_find(*tmp);
+        if (!acc) {
+            continue;
+        }
+        ret = accel_init_machine(acc, current_machine);
+        if (ret < 0) {
+            init_failed = true;
+            error_report("failed to initialize %s: %s",
+                         acc->name, strerror(-ret));
+        } else {
+            accel_initialised = true;
+        }
+    }
+    g_strfreev(accel_list);
+
+    if (!accel_initialised) {
+        if (!init_failed) {
+            error_report("-machine accel=%s: No accelerator found", accel);
+        }
+        exit(1);
+    }
+
+    if (init_failed) {
+        error_report("Back to %s accelerator", acc->name);
+    }
+
     qemu_opts_foreach(qemu_find_opts("icount"),
                       do_configure_icount, NULL, &error_fatal);
 
@@ -4183,7 +4237,8 @@ int main(int argc, char **argv, char **envp)
      * Note: uses machine properties such as kernel-irqchip, must run
      * after machine_set_property().
      */
-    configure_accelerator(current_machine, argv[0]);
+    cpu_ticks_init();
+    configure_accelerators(argv[0]);
 
     /*
      * Beware, QOM objects created before this point miss global and
@@ -4267,9 +4322,6 @@ int main(int argc, char **argv, char **envp)
     /* spice needs the timers to be initialized by this point */
     qemu_spice_init();
 
-    cpu_ticks_init();
-    configure_accelerators();
-
     if (default_net) {
         QemuOptsList *net = qemu_find_opts("net");
         qemu_opts_set(net, NULL, "type", "nic", &error_abort);
-- 
1.8.3.1



