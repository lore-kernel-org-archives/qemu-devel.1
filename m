Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C94C56202
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:23:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 927812068E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1UGDRGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927812068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXTcr-0005lh-DM
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 14:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXTbp-0004DV-V4
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23054)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXTbf-000304-Ti
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603822922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qDDkAiNZM2kLDoAezmLjPdfsYnkUHb2JHTyXTA89J6Y=;
 b=K1UGDRGInrMXgXrqfW72tF5lYNPv51PWL+kjMoCfncutSzWJgHV/HHQ+D9tx9O7n4RyxYx
 2rfgOmAWINMtcmo3M2rpaVuoAtaoELX51aQIveFRuhZBKPCxL7RapRKKm5lpfTeIJFjgkp
 ILdrAChOn8z+os/lck0UCI623TySP/k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-OadXNI90NgKhn02Go4UahQ-1; Tue, 27 Oct 2020 14:21:59 -0400
X-MC-Unique: OadXNI90NgKhn02Go4UahQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAC46106C05E
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 18:21:47 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F34F60C07
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 18:21:47 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/29] vl: move prelaunch part of qemu_init to new functions
Date: Tue, 27 Oct 2020 14:21:23 -0400
Message-Id: <20201027182144.3315885-9-pbonzini@redhat.com>
In-Reply-To: <20201027182144.3315885-1-pbonzini@redhat.com>
References: <20201027182144.3315885-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The final part of qemu_init, starting with the completion of
board init, is already relatively clean.  Split it out of
qemu_init so that qemu_init keeps only the messy parts.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 softmmu/vl.c | 250 +++++++++++++++++++++++++++------------------------
 1 file changed, 135 insertions(+), 115 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index a086cd7066..f9bae50c27 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -120,6 +120,9 @@
 static const char *cpu_option;
 static const char *data_dir[16];
 static int data_dir_idx;
+static const char *mem_path;
+static const char *boot_order;
+static const char *boot_once;
 enum vga_retrace_method vga_retrace_method = VGA_RETRACE_DUMB;
 int display_opengl;
 const char* keyboard_layout = NULL;
@@ -3000,6 +3003,135 @@ static void qemu_init_subsystems(void)
     socket_init();
 }
 
