Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33533C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 16:02:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ABF220679
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 16:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ABF220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41230 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbSBB-0006gT-0Z
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 12:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42984)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbQqA-0001nP-HB
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbQq8-0001wB-Gw
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:36:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26138)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hbQq6-0001tr-Di
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:36:30 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 40FE8C065135;
 Thu, 13 Jun 2019 14:36:29 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B0DA1001B2E;
 Thu, 13 Jun 2019 14:36:26 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 16:34:38 +0200
Message-Id: <20190613143446.23937-13-philmd@redhat.com>
In-Reply-To: <20190613143446.23937-1-philmd@redhat.com>
References: <20190613143446.23937-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Thu, 13 Jun 2019 14:36:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 12/20] hw/i386/pc: Pass the CPUArchIdList
 array by argument
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
Cc: Yang Zhong <yang.zhong@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Rob Bradford <robert.bradford@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Samuel Ortiz <sameo@linux.intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pass the CPUArchIdList array by argument, this will
allow us to remove the PCMachineState argument later.

Suggested-by: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/pc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 7f5215965e..266cdf19b5 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -933,14 +933,13 @@ static void pc_build_smbios(PCMachineState *pcms)
 }
=20
 static FWCfgState *fw_cfg_arch_create(PCMachineState *pcms,
+                                      const CPUArchIdList *cpus,
                                       uint16_t boot_cpus,
                                       uint16_t apic_id_limit)
 {
     FWCfgState *fw_cfg;
     uint64_t *numa_fw_cfg;
     int i;
-    const CPUArchIdList *cpus;
-    MachineClass *mc =3D MACHINE_GET_CLASS(pcms);
=20
     fw_cfg =3D fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4,
                                 &address_space_memory);
@@ -958,7 +957,7 @@ static FWCfgState *fw_cfg_arch_create(PCMachineState =
*pcms,
      * So for compatibility reasons with old BIOSes we are stuck with
      * "etc/max-cpus" actually being apic_id_limit
      */
-    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)pcms->apic_id_limi=
t);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, apic_id_limit);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
     fw_cfg_add_bytes(fw_cfg, FW_CFG_ACPI_TABLES,
                      acpi_tables, acpi_tables_len);
@@ -974,20 +973,19 @@ static FWCfgState *fw_cfg_arch_create(PCMachineStat=
e *pcms,
      * of nodes, one word for each VCPU->node and one word for each node=
 to
      * hold the amount of memory.
      */
-    numa_fw_cfg =3D g_new0(uint64_t, 1 + pcms->apic_id_limit + nb_numa_n=
odes);
+    numa_fw_cfg =3D g_new0(uint64_t, 1 + apic_id_limit + nb_numa_nodes);
     numa_fw_cfg[0] =3D cpu_to_le64(nb_numa_nodes);
-    cpus =3D mc->possible_cpu_arch_ids(MACHINE(pcms));
     for (i =3D 0; i < cpus->len; i++) {
         unsigned int apic_id =3D cpus->cpus[i].arch_id;
-        assert(apic_id < pcms->apic_id_limit);
+        assert(apic_id < apic_id_limit);
         numa_fw_cfg[apic_id + 1] =3D cpu_to_le64(cpus->cpus[i].props.nod=
e_id);
     }
     for (i =3D 0; i < nb_numa_nodes; i++) {
-        numa_fw_cfg[pcms->apic_id_limit + 1 + i] =3D
+        numa_fw_cfg[apic_id_limit + 1 + i] =3D
             cpu_to_le64(numa_info[i].node_mem);
     }
     fw_cfg_add_bytes(fw_cfg, FW_CFG_NUMA, numa_fw_cfg,
-                     (1 + pcms->apic_id_limit + nb_numa_nodes) *
+                     (1 + apic_id_limit + nb_numa_nodes) *
                      sizeof(*numa_fw_cfg));
=20
     return fw_cfg;
@@ -1768,7 +1766,8 @@ void pc_memory_init(PCMachineState *pcms,
                                         option_rom_mr,
                                         1);
=20
-    fw_cfg =3D fw_cfg_arch_create(pcms, pcms->boot_cpus, pcms->apic_id_l=
imit);
+    fw_cfg =3D fw_cfg_arch_create(pcms, mc->possible_cpu_arch_ids(machin=
e),
+                                pcms->boot_cpus, pcms->apic_id_limit);
=20
     rom_set_fw(fw_cfg);
=20
--=20
2.20.1


