Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D813C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:10:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37E1B2070B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="jnmf5LB0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E1B2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7IT-0000Kx-Hj
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38746)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs78E-0005dL-0p
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:00:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs78D-0005eZ-1W
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:00:09 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:49048)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hs784-0005RC-FW; Mon, 29 Jul 2019 11:00:00 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id AFFD696F92;
 Mon, 29 Jul 2019 14:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564412357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FGORLyVsyoPn4CUafp3DkuY7BxPSGvVkEp7R/gpfDbs=;
 b=jnmf5LB0kusot6raukquz8lPwMXc9zV2FeRAcofzOXMmmKd1jRsLpvbl1ViZVyEcCbQUCS
 SO27AlK946/F7M4vxFkmM/9qNwA8kgdMEjhsr2hrh4Gj0XCf1iJJ0t/rIDAMlf7awXDESB
 lNlyPzqbxMQjKEK9UqGe50uy8ekVJH4=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 16:56:40 +0200
Message-Id: <20190729145654.14644-20-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729145654.14644-1-damien.hedde@greensocs.com>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564412357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FGORLyVsyoPn4CUafp3DkuY7BxPSGvVkEp7R/gpfDbs=;
 b=q5cGZv9a88zJSmVzplwAzjUVhIJHdAvvuXY7RDQKi0spMb8RJnXTHDtqA15PQXW191hF8t
 mpLVE8crYPSdbnZXwyYCn9FyqUOHfivKfjJ3BG4jpQFEoL0sSiAR+oH2zPStSKkGur++Zq
 Ab4Za56t/pZ5MWIGuYlhKpZoVXuPg0o=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564412357; a=rsa-sha256; cv=none;
 b=FtKC4bRy9kmEhgoLjr1bG0ETU+E8zZFLMB357yCR7zcqjaZF5mw0C2ENCSoCpsvRCPI4pw
 EaUYswGtSd0myspPdUDHgt5w/XbfrH86+Js6XbT9FVboqD0zqKib83cLZxH8UuLyzg6fHS
 z0kl7zQfD9efR2Zoo0mB59Ko/MpZW0Y=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
X-Spam: Yes
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v3 19/33] hw/sd/pl181.c & omap_mmc.c: remove
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

The new function propagates also the reset to the sub-buses tree but this=
 has
no impact since SDState has no child bus.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/sd/omap_mmc.c | 2 +-
 hw/sd/pl181.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index 24a1edc149..3021e54b8d 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -317,7 +317,7 @@ void omap_mmc_reset(struct omap_mmc_s *host)
      * into any bus, and we must reset it manually. When omap_mmc is
      * QOMified this must move into the QOM reset function.
      */
-    device_legacy_reset(DEVICE(host->card));
+    device_reset_warm(DEVICE(host->card));
 }
=20
 static uint64_t omap_mmc_read(void *opaque, hwaddr offset,
diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index 15b4aaa67f..a59ef7eb2a 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -480,7 +480,7 @@ static void pl181_reset(DeviceState *d)
     /* Since we're still using the legacy SD API the card is not plugged
      * into any bus, and we must reset it manually.
      */
-    device_legacy_reset(DEVICE(s->card));
+    device_reset_warm(DEVICE(s->card));
 }
=20
 static void pl181_init(Object *obj)
--=20
2.22.0


