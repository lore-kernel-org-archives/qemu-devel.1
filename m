Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CACAC11D24
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:40:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 279E4208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="WKWi38WS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 279E4208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4zB1-0007Q3-V7
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 22:40:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j4z7r-00022l-Ad
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:37:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j4z7p-00088W-8v
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:37:15 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:53643 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j4z7o-0007yB-Co; Thu, 20 Feb 2020 22:37:13 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48NxwD3lRDz9sSN; Fri, 21 Feb 2020 14:37:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582256220;
 bh=s1aluvXNNbYdJsnoIMZtdcy8rZMNeRwJBzY+4SuKnO0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WKWi38WSe9Sp+kRq6flY3TDctfukpAXQi192V7FxuOmY3XO2T0dI+a1rOBHeIjC8K
 PSqdxbnPO4G1vjoRZvh5Ch58Ki10Kxn9NzRAcOgbkkOYv1HJcjjZOKzlGZXhJEcUqa
 eRzMpQYXAsOxNJ6PKXqXOAs6MNhZCOYhWxQVk2sM=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 08/20] spapr: Add Hcalls to support PAPR NVDIMM device
Date: Fri, 21 Feb 2020 14:36:38 +1100
Message-Id: <20200221033650.444386-9-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221033650.444386-1-david@gibson.dropbear.id.au>
References: <20200221033650.444386-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: lvivier@redhat.com, Shivaprasad G Bhat <sbhat@linux.ibm.com>, aik@ozlabs.ru,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Shivaprasad G Bhat <sbhat@linux.ibm.com>

This patch implements few of the necessary hcalls for the nvdimm support.

PAPR semantics is such that each NVDIMM device is comprising of multiple
SCM(Storage Class Memory) blocks. The guest requests the hypervisor to
bind each of the SCM blocks of the NVDIMM device using hcalls. There can
be SCM block unbind requests in case of driver errors or unplug(not
supported now) use cases. The NVDIMM label read/writes are done through
hcalls.

Since each virtual NVDIMM device is divided into multiple SCM blocks,
the bind, unbind, and queries using hcalls on those blocks can come
independently. This doesn't fit well into the qemu device semantics,
where the map/unmap are done at the (whole)device/object level granularit=
y.
The patch doesnt actually bind/unbind on hcalls but let it happen at the
device_add/del phase itself instead.

The guest kernel makes bind/unbind requests for the virtual NVDIMM device
at the region level granularity. Without interleaving, each virtual NVDIM=
M
device is presented as a separate guest physical address range. So, there
is no way a partial bind/unbind request can come for the vNVDIMM in a
hcall for a subset of SCM blocks of a virtual NVDIMM. Hence it is safe to
do bind/unbind everything during the device_add/del.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Message-Id: <158131059899.2897.11515211602702956854.stgit@lep8c.aus.stgla=
bs.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_nvdimm.c  | 298 +++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |   8 +-
 2 files changed, 305 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index d03c8d3a5c..74eeb8bb74 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -28,6 +28,7 @@
 #include "hw/mem/nvdimm.h"
 #include "qemu/nvdimm-utils.h"
 #include "hw/ppc/fdt.h"
+#include "qemu/range.h"
=20
 void spapr_nvdimm_validate_opts(NVDIMMDevice *nvdimm, uint64_t size,
                                 Error **errp)
@@ -175,3 +176,300 @@ void spapr_dt_persistent_memory(void *fdt)
=20
     return;
 }
