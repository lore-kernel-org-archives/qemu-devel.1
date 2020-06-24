Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816C1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:12:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D3652082F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CBNYPCRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3652082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo3Ko-0007ya-KK
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 07:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo305-0001kZ-3g
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:51:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49643
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo2zx-0001QE-1u
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592995880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yVLcLUVjW4nr2a0cYXuoAT0tRZDeKlAWy5SGPo/drxg=;
 b=CBNYPCRKst2GrxZAXykk1KfUZQ4xrxzle8sAJ2iw4soDrpmsBga+Y8Elbi2MwK+e+F0Uvq
 GBBDObCFfZYGJQxFDrk7NLhWEtS/GiDk4e/amCzwIfqkVUnVODWXDCbR7SMSUQPeCOLOig
 ycdwdwlSA6Xr1DhTJLHf8ayzHEa85BY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-tCM-SX6dOpSl3RBwLb81Yw-1; Wed, 24 Jun 2020 06:51:18 -0400
X-MC-Unique: tCM-SX6dOpSl3RBwLb81Yw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A21218A8221;
 Wed, 24 Jun 2020 10:51:17 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com
 (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A167B61169;
 Wed, 24 Jun 2020 10:51:13 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 26/31] numa: forbid '-numa node,
 mem' for 5.1 and newer machine types
Date: Wed, 24 Jun 2020 06:50:43 -0400
Message-Id: <20200624105048.375353-26-pbonzini@redhat.com>
In-Reply-To: <20200624104917.375143-1-pbonzini@redhat.com>
References: <20200624104917.375143-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 03:27:53
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
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Greg Kurz <groug@kaod.org>, Michal Privoznik <mprivozn@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

Deprecation period is run out and it's a time to flip the switch
introduced by cd5ff8333a.  Disable legacy option for new machine
types (since 5.1) and amend documentation.

'-numa node,memdev' shall be used instead of disabled option
with new machine types.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <20200609135635.761587-1-imammedo@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/system/deprecated.rst | 37 ++++++++++++++++++++-----------------
 hw/arm/virt.c              |  2 +-
 hw/core/numa.c             |  7 +++++++
 hw/i386/pc.c               |  1 -
 hw/i386/pc_piix.c          |  1 +
 hw/i386/pc_q35.c           |  1 +
 hw/ppc/spapr.c             |  2 +-
 qemu-options.hx            |  9 +++++----
 8 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 3a255591c3..2fd6047481 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -95,23 +95,6 @@ error in the future.
 The ``-realtime mlock=on|off`` argument has been replaced by the
 ``-overcommit mem-lock=on|off`` argument.
 
-``-numa node,mem=``\ *size* (since 4.1)
-'''''''''''''''''''''''''''''''''''''''
-
-The parameter ``mem`` of ``-numa node`` is used to assign a part of
-guest RAM to a NUMA node. But when using it, it's impossible to manage specified
-RAM chunk on the host side (like bind it to a host node, setting bind policy, ...),
-so guest end-ups with the fake NUMA configuration with suboptiomal performance.
-However since 2014 there is an alternative way to assign RAM to a NUMA node
-using parameter ``memdev``, which does the same as ``mem`` and adds
-means to actualy manage node RAM on the host side. Use parameter ``memdev``
-with *memory-backend-ram* backend as an replacement for parameter ``mem``
-to achieve the same fake NUMA effect or a properly configured
-*memory-backend-file* backend to actually benefit from NUMA configuration.
-In future new machine versions will not accept the option but it will still
-work with old machine types. User can check QAPI schema to see if the legacy
-option is supported by looking at MachineInfo::numa-mem-supported property.
-
 ``-numa`` node (without memory specified) (since 4.1)
 '''''''''''''''''''''''''''''''''''''''''''''''''''''
 
@@ -519,3 +502,23 @@ long starting at 1MiB, the old command::
 can be rewritten as::
 
   qemu-nbd -t --image-opts driver=raw,offset=1M,size=100M,file.driver=qcow2,file.file.driver=file,file.file.filename=file.qcow2
+
+Command line options
+--------------------
+
+``-numa node,mem=``\ *size* (removed in 5.1)
+''''''''''''''''''''''''''''''''''''''''''''
+
+The parameter ``mem`` of ``-numa node`` was used to assign a part of
+guest RAM to a NUMA node. But when using it, it's impossible to manage a specified
+RAM chunk on the host side (like bind it to a host node, setting bind policy, ...),
+so the guest ends up with the fake NUMA configuration with suboptiomal performance.
+However since 2014 there is an alternative way to assign RAM to a NUMA node
+using parameter ``memdev``, which does the same as ``mem`` and adds
+means to actually manage node RAM on the host side. Use parameter ``memdev``
+with *memory-backend-ram* backend as replacement for parameter ``mem``
+to achieve the same fake NUMA effect or a properly configured
+*memory-backend-file* backend to actually benefit from NUMA configuration.
+New machine versions (since 5.1) will not accept the option but it will still
+work with old machine types. User can check the QAPI schema to see if the legacy
+option is supported by looking at MachineInfo::numa-mem-supported property.
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index caceb1e4a0..05c321f1ed 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2262,7 +2262,6 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     hc->pre_plug = virt_machine_device_pre_plug_cb;
     hc->plug = virt_machine_device_plug_cb;
     hc->unplug_request = virt_machine_device_unplug_request_cb;
