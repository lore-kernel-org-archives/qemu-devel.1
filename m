Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0F5C04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:45:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9C2A208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="TamXp5ev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C2A208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49276 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVtH8-0003p2-V4
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 03:45:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVsQq-0000qd-Tq
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:51:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVsQp-00033d-KO
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:51:28 -0400
Received: from ozlabs.org ([203.11.71.1]:60525)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hVsQp-0002uL-1I; Wed, 29 May 2019 02:51:27 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45DLv73zgQz9sPf; Wed, 29 May 2019 16:50:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559112627;
	bh=In/zhhcSNnkbkU5M1g1bCBLSGVt2Svo9eVmPwlqUPIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TamXp5ev1bVHV2H81E3o1ajeNzXGKuUHwrRZVBCdxJOM/2D+32r58vWYzaeCisWo2
	0Aw3gYwcg4cBAYaRj7uHdIHkZlYrZecyf+hwC00J59pjwYAlK1hPKTWVlSGQuOnxzM
	r6FWTnPzst3T9B1GKNwt6GZgpb7q84X3cQaW14LQ=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 29 May 2019 16:50:13 +1000
Message-Id: <20190529065017.15149-41-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529065017.15149-1-david@gibson.dropbear.id.au>
References: <20190529065017.15149-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 40/44] spapr/xive: fix multiple resets when
 using the 'dual' interrupt mode
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
	qemu-ppc@nongnu.org, clg@kaod.org,
	Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
	David Gibson <david@gibson.dropbear.id.au>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Today, when a reset occurs on a pseries machine using the 'dual'
interrupt mode, the KVM devices are released and recreated depending
on the interrupt mode selected by CAS. If XIVE is selected, the SysBus
memory regions of the SpaprXive model are initialized by the KVM
backend initialization routine each time a reset occurs. This leads to
a crash after a couple of resets because the machine reaches the
QDEV_MAX_MMIO limit of SysBusDevice :

qemu-system-ppc64: hw/core/sysbus.c:193: sysbus_init_mmio: Assertion `dev=
->num_mmio < QDEV_MAX_MMIO' failed.

To fix, initialize the SysBus memory regions in spapr_xive_realize()
called only once and remove the same inits from the QEMU and KVM
backend initialization routines which are called at each reset.

Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190522074016.10521-2-clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive.c     | 11 +++++------
 hw/intc/spapr_xive_kvm.c |  4 ----
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index f6f6c29d6a..62e0ef8fa5 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -331,12 +331,16 @@ static void spapr_xive_realize(DeviceState *dev, Er=
ror **errp)
                            xive->tm_base + XIVE_TM_USER_PAGE * (1 << TM_=
SHIFT));
=20
     qemu_register_reset(spapr_xive_reset, dev);
+
+    /* Define all XIVE MMIO regions on SysBus */
+    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xsrc->esb_mmio);
+    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &end_xsrc->esb_mmio);
+    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xive->tm_mmio);
 }
=20
 void spapr_xive_init(SpaprXive *xive, Error **errp)
 {
     XiveSource *xsrc =3D &xive->source;
-    XiveENDSource *end_xsrc =3D &xive->end_source;
=20
     /*
      * The emulated XIVE device can only be initialized once. If the
@@ -351,11 +355,6 @@ void spapr_xive_init(SpaprXive *xive, Error **errp)
     memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive_tm_ops, xi=
ve,
                           "xive.tima", 4ull << TM_SHIFT);
=20
-    /* Define all XIVE MMIO regions on SysBus */
-    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xsrc->esb_mmio);
-    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &end_xsrc->esb_mmio);
-    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xive->tm_mmio);
-
     /* Map all regions */
     spapr_xive_map_mmio(xive);
 }
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index ec170b3045..b48f135838 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -693,7 +693,6 @@ static void *kvmppc_xive_mmap(SpaprXive *xive, int pg=
off, size_t len,
 void kvmppc_xive_connect(SpaprXive *xive, Error **errp)
 {
     XiveSource *xsrc =3D &xive->source;
-    XiveENDSource *end_xsrc =3D &xive->end_source;
     Error *local_err =3D NULL;
     size_t esb_len =3D (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
     size_t tima_len =3D 4ull << TM_SHIFT;
@@ -731,12 +730,10 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **e=
rrp)
=20
     memory_region_init_ram_device_ptr(&xsrc->esb_mmio, OBJECT(xsrc),
                                       "xive.esb", esb_len, xsrc->esb_mma=
p);
-    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xsrc->esb_mmio);
=20
     /*
      * 2. END ESB pages (No KVM support yet)
      */
-    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &end_xsrc->esb_mmio);
=20
     /*
      * 3. TIMA pages - KVM mapping
@@ -749,7 +746,6 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **err=
p)
     }
     memory_region_init_ram_device_ptr(&xive->tm_mmio, OBJECT(xive),
                                       "xive.tima", tima_len, xive->tm_mm=
ap);
-    sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xive->tm_mmio);
=20
     xive->change =3D qemu_add_vm_change_state_handler(
         kvmppc_xive_change_state_handler, xive);
--=20
2.21.0


