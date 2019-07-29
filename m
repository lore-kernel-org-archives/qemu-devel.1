Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23081C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:06:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E476D216C8
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="kGJsb5r2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E476D216C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7E2-0007ln-4p
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38609)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs78A-0005Vy-QG
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:00:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs789-0005aQ-MZ
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:00:06 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:49050)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hs784-0005RB-Fp; Mon, 29 Jul 2019 11:00:00 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id 4D14496F8E;
 Mon, 29 Jul 2019 14:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564412355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1IcmTa6ZKW/z4Jx3NrXrLMXyWQItUUT4uM9Fbt082nk=;
 b=kGJsb5r2TQPh4AeCIdCB5Qzktp39BcQt2H0Gt7oOG4ke7McCWnh86aPOKqQsOAE9SBfRCV
 dTmeVoHGkSrmJXcOlCs6BYdv9rW/+ALcn45k6JSk/3zG8bBCFh1MMYsQeDCE0AdCqwPVha
 GdH0oQl+in0CAQHFqYPPbuaWUemw6Hc=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 16:56:39 +0200
Message-Id: <20190729145654.14644-19-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729145654.14644-1-damien.hedde@greensocs.com>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564412355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1IcmTa6ZKW/z4Jx3NrXrLMXyWQItUUT4uM9Fbt082nk=;
 b=Z24LGGv2BLyH75b14UHx+FfmhKjVUmmitwbZ9Zu8nb9PlgFrSfOMaEb7RKnvA5dZhXDOlI
 uaeppMxaN/NV+V5Jmb0xF5O17tDIBjMGC9UeABlarXR2Cw5QfbRLD2ysOWKKqLn9/OvR7v
 OUDd+lmNAld1cuochbH/YrsGYgIArqQ=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564412355; a=rsa-sha256; cv=none;
 b=6jwmvBOPhgmR+MptX9yyEXkwvsonDOItuhfibT+jtnmm0MgPHyPjuAvdZFgJq83IAN/xyb
 f69FL/4u9AYd0vPIxMZqgvuQCtpDpgwsQAUU6dxeHcYxu913ficLneapQqL3IRdkcVj2al
 UAAdJBK92dHKTmqS9PiLTXdRebxH91k=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
X-Spam: Yes
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v3 18/33] hw/audio/intel-hda.c: remove
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
no impact since since HDACodecDevice has no child bus.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/audio/intel-hda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index f133684b10..523bb3e2ca 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -1086,7 +1086,7 @@ static void intel_hda_reset(DeviceState *dev)
     QTAILQ_FOREACH(kid, &d->codecs.qbus.children, sibling) {
         DeviceState *qdev =3D kid->child;
         cdev =3D HDA_CODEC_DEVICE(qdev);
-        device_legacy_reset(DEVICE(cdev));
+        device_reset_warm(DEVICE(cdev));
         d->state_sts |=3D (1 << cdev->cad);
     }
     intel_hda_update_irq(d);
--=20
2.22.0


