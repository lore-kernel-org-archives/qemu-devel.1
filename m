Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0590CC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:10:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C24542077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="scP8W5E6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C24542077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieKg6-0003rJ-Ei
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 10:10:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47155)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ieKXv-0003R8-5a
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:02:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ieKXt-0001Jz-Dq
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:01:59 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:39672)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ieKXt-0001J7-6U
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:01:57 -0500
Received: by mail-wr1-x42c.google.com with SMTP id y11so16539467wrt.6
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 07:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6IQuv/QEggSTXD+5GhFOi5TkstH1/qjSjpCg/fK/lgs=;
 b=scP8W5E6glq3QUB92yLksNfs9+8/9k26QEWbV+cpR3fI9S+EqdlLgWrCd88NU1CD2t
 Wt7x5jvNPpLb98MQ1ZB1IeO2r6H/PWicZ5WD7nkyYAG7oUFE8nG8Mq4zURLJAe8/ya+6
 /9wUitN7T7QBtir0FCOGLyn/xwNdaU5bo8kYELZieQIIfWxJv1T5nEk1+qAnPx/UxuXc
 0AXaAK/zvWOoCvjJGgWQfUTAbGodTMNPZc8LRChymzpWl+Z7IdmzcHKX0neq6CXdmJWK
 txokCMgTBydwI8eCf1el2fgUoLm+iRFmBmj3Q2U3GP4sIC9uPyqguKVyZB861Rj+hwSX
 +Xuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=6IQuv/QEggSTXD+5GhFOi5TkstH1/qjSjpCg/fK/lgs=;
 b=eyACpgLwm4Pg09tFcq/AGNBHD0VUNH1JXLKH50fxjbia3ZMNkK5HzQguUNxc4OROlk
 ahQRhWRL3d2VmTAwaHz3puj8UqnFi9IkZDy+TjE5yodfeTmZXKW74YZYZerp4+dzFWom
 KzzeFP7p+m9hRBr4PttGmwDHG02TQgyr1fNOOHH/w7GQeRWkzpN8W10X8mDadL/XoI6o
 /UUvrpMEnNDwbsj/aDBogwAJuhd4uzRwA7mWSF4VwZbV1/TN1BIppq7D6SIO+RJP2EkK
 Ijtde3jM6cFFnnd3kLOiCwlLcnqKuKu1xdCa3cga+90jWFzP3vEzT23bq4OUApo3RSVB
 /zag==
X-Gm-Message-State: APjAAAX380Nk0/W0FxRf5Uh8rgGAB20lssBsfqYQJdCgrFwNhxgPzRmx
 esePGN9if/5pVWa8QGj4bZ4mRu/Z
X-Google-Smtp-Source: APXvYqwU/uIILuKXgbKQb7W6X/T6WDky9Lk6RB7jaN/pwGCDodHISn1BeVXV8rfPUiciDvK0rExLcw==
X-Received: by 2002:adf:e3c7:: with SMTP id k7mr2837035wrm.80.1575903715756;
 Mon, 09 Dec 2019 07:01:55 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g9sm27219371wro.67.2019.12.09.07.01.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 09 Dec 2019 07:01:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/18] vl: configure accelerators from -accel options
Date: Mon,  9 Dec 2019 16:01:35 +0100
Message-Id: <1575903705-12925-9-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
References: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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

Drop the "accel" property from MachineState, and instead desugar
"-machine accel=" to a list of "-accel" options.

This has a semantic change due to removing merge_lists from -accel.
For example:

- "-accel kvm -accel tcg" all but ignored "-accel kvm".  This is a bugfix.

- "-accel kvm -accel thread=single" ignored "thread=single", since it
  applied the option to KVM.  Now it fails due to not specifying the
  accelerator on "-accel thread=single".

- "-accel tcg -accel thread=single" chose single-threaded TCG, while now
  it will fail due to not specifying the accelerator on "-accel
  thread=single".

