Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCAEC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:54:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 439B722D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DcWHGsKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439B722D6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0LRg-0004yi-CT
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 03:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42405)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0W-0004iM-99
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0Q-00086A-FH
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:12 -0400
Received: from ozlabs.org ([203.11.71.1]:47681)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i0L0N-0007zs-V2; Wed, 21 Aug 2019 03:26:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46CzjB31NDz9sPl; Wed, 21 Aug 2019 17:25:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566372350;
 bh=9a/metOirRTSEG7Tq4eDH9MEvXMq72NnVDMTpJfr3BI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DcWHGsKjJc/lDXjYOpr54WwVvnZriG9ftM6aZ3LPwtOKr6VRqxqoEQUqz9/Vn6owr
 mIbh99nnkof25lUJo3Om1HkJjLR8IhF+cfsONmuiuUDoIMsTz0etk0z6GjasdUu046
 CJ92VP8CtsTKnKteqXT1NCCu09+tSuseKqIGf2Io=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 21 Aug 2019 17:25:20 +1000
Message-Id: <20190821072542.23090-21-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821072542.23090-1-david@gibson.dropbear.id.au>
References: <20190821072542.23090-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 20/42] spapr: initial implementation for
 H_TPM_COMM/spapr-tpm-proxy
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Roth <mdroth@linux.vnet.ibm.com>

This implements the H_TPM_COMM hypercall, which is used by an
Ultravisor to pass TPM commands directly to the host's TPM device, or
a TPM Resource Manager associated with the device.

This also introduces a new virtual device, spapr-tpm-proxy, which
is used to configure the host TPM path to be used to service
requests sent by H_TPM_COMM hcalls, for example:

  -device spapr-tpm-proxy,id=3Dtpmp0,host-path=3D/dev/tpmrm0

By default, no spapr-tpm-proxy will be created, and hcalls will return
H_FUNCTION.

The full specification for this hypercall can be found in
docs/specs/ppc-spapr-uv-hcalls.txt

Since SVM-related hcalls like H_TPM_COMM use a reserved range of
0xEF00-0xEF80, we introduce a separate hcall table here to handle
them.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com
Message-Id: <20190717205842.17827-3-mdroth@linux.vnet.ibm.com>
[dwg: Corrected #include for upstream change]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/Makefile.objs             |   1 +
 hw/ppc/spapr.c                   |  33 +++++-
 hw/ppc/spapr_hcall.c             |  13 +++
 hw/ppc/spapr_tpm_proxy.c         | 178 +++++++++++++++++++++++++++++++
 hw/ppc/trace-events              |   4 +
 include/hw/ppc/spapr.h           |  11 ++
 include/hw/ppc/spapr_tpm_proxy.h |  31 ++++++
 7 files changed, 270 insertions(+), 1 deletion(-)
 create mode 100644 hw/ppc/spapr_tpm_proxy.c
 create mode 100644 include/hw/ppc/spapr_tpm_proxy.h

diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 9da93af905..2c4e1c8de0 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -5,6 +5,7 @@ obj-$(CONFIG_PSERIES) +=3D spapr.o spapr_caps.o spapr_vio=
.o spapr_events.o
 obj-$(CONFIG_PSERIES) +=3D spapr_hcall.o spapr_iommu.o spapr_rtas.o
 obj-$(CONFIG_PSERIES) +=3D spapr_pci.o spapr_rtc.o spapr_drc.o
 obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o spapr_irq.o
+obj-$(CONFIG_PSERIES) +=3D spapr_tpm_proxy.o
 obj-$(CONFIG_SPAPR_RNG) +=3D  spapr_rng.o
 # IBM PowerNV
 obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_ps=
i.o pnv_occ.o pnv_bmc.o
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 15e27d9a10..56b33571c5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -79,6 +79,7 @@
 #include "qemu/cutils.h"
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/mem/memory-device.h"
+#include "hw/ppc/spapr_tpm_proxy.h"
=20
 #include <libfdt.h>
=20
@@ -4036,6 +4037,29 @@ static void spapr_phb_unplug_request(HotplugHandle=
r *hotplug_dev,
     }
 }
