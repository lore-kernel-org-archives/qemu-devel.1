Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E24C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:49:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69AEB207DE
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZduzi8B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69AEB207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXU2V-0003LC-Fk
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 14:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXTc1-0004Om-M7
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:22:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54439)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXTbr-00032n-KO
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603822928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0aebqn9mcpgjpysUq+vt/qsdYGZP78xp3OuddpIOlKE=;
 b=XZduzi8BvRz/+HtT4gt97G7oT3awp7LhPVHGxfCHpbdaO0JiKb8xb0n4c4wsgQ46XcIK2l
 gt3vngNwYEqBdNkqx/V6v/1vWywcOB2v4HEgfJKeW7AfHbWmRjQkoz6PHT7RgohEhxSViy
 sf+raDLliVyIJKiGSX0jfEvQfQFaycE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-y5FRCb4LOBa0SaoYIWLj7w-1; Tue, 27 Oct 2020 14:22:06 -0400
X-MC-Unique: y5FRCb4LOBa0SaoYIWLj7w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28987A0C1B
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 18:21:52 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE2175D9E8
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 18:21:51 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/29] vl: separate qemu_create_late_backends
Date: Tue, 27 Oct 2020 14:21:33 -0400
Message-Id: <20201027182144.3315885-19-pbonzini@redhat.com>
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

"Late" backends are created after the machine.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 softmmu/vl.c | 64 ++++++++++++++++++++++++++--------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 109036c089..0c390b979e 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2755,11 +2755,41 @@ static void qemu_create_early_backends(void)
  * The remainder of object creation happens after the
  * creation of chardev, fsdev, net clients and device data types.
  */
-static bool object_create_delayed(const char *type, QemuOpts *opts)
+static bool object_create_late(const char *type, QemuOpts *opts)
 {
     return !object_create_early(type, opts);
 }
 
+static void qemu_create_late_backends(void)
+{
+    if (qtest_chrdev) {
+        qtest_server_init(qtest_chrdev, qtest_log, &error_fatal);
+    }
+
+    net_init_clients(&error_fatal);
+
+    qemu_opts_foreach(qemu_find_opts("object"),
+                      user_creatable_add_opts_foreach,
+                      object_create_late, &error_fatal);
+
+    if (tpm_init() < 0) {
+        exit(1);
+    }
+
+    qemu_opts_foreach(qemu_find_opts("mon"),
+                      mon_init_func, NULL, &error_fatal);
+
+    if (foreach_device_config(DEV_SERIAL, serial_parse) < 0)
+        exit(1);
+    if (foreach_device_config(DEV_PARALLEL, parallel_parse) < 0)
+        exit(1);
+    if (foreach_device_config(DEV_DEBUGCON, debugcon_parse) < 0)
+        exit(1);
+
+    /* now chardevs have been created we may have semihosting to connect */
+    qemu_semihosting_connect_chardevs();
+    qemu_semihosting_console_init();
+}
 
 static bool set_memory_options(uint64_t *ram_slots, ram_addr_t *maxram_size,
                                MachineClass *mc)
@@ -3385,7 +3415,6 @@ void qemu_init(int argc, char **argv, char **envp)
     ram_addr_t maxram_size;
     uint64_t ram_slots = 0;
     FILE *vmstate_dump_file = NULL;
-    Error *err = NULL;
     bool have_custom_ram_size;
 
     qemu_add_opts(&qemu_drive_opts);
@@ -4402,10 +4431,6 @@ void qemu_init(int argc, char **argv, char **envp)
      */
     migration_object_init();
 
-    if (qtest_chrdev) {
-        qtest_server_init(qtest_chrdev, qtest_log, &error_fatal);
-    }
-
     opts = qemu_opts_find(qemu_find_opts("boot-opts"), NULL);
     if (opts) {
         boot_order = qemu_opt_get(opts, "order");
@@ -4426,32 +4451,7 @@ void qemu_init(int argc, char **argv, char **envp)
         boot_order = machine_class->default_boot_order;
     }
 
-    if (net_init_clients(&err) < 0) {
-        error_report_err(err);
-        exit(1);
-    }
-
-    qemu_opts_foreach(qemu_find_opts("object"),
-                      user_creatable_add_opts_foreach,
-                      object_create_delayed, &error_fatal);
-
-    if (tpm_init() < 0) {
-        exit(1);
-    }
-
-    qemu_opts_foreach(qemu_find_opts("mon"),
-                      mon_init_func, NULL, &error_fatal);
-
-    if (foreach_device_config(DEV_SERIAL, serial_parse) < 0)
-        exit(1);
-    if (foreach_device_config(DEV_PARALLEL, parallel_parse) < 0)
-        exit(1);
-    if (foreach_device_config(DEV_DEBUGCON, debugcon_parse) < 0)
-        exit(1);
-
-    /* now chardevs have been created we may have semihosting to connect */
-    qemu_semihosting_connect_chardevs();
-    qemu_semihosting_console_init();
+    qemu_create_late_backends();
 
     current_machine->boot_order = boot_order;
 
-- 
2.26.2



