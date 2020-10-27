Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D93AC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:45:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B956320760
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFYzzNQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B956320760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXTyc-0008P8-O6
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 14:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXTbx-0004Ez-2I
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:22:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40692)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXTbi-00031Z-Ap
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603822925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cAGKRHLtgm9wbyrFBFMa1kpYshVl3fuYb8MJhn6kT88=;
 b=PFYzzNQBP+8HFKtKS+vLg6FWBeZvrZZlliK+7iOPBSnl0nosve3zqrYy6fwaZvEp41Xxl2
 pOaRUiwZnER4sJRCktKYGQgaHv1AIuWeCKIA/Ao0tVZk3X4ZyYFM7Vi18tPTFuPtRgs4nb
 twzgP3WbugJAFyPwhZ4TzkVcS/ROfLQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-WJJ75CFZNaGA8JUvRUOWuA-1; Tue, 27 Oct 2020 14:22:03 -0400
X-MC-Unique: WJJ75CFZNaGA8JUvRUOWuA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3073918CBC79
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 18:21:53 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F0F2F50B44
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 18:21:52 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 20/29] vl: separate qemu_apply_machine_options
Date: Tue, 27 Oct 2020 14:21:35 -0400
Message-Id: <20201027182144.3315885-21-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 softmmu/vl.c | 66 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 38ad3cc895..9a3c92387e 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2700,6 +2700,41 @@ static bool object_create_early(const char *type, QemuOpts *opts)
     return true;
 }
 
+static void qemu_apply_machine_options(void)
+{
+    MachineClass *machine_class = MACHINE_GET_CLASS(current_machine);
+    QemuOpts *machine_opts = qemu_get_machine_opts();
+    QemuOpts *opts;
+
+    qemu_opt_foreach(machine_opts, machine_set_property, current_machine,
+                     &error_fatal);
+    current_machine->ram_size = ram_size;
+    current_machine->maxram_size = maxram_size;
+    current_machine->ram_slots = ram_slots;
+
+    opts = qemu_opts_find(qemu_find_opts("boot-opts"), NULL);
+    if (opts) {
+        boot_order = qemu_opt_get(opts, "order");
+        if (boot_order) {
+            validate_bootdevices(boot_order, &error_fatal);
+        }
+
+        boot_once = qemu_opt_get(opts, "once");
+        if (boot_once) {
+            validate_bootdevices(boot_once, &error_fatal);
+        }
+
+        boot_menu = qemu_opt_get_bool(opts, "menu", boot_menu);
+        boot_strict = qemu_opt_get_bool(opts, "strict", false);
+    }
+
+    if (!boot_order) {
+        boot_order = machine_class->default_boot_order;
+    }
+
+    current_machine->boot_order = boot_order;
+}
+
 static void qemu_create_early_backends(void)
 {
     MachineClass *machine_class = MACHINE_GET_CLASS(current_machine);
@@ -3455,7 +3490,7 @@ static void qemu_machine_creation_done(void)
 
 void qemu_init(int argc, char **argv, char **envp)
 {
-    QemuOpts *opts, *machine_opts;
+    QemuOpts *opts;
     QemuOpts *icount_opts = NULL, *accel_opts = NULL;
     QemuOptsList *olist;
     int optind;
@@ -4397,12 +4432,7 @@ void qemu_init(int argc, char **argv, char **envp)
     qemu_create_default_devices();
     qemu_create_early_backends();
 
-    machine_opts = qemu_get_machine_opts();
-    qemu_opt_foreach(machine_opts, machine_set_property, current_machine,
-                     &error_fatal);
-    current_machine->ram_size = ram_size;
-    current_machine->maxram_size = maxram_size;
-    current_machine->ram_slots = ram_slots;
+    qemu_apply_machine_options();
 
     /*
      * Note: uses machine properties such as kernel-irqchip, must run
@@ -4438,30 +4468,8 @@ void qemu_init(int argc, char **argv, char **envp)
      */
     migration_object_init();
 
-    opts = qemu_opts_find(qemu_find_opts("boot-opts"), NULL);
-    if (opts) {
-        boot_order = qemu_opt_get(opts, "order");
-        if (boot_order) {
-            validate_bootdevices(boot_order, &error_fatal);
-        }
-
-        boot_once = qemu_opt_get(opts, "once");
-        if (boot_once) {
-            validate_bootdevices(boot_once, &error_fatal);
-        }
-
-        boot_menu = qemu_opt_get_bool(opts, "menu", boot_menu);
-        boot_strict = qemu_opt_get_bool(opts, "strict", false);
-    }
-
-    if (!boot_order) {
-        boot_order = machine_class->default_boot_order;
-    }
-
     qemu_create_late_backends();
 
-    current_machine->boot_order = boot_order;
-
     /* parse features once if machine provides default cpu_type */
     current_machine->cpu_type = machine_class->default_cpu_type;
     if (cpu_option) {
-- 
2.26.2



