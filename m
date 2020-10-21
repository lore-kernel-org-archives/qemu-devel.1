Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9FFC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:15:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6916324198
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVQnbSD8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6916324198
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVLS8-0008OX-T6
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 17:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVLB3-0005kx-B2
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 16:57:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29695)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVLAx-0006fP-CD
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 16:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603313847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iB6qv4a+aDu0BX/0RS/j/Wdxsua155FSRJWNDGQTqBk=;
 b=cVQnbSD8uuVyrcBhUMIPCpRrXB6ubmhvkK1dHYpGQZjzQ+CvOWEm9NFbj3xJe9DT/M2I2c
 1oxXs8K2DwJem67RmNqnPTEO9B8RRd5lqQjxlFcG4WRcJWOtwrAFE7x1dYrGHD9ZVy1kuc
 OACUsCZtLhPeKCjRk7789MMyn7FUigE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-u815ppS1PtSyQ40Oy-IUsQ-1; Wed, 21 Oct 2020 16:57:25 -0400
X-MC-Unique: u815ppS1PtSyQ40Oy-IUsQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63AC15F9C1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 20:57:24 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D2B936EF62;
 Wed, 21 Oct 2020 20:57:23 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/22] vl: extract qemu_init_subsystems
Date: Wed, 21 Oct 2020 16:57:04 -0400
Message-Id: <20201021205716.2359430-11-pbonzini@redhat.com>
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

Group a bunch of subsystem initializations that can be done right
after command line parsing.  Remove initializations that can be done
simply as global variable initializers.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 softmmu/vl.c | 94 ++++++++++++++++++++++++----------------------------
 1 file changed, 43 insertions(+), 51 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index a9f69a7d11..e731d754ec 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -129,7 +129,7 @@ bool enable_mlock = false;
 bool enable_cpu_pm = false;
 int nb_nics;
 NICInfo nd_table[MAX_NICS];
-int autostart;
+int autostart = 1;
 static enum {
     RTC_BASE_UTC,
     RTC_BASE_LOCALTIME,
@@ -1229,7 +1229,8 @@ struct VMChangeStateEntry {
     int priority;
 };
 
-static QTAILQ_HEAD(, VMChangeStateEntry) vm_change_state_head;
+static QTAILQ_HEAD(, VMChangeStateEntry) vm_change_state_head =
+    QTAILQ_HEAD_INITIALIZER(vm_change_state_head);
 
 /**
  * qemu_add_vm_change_state_handler_prio:
@@ -2962,11 +2963,45 @@ static void qemu_maybe_daemonize(const char *pid_file)
     qemu_add_exit_notifier(&qemu_unlink_pidfile_notifier);
 }
 
+static void qemu_init_subsystems(void)
+{
+    Error *err;
+
+    os_set_line_buffering();
+
+    module_call_init(MODULE_INIT_TRACE);
+
+    qemu_init_cpu_list();
+    qemu_init_cpu_loop();
+    qemu_mutex_lock_iothread();
+
+    atexit(qemu_run_exit_notifiers);
+
+    module_call_init(MODULE_INIT_QOM);
+    module_call_init(MODULE_INIT_MIGRATION);
+
+    runstate_init();
+    precopy_infrastructure_init();
+    postcopy_infrastructure_init();
+    monitor_init_globals();
+
+    if (qcrypto_init(&err) < 0) {
+        error_reportf_err(err, "cannot initialize crypto: ");
+        exit(1);
+    }
+
+    os_setup_early_signal_handling();
+
+    bdrv_init_with_whitelist();
+    page_size_init();
+    socket_init();
+}
 
 void qemu_init(int argc, char **argv, char **envp)
 {
     int i;
-    int snapshot, linux_boot;
+    int snapshot = 0;
+    int linux_boot;
     const char *initrd_filename;
     const char *kernel_filename, *kernel_cmdline;
     const char *boot_order = NULL;
@@ -2987,7 +3022,6 @@ void qemu_init(int argc, char **argv, char **envp)
     ram_addr_t maxram_size;
     uint64_t ram_slots = 0;
     FILE *vmstate_dump_file = NULL;
-    Error *main_loop_err = NULL;
     Error *err = NULL;
     const char *mem_path = NULL;
     bool have_custom_ram_size;
@@ -2995,22 +3029,6 @@ void qemu_init(int argc, char **argv, char **envp)
     QemuPluginList plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
     int mem_prealloc = 0; /* force preallocation of physical target memory */
 
-    os_set_line_buffering();
-
-    error_init(argv[0]);
-    module_call_init(MODULE_INIT_TRACE);
-
-    qemu_init_cpu_list();
-    qemu_init_cpu_loop();
-
-    qemu_mutex_lock_iothread();
-
-    atexit(qemu_run_exit_notifiers);
-    qemu_init_exec_dir(argv[0]);
-
-    module_call_init(MODULE_INIT_QOM);
-    module_call_init(MODULE_INIT_MIGRATION);
-
     qemu_add_opts(&qemu_drive_opts);
     qemu_add_drive_opts(&qemu_legacy_drive_opts);
     qemu_add_drive_opts(&qemu_common_drive_opts);
@@ -3045,27 +3063,10 @@ void qemu_init(int argc, char **argv, char **envp)
     qemu_add_opts(&qemu_fw_cfg_opts);
     module_call_init(MODULE_INIT_OPTS);
 
-    runstate_init();
-    precopy_infrastructure_init();
-    postcopy_infrastructure_init();
-    monitor_init_globals();
-
-    if (qcrypto_init(&err) < 0) {
-        error_reportf_err(err, "cannot initialize crypto: ");
-        exit(1);
-    }
-
-    QTAILQ_INIT(&vm_change_state_head);
-    os_setup_early_signal_handling();
-
-    cpu_option = NULL;
-    snapshot = 0;
-
-    nb_nics = 0;
-
-    bdrv_init_with_whitelist();
+    error_init(argv[0]);
+    qemu_init_exec_dir(argv[0]);
 
-    autostart = 1;
+    qemu_init_subsystems();
 
     /* first pass of option parsing */
     optind = 1;
@@ -3940,13 +3941,10 @@ void qemu_init(int argc, char **argv, char **envp)
     qemu_process_help_options();
     qemu_maybe_daemonize(pid_file);
 
-    if (qemu_init_main_loop(&main_loop_err)) {
-        error_report_err(main_loop_err);
-        exit(1);
-    }
+    qemu_init_main_loop(&error_fatal);
+    cpu_timers_init();
 
     user_register_global_props();
-
     replay_configure(icount_opts);
 
     if (incoming && !preconfig_exit_requested) {
@@ -4125,9 +4123,6 @@ void qemu_init(int argc, char **argv, char **envp)
         exit(1);
     }
 
-    page_size_init();
-    socket_init();
-
     qemu_opts_foreach(qemu_find_opts("object"),
                       user_creatable_add_opts_foreach,
                       object_create_initial, &error_fatal);
@@ -4245,9 +4240,6 @@ void qemu_init(int argc, char **argv, char **envp)
         semihosting_arg_fallback(kernel_filename, kernel_cmdline);
     }
 
-    /* initialize cpu timers and VCPU throttle modules */
-    cpu_timers_init();
-
     if (default_net) {
         QemuOptsList *net = qemu_find_opts("net");
         qemu_opts_set(net, NULL, "type", "nic", &error_abort);
-- 
2.26.2



