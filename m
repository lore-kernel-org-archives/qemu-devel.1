Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02221C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 11:25:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFF552086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 11:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF552086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyaMA-0000nS-U9
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 07:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1hyaLC-0008F8-Mq
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 07:24:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hyaLB-0008FK-LG
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 07:24:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54792)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hyaLB-0008Eo-G4
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 07:24:17 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BBB813090FCE;
 Fri, 16 Aug 2019 11:24:16 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF17C43FF3;
 Fri, 16 Aug 2019 11:24:14 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 07:24:06 -0400
Message-Id: <20190816112407.28180-2-imammedo@redhat.com>
In-Reply-To: <20190816112407.28180-1-imammedo@redhat.com>
References: <20190816112407.28180-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 16 Aug 2019 11:24:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH QEMU 1/1] q35: use dedicated SMRAM at default
 SMM_BASE
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
Cc: "Chen, Yingwen" <yingwen.chen@intel.com>,
 edk2-devel-groups-io <devel@edk2.groups.io>,
 Phillip Goerl <phillip.goerl@oracle.com>, "Yao, Jiewen" <jiewen.yao@intel.com>,
 "Nakajima, Jun" <jun.nakajima@intel.com>, pbonzini@redhat.com,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 edk2-rfc-groups-io <rfc@edk2.groups.io>, Laszlo Ersek <lersek@redhat.com>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

it will allow us to hide sensetive SMM_BASE area from non SMM running env,
that will allow us to ensure that hotplugged CPU will run trusted
SMM BASE relocation code and we won't need to force all present CPUs
into SMM mode since we don not care about about 0x30000 content
in normal RAM address space.

it's a obviously a hack only to demo approach. for easy SMI initialization
on SMI entry point SMRAM is aliased in to hajaked normal RAM address space
at a0000.
Patch should be used with supplied SMBIOS patch, that drops
save/restore sequence and just inits SMI entry point.

to test to run:
  qemu-system-x86_64 -M q35 -bios /path_to_seabios/out/bios.bin \
    -nodefaults \
    -chardev stdio,id=seabios -device isa-debugcon,iobase=0x402,chardev=seabios

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/pci-host/q35.h |  1 +
 hw/pci-host/q35.c         | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
index 5ed77facd0..556ecb835a 100644
--- a/include/hw/pci-host/q35.h
+++ b/include/hw/pci-host/q35.h
@@ -55,6 +55,7 @@ typedef struct MCHPCIState {
     MemoryRegion smram_region, open_high_smram;
     MemoryRegion smram, low_smram, high_smram;
     MemoryRegion tseg_blackhole, tseg_window;
+    MemoryRegion smbase, smram_alias;
     Range pci_hole;
     uint64_t below_4g_mem_size;
     uint64_t above_4g_mem_size;
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 0a010be4cf..6c4c0f308c 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -574,6 +574,16 @@ static void mch_realize(PCIDevice *d, Error **errp)
     memory_region_set_enabled(&mch->tseg_window, false);
     memory_region_add_subregion(&mch->smram, mch->below_4g_mem_size,
                                 &mch->tseg_window);
+
+    memory_region_init_ram(&mch->smm_base, OBJECT(mch), "SMM BASE", MCH_HOST_BRIDGE_SMRAM_C_SIZE, &error_fatal);
+    memory_region_set_enabled(&mch->smm_base, true);
+    memory_region_add_subregion(&mch->smram, 0x30000, &mch->smm_base);
+
+    memory_region_init_alias(&mch->smm_base_alias, OBJECT(mch), "smim_base_alias",
+                             &mch->smm_base, 0, MCH_HOST_BRIDGE_SMRAM_C_SIZE);
+    memory_region_set_enabled(&mch->smm_base_alias, true);
+    memory_region_add_subregion_overlap(mch->system_memory, MCH_HOST_BRIDGE_SMRAM_C_BASE, &mch->smm_base_alias, 1);
+
     object_property_add_const_link(qdev_get_machine(), "smram",
                                    OBJECT(&mch->smram), &error_abort);
 
-- 
2.18.1


