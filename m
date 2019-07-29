Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57893C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2573F21655
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="YP06WmN5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2573F21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7LR-0007M0-At
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39571)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs798-0007Ed-GR
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:01:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs796-0006UN-Vc
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:01:06 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:49060)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hs78u-0005Tt-Jg; Mon, 29 Jul 2019 11:00:53 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id B548C96FB5;
 Mon, 29 Jul 2019 14:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564412364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HGGw8htxAIJ95suMEQmcO6Wzd1brwHWaCoaPQS+mZIU=;
 b=YP06WmN5WHD07/jTlSfgGa2nWOwGCoxKQ29sH5FnKn+wLQkrsEyxQ3RpGrtflRvGIeOY/0
 uSlOOmTqBYb28Ewuotd6J6KyjCqoRuqyeP7sSODZ0AUyEOPdCV7naf6ox+GEVLZjuyhyoZ
 ie6Pljdmt/2KuzCubwwI0I9RXOCoET0=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 16:56:45 +0200
Message-Id: <20190729145654.14644-25-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729145654.14644-1-damien.hedde@greensocs.com>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564412364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HGGw8htxAIJ95suMEQmcO6Wzd1brwHWaCoaPQS+mZIU=;
 b=reTUCletLFNrKr/Uq1GGJmGv1saXk6XjI/CGClamgkcyVUgVlsMD/giMejo5bKjbPqSTn0
 KMRPHcBIjfgyLegvWOqGSzEbL83Ulc3T2ThmjkjX+cPaGyqeQSLI0qbk2LUYlJQGivn4fB
 8Va9ei3TKcadVCUpx+0kmYe3EB1wpXg=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564412364; a=rsa-sha256; cv=none;
 b=6aaXPMsz8Ptck4nIylbhGiRj23zMRZw+Lc39uayZpSEP5/UCClf1lm7Qghd8RvpiBrGptv
 fFtSreD331DPl0f6Blhgy1q9qNfOrO1txu7SNLET0qTPueOsAmOyW32dosXoQrwtxFsbaf
 G0mnCJIsGbqFIgLXZ6l4CF2M6Sf2TaI=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
X-Spam: Yes
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v3 24/33] hw/ppc/spapr: remove
 device_legacy_reset call
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

Replace legacy's reset call by device_reset_warm.

The new function propagates also the reset to the sub-buses tree.

In spapr_vio.c, the function resets a SpaprtceTable which does not seem
to have child bus so it should have no impact.

In Spapr_pci.c the functions resets QOM children devices of a SpaprPhbSta=
te.
If there is a device with a child bus, then this bus will now be reset
(and all its qdev tree).

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/ppc/spapr_pci.c | 2 +-
 hw/ppc/spapr_vio.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 3c6cf79a5e..946b2b4483 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2029,7 +2029,7 @@ static int spapr_phb_children_reset(Object *child, =
void *opaque)
     DeviceState *dev =3D (DeviceState *) object_dynamic_cast(child, TYPE=
_DEVICE);
=20
     if (dev) {
-        device_legacy_reset(dev);
+        device_reset_warm(dev);
     }
=20
     return 0;
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 5a0b5cc35c..41c17cfdd6 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -306,7 +306,7 @@ int spapr_vio_send_crq(SpaprVioDevice *dev, uint8_t *=
crq)
 static void spapr_vio_quiesce_one(SpaprVioDevice *dev)
 {
     if (dev->tcet) {
-        device_legacy_reset(DEVICE(dev->tcet));
+        device_reset_warm(DEVICE(dev->tcet));
     }
     free_crq(dev);
 }
--=20
2.22.0


