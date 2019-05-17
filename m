Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C55C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 07:47:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ADDA20578
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 07:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ADDA20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43873 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRXa5-0004Tx-Ko
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 03:47:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hRXY1-0002wR-E7
	for qemu-devel@nongnu.org; Fri, 17 May 2019 03:44:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hRXY0-0002O4-7D
	for qemu-devel@nongnu.org; Fri, 17 May 2019 03:44:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hRXXz-0002Nt-V2
	for qemu-devel@nongnu.org; Fri, 17 May 2019 03:44:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4DD4BC058CA4
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 07:44:55 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 04AC35D707;
	Fri, 17 May 2019 07:44:53 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 09:45:17 +0200
Message-Id: <1558079119-320634-5-git-send-email-imammedo@redhat.com>
In-Reply-To: <1558079119-320634-1-git-send-email-imammedo@redhat.com>
References: <1558079119-320634-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Fri, 17 May 2019 07:44:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 4/6] numa: introduce "numa-mem-supported"
 machine property
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: libvir-list@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
	ehabkost@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'-numa mem' option has a number of issues and mgmt often defaults
to it. Unfortunately it's no possible to replace it with an alternative
'-numa memdev' without breaking migration compatibility. What's possible
though is to deprecate it, keeping option working with old machine types.
Once deprecation period expires, QEMU will disable '-numa mem' option,
usage on new machine types and when the last machine type that supported
it is removed we would be able to remove '-numa mem' with associated code.

In order to help mgmt to find out if being deprecated CLI option
'-numa mem=SZ' is still supported by particular machine type, expose
this information via "numa-mem-supported" machine property.

Users can use "qom-list-properties" QMP command to list machine type
properties including initial proprety values (when probing for supported
machine types with '-machine none') or at runtime at preconfig time
before numa mapping is configured and decide if they should used legacy
'-numa mem' or alternative '-numa memdev' option.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/boards.h |  1 +
 hw/arm/virt.c       |  1 +
 hw/core/machine.c   | 12 ++++++++++++
 hw/i386/pc.c        |  1 +
 hw/ppc/spapr.c      |  1 +
 5 files changed, 16 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 6f7916f..9e347cf 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -210,6 +210,7 @@ struct MachineClass {
     bool ignore_boot_device_suffixes;
     bool smbus_no_migration_support;
     bool nvdimm_supported;
+    bool numa_mem_supported;
 
     HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
                                            DeviceState *dev);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 5331ab7..2e86c78 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1943,6 +1943,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
     hc->plug = virt_machine_device_plug_cb;
+    mc->numa_mem_supported = true;
 }
 
 static void virt_instance_init(Object *obj)
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 5d046a4..8bc53ba 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -506,6 +506,13 @@ static char *machine_get_nvdimm_persistence(Object *obj, Error **errp)
     return g_strdup(ms->nvdimms_state->persistence_string);
 }
 
+static bool machine_get_numa_mem_supported(Object *obj, Error **errp)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(obj);
+
+    return mc->numa_mem_supported;
+}
+
 static void machine_set_nvdimm_persistence(Object *obj, const char *value,
                                            Error **errp)
 {
@@ -810,6 +817,11 @@ static void machine_class_init(ObjectClass *oc, void *data)
         &error_abort);
     object_class_property_set_description(oc, "memory-encryption",
         "Set memory encryption object to use", &error_abort);
+
+    object_class_property_add_bool(oc, "numa-mem-supported",
+        machine_get_numa_mem_supported, NULL, &error_abort);
+    object_class_property_set_description(oc, "numa-mem-supported",
+        "Shows if legacy '-numa mem=SIZE option is supported", &error_abort);
 }
 
 static void machine_class_base_init(ObjectClass *oc, void *data)
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index de91e90..bec0055 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2756,6 +2756,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     nc->nmi_monitor_handler = x86_nmi;
     mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
     mc->nvdimm_supported = true;
+    mc->numa_mem_supported = true;
 
     object_class_property_add(oc, PC_MACHINE_DEVMEM_REGION_SIZE, "int",
         pc_machine_get_device_memory_region_size, NULL,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2ef3ce4..265ecfb 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4336,6 +4336,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
      * in which LMBs are represented and hot-added
      */
     mc->numa_mem_align_shift = 28;
+    mc->numa_mem_supported = true;
 
     smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
     smc->default_caps.caps[SPAPR_CAP_VSX] = SPAPR_CAP_ON;
-- 
2.7.4


