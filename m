Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A0CC48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 11:35:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ECC020656
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 11:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ECC020656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59028 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfjj3-0004V5-Ai
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 07:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53826)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jonathan.cameron@huawei.com>) id 1hfjdR-0007Vo-2R
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 07:29:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jonathan.cameron@huawei.com>) id 1hfjdM-0004Oo-66
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 07:29:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52888 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jonathan.cameron@huawei.com>)
 id 1hfjd5-0003xV-KU; Tue, 25 Jun 2019 07:28:57 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 4702790BD5F52C0CB68A;
 Tue, 25 Jun 2019 19:28:48 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Tue, 25 Jun 2019 19:28:37 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Date: Tue, 25 Jun 2019 19:27:48 +0800
Message-ID: <20190625112752.83188-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625112752.83188-1-Jonathan.Cameron@huawei.com>
References: <20190625112752.83188-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.123.41.22]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.35
Subject: [Qemu-devel] [RFC PATCH 3/7] pci: CCIX config space emulation
 library.
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
Cc: Peter Maydell <peter.maydell@linaro.org>, jcm@redhat.com,
 linuxarm@huawei.com, Auger Eric <eric.auger@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The nature of the complex topologies supported by CCIX means
that it will be sometime before it is possible to construct many
of the interesting cases in hardware, and it will be extermely
hard to exercise all of the combinations whilst developing firwmare
and drivers.

To that end, the intent of this library and following device
emulations is to allow the construction of complex CCIX toplogies
via their overlaying on PCIe.  The CCIX topologies are configured
through CCIX specific PCIe DVSEC capabillity and control structures.

A typical mesh capable CCIX device will overlay onto N upstream
PCIe switch ports, M downstream PCIe switch ports, function 0
EPs which are not PCIe switch upstream ports, P functions 1+
which have additional CCIX protocol elements described and Q
functions 1+ which respresent acceleration functions, with no
CCIX protocol elements (these look to be normal PCIe functions
so are not covered by this patch set).

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/pci/Kconfig           |    3 +
 hw/pci/Makefile.objs     |    1 +
 hw/pci/ccix_lib.c        | 1299 ++++++++++++++++++++++++++++++++++++++
 include/hw/misc/ccix.h   |   28 +
 include/hw/pci/pci_ids.h |    2 +
 5 files changed, 1333 insertions(+)

diff --git a/hw/pci/Kconfig b/hw/pci/Kconfig
index 77f8b005ff..605f8dcd18 100644
--- a/hw/pci/Kconfig
+++ b/hw/pci/Kconfig
@@ -13,3 +13,6 @@ config MSI_NONBROKEN
     # or support it and have a good implementation. See commit
     # 47d2b0f33c664533b8dbd5cb17faa8e6a01afe1f.
     bool
+
+config CCIX_LIB
+    bool
diff --git a/hw/pci/Makefile.objs b/hw/pci/Makefile.objs
index 8642fab622..efc17ff4dd 100644
--- a/hw/pci/Makefile.objs
+++ b/hw/pci/Makefile.objs
@@ -13,3 +13,4 @@ common-obj-$(CONFIG_PCI) +=3D ccix_per.o
=20
 common-obj-$(call lnot,$(CONFIG_PCI)) +=3D pci-stub.o
 common-obj-$(CONFIG_ALL) +=3D pci-stub.o