=20
+static void spapr_tpm_proxy_plug(HotplugHandler *hotplug_dev, DeviceStat=
e *dev,
+                                 Error **errp)
+{
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(OBJECT(hotplug_dev));
+    SpaprTpmProxy *tpm_proxy =3D SPAPR_TPM_PROXY(dev);
+
+    if (spapr->tpm_proxy !=3D NULL) {
+        error_setg(errp, "Only one TPM proxy can be specified for this m=
achine");
+        return;
+    }
+
+    spapr->tpm_proxy =3D tpm_proxy;
+}
+
+static void spapr_tpm_proxy_unplug(HotplugHandler *hotplug_dev, DeviceSt=
ate *dev)
+{
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(OBJECT(hotplug_dev));
+
+    object_property_set_bool(OBJECT(dev), false, "realized", NULL);
+    object_unparent(OBJECT(dev));
+    spapr->tpm_proxy =3D NULL;
+}
+
 static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
                                       DeviceState *dev, Error **errp)
 {
@@ -4045,6 +4069,8 @@ static void spapr_machine_device_plug(HotplugHandle=
r *hotplug_dev,
         spapr_core_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRID=
GE)) {
         spapr_phb_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_TPM_PROXY)) {
+        spapr_tpm_proxy_plug(hotplug_dev, dev, errp);
     }
 }
=20
@@ -4057,6 +4083,8 @@ static void spapr_machine_device_unplug(HotplugHand=
ler *hotplug_dev,
         spapr_core_unplug(hotplug_dev, dev);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRID=
GE)) {
         spapr_phb_unplug(hotplug_dev, dev);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_TPM_PROXY)) {
+        spapr_tpm_proxy_unplug(hotplug_dev, dev);
     }
 }
=20
@@ -4091,6 +4119,8 @@ static void spapr_machine_device_unplug_request(Hot=
plugHandler *hotplug_dev,
             return;
         }
         spapr_phb_unplug_request(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_TPM_PROXY)) {
+        spapr_tpm_proxy_unplug(hotplug_dev, dev);
     }
 }
=20
@@ -4111,7 +4141,8 @@ static HotplugHandler *spapr_get_hotplug_handler(Ma=
chineState *machine,
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
         object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE) ||
