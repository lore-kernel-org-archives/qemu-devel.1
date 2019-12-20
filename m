Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9DDC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:53:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7767721D7D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUcE5I4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7767721D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiIiM-0004fI-9T
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 08:53:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iiIcJ-00036g-3e
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:46:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iiIcH-0006WX-UB
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:46:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40478
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iiIcH-0006U1-LO
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:46:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576849613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VBZVozOGLmhK3L4aUpldUk74QqpmWSp6rMd22Q/SOA0=;
 b=CUcE5I4uZYWAgYn8vZmJ1Y5XqYwwQqGgA/bt3DM3dyu6XZ+Eb/LaeDX2GuPjDYVmNnJEX+
 bzOu8gicSexnDUQQMXkDaexNly/3Fb8ld+sNhP2KOE0TVULqZnV6bPZqHitYF17PK0tBpk
 IXBLPzp85kqB8xAdr/SJbWVUH1/mXLk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-Ws4jhbqYMvSgsBQzjflWoQ-1; Fri, 20 Dec 2019 08:46:49 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C176BDBFD;
 Fri, 20 Dec 2019 13:46:48 +0000 (UTC)
Received: from localhost (ovpn-112-54.ams2.redhat.com [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F2ABE26FB3;
 Fri, 20 Dec 2019 13:46:46 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 05/37] serial-pci-multi: factor out
 multi_serial_get_port_count()
Date: Fri, 20 Dec 2019 17:45:29 +0400
Message-Id: <20191220134601.571905-6-marcandre.lureau@redhat.com>
In-Reply-To: <20191220134601.571905-1-marcandre.lureau@redhat.com>
References: <20191220134601.571905-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Ws4jhbqYMvSgsBQzjflWoQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Common function to be reused in next patch.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/char/serial-pci-multi.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index 5f13b5663b..5c553c30d0 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -77,33 +77,34 @@ static void multi_serial_irq_mux(void *opaque, int n, i=
nt level)
     pci_set_irq(&pci->dev, pending);
 }
=20
+static size_t multi_serial_get_port_count(PCIDeviceClass *pc)
+{
+    switch (pc->device_id) {
+    case 0x0003:
+        return 2;
+    case 0x0004:
+        return 4;
+    }
+
+    g_assert_not_reached();
+}
+
+
 static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
 {
     PCIDeviceClass *pc =3D PCI_DEVICE_GET_CLASS(dev);
     PCIMultiSerialState *pci =3D DO_UPCAST(PCIMultiSerialState, dev, dev);
     SerialState *s;
     Error *err =3D NULL;
-    int i, nr_ports =3D 0;
-
-    switch (pc->device_id) {
-    case 0x0003:
-        nr_ports =3D 2;
-        break;
-    case 0x0004:
-        nr_ports =3D 4;
-        break;
-    }
-    assert(nr_ports > 0);
-    assert(nr_ports <=3D PCI_SERIAL_MAX_PORTS);
+    size_t i, nports =3D multi_serial_get_port_count(pc);
=20
     pci->dev.config[PCI_CLASS_PROG] =3D pci->prog_if;
     pci->dev.config[PCI_INTERRUPT_PIN] =3D 0x01;
-    memory_region_init(&pci->iobar, OBJECT(pci), "multiserial", 8 * nr_por=
ts);
+    memory_region_init(&pci->iobar, OBJECT(pci), "multiserial", 8 * nports=
);
     pci_register_bar(&pci->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &pci->iobar)=
;
-    pci->irqs =3D qemu_allocate_irqs(multi_serial_irq_mux, pci,
-                                   nr_ports);
+    pci->irqs =3D qemu_allocate_irqs(multi_serial_irq_mux, pci, nports);
=20
-    for (i =3D 0; i < nr_ports; i++) {
+    for (i =3D 0; i < nports; i++) {
         s =3D pci->state + i;
         s->baudbase =3D 115200;
         serial_realize_core(s, &err);
@@ -113,7 +114,7 @@ static void multi_serial_pci_realize(PCIDevice *dev, Er=
ror **errp)
             return;
         }
         s->irq =3D pci->irqs[i];
-        pci->name[i] =3D g_strdup_printf("uart #%d", i + 1);
+        pci->name[i] =3D g_strdup_printf("uart #%zu", i + 1);
         memory_region_init_io(&s->io, OBJECT(pci), &serial_io_ops, s,
                               pci->name[i], 8);
         memory_region_add_subregion(&pci->iobar, 8 * i, &s->io);
--=20
2.24.0.308.g228f53135a


