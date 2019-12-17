Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FEFC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:18:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D466B2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="o0Edwegn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D466B2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5FJ-0005jw-I7
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:18:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4iY-0000Hu-B7
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4iW-0005sw-MW
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:18 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:34589 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4iW-0005Po-Bq; Mon, 16 Dec 2019 23:44:16 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWR6d7zz9sSb; Tue, 17 Dec 2019 15:43:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557811;
 bh=Td+HUQPIiW4jdSS03cW6WQtatFv45X48Sv9D83TYMSg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=o0EdwegnbUdz5sfUfZLn3+rmbvYRcsXazoQXqTQBoJ9cJup3bnnNjT0CjHs1Zb3xr
 +OTcrd1ZSTRI3u+VkvhfDpaeJ62B3vD8FelaJuRXT9NIY13r1w3tVRlcreAD4hBmOl
 lhaZ+E0zDLLVKJkSju2krkNjcqKAL9VY04XaVxgw=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 25/88] ppc/pnv: Add HIOMAP commands
Date: Tue, 17 Dec 2019 15:42:19 +1100
Message-Id: <20191217044322.351838-26-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

This activates HIOMAP support on the QEMU PowerNV machine. The PnvPnor
model is used to access the flash contents. The model simply maps the
contents at a fix offset and enables or disables the mapping.

HIOMAP Protocol description :

  https://github.com/openbmc/hiomapd/blob/master/Documentation/protocol.m=
d

Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191028070027.22752-3-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c              |   1 +
 hw/ppc/pnv_bmc.c          | 102 ++++++++++++++++++++++++++++++++++++++
 hw/ppc/pnv_lpc.c          |  13 +++++
 include/hw/ppc/pnv.h      |   1 +
 include/hw/ppc/pnv_pnor.h |   5 ++
 5 files changed, 122 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index a2a8b97330..c3ac0d6d5b 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -569,6 +569,7 @@ static void pnv_reset(MachineState *machine)
     obj =3D object_resolve_path_type("", "ipmi-bmc-sim", NULL);
     if (obj) {
         pnv->bmc =3D IPMI_BMC(obj);
+        pnv_bmc_hiomap(pnv->bmc);
     }
=20
     fdt =3D pnv_dt_create(machine);
diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
index dc5e918cb7..aa5c89586c 100644
--- a/hw/ppc/pnv_bmc.c
+++ b/hw/ppc/pnv_bmc.c
@@ -114,3 +114,105 @@ void pnv_dt_bmc_sensors(IPMIBmc *bmc, void *fdt)
                                sdr->sensor_type)));
     }
 }
