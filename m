Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1EBC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 12:14:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6404920734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 12:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vc6+AD0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6404920734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jizcR-0005lK-Kl
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 08:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jizL4-0004oG-Gv
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 07:56:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24030
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jizL2-0002Fu-VP
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 07:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591790172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OMm4of9YaGzegN5bSIFM+q+axawQAsBn39Dg4QO3Ssc=;
 b=Vc6+AD0AMdlrA2DwSOk6vaiZ0+BJ6swksuGsbIOqkd6I740uCsYXTe0H7sDHnrO+YSkvWN
 no/gsWZqJcHaAQn8aRi545YN4YcQZkCKnYjESCn63h+kR3c3eLW2zdicsA/4ZG67kuGqsG
 NhGY5FhwoaXtVPLzsZjXPBEbAeie1cU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-iZtHDbZuMtaMTb9TjcRE4w-1; Wed, 10 Jun 2020 07:56:10 -0400
X-MC-Unique: iZtHDbZuMtaMTb9TjcRE4w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 607EF1B18BC2;
 Wed, 10 Jun 2020 11:56:08 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-42.ams2.redhat.com [10.36.114.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 188245D9D3;
 Wed, 10 Jun 2020 11:55:59 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 21/21] numa: Auto-enable NUMA when any memory devices are
 possible
Date: Wed, 10 Jun 2020 13:54:19 +0200
Message-Id: <20200610115419.51688-22-david@redhat.com>
In-Reply-To: <20200610115419.51688-1-david@redhat.com>
References: <20200610115419.51688-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Received-SPF: pass client-ip=207.211.31.120; envelope-from=david@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 21:17:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Sergio Lopez <slp@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-s390x@nongnu.org,
 "qemu-arm @ nongnu . org" <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex Shi <alex.shi@linux.alibaba.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's auto-enable it also when maxmem is specified but no slots are
defined. This will result in us properly creating ACPI srat tables,
indicating the maximum possible PFN to the guest OS. Based on this, e.g.,
Linux will enable the swiotlb properly.

This avoids having to manually force the switolb on (swiotlb=force) in
Linux in case we're booting only using DMA memory (e.g., 2GB on x86-64),
and virtio-mem adds memory later on that really needs the swiotlb to be
used for DMA.

Let's take care of backwards compatibility if somebody has a setup that
specifies "maxram" without "slots".

Reported-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Sergio Lopez <slp@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-arm@nongnu.org <qemu-arm@nongnu.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/arm/virt.c       |  2 ++
 hw/core/numa.c      | 11 ++++++-----
 hw/i386/microvm.c   |  1 +
 hw/i386/pc.c        |  1 +
 hw/i386/pc_piix.c   |  1 +
 hw/i386/pc_q35.c    |  1 +
 include/hw/boards.h |  1 +
 7 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 37462a6f78..d50ad6f841 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2265,6 +2265,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->numa_mem_supported = true;
     mc->nvdimm_supported = true;
     mc->auto_enable_numa_with_memhp = true;
+    mc->auto_enable_numa_with_memdev = true;
     mc->default_ram_id = "mach-virt.ram";
 
     object_class_property_add(oc, "acpi", "OnOffAuto",
@@ -2375,6 +2376,7 @@ DEFINE_VIRT_MACHINE_AS_LATEST(5, 1)
 static void virt_machine_5_0_options(MachineClass *mc)
 {
     virt_machine_5_1_options(mc);
+    mc->auto_enable_numa_with_memdev = false;
 }
 DEFINE_VIRT_MACHINE(5, 0)
 
diff --git a/hw/core/numa.c b/hw/core/numa.c
index 06960918e7..b9923cdd45 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -681,8 +681,9 @@ void numa_complete_configuration(MachineState *ms)
     NodeInfo *numa_info = ms->numa_state->nodes;
 
     /*
-     * If memory hotplug is enabled (slots > 0) but without '-numa'
-     * options explicitly on CLI, guestes will break.
+     * If memory hotplug is enabled (slot > 0) or memory devices are enabled
+     * (ms->maxram_size > ram_size) but without '-numa' options explicitly on
+     * CLI, guests will break.
      *
      *   Windows: won't enable memory hotplug without SRAT table at all
      *
@@ -697,9 +698,9 @@ void numa_complete_configuration(MachineState *ms)
      * assume there is just one node with whole RAM.
      */
     if (ms->numa_state->num_nodes == 0 &&
-        ((ms->ram_slots > 0 &&
-        mc->auto_enable_numa_with_memhp) ||
-        mc->auto_enable_numa)) {
+        ((ms->ram_slots && mc->auto_enable_numa_with_memhp) ||
+         (ms->maxram_size > ms->ram_size && mc->auto_enable_numa_with_memdev) ||
+         mc->auto_enable_numa)) {
             NumaNodeOptions node = { };
             parse_numa_node(ms, &node, &error_abort);
             numa_info[0].node_mem = ram_size;
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 937db10ae6..2c052ee2e5 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -497,6 +497,7 @@ static void microvm_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 288;
     mc->has_hotpluggable_cpus = false;
     mc->auto_enable_numa_with_memhp = false;
+    mc->auto_enable_numa_with_memdev = false;
     mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
     mc->nvdimm_supported = false;
     mc->default_ram_id = "microvm.ram";
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index ee6368915b..ec93870de5 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1955,6 +1955,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->get_default_cpu_node_id = x86_get_default_cpu_node_id;
     mc->possible_cpu_arch_ids = x86_possible_cpu_arch_ids;
     mc->auto_enable_numa_with_memhp = true;
+    mc->auto_enable_numa_with_memdev = true;
     mc->has_hotpluggable_cpus = true;
     mc->default_boot_order = "cad";
     mc->hot_add_cpu = pc_hot_add_cpu;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index f66e1d73ce..1bc68c3841 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -440,6 +440,7 @@ static void pc_i440fx_5_0_machine_options(MachineClass *m)
     m->is_default = false;
     compat_props_add(m->compat_props, hw_compat_5_0, hw_compat_5_0_len);
     compat_props_add(m->compat_props, pc_compat_5_0, pc_compat_5_0_len);
+    m->auto_enable_numa_with_memdev = false;
 }
 
 DEFINE_I440FX_MACHINE(v5_0, "pc-i440fx-5.0", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 4ba8ac8774..a17459e37c 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -368,6 +368,7 @@ static void pc_q35_5_0_machine_options(MachineClass *m)
     m->alias = NULL;
     compat_props_add(m->compat_props, hw_compat_5_0, hw_compat_5_0_len);
     compat_props_add(m->compat_props, pc_compat_5_0, pc_compat_5_0_len);
+    m->auto_enable_numa_with_memhp = false;
 }
 
 DEFINE_Q35_MACHINE(v5_0, "pc-q35-5.0", NULL,
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 18815d9be2..426ce5f625 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -207,6 +207,7 @@ struct MachineClass {
     const char **valid_cpu_types;
     strList *allowed_dynamic_sysbus_devices;
     bool auto_enable_numa_with_memhp;
+    bool auto_enable_numa_with_memdev;
     void (*numa_auto_assign_ram)(MachineClass *mc, NodeInfo *nodes,
                                  int nb_nodes, ram_addr_t size);
     bool ignore_boot_device_suffixes;
-- 
2.26.2


