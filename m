Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8281BC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:13:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E6072072D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="lrb6Qnui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6072072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5AV-0006jC-4E
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:13:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4ix-0000za-CD
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4iv-0006Qi-Sc
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:44:43 -0500
Received: from ozlabs.org ([203.11.71.1]:54963)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4iv-0005wV-HP; Mon, 16 Dec 2019 23:44:41 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWX70nMz9sT5; Tue, 17 Dec 2019 15:43:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557816;
 bh=ZHXb/8Y5KCzTAlhr35nTDdW8rY7WydhcNYlDpNpq9Fg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lrb6Qnui1lfZB0SpmkApQuiebAzDpQmZEqWqiFcbS/DOI0h5//cpaHymdskfvPlqq
 ZY9Gs24cpqQc+RgmZaIcffsY20jovjItklzGz+BAvlVhYOxlP9xxPdRZZqfr0Bju6I
 QGOT38qtlJlSppX5Du762rhkCtpLMMz+l5hDqNdM=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 44/88] ppc/xive: Move the TIMA operations to the controller
 model
Date: Tue, 17 Dec 2019 15:42:38 +1100
Message-Id: <20191217044322.351838-45-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

On the P9 Processor, the thread interrupt context registers of a CPU
can be accessed "directly" when by load/store from the CPU or
"indirectly" by the IC through an indirect TIMA page. This requires to
configure first the PC_TCTXT_INDIRx registers.

Today, we rely on the get_tctx() handler to deduce from the CPU PIR
the chip from which the TIMA access is being done. By handling the
TIMA memory ops under the interrupt controller model of each machine,
we can uniformize the TIMA direct and indirect ops under PowerNV. We
can also check that the CPUs have been enabled in the XIVE controller.

This prepares ground for the future versions of XIVE.

Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191125065820.927-15-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/pnv_xive.c    | 35 ++++++++++++++++++++++++++++++++++-
 hw/intc/spapr_xive.c  | 33 +++++++++++++++++++++++++++++++--
 hw/intc/xive.c        | 29 -----------------------------
 include/hw/ppc/xive.h |  1 -
 4 files changed, 65 insertions(+), 33 deletions(-)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index db9d9c11a8..c14a2d1869 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -1467,6 +1467,39 @@ static const MemoryRegionOps xive_tm_indirect_ops =
=3D {
     },
 };
=20
+static void pnv_xive_tm_write(void *opaque, hwaddr offset,
+                              uint64_t value, unsigned size)
+{
+    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
+    PnvXive *xive =3D pnv_xive_tm_get_xive(cpu);
+    XiveTCTX *tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
+
+    xive_tctx_tm_write(XIVE_PRESENTER(xive), tctx, offset, value, size);
+}
+
+static uint64_t pnv_xive_tm_read(void *opaque, hwaddr offset, unsigned s=
ize)
+{
+    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
+    PnvXive *xive =3D pnv_xive_tm_get_xive(cpu);
+    XiveTCTX *tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
+
+    return xive_tctx_tm_read(XIVE_PRESENTER(xive), tctx, offset, size);
+}
+
+const MemoryRegionOps pnv_xive_tm_ops =3D {
+    .read =3D pnv_xive_tm_read,
+    .write =3D pnv_xive_tm_write,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+    .valid =3D {
+        .min_access_size =3D 1,
+        .max_access_size =3D 8,
+    },
+    .impl =3D {
+        .min_access_size =3D 1,
+        .max_access_size =3D 8,
+    },
+};
+
 /*
  * Interrupt controller XSCOM region.
  */
@@ -1809,7 +1842,7 @@ static void pnv_xive_realize(DeviceState *dev, Erro=
r **errp)
                           "xive-pc", PNV9_XIVE_PC_SIZE);
=20
     /* Thread Interrupt Management Area (Direct) */
-    memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive_tm_ops,
+    memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &pnv_xive_tm_ops=
,
                           xive, "xive-tima", PNV9_XIVE_TM_SIZE);
