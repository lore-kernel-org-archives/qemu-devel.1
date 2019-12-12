Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9345AC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:59:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60D632073B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="boHvqxge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D632073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifTgj-0007k2-RM
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:59:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ifTbv-0002VQ-59
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:54:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ifTbt-0008TR-S3
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:54:51 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31997
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ifTbt-0008Sd-N3
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:54:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576176889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HQYiAvsVMGBVlRxeNyZz9Bwr6TdosowFPcSSIBiBzwk=;
 b=boHvqxgesA8/lheEKHWyuEuts5ACjrHsbMWUCF39WIa9VRTKf3fGjuPHIRM2cCKmZbshm7
 pLyAuYrmLnD++GfZsvPbtMuEIk6zG9wgLvW/jjCaUhOvyvWLOfuytZClkU8y4+ny2DbiW6
 TjGIYO+nzoc/raA554gPexgSU5fIEG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-3kuGzv50NwK7CXzzj44rFA-1; Thu, 12 Dec 2019 13:54:45 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4C90800D4C;
 Thu, 12 Dec 2019 18:54:44 +0000 (UTC)
Received: from thuth.com (ovpn-116-168.ams2.redhat.com [10.36.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 33E1619C4F;
 Thu, 12 Dec 2019 18:54:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 07/10] hw/misc/ivshmem: Bury dead legacy INTx code
Date: Thu, 12 Dec 2019 19:54:21 +0100
Message-Id: <20191212185424.4675-8-thuth@redhat.com>
In-Reply-To: <20191212185424.4675-1-thuth@redhat.com>
References: <20191212185424.4675-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 3kuGzv50NwK7CXzzj44rFA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

Devices "ivshmem-plain" and "ivshmem-doorbell" support only MSI-X.
Config space register Interrupt Pin is zero.  Device "ivshmem"
additionally supported legacy INTx, but it was removed in commit
5a0e75f0a9 "hw/misc/ivshmem: Remove deprecated "ivshmem" legacy
device".  The commit left ivshmem_update_irq() behind.  Since the
Interrupt Pin register is zero, the function does nothing.  Remove it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191205203557.11254-1-armbru@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
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
2.18.1


