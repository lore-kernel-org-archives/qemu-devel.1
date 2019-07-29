Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688CFC7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:09:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 387B42070B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="3ZGy/9vp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387B42070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7HU-0006L1-Fq
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38172)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs77X-0004Kz-AX
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:59:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs77T-0004pi-5i
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:59:25 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:48220)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hs77D-0004ZC-Cw; Mon, 29 Jul 2019 10:59:07 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id 7548296F68;
 Mon, 29 Jul 2019 14:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564412345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6BYZlTqXFaSTVHfhpxHCxDjaR213vN7XZdOsvKiNxUA=;
 b=3ZGy/9vpKbQy9Dtyg6v2JIvek4NUmM2DVlo1R+3rmd1+QxCBOWVBWq1cRg7PAzCUumBppq
 fNEUCmJRJwq3XVG656PNv3C5lkPlmkOweGWywia+P3/kV6e4Ln9M94QUgtHQynBIzPRBtN
 dbL6HH6ioZIxnKpMNdmMhMhEZ620SXk=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 16:56:32 +0200
Message-Id: <20190729145654.14644-12-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729145654.14644-1-damien.hedde@greensocs.com>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564412345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6BYZlTqXFaSTVHfhpxHCxDjaR213vN7XZdOsvKiNxUA=;
 b=qkrEF5itTmFRRH9M7llbzZQK88uW0GC0w4HegGZRw8tNe2edblo2uLbQhsoF57AMh5w14w
 +kRiBqzpy3yWOxWXRVpUrYg2qo0Tqg9RzAnu+ci2ASQ8Ns263yedN3ABQQImAgMeVnP7IC
 nJA57zCYrjgmSud54Lnccxq1l7wb/Zg=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564412345; a=rsa-sha256; cv=none;
 b=Q30jrPAQb7NLdpZtgzV7vTFOOqRYGwSsbCsFzkI/Vx+6m5FfT9KxHio6wCPyDMLzUMgbz5
 +cWhfOvZjsGIKNX2AktGR6IvKkj/YMR51/8UaQ0B7L8+bL2SOzfTCqDvYgnNtTZSmE+/89
 IvJDPrAnlk9+EF2LgeuQEDSiPuofODM=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
X-Spam: Yes
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v3 11/33] hw/s390x/ipl.c: remove qbus_reset_all
 registration
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

Replace deprecated qbus_reset_all by resettable_reset_cold_fn for
the ipl registration in the main reset handlers.

This does not impact the behavior.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/s390x/ipl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 60bd081d3e..402770a2c9 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -234,7 +234,11 @@ static void s390_ipl_realize(DeviceState *dev, Error=
 **errp)
      */
     ipl->compat_start_addr =3D ipl->start_addr;
     ipl->compat_bios_start_addr =3D ipl->bios_start_addr;
-    qemu_register_reset(qdev_reset_all_fn, dev);
+    /*
+     * TODO: when we add some kind of main reset container / domain
+     * switch to it to really benefit from multi-phase.
+     */
+    qemu_register_reset(resettable_reset_cold_fn, dev);
 error:
     error_propagate(errp, err);
 }
--=20
2.22.0


