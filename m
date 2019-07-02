Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3B1C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:31:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF69520881
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hIpGBaEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF69520881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiCJv-0006io-2a
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 02:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58734)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBzE-0005J1-Th
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBzD-0003Df-DA
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:52 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:41149 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiBzC-0003Cj-OO; Tue, 02 Jul 2019 02:09:51 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMl62V4z9sR2; Tue,  2 Jul 2019 16:09:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047747;
 bh=BoQiYE/mVURYA3U/YJzA8w1BMJeYj/dzSkDSUvcQtmw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hIpGBaEmsnZqHnnd3D5129y+f5H+nwTzuhvUGv1Wj71q/6AJDLQoAlISCMuIcGX+n
 +V4EEmkwXTv5jMz/eO4VL6hpgu9Enmq/VW1nt46Q/Bo+tTWYvpMGGVYtkSS3Vw2XYY
 9Kf8EzKLg/gI/eaaSc9Yub6GZ8AA9Wn5U/Ktc7r0=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:50 +1000
Message-Id: <20190702060857.3926-43-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 42/49] spapr_pci: Unregister listeners before
 destroying the IOMMU address space
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
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Hot-unplugging a PHB with a VFIO device connected to it crashes QEMU:

-device spapr-pci-host-bridge,index=3D1,id=3Dphb1 \
-device vfio-pci,host=3D0034:01:00.3,id=3Dvfio0

(qemu) device_del phb1
[  357.207183] iommu: Removing device 0001:00:00.0 from group 1
[  360.375523] rpadlpar_io: slot PHB 1 removed
qemu-system-ppc64: memory.c:2742:
 do_address_space_destroy: Assertion `QTAILQ_EMPTY(&as->listeners)' faile=
d.

'as' is the IOMMU address space, which indeed has a listener registered
to by vfio_connect_container() when the VFIO device is realized. This
listener is supposed to be unregistered by vfio_disconnect_container()
when the VFIO device is finalized. Unfortunately, the VFIO device hasn't
reached finalize yet at the time the PHB unrealize function is called,
and address_space_destroy() gets called with the VFIO listener still
being registered.

All regions have just been unmapped from the address space. Listeners
aren't needed anymore at this point. Remove them before destroying the
address space.

The VFIO code will try to remove them _again_ at device finalize,
but it is okay since memory_listener_unregister() is idempotent.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <156110925375.92514.11649846071216864570.stgit@bahia.lan>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
[dwg: Correct spelling error pointed out by aik]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c    |  6 ++++++
 include/exec/memory.h | 10 ++++++++++
 memory.c              |  7 +++++++
 3 files changed, 23 insertions(+)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 5591723bb2..9003fe9010 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1788,6 +1788,12 @@ static void spapr_phb_unrealize(DeviceState *dev, =
Error **errp)
=20
     memory_region_del_subregion(&sphb->iommu_root, &sphb->msiwindow);
=20
+    /*
+     * An attached PCI device may have memory listeners, eg. VFIO PCI. W=
e have
+     * unmapped all sections. Remove the listeners now, before destroyin=
g the
+     * address space.
+     */
+    address_space_remove_listeners(&sphb->iommu_as);
     address_space_destroy(&sphb->iommu_as);
=20
     qbus_set_hotplug_handler(BUS(phb->bus), NULL, &error_abort);
diff --git a/include/exec/memory.h b/include/exec/memory.h
index e6140e8a04..2c5cdffa31 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1757,6 +1757,16 @@ void address_space_init(AddressSpace *as, MemoryRe=
gion *root, const char *name);
  */
 void address_space_destroy(AddressSpace *as);
=20
+/**
+ * address_space_remove_listeners: unregister all listeners of an addres=
s space
+ *
+ * Removes all callbacks previously registered with memory_listener_regi=
ster()
+ * for @as.
+ *
+ * @as: an initialized #AddressSpace
+ */
+void address_space_remove_listeners(AddressSpace *as);
+
 /**
  * address_space_rw: read from or write to an address space.
  *
diff --git a/memory.c b/memory.c
index 0a089a73ae..480f3d989b 100644
--- a/memory.c
+++ b/memory.c
@@ -2723,6 +2723,13 @@ void memory_listener_unregister(MemoryListener *li=
stener)
     listener->address_space =3D NULL;
 }
=20
+void address_space_remove_listeners(AddressSpace *as)
+{
+    while (!QTAILQ_EMPTY(&as->listeners)) {
+        memory_listener_unregister(QTAILQ_FIRST(&as->listeners));
+    }
+}
+
 void address_space_init(AddressSpace *as, MemoryRegion *root, const char=
 *name)
 {
     memory_region_ref(root);
--=20
2.21.0


