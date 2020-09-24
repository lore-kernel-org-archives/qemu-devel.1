Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1816C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:13:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44ABF23977
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GF+GBajc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44ABF23977
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLOGC-0007dH-Uv
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 06:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNU4-0001nl-I5
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:24:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36603)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNU0-00068t-M9
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2xMrxnw2MmITokncdkTVBq26a0kV/kE9V0PiO6g3qsg=;
 b=GF+GBajc/UGaDnoaSJbFhHRk0ZgLQrSyhe0gL5pEtQWK03qzmJW8heuXvjpCqUu02vApR7
 tFrzqe7rqDhmtimfTfdZHxuX6KKwluD5ND7OwEh7Qf5nmfXxZaULPUD284WcS1Ca+BaCBe
 3cwzbOcCwN53mr2PLPELuTCJnuCQk4M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-L7KtDjmCPsCSSryASRv9Pw-1; Thu, 24 Sep 2020 05:24:05 -0400
X-MC-Unique: L7KtDjmCPsCSSryASRv9Pw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B77841007474
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:24:04 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3BBBE6115F;
 Thu, 24 Sep 2020 09:24:04 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 64/92] cphp: remove deprecated cpu-add command(s)
Date: Thu, 24 Sep 2020 05:22:46 -0400
Message-Id: <20200924092314.1722645-65-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Michal Privoznik <mprivozn@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

These were deprecated since 4.0, remove both HMP and QMP variants.

Users should use device_add command instead. To get list of
possible CPUs and options, use 'info hotpluggable-cpus' HMP
or query-hotpluggable-cpus QMP command.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200915120403.1074579-1-imammedo@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/system/deprecated.rst  |  25 +++++----
 hmp-commands.hx             |  15 ------
 hw/core/machine-hmp-cmds.c  |  12 -----
 hw/core/machine-qmp-cmds.c  |  12 -----
 hw/i386/pc.c                |  27 ----------
 hw/i386/pc_piix.c           |   1 -
 hw/s390x/s390-virtio-ccw.c  |  12 -----
 include/hw/boards.h         |   1 -
 include/hw/i386/pc.h        |   1 -
 include/monitor/hmp.h       |   1 -
 qapi/machine.json           |  24 ---------
 tests/qtest/cpu-plug-test.c | 100 ++++--------------------------------
 tests/qtest/test-hmp.c      |   1 -
 13 files changed, 21 insertions(+), 211 deletions(-)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 17703d18fd..2bede67b04 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -251,13 +251,6 @@ The ``query-cpus`` command is replaced by the ``query-cpus-fast`` command.
 The ``arch`` output member of the ``query-cpus-fast`` command is
 replaced by the ``target`` output member.
 
-``cpu-add`` (since 4.0)
-'''''''''''''''''''''''
-
-Use ``device_add`` for hotplugging vCPUs instead of ``cpu-add``.  See
-documentation of ``query-hotpluggable-cpus`` for additional
-details.
-
 ``query-events`` (since 4.0)
 ''''''''''''''''''''''''''''
 
@@ -273,12 +266,6 @@ the 'wait' field, which is only applicable to sockets in server mode
 Human Monitor Protocol (HMP) commands
 -------------------------------------
 
-``cpu-add`` (since 4.0)
-'''''''''''''''''''''''
-
-Use ``device_add`` for hotplugging vCPUs instead of ``cpu-add``.  See
-documentation of ``query-hotpluggable-cpus`` for additional details.
-
 ``acl_show``, ``acl_reset``, ``acl_policy``, ``acl_add``, ``acl_remove`` (since 4.0.0)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
@@ -496,6 +483,12 @@ QEMU Machine Protocol (QMP) commands
 The "autoload" parameter has been ignored since 2.12.0. All bitmaps
 are automatically loaded from qcow2 images.
 
+``cpu-add`` (removed in 5.2)
+''''''''''''''''''''''''''''
+
+Use ``device_add`` for hotplugging vCPUs instead of ``cpu-add``.  See
+documentation of ``query-hotpluggable-cpus`` for additional details.
+
 Human Monitor Protocol (HMP) commands
 -------------------------------------
 
