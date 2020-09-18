Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B964CC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3617A2078B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fAllN1N9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3617A2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJJWl-0003qn-Aw
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 12:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJJ8A-0005Py-Aq
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 12:21:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58097)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJJ82-0005mH-6z
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 12:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600446043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p+UkMbHw7A0wZD6E1HsNyZ5qPFAY5u5AZjBJxMTg5x8=;
 b=fAllN1N9+M+YLaHtQbfN+xZJstaD4G46ag9mJ62mP5KScu+HO5JtoDark5wyRTRfzV8pJz
 NdZIJ3n1DmydxFhdK9oOeVZZgeksFwGqC14PSibGWosgbWKX4hJ3yjtaUKt6PK6J82R1Y8
 lQP3XWhzsA876l5o0XAMBMUlOhsCGEw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-F7ekoTnPMJqLbeg8Y8-Y2Q-1; Fri, 18 Sep 2020 12:20:39 -0400
X-MC-Unique: F7ekoTnPMJqLbeg8Y8-Y2Q-1
Received: by mail-wr1-f70.google.com with SMTP id n15so2301518wrv.23
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 09:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=p+UkMbHw7A0wZD6E1HsNyZ5qPFAY5u5AZjBJxMTg5x8=;
 b=T7A7hEuLjc1jtmn2ATJ9Sw4MLVquzUz+7TJzCIiqssuPtwXqo0j8FdjO1Gr+qBhqwx
 PgNO2kMQ19ZrhsbunVyaZi5QoBvZHgC2j3/2pUvRi10xR8uwgEutzKN2KDacLYoyNWwK
 oLi33Io3iL4EKVgeMWe1C3j6Y1D/RMX2ubVpVrBymk5KKiZxoW1YZlRfNNc7V6tKEAnR
 AchD1U8/yXhcfv54rGAR/lshhu3IAzKtRMobs0yJ+StHlIT9TBrEgfQlCYN65UapXTYa
 SyiAWq4H4DGm1h9GaZ9DS1o+19WfBEWA0CTX2DGD+HeSdWbq7eTj9X1vvlb9xPg7YTp+
 8+lA==
X-Gm-Message-State: AOAM532k+cd/+ldEA1KkKyBVjrm/RzvKuamqHGSo2AQIP5EZJ0K0dbf/
 m72yG0bfs+LN4tu1fTv0Z6BWWC9Oid8q1iqzbXy8Vq/eB7OQM5fJVf8L6jjxSH4kfrwXK8J/525
 4V8VKqWabpv1TYkA=
X-Received: by 2002:a1c:6484:: with SMTP id
 y126mr16404494wmb.177.1600446037303; 
 Fri, 18 Sep 2020 09:20:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6vETPVqcMnNGa9gRcSWO05TxdeOCu2ZUe6kkuubA9pt3ZZFFFH5VFfUsGlw4pl3Mljkd5bQ==
X-Received: by 2002:a1c:6484:: with SMTP id
 y126mr16404461wmb.177.1600446036979; 
 Fri, 18 Sep 2020 09:20:36 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net.
 [109.65.116.225])
 by smtp.gmail.com with ESMTPSA id w15sm5762185wro.46.2020.09.18.09.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 09:20:36 -0700 (PDT)
Date: Fri, 18 Sep 2020 12:20:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 13/15] cphp: remove deprecated cpu-add command(s)
Message-ID: <20200918161836.318893-14-mst@redhat.com>
References: <20200918161836.318893-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200918161836.318893-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 01:32:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 libvir-list@redhat.com, Michal Privoznik <mprivozn@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 qapi/machine.json           |  24 ---------
 include/hw/boards.h         |   1 -
 include/hw/i386/pc.h        |   1 -
 include/monitor/hmp.h       |   1 -
 hw/core/machine-hmp-cmds.c  |  12 -----
 hw/core/machine-qmp-cmds.c  |  12 -----
 hw/i386/pc.c                |  27 ----------
 hw/i386/pc_piix.c           |   1 -
 hw/s390x/s390-virtio-ccw.c  |  12 -----
 tests/qtest/cpu-plug-test.c | 100 ++++--------------------------------
 tests/qtest/test-hmp.c      |   1 -
 docs/system/deprecated.rst  |  25 +++++----
 hmp-commands.hx             |  15 ------
 13 files changed, 21 insertions(+), 211 deletions(-)

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
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 795910d01b..7abd5d889c 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -169,7 +169,6 @@ struct MachineClass {
     void (*init)(MachineState *state);
     void (*reset)(MachineState *state);
     void (*wakeup)(MachineState *state);
-    void (*hot_add_cpu)(MachineState *state, const int64_t id, Error **errp);
     int (*kvm_type)(MachineState *machine, const char *arg);
     void (*smp_parse)(MachineState *ms, QemuOpts *opts);
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index c14e14dfe0..be42fe3599 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -134,7 +134,6 @@ extern int fd_bootchk;
 
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
index b55369357e..5e1911fba0 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -777,32 +777,6 @@ void pc_smp_parse(MachineState *ms, QemuOpts *opts)
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
@@ -1699,7 +1673,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->auto_enable_numa_with_memdev = true;
     mc->has_hotpluggable_cpus = true;
     mc->default_boot_order = "cad";
-    mc->hot_add_cpu = pc_hot_add_cpu;
     mc->smp_parse = pc_smp_parse;
     mc->block_default_type = IF_IDE;
     mc->max_cpus = 255;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 6f3e78bb60..2d8413a0ce 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -752,7 +752,6 @@ static void pc_i440fx_1_4_machine_options(MachineClass *m)
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
 
-        data2->machine = g_strdup(data->machine);
-        data2->device_model = g_strdup(data->device_model);
-
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
diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 0cb8b01424..cc31d79177 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -284,13 +284,6 @@ The ``query-cpus`` command is replaced by the ``query-cpus-fast`` command.
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
 
@@ -306,12 +299,6 @@ the 'wait' field, which is only applicable to sockets in server mode
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
 
@@ -529,6 +516,12 @@ QEMU Machine Protocol (QMP) commands
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
 
@@ -538,6 +531,12 @@ The ``hub_id`` parameter of ``hostfwd_add`` / ``hostfwd_remove`` (removed in 5.0
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
index 60f395c276..d1e3e0e1c6 100644
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
-- 
MST


