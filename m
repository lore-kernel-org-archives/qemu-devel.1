Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27E8C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DA20216C8
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="OMU9xVNA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA20216C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7FG-0001R7-T1
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38565)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs789-0005SJ-H2
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:00:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs788-0005Z4-9M
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:00:05 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:48246)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hs783-0004aI-CZ; Mon, 29 Jul 2019 10:59:59 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id D93E296F6C;
 Mon, 29 Jul 2019 14:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564412347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VqngxFE1LYSL6RUCSoBOVHLbVMhtjOBp3mEG5XVXqYg=;
 b=OMU9xVNA+PSt5AInVlh+uxBeSiV/LnfInWgsPOYIsG9gMFVlwgb1+E00wPHjnake8//zdV
 5Uw9ifoADskLKIQXDX3Rg25gkgG74YhH2FNpz1grYvUg2p6MnNxzLtSSWZryTSF1Mug3Ch
 Ci+7l15vtct895w06Sjp1iROPL/zGEI=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 16:56:33 +0200
Message-Id: <20190729145654.14644-13-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729145654.14644-1-damien.hedde@greensocs.com>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564412347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VqngxFE1LYSL6RUCSoBOVHLbVMhtjOBp3mEG5XVXqYg=;
 b=NEIDUEr6yN9tx8ViwSUPXM8koP1bG2FV/Ba141YGsZGZEUTDHYCKbyQrGiSbBA2fNvkLfv
 fHeSG7L2aHv01s3Uqzm4xJjy4II5mGtlB23KxO/0F3STlqKu6XgvMJrA8+RW5edVS/PsE+
 udsNqjC4JjhakWri4pHs/ZRzBxlTP4Y=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564412347; a=rsa-sha256; cv=none;
 b=ocHrlw543pgepaf6hD/gMKi4nwIUyiDarvDb4Ek+T0anvrLO+hYDsAaKyqUL9xdZDSpsmX
 HC/W10NKPpkNKUA1ukNndUMGbrp5GKxtc4cotBWEbzOYX5eMmqFBh7588aQXEsunVANr4k
 IsE+Qs+qeFS00JaxLv8JeA10L/eIuI4=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
X-Spam: Yes
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v3 12/33] hw/pci/: remove qdev/qbus_reset_all
 call
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
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 dmitry.fleytman@gmail.com, mst@redhat.com, mark.cave-ayland@ilande.co.uk,
 kraxel@redhat.com, edgar.iglesias@xilinx.com, hare@suse.com,
 qemu-block@nongnu.org, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, marcandre.lureau@redhat.com, rth@twiddle.net,
 thuth@redhat.com, ehabkost@redhat.com, alistair@alistair23.me,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, clg@kaod.org, jsnow@redhat.com,
 david@gibson.dropbear.id.au, Damien Hedde <damien.hedde@greensocs.com>,
 berrange@redhat.com, cohuck@redhat.com, mark.burton@greensocs.com,
 qemu-ppc@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace deprecated qdev/bus_reset_all by device/bus_reset_warm.

This does not impact the behavior.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/pci/pci.c        | 6 +++---
 hw/pci/pci_bridge.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 8076a80ab3..f2b9d37754 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -325,14 +325,14 @@ static void pci_do_device_reset(PCIDevice *dev)
  */
 void pci_device_reset(PCIDevice *dev)
 {
-    qdev_reset_all(&dev->qdev);
+    device_reset_warm(&dev->qdev);
     pci_do_device_reset(dev);
 }
=20
 /*
  * Trigger pci bus reset under a given bus.
- * Called via qbus_reset_all on RST# assert, after the devices
- * have been reset qdev_reset_all-ed already.
+ * Called via bus_reset on RST# assert, after the devices
+ * have been reset device_reset-ed already.
  */
 static void pcibus_reset(BusState *qbus)
 {
diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index 715b9a4fe6..695242149f 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -274,7 +274,7 @@ void pci_bridge_write_config(PCIDevice *d,
     newctl =3D pci_get_word(d->config + PCI_BRIDGE_CONTROL);
     if (~oldctl & newctl & PCI_BRIDGE_CTL_BUS_RESET) {
         /* Trigger hot reset on 0->1 transition. */
-        qbus_reset_all(BUS(&s->sec_bus));
+        bus_reset_warm(BUS(&s->sec_bus));
     }
 }
=20
--=20
2.22.0


