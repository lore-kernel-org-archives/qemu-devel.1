Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C36EC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 23:10:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 137FE21D7F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 23:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2xLKkFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137FE21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSTRM-00051F-60
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 19:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kSTMv-00077Q-39
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 19:06:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42762)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kSTMr-0003ky-Tg
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 19:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602630362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JuXZUizPitfToIYjvGSlfEdgnZ1Kh4hY1IZ1XTdd/j0=;
 b=h2xLKkFG2crMUS9nzy9P4mZCiD2Lt7/0iGzOtk1MTQCEz8vJ8HC96e9i+BrN3KB2uX3sdR
 GgG5RzBV2cdC2iOZZyPHubtvLtoXYh/NI1Fe04E5x/vhmtdn8IMJy38gBVmVpDATkvN6Ci
 w9Lgal2F6fXDXY9b+uIao0kX7T2S1W4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-i9SzE-LQPSeay-a6hoV3Bw-1; Tue, 13 Oct 2020 19:05:57 -0400
X-MC-Unique: i9SzE-LQPSeay-a6hoV3Bw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 841A11007464;
 Tue, 13 Oct 2020 23:05:55 +0000 (UTC)
Received: from localhost (ovpn-66-44.rdu2.redhat.com [10.10.66.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A83276663;
 Tue, 13 Oct 2020 23:05:48 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 7/7] cpu: Add `machine` parameter to query-cpu-definitions
Date: Tue, 13 Oct 2020 19:04:57 -0400
Message-Id: <20201013230457.150630-8-ehabkost@redhat.com>
In-Reply-To: <20201013230457.150630-1-ehabkost@redhat.com>
References: <20201013230457.150630-1-ehabkost@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 19:05:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The new parameter can be used by management software to query for
CPU model alias information for multiple machines without
restarting QEMU.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* Rewrite documentation, with suggestions from Markus
---
 qapi/machine-target.json                   | 14 ++++++-
 target/arm/helper.c                        |  4 +-
 target/i386/cpu.c                          | 24 ++++++++++-
 target/mips/helper.c                       |  4 +-
 target/s390x/cpu_models.c                  |  4 +-
 target/ppc/translate_init.c.inc            |  4 +-
 tests/acceptance/x86_cpu_model_versions.py | 48 ++++++++++++++++++++++
 7 files changed, 95 insertions(+), 7 deletions(-)

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 698850cc78..211cb2d7c9 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -282,6 +282,10 @@
 #
 # @alias-of: Name of CPU model this model is an alias for.  The target of the
 #            CPU model alias may change depending on the machine type.
+#            If the @machine argument was provided to query-cpu-definitions,
+#            alias information for that machine type will be returned.
+#            If @machine is not provided, alias information for
+#            the current machine will be returned.
 #            Management software is supposed to translate CPU model aliases
 #            in the VM configuration, because aliases may stop being
 #            migration-safe in the future (since 4.1)
@@ -318,9 +322,17 @@
 #
 # Return a list of supported virtual CPU definitions
 #
+# @machine: Name of machine type.  The value of the @alias-of field
+#           is machine-specific.  This overrides the machine type
+#           used to look up that information.  This can be used
+#           to query machine-specific CPU model aliases without
+#           restarting QEMU (since 5.2)
+#
 # Returns: a list of CpuDefInfo
 #
 # Since: 1.2.0
 ##
-{ 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'],
+{ 'command': 'query-cpu-definitions',
+  'data': { '*machine': 'str' },
+  'returns': ['CpuDefinitionInfo'],
   'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS)' }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index cd0779ff5f..fc339a19ba 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8276,7 +8276,9 @@ static void arm_cpu_add_definition(gpointer data, gpointer user_data)
     *cpu_list = entry;
 }
 
-CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+CpuDefinitionInfoList *qmp_query_cpu_definitions(bool has_machine,
+                                                 const char *machine,
+                                                 Error **errp)
 {
     CpuDefinitionInfoList *cpu_list = NULL;
     GSList *list;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0807d12ffa..d78ff6a563 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -56,6 +56,7 @@
 #ifndef CONFIG_USER_ONLY
 #include "exec/address-spaces.h"
 #include "hw/i386/apic_internal.h"
+#include "hw/i386/pc.h"
 #include "hw/boards.h"
 #endif
 
@@ -4187,6 +4188,13 @@ static char *x86_cpu_model_resolve_alias(const X86CPUModel *model,
     }
     return x86_cpu_versioned_model_name(model->cpudef, version);
 }
+
+static X86CPUVersion default_cpu_version_for_machine(MachineClass *mc)
+{
+    PCMachineClass *pcmc =
+        (PCMachineClass *)object_class_dynamic_cast(OBJECT_CLASS(mc), TYPE_PC_MACHINE);
+    return pcmc ? pcmc->default_cpu_version : 1;
+}
 #endif
 
 void x86_cpu_change_kvm_default(const char *prop, const char *value)
@@ -5027,12 +5035,24 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
     args->cpu_list = entry;
 }
 
-CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+CpuDefinitionInfoList *qmp_query_cpu_definitions(bool has_machine,
+                                                 const char *machine,
+                                                 Error **errp)
 {
     X86CPUDefinitionArgs args = { .cpu_list = NULL };
     GSList *list = get_sorted_cpu_model_list();
 
-    args.default_version = default_cpu_version;
+    if (!has_machine) {
+        args.default_version = default_cpu_version;
+    } else {
+        MachineClass *mc = machine_find_class(machine);
+        if (!mc) {
+            error_setg(errp, "Machine type '%s' not found", machine);
+            return NULL;
+        }
+        args.default_version = default_cpu_version_for_machine(mc);
+    }
+
     g_slist_foreach(list, x86_cpu_definition_entry, &args);
     g_slist_free(list);
     return args.cpu_list;
diff --git a/target/mips/helper.c b/target/mips/helper.c
index afd78b1990..33351e9578 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -1518,7 +1518,9 @@ static void mips_cpu_add_definition(gpointer data, gpointer user_data)
     *cpu_list = entry;
 }
 
-CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+CpuDefinitionInfoList *qmp_query_cpu_definitions(bool has_machine,
+                                                 const char *machine,
+                                                 Error **errp)
 {
     CpuDefinitionInfoList *cpu_list = NULL;
     GSList *list;
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index ca484bfda7..19ccbd50ea 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -456,7 +456,9 @@ static void create_cpu_model_list(ObjectClass *klass, void *opaque)
     *cpu_list = entry;
 }
 
-CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+CpuDefinitionInfoList *qmp_query_cpu_definitions(bool has_machine,
+                                                 const char *machine,
+                                                 Error **errp)
 {
     struct CpuDefinitionInfoListData list_data = {
         .list = NULL,
diff --git a/target/ppc/translate_init.c.inc b/target/ppc/translate_init.c.inc
index bb66526280..0d31da0c7f 100644
--- a/target/ppc/translate_init.c.inc
+++ b/target/ppc/translate_init.c.inc
@@ -10635,7 +10635,9 @@ static void ppc_cpu_defs_entry(gpointer data, gpointer user_data)
     *first = entry;
 }
 
-CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+CpuDefinitionInfoList *qmp_query_cpu_definitions(bool has_machine,
+                                                 const char *machine,
+                                                 Error **errp)
 {
     CpuDefinitionInfoList *cpu_list = NULL;
     GSList *list;
diff --git a/tests/acceptance/x86_cpu_model_versions.py b/tests/acceptance/x86_cpu_model_versions.py
index 01ff614ec2..7fb17d00ba 100644
--- a/tests/acceptance/x86_cpu_model_versions.py
+++ b/tests/acceptance/x86_cpu_model_versions.py
@@ -238,6 +238,54 @@ class X86CPUModelAliases(avocado_qemu.Test):
 
         self.validate_aliases(cpus)
 
+    def test_machine_arg_none(self):
+        """Check results using explicit machine=none argument"""
+        vm1 = self.get_vm()
+        vm1.add_args('-S')
+        vm1.set_machine('pc-i440fx-4.0')
+        vm1.launch()
+        cpus1 = dict((m['name'], m.get('alias-of'))
+                     for m in vm1.command('query-cpu-definitions',
+                                          machine='none'))
+        vm1.shutdown()
+
+        vm2 = self.get_vm()
+        vm2.add_args('-S')
+        vm2.set_machine('none')
+        vm2.launch()
+        cpus2 = dict((m['name'], m.get('alias-of'))
+                     for m in vm2.command('query-cpu-definitions'))
+        vm1.shutdown()
+
+        self.assertEquals(cpus1, cpus2)
+
+    def test_machine_arg_4_1(self):
+        """Check results using explicit machine=pc-i440fx-4.1 argument"""
+        vm1 = self.get_vm()
+        vm1.add_args('-S')
+        vm1.set_machine('pc-i440fx-4.0')
+        vm1.launch()
+        cpus1 = dict((m['name'], m.get('alias-of'))
+                     for m in vm1.command('query-cpu-definitions',
+                                          machine='pc-i440fx-4.1'))
+        vm1.shutdown()
+
+        vm2 = self.get_vm()
+        vm2.add_args('-S')
+        vm2.set_machine('pc-i440fx-4.1')
+        vm2.launch()
+        cpus2 = dict((m['name'], m.get('alias-of'))
+                     for m in vm2.command('query-cpu-definitions'))
+        vm1.shutdown()
+
+        self.assertEquals(cpus1, cpus2)
+
+    def test_invalid_machine(self):
+        self.vm.add_args('-S')
+        self.vm.launch()
+        r = self.vm.qmp('query-cpu-definitions', machine='invalid-machine-123')
+        self.assertIn('error', r)
+
 
 class CascadelakeArchCapabilities(avocado_qemu.Test):
     """
-- 
2.28.0