Also, "-machine accel" and "-accel" become incompatible.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/machine.c   | 21 ------------
 include/hw/boards.h |  1 -
 vl.c                | 93 +++++++++++++++++++++++++++++++----------------------
 3 files changed, 54 insertions(+), 61 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1689ad3..45ddfb6 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -173,21 +173,6 @@ GlobalProperty hw_compat_2_1[] = {
 };
 const size_t hw_compat_2_1_len = G_N_ELEMENTS(hw_compat_2_1);
 
-static char *machine_get_accel(Object *obj, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    return g_strdup(ms->accel);
-}
-
-static void machine_set_accel(Object *obj, const char *value, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    g_free(ms->accel);
-    ms->accel = g_strdup(value);
-}
-
 static void machine_set_kernel_irqchip(Object *obj, Visitor *v,
                                        const char *name, void *opaque,
                                        Error **errp)
@@ -808,11 +793,6 @@ static void machine_class_init(ObjectClass *oc, void *data)
     mc->numa_mem_align_shift = 23;
     mc->numa_auto_assign_ram = numa_default_auto_assign_ram;
 
-    object_class_property_add_str(oc, "accel",
-        machine_get_accel, machine_set_accel, &error_abort);
-    object_class_property_set_description(oc, "accel",
-        "Accelerator list", &error_abort);
-
     object_class_property_add(oc, "kernel-irqchip", "on|off|split",
         NULL, machine_set_kernel_irqchip,
         NULL, NULL, &error_abort);