+common-obj-$(CONFIG_CCIX_LIB) +=3D ccix_lib.o
diff --git a/hw/pci/ccix_lib.c b/hw/pci/ccix_lib.c
new file mode 100644
index 0000000000..544f90077d
--- /dev/null
+++ b/hw/pci/ccix_lib.c
@@ -0,0 +1,1299 @@
+/*
+ * CCIX configuration space creation library
+ *
+ * Copyright (c) 2019 Huawei
+ * Author: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
+ *
+ * Portions copied from pci-testdev.c
+ * Copyright (c) 2012 Red Hat Inc.
+ * Author: Michael S. Tsirkin <mst@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License alo=
ng
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include "qemu/osdep.h"
+#include "hw/hw.h"
+#include "hw/pci/pci.h"
+#include "qemu/event_notifier.h"
+#include "sysemu/kvm.h"
+#include "hw/misc/ccix.h"
+
+/* Leave space for the SR-IDM and SW portal if enabled */
+#define CCIX_COMMON_CAP_MAX_SIZE                        10 * sizeof(uint=
32_t)
+
+#define CM_CAP_DW1_MULTIPORT_CAP_OFF                    0
+#define CM_CAP_DW1_MULTIPORT_CAP_M                      0x00000007
+#define CM_CAP_DW1_VERSION_CAP_OFF                      22
+#define CM_CAP_DW1_VERSION_CAP_M                        0x00C00000
+#define CM_CAP_DW1_DEVID_OFF                            24
+#define CM_CAP_DW1_DEVID_M                              0xFF000000
+
+#define CM_CAP_DW2_DISC_READY_CAP_OFF                   0
+#define CM_CAP_DW2_PART_CS_CAP_OFF                      1
+#define CM_CAP_DW2_PORT_AG_CAP_OFF                      2
+#define CM_CAP_DW2_CL_SIZE_CAP_OFF                      3
+#define CM_CAP_DW2_ADDR_W_CAP_OFF                       4
+#define CM_CAP_DW2_MH_CAP_OFF                           7
+#define CM_CAP_DW2_SW_PORT_CAP_OFF                      8
+#define CM_CAP_DW2_SAM_ALIGN_CAP_OFF                    9
+#define CM_CAP_DW2_READY_TIME_VAL_OFF                   19
+#define CM_CAP_DW2_READY_TIME_SCALE_OFF                 28
+
+/* COMMON_CAP III is reserved */
+#define CM_CAP_DW4_DEV_ERR_LOG_OFFSET_OFF               20
+#define CM_CAP_DW5_IDM_OFFSET_OFF                       20
+#define CM_CAP_DW6_RSAM_SIZE_OFF                        0
+#define CM_CAP_DW6_RSAM_OFFSET_OFF                      20
+#define CM_CAP_DW7_HSAM_SIZE_OFF                        0
+#define CM_CAP_DW7_HSAM_OFFSET_OFF                      20
+#define CM_CAP_DW8_SR_OFFSET_OFF                        20
+#define CM_CAP_DW9_SW_PORTAL_OFF                        0
+
+#define CM_CTL_DW1_DEVICE_EN_OFF                        0
+#define CM_CTL_DW1_PRIMARY_PORT_EN_OFF                  1
+#define CM_CTL_DW1_MESH_EN_OFF                          2
+#define CM_CTL_DW1_PORT_AG_EN_OFF                       4
+#define CM_CTL_DW1_IDM_TABLE_VALID_OFF                  5
+#define CM_CTL_DW1_RSAM_TABLE_VALID_OFF                 6
+#define CM_CTL_DW1_HSAM_TABLE_VALID_OFF                 7
+#define CM_CTL_DW1_SW_PORT_ENABLE_OFF                   8
+#define CM_CTL_DW1_ERR_AGENT_ID_OFF                     16
+#define CM_CTL_DW1_ERR_AGENT_ID_M                       0x003F0000
+#define CM_CTL_DW1_DEVID_OFF                            24
+#define CM_CTL_DW1_DEVID_M                              0xFF000000
+
+#define CM_CTL_DW2_PART_CS_EN_OFF                       1
+#define CM_CTL_DW2_CL_SIZE_EN_OFF                       3
+#define CM_CTL_DW2_ADDR_W_EN_OFF                        4
+#define CM_CTL_DW2_ADDR_W_EN_M                          0x00000070
+
+#define CCIX_PORT_CAP_SIZE                              5 * sizeof(uint3=
2_t)
+
+#define PT_CAP_DW1_DISC_READY_OFF                       0
+#define PT_CAP_DW1_OPT_HEADER_OFF                       1
+#define PT_CAP_DW1_P2P_FORWARDING_OFF                   5
+#define PT_CAP_DW1_LINKS_OFF                            7
+#define PT_CAP_DW1_LINKS_M                              0x00001F80
+#define PT_CAP_DW1_PSAM_ENTRIES_OFF                     13
+#define PT_CAP_DW1_PSAM_ENTRIES_M                       0x0007E000
+#define PT_CAP_DW1_PORTID_OFF                           27
+#define PT_CAP_DW1_PORTID_M                             0xF8000000
+
+/* not including PSAM */
+#define CCIX_PORT_CTL_SIZE                              5 * sizeof(uint3=
2_t)
+
+#define PT_CTL_DW1_PORT_EN_OFF                          0
+#define PT_CTL_DW1_OPT_HEADER_EN_OFF                    1
+#define PT_CTL_DW1_LINKS_EN_OFF                         7
+#define PT_CTL_DW1_LINKS_EN_M                           0x00001F80
+#define PT_CTL_DW1_PSAM_ENTRIES_EN_OFF                  13
+#define PT_CTL_DW1_PSAM_ENTRIES_EN_M                    0x0007E000
+
+#define CCIX_LINK_CAP_SIZE                              6 * sizeof(uint3=
2_t)
+
+#define LK_CAP_DW1_DISC_READY_OFF                       0
+#define LK_CAP_DW1_CREDIT_TYPE_OFF                      1
+#define LK_CAP_DW1_MESSAGE_PACKING_OFF                  2
+#define LK_CAP_DW1_NOCOMPACK_OFF                        6
+#define LK_CAP_DW1_MAX_PKT_SIZE_OFF                     7
+#define LK_CAP_DW1_MAX_PKT_SIZE_M                       0x00000038
+#define LK_CAP_DW2_MAX_MEM_REQ_SEND_OFF                 0
+#define LK_CAP_DW2_MAX_MEM_REQ_SEND_M                   0x000003FF
+#define LK_CAP_DW2_MAX_SNP_REQ_SEND_OFF                 10
+#define LK_CAP_DW2_MAX_SNP_REQ_SEND_M                   0x000FFC00
+#define LK_CAP_DW2_MAX_DAT_REQ_SEND_OFF                 20
+#define LK_CAP_DW2_MAX_DAT_REQ_SEND_M                   0x3FF00000
+#define LK_CAP_DW3_MAX_MEM_REQ_RECV_OFF                 0
+#define LK_CAP_DW3_MAX_MEM_REQ_RECV_M                   0x000003FF
+#define LK_CAP_DW3_MAX_SNP_REQ_RECV_OFF                 10
+#define LK_CAP_DW3_MAX_SNP_REQ_RECV_M                   0x000FFC00
+#define LK_CAP_DW3_MAX_DAT_REQ_RECV_OFF                 20
+#define LK_CAP_DW3_MAX_DAT_REQ_RECV_M                   0x3FF00000
+#define LK_CAP_DW4_MAX_MISC_REQ_SEND_CAP_OFF            0
+#define LK_CAP_DW4_MAX_MISC_REQ_RECV_CAP_OFF            10
+
+/* Not including per link */
+#define CCIX_LINK_CTL_SIZE                              1 * sizeof(uint3=
2_t)
+/* Not including BcastFwdCntlVctr, including Tranport ID map */
+#define CCIX_LINK_CTL_PER_LINK_SIZE                    (6 + 1) * sizeof(=
uint32_t)
+
+/* Per link controls */
+#define LK_CTL_DW1_LINK_EN_OFF                          0
+#define LK_CTL_DW1_CREDIT_EN_OFF                        1
+#define LK_CTL_DW1_MESSAGE_PACKING_EN_OFF               2
+#define LK_CTL_DW1_NO_COMP_ACK_EN_OFF                   6
+#define LK_CTL_DW1_MAX_PKT_SIZE_EN_OFF                  7
+#define LK_CTL_DW1_MAX_PKT_SIZE_EN_M                    0x00000380
+#define LK_CTL_DW1_LINK_ENT_ADDR_TYPE_OFF               10
+
+#define CCIX_RA_CAP_SIZE                                3 * sizeof(uint3=
2_t)
+
+#define RA_CAP_DW1_RA_DISC_RDY_STAT_OFF                 0
+#define RA_CAP_DW1_RA_CACHE_FLUSH_TIME_VALUE_OFF        19
+#define RA_CAP_DW1_RA_CACHE_FLUSH_TIME_VALUE_M          0x0FF80000
+#define RA_CAP_DW1_RA_CACHE_FLUSH_TIME_SCALE_OFF        28
+#define RA_CAP_DW1_RA_CACHE_FLUSH_TIME_SCALE_M          0x70000000
+#define RA_CAP_DW1_RA_CACHE_FLUSH_STA_OFF               31
+
+#define RA_CAP_DW2_RA_ERROR_LOG_OFFSET_OFF              20
+
+#define CCIX_RA_CTL_SIZE                                4 * sizeof(uint3=
2_t)
+
+#define RA_CTL_DW1_EN_OFF                               0
+#define RA_CTL_DW1_SNOOP_RESP_EN_OFF                    1
+#define RA_CTL_DW1_CACHE_FLUSH_EN_OFF                   14
+#define RA_CTL_DW1_CACHE_EN_OFF                         15
+#define RA_CTL_DW1_RAID_OFF                             26
+#define RA_CTL_DW1_RAID_M                               0xFC000000
+
+/* Excluding pool entries */
+#define CCIX_HA_CAP_SIZE                                3 * sizeof(uint3=
2_t)
+
+#define HA_CAP_DW1_HA_DISC_RD_STAT_OFF                  0
+#define HA_CAP_DW1_NUM_HA_IDS_OFF                       1
+#define HA_CAP_DW1_HA_MEM_POOL_CAP_OFF                  8
+#define HA_CAP_DW1_HA_QACK_OFF                          14
+#define HA_CAP_DW1_HA_HW_QACK_CAP_OFF                   15
+#define HA_CAP_DW1_HA_MEM_EXP_CAP_OFF                   16
+#define HA_CAP_DW1_HA_EVICT_HINT_CAP_OFF                17
+#define HA_CAP_DW1_HA_WRITE_EVICT_FULL_HIT_CAP_OFF      18
+#define HA_CAP_DW1_MEM_POOL_READY_TIME_VALUE_OFF        19
+#define HA_CAP_DW1_MEM_POOL_READY_TIME_VALUE_M          0x0FF80000
+#define HA_CAP_DW1_MEM_POOL_READY_TIME_SCALE_OFF        28
+#define HA_CAP_DW1_MEM_POOL_READY_TIME_SCALE_M          0x70000000
+#define HA_CAP_DW1_MEM_POOL_READY_STA_OFF               31
+
+#define HA_CAP_DW2_HA_ERROR_LOG_OFF                     20
+
+#define MEM_POOL_CAP_DW1_READY_STA_OFF                  0
+#define MEM_POOL_CAP_DW1_GEN_MEM_TYPE_OFF               1
+enum {
+    mem_type_other =3D 0,
+    mem_type_expan,
+    mem_type_hole,
+    mem_type_rom,
+    mem_type_volatile,
+    mem_type_non_volatile,
+    mem_type_device,
+};
+
+#define MEM_POOL_CAP_DW1_SPEC_MEM_TYPE_OFF              4
+enum {
+    mem_spec_other =3D 0,
+    mem_spec_sram,
+    mem_spec_ddr,
+    mem_spec_nvdimm_f,
+    mem_spec_nvdimm_n,
+    mem_spec_hbm,
+    mem_spec_flash,
+};
+#define MEM_POOL_CAP_DW1_ADDR_CAP_OFF                   7
+#define MEM_POOL_CAP_DW1_MEM_ATTR_OFF                   8
+#define MEM_POOL_CAP_DW1_MEM_ATTR_DEV                   0x0
+#define MEM_POOL_CAP_DW1_MEM_ATTR_NONCACHE              0x4
+#define MEM_POOL_CAP_DW1_MEM_ATTR_NORMAL                0x5
+#define MEM_POOL_CAP_DW1_MEM_EXT_ATTR_OFF               11
+#define MEM_POOL_CAP_DW1_MEM_EXT_ATTR_NONE              0x0
+#define MEM_POOL_CAP_DW1_MEM_EXT_ATTR_PRIVATE           0x1
+#define MEM_POOL_CAP_DW1_MEM_POOL_SIZE_L_CAP_OFF        16
+
+#define MEM_POOL_CAP_DW2_MEM_POOL_SIZE_H_CAP_OFF        0
+
+/* Not including HAID or HBAT entries */
+#define CCIX_HA_CTL_SIZE                                6 * sizeof(uint3=
2_t)
+#define CCIX_HAID_ENTRY_SIZE                            1 * sizeof(uint3=
2_t)
+#define CCIX_BAT_ENTRY_SIZE                             2 * sizeof(uint3=
2_t)
+
+#define CCIX_POOL_CAP_SIZE                              2 * sizeof(uint3=
2_t)
+#define CCIX_GUID_SIZE                                  5 * sizeof(uint3=
2_t)
+#define CCIX_SAM_ENTRY_SIZE                             3 * sizeof(uint3=
2_t)
+#define CCIX_GUID_DW0                                   0xC3CB993B
+#define CCIX_GUID_DW1                                   0x02C4436F
+#define CCIX_GUID_DW2                                   0x9B68D271
+#define CCIX_GUID_DW3                                   0xF2E8CA31
+#define CCIX_GUID_DW4_VERSION_OFF                       0
+
+/* HACK - What is the best way to do this in Qemu? */
+CCIXState *CCIXFuncs[256];
+
+typedef void (*am_cb_t)(PCIDevice *d, CCIXState *s, uint16_t offset,
+                        uint16_t cap_start_offset, uint32_t val);
+struct am {
+    uint16_t offset;
+    uint16_t cap_start_offset;
+    am_cb_t am_cb;
+};
+
+static int am_cmp(const void *ap, const void *bp)
+{
+    const uint16_t *a;
+    const uint16_t *b;
+
+    a =3D ap;
+    b =3D bp;
+
+    return *a - *b;
+}
+
+void initialize_ccixstate(CCIXState *s, PCIDevice *d)
+{
+    s->am_tree =3D g_tree_new(am_cmp);
+    s->pci_dev =3D d;
+}
+
+static void am_table_add(PCIDevice *pci_dev, CCIXState *s, uint16_t offs=
et,
+                         uint16_t cap_start_offset, am_cb_t cb)
+{
+    struct am *entry =3D g_malloc0(sizeof *entry);
+
+    if (entry) {
+        entry->offset =3D offset;
+        entry->cap_start_offset =3D cap_start_offset;
+        entry->am_cb =3D cb;
+        g_tree_insert(s->am_tree, &entry->offset, entry);
+    }
+}
+
+void ccix_write_config(PCIDevice *pci_dev, CCIXState *s, uint32_t addr, =
uint32_t val_in, int l)
+{
+    uint64_t key =3D addr;
+    struct am *entry =3D g_tree_lookup(s->am_tree, &key);
+
+    if (entry && entry->offset =3D=3D addr)
+        entry->am_cb(pci_dev, s, addr, entry->cap_start_offset, val_in);
+}
+
+#define CCIX_COMP_ID_GENERAL     0x0000
+#define CCIX_COMP_ID_TDL_DVSEC   0x0001
+#define CCIX_COMP_ID_PRL_DVSEC   0x0002
+#define CCIX_COMP_ID_PRL_COMMON  0x0003
+#define CCIX_COMP_ID_PRL_PORT    0x0004
+#define CCIX_COMP_ID_PRL_LINK    0x0005
+#define CCIX_COMP_ID_HA          0x0006
+#define CCIX_COMP_ID_RA          0x0008
+#define CCIX_COMP_ID_SA          0x000A
+
+#define CCIX_DVSEC_CAP_POS_OFFSET 0x0C
+#define CCIX_DVSEC_CTR_POS_OFFSET 0x10
+
+static void ccix_dvsec_fill_dvsec_header(PCIDevice *pci_dev, uint16_t of=
fset,
+                                         uint16_t cap_size,
+                                         uint16_t cap_offset,
+                                         uint16_t control_size,
+                                         uint16_t control_offset)
+{
+    uint32_t *dword_addr;
+
+    dword_addr =3D (uint32_t *)(pci_dev->config + offset +
+                              CCIX_DVSEC_CAP_POS_OFFSET);
+    *dword_addr =3D cap_size | (cap_offset << 20);
+    dword_addr =3D (uint32_t *)(pci_dev->config + offset +
+                              CCIX_DVSEC_CTR_POS_OFFSET);
+    *dword_addr =3D control_size | (control_offset << 20);
+}
+
+static void ccix_fill_cap_header(PCIDevice *pci_dev, uint16_t cap_offset=
,
+                                 uint16_t ccix_comp, uint16_t next_offse=
t)
+{
+    uint8_t ver =3D 1;
+    uint32_t *dword_addr;
+
+    dword_addr =3D (uint32_t *)(pci_dev->config + cap_offset);
+    *dword_addr =3D ccix_comp | (ver << 16) | (next_offset << 20);
+}
+
+static void ra_ctl_dw1_set(PCIDevice *pci_dev, CCIXState *s,  uint16_t o=
ffset,
+                           uint16_t cap_start, uint32_t req_val)
+{
+    uint32_t cur_val, new_val =3D 0;
+    bool ra_en_cur, ra_en_req;
+    uint32_t capval;
+    bool ra_snoop_resp_en_cur, ra_snoop_resp_en_req;
+    bool ra_cache_flush_en_cur, ra_cache_flush_en_req;
+    bool ra_cache_en_cur, ra_cache_en_req;
+    uint8_t raid_cur, raid_req;
+
+    cur_val =3D pci_get_long(pci_dev->config + offset);
+    ra_en_cur =3D cur_val & (1 << RA_CTL_DW1_EN_OFF);
+    ra_en_req =3D req_val & (1 << RA_CTL_DW1_EN_OFF);
+
+    if (ra_en_cur !=3D ra_en_req)
+        printf("Changing RA Enable to %d\n", ra_en_req);
+
+    if (ra_en_req)
+        new_val =3D (1 << RA_CTL_DW1_EN_OFF);
+
+    ra_snoop_resp_en_cur =3D cur_val & (1 << RA_CTL_DW1_SNOOP_RESP_EN_OF=
F);
+    ra_snoop_resp_en_req =3D req_val & (1 << RA_CTL_DW1_SNOOP_RESP_EN_OF=
F);
+
+    if (ra_snoop_resp_en_cur !=3D ra_snoop_resp_en_req)
+        printf("Changing RA Snoop REsp Enabled to %d\n",
+               ra_snoop_resp_en_req);
+
+    if (ra_snoop_resp_en_req)
+        new_val |=3D (1 << RA_CTL_DW1_SNOOP_RESP_EN_OFF);
+
+    ra_cache_flush_en_cur =3D cur_val & (1 << RA_CTL_DW1_CACHE_FLUSH_EN_=
OFF);
+    ra_cache_flush_en_req =3D req_val & (1 << RA_CTL_DW1_CACHE_FLUSH_EN_=
OFF);
+    if (ra_cache_flush_en_cur !=3D ra_cache_flush_en_req) {
+        printf("Enabling or disabling a cache flush %d\n",
+               ra_cache_flush_en_req);
+
+        //Make the cache flush status update instantaneous for now
+        capval =3D pci_get_long(pci_dev->config + cap_start + 0x4);
+        if (ra_cache_flush_en_req)
+            capval |=3D (1 << RA_CAP_DW1_RA_CACHE_FLUSH_STA_OFF);
+        else
+            capval &=3D ~ (1 << RA_CAP_DW1_RA_CACHE_FLUSH_STA_OFF);
+        pci_set_long(pci_dev->config + cap_start + 0x4, capval);
+    }
+    if (ra_cache_flush_en_req)
+        new_val |=3D (1 << RA_CTL_DW1_CACHE_FLUSH_EN_OFF);
+
+    ra_cache_en_cur =3D cur_val & (1 << RA_CTL_DW1_CACHE_EN_OFF);
+    ra_cache_en_req =3D req_val & (1 << RA_CTL_DW1_CACHE_EN_OFF);
+    if (ra_cache_en_cur !=3D ra_cache_en_req)
+        printf("Enabling of disabling the RA cache %d\n", ra_cache_en_re=
q);
+
+    if (ra_cache_en_req)
+        new_val |=3D (1 << RA_CTL_DW1_CACHE_EN_OFF);
+
+    raid_cur =3D (cur_val & RA_CTL_DW1_RAID_M) >> RA_CTL_DW1_RAID_OFF;
+    raid_req =3D (req_val & RA_CTL_DW1_RAID_M) >> RA_CTL_DW1_RAID_OFF;
+    if (raid_cur !=3D raid_req)
+        printf("RA ID changing from %u to %u\n", raid_cur, raid_req);
+
+    new_val |=3D (raid_req << RA_CTL_DW1_RAID_OFF) & RA_CTL_DW1_RAID_M;
+
+    pci_set_long(pci_dev->config + offset, new_val);
+}
+
+
+static void comncntl1_set(PCIDevice *pci_dev, CCIXState *s, uint16_t off=
set,
+			  uint16_t cap_start, uint32_t req_val)
+{
+    uint32_t cur_val, new_val =3D 0;
+    bool dev_en_req, dev_en_cur;
+    bool pp_en_req, pp_en_cur;
+    bool id_val_req, id_val_cur;
+    bool rsam_val_req, rsam_val_cur;
+    uint8_t eaid_req, eaid_cur;
+    uint8_t devid_req, devid_cur;
+    int i;
+    uint32_t capval;
+
+    cur_val =3D pci_get_long(pci_dev->config + offset);
+
+    dev_en_req =3D req_val & (1 << CM_CTL_DW1_DEVICE_EN_OFF);
+    dev_en_cur =3D cur_val & (1 << CM_CTL_DW1_DEVICE_EN_OFF);
+    if (dev_en_req !=3D dev_en_cur) {
+        printf("Dev enable changing to %d\n", dev_en_req);
+        /* Now I need to set it on all devices */
+        if (s->ccix_dev_name)
+            for (i =3D 0; i < sizeof(CCIXFuncs)/sizeof(*CCIXFuncs); i++)=
 {
+                if (!CCIXFuncs[i] || !CCIXFuncs[i]->ccix_dev_name)
+                    continue;
+                if (CCIXFuncs[i] !=3D s && !strcmp(CCIXFuncs[i]->ccix_de=
v_name, s->ccix_dev_name)) {
+                    pci_set_long(CCIXFuncs[i]->pci_dev->config + CCIXFun=
cs[i]->enable_offset,
+                                 pci_get_word(CCIXFuncs[i]->pci_dev->con=
fig + CCIXFuncs[i]->enable_offset) | 0x1);
+                }
+            }
+    }
+    if (dev_en_req)
+        new_val |=3D (1 << CM_CTL_DW1_DEVICE_EN_OFF);
+
+    pp_en_req =3D req_val & (1 << CM_CTL_DW1_PRIMARY_PORT_EN_OFF);
+    pp_en_cur =3D cur_val & (1 << CM_CTL_DW1_PRIMARY_PORT_EN_OFF);
+    if (pp_en_req !=3D pp_en_cur)
+        printf("Primary port enable changing to %d\n", pp_en_req);
+    if (pp_en_req)
+        new_val |=3D (1 << CM_CTL_DW1_PRIMARY_PORT_EN_OFF);
+    /* NOT DOING MESH ENABLE FOR NOW */
+    /* NOT DOING PORT AG FOR NOW */
+
+    id_val_req =3D req_val & (1 << CM_CTL_DW1_IDM_TABLE_VALID_OFF);
+    id_val_cur =3D cur_val & (1 << CM_CTL_DW1_IDM_TABLE_VALID_OFF);
+    if (id_val_req !=3D id_val_cur)
+        printf("Validity of IDM changing to %d\n", id_val_req);
+    if (id_val_req)
+        new_val |=3D (1 << CM_CTL_DW1_IDM_TABLE_VALID_OFF);
+
+    rsam_val_req =3D req_val & (1 << CM_CTL_DW1_RSAM_TABLE_VALID_OFF);
+    rsam_val_cur =3D cur_val & (1 << CM_CTL_DW1_RSAM_TABLE_VALID_OFF);
+    if (rsam_val_req !=3D rsam_val_cur)
+        printf("RSAM valid changing to %d\n", rsam_val_req);
+    if (rsam_val_req)
+        new_val |=3D (1 << CM_CTL_DW1_RSAM_TABLE_VALID_OFF);
+    /* NOT DOING HSAM FOR NOW */
+    /* NOT DOING SW SERVICES PORTAL FOR NOW */
+
+    eaid_req =3D (req_val & CM_CTL_DW1_ERR_AGENT_ID_M) >>
+        CM_CTL_DW1_ERR_AGENT_ID_OFF;
+    eaid_cur =3D (cur_val & CM_CTL_DW1_ERR_AGENT_ID_M) >>
+        CM_CTL_DW1_ERR_AGENT_ID_OFF;
+    if (eaid_req !=3D eaid_cur)
+        printf("EAID for device changing from %d to %d\n",
+               eaid_cur, eaid_req);
+    new_val |=3D eaid_req << CM_CTL_DW1_ERR_AGENT_ID_OFF;
+
+    devid_req =3D (req_val & CM_CTL_DW1_DEVID_M) >> CM_CTL_DW1_DEVID_OFF=
;
+    devid_cur =3D (cur_val & CM_CTL_DW1_DEVID_M) >> CM_CTL_DW1_DEVID_OFF=
;
+    if (devid_req !=3D devid_cur) {
+        printf("DEVID changing from %d to %d, updating status\n",
+               devid_cur, devid_req);
+
+        capval =3D pci_get_long(pci_dev->config + cap_start + 0x4);
+        capval &=3D ~CM_CAP_DW1_DEVID_M;
+        capval |=3D (uint32_t)devid_req << CM_CAP_DW1_DEVID_OFF;
+        pci_set_long(pci_dev->config + cap_start + 4, capval);
+
+        if (s->ccix_dev_name)
+            for (i =3D 0; i < sizeof(CCIXFuncs)/sizeof(*CCIXFuncs); i++)=
 {
+                if (!CCIXFuncs[i] || !CCIXFuncs[i]->ccix_dev_name)
+                    continue;
+                if (CCIXFuncs[i] !=3D s && !strcmp(CCIXFuncs[i]->ccix_de=
v_name, s->ccix_dev_name)) {
+                    capval =3D pci_get_long(CCIXFuncs[i]->pci_dev->confi=
g + CCIXFuncs[i]->enable_offset);
+                    capval &=3D ~CM_CAP_DW1_DEVID_M;
+                    capval |=3D (uint32_t)devid_req << CM_CAP_DW1_DEVID_=
OFF;
+                    pci_set_long(CCIXFuncs[i]->pci_dev->config + CCIXFun=
cs[i]->enable_offset, capval);
+                }
+            }
+    }
+    new_val |=3D (uint32_t)devid_req << CM_CTL_DW1_DEVID_OFF;
+
+    pci_set_long(pci_dev->config + offset, new_val);
+}
+
+static void comncntl2_set(PCIDevice *pci_dev, CCIXState *s, uint16_t off=
set,
+              uint16_t cap_start, uint32_t req_val)
+{
+    uint32_t cur_val, new_val =3D 0;
+    bool partial_cur, partial_req;
+    uint32_t addrw_cur, addrw_req;
+
+    cur_val =3D pci_get_long(pci_dev->config + offset);
+
+    partial_cur =3D cur_val & (1 << CM_CTL_DW2_PART_CS_EN_OFF);
+    partial_req =3D req_val & (1 << CM_CTL_DW2_PART_CS_EN_OFF);
+    if (partial_cur !=3D partial_req)
+        printf("Changing Partial Cache enable to %d\n", partial_req);
+    if (partial_req)
+        new_val =3D (1 << CM_CTL_DW2_PART_CS_EN_OFF);
+    /* Cacheline size 128 not yet supported */
+
+    addrw_cur =3D (cur_val & CM_CTL_DW2_ADDR_W_EN_M) >> CM_CTL_DW2_ADDR_=
W_EN_OFF;
+    addrw_req =3D (req_val & CM_CTL_DW2_ADDR_W_EN_M) >> CM_CTL_DW2_ADDR_=
W_EN_OFF;
+    /* No sanity checking yet */
+    if (addrw_cur !=3D addrw_req)
+        printf("Changing Address Width to %d\n", addrw_req);
+    new_val =3D (addrw_req << CM_CTL_DW2_ADDR_W_EN_OFF);
+
+    pci_set_long(pci_dev->config + offset, new_val);
+}
+
+static void port_ctl_dw1_set(PCIDevice *pci_dev, CCIXState *s, uint16_t =
offset,
+                             uint16_t cap_start, uint32_t req_val)
+{
+    uint32_t cur_val;
+    uint32_t new_val =3D 0;
+    bool en_req, en_cur;
+    bool opt_req, opt_cur;
+    uint32_t links_req, links_cur;
+    uint32_t psam_req, psam_cur;
+
+    cur_val =3D pci_get_long(pci_dev->config + offset);
+    en_cur =3D cur_val & (1 << PT_CTL_DW1_PORT_EN_OFF);
+    en_req =3D req_val & (1 << PT_CTL_DW1_PORT_EN_OFF);
+    if (en_cur !=3D en_req)
+        printf("Enabling of port changing to %d\n", en_req);
+    if (en_req)
+        new_val |=3D (1 << PT_CTL_DW1_PORT_EN_OFF);
+
+    opt_cur =3D cur_val & (1 << PT_CTL_DW1_OPT_HEADER_EN_OFF);
+    opt_req =3D req_val & (1 << PT_CTL_DW1_OPT_HEADER_EN_OFF);
+    if (opt_cur !=3D opt_req)
+        printf("Enabling of optimized header changing to %d\n", opt_req)=
;
+    if (opt_req)
+        new_val |=3D (1 << PT_CTL_DW1_OPT_HEADER_EN_OFF);
+
+    links_cur =3D (cur_val & PT_CTL_DW1_LINKS_EN_M) >> PT_CTL_DW1_LINKS_=
EN_OFF;
+    links_req =3D (req_val & PT_CTL_DW1_LINKS_EN_M) >> PT_CTL_DW1_LINKS_=
EN_OFF;
+    if (links_cur !=3D links_req)
+        printf("Number of enabled links changing from %d to %d\n",
+               links_cur, links_req);
+    new_val |=3D (links_req << PT_CTL_DW1_LINKS_EN_OFF);
+
+    psam_cur =3D (cur_val & PT_CTL_DW1_PSAM_ENTRIES_EN_M) >>
+        PT_CTL_DW1_PSAM_ENTRIES_EN_OFF;
+    psam_req =3D (req_val & PT_CTL_DW1_PSAM_ENTRIES_EN_M) >>
+        PT_CTL_DW1_PSAM_ENTRIES_EN_OFF;
+    if (psam_cur !=3D psam_req)
+        printf("Number of psam entries changing from %d to %d\n",
+               psam_cur, psam_req);
+    new_val |=3D (psam_req << PT_CTL_DW1_PSAM_ENTRIES_EN_OFF);
+
+    pci_set_long(pci_dev->config + offset, new_val);
+}
+
+static void lk_ctl_dw1_set(PCIDevice *pci_dev, CCIXState *s, uint16_t of=
fset,
+               uint16_t cap_start, uint32_t req_val)
+{
+    uint32_t cur_val;
+    uint32_t new_val =3D 0;
+    bool en_cur, en_req;
+    bool cred_en_cur, cred_en_req;
+    bool mpack_en_cur, mpack_en_req;
+    bool nocompack_cur, nocompack_req;
+    uint32_t maxpkt_cur, maxpkt_req;
+    bool addr_type_cur, addr_type_req;
+
+    cur_val =3D pci_get_long(pci_dev->config + offset);
+
+    en_cur =3D cur_val & (1 << LK_CTL_DW1_LINK_EN_OFF);
+    en_req =3D req_val & (1 << LK_CTL_DW1_LINK_EN_OFF);
+    if (en_cur !=3D en_req)
+        printf("Changing link enabled status to %d\n", en_req);
+    if (en_req)
+        new_val |=3D (1 << LK_CTL_DW1_LINK_EN_OFF);
+
+    cred_en_cur =3D cur_val & (1 << LK_CTL_DW1_CREDIT_EN_OFF);
+    cred_en_req =3D req_val & (1 << LK_CTL_DW1_CREDIT_EN_OFF);
+    if (cred_en_cur !=3D cred_en_req)
+        printf("Changing link credit enable status to %d\n", cred_en_cur=
);
+    if (cred_en_req)
+        new_val |=3D (1 << LK_CTL_DW1_CREDIT_EN_OFF);
+
+    mpack_en_cur =3D cur_val & (1 << LK_CTL_DW1_MESSAGE_PACKING_EN_OFF);
+    mpack_en_req =3D req_val & (1 << LK_CTL_DW1_MESSAGE_PACKING_EN_OFF);
+    if (mpack_en_cur !=3D mpack_en_req)
+        printf("Changing message packing enable to %d\n", mpack_en_req);
+    if (mpack_en_req)
+        new_val |=3D (1 << LK_CTL_DW1_MESSAGE_PACKING_EN_OFF);
+    nocompack_cur =3D cur_val & (1 << LK_CTL_DW1_NO_COMP_ACK_EN_OFF);
+    nocompack_req =3D req_val & (1 << LK_CTL_DW1_NO_COMP_ACK_EN_OFF);
+    if (nocompack_cur !=3D nocompack_req)
+        printf("Setting nocompack for link to %d\n", nocompack_req);
+    if (nocompack_req)
+        new_val |=3D (1 << LK_CTL_DW1_NO_COMP_ACK_EN_OFF);
+
+    maxpkt_cur =3D (cur_val & LK_CTL_DW1_MAX_PKT_SIZE_EN_M) >>
+        LK_CTL_DW1_MAX_PKT_SIZE_EN_OFF;
+    maxpkt_req =3D (req_val & LK_CTL_DW1_MAX_PKT_SIZE_EN_M) >>
+        LK_CTL_DW1_MAX_PKT_SIZE_EN_OFF;
+    if (maxpkt_cur !=3D maxpkt_req)
+        printf("Changing max packet size on link from %d to %d\n",
+               maxpkt_cur, maxpkt_req);
+    new_val |=3D maxpkt_req << LK_CTL_DW1_MAX_PKT_SIZE_EN_OFF;
+
+    addr_type_cur =3D cur_val & (1 << LK_CTL_DW1_LINK_ENT_ADDR_TYPE_OFF)=
;
+    addr_type_req =3D req_val & (1 << LK_CTL_DW1_LINK_ENT_ADDR_TYPE_OFF)=
;
+    if (addr_type_cur !=3D addr_type_req)
+        printf("Link Entry Address Type changed to %d\n", addr_type_req)=
;
+    if (addr_type_req)
+        new_val |=3D (1 << LK_CTL_DW1_LINK_ENT_ADDR_TYPE_OFF);
+
+    pci_set_long(pci_dev->config + offset, new_val);
+}
+
+static void lk_ctl_dw2_set(PCIDevice *pci_dev, CCIXState *s, uint16_t of=
fset,
+               uint16_t cap_start, uint32_t req_val)
+{
+    uint32_t new_val =3D req_val;
+    /* TODO */
+    pci_set_long(pci_dev->config + offset, new_val);
+}
+
+static void lk_ctl_dw3_set(PCIDevice *pci_dev, CCIXState *s, uint16_t of=
fset,
+               uint16_t cap_start, uint32_t req_val)
+{
+    uint32_t new_val =3D req_val;
+    /* TODO */
+    pci_set_long(pci_dev->config + offset, new_val);
+}
+
+static void lk_ctl_dw4_set(PCIDevice *pci_dev, CCIXState *s, uint16_t of=
fset,
+               uint16_t cap_start, uint32_t req_val)
+{
+    uint32_t new_val =3D req_val;
+    /* TODO */
+    pci_set_long(pci_dev->config + offset, new_val);
+}
+
+static void idm_entry_set(PCIDevice *pci_dev, CCIXState *s, uint16_t off=
set,
+              uint16_t cap_start, uint32_t req_val)
+{
+    /* No sanity checking */
+    printf("Setting idm entry\n");
+    pci_set_long(pci_dev->config + offset, req_val);
+}
+
+static void psam_entry_dw0_set(PCIDevice *pci_dev, CCIXState *s, uint16_=
t offset,
+                   uint16_t cap_start, uint32_t req_val)
+{
+    /* No sanity checking */
+    printf("Setting psam entry dw0\n");
+    pci_set_long(pci_dev->config + offset, req_val);
+}
+
+static void psam_entry_dw1_set(PCIDevice *pci_dev, CCIXState *s, uint16_=
t offset,
+                   uint16_t cap_start, uint32_t req_val)
+{
+    /* No sanity checking */
+    printf("Setting psam entry dw1\n");
+    pci_set_long(pci_dev->config + offset, req_val);
+}
+
+static void psam_entry_dw2_set(PCIDevice *pci_dev, CCIXState *s, uint16_=
t offset,
+                   uint16_t cap_start, uint32_t req_val)
+{
+    /* No sanity checking */
+    printf("Setting psam entry dw2\n");
+    pci_set_long(pci_dev->config + offset, req_val);
+}
+
+
+static void sam_entry_dw0_set(PCIDevice *pci_dev, CCIXState *s, uint16_t=
 offset,
+                  uint16_t cap_start, uint32_t req_val)
+{
+    /* No sanity checking */
+    printf("Setting sam entry dw0\n");
+    pci_set_long(pci_dev->config + offset, req_val);
+}
+
+static void sam_entry_dw1_set(PCIDevice *pci_dev, CCIXState *s, uint16_t=
 offset,
+                  uint16_t cap_start, uint32_t req_val)
+{
+    /* No sanity checking */
+    printf("Setting sam entry dw1\n");
+    pci_set_long(pci_dev->config + offset, req_val);
+}
+
+static void sam_entry_dw2_set(PCIDevice *pci_dev, CCIXState *s, uint16_t=
 offset,
+                  uint16_t cap_start, uint32_t req_val)
+{
+    /* No sanity checking */
+    printf("Setting sam entry dw2\n");
+    pci_set_long(pci_dev->config + offset, req_val);
+}
+
+static void ccix_prl_common_cap(PCIDevice *pci_dev,
+                                CCIXState *s,
+                                uint16_t this_cap_offset,
+                                uint16_t next_cap_offset,
+                                uint16_t device_err_log_offset,
+                                uint16_t idm_table_offset,
+                                uint16_t rsam_offset, uint16_t rsam_size=
,
+                                uint16_t hsam_offset, uint16_t hsam_size=
,
+                                uint16_t sr_table_offset,
+                                uint16_t sw_portal_offset)
+{
+    uint32_t *cap_start =3D (uint32_t *)(pci_dev->config + this_cap_offs=
et);
+    uint32_t multiport_dev_cap;
+
+    /* Put in our first capability */
+    ccix_fill_cap_header(pci_dev, this_cap_offset, CCIX_COMP_ID_PRL_COMM=
ON,
+                         next_cap_offset);
+    /* ComnCapStat1 */
+    if (s->flags & (1 << PRIMARY_PORT_BIT))
+        multiport_dev_cap =3D 0x7;
+    else
+        multiport_dev_cap =3D 0x5;
+
+    *(cap_start + 1) =3D (multiport_dev_cap << CM_CAP_DW1_MULTIPORT_CAP_=
OFF) |
+        (0 << CM_CAP_DW1_VERSION_CAP_OFF) |
+        (0 << CM_CAP_DW1_DEVID_OFF);
+    /* ComnCapStat2 */
+    *(cap_start + 2) =3D (1 << CM_CAP_DW2_DISC_READY_CAP_OFF) |
+        (0 << CM_CAP_DW2_PART_CS_CAP_OFF) |
+        (0 << CM_CAP_DW2_PORT_AG_CAP_OFF) |
+        /* 64 byte only */
+        (0 << CM_CAP_DW2_CL_SIZE_CAP_OFF) |
+        /* 48 bit addressing only */
+        (0 << CM_CAP_DW2_ADDR_W_CAP_OFF) |
+        /* No multihop port aggregation */
+        (0 << CM_CAP_DW2_MH_CAP_OFF) |
+        ((sw_portal_offset ? 1 : 0) << CM_CAP_DW2_SW_PORT_CAP_OFF) |
+        /* Natural alignment over 4GB */
+        (1 << CM_CAP_DW2_SAM_ALIGN_CAP_OFF) |
+        /* random time values */
+        (3 << CM_CAP_DW2_READY_TIME_VAL_OFF) |
+        (1 << CM_CAP_DW2_READY_TIME_SCALE_OFF);
+    /* ComnCapStat3 */
+    *(cap_start + 3) =3D 0;
+    /* Device Error Log Offset */
+    *(cap_start + 4) =3D device_err_log_offset << CM_CAP_DW4_DEV_ERR_LOG=
_OFFSET_OFF;
+    *(cap_start + 5) =3D idm_table_offset << CM_CAP_DW5_IDM_OFFSET_OFF;
+    *(cap_start + 6) =3D (rsam_size << CM_CAP_DW6_RSAM_SIZE_OFF) |
+        (rsam_offset << CM_CAP_DW6_RSAM_OFFSET_OFF);
+    *(cap_start + 7) =3D (hsam_size << CM_CAP_DW7_HSAM_SIZE_OFF) |
+        (hsam_offset << CM_CAP_DW7_HSAM_OFFSET_OFF);
+    *(cap_start + 8) =3D sr_table_offset << CM_CAP_DW8_SR_OFFSET_OFF;
+    *(cap_start + 9) =3D sw_portal_offset << CM_CAP_DW9_SW_PORTAL_OFF;
+}
+
+static void ccix_prl_ra_cap(PCIDevice *pci_dev,
+                            uint16_t this_cap_offset,
+                            uint16_t next_cap_offset,
+                            uint16_t error_log_offset)
+{
+    uint32_t *cap_start =3D (uint32_t *)(pci_dev->config + this_cap_offs=
et);
+
+    ccix_fill_cap_header(pci_dev, this_cap_offset, CCIX_COMP_ID_RA, next=
_cap_offset);
+    *(cap_start + 1) =3D (1 << RA_CAP_DW1_RA_DISC_RDY_STAT_OFF) |
+        /* Some example values follow */
+        (3 << RA_CAP_DW1_RA_CACHE_FLUSH_TIME_VALUE_OFF) |
+        (1 << RA_CAP_DW1_RA_CACHE_FLUSH_TIME_SCALE_OFF) |
+        (0 << RA_CAP_DW1_RA_CACHE_FLUSH_STA_OFF);
+
+    *(cap_start + 2) =3D (error_log_offset << RA_CAP_DW2_RA_ERROR_LOG_OF=
FSET_OFF);
+}
+
+static void ccix_prl_ha_cap(PCIDevice *pci_dev,
+                            uint16_t this_cap_offset,
+                            uint16_t next_cap_offset,
+                            uint16_t error_log_offset,
+                            uint8_t num_ids,
+                            uint8_t num_pools)
+{
+    uint32_t *cap_start =3D (uint32_t *)(pci_dev->config + this_cap_offs=
et);
+    int i;
+
+    ccix_fill_cap_header(pci_dev, this_cap_offset, CCIX_COMP_ID_HA, next=
_cap_offset);
+    *(cap_start + 1) =3D (1 << HA_CAP_DW1_HA_DISC_RD_STAT_OFF) |
+        ((num_ids - 1) << HA_CAP_DW1_NUM_HA_IDS_OFF) |
+        (num_pools << HA_CAP_DW1_HA_MEM_POOL_CAP_OFF) |
+        (0 << HA_CAP_DW1_HA_QACK_OFF) |
+        (0 << HA_CAP_DW1_HA_HW_QACK_CAP_OFF) |
+        (0 << HA_CAP_DW1_HA_MEM_EXP_CAP_OFF) | /* No support for SAs bei=
ng homed here */
+        (0 << HA_CAP_DW1_HA_EVICT_HINT_CAP_OFF) |
+        (0 << HA_CAP_DW1_HA_WRITE_EVICT_FULL_HIT_CAP_OFF) |
+        (3 << HA_CAP_DW1_MEM_POOL_READY_TIME_VALUE_OFF) |
+        (4 << HA_CAP_DW1_MEM_POOL_READY_TIME_SCALE_OFF) |
+        (1 << HA_CAP_DW1_MEM_POOL_READY_STA_OFF);
+    *(cap_start + 2) =3D error_log_offset << HA_CAP_DW2_HA_ERROR_LOG_OFF=
;
+
+    for (i =3D 0; i < num_pools; i++) {
+        *(cap_start + 3 + i * 2) =3D (1 << MEM_POOL_CAP_DW1_READY_STA_OF=
F) |
+            (mem_type_volatile << MEM_POOL_CAP_DW1_GEN_MEM_TYPE_OFF) |
+            (mem_spec_hbm << MEM_POOL_CAP_DW1_SPEC_MEM_TYPE_OFF) |
+            (0 << MEM_POOL_CAP_DW1_ADDR_CAP_OFF) |
+            (MEM_POOL_CAP_DW1_MEM_ATTR_NORMAL << MEM_POOL_CAP_DW1_MEM_AT=
TR_OFF) |
+            (MEM_POOL_CAP_DW1_MEM_EXT_ATTR_NONE << MEM_POOL_CAP_DW1_MEM_=
EXT_ATTR_OFF) |
+            (0xFFFF << MEM_POOL_CAP_DW1_MEM_POOL_SIZE_L_CAP_OFF);
+        *(cap_start + 3 + i * 2 + 1) =3D 0xF << MEM_POOL_CAP_DW2_MEM_POO=
L_SIZE_H_CAP_OFF;
+    }
+}
+
+static void ccix_prl_port_cap(PCIDevice *pci_dev,
+                              CCIXState *s,
+                              uint16_t this_cap_offset,
+                              uint16_t next_cap_offset,
+                              uint16_t error_log_offset)
+{
+    uint32_t *cap_start =3D (uint32_t *)(pci_dev->config + this_cap_offs=
et);
+
+    ccix_fill_cap_header(pci_dev, this_cap_offset, CCIX_COMP_ID_PRL_PORT=
,
+                         next_cap_offset);
+    *(cap_start + 1) =3D (1 << PT_CAP_DW1_DISC_READY_OFF) |
+        (1 << PT_CAP_DW1_OPT_HEADER_OFF) |
+        (0 << PT_CAP_DW1_P2P_FORWARDING_OFF) |
+        (s->num_links << PT_CAP_DW1_LINKS_OFF) |
+        (s->psam_entries << PT_CAP_DW1_PSAM_ENTRIES_OFF) |
+        ((s->port_id & 0xf) << PT_CAP_DW1_PORTID_OFF);
+    *(cap_start + 2) =3D 0; /* No Port AG */
+    *(cap_start + 3) =3D 0; /* No Port FW */
+    *(cap_start + 4) =3D error_log_offset << 20;
+}
+
+static void ccix_prl_link_cap(PCIDevice *pci_dev,
+                              uint16_t this_cap_offset,
+                              uint16_t next_cap_offset,
+                              uint16_t error_log_offset)
+{
+    uint32_t *cap_start =3D (uint32_t *)(pci_dev->config + this_cap_offs=
et);
+
+    ccix_fill_cap_header(pci_dev, this_cap_offset, CCIX_COMP_ID_PRL_LINK=
,
+                         next_cap_offset);
+
+    *(cap_start + 1) =3D (1 << LK_CAP_DW1_DISC_READY_OFF) |
+        (0 << LK_CAP_DW1_CREDIT_TYPE_OFF) |
+        (1 << LK_CAP_DW1_MESSAGE_PACKING_OFF) |
+        (0 << LK_CAP_DW1_NOCOMPACK_OFF) |
+        (2 << LK_CAP_DW1_MAX_PKT_SIZE_OFF);
+
+    *(cap_start + 2) =3D (3 << LK_CAP_DW2_MAX_MEM_REQ_SEND_OFF) |
+        (4 << LK_CAP_DW2_MAX_SNP_REQ_SEND_OFF) |
+        (5 << LK_CAP_DW2_MAX_DAT_REQ_SEND_OFF);
+    *(cap_start + 3) =3D (6 << LK_CAP_DW3_MAX_MEM_REQ_RECV_OFF) |
+        (7 << LK_CAP_DW3_MAX_SNP_REQ_RECV_OFF) |
+        (8 << LK_CAP_DW3_MAX_DAT_REQ_RECV_OFF);
+    *(cap_start + 4) =3D (9 << LK_CAP_DW4_MAX_MISC_REQ_SEND_CAP_OFF) |
+        (10 << LK_CAP_DW4_MAX_MISC_REQ_RECV_CAP_OFF);
+    *(cap_start + 5) =3D error_log_offset << 20;
+}
+
+static void ccix_prl_common_ctl(PCIDevice *pci_dev,
+                                CCIXState *s,
+                                uint16_t this_ctl_offset,
+                                uint16_t next_ctl_offset)
+{
+    uint32_t *ctl_start =3D (uint32_t *)(pci_dev->config + this_ctl_offs=
et);
+
+    ccix_fill_cap_header(pci_dev, this_ctl_offset, CCIX_COMP_ID_PRL_COMM=
ON,
+                         next_ctl_offset);
+    /* ComnCntl1 */
+    *(ctl_start + 1) =3D (0 << CM_CTL_DW1_DEVICE_EN_OFF) |
+        (0 << CM_CTL_DW1_PRIMARY_PORT_EN_OFF) |
+        (0 << CM_CTL_DW1_MESH_EN_OFF) |
+        (0 << CM_CTL_DW1_PORT_AG_EN_OFF) |
+        (0 << CM_CTL_DW1_IDM_TABLE_VALID_OFF) |
+        (0 << CM_CTL_DW1_RSAM_TABLE_VALID_OFF) |
+        (0 << CM_CTL_DW1_HSAM_TABLE_VALID_OFF) |
+        (0 << CM_CTL_DW1_SW_PORT_ENABLE_OFF) |
+        (0 << CM_CTL_DW1_ERR_AGENT_ID_OFF) |
+        (0 << CM_CTL_DW1_DEVID_OFF);
+    am_table_add(pci_dev, s, this_ctl_offset + 4, this_ctl_offset, comnc=
ntl1_set);
+    s->enable_offset =3D this_ctl_offset + 4;
+    /* ComnCtl2 */
+    *(ctl_start + 2) =3D 0; // No support for anything in here yet.
+    am_table_add(pci_dev, s, this_ctl_offset + 8, this_ctl_offset, comnc=
ntl2_set);
+    /* No snoop request hash mask yet */
+    /* No SW Service Portal yet */
+}
+
+static void ccix_prl_ra_ctl(PCIDevice *pci_dev,
+                            CCIXState *s,
+                            uint16_t this_ctl_offset,
+                            uint16_t next_ctl_offset,
+                            uint16_t ra_id)
+{
+    uint32_t *ctl_start =3D (uint32_t *)(pci_dev->config + this_ctl_offs=
et);
+
+    ccix_fill_cap_header(pci_dev, this_ctl_offset, CCIX_COMP_ID_RA,
+                         next_ctl_offset);
+
+    *(ctl_start + 1) =3D (0 << RA_CTL_DW1_EN_OFF) |
+        (0 << RA_CTL_DW1_SNOOP_RESP_EN_OFF) |
+        (0 << RA_CTL_DW1_CACHE_FLUSH_EN_OFF) |
+        (0 << RA_CTL_DW1_CACHE_EN_OFF) |
+        (0 << RA_CTL_DW1_RAID_OFF);
+    am_table_add(pci_dev, s, this_ctl_offset + 4, this_ctl_offset, ra_ct=
l_dw1_set);
+}
+
+static void ccix_prl_ha_ctl(PCIDevice *pci_dev,
+                            CCIXState *s,
+                            uint16_t this_ctl_offset,
+                            uint16_t next_ctl_offset,
+                            uint16_t num_ids,
+                            uint16_t num_pools)
+{
+    uint32_t *ctl_start =3D (uint32_t *)(pci_dev->config + this_ctl_offs=
et);
+
+    ccix_fill_cap_header(pci_dev, this_ctl_offset, CCIX_COMP_ID_HA,
+                         next_ctl_offset);
+    *(ctl_start + 1) =3D 0;
+}
+
+static void ccix_prl_port_ctl(PCIDevice *pci_dev,
+                              CCIXState *s,
+                              uint16_t this_ctl_offset,
+                              uint16_t next_ctl_offset,
+                              uint8_t psam_table_entries)
+{
+    uint8_t i;
+    uint32_t *ctl_start =3D (uint32_t *)(pci_dev->config + this_ctl_offs=
et);
+
+    ccix_fill_cap_header(pci_dev, this_ctl_offset, CCIX_COMP_ID_PRL_PORT=
,
+                         next_ctl_offset);
+    /* Port Control */
+    *(ctl_start + 1) =3D 0;
+    am_table_add(pci_dev, s, this_ctl_offset + 4, this_ctl_offset, port_=
ctl_dw1_set);
+
+    for (i =3D 0; i < psam_table_entries; i++) {
+        am_table_add(pci_dev, s, this_ctl_offset + 0x14 + (3 * i + 0) * =
4,
+                     0, psam_entry_dw0_set);
+        am_table_add(pci_dev, s, this_ctl_offset + 0x14 + (3 * i + 1) * =
4,
+                     0, psam_entry_dw1_set);
+        am_table_add(pci_dev, s, this_ctl_offset + 0x14 + (3 * i + 2) * =
4,
+                     0, psam_entry_dw2_set);
+    }
+}
+
+static void ccix_prl_link_ctl(PCIDevice *pci_dev,
+                              CCIXState *s,
+                              uint16_t this_ctl_offset,
+                              uint16_t next_ctl_offset,
+                              uint8_t num_links)
+{
+    uint32_t *ctl_start =3D (uint32_t *)(pci_dev->config + this_ctl_offs=
et);
+    uint8_t i;
+
+    ccix_fill_cap_header(pci_dev, this_ctl_offset, CCIX_COMP_ID_PRL_LINK=
,
+        next_ctl_offset);
+
+    for (i =3D 0; i < num_links; i++) {
+        /* LinkAttrCntl for link i */
+        *(ctl_start + 1 + i * 6) =3D 0;
+        am_table_add(pci_dev, s, this_ctl_offset + 4 + i * 24, 0, lk_ctl=
_dw1_set);
+        /* LinkMaxCreditCntl for link i */
+        *(ctl_start + 1 + i * 6 + 1) =3D 0;
+        am_table_add(pci_dev, s, this_ctl_offset + 4 + i * 24 + 4, 0, lk=
_ctl_dw2_set);
+        *(ctl_start + 1 + i * 6 + 2) =3D 0;
+        am_table_add(pci_dev, s, this_ctl_offset + 4 + i * 24 + 8, 0, lk=
_ctl_dw3_set);
+        *(ctl_start + 1 + i * 6 + 3) =3D 0;
+        am_table_add(pci_dev, s, this_ctl_offset + 4 + i * 24 + 0xC, 0, =
lk_ctl_dw4_set);
+
+        /* error fields - to do */
+        *(ctl_start + 1 + i * 24 + 4) =3D 0;
+        *(ctl_start + 1 + i * 24 + 5) =3D 0;
+    }
+    /* transport id */
+    for (i =3D 0; i < num_links; i++)
+        //to check
+        *(ctl_start + 1 + num_links * 6 + 4 * i) =3D 0;
+}
+
+static void ccix_idm(PCIDevice *pci_dev, CCIXState *s, uint16_t offset)
+{
+    int i;
+
+    for (i =3D 0; i < 64; i++)
+        am_table_add(pci_dev, s, offset + i * 4, 0, idm_entry_set);
+}
+
+static void ccix_sam(PCIDevice *pci_dev, CCIXState *s, uint16_t offset, =
uint8_t entries)
+{
+    int i;
+
+    for (i =3D 0; i < entries; i++) {
+        am_table_add(pci_dev, s, offset + 3 * i * 4, 0, sam_entry_dw0_se=
t);
+        am_table_add(pci_dev, s, offset + (3 * i + 1) * 4, 0, sam_entry_=
dw1_set);
+        am_table_add(pci_dev, s, offset + (3 * i + 2) * 4, 0, sam_entry_=
dw2_set);
+    }
+}
+static void ccix_guid(PCIDevice *pci_dev, uint16_t offset)
+{
+    uint32_t *start =3D (uint32_t *)(pci_dev->config + offset);
+
+    *(start) =3D CCIX_GUID_DW0;
+    *(start + 1) =3D CCIX_GUID_DW1;
+    *(start + 2) =3D CCIX_GUID_DW2;
+    *(start + 3) =3D CCIX_GUID_DW3;
+    *(start + 4) =3D 1 << CCIX_GUID_DW4_VERSION_OFF;
+}
+
+/*FIXME: Is this generic enough that we should put it in the PCIe core *=
/
+
+#define CCIX_DVSEC_HEADER_SIZE   0x14
+#define PCIE_DVSEC_HEADER_OFFSET 0x4 /* Offset from start of extend cap =
*/
+#define PCIE_DVSEC_ID_OFFSET     0x8
+static void pcie_add_dvsec(PCIDevice *pci_dev, uint16_t offset,
+                           uint16_t size, uint16_t vendor_id, uint16_t d=
vsec_id,
+                           uint16_t ccix_guid_offset)
+{
+    uint16_t *word_addr;
+
+    pcie_add_capability(pci_dev, PCI_EXT_CAP_ID_DVSEC, 1, offset, size);
+    pci_set_word(pci_dev->config + offset + PCIE_DVSEC_HEADER_OFFSET,
+                 vendor_id);
+    word_addr =3D (uint16_t *)(pci_dev->config + offset + PCIE_DVSEC_HEA=
DER_OFFSET + 2);
+    *word_addr =3D 0x1 | (size << 4);
+
+    word_addr =3D (uint16_t *)(pci_dev->config + offset + PCIE_DVSEC_ID_=
OFFSET);
+    *word_addr =3D dvsec_id;
+    word_addr =3D (uint16_t *)(pci_dev->config + offset + PCIE_DVSEC_ID_=
OFFSET + 2);
+    *word_addr =3D (ccix_guid_offset << 4);
+}
+
+void ccix_set_port(CCIXState *s)
+{
+    s->flags |=3D (1 << CCIX_IS_PORT);
+    /* Enforce rule of how many psam entries if links is greater than 1 =
*/
+    if ((s->num_links > 1) &&
+        (s->psam_entries < s->num_links + 1)) {
+        printf("Increased psam entries to minimum allowed\n");
+        s->psam_entries =3D s->num_links + 1;
+    }
+}
+
+enum  ccix_entry_type {
+    common_cap,
+    ra_cap,
+    ha_cap,
+    port_cap,
+    link_cap,
+    end_cap,
+    common_ctl,
+    ra_ctl,
+    ha_ctl,
+    port_ctl,
+    link_ctl,
+    end_ctl,
+    idm_table,
+    sr_table,
+    rsam,
+    hsam,
+    guid,
+};
+
+struct ccix_cap {
+    uint16_t size;
+    uint16_t offset;
+    enum ccix_entry_type type;
+};
+
+static void ccix_add_cap(GList **l, enum ccix_entry_type type, uint16_t =
size)
+{
+    struct ccix_cap *c;
+   =20
+    c =3D malloc(sizeof(*c));
+    c->type =3D type;
+    c->size =3D size;
+    *l =3D g_list_append(*l, c);
+}
+
+uint16_t ccix_add_prldvsec(PCIDevice *pci_dev, CCIXState *s, uint16_t of=
fset)
+{
+    /* Runtime configuration of the following is not yet implemented */
+    uint16_t ha_num_pools =3D 2;
+    uint16_t ha_num_ids =3D 8;
+    /* Error log not yet implemented */
+    uint16_t error_log_offset =3D 0;
+    uint16_t idm_offset =3D 0;
+    uint16_t sr_offset =3D 0;
+    uint16_t rsam_offset =3D 0;
+    uint16_t hsam_offset =3D 0;
+    uint16_t guid_offset =3D 0;
+    uint16_t max_offset =3D 0;
+    uint16_t next_offset;
+    uint16_t cap_size =3D 0;
+    uint16_t cap_offset;
+    uint16_t ctl_size =3D 0;
+    uint16_t ctl_offset;
+    struct ccix_cap *c;
+    GList *li;
+    GList *cap_list =3D NULL;
+    GList *ctl_list =3D NULL;
+    GList *other_list =3D NULL;
+    int i;
+
+    /*
+     * Build up lists of the CCIX capabilities, controls and other block=
s so that we
+     * can work out their layout in config space before writing the head=
er.
+     */
+    ccix_add_cap(&cap_list, common_cap, CCIX_COMMON_CAP_MAX_SIZE);
+    if (s->flags & (1 << PRIMARY_PORT_BIT))
+            ccix_add_cap(&ctl_list, common_ctl, 0x10);
+    for (i =3D 0; i < s->num_ras; i++) {
+        ccix_add_cap(&cap_list, ra_cap, CCIX_RA_CAP_SIZE);
+        ccix_add_cap(&ctl_list, ra_ctl, CCIX_RA_CTL_SIZE);
+    }
+    for (i =3D 0; i < s->num_has; i++) {
+        ccix_add_cap(&cap_list, ha_cap, CCIX_HA_CAP_SIZE + CCIX_POOL_CAP=
_SIZE * ha_num_pools);
+        ccix_add_cap(&ctl_list, ha_ctl,
+                     CCIX_HA_CTL_SIZE +
+                     (ha_num_ids + 3) / 4 * CCIX_HAID_ENTRY_SIZE +
+                     ha_num_pools * CCIX_BAT_ENTRY_SIZE);
+    }
+
+    /* Only functions with CCIX ports may have port and link structures =
*/
+    if (s->flags & (1 << CCIX_IS_PORT)) {
+        ccix_add_cap(&cap_list, port_cap, CCIX_PORT_CAP_SIZE);
+        ccix_add_cap(&ctl_list, port_ctl,
+                     CCIX_PORT_CTL_SIZE + 12 * s->psam_entries);
+        ccix_add_cap(&cap_list, link_cap, CCIX_LINK_CAP_SIZE);
+        ccix_add_cap(&ctl_list, link_ctl,
+                     CCIX_LINK_CTL_SIZE + CCIX_LINK_CTL_PER_LINK_SIZE * =
s->num_links);
+    }
+
+    if (s->flags & (1 << PRIMARY_PORT_BIT)) {
+        ccix_add_cap(&other_list, idm_table, 64 * 4);
+        if (s->rsam_entries)
+            ccix_add_cap(&other_list, rsam, CCIX_SAM_ENTRY_SIZE * s->rsa=
m_entries);
+        if (s->hsam_entries)
+            ccix_add_cap(&other_list, hsam, CCIX_SAM_ENTRY_SIZE * s->hsa=
m_entries);
+        ccix_add_cap(&other_list, guid, CCIX_GUID_SIZE);
+    }
+   =20
+    cap_offset =3D offset + CCIX_DVSEC_HEADER_SIZE;
+    next_offset =3D cap_offset;
+    for (li =3D cap_list; li !=3D NULL; li =3D li->next) {
+        c =3D (struct ccix_cap *)li->data;
+        c->offset =3D next_offset;
+        if (li->next =3D=3D NULL)
+            next_offset =3D 0;
+        else {
+            next_offset =3D c->offset + c->size;
+        }
+        cap_size +=3D c->size;
+        max_offset =3D c->offset + c->size;
+    }
+   =20
+    next_offset =3D max_offset;
+    ctl_offset =3D max_offset;
+    for (li =3D ctl_list; li !=3D NULL; li =3D li->next) {
+        c =3D (struct ccix_cap *)li->data;
+        c->offset =3D next_offset;
+        if (li->next =3D=3D NULL)
+            next_offset =3D 0;
+        else
+            next_offset =3D c->offset + c->size;
+
+        max_offset =3D c->offset + c->size;
+        ctl_size +=3D c->size;
+    }
+
+    next_offset =3D max_offset;
+    for (li =3D other_list; li !=3D NULL; li =3D li->next) {
+        c =3D (struct ccix_cap *)li->data;
+        c->offset =3D next_offset;
+        switch (c->type) {
+        case
+            idm_table: idm_offset =3D c->offset;
+            break;
+        case sr_table:
+            sr_offset =3D c->offset;
+            break;
+        case hsam:
+            hsam_offset =3D c->offset;
+            break;
+        case rsam:
+            rsam_offset =3D c->offset;
+            break;
+        case guid:
+            guid_offset =3D c->offset;
+            break;
+        default:
+            break;
+        }
+        if (li->next =3D=3D NULL)
+            next_offset =3D 0;
+        else
+            next_offset =3D c->offset + c->size;
+        max_offset =3D c->offset + c->size;
+    }
+
+    /* Will eventually take some description and make a prl. For now one=
 RA */
+    pcie_add_dvsec(pci_dev, offset, max_offset - offset, PCI_VENDOR_ID_C=
CIX,
+                   CCIX_COMP_ID_PRL_DVSEC, guid_offset);
+   =20
+    ccix_dvsec_fill_dvsec_header(pci_dev, offset, cap_size, cap_offset,
+                                 ctl_size, ctl_offset);
+
+    for (li =3D cap_list; li !=3D NULL; li =3D li->next) {
+        c =3D (struct ccix_cap *)li->data;
+        if (li->next)
+            next_offset =3D ((struct ccix_cap *)(li->next->data))->offse=
t;
+        else
+            next_offset =3D 0;
+        switch (c->type) {
+        case common_cap:
+            ccix_prl_common_cap(pci_dev, s, c->offset, next_offset,
+                                0, /* No support for device error log */
+                                idm_offset,
+                                rsam_offset, CCIX_SAM_ENTRY_SIZE * s->rs=
am_entries,
+                                hsam_offset, CCIX_SAM_ENTRY_SIZE * s->hs=
am_entries,
+                                sr_offset,
+                                0 /* No support for sw portal */);
+               break;
+        case ra_cap:
+            ccix_prl_ra_cap(pci_dev, c->offset, next_offset, error_log_o=
ffset);
+            break;
+        case ha_cap:
+            ccix_prl_ha_cap(pci_dev, c->offset, next_offset, error_log_o=
ffset,
+                            ha_num_ids, ha_num_pools);
+            break;
+        case port_cap:
+            ccix_prl_port_cap(pci_dev, s, c->offset, next_offset, error_=
log_offset);
+            break;
+        case link_cap:
+            ccix_prl_link_cap(pci_dev, c->offset, next_offset, error_log=
_offset);
+            break;
+        default:
+            break;
+        }
+    }
+
+    for (li =3D ctl_list; li !=3D NULL; li =3D li->next) {
+        c =3D (struct ccix_cap *)li->data;
+        if (li->next)
+            next_offset =3D ((struct ccix_cap *)(li->next->data))->offse=
t;
+        else
+            next_offset =3D0;
+        switch (c->type) {
+        case common_ctl:
+            ccix_prl_common_ctl(pci_dev, s, c->offset, next_offset);
+            break;
+        case ra_ctl:
+            ccix_prl_ra_ctl(pci_dev, s, c->offset, next_offset, 0);
+            break;
+        case ha_ctl:
+            ccix_prl_ha_ctl(pci_dev, s, c->offset, next_offset, ha_num_i=
ds, ha_num_pools);
+            break;
+        case port_ctl:
+            ccix_prl_port_ctl(pci_dev, s, c->offset, next_offset, s->psa=
m_entries);
+            break;
+        case link_ctl:
+            ccix_prl_link_ctl(pci_dev, s, c->offset, next_offset, s->num=
_links);
+            break;
+        default:
+            break;
+        }
+    }
+
+    for (li =3D other_list; li !=3D NULL; li =3D li->next) {
+        c =3D (struct ccix_cap *)li->data;
+        switch(c->type) {
+            case idm_table:
+                ccix_idm(pci_dev, s, c->offset);
+                break;
+            case sr_table:
+                ccix_idm(pci_dev, s, c->offset);
+                break;
+            case rsam:
+                ccix_sam(pci_dev, s, c->offset, s->rsam_entries);
+                break;
+            case hsam:
+                ccix_sam(pci_dev, s, c->offset, s->hsam_entries);
+                break;
+            case guid:
+                ccix_guid(pci_dev, c->offset);
+                break;
+            default:
+                break;
+        }
+    }
+    return max_offset;
+}
+
+uint16_t ccix_add_tdldvsec(PCIDevice *pci_dev, uint16_t offset)
+{
+    const uint16_t dvsec_size =3D 17 * sizeof(uint32_t);
+
+    pcie_add_dvsec(pci_dev, offset, dvsec_size, PCI_VENDOR_ID_CCIX,
+                   CCIX_COMP_ID_TDL_DVSEC, 0);
+
+    return offset + dvsec_size;
+}
+
+void ccix_register(CCIXState *s)
+{
+    int i;
+
+    if (s->ccix_dev_name)
+        for (i =3D 0; i < sizeof(CCIXFuncs)/sizeof(*CCIXFuncs); i++)
+            if (!CCIXFuncs[i]) {
+                CCIXFuncs[i] =3D s;
+                break;
+            }
+}
diff --git a/include/hw/misc/ccix.h b/include/hw/misc/ccix.h
new file mode 100644
index 0000000000..94aa904b53
--- /dev/null
+++ b/include/hw/misc/ccix.h
@@ -0,0 +1,28 @@
+
+#include "hw/pci/pcie_port.h"
+typedef struct CCIXState {
+    GTree *am_tree;
+#define PRIMARY_PORT_BIT 0
+#define CCIX_IS_PORT 1
+    uint32_t flags;
+    char *ccix_dev_name;
+    uint8_t port_id;
+    uint8_t num_links;
+    uint8_t psam_entries;
+    uint8_t num_ras;
+    uint8_t num_has;
+    uint8_t rsam_entries;
+    uint8_t hsam_entries;
+    PCIDevice *pci_dev;
+    uint16_t enable_offset;
+} CCIXState;
+
+extern CCIXState *CCIXFuncs[256];
+
+uint16_t ccix_add_prldvsec(PCIDevice *pci_dev, CCIXState *s, uint16_t of=
fset);
+void ccix_write_config(PCIDevice *pci_dev, CCIXState *s, uint32_t addr, =
uint32_t val_in, int l);
+uint16_t ccix_add_tdldvsec(PCIDevice *pci_dev, uint16_t offset);
+void initialize_ccixstate(CCIXState *s, PCIDevice *pci_dev);
+void ccix_register(CCIXState *s);
+
+void ccix_set_port(CCIXState *s);
diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
index f49be07328..19675fdac1 100644
--- a/include/hw/pci/pci_ids.h
+++ b/include/hw/pci/pci_ids.h
@@ -225,6 +225,8 @@
 #define PCI_DEVICE_ID_HUAWEI_CCIX_DOWN   0xA261
 #define PCI_DEVICE_ID_HUAWEI_CCIX_EP     0xA262
=20
+#define PCI_VENDOR_ID_CCIX               0x1e2c
+
 #define PCI_VENDOR_ID_INTEL              0x8086
 #define PCI_DEVICE_ID_INTEL_82378        0x0484
 #define PCI_DEVICE_ID_INTEL_82441        0x1237
--=20
2.20.1


