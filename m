Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201FDC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B0F420760
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fe2xs172"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0F420760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXTsb-0000Uf-Jf
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 14:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXTby-0004GN-7L
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:22:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49916)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXTbp-00032I-Uq
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603822926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Up+gosc1jXTvnOZXsQKT0Wdpdzi58kR6SkUZKts8wVk=;
 b=Fe2xs172lh9AL3ZjKgyFV8eOtZ7ZSEvSjNxuP0O8RAAc4KIgKISrwoufpw5PNqWEhB8l2O
 jIGMKsZt21O9Ut5lNfuXfL53IHyllzuI2x1PcsLrLqg/FNlkRvIpGWJnrDfrhSii7jPgCb
 pNpFbl49GYjF/1anzY3VEH0mNJbUC8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-Xf1ro3I_OQacqOZxWvNIQQ-1; Tue, 27 Oct 2020 14:22:03 -0400
X-MC-Unique: Xf1ro3I_OQacqOZxWvNIQQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDCDC18FE864
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 18:21:53 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9AF2B50B44
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 18:21:53 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 22/29] vl: initialize displays before preconfig loop
Date: Tue, 27 Oct 2020 14:21:37 -0400
Message-Id: <20201027182144.3315885-23-pbonzini@redhat.com>
In-Reply-To: <20201027182144.3315885-1-pbonzini@redhat.com>
References: <20201027182144.3315885-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Displays should be available before the monitor starts, so that
it is possible to use the graphical console to interact with
the monitor itself.

This patch is quite ugly, but all this is temporary.  The double
call to qemu_init_displays will go away as soon we can unify machine
initialization between the preconfig and "normal" flows, and so will
the preconfig_exit_requested variable (that is only preconfig_requested
remains).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 softmmu/vl.c | 58 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 1485aba8be..a46f1b9164 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -137,6 +137,7 @@ static ram_addr_t maxram_size;
 static uint64_t ram_slots;
 static int display_remote;
 static int snapshot;
+static bool preconfig_requested;
 static QemuPluginList plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
 static BlockdevOptionsQueue bdo_queue = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
 static bool nographic = false;
@@ -3210,12 +3211,12 @@ static void qemu_validate_options(void)
           }
     }
 
-    if (loadvm && !preconfig_exit_requested) {
+    if (loadvm && preconfig_requested) {
         error_report("'preconfig' and 'loadvm' options are "
                      "mutually exclusive");
         exit(EXIT_FAILURE);
     }
-    if (incoming && !preconfig_exit_requested) {
+    if (incoming && preconfig_requested) {
         error_report("'preconfig' and 'incoming' options are "
                      "mutually exclusive");
         exit(EXIT_FAILURE);
@@ -3381,6 +3382,28 @@ static void qemu_init_subsystems(void)
     socket_init();
 }
 
+static void qemu_init_displays(void)
+{
+    DisplayState *ds;
+
+    /* init local displays */
+    ds = init_displaystate();
+    qemu_display_init(ds, &dpy);
+
+    /* must be after terminal init, SDL library changes signal handlers */
+    os_setup_signal_handling();
+
+    /* init remote displays */
+#ifdef CONFIG_VNC
+    qemu_opts_foreach(qemu_find_opts("vnc"),
+                      vnc_init_func, NULL, &error_fatal);
+#endif
+
+    if (using_spice) {
+        qemu_spice.display_init();
+    }
+}
+
 /*
  * Called after leaving preconfig state.  From here on runstate is
  * RUN_STATE_PRELAUNCH or RUN_STATE_INMIGRATE.
@@ -3449,8 +3472,6 @@ static void qemu_create_cli_devices(void)
 
 static void qemu_machine_creation_done(void)
 {
-    DisplayState *ds;
-
     cpu_synchronize_all_post_init();
 
     /* Did we create any drives that we failed to create a device for? */
@@ -3473,23 +3494,6 @@ static void qemu_machine_creation_done(void)
         qemu_register_reset(restore_boot_order, g_strdup(boot_order));
     }
 
-    /* init local displays */
-    ds = init_displaystate();
-    qemu_display_init(ds, &dpy);
-
-    /* must be after terminal init, SDL library changes signal handlers */
-    os_setup_signal_handling();
-
-    /* init remote displays */
-#ifdef CONFIG_VNC
-    qemu_opts_foreach(qemu_find_opts("vnc"),
-                      vnc_init_func, NULL, &error_fatal);
-#endif
-
-    if (using_spice) {
-        qemu_spice.display_init();
-    }
-
     if (foreach_device_config(DEV_GDB, gdbserver_start) < 0) {
         exit(1);
     }
@@ -4094,6 +4098,7 @@ void qemu_init(int argc, char **argv, char **envp)
                 break;
             case QEMU_OPTION_preconfig:
                 preconfig_exit_requested = false;
+                preconfig_requested = true;
                 break;
             case QEMU_OPTION_enable_kvm:
                 olist = qemu_find_opts("machine");
@@ -4515,11 +4520,20 @@ void qemu_init(int argc, char **argv, char **envp)
     qemu_resolve_machine_memdev();
     parse_numa_opts(current_machine);
 
+    if (preconfig_requested) {
+        qemu_init_displays();
+    }
+
     /* do monitor/qmp handling at preconfig state if requested */
     qemu_main_loop();
-
     qemu_finish_machine_init();
+
     qemu_create_cli_devices();
+
+    /* initialize displays after all errors have been reported */
+    if (!preconfig_requested) {
+        qemu_init_displays();
+    }
     qemu_machine_creation_done();
 
     if (loadvm) {
-- 
2.26.2