+
+/*
+ * HIOMAP protocol handler
+ */
+#define HIOMAP_C_RESET                  1
+#define HIOMAP_C_GET_INFO               2
+#define HIOMAP_C_GET_FLASH_INFO         3
+#define HIOMAP_C_CREATE_READ_WINDOW     4
+#define HIOMAP_C_CLOSE_WINDOW           5
+#define HIOMAP_C_CREATE_WRITE_WINDOW    6
+#define HIOMAP_C_MARK_DIRTY             7
+#define HIOMAP_C_FLUSH                  8
+#define HIOMAP_C_ACK                    9
+#define HIOMAP_C_ERASE                  10
+#define HIOMAP_C_DEVICE_NAME            11
+#define HIOMAP_C_LOCK                   12
+
+#define BLOCK_SHIFT                     12 /* 4K */
+
+static uint16_t bytes_to_blocks(uint32_t bytes)
+{
+    return bytes >> BLOCK_SHIFT;
+}
+
+static void hiomap_cmd(IPMIBmcSim *ibs, uint8_t *cmd, unsigned int cmd_l=
en,
+                       RspBuffer *rsp)
+{
+    PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
+    PnvPnor *pnor =3D pnv->pnor;
+    uint32_t pnor_size =3D pnor->size;
+    uint32_t pnor_addr =3D PNOR_SPI_OFFSET;
+    bool readonly =3D false;
+
+    rsp_buffer_push(rsp, cmd[2]);
+    rsp_buffer_push(rsp, cmd[3]);
+
+    switch (cmd[2]) {
+    case HIOMAP_C_MARK_DIRTY:
+    case HIOMAP_C_FLUSH:
+    case HIOMAP_C_ERASE:
+    case HIOMAP_C_ACK:
+        break;
+
+    case HIOMAP_C_GET_INFO:
+        rsp_buffer_push(rsp, 2);  /* Version 2 */
+        rsp_buffer_push(rsp, BLOCK_SHIFT); /* block size */
+        rsp_buffer_push(rsp, 0);  /* Timeout */
+        rsp_buffer_push(rsp, 0);  /* Timeout */
+        break;
+
+    case HIOMAP_C_GET_FLASH_INFO:
+        rsp_buffer_push(rsp, bytes_to_blocks(pnor_size) & 0xFF);
+        rsp_buffer_push(rsp, bytes_to_blocks(pnor_size) >> 8);
+        rsp_buffer_push(rsp, 0x01);  /* erase size */
+        rsp_buffer_push(rsp, 0x00);  /* erase size */
+        break;
+
+    case HIOMAP_C_CREATE_READ_WINDOW:
+        readonly =3D true;
+        /* Fall through */
+
+    case HIOMAP_C_CREATE_WRITE_WINDOW:
+        memory_region_set_readonly(&pnor->mmio, readonly);
+        memory_region_set_enabled(&pnor->mmio, true);
+
+        rsp_buffer_push(rsp, bytes_to_blocks(pnor_addr) & 0xFF);
+        rsp_buffer_push(rsp, bytes_to_blocks(pnor_addr) >> 8);
+        rsp_buffer_push(rsp, bytes_to_blocks(pnor_size) & 0xFF);
+        rsp_buffer_push(rsp, bytes_to_blocks(pnor_size) >> 8);
+        rsp_buffer_push(rsp, 0x00); /* offset */
+        rsp_buffer_push(rsp, 0x00); /* offset */
+        break;
+
+    case HIOMAP_C_CLOSE_WINDOW:
+        memory_region_set_enabled(&pnor->mmio, false);
+        break;
+
+    case HIOMAP_C_DEVICE_NAME:
+    case HIOMAP_C_RESET:
+    case HIOMAP_C_LOCK:
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "HIOMAP: unknow command %02X\n", =
cmd[2]);
+        break;
+    }
+}
+
+#define HIOMAP   0x5a
+
+static const IPMICmdHandler hiomap_cmds[] =3D {
+    [HIOMAP] =3D { hiomap_cmd, 3 },
+};
+
+static const IPMINetfn hiomap_netfn =3D {
+    .cmd_nums =3D ARRAY_SIZE(hiomap_cmds),
+    .cmd_handlers =3D hiomap_cmds
+};
+
+int pnv_bmc_hiomap(IPMIBmc *bmc)
+{
+    return ipmi_sim_register_netfn(IPMI_BMC_SIMULATOR(bmc),
+                                   IPMI_NETFN_OEM, &hiomap_netfn);
+}
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index c5a85c38c7..dd5374c838 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -810,6 +810,7 @@ ISABus *pnv_lpc_isa_create(PnvLpcController *lpc, boo=
l use_cpld, Error **errp)
     ISABus *isa_bus;
     qemu_irq *irqs;
     qemu_irq_handler handler;
+    PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
=20
     /* let isa_bus_new() create its own bridge on SysBus otherwise
      * devices speficied on the command line won't find the bus and
@@ -834,5 +835,17 @@ ISABus *pnv_lpc_isa_create(PnvLpcController *lpc, bo=
ol use_cpld, Error **errp)
     irqs =3D qemu_allocate_irqs(handler, lpc, ISA_NUM_IRQS);
=20
     isa_bus_irqs(isa_bus, irqs);
+
+    /*
+     * TODO: Map PNOR on the LPC FW address space on demand ?
+     */
+    memory_region_add_subregion(&lpc->isa_fw, PNOR_SPI_OFFSET,
+                                &pnv->pnor->mmio);
+    /*
+     * Start disabled. The HIOMAP protocol will activate the mapping
+     * with HIOMAP_C_CREATE_WRITE_WINDOW
+     */
+    memory_region_set_enabled(&pnv->pnor->mmio, false);
+
     return isa_bus;
 }
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 5ecd3ba6ed..07c56c05ad 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -198,6 +198,7 @@ static inline bool pnv_is_power9(PnvMachineState *pnv=
)
  */
 void pnv_dt_bmc_sensors(IPMIBmc *bmc, void *fdt);
 void pnv_bmc_powerdown(IPMIBmc *bmc);
+int pnv_bmc_hiomap(IPMIBmc *bmc);
=20
 /*
  * POWER8 MMIO base addresses
diff --git a/include/hw/ppc/pnv_pnor.h b/include/hw/ppc/pnv_pnor.h
index dec811695c..c3dd28643c 100644
--- a/include/hw/ppc/pnv_pnor.h
+++ b/include/hw/ppc/pnv_pnor.h
@@ -9,6 +9,11 @@
 #ifndef _PPC_PNV_PNOR_H
 #define _PPC_PNV_PNOR_H
=20
+/*
+ * PNOR offset on the LPC FW address space
+ */
+#define PNOR_SPI_OFFSET         0x0c000000UL
+
 #define TYPE_PNV_PNOR  "pnv-pnor"
 #define PNV_PNOR(obj)  OBJECT_CHECK(PnvPnor, (obj), TYPE_PNV_PNOR)
=20
--=20
2.23.0