@@ -505,6 +498,12 @@ The ``hub_id`` parameter of ``hostfwd_add`` / ``hostfwd_remove`` (removed in 5.0
 The ``[hub_id name]`` parameter tuple of the 'hostfwd_add' and
 'hostfwd_remove' HMP commands has been replaced by ``netdev_id``.
 
+``cpu-add`` (removed in 5.2)
+''''''''''''''''''''''''''''
+
+Use ``device_add`` for hotplugging vCPUs instead of ``cpu-add``.  See
+documentation of ``query-hotpluggable-cpus`` for additional details.
+
 Guest Emulator ISAs
 -------------------
 
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 27c4bbe0f2..1088d64503 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1761,21 +1761,6 @@ SRST
   Executes a qemu-io command on the given block device.
 ERST
 
-    {
-        .name       = "cpu-add",
-        .args_type  = "id:i",
-        .params     = "id",
-        .help       = "add cpu (deprecated, use device_add instead)",
-        .cmd        = hmp_cpu_add,
-    },
-
-SRST
-``cpu-add`` *id*
-  Add CPU with id *id*.  This command is deprecated, please
-  +use ``device_add`` instead. For details, refer to
-  'docs/cpu-hotplug.rst'.
-ERST
-
     {
         .name       = "qom-list",
         .args_type  = "path:s?",
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index 39999c47c5..f4092b98cc 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -46,18 +46,6 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict)
     qapi_free_CpuInfoFastList(cpu_list);
 }
 
-void hmp_cpu_add(Monitor *mon, const QDict *qdict)
-{
-    int cpuid;
-    Error *err = NULL;
-
-    error_report("cpu_add is deprecated, please use device_add instead");
-
-    cpuid = qdict_get_int(qdict, "id");
-    qmp_cpu_add(cpuid, &err);
-    hmp_handle_error(mon, err);
-}
-
 void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 21551221ad..5362c80a18 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -284,18 +284,6 @@ HotpluggableCPUList *qmp_query_hotpluggable_cpus(Error **errp)
     return machine_query_hotpluggable_cpus(ms);
 }
 
-void qmp_cpu_add(int64_t id, Error **errp)
-{
-    MachineClass *mc;
-
-    mc = MACHINE_GET_CLASS(current_machine);
-    if (mc->hot_add_cpu) {
-        mc->hot_add_cpu(current_machine, id, errp);
-    } else {
-        error_setg(errp, "Not supported");
-    }
-}
-
 void qmp_set_numa_node(NumaOptions *cmd, Error **errp)
 {
     if (!runstate_check(RUN_STATE_PRECONFIG)) {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 1e2ab5ebe7..50e8317342 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -769,32 +769,6 @@ void pc_smp_parse(MachineState *ms, QemuOpts *opts)
     }
 }
 
-void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp)
-{
-    X86MachineState *x86ms = X86_MACHINE(ms);
-    int64_t apic_id = x86_cpu_apic_id_from_index(x86ms, id);
-    Error *local_err = NULL;
-
-    if (id < 0) {
-        error_setg(errp, "Invalid CPU id: %" PRIi64, id);
-        return;
-    }
-
-    if (apic_id >= ACPI_CPU_HOTPLUG_ID_LIMIT) {
-        error_setg(errp, "Unable to add CPU: %" PRIi64
-                   ", resulting APIC ID (%" PRIi64 ") is too large",
-                   id, apic_id);
-        return;
-    }
-
-
-    x86_cpu_new(X86_MACHINE(ms), apic_id, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-}
-
 static
 void pc_machine_done(Notifier *notifier, void *data)
 {
@@ -1691,7 +1665,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->auto_enable_numa_with_memdev = true;
     mc->has_hotpluggable_cpus = true;
     mc->default_boot_order = "cad";
-    mc->hot_add_cpu = pc_hot_add_cpu;
     mc->smp_parse = pc_smp_parse;
     mc->block_default_type = IF_IDE;
     mc->max_cpus = 255;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c6057905fa..32c5d95762 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -751,7 +751,6 @@ static void pc_i440fx_1_4_machine_options(MachineClass *m)
 {
     pc_i440fx_1_5_machine_options(m);
     m->hw_version = "1.4.0";
-    m->hot_add_cpu = NULL;
     compat_props_add(m->compat_props, pc_compat_1_4, pc_compat_1_4_len);
 }
 
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 3106bbea33..28266a3a35 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -553,17 +553,6 @@ static HotplugHandler *s390_get_hotplug_handler(MachineState *machine,
     return NULL;
 }
 
-static void s390_hot_add_cpu(MachineState *machine,
-                             const int64_t id, Error **errp)
-{
-    ObjectClass *oc;
-
-    g_assert(machine->possible_cpus->cpus[0].cpu);
-    oc = OBJECT_CLASS(CPU_GET_CLASS(machine->possible_cpus->cpus[0].cpu));
-
-    s390x_new_cpu(object_class_get_name(oc), id, errp);
-}
-
 static void s390_nmi(NMIState *n, int cpu_index, Error **errp)
 {
     CPUState *cs = qemu_get_cpu(cpu_index);
@@ -604,7 +593,6 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     s390mc->hpage_1m_allowed = true;
     mc->init = ccw_init;
     mc->reset = s390_machine_reset;
-    mc->hot_add_cpu = s390_hot_add_cpu;
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
     mc->no_floppy = 1;
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 777621fb30..bf53e8a16e 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -168,7 +168,6 @@ struct MachineClass {
     void (*init)(MachineState *state);
     void (*reset)(MachineState *state);
     void (*wakeup)(MachineState *state);
-    void (*hot_add_cpu)(MachineState *state, const int64_t id, Error **errp);
     int (*kvm_type)(MachineState *machine, const char *arg);
     void (*smp_parse)(MachineState *ms, QemuOpts *opts);
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index b2da2c8d2b..c71b02cafd 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -132,7 +132,6 @@ extern int fd_bootchk;
 
 void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
 
-void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp);
 void pc_smp_parse(MachineState *ms, QemuOpts *opts);
 
 void pc_guest_info_init(PCMachineState *pcms);
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index c986cfd28b..642e9e91f9 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -89,7 +89,6 @@ void hmp_chardev_add(Monitor *mon, const QDict *qdict);
 void hmp_chardev_change(Monitor *mon, const QDict *qdict);
 void hmp_chardev_remove(Monitor *mon, const QDict *qdict);
 void hmp_chardev_send_break(Monitor *mon, const QDict *qdict);
-void hmp_cpu_add(Monitor *mon, const QDict *qdict);
 void hmp_object_add(Monitor *mon, const QDict *qdict);
 void hmp_object_del(Monitor *mon, const QDict *qdict);
 void hmp_info_memdev(Monitor *mon, const QDict *qdict);
diff --git a/qapi/machine.json b/qapi/machine.json
index 0ac1880e4a..d8ed096e9a 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -307,30 +307,6 @@
 ##
 { 'command': 'query-cpus-fast', 'returns': [ 'CpuInfoFast' ] }
 
-##
-# @cpu-add:
-#
-# Adds CPU with specified ID.
-#
-# @id: ID of CPU to be created, valid values [0..max_cpus)
-#
-# Features:
-# @deprecated: This command is deprecated.  Use `device_add` instead.
-#              See the `query-hotpluggable-cpus` command for details.
-#
-# Returns: Nothing on success
-#
-# Since: 1.5
-#
-# Example:
-#
-# -> { "execute": "cpu-add", "arguments": { "id": 2 } }
-# <- { "return": {} }
-#
-##
-{ 'command': 'cpu-add', 'data': {'id': 'int'},
-  'features': [ 'deprecated' ] }
-
 ##
 # @MachineInfo:
 #
diff --git a/tests/qtest/cpu-plug-test.c b/tests/qtest/cpu-plug-test.c
index e8ffbbce4b..a1c689414b 100644
--- a/tests/qtest/cpu-plug-test.c
+++ b/tests/qtest/cpu-plug-test.c
@@ -25,54 +25,6 @@ struct PlugTestData {
 };
 typedef struct PlugTestData PlugTestData;
 
-static void test_plug_with_cpu_add(gconstpointer data)
-{
-    const PlugTestData *s = data;
-    char *args;
-    QDict *response;
-    unsigned int i;
-
-    args = g_strdup_printf("-machine %s -cpu %s "
-                           "-smp 1,sockets=%u,cores=%u,threads=%u,maxcpus=%u",
-                           s->machine, s->cpu_model,
-                           s->sockets, s->cores, s->threads, s->maxcpus);
-    qtest_start(args);
-
-    for (i = 1; i < s->maxcpus; i++) {
-        response = qmp("{ 'execute': 'cpu-add',"
-                       "  'arguments': { 'id': %d } }", i);
-        g_assert(response);
-        g_assert(!qdict_haskey(response, "error"));
-        qobject_unref(response);
-    }
-
-    qtest_end();
-    g_free(args);
-}
-
-static void test_plug_without_cpu_add(gconstpointer data)
-{
-    const PlugTestData *s = data;
-    char *args;
-    QDict *response;
-
-    args = g_strdup_printf("-machine %s -cpu %s "
-                           "-smp 1,sockets=%u,cores=%u,threads=%u,maxcpus=%u",
-                           s->machine, s->cpu_model,
-                           s->sockets, s->cores, s->threads, s->maxcpus);
-    qtest_start(args);
-
-    response = qmp("{ 'execute': 'cpu-add',"
-                   "  'arguments': { 'id': %d } }",
-                   s->sockets * s->cores * s->threads);
-    g_assert(response);
-    g_assert(qdict_haskey(response, "error"));
-    qobject_unref(response);
-
-    qtest_end();
-    g_free(args);
-}
-
 static void test_plug_with_device_add(gconstpointer data)
 {
     const PlugTestData *td = data;
@@ -144,36 +96,13 @@ static void add_pc_test_case(const char *mname)
     data->cores = 3;
     data->threads = 2;
     data->maxcpus = data->sockets * data->cores * data->threads;
-    if (g_str_has_suffix(mname, "-1.4") ||
-        (strcmp(mname, "pc-1.3") == 0) ||
-        (strcmp(mname, "pc-1.2") == 0) ||
-        (strcmp(mname, "pc-1.1") == 0) ||
-        (strcmp(mname, "pc-1.0") == 0)) {
-        path = g_strdup_printf("cpu-plug/%s/init/%ux%ux%u&maxcpus=%u",
-                               mname, data->sockets, data->cores,
-                               data->threads, data->maxcpus);
-        qtest_add_data_func_full(path, data, test_plug_without_cpu_add,
-                                 test_data_free);
-        g_free(path);
-    } else {
-        PlugTestData *data2 = g_memdup(data, sizeof(PlugTestData));
-
-        data2->machine = g_strdup(data->machine);
-        data2->device_model = g_strdup(data->device_model);
 
-        path = g_strdup_printf("cpu-plug/%s/cpu-add/%ux%ux%u&maxcpus=%u",
-                               mname, data->sockets, data->cores,
-                               data->threads, data->maxcpus);
-        qtest_add_data_func_full(path, data, test_plug_with_cpu_add,
-                                 test_data_free);
-        g_free(path);
-        path = g_strdup_printf("cpu-plug/%s/device-add/%ux%ux%u&maxcpus=%u",
-                               mname, data2->sockets, data2->cores,
-                               data2->threads, data2->maxcpus);
-        qtest_add_data_func_full(path, data2, test_plug_with_device_add,
-                                 test_data_free);
-        g_free(path);
-    }
+    path = g_strdup_printf("cpu-plug/%s/device-add/%ux%ux%u&maxcpus=%u",
+                           mname, data->sockets, data->cores,
+                           data->threads, data->maxcpus);
+    qtest_add_data_func_full(path, data, test_plug_with_device_add,
+                             test_data_free);
+    g_free(path);
 }
 
 static void add_pseries_test_case(const char *mname)
@@ -205,7 +134,7 @@ static void add_pseries_test_case(const char *mname)
 static void add_s390x_test_case(const char *mname)
 {
     char *path;
-    PlugTestData *data, *data2;
+    PlugTestData *data;
 
     if (!g_str_has_prefix(mname, "s390-ccw-virtio-")) {
         return;
@@ -220,21 +149,10 @@ static void add_s390x_test_case(const char *mname)
     data->threads = 1;
     data->maxcpus = data->sockets * data->cores * data->threads;
 
-    data2 = g_memdup(data, sizeof(PlugTestData));
-    data2->machine = g_strdup(data->machine);
-    data2->device_model = g_strdup(data->device_model);
-
-    path = g_strdup_printf("cpu-plug/%s/cpu-add/%ux%ux%u&maxcpus=%u",
+    path = g_strdup_printf("cpu-plug/%s/device-add/%ux%ux%u&maxcpus=%u",
                            mname, data->sockets, data->cores,
                            data->threads, data->maxcpus);
-    qtest_add_data_func_full(path, data, test_plug_with_cpu_add,
-                             test_data_free);
-    g_free(path);
-
-    path = g_strdup_printf("cpu-plug/%s/device-add/%ux%ux%u&maxcpus=%u",
-                           mname, data2->sockets, data2->cores,
-                           data2->threads, data2->maxcpus);
-    qtest_add_data_func_full(path, data2, test_plug_with_device_add,
+    qtest_add_data_func_full(path, data, test_plug_with_device_add,
                              test_data_free);
     g_free(path);
 }
diff --git a/tests/qtest/test-hmp.c b/tests/qtest/test-hmp.c
index aea1384bac..94a8023173 100644
--- a/tests/qtest/test-hmp.c
+++ b/tests/qtest/test-hmp.c
@@ -27,7 +27,6 @@ static const char *hmp_cmds[] = {
     "chardev-change testchardev1 ringbuf",
     "chardev-remove testchardev1",
     "commit all",
-    "cpu-add 1",
     "cpu 0",
     "device_add ?",
     "device_add usb-mouse,id=mouse1",
-- 
2.26.2



