Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40187C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:53:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A97862068D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fvjopy16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97862068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT6Vm-0002ls-Bg
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 12:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kT6Na-0004NU-MG
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:45:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31297)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kT6NR-0000XL-Tr
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602780316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dml4u4hzBMkhrKuVpNMnp+Qa3nDbJZGUvC7br4Ju0N0=;
 b=Fvjopy16reUL1ytzNf4YgtWjL+JgQEHBzsyLJCV8ZGVidELU6S9RW8mtENBrO47J5ZJ4uA
 Yfu0++tBryMrbZgaXytFKvM7+FZ1MDSdQu0Rql/lhz7sRCV8ng6sOdK6O+UQUmXqOKsWSM
 bCdo+rHeQq6GsXRdQqnvvu0ewTxA+h4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-29PkpWkCOnONas_RomBwDw-1; Thu, 15 Oct 2020 12:45:14 -0400
X-MC-Unique: 29PkpWkCOnONas_RomBwDw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F6821074665;
 Thu, 15 Oct 2020 16:45:13 +0000 (UTC)
Received: from localhost (ovpn-66-44.rdu2.redhat.com [10.10.66.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3BE6476673;
 Thu, 15 Oct 2020 16:45:13 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 8/9] cpu: Introduce CPU model deprecation API
Date: Thu, 15 Oct 2020 12:45:00 -0400
Message-Id: <20201015164501.462775-9-ehabkost@redhat.com>
In-Reply-To: <20201015164501.462775-1-ehabkost@redhat.com>
References: <20201015164501.462775-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Robert Hoo <robert.hu@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Hoo <robert.hu@linux.intel.com>

Implement the ability of marking some versions deprecated. When
that CPU model is chosen, print a warning.  The warning message
can be customized, e.g. suggesting an alternative CPU model to be
used instead.

The deprecation message will be printed by x86_cpu_list_entry(),
e.g. '-cpu help'.

QMP command 'query-cpu-definitions' will return a bool value
indicating the deprecation status.

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
Message-Id: <1600758855-80046-1-git-send-email-robert.hu@linux.intel.com>
[ehabkost: reword commit message]
[ehabkost: Handle NULL cpu_type]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qapi/machine-target.json |  7 ++++++-
 include/hw/core/cpu.h    |  3 +++
 hw/core/machine.c        | 12 ++++++++++--
 target/i386/cpu.c        |  8 ++++++++
 4 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 698850cc78..fec3bb8679 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -286,6 +286,10 @@
 #            in the VM configuration, because aliases may stop being
 #            migration-safe in the future (since 4.1)
 #
+# @deprecated: If true, this CPU model is deprecated and may be removed in
+#              in some future version of QEMU according to the QEMU deprecation
+#              policy. (since 5.2)
+#
 # @unavailable-features is a list of QOM property names that
 # represent CPU model attributes that prevent the CPU from running.
 # If the QOM property is read-only, that means there's no known
@@ -310,7 +314,8 @@
             'static': 'bool',
             '*unavailable-features': [ 'str' ],
             'typename': 'str',
-            '*alias-of' : 'str' },
+            '*alias-of' : 'str',
+            'deprecated' : 'bool' },
   'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS)' }
 
 ##
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 4879f25026..9c3a45ad7b 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -155,6 +155,8 @@ struct TranslationBlock;
  * @disas_set_info: Setup architecture specific components of disassembly info
  * @adjust_watchpoint_address: Perform a target-specific adjustment to an
  * address before attempting to match it against watchpoints.
+ * @deprecation_note: If this CPUClass is deprecated, this field provides
+ *                    related information.
  *
  * Represents a CPU family or model.
  */
@@ -221,6 +223,7 @@ struct CPUClass {
     vaddr (*adjust_watchpoint_address)(CPUState *cpu, vaddr addr, int len);
     void (*tcg_initialize)(void);
 
+    const char *deprecation_note;
     /* Keep non-pointer data at the end to minimize holes.  */
     int gdb_num_core_regs;
     bool gdb_stop_before_watchpoint;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 7e2f4ec08e..d740a7e963 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1087,6 +1087,8 @@ MemoryRegion *machine_consume_memdev(MachineState *machine,
 void machine_run_board_init(MachineState *machine)
 {
     MachineClass *machine_class = MACHINE_GET_CLASS(machine);
+    ObjectClass *oc = object_class_by_name(machine->cpu_type);
+    CPUClass *cc;
 
     if (machine->ram_memdev_id) {
         Object *o;
@@ -1106,11 +1108,10 @@ void machine_run_board_init(MachineState *machine)
      * specified a CPU with -cpu check here that the user CPU is supported.
      */
     if (machine_class->valid_cpu_types && machine->cpu_type) {
-        ObjectClass *class = object_class_by_name(machine->cpu_type);
         int i;
 
         for (i = 0; machine_class->valid_cpu_types[i]; i++) {
-            if (object_class_dynamic_cast(class,
+            if (object_class_dynamic_cast(oc,
                                           machine_class->valid_cpu_types[i])) {
                 /* The user specificed CPU is in the valid field, we are
                  * good to go.
@@ -1133,6 +1134,13 @@ void machine_run_board_init(MachineState *machine)
         }
     }
 
+    /* Check if CPU type is deprecated and warn if so */
+    cc = CPU_CLASS(oc);
+    if (cc && cc->deprecation_note) {
+        warn_report("CPU model %s is deprecated -- %s", machine->cpu_type,
+                    cc->deprecation_note);
+    }
+
     machine_class->init(machine);
 }
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 25ec64124e..2e3ee41c56 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1633,6 +1633,7 @@ typedef struct X86CPUDefinition {
      * If NULL, version 1 will be registered automatically.
      */
     const X86CPUVersionDefinition *versions;
+    const char *deprecation_note;
 } X86CPUDefinition;
 
 /* Reference to a specific CPU model version */
@@ -4990,6 +4991,11 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
     info->migration_safe = cc->migration_safe;
     info->has_migration_safe = true;
     info->q_static = cc->static_model;
+    if (cc->model && cc->model->cpudef->deprecation_note) {
+        info->deprecated = true;
+    } else {
+        info->deprecated = false;
+    }
     /*
      * Old machine types won't report aliases, so that alias translation
      * doesn't break compatibility with previous QEMU versions.
@@ -5380,9 +5386,11 @@ static void x86_cpu_cpudef_class_init(ObjectClass *oc, void *data)
 {
     X86CPUModel *model = data;
     X86CPUClass *xcc = X86_CPU_CLASS(oc);
+    CPUClass *cc = CPU_CLASS(oc);
 
     xcc->model = model;
     xcc->migration_safe = true;
+    cc->deprecation_note = model->cpudef->deprecation_note;
 }
 
 static void x86_register_cpu_model_type(const char *name, X86CPUModel *model)
-- 
2.28.0