+
+static target_ulong h_scm_read_metadata(PowerPCCPU *cpu,
+                                        SpaprMachineState *spapr,
+                                        target_ulong opcode,
+                                        target_ulong *args)
+{
+    uint32_t drc_index =3D args[0];
+    uint64_t offset =3D args[1];
+    uint64_t len =3D args[2];
+    SpaprDrc *drc =3D spapr_drc_by_index(drc_index);
+    NVDIMMDevice *nvdimm;
+    NVDIMMClass *ddc;
+    uint64_t data =3D 0;
+    uint8_t buf[8] =3D { 0 };
+
+    if (!drc || !drc->dev ||
+        spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PMEM) {
+        return H_PARAMETER;
+    }
+
+    if (len !=3D 1 && len !=3D 2 &&
+        len !=3D 4 && len !=3D 8) {
+        return H_P3;
+    }
+
+    nvdimm =3D NVDIMM(drc->dev);
+    if ((offset + len < offset) ||
+        (nvdimm->label_size < len + offset)) {
+        return H_P2;
+    }
+
+    ddc =3D NVDIMM_GET_CLASS(nvdimm);
+    ddc->read_label_data(nvdimm, buf, len, offset);
+
+    switch (len) {
+    case 1:
+        data =3D ldub_p(buf);
+        break;
+    case 2:
+        data =3D lduw_be_p(buf);
+        break;
+    case 4:
+        data =3D ldl_be_p(buf);
+        break;
+    case 8:
+        data =3D ldq_be_p(buf);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    args[0] =3D data;
+
+    return H_SUCCESS;
+}
+
+static target_ulong h_scm_write_metadata(PowerPCCPU *cpu,
+                                         SpaprMachineState *spapr,
+                                         target_ulong opcode,
+                                         target_ulong *args)
+{
+    uint32_t drc_index =3D args[0];
+    uint64_t offset =3D args[1];
+    uint64_t data =3D args[2];
+    uint64_t len =3D args[3];
+    SpaprDrc *drc =3D spapr_drc_by_index(drc_index);
+    NVDIMMDevice *nvdimm;
+    NVDIMMClass *ddc;
+    uint8_t buf[8] =3D { 0 };
+
+    if (!drc || !drc->dev ||
+        spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PMEM) {
+        return H_PARAMETER;
+    }
+
+    if (len !=3D 1 && len !=3D 2 &&
+        len !=3D 4 && len !=3D 8) {
+        return H_P4;
+    }
+
+    nvdimm =3D NVDIMM(drc->dev);
+    if ((offset + len < offset) ||
+        (nvdimm->label_size < len + offset)) {
+        return H_P2;
+    }
+
+    switch (len) {
+    case 1:
+        if (data & 0xffffffffffffff00) {
+            return H_P2;
+        }
+        stb_p(buf, data);
+        break;
+    case 2:
+        if (data & 0xffffffffffff0000) {
+            return H_P2;
+        }
+        stw_be_p(buf, data);
+        break;
+    case 4:
+        if (data & 0xffffffff00000000) {
+            return H_P2;
+        }
+        stl_be_p(buf, data);
+        break;
+    case 8:
+        stq_be_p(buf, data);
+        break;
+    default:
+            g_assert_not_reached();
+    }
+
+    ddc =3D NVDIMM_GET_CLASS(nvdimm);
+    ddc->write_label_data(nvdimm, buf, len, offset);
+
+    return H_SUCCESS;
+}
+
+static target_ulong h_scm_bind_mem(PowerPCCPU *cpu, SpaprMachineState *s=
papr,
+                                   target_ulong opcode, target_ulong *ar=
gs)
+{
+    uint32_t drc_index =3D args[0];
+    uint64_t starting_idx =3D args[1];
+    uint64_t no_of_scm_blocks_to_bind =3D args[2];
+    uint64_t target_logical_mem_addr =3D args[3];
+    uint64_t continue_token =3D args[4];
+    uint64_t size;
+    uint64_t total_no_of_scm_blocks;
+    SpaprDrc *drc =3D spapr_drc_by_index(drc_index);
+    hwaddr addr;
+    NVDIMMDevice *nvdimm;
+
+    if (!drc || !drc->dev ||
+        spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PMEM) {
+        return H_PARAMETER;
+    }
+
+    /*
+     * Currently continue token should be zero qemu has already bound
+     * everything and this hcall doesnt return H_BUSY.
+     */
+    if (continue_token > 0) {
+        return H_P5;
+    }
+
+    /* Currently qemu assigns the address. */
+    if (target_logical_mem_addr !=3D 0xffffffffffffffff) {
+        return H_OVERLAP;
+    }
+
+    nvdimm =3D NVDIMM(drc->dev);
+
+    size =3D object_property_get_uint(OBJECT(nvdimm),
+                                    PC_DIMM_SIZE_PROP, &error_abort);
+
+    total_no_of_scm_blocks =3D size / SPAPR_MINIMUM_SCM_BLOCK_SIZE;
+
+    if (starting_idx > total_no_of_scm_blocks) {
+        return H_P2;
+    }
+
+    if (((starting_idx + no_of_scm_blocks_to_bind) < starting_idx) ||
+        ((starting_idx + no_of_scm_blocks_to_bind) > total_no_of_scm_blo=
cks)) {
+        return H_P3;
+    }
+
+    addr =3D object_property_get_uint(OBJECT(nvdimm),
+                                    PC_DIMM_ADDR_PROP, &error_abort);
+
+    addr +=3D starting_idx * SPAPR_MINIMUM_SCM_BLOCK_SIZE;
+
+    /* Already bound, Return target logical address in R5 */
+    args[1] =3D addr;
+    args[2] =3D no_of_scm_blocks_to_bind;
+
+    return H_SUCCESS;
+}
+
+static target_ulong h_scm_unbind_mem(PowerPCCPU *cpu, SpaprMachineState =
*spapr,
+                                     target_ulong opcode, target_ulong *=
args)
+{
+    uint32_t drc_index =3D args[0];
+    uint64_t starting_scm_logical_addr =3D args[1];
+    uint64_t no_of_scm_blocks_to_unbind =3D args[2];
+    uint64_t continue_token =3D args[3];
+    uint64_t size_to_unbind;
+    Range blockrange =3D range_empty;
+    Range nvdimmrange =3D range_empty;
+    SpaprDrc *drc =3D spapr_drc_by_index(drc_index);
+    NVDIMMDevice *nvdimm;
+    uint64_t size, addr;
+
+    if (!drc || !drc->dev ||
+        spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PMEM) {
+        return H_PARAMETER;
+    }
+
+    /* continue_token should be zero as this hcall doesn't return H_BUSY=
. */
+    if (continue_token > 0) {
+        return H_P4;
+    }
+
+    /* Check if starting_scm_logical_addr is block aligned */
+    if (!QEMU_IS_ALIGNED(starting_scm_logical_addr,
+                         SPAPR_MINIMUM_SCM_BLOCK_SIZE)) {
+        return H_P2;
+    }
+
+    size_to_unbind =3D no_of_scm_blocks_to_unbind * SPAPR_MINIMUM_SCM_BL=
OCK_SIZE;
+    if (no_of_scm_blocks_to_unbind =3D=3D 0 || no_of_scm_blocks_to_unbin=
d !=3D
+                               size_to_unbind / SPAPR_MINIMUM_SCM_BLOCK_=
SIZE) {
+        return H_P3;
+    }
+
+    nvdimm =3D NVDIMM(drc->dev);
+    size =3D object_property_get_int(OBJECT(nvdimm), PC_DIMM_SIZE_PROP,
+                                   &error_abort);
+    addr =3D object_property_get_int(OBJECT(nvdimm), PC_DIMM_ADDR_PROP,
+                                   &error_abort);
+
+    range_init_nofail(&nvdimmrange, addr, size);
+    range_init_nofail(&blockrange, starting_scm_logical_addr, size_to_un=
bind);
+
+    if (!range_contains_range(&nvdimmrange, &blockrange)) {
+        return H_P3;
+    }
+
+    args[1] =3D no_of_scm_blocks_to_unbind;
+
+    /* let unplug take care of actual unbind */
+    return H_SUCCESS;
+}
+
+#define H_UNBIND_SCOPE_ALL 0x1
+#define H_UNBIND_SCOPE_DRC 0x2
+
+static target_ulong h_scm_unbind_all(PowerPCCPU *cpu, SpaprMachineState =
*spapr,
+                                     target_ulong opcode, target_ulong *=
args)
+{
+    uint64_t target_scope =3D args[0];
+    uint32_t drc_index =3D args[1];
+    uint64_t continue_token =3D args[2];
+    NVDIMMDevice *nvdimm;
+    uint64_t size;
+    uint64_t no_of_scm_blocks_unbound =3D 0;
+
+    /* continue_token should be zero as this hcall doesn't return H_BUSY=
. */
+    if (continue_token > 0) {
+        return H_P4;
+    }
+
+    if (target_scope =3D=3D H_UNBIND_SCOPE_DRC) {
+        SpaprDrc *drc =3D spapr_drc_by_index(drc_index);
+
+        if (!drc || !drc->dev ||
+            spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PMEM) {
+            return H_P2;
+        }
+
+        nvdimm =3D NVDIMM(drc->dev);
+        size =3D object_property_get_int(OBJECT(nvdimm), PC_DIMM_SIZE_PR=
OP,
+                                       &error_abort);
+
+        no_of_scm_blocks_unbound =3D size / SPAPR_MINIMUM_SCM_BLOCK_SIZE=
;
+    } else if (target_scope =3D=3D  H_UNBIND_SCOPE_ALL) {
+        GSList *list, *nvdimms;
+
+        nvdimms =3D nvdimm_get_device_list();
+        for (list =3D nvdimms; list; list =3D list->next) {
+            nvdimm =3D list->data;
+            size =3D object_property_get_int(OBJECT(nvdimm), PC_DIMM_SIZ=
E_PROP,
+                                           &error_abort);
+
+            no_of_scm_blocks_unbound +=3D size / SPAPR_MINIMUM_SCM_BLOCK=
_SIZE;
+        }
+        g_slist_free(nvdimms);
+    } else {
+        return H_PARAMETER;
+    }
+
+    args[1] =3D no_of_scm_blocks_unbound;
+
+    /* let unplug take care of actual unbind */
+    return H_SUCCESS;
+}
+
+static void spapr_scm_register_types(void)
+{
+    /* qemu/scm specific hcalls */
+    spapr_register_hypercall(H_SCM_READ_METADATA, h_scm_read_metadata);
+    spapr_register_hypercall(H_SCM_WRITE_METADATA, h_scm_write_metadata)=
;
+    spapr_register_hypercall(H_SCM_BIND_MEM, h_scm_bind_mem);
+    spapr_register_hypercall(H_SCM_UNBIND_MEM, h_scm_unbind_mem);
+    spapr_register_hypercall(H_SCM_UNBIND_ALL, h_scm_unbind_all);
+}
+
+type_init(spapr_scm_register_types)
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index a1fba95c82..d557fc1f35 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -300,6 +300,7 @@ struct SpaprMachineState {
 #define H_P7              -60
 #define H_P8              -61
 #define H_P9              -62
+#define H_OVERLAP         -68
 #define H_UNSUPPORTED_FLAG -256
 #define H_MULTI_THREADS_ACTIVE -9005
=20
@@ -507,8 +508,13 @@ struct SpaprMachineState {
 #define H_INT_ESB               0x3C8
 #define H_INT_SYNC              0x3CC
 #define H_INT_RESET             0x3D0
+#define H_SCM_READ_METADATA     0x3E4
+#define H_SCM_WRITE_METADATA    0x3E8
+#define H_SCM_BIND_MEM          0x3EC
+#define H_SCM_UNBIND_MEM        0x3F0
+#define H_SCM_UNBIND_ALL        0x3FC
=20
-#define MAX_HCALL_OPCODE        H_INT_RESET
+#define MAX_HCALL_OPCODE        H_SCM_UNBIND_ALL
=20
 /* The hcalls above are standardized in PAPR and implemented by pHyp
  * as well.
--=20
2.24.1


