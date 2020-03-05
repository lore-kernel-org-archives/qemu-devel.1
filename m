Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1626CC3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 19:47:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D26D020848
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 19:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26D020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9wT8-0003Tb-2i
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 14:47:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1j9wKl-0007PP-Qe
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:39:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.vnet.ibm.com>) id 1j9wKj-0005Gx-7G
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:39:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26738)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1j9wKi-0005FY-Um
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:39:01 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 025JK2e0114506; Thu, 5 Mar 2020 14:38:59 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yk4jp6qn6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2020 14:38:59 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 025JK9vg115211;
 Thu, 5 Mar 2020 14:38:58 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yk4jp6qm5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2020 14:38:58 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 025JcbcU020265;
 Thu, 5 Mar 2020 19:38:57 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma05wdc.us.ibm.com with ESMTP id 2yffk6wt41-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2020 19:38:57 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 025JcujJ54198698
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Mar 2020 19:38:56 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B71F9124054;
 Thu,  5 Mar 2020 19:38:56 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 94031124055;
 Thu,  5 Mar 2020 19:38:56 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu,  5 Mar 2020 19:38:56 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 03/10] tpm: Separate tpm_tis common functions from isa code
Date: Thu,  5 Mar 2020 14:38:48 -0500
Message-Id: <20200305193855.278878-4-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305193855.278878-1-stefanb@linux.vnet.ibm.com>
References: <20200305193855.278878-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-05_06:2020-03-05,
 2020-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=1 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050114
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, peter.maydell@linaro.org,
 Stefan Berger <stefanb@linux.ibm.com>, eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

Move the device agnostic code into tpm_tis_common.c and
put the ISA device specific code into tpm_tis_isa.c

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Message-id: 20200305165149.618-4-eric.auger@redhat.com
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/Makefile.objs                   |   2 +-
 hw/tpm/tpm_tis.h                       |  91 +++++++++++
 hw/tpm/{tpm_tis.c => tpm_tis_common.c} | 209 ++-----------------------
 hw/tpm/tpm_tis_isa.c                   | 170 ++++++++++++++++++++
 4 files changed, 271 insertions(+), 201 deletions(-)
 create mode 100644 hw/tpm/tpm_tis.h
 rename hw/tpm/{tpm_tis.c => tpm_tis_common.c} (83%)
 create mode 100644 hw/tpm/tpm_tis_isa.c

diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
index 85eb99ae05..fcc4c2f27c 100644
--- a/hw/tpm/Makefile.objs
+++ b/hw/tpm/Makefile.objs
@@ -1,6 +1,6 @@
 common-obj-$(CONFIG_TPM) += tpm_util.o
 obj-$(call lor,$(CONFIG_TPM_TIS),$(CONFIG_TPM_CRB)) += tpm_ppi.o
-common-obj-$(CONFIG_TPM_TIS) += tpm_tis.o
+common-obj-$(CONFIG_TPM_TIS) += tpm_tis_isa.o tpm_tis_common.o
 common-obj-$(CONFIG_TPM_CRB) += tpm_crb.o
 common-obj-$(CONFIG_TPM_PASSTHROUGH) += tpm_passthrough.o
 common-obj-$(CONFIG_TPM_EMULATOR) += tpm_emulator.o
diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
new file mode 100644
index 0000000000..5554989395
--- /dev/null
+++ b/hw/tpm/tpm_tis.h
@@ -0,0 +1,91 @@
+/*
+ * tpm_tis.h - QEMU's TPM TIS common header
+ *
+ * Copyright (C) 2006,2010-2013 IBM Corporation
+ *
+ * Authors:
+ *  Stefan Berger <stefanb@us.ibm.com>
+ *  David Safford <safford@us.ibm.com>
+ *
+ * Xen 4 support: Andrease Niederl <andreas.niederl@iaik.tugraz.at>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * Implementation of the TIS interface according to specs found at
+ * http://www.trustedcomputinggroup.org. This implementation currently
+ * supports version 1.3, 21 March 2013
+ * In the developers menu choose the PC Client section then find the TIS
+ * specification.
+ *
+ * TPM TIS for TPM 2 implementation following TCG PC Client Platform
+ * TPM Profile (PTP) Specification, Familiy 2.0, Revision 00.43
+ */
+#ifndef TPM_TPM_TIS_H
+#define TPM_TPM_TIS_H
+
+#include "qemu/osdep.h"
+#include "sysemu/tpm_backend.h"
+#include "tpm_ppi.h"
+
+#define TPM_TIS_NUM_LOCALITIES      5     /* per spec */
+#define TPM_TIS_LOCALITY_SHIFT      12
+#define TPM_TIS_NO_LOCALITY         0xff
+
+#define TPM_TIS_IS_VALID_LOCTY(x)   ((x) < TPM_TIS_NUM_LOCALITIES)
+
+#define TPM_TIS_BUFFER_MAX          4096
+
+typedef enum {
+    TPM_TIS_STATE_IDLE = 0,
+    TPM_TIS_STATE_READY,
+    TPM_TIS_STATE_COMPLETION,
+    TPM_TIS_STATE_EXECUTION,
+    TPM_TIS_STATE_RECEPTION,
+} TPMTISState;
+
+/* locality data  -- all fields are persisted */
+typedef struct TPMLocality {
+    TPMTISState state;
+    uint8_t access;
+    uint32_t sts;
+    uint32_t iface_id;
+    uint32_t inte;
+    uint32_t ints;
+} TPMLocality;
+
+typedef struct TPMState {
+    MemoryRegion mmio;
+
+    unsigned char buffer[TPM_TIS_BUFFER_MAX];
+    uint16_t rw_offset;
+
+    uint8_t active_locty;
+    uint8_t aborting_locty;
+    uint8_t next_locty;
+
+    TPMLocality loc[TPM_TIS_NUM_LOCALITIES];
+
+    qemu_irq irq;
+    uint32_t irq_num;
+
+    TPMBackendCmd cmd;
+
+    TPMBackend *be_driver;
+    TPMVersion be_tpm_version;
+
+    size_t be_buffer_size;
+
+    bool ppi_enabled;
+    TPMPPI ppi;
+} TPMState;
+
+extern const VMStateDescription vmstate_locty;
+extern const MemoryRegionOps tpm_tis_memory_ops;
+
+int tpm_tis_pre_save(TPMState *s);
+void tpm_tis_reset(TPMState *s);
+enum TPMVersion tpm_tis_get_tpm_version(TPMState *s);
+void tpm_tis_request_completed(TPMState *s, int ret);
+
+#endif /* TPM_TPM_TIS_H */
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis_common.c
similarity index 83%
rename from hw/tpm/tpm_tis.c
rename to hw/tpm/tpm_tis_common.c
index fc6d7ca579..9ce64d4836 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis_common.c
@@ -1,5 +1,6 @@
 /*
- * tpm_tis.c - QEMU's TPM TIS interface emulator
+ * tpm_tis_common.c - QEMU's TPM TIS interface emulator
+ * device agnostic functions
  *
  * Copyright (C) 2006,2010-2013 IBM Corporation
  *
@@ -21,7 +22,6 @@
  * TPM TIS for TPM 2 implementation following TCG PC Client Platform
  * TPM Profile (PTP) Specification, Familiy 2.0, Revision 00.43
  */
-
 #include "qemu/osdep.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
@@ -38,67 +38,7 @@
 #include "tpm_ppi.h"
 #include "trace.h"
 