@@ -971,7 +951,6 @@ static void machine_finalize(Object *obj)
 {
     MachineState *ms = MACHINE(obj);
 
-    g_free(ms->accel);
     g_free(ms->kernel_filename);
     g_free(ms->initrd_filename);
     g_free(ms->kernel_cmdline);
diff --git a/include/hw/boards.h b/include/hw/boards.h
index de45087..36fcbda 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -275,7 +275,6 @@ struct MachineState {
 
     /*< public >*/
 
-    char *accel;
     bool kernel_irqchip_allowed;
     bool kernel_irqchip_required;
     bool kernel_irqchip_split;
diff --git a/vl.c b/vl.c
index 66dff1b..f0cb438 100644
--- a/vl.c
+++ b/vl.c
@@ -294,7 +294,6 @@ static QemuOptsList qemu_accel_opts = {
     .name = "accel",
     .implied_opt_name = "accel",
     .head = QTAILQ_HEAD_INITIALIZER(qemu_accel_opts.head),
-    .merge_lists = true,
     .desc = {
         {
             .name = "accel",
@@ -2648,6 +2647,11 @@ static int machine_set_property(void *opaque,
         }
     }
 
+    /* Legacy options do not correspond to MachineState properties.  */
+    if (g_str_equal(qom_name, "accel")) {
+        return 0;
+    }
+
     return object_parse_property_opt(opaque, name, value, "type", errp);
 }
 
@@ -2838,74 +2842,88 @@ static int do_configure_icount(void *opaque, QemuOpts *opts, Error **errp)
 
 static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
 {
+    bool *p_init_failed = opaque;
+    const char *acc = qemu_opt_get(opts, "accel");
+    AccelClass *ac = accel_find(acc);
+    int ret;
+
+    if (!ac) {
+        return 0;
+    }
+    ret = accel_init_machine(ac, current_machine);
+    if (ret < 0) {
+        *p_init_failed = true;
+        error_report("failed to initialize %s: %s",
+                     acc, strerror(-ret));
+        return 0;
+    }
+
     if (tcg_enabled()) {
         qemu_tcg_configure(opts, &error_fatal);
     }
-    return 0;
+    return 1;
 }
 
 static void configure_accelerators(const char *progname)
 {
     const char *accel;
     char **accel_list, **tmp;
-    int ret;
     bool accel_initialised = false;
     bool init_failed = false;
-    AccelClass *acc = NULL;
 
     qemu_opts_foreach(qemu_find_opts("icount"),
                       do_configure_icount, NULL, &error_fatal);
 
     accel = qemu_opt_get(qemu_get_machine_opts(), "accel");
-    if (accel == NULL) {
-        /* Select the default accelerator */
-        if (!accel_find("tcg") && !accel_find("kvm")) {
-            error_report("No accelerator selected and"
-                         " no default accelerator available");
-            exit(1);
-        } else {
-            int pnlen = strlen(progname);
-            if (pnlen >= 3 && g_str_equal(&progname[pnlen - 3], "kvm")) {
-                /* If the program name ends with "kvm", we prefer KVM */
-                accel = "kvm:tcg";
+    if (QTAILQ_EMPTY(&qemu_accel_opts.head)) {
+        if (accel == NULL) {
+            /* Select the default accelerator */
+            if (!accel_find("tcg") && !accel_find("kvm")) {
+                error_report("No accelerator selected and"
+                             " no default accelerator available");
+                exit(1);
             } else {
-                accel = "tcg:kvm";
+                int pnlen = strlen(progname);
+                if (pnlen >= 3 && g_str_equal(&progname[pnlen - 3], "kvm")) {
+                    /* If the program name ends with "kvm", we prefer KVM */
+                    accel = "kvm:tcg";
+                } else {
+                    accel = "tcg:kvm";
+                }
             }
         }
-    }
 
-    accel_list = g_strsplit(accel, ":", 0);
+        accel_list = g_strsplit(accel, ":", 0);
 
-    for (tmp = accel_list; !accel_initialised && tmp && *tmp; tmp++) {
-        acc = accel_find(*tmp);
-        if (!acc) {
-            continue;
+        for (tmp = accel_list; !accel_initialised && tmp && *tmp; tmp++) {
+            /*
+             * Filter invalid accelerators here, to prevent obscenities
+             * such as "-machine accel=tcg,,thread=single".
+             */
+            if (accel_find(*tmp)) {
+                qemu_opts_parse_noisily(qemu_find_opts("accel"), *tmp, true);
+            }
         }
-        ret = accel_init_machine(acc, current_machine);
-        if (ret < 0) {
-            init_failed = true;
-            error_report("failed to initialize %s: %s",
-                         acc->name, strerror(-ret));
-        } else {
-            accel_initialised = true;
+    } else {
+        if (accel != NULL) {
+            error_report("The -accel and \"-machine accel=\" options are incompatible");
+            exit(1);
         }
     }
-    g_strfreev(accel_list);
 
-    if (!accel_initialised) {
+    if (!qemu_opts_foreach(qemu_find_opts("accel"),
+                           do_configure_accelerator, &init_failed, &error_fatal)) {
         if (!init_failed) {
-            error_report("-machine accel=%s: No accelerator found", accel);
+            error_report("no accelerator found");
         }
         exit(1);
     }
 
     if (init_failed) {
-        error_report("Back to %s accelerator", acc->name);
+        AccelClass *ac = ACCEL_GET_CLASS(current_machine->accelerator);
+        error_report("Back to %s accelerator", ac->name);
     }
 
-    qemu_opts_foreach(qemu_find_opts("accel"),
-                      do_configure_accelerator, NULL, &error_fatal);
-
     if (!tcg_enabled() && use_icount) {
         error_report("-icount is not allowed with hardware virtualization");
         exit(1);
@@ -3616,9 +3634,6 @@ int main(int argc, char **argv, char **envp)
                                  "use -M accel=... for now instead");
                     exit(1);
                 }
-                opts = qemu_opts_create(qemu_find_opts("machine"), NULL,
-                                        false, &error_abort);
-                qemu_opt_set(opts, "accel", optarg, &error_abort);
                 break;
             case QEMU_OPTION_usb:
                 olist = qemu_find_opts("machine");
-- 
1.8.3.1



