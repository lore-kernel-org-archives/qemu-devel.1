Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AEFC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:15:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F363424198
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S4cmQ0EV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F363424198
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVLS8-0008Ne-MC
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 17:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVLB1-0005gV-MG
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 16:57:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58124)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVLAv-0006gl-CU
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 16:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603313852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dRvr5vK9gyZ3cW3q+3aqjtBHNka0CgHWp9sdX69KnyE=;
 b=S4cmQ0EVlU+dmaWH0sl6P78gopuUTcKWhDgV7aXkFNMJzdRsif6MrKitv2MGeQp74GDzf7
 hPZdoTDH6/gVElLfCKIAKwLOumnWfcz9XTm4DhFFGMcsNDGajIswA+ZLvyLb5vb62a2K9T
 udqXbq7m2DzGsA68h4rcvEFGiJC6jRE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-lkO0AsEwM1KG7oGQbjEMUw-1; Wed, 21 Oct 2020 16:57:30 -0400
X-MC-Unique: lkO0AsEwM1KG7oGQbjEMUw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74DF5804B68
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 20:57:29 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C53296EF62;
 Wed, 21 Oct 2020 20:57:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/22] vl: extract various command line validation snippets to
 a new function
Date: Wed, 21 Oct 2020 16:57:07 -0400
Message-Id: <20201021205716.2359430-14-pbonzini@redhat.com>
In-Reply-To: <20201021205716.2359430-1-pbonzini@redhat.com>
References: <20201021205716.2359430-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
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
Cc: jsnow@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 softmmu/vl.c | 78 ++++++++++++++++++++++++++--------------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index e32e209a82..f8b1ffb46e 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -123,6 +123,7 @@ static int data_dir_idx;
 static const char *mem_path;
 static const char *boot_order;
 static const char *boot_once;
+static const char *incoming;
 enum vga_retrace_method vga_retrace_method = VGA_RETRACE_DUMB;
 int display_opengl;
 const char* keyboard_layout = NULL;
@@ -2866,6 +2867,39 @@ static char *find_datadir(void)
     return get_relocated_path(CONFIG_QEMU_DATADIR);
 }
 
+static void qemu_validate_options(void)
+{
+    QemuOpts *machine_opts = qemu_get_machine_opts();
+    const char *kernel_filename = qemu_opt_get(machine_opts, "kernel");
+    const char *initrd_filename = qemu_opt_get(machine_opts, "initrd");
+    const char *kernel_cmdline = qemu_opt_get(machine_opts, "append");
+
+    if (kernel_filename == NULL) {
+         if (kernel_cmdline != NULL) {
+              error_report("-append only allowed with -kernel option");
+              exit(1);
+          }
+
+          if (initrd_filename != NULL) {
+              error_report("-initrd only allowed with -kernel option");
+              exit(1);
+          }
+    }
+
+    if (incoming && !preconfig_exit_requested) {
+        error_report("'preconfig' and 'incoming' options are "
+                     "mutually exclusive");
+        exit(EXIT_FAILURE);
+    }
+
+#ifdef CONFIG_CURSES
+    if (is_daemonized() && dpy.type == DISPLAY_TYPE_CURSES) {
+        error_report("curses display cannot be used with -daemonize");
+        exit(1);
+    }
+#endif
+}
+
 static void qemu_process_early_options(void)
 {
     char **dirs;
@@ -3122,9 +3156,6 @@ void qemu_init(int argc, char **argv, char **envp)
 {
     int i;
     int snapshot = 0;
-    int linux_boot;
-    const char *initrd_filename;
-    const char *kernel_filename, *kernel_cmdline;
     QemuOpts *opts, *machine_opts;
     QemuOpts *icount_opts = NULL, *accel_opts = NULL;
     QemuOptsList *olist;
@@ -3133,7 +3164,6 @@ void qemu_init(int argc, char **argv, char **envp)
     const char *loadvm = NULL;
     MachineClass *machine_class;
     const char *vga_model = NULL;
-    const char *incoming = NULL;
     bool userconfig = true;
     bool nographic = false;
     int display_remote = 0;
@@ -4050,6 +4080,8 @@ void qemu_init(int argc, char **argv, char **envp)
      */
     loc_set_none();
 
+    qemu_validate_options();
+
     /* These options affect everything else and should be processed
      * before daemonizing.
      */
@@ -4064,12 +4096,6 @@ void qemu_init(int argc, char **argv, char **envp)
     user_register_global_props();
     replay_configure(icount_opts);
 
-    if (incoming && !preconfig_exit_requested) {
-        error_report("'preconfig' and 'incoming' options are "
-                     "mutually exclusive");
-        exit(EXIT_FAILURE);
-    }
-
     configure_rtc(qemu_find_opts_singleton("rtc"));
 
     machine_class = select_machine();
@@ -4173,12 +4199,6 @@ void qemu_init(int argc, char **argv, char **envp)
             error_report("-nographic cannot be used with -daemonize");
             exit(1);
         }
-#ifdef CONFIG_CURSES
-        if (dpy.type == DISPLAY_TYPE_CURSES) {
-            error_report("curses display cannot be used with -daemonize");
-            exit(1);
-        }
-#endif
     }
 
     if (nographic) {
@@ -4309,11 +4329,6 @@ void qemu_init(int argc, char **argv, char **envp)
         qtest_server_init(qtest_chrdev, qtest_log, &error_fatal);
     }
 
-    machine_opts = qemu_get_machine_opts();
-    kernel_filename = qemu_opt_get(machine_opts, "kernel");
-    initrd_filename = qemu_opt_get(machine_opts, "initrd");
-    kernel_cmdline = qemu_opt_get(machine_opts, "append");
-
     opts = qemu_opts_find(qemu_find_opts("boot-opts"), NULL);
     if (opts) {
         boot_order = qemu_opt_get(opts, "order");
@@ -4334,24 +4349,9 @@ void qemu_init(int argc, char **argv, char **envp)
         boot_order = machine_class->default_boot_order;
     }
 
-    if (!kernel_cmdline) {
-        kernel_cmdline = "";
-        current_machine->kernel_cmdline = (char *)kernel_cmdline;
-    }
-
-    linux_boot = (kernel_filename != NULL);
-
-    if (!linux_boot && *kernel_cmdline != '\0') {
-        error_report("-append only allowed with -kernel option");
-        exit(1);
-    }
-
-    if (!linux_boot && initrd_filename != NULL) {
-        error_report("-initrd only allowed with -kernel option");
-        exit(1);
-    }
-
-    if (semihosting_enabled() && !semihosting_get_argc() && kernel_filename) {
+    if (semihosting_enabled() && !semihosting_get_argc()) {
+        const char *kernel_filename = qemu_opt_get(machine_opts, "kernel");
+        const char *kernel_cmdline = qemu_opt_get(machine_opts, "append");
         /* fall back to the -kernel/-append */
         semihosting_arg_fallback(kernel_filename, kernel_cmdline);
     }
-- 
2.26.2



