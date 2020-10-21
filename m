Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E880C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:09:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8303121481
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RWZQMCJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8303121481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVLLx-0001at-B9
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 17:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVLAz-0005aE-7o
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 16:57:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26257)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVLAv-0006gz-AU
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 16:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603313853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sjO3LEWU1B+vyfhOtmKRmrtOL9ZWXQ7OGar1eX5wPng=;
 b=RWZQMCJsdK9YIWS9Ckqk9PAje6Ha5QmAVTpwd/gqmbEXHk+jX8yJRxpSz8c1DUKX8qgfsm
 0Z9dJxB2Nf+3hisXrTl4CfHp46GGCUITaBtKhPxUxPHyigbMfdXpKu0zLYNHKGpUPxICty
 0clC+mO2B5BCjd4gk7X0e7e7/kbMJjo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-s-xvwK2dM72ao_u5E8FBYQ-1; Wed, 21 Oct 2020 16:57:31 -0400
X-MC-Unique: s-xvwK2dM72ao_u5E8FBYQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A88E2107AFA5
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 20:57:30 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 25C596EF62;
 Wed, 21 Oct 2020 20:57:30 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/22] vl: extract various command line desugaring snippets to
 a new function
Date: Wed, 21 Oct 2020 16:57:09 -0400
Message-Id: <20201021205716.2359430-16-pbonzini@redhat.com>
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
 softmmu/vl.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 3607cd4357..122bf1821b 100644
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
@@ -2906,6 +2907,24 @@ static void qemu_validate_options(void)
 #endif
 }
 
+static void qemu_process_sugar_options(void)
+{
+    if (mem_prealloc) {
+        char *val;
+
+        val = g_strdup_printf("%ld", qemu_opt_get_number(qemu_find_opts_singleton("smp-opts"), "cpus", 1));
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
@@ -3160,7 +3179,6 @@ void qemu_finish_machine_init(void)
 
 void qemu_init(int argc, char **argv, char **envp)
 {
-    int i;
     int snapshot = 0;
     QemuOpts *opts, *machine_opts;
     QemuOpts *icount_opts = NULL, *accel_opts = NULL;
@@ -3179,7 +3197,6 @@ void qemu_init(int argc, char **argv, char **envp)
     bool have_custom_ram_size;
     BlockdevOptionsQueue bdo_queue = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
     QemuPluginList plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
-    int mem_prealloc = 0; /* force preallocation of physical target memory */
 
     qemu_add_opts(&qemu_drive_opts);
     qemu_add_drive_opts(&qemu_legacy_drive_opts);
@@ -4086,6 +4103,7 @@ void qemu_init(int argc, char **argv, char **envp)
     loc_set_none();
 
     qemu_validate_options();
+    qemu_process_sugar_options();
 
     /* These options affect everything else and should be processed
      * before daemonizing.
@@ -4137,15 +4155,6 @@ void qemu_init(int argc, char **argv, char **envp)
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
@@ -4404,12 +4413,6 @@ void qemu_init(int argc, char **argv, char **envp)
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