-#define TPM_TIS_NUM_LOCALITIES      5     /* per spec */
-#define TPM_TIS_LOCALITY_SHIFT      12
-#define TPM_TIS_NO_LOCALITY         0xff
-
-#define TPM_TIS_IS_VALID_LOCTY(x)   ((x) < TPM_TIS_NUM_LOCALITIES)
-
-#define TPM_TIS_BUFFER_MAX          4096
-
-typedef enum {
-    TPM_TIS_STATE_IDLE = 0,
-    TPM_TIS_STATE_READY,
-    TPM_TIS_STATE_COMPLETION,
-    TPM_TIS_STATE_EXECUTION,
-    TPM_TIS_STATE_RECEPTION,
-} TPMTISState;
-
-/* locality data  -- all fields are persisted */
-typedef struct TPMLocality {
-    TPMTISState state;
-    uint8_t access;
-    uint32_t sts;
-    uint32_t iface_id;
-    uint32_t inte;
-    uint32_t ints;
-} TPMLocality;
-
-typedef struct TPMState {
-    MemoryRegion mmio;
-
-    unsigned char buffer[TPM_TIS_BUFFER_MAX];
-    uint16_t rw_offset;
-
-    uint8_t active_locty;
-    uint8_t aborting_locty;
-    uint8_t next_locty;
-
-    TPMLocality loc[TPM_TIS_NUM_LOCALITIES];
-
-    qemu_irq irq;
-    uint32_t irq_num;
-
-    TPMBackendCmd cmd;
-
-    TPMBackend *be_driver;
-    TPMVersion be_tpm_version;
-
-    size_t be_buffer_size;
-
-    bool ppi_enabled;
-    TPMPPI ppi;
-} TPMState;
-
-typedef struct TPMStateISA {
-    /*< private >*/
-    ISADevice parent_obj;
-
-    /*< public >*/
-    TPMState state; /* not a QOM object */
-} TPMStateISA;
-
-#define TPM_TIS_ISA(obj) OBJECT_CHECK(TPMStateISA, (obj), TYPE_TPM_TIS_ISA)
+#include "tpm_tis.h"
 
 #define DEBUG_TIS 0
 
@@ -288,7 +228,7 @@ static void tpm_tis_prep_abort(TPMState *s, uint8_t locty, uint8_t newlocty)
 /*
  * Callback from the TPM to indicate that the response was received.
  */
-static void tpm_tis_request_completed(TPMState *s, int ret)
+void tpm_tis_request_completed(TPMState *s, int ret)
 {
     uint8_t locty = s->cmd.locty;
     uint8_t l;
@@ -827,7 +767,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
     }
 }
 