+/*
+ * Called after leaving preconfig state.  From here on runstate is
+ * RUN_STATE_PRELAUNCH or RUN_STATE_INMIGRATE.
+ */
+static void qemu_finish_machine_init(void)
+{
+    MachineClass *machine_class = MACHINE_GET_CLASS(current_machine);
+
+    if (machine_class->default_ram_id && current_machine->ram_size &&
+        numa_uses_legacy_mem() && !current_machine->ram_memdev_id) {
+        create_default_memdev(current_machine, mem_path);
+    }
+
+    /* from here on runstate is RUN_STATE_PRELAUNCH */
+    machine_run_board_init(current_machine);
+
+    /*
+     * TODO To drop support for deprecated bogus if=..., move
+     * drive_check_orphaned() here, replacing this call.  Also drop
+     * its deprecation warning, along with DriveInfo member
+     * @claimed_by_board.
+     */
+    drive_mark_claimed_by_board();
+
+    realtime_init();
+
+    if (hax_enabled()) {
+        /* FIXME: why isn't cpu_synchronize_all_post_init enough? */
+        hax_sync_vcpus();
+    }
+}
+
+static void qemu_create_cli_devices(void)
+{
+    soundhw_init();
+
+    qemu_opts_foreach(qemu_find_opts("fw_cfg"),
+                      parse_fw_cfg, fw_cfg_find(), &error_fatal);
+
+    /* init USB devices */
+    if (machine_usb(current_machine)) {
+        if (foreach_device_config(DEV_USB, usb_parse) < 0)
+            exit(1);
+    }
+
+    /* init generic devices */
+    rom_set_order_override(FW_CFG_ORDER_OVERRIDE_DEVICE);
+    qemu_opts_foreach(qemu_find_opts("device"),
+                      device_init_func, NULL, &error_fatal);
+    rom_reset_order_override();
+}
+
+static void qemu_machine_creation_done(void)
+{
+    DisplayState *ds;
+
+    cpu_synchronize_all_post_init();
+
+    /* Did we create any drives that we failed to create a device for? */
+    drive_check_orphaned();
+
+    /* Don't warn about the default network setup that you get if
+     * no command line -net or -netdev options are specified. There
+     * are two cases that we would otherwise complain about:
+     * (1) board doesn't support a NIC but the implicit "-net nic"
+     * requested one
+     * (2) CONFIG_SLIRP not set, in which case the implicit "-net nic"
+     * sets up a nic that isn't connected to anything.
+     */
+    if (!default_net && (!qtest_enabled() || has_defaults)) {
+        net_check_clients();
+    }
+
+    if (boot_once) {
+        qemu_boot_set(boot_once, &error_fatal);
+        qemu_register_reset(restore_boot_order, g_strdup(boot_order));
+    }
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
+
+    if (foreach_device_config(DEV_GDB, gdbserver_start) < 0) {
+        exit(1);
+    }
+
+    qdev_machine_creation_done();
+
+    /* TODO: once all bus devices are qdevified, this should be done
+     * when bus is created by qdev.c */
+    /*
+     * TODO: If we had a main 'reset container' that the whole system
+     * lived in, we could reset that using the multi-phase reset
+     * APIs. For the moment, we just reset the sysbus, which will cause
+     * all devices hanging off it (and all their child buses, recursively)
+     * to be reset. Note that this will *not* reset any Device objects
+     * which are not attached to some part of the qbus tree!
+     */
+    qemu_register_reset(resettable_cold_reset_fn, sysbus_get_default());
+    qemu_run_machine_init_done_notifiers();
+
+    if (rom_check_and_register_reset() != 0) {
+        error_report("rom check and register reset failed");
+        exit(1);
+    }
+
+    replay_start();
+
+    /* This checkpoint is required by replay to separate prior clock
+       reading from the other reads, because timer polling functions query
+       clock values from the log. */
+    replay_checkpoint(CHECKPOINT_RESET);
+    qemu_system_reset(SHUTDOWN_CAUSE_NONE);
+    register_global_state();
+}
+
 void qemu_init(int argc, char **argv, char **envp)
 {
     int i;
@@ -3007,9 +3139,6 @@ void qemu_init(int argc, char **argv, char **envp)
     int linux_boot;
     const char *initrd_filename;
     const char *kernel_filename, *kernel_cmdline;
-    const char *boot_order = NULL;
-    const char *boot_once = NULL;
-    DisplayState *ds;
     QemuOpts *opts, *machine_opts;
     QemuOpts *icount_opts = NULL, *accel_opts = NULL;
     QemuOptsList *olist;
@@ -3026,7 +3155,6 @@ void qemu_init(int argc, char **argv, char **envp)
     uint64_t ram_slots = 0;
     FILE *vmstate_dump_file = NULL;
     Error *err = NULL;
-    const char *mem_path = NULL;
     bool have_custom_ram_size;
     BlockdevOptionsQueue bdo_queue = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
     QemuPluginList plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
@@ -4346,117 +4474,10 @@ void qemu_init(int argc, char **argv, char **envp)
     /* do monitor/qmp handling at preconfig state if requested */
     qemu_main_loop();
 
-    if (machine_class->default_ram_id && current_machine->ram_size &&
-        numa_uses_legacy_mem() && !current_machine->ram_memdev_id) {
-        create_default_memdev(current_machine, mem_path);
-    }
-
-    /* from here on runstate is RUN_STATE_PRELAUNCH */
-    machine_run_board_init(current_machine);
-
-    /*
-     * TODO To drop support for deprecated bogus if=..., move
-     * drive_check_orphaned() here, replacing this call.  Also drop
-     * its deprecation warning, along with DriveInfo member
-     * @claimed_by_board.
-     */
-    drive_mark_claimed_by_board();
-
-    realtime_init();
+    qemu_finish_machine_init();
+    qemu_create_cli_devices();
+    qemu_machine_creation_done();
 
-    soundhw_init();
-
-    if (hax_enabled()) {
-        hax_sync_vcpus();
-    }
-
-    qemu_opts_foreach(qemu_find_opts("fw_cfg"),
-                      parse_fw_cfg, fw_cfg_find(), &error_fatal);
-
-    /* init USB devices */
-    if (machine_usb(current_machine)) {
-        if (foreach_device_config(DEV_USB, usb_parse) < 0)
-            exit(1);
-    }
-
-    /* init generic devices */
-    rom_set_order_override(FW_CFG_ORDER_OVERRIDE_DEVICE);
-    qemu_opts_foreach(qemu_find_opts("device"),
-                      device_init_func, NULL, &error_fatal);
-
-    cpu_synchronize_all_post_init();
-
-    rom_reset_order_override();
-
-    /* Did we create any drives that we failed to create a device for? */
-    drive_check_orphaned();
-
-    /* Don't warn about the default network setup that you get if
-     * no command line -net or -netdev options are specified. There
-     * are two cases that we would otherwise complain about:
-     * (1) board doesn't support a NIC but the implicit "-net nic"
-     * requested one
-     * (2) CONFIG_SLIRP not set, in which case the implicit "-net nic"
-     * sets up a nic that isn't connected to anything.
-     */
-    if (!default_net && (!qtest_enabled() || has_defaults)) {
-        net_check_clients();
-    }
-
-    if (boot_once) {
-        qemu_boot_set(boot_once, &error_fatal);
-        qemu_register_reset(restore_boot_order, g_strdup(boot_order));
-    }
-
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
-    if (foreach_device_config(DEV_GDB, gdbserver_start) < 0) {
-        exit(1);
-    }
-
-    qdev_machine_creation_done();
-
-    /* TODO: once all bus devices are qdevified, this should be done
-     * when bus is created by qdev.c */
-    /*
-     * TODO: If we had a main 'reset container' that the whole system
-     * lived in, we could reset that using the multi-phase reset
-     * APIs. For the moment, we just reset the sysbus, which will cause
-     * all devices hanging off it (and all their child buses, recursively)
-     * to be reset. Note that this will *not* reset any Device objects
-     * which are not attached to some part of the qbus tree!
-     */
-    qemu_register_reset(resettable_cold_reset_fn, sysbus_get_default());
-    qemu_run_machine_init_done_notifiers();
-
-    if (rom_check_and_register_reset() != 0) {
-        error_report("rom check and register reset failed");
-        exit(1);
-    }
-
-    replay_start();
-
-    /* This checkpoint is required by replay to separate prior clock
-       reading from the other reads, because timer polling functions query
-       clock values from the log. */
-    replay_checkpoint(CHECKPOINT_RESET);
-    qemu_system_reset(SHUTDOWN_CAUSE_NONE);
-    register_global_state();
     if (loadvm) {
         Error *local_err = NULL;
         if (load_snapshot(loadvm, &local_err) < 0) {
@@ -4475,7 +4496,6 @@ void qemu_init(int argc, char **argv, char **envp)
         dump_vmstate_json_to_file(vmstate_dump_file);
         exit(0);
     }
-
     if (incoming) {
         Error *local_err = NULL;
         qemu_start_incoming_migration(incoming, &local_err);
-- 
2.26.2



