Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432AAC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:14:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF6E20870
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmE1Smjs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF6E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHlo-0002PX-87
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHcl-0000JD-Pw
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:04:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60459
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHcf-0004Ua-9E
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593767080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c5tdu84EsYu030A7xZkXJlQoGtXOTX2WueiDbJOGS4I=;
 b=SmE1SmjsnXvnPl57zYZ9nLcQ4wz92yua/XOnRmrIw9ldHgi5+HPXgholBBeHVCwP8X51lF
 1W2F+QghFiuaKsQjvgMIY0Kwlya/GbQW3gpXyWxB7g3g/M6oANllUOMBp0LYAbmMlywEN7
 Y8N2xaYw4GiPwgXcErzhk8BvFa//eBo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-n_kCMByxNQOWK_FmE4bvlg-1; Fri, 03 Jul 2020 05:04:38 -0400
X-MC-Unique: n_kCMByxNQOWK_FmE4bvlg-1
Received: by mail-wr1-f69.google.com with SMTP id 89so7685723wrr.15
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 02:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=c5tdu84EsYu030A7xZkXJlQoGtXOTX2WueiDbJOGS4I=;
 b=UiHPRMfHYyNi10XrjcTTDoW3pfbfJOArm7s06kS3lkmiyXcaYsN0MVM8le21WiAss8
 NzTtkN2YfVhsZ/FYm9mUE/BjUTdSLYcZrg0y2yuqekTuP/fcF2njzqb7k3AKWkcwovfn
 UGk2BUC3k953OgPasCPkJ4d97iRLO/yiqa85x9NFhuDJZy1uMV49ajYeclStPG5BV3oY
 nLmTk3G4cQgUshcG9ZRY6UNg86mvf6+VDpyKU3S1WtHhXWLqL1WZzmKX9x295VxgwwoR
 embESfO/3C1DNVdSH57unVDHoDVEzsdpgf4Sm99Quny4MnHEPoTRfPH4YfJYAqTvVcfO
 KlZw==
X-Gm-Message-State: AOAM532lY4mCcHaZVgY+s73O028nNRtQ0CSez4X08d+p3TToc6KhG3ws
 DX9AIBrqxDNob5pj4vHCDEam1RInDiYG0x+FZ23BEksVsiJTDSn79cKiXySKPMHpLtRihbZy73T
 9Zxk5BCYTgC2KLw4=
X-Received: by 2002:a1c:b182:: with SMTP id
 a124mr33866091wmf.114.1593767077142; 
 Fri, 03 Jul 2020 02:04:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVOY4TvhikLMVstjU3wXl+ftQ+Rs9F/kNmVJrga8v+b2EPC/UoLYQ6F5T/cQ+W7boy9mqzgg==
X-Received: by 2002:a1c:b182:: with SMTP id
 a124mr33866071wmf.114.1593767076894; 
 Fri, 03 Jul 2020 02:04:36 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 f12sm13711084wrw.53.2020.07.03.02.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 02:04:36 -0700 (PDT)
Date: Fri, 3 Jul 2020 05:04:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/41] numa: Auto-enable NUMA when any memory devices are
 possible
Message-ID: <20200703090252.368694-25-mst@redhat.com>
References: <20200703090252.368694-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200703090252.368694-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 01:34:15
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 "qemu-arm @ nongnu . org" <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex Shi <alex.shi@linux.alibaba.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

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
Message-Id: <20200626072248.78761-22-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/boards.h |  1 +
 hw/arm/virt.c       |  2 ++
 hw/core/numa.c      | 11 ++++++-----
 hw/i386/microvm.c   |  1 +
 hw/i386/pc.c        |  1 +
 hw/i386/pc_piix.c   |  1 +
 hw/i386/pc_q35.c    |  1 +
 7 files changed, 13 insertions(+), 5 deletions(-)

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
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index cd0834ce7f..f97be80a86 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2373,6 +2373,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     hc->unplug = virt_machine_device_unplug_cb;
     mc->nvdimm_supported = true;
     mc->auto_enable_numa_with_memhp = true;
+    mc->auto_enable_numa_with_memdev = true;
     mc->default_ram_id = "mach-virt.ram";
 
     object_class_property_add(oc, "acpi", "OnOffAuto",
@@ -2485,6 +2486,7 @@ static void virt_machine_5_0_options(MachineClass *mc)
     virt_machine_5_1_options(mc);
     compat_props_add(mc->compat_props, hw_compat_5_0, hw_compat_5_0_len);
     mc->numa_mem_supported = true;
+    mc->auto_enable_numa_with_memdev = false;
 }
 DEFINE_VIRT_MACHINE(5, 0)
 
diff --git a/hw/core/numa.c b/hw/core/numa.c
index e9aec69afd..6a20ce7cf1 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -688,8 +688,9 @@ void numa_complete_configuration(MachineState *ms)
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
@@ -704,9 +705,9 @@ void numa_complete_configuration(MachineState *ms)
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
index 5e931975a0..81d0888930 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -464,6 +464,7 @@ static void microvm_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 288;
     mc->has_hotpluggable_cpus = false;
     mc->auto_enable_numa_with_memhp = false;
+    mc->auto_enable_numa_with_memdev = false;
     mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
     mc->nvdimm_supported = false;
     mc->default_ram_id = "microvm.ram";
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 576f2502f9..61acc9e530 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1975,6 +1975,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->get_default_cpu_node_id = x86_get_default_cpu_node_id;
     mc->possible_cpu_arch_ids = x86_possible_cpu_arch_ids;
     mc->auto_enable_numa_with_memhp = true;
+    mc->auto_enable_numa_with_memdev = true;
     mc->has_hotpluggable_cpus = true;
     mc->default_boot_order = "cad";
     mc->hot_add_cpu = pc_hot_add_cpu;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 1d832b2878..fae487f57d 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -444,6 +444,7 @@ static void pc_i440fx_5_0_machine_options(MachineClass *m)
     m->numa_mem_supported = true;
     compat_props_add(m->compat_props, hw_compat_5_0, hw_compat_5_0_len);
     compat_props_add(m->compat_props, pc_compat_5_0, pc_compat_5_0_len);
+    m->auto_enable_numa_with_memdev = false;
 }
 
 DEFINE_I440FX_MACHINE(v5_0, "pc-i440fx-5.0", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 047ea8db28..acd6d405f0 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -372,6 +372,7 @@ static void pc_q35_5_0_machine_options(MachineClass *m)
     m->numa_mem_supported = true;
     compat_props_add(m->compat_props, hw_compat_5_0, hw_compat_5_0_len);
     compat_props_add(m->compat_props, pc_compat_5_0, pc_compat_5_0_len);
+    m->auto_enable_numa_with_memhp = false;
 }
 
 DEFINE_Q35_MACHINE(v5_0, "pc-q35-5.0", NULL,
-- 
MST