-    mc->numa_mem_supported = true;
     mc->nvdimm_supported = true;
     mc->auto_enable_numa_with_memhp = true;
     mc->default_ram_id = "mach-virt.ram";
@@ -2375,6 +2374,7 @@ DEFINE_VIRT_MACHINE_AS_LATEST(5, 1)
 static void virt_machine_5_0_options(MachineClass *mc)
 {
     virt_machine_5_1_options(mc);
+    mc->numa_mem_supported = true;
 }
 DEFINE_VIRT_MACHINE(5, 0)
 
diff --git a/hw/core/numa.c b/hw/core/numa.c
index 5f81900f88..2725886d06 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -117,6 +117,13 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
     }
 
     if (node->has_mem) {
+        if (!mc->numa_mem_supported) {
+            error_setg(errp, "Parameter -numa node,mem is not supported by this"
+                      " machine type");
+            error_append_hint(errp, "Use -numa node,memdev instead\n");
+            return;
+        }
+
         numa_info[nodenr].node_mem = node->mem;
         if (!qtest_enabled()) {
             warn_report("Parameter -numa node,mem is deprecated,"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d103b8c0ab..39f8b47ce8 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2001,7 +2001,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     hc->unplug = pc_machine_device_unplug_cb;
     mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
     mc->nvdimm_supported = true;
-    mc->numa_mem_supported = true;
     mc->default_ram_id = "pc.ram";
 
     object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size",
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 1497d0e4ae..1d832b2878 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -441,6 +441,7 @@ static void pc_i440fx_5_0_machine_options(MachineClass *m)
     pc_i440fx_5_1_machine_options(m);
     m->alias = NULL;
     m->is_default = false;
+    m->numa_mem_supported = true;
     compat_props_add(m->compat_props, hw_compat_5_0, hw_compat_5_0_len);
     compat_props_add(m->compat_props, pc_compat_5_0, pc_compat_5_0_len);
 }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 46cd06524c..047ea8db28 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -369,6 +369,7 @@ static void pc_q35_5_0_machine_options(MachineClass *m)
 {
     pc_q35_5_1_machine_options(m);
     m->alias = NULL;
+    m->numa_mem_supported = true;
     compat_props_add(m->compat_props, hw_compat_5_0, hw_compat_5_0_len);
     compat_props_add(m->compat_props, pc_compat_5_0, pc_compat_5_0_len);
 }
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8d630baa5d..defb819f3c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4510,7 +4510,6 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
      * in which LMBs are represented and hot-added
      */
     mc->numa_mem_align_shift = 28;
-    mc->numa_mem_supported = true;
     mc->auto_enable_numa = true;
 
     smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
@@ -4598,6 +4597,7 @@ static void spapr_machine_5_0_class_options(MachineClass *mc)
 {
     spapr_machine_5_1_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_5_0, hw_compat_5_0_len);
+    mc->numa_mem_supported = true;
 }
 
 DEFINE_SPAPR_MACHINE(5_0, "5.0", false);
diff --git a/qemu-options.hx b/qemu-options.hx
index 93bde2bbc8..196f468786 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -239,10 +239,11 @@ SRST
         -numa node,nodeid=0 -numa node,nodeid=1 \
         -numa cpu,node-id=0,socket-id=0 -numa cpu,node-id=1,socket-id=1
 
-    '\ ``mem``\ ' assigns a given RAM amount to a node. '\ ``memdev``\ '
-    assigns RAM from a given memory backend device to a node. If
-    '\ ``mem``\ ' and '\ ``memdev``\ ' are omitted in all nodes, RAM is
-    split equally between them.
+    Legacy '\ ``mem``\ ' assigns a given RAM amount to a node (not supported
+    for 5.1 and newer machine types). '\ ``memdev``\ ' assigns RAM from
+    a given memory backend device to a node. If '\ ``mem``\ ' and
+    '\ ``memdev``\ ' are omitted in all nodes, RAM is split equally between them.
+
 
     '\ ``mem``\ ' and '\ ``memdev``\ ' are mutually exclusive.
     Furthermore, if one node uses '\ ``memdev``\ ', all of them have to
-- 
2.26.2



