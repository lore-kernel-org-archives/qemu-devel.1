Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7761AC55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:26:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23EE22068E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WqXM15sc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23EE22068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXTg8-0000c9-56
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 14:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXTbj-0004Bf-LW
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:22:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34958)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXTbf-0002zs-9E
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603822922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZdndMIdOYYEdSMnjBJRZlMR5v2AgTI3zsIRusut3b5Q=;
 b=WqXM15scmH0uycVC53e/QWu+JnBInLo3g2wiI9x28Ee8HvkMPTU4qRCtkcmGqOu9hn5yOk
 nZtFSj3qs1S61EYw7DayysgUTh5ciHpbLZyMm8va3q8emubDJyy4wSHndYFVgiFR2Brfro
 wnePofmTLiCoQHA7pbbzw3QoxDW6bk4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-hW4ipLfUOGmwBlpKNLHjRQ-1; Tue, 27 Oct 2020 14:21:59 -0400
X-MC-Unique: hW4ipLfUOGmwBlpKNLHjRQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 723D8107465E
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 18:21:49 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DE1F5D9F1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 18:21:49 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/29] vl: extract various command line desugaring snippets to
 a new function
Date: Tue, 27 Oct 2020 14:21:26 -0400
Message-Id: <20201027182144.3315885-12-pbonzini@redhat.com>
In-Reply-To: <20201027182144.3315885-1-pbonzini@redhat.com>
References: <20201027182144.3315885-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 softmmu/vl.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index c2a5ee61f9..6749109b29 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -126,6 +126,7 @@ static const char *boot_once;
 static const char *incoming;
 static const char *loadvm;
 enum vga_retrace_method vga_retrace_method = VGA_RETRACE_DUMB;
+int mem_prealloc; /* force preallocation of physical target memory */
 int display_opengl;
 const char* keyboard_layout = NULL;
 ram_addr_t ram_size;
@@ -159,7 +160,7 @@ int fd_bootchk = 1;
 static int no_reboot;
 int no_shutdown = 0;
 int graphic_rotate = 0;
-const char *watchdog;
+static const char *watchdog;
 QEMUOptionRom option_rom[MAX_OPTION_ROMS];
 int nb_option_roms;
 int old_param = 0;
@@ -2910,6 +2911,25 @@ static void qemu_validate_options(void)
 #endif
 }
 
+static void qemu_process_sugar_options(void)
+{
+    if (mem_prealloc) {
+        char *val;
+
+        val = g_strdup_printf("%d",
+                 (uint32_t) qemu_opt_get_number(qemu_find_opts_singleton("smp-opts"), "cpus", 1));
+        object_register_sugar_prop("memory-backend", "prealloc-threads", val);
+        g_free(val);
+        object_register_sugar_prop("memory-backend", "prealloc", "on");
+    }
+
+    if (watchdog) {
+        int i = select_watchdog(watchdog);
+        if (i > 0)
+            exit (i == 1 ? 1 : 0);
+    }
+}
+
 static void qemu_process_early_options(void)
 {
     char **dirs;
@@ -3174,7 +3194,6 @@ static void qemu_machine_creation_done(void)
 
 void qemu_init(int argc, char **argv, char **envp)
 {
-    int i;
     int snapshot = 0;
     QemuOpts *opts, *machine_opts;
     QemuOpts *icount_opts = NULL, *accel_opts = NULL;
@@ -3193,7 +3212,6 @@ void qemu_init(int argc, char **argv, char **envp)
     bool have_custom_ram_size;
     BlockdevOptionsQueue bdo_queue = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
     QemuPluginList plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
-    int mem_prealloc = 0; /* force preallocation of physical target memory */
 
     qemu_add_opts(&qemu_drive_opts);
     qemu_add_drive_opts(&qemu_legacy_drive_opts);
@@ -4104,6 +4122,7 @@ void qemu_init(int argc, char **argv, char **envp)
     loc_set_none();
 
     qemu_validate_options();
+    qemu_process_sugar_options();
 
     /* These options affect everything else and should be processed
      * before daemonizing.
@@ -4155,15 +4174,6 @@ void qemu_init(int argc, char **argv, char **envp)
     machine_smp_parse(current_machine,
         qemu_opts_find(qemu_find_opts("smp-opts"), NULL), &error_fatal);
 
-    if (mem_prealloc) {
-        char *val;
-
-        val = g_strdup_printf("%d", current_machine->smp.cpus);
-        object_register_sugar_prop("memory-backend", "prealloc-threads", val);
-        g_free(val);
-        object_register_sugar_prop("memory-backend", "prealloc", "on");
-    }
-
     /*
      * Get the default machine options from the machine if it is not already
      * specified either by the configuration file or by the command line.
@@ -4422,12 +4432,6 @@ void qemu_init(int argc, char **argv, char **envp)
         select_vgahw(machine_class, vga_model);
     }
 
-    if (watchdog) {
-        i = select_watchdog(watchdog);
-        if (i > 0)
-            exit (i == 1 ? 1 : 0);
-    }
-
     /* This checkpoint is required by replay to separate prior clock
        reading from the other reads, because timer polling functions query
        clock values from the log. */
-- 
2.26.2



