Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4869BC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 15:46:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A1752082E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 15:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A1752082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38951 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEyNu-0000JA-8I
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 11:46:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hEyF7-0000J5-4f
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:37:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hEyF5-0001Wh-DO
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:37:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hEyF2-0001Qp-6s; Fri, 12 Apr 2019 11:37:25 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3CDB2308621C;
	Fri, 12 Apr 2019 15:37:15 +0000 (UTC)
Received: from localhost (ovpn-112-59.ams2.redhat.com [10.36.112.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B35AD19738;
	Fri, 12 Apr 2019 15:37:06 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 12 Apr 2019 17:36:36 +0200
Message-Id: <20190412153647.19027-3-marcandre.lureau@redhat.com>
In-Reply-To: <20190412153647.19027-1-marcandre.lureau@redhat.com>
References: <20190412153647.19027-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Fri, 12 Apr 2019 15:37:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 02/13] spapr_pci: Fix broken naming of PCI
 bus
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Greg Kurz <groug@kaod.org>,
	qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190412153636.90UOh1BZgeilQ_CbCp_r6yiqc00FJ7QfTYWCOfAOOWg@z>

From: Greg Kurz <groug@kaod.org>

Recent commit 5cf0d326a0fe fixed a regression which was preventing the
guest to access the extended config space of a PCIe device. This was
done by introducing a new PCI bus subtype for PAPR. The original fix
was causing PCI busses to be named "spapr-pci-host-bridge-root-bus.N"
instead of "pci.N", which was making upper layers unhappy of course.
This got worked around by hardcoding the PCI bus name to "pci.0", but
this only works for the default PHB. And we're now hitting:

# qemu-system-ppc64 \
             -device spapr-pci-host-bridge,index=3D1 \
             -device e1000e,bus=3Dpci.0 \
             -device e1000e,bus=3Dpci.1
qemu-system-ppc64: -device e1000e,bus=3Dpci.1: Bus 'pci.1' not found

David already posted some patches [1] to control PCI extended config
space accesses with a new flag in the base PCI bus class instead of
subtyping. These patches are a bit more intrusive though, and
are targetted for 4.1.

When no name is passed to pci_register_bus(), the core device code
generates a lowercase name based on the QOM typename. The typename
for the base PCI bus class is "PCI", hence the "pci.0", "pci.1"
bus names. Rename the type of the PAPR PCI bus to "pci", so that
the QOM code can generate proper names. This is a hack but it is
enough to fix the regression. And all this will be reworked properly
in 4.1.

[1] https://patchwork.ozlabs.org/project/qemu-devel/list/?series=3D100486

Fixes: 5cf0d326a0fe
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155500034416.646888.1307366522340665522.stgit@bahia.lab.toul=
ouse-stg.fr.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index f0b6b23afc..f62e6833b8 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1652,7 +1652,7 @@ static void spapr_phb_root_bus_class_init(ObjectCla=
ss *klass, void *data)
     pbc->allows_extended_config_space =3D spapr_phb_allows_extended_conf=
ig_space;
 }
=20
-#define TYPE_SPAPR_PHB_ROOT_BUS "spapr-pci-host-bridge-root-bus"
+#define TYPE_SPAPR_PHB_ROOT_BUS "pci"
=20
 static const TypeInfo spapr_phb_root_bus_info =3D {
     .name =3D TYPE_SPAPR_PHB_ROOT_BUS,
@@ -1761,7 +1761,7 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
     memory_region_add_subregion(get_system_memory(), sphb->io_win_addr,
                                 &sphb->iowindow);
=20
-    bus =3D pci_register_root_bus(dev, "pci.0",
+    bus =3D pci_register_root_bus(dev, NULL,
                                 pci_spapr_set_irq, pci_spapr_map_irq, sp=
hb,
                                 &sphb->memspace, &sphb->iospace,
                                 PCI_DEVFN(0, 0), PCI_NUM_PINS,
--=20
2.21.0.313.ge35b8cb8e2


