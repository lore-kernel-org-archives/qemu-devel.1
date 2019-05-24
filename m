Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C8CC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 06:42:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CDA020868
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 06:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CDA020868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49769 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU3tx-0006kR-JN
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 02:42:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU3ph-0003R2-Uc
	for qemu-devel@nongnu.org; Fri, 24 May 2019 02:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU3ph-0003Jw-0E
	for qemu-devel@nongnu.org; Fri, 24 May 2019 02:37:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hU3pg-0003JZ-P1
	for qemu-devel@nongnu.org; Fri, 24 May 2019 02:37:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E6A8C0578C4;
	Fri, 24 May 2019 06:37:36 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-235.brq.redhat.com [10.40.204.235])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 758F65B689;
	Fri, 24 May 2019 06:37:32 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 08:35:45 +0200
Message-Id: <20190524063553.5339-13-philmd@redhat.com>
In-Reply-To: <20190524063553.5339-1-philmd@redhat.com>
References: <20190524063553.5339-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Fri, 24 May 2019 06:37:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 12/20] hw/i386/pc: Pass the CPUArchIdList array
 by argument
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
Cc: Yang Zhong <yang.zhong@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
	Rob Bradford <robert.bradford@intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <rth@twiddle.net>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Samuel Ortiz <sameo@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pass the CPUArchIdList array by argument, this will
allow us to remove the PCMachineState argument later.

Suggested-by: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/pc.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index fe07baeb1d..6cfdb09f34 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -928,14 +928,12 @@ static void pc_build_smbios(PCMachineState *pcms)
     }
 }
=20
-static FWCfgState *x86_create_fw_cfg(PCMachineState *pcms,
+static FWCfgState *x86_create_fw_cfg(PCMachineState *pcms, const CPUArch=
IdList *cpus,
                                      uint16_t boot_cpus, uint16_t apic_i=
d_limit)
 {
     FWCfgState *fw_cfg;
     uint64_t *numa_fw_cfg;
     int i;
-    const CPUArchIdList *cpus;
-    MachineClass *mc =3D MACHINE_GET_CLASS(pcms);
=20
     fw_cfg =3D fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4,
                                 &address_space_memory);
@@ -953,7 +951,7 @@ static FWCfgState *x86_create_fw_cfg(PCMachineState *=
pcms,
      * So for compatibility reasons with old BIOSes we are stuck with
      * "etc/max-cpus" actually being apic_id_limit
      */
-    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)pcms->apic_id_limi=
t);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, apic_id_limit);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
     fw_cfg_add_bytes(fw_cfg, FW_CFG_ACPI_TABLES,
                      acpi_tables, acpi_tables_len);
@@ -969,20 +967,19 @@ static FWCfgState *x86_create_fw_cfg(PCMachineState=
 *pcms,
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
@@ -1763,7 +1760,8 @@ void pc_memory_init(PCMachineState *pcms,
                                         option_rom_mr,
                                         1);
=20
-    fw_cfg =3D x86_create_fw_cfg(pcms, pcms->boot_cpus, pcms->apic_id_li=
mit);
+    fw_cfg =3D x86_create_fw_cfg(pcms, mc->possible_cpu_arch_ids(machine=
),
+                               pcms->boot_cpus, pcms->apic_id_limit);
=20
     rom_set_fw(fw_cfg);
=20
--=20
2.20.1


