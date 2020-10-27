Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154CBC55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:34:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 855C820709
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHef+Evt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855C820709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXTnt-0001y9-HL
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 14:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXTbu-0004Ee-Bj
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:22:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33257)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXTbh-00031A-J7
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603822924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+z6vD7sn9n3xwQklUHzR7mpLArjc7cZLHh/EpGkAZOI=;
 b=eHef+EvtFsmm40DR+Nlf/2Hu7z+fF64yv8tD/pYHXVZcSU/DCIkg33L0d83gESyFL/Xwl5
 vpjcOPTTllsRxASoYb0P6NCXtIVxhxffya6uUU+kEl4abi0LktVL8U9Sw2xYIFJiaH5Snh
 vqv24IHeVzH9oy4vOSJzCTszSRoZeX4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-c5Ut2ofnP9KmERObkG6OoA-1; Tue, 27 Oct 2020 14:22:02 -0400
X-MC-Unique: c5Ut2ofnP9KmERObkG6OoA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81C2318CBC59
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 18:21:52 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 467D45D9E8
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 18:21:52 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/29] vl: separate qemu_create_machine
Date: Tue, 27 Oct 2020 14:21:34 -0400
Message-Id: <20201027182144.3315885-20-pbonzini@redhat.com>
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
 softmmu/vl.c | 111 +++++++++++++++++++++++++++------------------------
 1 file changed, 59 insertions(+), 52 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 0c390b979e..38ad3cc895 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -133,6 +133,8 @@ static const char *boot_order;
 static const char *boot_once;
 static const char *incoming;
 static const char *loadvm;
+static ram_addr_t maxram_size;
+static uint64_t ram_slots;
 static int display_remote;
 static int snapshot;
 static QemuPluginList plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
@@ -2791,8 +2793,13 @@ static void qemu_create_late_backends(void)
     qemu_semihosting_console_init();
 }
 
