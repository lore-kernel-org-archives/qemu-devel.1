Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBBFC072A4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 07:42:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B38520863
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 07:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B38520863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37822 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTLt9-00058m-AR
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 03:42:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hTLrh-0003yB-8E
	for qemu-devel@nongnu.org; Wed, 22 May 2019 03:40:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hTLrc-0002Rb-K2
	for qemu-devel@nongnu.org; Wed, 22 May 2019 03:40:42 -0400
Received: from 8.mo4.mail-out.ovh.net ([188.165.33.112]:50025)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hTLra-0002GH-IA
	for qemu-devel@nongnu.org; Wed, 22 May 2019 03:40:40 -0400
Received: from player761.ha.ovh.net (unknown [10.108.57.153])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id CE5801F28F7
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 09:40:34 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player761.ha.ovh.net (Postfix) with ESMTPSA id AD3B5609C884;
	Wed, 22 May 2019 07:40:26 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 May 2019 09:40:15 +0200
Message-Id: <20190522074016.10521-2-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522074016.10521-1-clg@kaod.org>
References: <20190522074016.10521-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 18226630644379061222
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudduuddguddvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.33.112
Subject: [Qemu-devel] [PATCH 1/2] spapr/xive: fix multiple resets when using
 the 'dual' interrupt mode
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	Greg Kurz <groug@kaod.org>,
	Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 hw/intc/spapr_xive.c     | 11 +++++------
 hw/intc/spapr_xive_kvm.c |  4 ----
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index f6f6c29d6ae4..62e0ef8fa5b4 100644
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
index ec170b304555..b48f135838f2 100644
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
2.20.1


