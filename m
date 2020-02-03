Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B439C33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:20:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06AAE2080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PZ2vB20b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06AAE2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyV60-0002Qh-4A
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 01:20:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUxU-0002g4-2g
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:11:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUxQ-0002gf-QL
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:11:43 -0500
Received: from ozlabs.org ([203.11.71.1]:33935)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iyUxQ-0002ZA-4I; Mon, 03 Feb 2020 01:11:40 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 489yBp3sC5z9sSV; Mon,  3 Feb 2020 17:11:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580710290;
 bh=F6fSatWHvIT/NeeYDCkFuSv9aaof4/iPKvgE/tiILow=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PZ2vB20b+mVdpLOXRV/RnS0Tma8xtqonkbDFcrh6iobCAt0gCgw/vS6N2uRrZuZo2
 PrOqkAip/MZ8YeK790WejlsYYbYkHQHwqCHYGUbav+ByMocyKo+bDM4z0pVms0xCTr
 46iKt5rdnlKVuufZslKI1+MkMlpGRKF/y6GTJ5Rw=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 15/35] tpm_spapr: Support TPM for ppc64 using CRQ based
 interface
Date: Mon,  3 Feb 2020 17:11:03 +1100
Message-Id: <20200203061123.59150-16-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203061123.59150-1-david@gibson.dropbear.id.au>
References: <20200203061123.59150-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Berger <stefanb@linux.vnet.ibm.com>

Implement support for TPM on ppc64 by implementing the vTPM CRQ interface
as a frontend. It can use the tpm_emulator driver backend with the extern=
al
swtpm.

The Linux vTPM driver for ppc64 works with this emulation.

This TPM emulator also handles the TPM 2 case.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20200121152935.649898-4-stefanb@linux.ibm.com>
[dwg: Use device_class_set_props(), tweak Kconfig]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 docs/specs/tpm.txt   |  20 ++-
 hw/tpm/Kconfig       |   6 +
 hw/tpm/Makefile.objs |   1 +
 hw/tpm/tpm_spapr.c   | 379 +++++++++++++++++++++++++++++++++++++++++++
 hw/tpm/trace-events  |  12 ++
 include/sysemu/tpm.h |   3 +
 qapi/tpm.json        |   6 +-
 7 files changed, 423 insertions(+), 4 deletions(-)
 create mode 100644 hw/tpm/tpm_spapr.c

diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
index 9c8cca042d..9c3e67d8a7 100644
--- a/docs/specs/tpm.txt
+++ b/docs/specs/tpm.txt
@@ -34,6 +34,12 @@ The CRB interface makes a memory mapped IO region in t=
he area 0xfed40000 -
 QEMU files related to TPM CRB interface:
  - hw/tpm/tpm_crb.c
=20
+
+pSeries (ppc64) machines offer a tpm-spapr device model.
+
+QEMU files related to the SPAPR interface:
+ - hw/tpm/tpm_spapr.c
+
 =3D fw_cfg interface =3D
=20
 The bios/firmware may read the "etc/tpm/config" fw_cfg entry for
@@ -281,7 +287,7 @@ swtpm socket --tpmstate dir=3D/tmp/mytpm1 \
   --log level=3D20
=20
 Command line to start QEMU with the TPM emulator device communicating wi=
th
-the swtpm:
+the swtpm (x86):
=20
 qemu-system-x86_64 -display sdl -accel kvm \
   -m 1024 -boot d -bios bios-256k.bin -boot menu=3Don \
@@ -289,6 +295,18 @@ qemu-system-x86_64 -display sdl -accel kvm \
   -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
   -device tpm-tis,tpmdev=3Dtpm0 test.img
=20
+In case a pSeries machine is emulated, use the following command line:
+
+qemu-system-ppc64 -display sdl -machine pseries,accel=3Dkvm \
+  -m 1024 -bios slof.bin -boot menu=3Don \
+  -nodefaults -device VGA -device pci-ohci -device usb-kbd \
+  -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
+  -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
+  -device tpm-spapr,tpmdev=3Dtpm0 \
+  -device spapr-vscsi,id=3Dscsi0,reg=3D0x00002000 \
+  -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x3,drive=3Ddrive=
-virtio-disk0,id=3Dvirtio-disk0 \
+  -drive file=3Dtest.img,format=3Draw,if=3Dnone,id=3Ddrive-virtio-disk0
+
=20
 In case SeaBIOS is used as firmware, it should show the TPM menu item
 after entering the menu with 'ESC'.
diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
index 4c8ee87d67..4d4ab0855c 100644
--- a/hw/tpm/Kconfig
+++ b/hw/tpm/Kconfig
@@ -22,3 +22,9 @@ config TPM_EMULATOR
     bool
     default y
     depends on TPMDEV
+
+config TPM_SPAPR
+    bool
+    default n
+    depends on TPM && PSERIES
+    select TPMDEV
diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
index de0b85d02a..85eb99ae05 100644
--- a/hw/tpm/Makefile.objs
+++ b/hw/tpm/Makefile.objs
@@ -4,3 +4,4 @@ common-obj-$(CONFIG_TPM_TIS) +=3D tpm_tis.o
 common-obj-$(CONFIG_TPM_CRB) +=3D tpm_crb.o
 common-obj-$(CONFIG_TPM_PASSTHROUGH) +=3D tpm_passthrough.o
 common-obj-$(CONFIG_TPM_EMULATOR) +=3D tpm_emulator.o
+obj-$(CONFIG_TPM_SPAPR) +=3D tpm_spapr.o
diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
new file mode 100644
index 0000000000..2ac4cb061c
--- /dev/null
+++ b/hw/tpm/tpm_spapr.c
@@ -0,0 +1,379 @@
+/*
+ * QEMU PowerPC pSeries Logical Partition (aka sPAPR) hardware System Em=
ulator
+ *
+ * PAPR Virtual TPM
+ *
+ * Copyright (c) 2015, 2017, 2019 IBM Corporation.
+ *
+ * Authors:
+ *    Stefan Berger <stefanb@linux.vnet.ibm.com>
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+
+#include "sysemu/tpm_backend.h"
+#include "tpm_int.h"
+#include "tpm_util.h"
+
+#include "hw/ppc/spapr.h"
+#include "hw/ppc/spapr_vio.h"
+#include "trace.h"
+
+#define DEBUG_SPAPR 0
+
+#define VIO_SPAPR_VTPM(obj) \
+     OBJECT_CHECK(SpaprTpmState, (obj), TYPE_TPM_SPAPR)
+
+typedef struct TpmCrq {
+    uint8_t valid;  /* 0x80: cmd; 0xc0: init crq */
+                    /* 0x81-0x83: CRQ message response */
+    uint8_t msg;    /* see below */
+    uint16_t len;   /* len of TPM request; len of TPM response */
+    uint32_t data;  /* rtce_dma_handle when sending TPM request */
+    uint64_t reserved;
+} TpmCrq;
+
+#define SPAPR_VTPM_VALID_INIT_CRQ_COMMAND  0xC0
+#define SPAPR_VTPM_VALID_COMMAND           0x80
+#define SPAPR_VTPM_MSG_RESULT              0x80
+
+/* msg types for valid =3D SPAPR_VTPM_VALID_INIT_CRQ */
+#define SPAPR_VTPM_INIT_CRQ_RESULT           0x1
+#define SPAPR_VTPM_INIT_CRQ_COMPLETE_RESULT  0x2
+
+/* msg types for valid =3D SPAPR_VTPM_VALID_CMD */
+#define SPAPR_VTPM_GET_VERSION               0x1
+#define SPAPR_VTPM_TPM_COMMAND               0x2
+#define SPAPR_VTPM_GET_RTCE_BUFFER_SIZE      0x3
+#define SPAPR_VTPM_PREPARE_TO_SUSPEND        0x4
+
+/* response error messages */
+#define SPAPR_VTPM_VTPM_ERROR                0xff
+
+/* error codes */
+#define SPAPR_VTPM_ERR_COPY_IN_FAILED        0x3
+#define SPAPR_VTPM_ERR_COPY_OUT_FAILED       0x4
+
+#define TPM_SPAPR_BUFFER_MAX                 4096
+
+typedef struct {
+    SpaprVioDevice vdev;
+
+    TpmCrq crq; /* track single TPM command */
+
+    uint8_t state;
+#define SPAPR_VTPM_STATE_NONE         0
+#define SPAPR_VTPM_STATE_EXECUTION    1
+#define SPAPR_VTPM_STATE_COMPLETION   2
+
+    unsigned char *buffer;
+
+    TPMBackendCmd cmd;
+
+    TPMBackend *be_driver;
+    TPMVersion be_tpm_version;
+
+    size_t be_buffer_size;
+} SpaprTpmState;
+
+/*
+ * Send a request to the TPM.
+ */
+static void tpm_spapr_tpm_send(SpaprTpmState *s)
+{
+    if (trace_event_get_state_backends(TRACE_TPM_SPAPR_SHOW_BUFFER)) {
+        tpm_util_show_buffer(s->buffer, s->be_buffer_size, "To TPM");
+    }
+
+    s->state =3D SPAPR_VTPM_STATE_EXECUTION;
+    s->cmd =3D (TPMBackendCmd) {
+        .locty =3D 0,
+        .in =3D s->buffer,
+        .in_len =3D MIN(tpm_cmd_get_size(s->buffer), s->be_buffer_size),
+        .out =3D s->buffer,
+        .out_len =3D s->be_buffer_size,
+    };
+
+    tpm_backend_deliver_request(s->be_driver, &s->cmd);
+}
+
+static int tpm_spapr_process_cmd(SpaprTpmState *s, uint64_t dataptr)
+{
+    long rc;
+
+    /* a max. of be_buffer_size bytes can be transported */
+    rc =3D spapr_vio_dma_read(&s->vdev, dataptr,
+                            s->buffer, s->be_buffer_size);
+    if (rc) {
+        error_report("tpm_spapr_got_payload: DMA read failure");
+    }
+    /* let vTPM handle any malformed request */
+    tpm_spapr_tpm_send(s);
+
+    return rc;
+}
+
+static inline int spapr_tpm_send_crq(struct SpaprVioDevice *dev, TpmCrq =
*crq)
+{
+    return spapr_vio_send_crq(dev, (uint8_t *)crq);
+}
+
+static int tpm_spapr_do_crq(struct SpaprVioDevice *dev, uint8_t *crq_dat=
a)
+{
+    SpaprTpmState *s =3D VIO_SPAPR_VTPM(dev);
+    TpmCrq local_crq;
+    TpmCrq *crq =3D &s->crq; /* requests only */
+    int rc;
+    uint8_t valid =3D crq_data[0];
+    uint8_t msg =3D crq_data[1];
+
+    trace_tpm_spapr_do_crq(valid, msg);
+
+    switch (valid) {
+    case SPAPR_VTPM_VALID_INIT_CRQ_COMMAND: /* Init command/response */
+
+        /* Respond to initialization request */
+        switch (msg) {
+        case SPAPR_VTPM_INIT_CRQ_RESULT:
+            trace_tpm_spapr_do_crq_crq_result();
+            memset(&local_crq, 0, sizeof(local_crq));
+            local_crq.valid =3D SPAPR_VTPM_VALID_INIT_CRQ_COMMAND;
+            local_crq.msg =3D SPAPR_VTPM_INIT_CRQ_RESULT;
+            spapr_tpm_send_crq(dev, &local_crq);
+            break;
+
+        case SPAPR_VTPM_INIT_CRQ_COMPLETE_RESULT:
+            trace_tpm_spapr_do_crq_crq_complete_result();
+            memset(&local_crq, 0, sizeof(local_crq));
+            local_crq.valid =3D SPAPR_VTPM_VALID_INIT_CRQ_COMMAND;
+            local_crq.msg =3D SPAPR_VTPM_INIT_CRQ_COMPLETE_RESULT;
+            spapr_tpm_send_crq(dev, &local_crq);
+            break;
+        }
+
+        break;
+    case SPAPR_VTPM_VALID_COMMAND: /* Payloads */
+        switch (msg) {
+        case SPAPR_VTPM_TPM_COMMAND:
+            trace_tpm_spapr_do_crq_tpm_command();
+            if (s->state =3D=3D SPAPR_VTPM_STATE_EXECUTION) {
+                return H_BUSY;
+            }
+            memcpy(crq, crq_data, sizeof(*crq));
+
+            rc =3D tpm_spapr_process_cmd(s, be32_to_cpu(crq->data));
+
+            if (rc =3D=3D H_SUCCESS) {
+                crq->valid =3D be16_to_cpu(0);
+            } else {
+                local_crq.valid =3D SPAPR_VTPM_MSG_RESULT;
+                local_crq.msg =3D SPAPR_VTPM_VTPM_ERROR;
+                local_crq.len =3D cpu_to_be16(0);
+                local_crq.data =3D cpu_to_be32(SPAPR_VTPM_ERR_COPY_IN_FA=
ILED);
+                spapr_tpm_send_crq(dev, &local_crq);
+            }
+            break;
+
+        case SPAPR_VTPM_GET_RTCE_BUFFER_SIZE:
+            trace_tpm_spapr_do_crq_tpm_get_rtce_buffer_size(s->be_buffer=
_size);
+            local_crq.valid =3D SPAPR_VTPM_VALID_COMMAND;
+            local_crq.msg =3D SPAPR_VTPM_GET_RTCE_BUFFER_SIZE |
+                            SPAPR_VTPM_MSG_RESULT;
+            local_crq.len =3D cpu_to_be16(s->be_buffer_size);
+            spapr_tpm_send_crq(dev, &local_crq);
+            break;
+
+        case SPAPR_VTPM_GET_VERSION:
+            local_crq.valid =3D SPAPR_VTPM_VALID_COMMAND;
+            local_crq.msg =3D SPAPR_VTPM_GET_VERSION | SPAPR_VTPM_MSG_RE=
SULT;
+            local_crq.len =3D cpu_to_be16(0);
+            switch (s->be_tpm_version) {
+            case TPM_VERSION_1_2:
+                local_crq.data =3D cpu_to_be32(1);
+                break;
+            case TPM_VERSION_2_0:
+                local_crq.data =3D cpu_to_be32(2);
+                break;
+            default:
+                g_assert_not_reached();
+                break;
+            }
+            trace_tpm_spapr_do_crq_get_version(be32_to_cpu(local_crq.dat=
a));
+            spapr_tpm_send_crq(dev, &local_crq);
+            break;
+
+        case SPAPR_VTPM_PREPARE_TO_SUSPEND:
+            trace_tpm_spapr_do_crq_prepare_to_suspend();
+            local_crq.valid =3D SPAPR_VTPM_VALID_COMMAND;
+            local_crq.msg =3D SPAPR_VTPM_PREPARE_TO_SUSPEND |
+                            SPAPR_VTPM_MSG_RESULT;
+            spapr_tpm_send_crq(dev, &local_crq);
+            break;
+
+        default:
+            trace_tpm_spapr_do_crq_unknown_msg_type(crq->msg);
+        }
+        break;
+    default:
+        trace_tpm_spapr_do_crq_unknown_crq(valid, msg);
+    };
+
+    return H_SUCCESS;
+}
+
+static void tpm_spapr_request_completed(TPMIf *ti, int ret)
+{
+    SpaprTpmState *s =3D VIO_SPAPR_VTPM(ti);
+    TpmCrq *crq =3D &s->crq;
+    uint32_t len;
+    int rc;
+
+    s->state =3D SPAPR_VTPM_STATE_COMPLETION;
+
+    /* a max. of be_buffer_size bytes can be transported */
+    len =3D MIN(tpm_cmd_get_size(s->buffer), s->be_buffer_size);
+    rc =3D spapr_vio_dma_write(&s->vdev, be32_to_cpu(crq->data),
+                             s->buffer, len);
+
+    if (trace_event_get_state_backends(TRACE_TPM_SPAPR_SHOW_BUFFER)) {
+        tpm_util_show_buffer(s->buffer, len, "From TPM");
+    }
+
+    crq->valid =3D SPAPR_VTPM_MSG_RESULT;
+    if (rc =3D=3D H_SUCCESS) {
+        crq->msg =3D SPAPR_VTPM_TPM_COMMAND | SPAPR_VTPM_MSG_RESULT;
+        crq->len =3D cpu_to_be16(len);
+    } else {
+        error_report("%s: DMA write failure", __func__);
+        crq->msg =3D SPAPR_VTPM_VTPM_ERROR;
+        crq->len =3D cpu_to_be16(0);
+        crq->data =3D cpu_to_be32(SPAPR_VTPM_ERR_COPY_OUT_FAILED);
+    }
+
+    rc =3D spapr_tpm_send_crq(&s->vdev, crq);
+    if (rc) {
+        error_report("%s: Error sending response", __func__);
+    }
+}
+
+static int tpm_spapr_do_startup_tpm(SpaprTpmState *s, size_t buffersize)
+{
+    return tpm_backend_startup_tpm(s->be_driver, buffersize);
+}
+
+static const char *tpm_spapr_get_dt_compatible(SpaprVioDevice *dev)
+{
+    SpaprTpmState *s =3D VIO_SPAPR_VTPM(dev);
+
+    switch (s->be_tpm_version) {
+    case TPM_VERSION_1_2:
+        return "IBM,vtpm";
+    case TPM_VERSION_2_0:
+        return "IBM,vtpm20";
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tpm_spapr_reset(SpaprVioDevice *dev)
+{
+    SpaprTpmState *s =3D VIO_SPAPR_VTPM(dev);
+
+    s->state =3D SPAPR_VTPM_STATE_NONE;
+
+    s->be_tpm_version =3D tpm_backend_get_tpm_version(s->be_driver);
+
+    s->be_buffer_size =3D MIN(tpm_backend_get_buffer_size(s->be_driver),
+                            TPM_SPAPR_BUFFER_MAX);
+
+    tpm_backend_reset(s->be_driver);
+    tpm_spapr_do_startup_tpm(s, s->be_buffer_size);
+}
+
+static enum TPMVersion tpm_spapr_get_version(TPMIf *ti)
+{
+    SpaprTpmState *s =3D VIO_SPAPR_VTPM(ti);
+
+    if (tpm_backend_had_startup_error(s->be_driver)) {
+        return TPM_VERSION_UNSPEC;
+    }
+
+    return tpm_backend_get_tpm_version(s->be_driver);
+}
+
+static const VMStateDescription vmstate_spapr_vtpm =3D {
+    .name =3D "tpm-spapr",
+    .unmigratable =3D 1,
+};
+
+static Property tpm_spapr_properties[] =3D {
+    DEFINE_SPAPR_PROPERTIES(SpaprTpmState, vdev),
+    DEFINE_PROP_TPMBE("tpmdev", SpaprTpmState, be_driver),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void tpm_spapr_realizefn(SpaprVioDevice *dev, Error **errp)
+{
+    SpaprTpmState *s =3D VIO_SPAPR_VTPM(dev);
+
+    if (!tpm_find()) {
+        error_setg(errp, "at most one TPM device is permitted");
+        return;
+    }
+
+    dev->crq.SendFunc =3D tpm_spapr_do_crq;
+
+    if (!s->be_driver) {
+        error_setg(errp, "'tpmdev' property is required");
+        return;
+    }
+    s->buffer =3D g_malloc(TPM_SPAPR_BUFFER_MAX);
+}
+
+static void tpm_spapr_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    SpaprVioDeviceClass *k =3D VIO_SPAPR_DEVICE_CLASS(klass);
+    TPMIfClass *tc =3D TPM_IF_CLASS(klass);
+
+    k->realize =3D tpm_spapr_realizefn;
+    k->reset =3D tpm_spapr_reset;
+    k->dt_name =3D "vtpm";
+    k->dt_type =3D "IBM,vtpm";
+    k->get_dt_compatible =3D tpm_spapr_get_dt_compatible;
+    k->signal_mask =3D 0x00000001;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    device_class_set_props(dc, tpm_spapr_properties);
+    k->rtce_window_size =3D 0x10000000;
+    dc->vmsd =3D &vmstate_spapr_vtpm;
+
+    tc->model =3D TPM_MODEL_TPM_SPAPR;
+    tc->get_version =3D tpm_spapr_get_version;
+    tc->request_completed =3D tpm_spapr_request_completed;
+}
+
+static const TypeInfo tpm_spapr_info =3D {
+    .name          =3D TYPE_TPM_SPAPR,
+    .parent        =3D TYPE_VIO_SPAPR_DEVICE,
+    .instance_size =3D sizeof(SpaprTpmState),
+    .class_init    =3D tpm_spapr_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { TYPE_TPM_IF },
+        { }
+    }
+};
+
+static void tpm_spapr_register_types(void)
+{
+    type_register_static(&tpm_spapr_info);
+}
+
+type_init(tpm_spapr_register_types)
diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
index 357c9e9a84..9143a8eaa3 100644
--- a/hw/tpm/trace-events
+++ b/hw/tpm/trace-events
@@ -55,3 +55,15 @@ tpm_tis_pre_save(uint8_t locty, uint32_t rw_offset) "l=
octy: %d, rw_offset =3D %u"
=20
 # tpm_ppi.c
 tpm_ppi_memset(uint8_t *ptr, size_t size) "memset: %p %zu"
+
+# hw/tpm/tpm_spapr.c
+tpm_spapr_show_buffer(const char *direction, size_t len, const char *buf=
) "direction: %s len: %zu\n%s"
+tpm_spapr_do_crq(uint8_t raw1, uint8_t raw2) "1st 2 bytes in CRQ: 0x%02x=
 0x%02x"
+tpm_spapr_do_crq_crq_result(void) "SPAPR_VTPM_INIT_CRQ_RESULT"
+tpm_spapr_do_crq_crq_complete_result(void) "SPAPR_VTPM_INIT_CRQ_COMP_RES=
ULT"
+tpm_spapr_do_crq_tpm_command(void) "got TPM command payload"
+tpm_spapr_do_crq_tpm_get_rtce_buffer_size(size_t buffersize) "response: =
buffer size is %zu"
+tpm_spapr_do_crq_get_version(uint32_t version) "response: version %u"
+tpm_spapr_do_crq_prepare_to_suspend(void) "response: preparing to suspen=
d"
+tpm_spapr_do_crq_unknown_msg_type(uint8_t type) "Unknown message type 0x=
%02x"
+tpm_spapr_do_crq_unknown_crq(uint8_t raw1, uint8_t raw2) "unknown CRQ 0x=
%02x 0x%02x ..."
diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index 5b541a71c8..15979a3647 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -45,11 +45,14 @@ typedef struct TPMIfClass {
=20
 #define TYPE_TPM_TIS                "tpm-tis"
 #define TYPE_TPM_CRB                "tpm-crb"
+#define TYPE_TPM_SPAPR              "tpm-spapr"
=20
 #define TPM_IS_TIS(chr)                             \
     object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS)
 #define TPM_IS_CRB(chr)                             \
     object_dynamic_cast(OBJECT(chr), TYPE_TPM_CRB)
+#define TPM_IS_SPAPR(chr)                           \
+    object_dynamic_cast(OBJECT(chr), TYPE_TPM_SPAPR)
=20
 /* returns NULL unless there is exactly one TPM device */
 static inline TPMIf *tpm_find(void)
diff --git a/qapi/tpm.json b/qapi/tpm.json
index b30323bb6b..63878aa0f4 100644
--- a/qapi/tpm.json
+++ b/qapi/tpm.json
@@ -12,11 +12,11 @@
 #
 # @tpm-tis: TPM TIS model
 # @tpm-crb: TPM CRB model (since 2.12)
+# @tpm-spapr: TPM SPAPR model (since 5.0)
 #
 # Since: 1.5
 ##
-{ 'enum': 'TpmModel', 'data': [ 'tpm-tis', 'tpm-crb' ] }
-
+{ 'enum': 'TpmModel', 'data': [ 'tpm-tis', 'tpm-crb', 'tpm-spapr' ] }
 ##
 # @query-tpm-models:
 #
@@ -29,7 +29,7 @@
 # Example:
 #
 # -> { "execute": "query-tpm-models" }
-# <- { "return": [ "tpm-tis", "tpm-crb" ] }
+# <- { "return": [ "tpm-tis", "tpm-crb", "tpm-spapr" ] }
 #
 ##
 { 'command': 'query-tpm-models', 'returns': ['TpmModel'] }
--=20
2.24.1


