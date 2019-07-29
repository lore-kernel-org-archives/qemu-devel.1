Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D16C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:11:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4CB32070B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="pQTJedEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4CB32070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7J1-0001QZ-W6
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38895)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs78J-0005uj-SZ
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs78I-0005kb-O2
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:00:15 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:48426)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hs78E-0004iO-8s; Mon, 29 Jul 2019 11:00:10 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id D84C596F8F;
 Mon, 29 Jul 2019 14:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564412354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IojvZJcR6TrNzXejNkbhfStORPj7CffyX3e9LR2zhu0=;
 b=pQTJedEFzSEhToYRJonGcyEJsut6kxPeewLDxgIoti8xf3Y2g4muzo7+iEpR2lAT0EKUtB
 EXOfgBkzpZZDvNvFJCH8dNKhSWSGF84dKsKt8ijRGvPZ5jtivjMp4PMlknGrfBwpS17J+m
 P3QUDPseQOJAbSQY0wtKraRR6dgTp+s=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 16:56:38 +0200
Message-Id: <20190729145654.14644-18-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729145654.14644-1-damien.hedde@greensocs.com>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564412354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IojvZJcR6TrNzXejNkbhfStORPj7CffyX3e9LR2zhu0=;
 b=Y6q5K32mpl0fpwHYvDKhkQBHZ9iVben+BD4D7MsEj4wevi2BxXlCxS60WBzQzQI2syPsE5
 dqvuB0Ar/YXxgGyRwrkuWFdv1Vhe/0I4Vmp1iSY0qyE6A5gj+ZHrTR+wjs7xmDjONZ1uQI
 9RdKGsBsUwHwOrv8spxlAYhkh4EZmno=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564412354; a=rsa-sha256; cv=none;
 b=Shawad7IqON5VSONAGP4x8Uk9zJwyF+1tn0CWqTmXEbt/2uuIttSlevf0Iy3nXAdkAcNLw
 S6FbOWr8JcI5vL2krQ9MiQalI25Q0NGXmEXseIiYQ1+yvePrMAGJQzMGciga7FEvYianf5
 dOx5CfJ3qFH9HTNIlj5AbJbbxjOY7WE=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
X-Spam: Yes
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v3 17/33] hw/usb/dev-uas.c: remove
 qdev_reset_all call
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

Replace deprecated qdev_reset_all by device_reset_warm.

This does not impact the behavior.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/usb/dev-uas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index abd8070d0c..b3a6e470e4 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -777,7 +777,7 @@ static void usb_uas_task(UASDevice *uas, uas_iu *iu)
=20
     case UAS_TMF_LOGICAL_UNIT_RESET:
         trace_usb_uas_tmf_logical_unit_reset(uas->dev.addr, tag, lun);
-        qdev_reset_all(&dev->qdev);
+        device_reset_warm(&dev->qdev);
         usb_uas_queue_response(uas, tag, UAS_RC_TMF_COMPLETE);
         break;
=20
--=20
2.22.0


