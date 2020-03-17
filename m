Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B80C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:29:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 196A820714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmZjzwyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196A820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jELeo-0001gH-5b
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 19:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52975)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jELZR-0000Ix-Oo
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jELZQ-0003qb-Mj
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:24:25 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:49855)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jELZQ-0003m9-Hi
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584487464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GnwRsDX6VExlAm3qYZrwhrxhhISuBQagwjpeLuR/TMk=;
 b=UmZjzwyO7nSgzi3g2oCm2czRqTU5LK8vTiWg2450WD3Xtwvc58+4Jp+LG32V8EEX3UZC+J
 X4NocQp2bGd9eyflvhwOnpNuEPMO3mfm2dK4MOvVWEj/7+1oFl3AW18detAhyHfqkTKebD
 dMmVuZwjPF+EqyB14qrm7PEM+o0Ocy8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-LZDidgCQMlSsSsbeIYTDFQ-1; Tue, 17 Mar 2020 19:24:22 -0400
X-MC-Unique: LZDidgCQMlSsSsbeIYTDFQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42210100550D;
 Tue, 17 Mar 2020 23:24:20 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1ACA660BE0;
 Tue, 17 Mar 2020 23:24:12 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 07/20] pci: Honour wmask when resetting PCI_INTERRUPT_LINE
Date: Tue, 17 Mar 2020 19:23:16 -0400
Message-Id: <20200317232329.22362-8-jsnow@redhat.com>
In-Reply-To: <20200317232329.22362-1-jsnow@redhat.com>
References: <20200317232329.22362-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-block@nongnu.org,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: BALATON Zoltan <balaton@eik.bme.hu>

The pci_do_device_reset() function (called from pci_device_reset)
clears the PCI_INTERRUPT_LINE config reg of devices on the bus but did
this without taking wmask into account. We'll have a device model now
that needs to set a constant value for this reg and this patch allows
to do that without additional workaround in device emulation to
reverse the effect of this PCI bus reset function.

Suggested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-id: 20200313082444.2439-4-mark.cave-ayland@ilande.co.uk
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/pci/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index e1ed6677e1..b5bc842fac 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -302,8 +302,11 @@ static void pci_do_device_reset(PCIDevice *dev)
     pci_word_test_and_clear_mask(dev->config + PCI_STATUS,
                                  pci_get_word(dev->wmask + PCI_STATUS) |
                                  pci_get_word(dev->w1cmask + PCI_STATUS));
+    /* Some devices make bits of PCI_INTERRUPT_LINE read only */
+    pci_byte_test_and_clear_mask(dev->config + PCI_INTERRUPT_LINE,
+                              pci_get_word(dev->wmask + PCI_INTERRUPT_LINE=
) |
+                              pci_get_word(dev->w1cmask + PCI_INTERRUPT_LI=
NE));
     dev->config[PCI_CACHE_LINE_SIZE] =3D 0x0;
-    dev->config[PCI_INTERRUPT_LINE] =3D 0x0;
     for (r =3D 0; r < PCI_NUM_REGIONS; ++r) {
         PCIIORegion *region =3D &dev->io_regions[r];
         if (!region->size) {
--=20
2.21.1