-        object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDGE)) {
+        object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDGE) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_TPM_PROXY)) {
         return HOTPLUG_HANDLER(machine);
     }
     if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 10c0b53339..e20a946b99 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1963,6 +1963,7 @@ static target_ulong h_update_dt(PowerPCCPU *cpu, Sp=
aprMachineState *spapr,
=20
 static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
 static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_H=
CALL_BASE + 1];
+static spapr_hcall_fn svm_hypercall_table[(SVM_HCALL_MAX - SVM_HCALL_BAS=
E) / 4 + 1];
=20
 void spapr_register_hypercall(target_ulong opcode, spapr_hcall_fn fn)
 {
@@ -1972,6 +1973,11 @@ void spapr_register_hypercall(target_ulong opcode,=
 spapr_hcall_fn fn)
         assert((opcode & 0x3) =3D=3D 0);
=20
         slot =3D &papr_hypercall_table[opcode / 4];
+    } else if (opcode >=3D SVM_HCALL_BASE && opcode <=3D SVM_HCALL_MAX) =
{
+        /* we only have SVM-related hcall numbers assigned in multiples =
of 4 */
+        assert((opcode & 0x3) =3D=3D 0);
+
+        slot =3D &svm_hypercall_table[(opcode - SVM_HCALL_BASE) / 4];
     } else {
         assert((opcode >=3D KVMPPC_HCALL_BASE) && (opcode <=3D KVMPPC_HC=
ALL_MAX));
=20
@@ -1991,6 +1997,13 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, targ=
et_ulong opcode,
         && ((opcode & 0x3) =3D=3D 0)) {
         spapr_hcall_fn fn =3D papr_hypercall_table[opcode / 4];
=20
+        if (fn) {
+            return fn(cpu, spapr, opcode, args);
+        }
+    } else if ((opcode >=3D SVM_HCALL_BASE) &&
+               (opcode <=3D SVM_HCALL_MAX)) {
+        spapr_hcall_fn fn =3D svm_hypercall_table[(opcode - SVM_HCALL_BA=
SE) / 4];
+
         if (fn) {
             return fn(cpu, spapr, opcode, args);
         }
diff --git a/hw/ppc/spapr_tpm_proxy.c b/hw/ppc/spapr_tpm_proxy.c
new file mode 100644
index 0000000000..b835d25be6
--- /dev/null
+++ b/hw/ppc/spapr_tpm_proxy.c
@@ -0,0 +1,178 @@
+/*
+ * SPAPR TPM Proxy/Hypercall
+ *
+ * Copyright IBM Corp. 2019
+ *
+ * Authors:
+ *  Michael Roth      <mdroth@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "sysemu/reset.h"
+#include "cpu.h"
+#include "hw/ppc/spapr.h"
+#include "hw/qdev-properties.h"
+#include "trace.h"
+
+#define TPM_SPAPR_BUFSIZE 4096
+
+enum {
+    TPM_COMM_OP_EXECUTE =3D 1,
+    TPM_COMM_OP_CLOSE_SESSION =3D 2,
+};
+
+static void spapr_tpm_proxy_reset(void *opaque)
+{
+    SpaprTpmProxy *tpm_proxy =3D SPAPR_TPM_PROXY(opaque);
+
+    if (tpm_proxy->host_fd !=3D -1) {
+        close(tpm_proxy->host_fd);
+        tpm_proxy->host_fd =3D -1;
+    }
+}
+
+static ssize_t tpm_execute(SpaprTpmProxy *tpm_proxy, target_ulong *args)
+{
+    uint64_t data_in =3D ppc64_phys_to_real(args[1]);
+    target_ulong data_in_size =3D args[2];
+    uint64_t data_out =3D ppc64_phys_to_real(args[3]);
+    target_ulong data_out_size =3D args[4];
+    uint8_t buf_in[TPM_SPAPR_BUFSIZE];
+    uint8_t buf_out[TPM_SPAPR_BUFSIZE];
+    ssize_t ret;
+
+    trace_spapr_tpm_execute(data_in, data_in_size, data_out, data_out_si=
ze);
+
+    if (data_in_size > TPM_SPAPR_BUFSIZE) {
+        error_report("invalid TPM input buffer size: " TARGET_FMT_lu,
+                     data_in_size);
+        return H_P3;
+    }
+
+    if (data_out_size < TPM_SPAPR_BUFSIZE) {
+        error_report("invalid TPM output buffer size: " TARGET_FMT_lu,
+                     data_out_size);
+        return H_P5;
+    }
+
+    if (tpm_proxy->host_fd =3D=3D -1) {
+        tpm_proxy->host_fd =3D open(tpm_proxy->host_path, O_RDWR);
+        if (tpm_proxy->host_fd =3D=3D -1) {
+            error_report("failed to open TPM device %s: %d",
+                         tpm_proxy->host_path, errno);
+            return H_RESOURCE;
+        }
+    }
+
+    cpu_physical_memory_read(data_in, buf_in, data_in_size);
+
+    do {
+        ret =3D write(tpm_proxy->host_fd, buf_in, data_in_size);
+        if (ret > 0) {
+            data_in_size -=3D ret;
+        }
+    } while ((ret >=3D 0 && data_in_size > 0) || (ret =3D=3D -1 && errno=
 =3D=3D EINTR));
+
+    if (ret =3D=3D -1) {
+        error_report("failed to write to TPM device %s: %d",
+                     tpm_proxy->host_path, errno);
+        return H_RESOURCE;
+    }
+
+    do {
+        ret =3D read(tpm_proxy->host_fd, buf_out, data_out_size);
+    } while (ret =3D=3D 0 || (ret =3D=3D -1 && errno =3D=3D EINTR));
+
+    if (ret =3D=3D -1) {
+        error_report("failed to read from TPM device %s: %d",
+                     tpm_proxy->host_path, errno);
+        return H_RESOURCE;
+    }
+
+    cpu_physical_memory_write(data_out, buf_out, ret);
+    args[0] =3D ret;
+
+    return H_SUCCESS;
+}
+
+static target_ulong h_tpm_comm(PowerPCCPU *cpu,
+                               SpaprMachineState *spapr,
+                               target_ulong opcode,
+                               target_ulong *args)
+{
+    target_ulong op =3D args[0];
+    SpaprTpmProxy *tpm_proxy =3D spapr->tpm_proxy;
+
+    if (!tpm_proxy) {
+        error_report("TPM proxy not available");
+        return H_FUNCTION;
+    }
+
+    trace_spapr_h_tpm_comm(tpm_proxy->host_path ?: "null", op);
+
+    switch (op) {
+    case TPM_COMM_OP_EXECUTE:
+        return tpm_execute(tpm_proxy, args);
+    case TPM_COMM_OP_CLOSE_SESSION:
+        spapr_tpm_proxy_reset(tpm_proxy);
+        return H_SUCCESS;
+    default:
+        return H_PARAMETER;
+    }
+}
+
+static void spapr_tpm_proxy_realize(DeviceState *d, Error **errp)
+{
+    SpaprTpmProxy *tpm_proxy =3D SPAPR_TPM_PROXY(d);
+
+    if (tpm_proxy->host_path =3D=3D NULL) {
+        error_setg(errp, "must specify 'host-path' option for device");
+        return;
+    }
+
+    tpm_proxy->host_fd =3D -1;
+    qemu_register_reset(spapr_tpm_proxy_reset, tpm_proxy);
+}
+
+static void spapr_tpm_proxy_unrealize(DeviceState *d, Error **errp)
+{
+    SpaprTpmProxy *tpm_proxy =3D SPAPR_TPM_PROXY(d);
+
+    qemu_unregister_reset(spapr_tpm_proxy_reset, tpm_proxy);
+}
+
+static Property spapr_tpm_proxy_properties[] =3D {
+    DEFINE_PROP_STRING("host-path", SpaprTpmProxy, host_path),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void spapr_tpm_proxy_class_init(ObjectClass *k, void *data)
+{
+    DeviceClass *dk =3D DEVICE_CLASS(k);
+
+    dk->realize =3D spapr_tpm_proxy_realize;
+    dk->unrealize =3D spapr_tpm_proxy_unrealize;
+    dk->user_creatable =3D true;
+    dk->props =3D spapr_tpm_proxy_properties;
+}
+
+static const TypeInfo spapr_tpm_proxy_info =3D {
+    .name          =3D TYPE_SPAPR_TPM_PROXY,
+    .parent        =3D TYPE_DEVICE,
+    .instance_size =3D sizeof(SpaprTpmProxy),
+    .class_init    =3D spapr_tpm_proxy_class_init,
+};
+
+static void spapr_tpm_proxy_register_types(void)
+{
+    type_register_static(&spapr_tpm_proxy_info);
+    spapr_register_hypercall(SVM_H_TPM_COMM, h_tpm_comm);
+}
+
+type_init(spapr_tpm_proxy_register_types)
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index f76448f532..96dad767a1 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -25,6 +25,10 @@ spapr_update_dt(unsigned cb) "New blob %u bytes"
 spapr_update_dt_failed_size(unsigned cbold, unsigned cbnew, unsigned mag=
ic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
 spapr_update_dt_failed_check(unsigned cbold, unsigned cbnew, unsigned ma=
gic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
=20
+# spapr_hcall_tpm.c
+spapr_h_tpm_comm(const char *device_path, uint64_t operation) "tpm_devic=
e_path=3D%s operation=3D0x%"PRIu64
+spapr_tpm_execute(uint64_t data_in, uint64_t data_in_sz, uint64_t data_o=
ut, uint64_t data_out_sz) "data_in=3D0x%"PRIx64", data_in_sz=3D%"PRIu64",=
 data_out=3D0x%"PRIx64", data_out_sz=3D%"PRIu64
+
 # spapr_iommu.c
 spapr_iommu_put(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t re=
t) "liobn=3D0x%"PRIx64" ioba=3D0x%"PRIx64" tce=3D0x%"PRIx64" ret=3D%"PRId=
64
 spapr_iommu_get(uint64_t liobn, uint64_t ioba, uint64_t ret, uint64_t tc=
e) "liobn=3D0x%"PRIx64" ioba=3D0x%"PRIx64" ret=3D%"PRId64" tce=3D0x%"PRIx=
64
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 5d36eec9d0..c79bc6a123 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -10,6 +10,7 @@
 #include "hw/ppc/spapr_irq.h"
 #include "hw/ppc/spapr_xive.h"  /* For SpaprXive */
 #include "hw/ppc/xics.h"        /* For ICSState */
+#include "hw/ppc/spapr_tpm_proxy.h"
=20
 struct SpaprVioBus;
 struct SpaprPhbState;
@@ -203,6 +204,7 @@ struct SpaprMachineState {
     SpaprCapabilities def, eff, mig;
=20
     unsigned gpu_numa_id;
+    SpaprTpmProxy *tpm_proxy;
 };
=20
 #define H_SUCCESS         0
@@ -508,6 +510,15 @@ struct SpaprMachineState {
 #define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
 #define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
=20
+/*
+ * The hcall range 0xEF00 to 0xEF80 is reserved for use in facilitating
+ * Secure VM mode via an Ultravisor / Protected Execution Facility
+ */
+#define SVM_HCALL_BASE              0xEF00
+#define SVM_H_TPM_COMM              0xEF10
+#define SVM_HCALL_MAX               SVM_H_TPM_COMM
+
+
 typedef struct SpaprDeviceTreeUpdateHeader {
     uint32_t version_id;
 } SpaprDeviceTreeUpdateHeader;
diff --git a/include/hw/ppc/spapr_tpm_proxy.h b/include/hw/ppc/spapr_tpm_=
proxy.h
new file mode 100644
index 0000000000..c574e22ba4
--- /dev/null
+++ b/include/hw/ppc/spapr_tpm_proxy.h
@@ -0,0 +1,31 @@
+/*
+ * SPAPR TPM Proxy/Hypercall
+ *
+ * Copyright IBM Corp. 2019
+ *
+ * Authors:
+ *  Michael Roth      <mdroth@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_SPAPR_TPM_PROXY_H
+#define HW_SPAPR_TPM_PROXY_H
+
+#include "qom/object.h"
+#include "hw/qdev-core.h"
+
+#define TYPE_SPAPR_TPM_PROXY "spapr-tpm-proxy"
+#define SPAPR_TPM_PROXY(obj) OBJECT_CHECK(SpaprTpmProxy, (obj), \
+                                          TYPE_SPAPR_TPM_PROXY)
+
+typedef struct SpaprTpmProxy {
+    /*< private >*/
+    DeviceState parent;
+
+    char *host_path;
+    int host_fd;
+} SpaprTpmProxy;
+
+#endif /* HW_SPAPR_TPM_PROXY_H */
--=20
2.21.0