-static bool set_memory_options(uint64_t *ram_slots, ram_addr_t *maxram_size,
-                               MachineClass *mc)
+static bool have_custom_ram_size(void)
+{
+    QemuOpts *opts = qemu_find_opts_singleton("memory");
+    return !!qemu_opt_get(opts, "size");
+}
+
+static void set_memory_options(MachineClass *mc)
 {
     uint64_t sz;
     const char *mem_str;
@@ -2842,7 +2849,7 @@ static bool set_memory_options(uint64_t *ram_slots, ram_addr_t *maxram_size,
 
     /* store value for the future use */
     qemu_opt_set_number(opts, "size", ram_size, &error_abort);
-    *maxram_size = ram_size;
+    maxram_size = ram_size;
 
     if (qemu_opt_get(opts, "maxmem")) {
         uint64_t slots;
@@ -2863,15 +2870,58 @@ static bool set_memory_options(uint64_t *ram_slots, ram_addr_t *maxram_size,
             exit(EXIT_FAILURE);
         }
 
-        *maxram_size = sz;
-        *ram_slots = slots;
+        maxram_size = sz;
+        ram_slots = slots;
     } else if (qemu_opt_get(opts, "slots")) {
         error_report("invalid -m option value: missing 'maxmem' option");
         exit(EXIT_FAILURE);
     }
 
     loc_pop(&loc);
-    return !!mem_str;
+}
+
+static void qemu_create_machine(MachineClass *machine_class)
+{
+    object_set_machine_compat_props(machine_class->compat_props);
+
+    set_memory_options(machine_class);
+
+    current_machine = MACHINE(object_new_with_class(OBJECT_CLASS(machine_class)));
+    if (machine_help_func(qemu_get_machine_opts(), current_machine)) {
+        exit(0);
+    }
+    object_property_add_child(object_get_root(), "machine",
+                              OBJECT(current_machine));
+    object_property_add_child(container_get(OBJECT(current_machine),
+                                            "/unattached"),
+                              "sysbus", OBJECT(sysbus_get_default()));
+
+    if (machine_class->minimum_page_bits) {
+        if (!set_preferred_target_page_bits(machine_class->minimum_page_bits)) {
+            /* This would be a board error: specifying a minimum smaller than
+             * a target's compile-time fixed setting.
+             */
+            g_assert_not_reached();
+        }
+    }
+
+    cpu_exec_init_all();
+
+    if (machine_class->hw_version) {
+        qemu_set_hw_version(machine_class->hw_version);
+    }
+
+    machine_smp_parse(current_machine,
+        qemu_opts_find(qemu_find_opts("smp-opts"), NULL), &error_fatal);
+
+    /*
+     * Get the default machine options from the machine if it is not already
+     * specified either by the configuration file or by the command line.
+     */
+    if (machine_class->default_machine_opts) {
+        qemu_opts_set_defaults(qemu_find_opts("machine"),
+                               machine_class->default_machine_opts, 0);
+    }
 }
 
 static int global_init_func(void *opaque, QemuOpts *opts, Error **errp)
@@ -3412,10 +3462,7 @@ void qemu_init(int argc, char **argv, char **envp)
     const char *optarg;
     MachineClass *machine_class;
     bool userconfig = true;
-    ram_addr_t maxram_size;
-    uint64_t ram_slots = 0;
     FILE *vmstate_dump_file = NULL;
-    bool have_custom_ram_size;
 
     qemu_add_opts(&qemu_drive_opts);
     qemu_add_drive_opts(&qemu_legacy_drive_opts);
@@ -4344,48 +4391,7 @@ void qemu_init(int argc, char **argv, char **envp)
 
     configure_rtc(qemu_find_opts_singleton("rtc"));
 
-    machine_class = select_machine();
-    object_set_machine_compat_props(machine_class->compat_props);
-
-    have_custom_ram_size = set_memory_options(&ram_slots, &maxram_size,
-                                              machine_class);
-
-    current_machine = MACHINE(object_new_with_class(OBJECT_CLASS(machine_class)));
-    if (machine_help_func(qemu_get_machine_opts(), current_machine)) {
-        exit(0);
-    }
-    object_property_add_child(object_get_root(), "machine",
-                              OBJECT(current_machine));
-    object_property_add_child(container_get(OBJECT(current_machine),
-                                            "/unattached"),
-                              "sysbus", OBJECT(sysbus_get_default()));
-
-    if (machine_class->minimum_page_bits) {
-        if (!set_preferred_target_page_bits(machine_class->minimum_page_bits)) {
-            /* This would be a board error: specifying a minimum smaller than
-             * a target's compile-time fixed setting.
-             */
-            g_assert_not_reached();
-        }
-    }
-
-    cpu_exec_init_all();
-
-    if (machine_class->hw_version) {
-        qemu_set_hw_version(machine_class->hw_version);
-    }
-
-    machine_smp_parse(current_machine,
-        qemu_opts_find(qemu_find_opts("smp-opts"), NULL), &error_fatal);
-
-    /*
-     * Get the default machine options from the machine if it is not already
-     * specified either by the configuration file or by the command line.
-     */
-    if (machine_class->default_machine_opts) {
-        qemu_opts_set_defaults(qemu_find_opts("machine"),
-                               machine_class->default_machine_opts, 0);
-    }
+    qemu_create_machine(select_machine());
 
     qemu_disable_default_devices();
     qemu_create_default_devices();
@@ -4420,6 +4426,7 @@ void qemu_init(int argc, char **argv, char **envp)
      * called from configure_accelerator().
      */
 
+    machine_class = MACHINE_GET_CLASS(current_machine);
     if (!qtest_enabled() && machine_class->deprecation_reason) {
         error_report("Machine type '%s' is deprecated: %s",
                      machine_class->name, machine_class->deprecation_reason);
@@ -4473,7 +4480,7 @@ void qemu_init(int argc, char **argv, char **envp)
             exit(EXIT_FAILURE);
         }
         backend_size = object_property_get_uint(backend, "size",  &error_abort);
-        if (have_custom_ram_size && backend_size != ram_size) {
+        if (have_custom_ram_size() && backend_size != ram_size) {
                 error_report("Size specified by -m option must match size of "
                              "explicitly specified 'memory-backend' property");
                 exit(EXIT_FAILURE);
-- 
2.26.2