-static const MemoryRegionOps tpm_tis_memory_ops = {
+const MemoryRegionOps tpm_tis_memory_ops = {
     .read = tpm_tis_mmio_read,
     .write = tpm_tis_mmio_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
@@ -840,7 +780,7 @@ static const MemoryRegionOps tpm_tis_memory_ops = {
 /*
  * Get the TPMVersion of the backend device being used
  */
-static enum TPMVersion tpm_tis_get_tpm_version(TPMState *s)
+enum TPMVersion tpm_tis_get_tpm_version(TPMState *s)
 {
     if (tpm_backend_had_startup_error(s->be_driver)) {
         return TPM_VERSION_UNSPEC;
@@ -853,7 +793,7 @@ static enum TPMVersion tpm_tis_get_tpm_version(TPMState *s)
  * This function is called when the machine starts, resets or due to
  * S3 resume.
  */
-static void tpm_tis_reset(TPMState *s)
+void tpm_tis_reset(TPMState *s)
 {
     int c;
 
@@ -898,7 +838,7 @@ static void tpm_tis_reset(TPMState *s)
 
 /* persistent state handling */
 
-static int tpm_tis_pre_save(TPMState *s)
+int tpm_tis_pre_save(TPMState *s)
 {
     uint8_t locty = s->active_locty;
 
@@ -916,7 +856,7 @@ static int tpm_tis_pre_save(TPMState *s)
     return 0;
 }
 
-static const VMStateDescription vmstate_locty = {
+const VMStateDescription vmstate_locty = {
     .name = "tpm-tis/locty",
     .version_id = 0,
     .fields      = (VMStateField[]) {
@@ -930,134 +870,3 @@ static const VMStateDescription vmstate_locty = {
     }
 };
 
-/* ISA */
-
-static int tpm_tis_pre_save_isa(void *opaque)
-{
-    TPMStateISA *isadev = opaque;
-
-    return tpm_tis_pre_save(&isadev->state);
-}
-
-static const VMStateDescription vmstate_tpm_tis_isa = {
-    .name = "tpm-tis",
-    .version_id = 0,
-    .pre_save  = tpm_tis_pre_save_isa,
-    .fields = (VMStateField[]) {
-        VMSTATE_BUFFER(state.buffer, TPMStateISA),
-        VMSTATE_UINT16(state.rw_offset, TPMStateISA),
-        VMSTATE_UINT8(state.active_locty, TPMStateISA),
-        VMSTATE_UINT8(state.aborting_locty, TPMStateISA),
-        VMSTATE_UINT8(state.next_locty, TPMStateISA),
-
-        VMSTATE_STRUCT_ARRAY(state.loc, TPMStateISA, TPM_TIS_NUM_LOCALITIES, 0,
-                             vmstate_locty, TPMLocality),
-
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static void tpm_tis_isa_request_completed(TPMIf *ti, int ret)
-{
-    TPMStateISA *isadev = TPM_TIS_ISA(ti);
-    TPMState *s = &isadev->state;
-
-    tpm_tis_request_completed(s, ret);
-}
-
-static enum TPMVersion tpm_tis_isa_get_tpm_version(TPMIf *ti)
-{
-    TPMStateISA *isadev = TPM_TIS_ISA(ti);
-    TPMState *s = &isadev->state;
-
-    return tpm_tis_get_tpm_version(s);
-}
-
-static void tpm_tis_isa_reset(DeviceState *dev)
-{
-    TPMStateISA *isadev = TPM_TIS_ISA(dev);
-    TPMState *s = &isadev->state;
-
-    return tpm_tis_reset(s);
-}
-
-static Property tpm_tis_isa_properties[] = {
-    DEFINE_PROP_UINT32("irq", TPMStateISA, state.irq_num, TPM_TIS_IRQ),
-    DEFINE_PROP_TPMBE("tpmdev", TPMStateISA, state.be_driver),
-    DEFINE_PROP_BOOL("ppi", TPMStateISA, state.ppi_enabled, true),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void tpm_tis_isa_initfn(Object *obj)
-{
-    TPMStateISA *isadev = TPM_TIS_ISA(obj);
-    TPMState *s = &isadev->state;
-
-    memory_region_init_io(&s->mmio, obj, &tpm_tis_memory_ops,
-                          s, "tpm-tis-mmio",
-                          TPM_TIS_NUM_LOCALITIES << TPM_TIS_LOCALITY_SHIFT);
-}
-
-static void tpm_tis_isa_realizefn(DeviceState *dev, Error **errp)
-{
-    TPMStateISA *isadev = TPM_TIS_ISA(dev);
-    TPMState *s = &isadev->state;
-
-    if (!tpm_find()) {
-        error_setg(errp, "at most one TPM device is permitted");
-        return;
-    }
-
-    if (!s->be_driver) {
-        error_setg(errp, "'tpmdev' property is required");
-        return;
-    }
-    if (s->irq_num > 15) {
-        error_setg(errp, "IRQ %d is outside valid range of 0 to 15",
-                   s->irq_num);
-        return;
-    }
-
-    isa_init_irq(ISA_DEVICE(dev), &s->irq, s->irq_num);
-
-    memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
-                                TPM_TIS_ADDR_BASE, &s->mmio);
-
-    if (s->ppi_enabled) {
-        tpm_ppi_init(&s->ppi, isa_address_space(ISA_DEVICE(dev)),
-                     TPM_PPI_ADDR_BASE, OBJECT(dev));
-    }
-}
-
-static void tpm_tis_isa_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    TPMIfClass *tc = TPM_IF_CLASS(klass);
-
-    device_class_set_props(dc, tpm_tis_isa_properties);
-    dc->vmsd  = &vmstate_tpm_tis_isa;
-    tc->model = TPM_MODEL_TPM_TIS;
-    dc->realize = tpm_tis_isa_realizefn;
-    dc->reset = tpm_tis_isa_reset;
-    tc->request_completed = tpm_tis_isa_request_completed;
-    tc->get_version = tpm_tis_isa_get_tpm_version;
-}
-
-static const TypeInfo tpm_tis_isa_info = {
-    .name = TYPE_TPM_TIS_ISA,
-    .parent = TYPE_ISA_DEVICE,
-    .instance_size = sizeof(TPMStateISA),
-    .instance_init = tpm_tis_isa_initfn,
-    .class_init  = tpm_tis_isa_class_init,
-    .interfaces = (InterfaceInfo[]) {
-        { TYPE_TPM_IF },
-        { }
-    }
-};
-
-static void tpm_tis_isa_register(void)
-{
-    type_register_static(&tpm_tis_isa_info);
-}
-
-type_init(tpm_tis_isa_register)
diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
new file mode 100644
index 0000000000..30ba37079d
--- /dev/null
+++ b/hw/tpm/tpm_tis_isa.c
@@ -0,0 +1,170 @@
+/*
+ * tpm_tis_isa.c - QEMU's TPM TIS ISA Device
+ *
+ * Copyright (C) 2006,2010-2013 IBM Corporation
+ *
+ * Authors:
+ *  Stefan Berger <stefanb@us.ibm.com>
+ *  David Safford <safford@us.ibm.com>
+ *
+ * Xen 4 support: Andrease Niederl <andreas.niederl@iaik.tugraz.at>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * Implementation of the TIS interface according to specs found at
+ * http://www.trustedcomputinggroup.org. This implementation currently
+ * supports version 1.3, 21 March 2013
+ * In the developers menu choose the PC Client section then find the TIS
+ * specification.
+ *
+ * TPM TIS for TPM 2 implementation following TCG PC Client Platform
+ * TPM Profile (PTP) Specification, Familiy 2.0, Revision 00.43
+ */
+
+#include "qemu/osdep.h"
+#include "hw/isa/isa.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "tpm_util.h"
+#include "tpm_tis.h"
+
+typedef struct TPMStateISA {
+    /*< private >*/
+    ISADevice parent_obj;
+
+    /*< public >*/
+    TPMState state; /* not a QOM object */
+} TPMStateISA;
+
+#define TPM_TIS_ISA(obj) OBJECT_CHECK(TPMStateISA, (obj), TYPE_TPM_TIS_ISA)
+
+static int tpm_tis_pre_save_isa(void *opaque)
+{
+    TPMStateISA *isadev = opaque;
+
+    return tpm_tis_pre_save(&isadev->state);
+}
+
+static const VMStateDescription vmstate_tpm_tis_isa = {
+    .name = "tpm-tis",
+    .version_id = 0,
+    .pre_save  = tpm_tis_pre_save_isa,
+    .fields = (VMStateField[]) {
+        VMSTATE_BUFFER(state.buffer, TPMStateISA),
+        VMSTATE_UINT16(state.rw_offset, TPMStateISA),
+        VMSTATE_UINT8(state.active_locty, TPMStateISA),
+        VMSTATE_UINT8(state.aborting_locty, TPMStateISA),
+        VMSTATE_UINT8(state.next_locty, TPMStateISA),
+
+        VMSTATE_STRUCT_ARRAY(state.loc, TPMStateISA, TPM_TIS_NUM_LOCALITIES, 0,
+                             vmstate_locty, TPMLocality),
+
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void tpm_tis_isa_request_completed(TPMIf *ti, int ret)
+{
+    TPMStateISA *isadev = TPM_TIS_ISA(ti);
+    TPMState *s = &isadev->state;
+
+    tpm_tis_request_completed(s, ret);
+}
+
+static enum TPMVersion tpm_tis_isa_get_tpm_version(TPMIf *ti)
+{
+    TPMStateISA *isadev = TPM_TIS_ISA(ti);
+    TPMState *s = &isadev->state;
+
+    return tpm_tis_get_tpm_version(s);
+}
+
+static void tpm_tis_isa_reset(DeviceState *dev)
+{
+    TPMStateISA *isadev = TPM_TIS_ISA(dev);
+    TPMState *s = &isadev->state;
+
+    return tpm_tis_reset(s);
+}
+
+static Property tpm_tis_isa_properties[] = {
+    DEFINE_PROP_UINT32("irq", TPMStateISA, state.irq_num, TPM_TIS_IRQ),
+    DEFINE_PROP_TPMBE("tpmdev", TPMStateISA, state.be_driver),
+    DEFINE_PROP_BOOL("ppi", TPMStateISA, state.ppi_enabled, true),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void tpm_tis_isa_initfn(Object *obj)
+{
+    TPMStateISA *isadev = TPM_TIS_ISA(obj);
+    TPMState *s = &isadev->state;
+
+    memory_region_init_io(&s->mmio, obj, &tpm_tis_memory_ops,
+                          s, "tpm-tis-mmio",
+                          TPM_TIS_NUM_LOCALITIES << TPM_TIS_LOCALITY_SHIFT);
+}
+
+static void tpm_tis_isa_realizefn(DeviceState *dev, Error **errp)
+{
+    TPMStateISA *isadev = TPM_TIS_ISA(dev);
+    TPMState *s = &isadev->state;
+
+    if (!tpm_find()) {
+        error_setg(errp, "at most one TPM device is permitted");
+        return;
+    }
+
+    if (!s->be_driver) {
+        error_setg(errp, "'tpmdev' property is required");
+        return;
+    }
+    if (s->irq_num > 15) {
+        error_setg(errp, "IRQ %d is outside valid range of 0 to 15",
+                   s->irq_num);
+        return;
+    }
+
+    isa_init_irq(ISA_DEVICE(dev), &s->irq, s->irq_num);
+
+    memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
+                                TPM_TIS_ADDR_BASE, &s->mmio);
+
+    if (s->ppi_enabled) {
+        tpm_ppi_init(&s->ppi, isa_address_space(ISA_DEVICE(dev)),
+                     TPM_PPI_ADDR_BASE, OBJECT(dev));
+    }
+}
+
+static void tpm_tis_isa_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    TPMIfClass *tc = TPM_IF_CLASS(klass);
+
+    device_class_set_props(dc, tpm_tis_isa_properties);
+    dc->vmsd  = &vmstate_tpm_tis_isa;
+    tc->model = TPM_MODEL_TPM_TIS;
+    dc->realize = tpm_tis_isa_realizefn;
+    dc->reset = tpm_tis_isa_reset;
+    tc->request_completed = tpm_tis_isa_request_completed;
+    tc->get_version = tpm_tis_isa_get_tpm_version;
+}
+
+static const TypeInfo tpm_tis_isa_info = {
+    .name = TYPE_TPM_TIS_ISA,
+    .parent = TYPE_ISA_DEVICE,
+    .instance_size = sizeof(TPMStateISA),
+    .instance_init = tpm_tis_isa_initfn,
+    .class_init  = tpm_tis_isa_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TPM_IF },
+        { }
+    }
+};
+
+static void tpm_tis_isa_register(void)
+{
+    type_register_static(&tpm_tis_isa_info);
+}
+
+type_init(tpm_tis_isa_register)
-- 
2.24.1


