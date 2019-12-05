Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C8EC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 20:37:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E3B1205F4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 20:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKyRA/wy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3B1205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icxs3-00073Z-EP
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 15:37:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1icxr9-0006cN-Iz
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 15:36:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1icxr6-0004yr-A8
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 15:36:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59868
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1icxr2-0004ux-Go
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 15:36:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575578161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yBzWoUW3abdp+FwlbG70WgdbJzP+AgNQr9jNH42YMRM=;
 b=hKyRA/wy8eSnDwCct39PkhI30oyRWJyRXYw9rRsfN9rMtDyJrPbP1GKX9BQxEyiNXkmOjH
 Q1oMj7KWn1uM1KVDGkdeYSZWuNgGYDSpgXatxeOEHtD6nKOTVtEC1W3GhiRVvzT1cbjJvo
 vBWaLVJqPkp83zEoO2TMQHP9HBVt3NY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-Ost6BxqnOhiyzX2q_ULzig-1; Thu, 05 Dec 2019 15:36:00 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59386107ACC9
 for <qemu-devel@nongnu.org>; Thu,  5 Dec 2019 20:35:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 294005C240;
 Thu,  5 Dec 2019 20:35:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 95A2C1138606; Thu,  5 Dec 2019 21:35:57 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/misc/ivshmem: Bury dead legacy INTx code
Date: Thu,  5 Dec 2019 21:35:57 +0100
Message-Id: <20191205203557.11254-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Ost6BxqnOhiyzX2q_ULzig-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Devices "ivshmem-plain" and "ivshmem-doorbell" support only MSI-X.
Config space register Interrupt Pin is zero.  Device "ivshmem"
additionally supported legacy INTx, but it was removed in commit
5a0e75f0a9 "hw/misc/ivshmem: Remove deprecated "ivshmem" legacy
device".  The commit left ivshmem_update_irq() behind.  Since the
Interrupt Pin register is zero, the function does nothing.  Remove it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/misc/ivshmem.c | 35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 5e3b05eae0..710cdb7263 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -136,44 +136,11 @@ static inline bool ivshmem_is_master(IVShmemState *s)
     return s->master =3D=3D ON_OFF_AUTO_ON;
 }
=20
-static void ivshmem_update_irq(IVShmemState *s)
-{
-    PCIDevice *d =3D PCI_DEVICE(s);
-    uint32_t isr =3D s->intrstatus & s->intrmask;
-
-    /*
-     * Do nothing unless the device actually uses INTx.  Here's how
-     * the device variants signal interrupts, what they put in PCI
-     * config space:
-     * Device variant    Interrupt  Interrupt Pin  MSI-X cap.
-     * ivshmem-plain         none            0         no
-     * ivshmem-doorbell     MSI-X            1        yes(1)
-     * ivshmem,msi=3Doff       INTx            1         no
-     * ivshmem,msi=3Don       MSI-X            1(2)     yes(1)
-     * (1) if guest enabled MSI-X
-     * (2) the device lies
-     * Leads to the condition for doing nothing:
-     */
-    if (ivshmem_has_feature(s, IVSHMEM_MSI)
-        || !d->config[PCI_INTERRUPT_PIN]) {
-        return;
-    }
-
-    /* don't print ISR resets */
-    if (isr) {
-        IVSHMEM_DPRINTF("Set IRQ to %d (%04x %04x)\n",
-                        isr ? 1 : 0, s->intrstatus, s->intrmask);
-    }
-
-    pci_set_irq(d, isr !=3D 0);
-}
-
 static void ivshmem_IntrMask_write(IVShmemState *s, uint32_t val)
 {
     IVSHMEM_DPRINTF("IntrMask write(w) val =3D 0x%04x\n", val);
=20
     s->intrmask =3D val;
-    ivshmem_update_irq(s);
 }
=20
 static uint32_t ivshmem_IntrMask_read(IVShmemState *s)
@@ -189,7 +156,6 @@ static void ivshmem_IntrStatus_write(IVShmemState *s, u=
int32_t val)
     IVSHMEM_DPRINTF("IntrStatus write(w) val =3D 0x%04x\n", val);
=20
     s->intrstatus =3D val;
-    ivshmem_update_irq(s);
 }
=20
 static uint32_t ivshmem_IntrStatus_read(IVShmemState *s)
@@ -198,7 +164,6 @@ static uint32_t ivshmem_IntrStatus_read(IVShmemState *s=
)
=20
     /* reading ISR clears all interrupts */
     s->intrstatus =3D 0;
-    ivshmem_update_irq(s);
     return ret;
 }
=20
--=20
2.21.0


