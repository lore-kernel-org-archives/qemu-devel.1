Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322D7C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:02:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02BB021920
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02BB021920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFS5o-0004xC-7H
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 20:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39311)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRrs-0001HY-71
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:47:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRrn-0001Yi-37
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:47:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9626
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRrm-0001PA-Mp; Tue, 01 Oct 2019 19:47:38 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlO5q122835; Tue, 1 Oct 2019 19:47:30 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vcgk4094s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:30 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91NlTop123007;
 Tue, 1 Oct 2019 19:47:29 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vcgk4094j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:29 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjlX7001425;
 Tue, 1 Oct 2019 23:47:29 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma03wdc.us.ibm.com with ESMTP id 2v9y56yf6s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:29 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91NlSm744302770
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:28 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC89428058;
 Tue,  1 Oct 2019 23:47:28 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F9C02805A;
 Tue,  1 Oct 2019 23:47:28 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:28 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 31/97] q35: Revert to kernel irqchip
Date: Tue,  1 Oct 2019 18:45:10 -0500
Message-Id: <20191001234616.7825-32-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010203
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Williamson <alex.williamson@redhat.com>

Backport of QEMU v4.1 commit for stable v4.0.1 release

commit c87759ce876a7a0b17c2bf4f0b964bd51f0ee871
Author: Alex Williamson <alex.williamson@redhat.com>
Date:   Tue May 14 14:14:41 2019 -0600

    q35: Revert to kernel irqchip

    Commit b2fc91db8447 ("q35: set split kernel irqchip as default") changed
    the default for the pc-q35-4.0 machine type to use split irqchip, which
    turned out to have disasterous effects on vfio-pci INTx support.  KVM
    resampling irqfds are registered for handling these interrupts, but
    these are non-functional in split irqchip mode.  We can't simply test
    for split irqchip in QEMU as userspace handling of this interrupt is a
    significant performance regression versus KVM handling (GeForce GPUs
    assigned to Windows VMs are non-functional without forcing MSI mode or
    re-enabling kernel irqchip).

    The resolution is to revert the change in default irqchip mode in the
    pc-q35-4.1 machine and create a pc-q35-4.0.1 machine for the 4.0-stable
    branch.  The qemu-q35-4.0 machine type should not be used in vfio-pci
    configurations for devices requiring legacy INTx support without
    explicitly modifying the VM configuration to use kernel irqchip.

Link: https://bugs.launchpad.net/qemu/+bug/1826422
Fixes: b2fc91db8447 ("q35: set split kernel irqchip as default")
Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
(upstream commit c87759ce876a7a0b17c2bf4f0b964bd51f0ee871)
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
*add comments regarding AML mismatch warnings from
 tests/bios-tables-test.c
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/core/machine.c        |  3 +++
 hw/i386/pc.c             |  3 +++
 hw/i386/pc_q35.c         | 16 ++++++++++++++--
 include/hw/boards.h      |  3 +++
 include/hw/i386/pc.h     |  3 +++
 tests/bios-tables-test.c |  9 +++++++++
 6 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index b6766632d9..eb34f53a85 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -24,6 +24,9 @@
 #include "hw/pci/pci.h"
 #include "hw/mem/nvdimm.h"
 
+GlobalProperty hw_compat_4_0[] = {};
+const size_t hw_compat_4_0_len = G_N_ELEMENTS(hw_compat_4_0);
+
 GlobalProperty hw_compat_3_1[] = {
     { "pcie-root-port", "x-speed", "2_5" },
     { "pcie-root-port", "x-width", "1" },
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f2c15bf1f2..d98b737b8f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -115,6 +115,9 @@ struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
 /* Physical Address of PVH entry point read from kernel ELF NOTE */
 static size_t pvh_start_addr;
 
+GlobalProperty pc_compat_4_0[] = {};
+const size_t pc_compat_4_0_len = G_N_ELEMENTS(pc_compat_4_0);
+
 GlobalProperty pc_compat_3_1[] = {
     { "intel-iommu", "dma-drain", "off" },
     { "Opteron_G3" "-" TYPE_X86_CPU, "rdtscp", "off" },
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 372c6b73be..45cc29d1ad 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -357,7 +357,7 @@ static void pc_q35_machine_options(MachineClass *m)
     m->units_per_default_bus = 1;
     m->default_machine_opts = "firmware=bios-256k.bin";
     m->default_display = "std";
-    m->default_kernel_irqchip_split = true;
+    m->default_kernel_irqchip_split = false;
     m->no_floppy = 1;
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
@@ -365,12 +365,24 @@ static void pc_q35_machine_options(MachineClass *m)
     m->max_cpus = 288;
 }
 
-static void pc_q35_4_0_machine_options(MachineClass *m)
+static void pc_q35_4_0_1_machine_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
     m->alias = "q35";
 }
 
+DEFINE_Q35_MACHINE(v4_0_1, "pc-q35-4.0.1", NULL,
+                   pc_q35_4_0_1_machine_options);
+
+static void pc_q35_4_0_machine_options(MachineClass *m)
+{
+    pc_q35_4_0_1_machine_options(m);
+    m->default_kernel_irqchip_split = true;
+    m->alias = NULL;
+    compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
+    compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
+}
+
 DEFINE_Q35_MACHINE(v4_0, "pc-q35-4.0", NULL,
                    pc_q35_4_0_machine_options);
 
diff --git a/include/hw/boards.h b/include/hw/boards.h
index e231860666..fe1885cbff 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -293,6 +293,9 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
 
+extern GlobalProperty hw_compat_4_0[];
+extern const size_t hw_compat_4_0_len;
+
 extern GlobalProperty hw_compat_3_1[];
 extern const size_t hw_compat_3_1_len;
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ca65ef18af..43df7230a2 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -293,6 +293,9 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
 int e820_get_num_entries(void);
 bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
+extern GlobalProperty pc_compat_4_0[];
+extern const size_t pc_compat_4_0_len;
+
 extern GlobalProperty pc_compat_3_1[];
 extern const size_t pc_compat_3_1_len;
 
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index a506dcbb29..996599991e 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -354,6 +354,15 @@ static void test_acpi_asl(test_data *data)
             } else {
                 sdt->tmp_files_retain = true;
                 exp_sdt->tmp_files_retain = true;
+                /* NOTE: In QEMU 4.0.1, q35 aliases "pc-q35-4.0.1" instead of
+                 * "pc-q35-4.0". This gets encoded into the smbios tables and
+                 * due to the extra characters changes the offset of ACPI
+                 * pointer values allocated by SeaBIOS, causing some tests to
+                 * report AML mismatches. Since ACPI expected file paths rely
+                 * on the "q35" alias being used we can't easily change the
+                 * tests to use pc-q35-4.0, so for now hopefully this friendly
+                 * note will suffice.
+                 */
                 fprintf(stderr,
                         "acpi-test: Warning! %.4s mismatch. "
                         "Actual [asl:%s, aml:%s], Expected [asl:%s, aml:%s].\n",
-- 
2.17.1