=20
     qemu_register_reset(pnv_xive_reset, dev);
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 18a043a277..40891543e0 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -205,6 +205,35 @@ void spapr_xive_mmio_set_enabled(SpaprXive *xive, bo=
ol enable)
     memory_region_set_enabled(&xive->end_source.esb_mmio, false);
 }
=20
+static void spapr_xive_tm_write(void *opaque, hwaddr offset,
+                          uint64_t value, unsigned size)
+{
+    XiveTCTX *tctx =3D spapr_cpu_state(POWERPC_CPU(current_cpu))->tctx;
+
+    xive_tctx_tm_write(XIVE_PRESENTER(opaque), tctx, offset, value, size=
);
+}
+
+static uint64_t spapr_xive_tm_read(void *opaque, hwaddr offset, unsigned=
 size)
+{
+    XiveTCTX *tctx =3D spapr_cpu_state(POWERPC_CPU(current_cpu))->tctx;
+
+    return xive_tctx_tm_read(XIVE_PRESENTER(opaque), tctx, offset, size)=
;
+}
+
+const MemoryRegionOps spapr_xive_tm_ops =3D {
+    .read =3D spapr_xive_tm_read,
+    .write =3D spapr_xive_tm_write,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+    .valid =3D {
+        .min_access_size =3D 1,
+        .max_access_size =3D 8,
+    },
+    .impl =3D {
+        .min_access_size =3D 1,
+        .max_access_size =3D 8,
+    },
+};
+
 static void spapr_xive_end_reset(XiveEND *end)
 {
     memset(end, 0, sizeof(*end));
@@ -314,8 +343,8 @@ static void spapr_xive_realize(DeviceState *dev, Erro=
r **errp)
     qemu_register_reset(spapr_xive_reset, dev);
=20
     /* TIMA initialization */
-    memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive_tm_ops, xi=
ve,
-                          "xive.tima", 4ull << TM_SHIFT);
+    memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &spapr_xive_tm_o=
ps,
+                          xive, "xive.tima", 4ull << TM_SHIFT);
     sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xive->tm_mmio);
=20
     /*
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 9e7e5ea57c..0ca7099f4e 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -523,35 +523,6 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, Xive=
TCTX *tctx, hwaddr offset,
     return xive_tm_raw_read(tctx, offset, size);
 }
=20
-static void xive_tm_write(void *opaque, hwaddr offset,
-                          uint64_t value, unsigned size)
-{
-    XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), current=
_cpu);
-
-    xive_tctx_tm_write(XIVE_PRESENTER(opaque), tctx, offset, value, size=
);
-}
-
-static uint64_t xive_tm_read(void *opaque, hwaddr offset, unsigned size)
-{
-    XiveTCTX *tctx =3D xive_router_get_tctx(XIVE_ROUTER(opaque), current=
_cpu);
-
-    return xive_tctx_tm_read(XIVE_PRESENTER(opaque), tctx, offset, size)=
;
-}
-
-const MemoryRegionOps xive_tm_ops =3D {
-    .read =3D xive_tm_read,
-    .write =3D xive_tm_write,
-    .endianness =3D DEVICE_BIG_ENDIAN,
-    .valid =3D {
-        .min_access_size =3D 1,
-        .max_access_size =3D 8,
-    },
-    .impl =3D {
-        .min_access_size =3D 1,
-        .max_access_size =3D 8,
-    },
-};
-
 static char *xive_tctx_ring_print(uint8_t *ring)
 {
     uint32_t w2 =3D xive_tctx_word2(ring);
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 97bbcddb38..dcf8974515 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -462,7 +462,6 @@ typedef struct XiveENDSource {
 #define XIVE_TM_OS_PAGE         0x2
 #define XIVE_TM_USER_PAGE       0x3
=20
-extern const MemoryRegionOps xive_tm_ops;
 void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offs=
et,
                         uint64_t value, unsigned size);
 uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr o=
ffset,
--=20
2.23.0


