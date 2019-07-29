Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A51C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:09:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 900EA2070B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="RbEw7tAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 900EA2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7Gu-0005BJ-AM
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38805)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs78G-0005lB-MI
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:00:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs78B-0005cx-PV
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:00:12 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:49054)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hs785-0005S3-Il; Mon, 29 Jul 2019 11:00:01 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id 7CC6A96F98;
 Mon, 29 Jul 2019 14:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564412359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MabvMRXMXvglNHuMuwjz05sk4mSZqL5kEppHHuUwOes=;
 b=RbEw7tAydVp6/nppEq6nCc6ol8nkZTCHV19A4QJmuGWul57V30AGOyO/52vuGMABdYRQMC
 7iK91DSQatfT+pjryv5+tM2e///hsymOb2yA8aPDXXTezQlHRp0HnGfX0MBoLzIdwo1me2
 zaIXpoY5jwGJDYHE5wzY+VyM0SvCo9s=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 16:56:42 +0200
Message-Id: <20190729145654.14644-22-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729145654.14644-1-damien.hedde@greensocs.com>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564412359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MabvMRXMXvglNHuMuwjz05sk4mSZqL5kEppHHuUwOes=;
 b=xsE9+Q0d0dyv+xkvkMqr06WnTZSFzaN1kShGpwHQkCFv50Dep2t1+OIUlchuzljU+I5+al
 lEbBf8W1F24hHA9JAHUW6uB3vJN5DNdh9c5RZlw1FzbD+IcieKABEnBYmvaLzsJL4KEs8w
 n5WA7c127R07w54EvtPKX2G7O5uW5lU=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564412359; a=rsa-sha256; cv=none;
 b=UQkGwFSDvFflTpIyjFSfQZEwGWqTWkZbJZ7+kXz5OS77XN3Tb7/JaXJq4M5+DWbOmBUSsq
 8WCbS234CmUQDcHuTZIRHapaU+Sq+l+nk0tbTaL8d0CfQBgLTGk+BS/JtheJefMqZyp6hf
 cDhiqXvBAFJPKoLgWLKWe7cfPUcgbgU=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
X-Spam: Yes
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v3 21/33] hw/intc/spapr_xive.c: remove
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
no impact since SpaprXive has no child bus.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/intc/spapr_xive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 22e11ad10c..fbd7ddb06e 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -1511,7 +1511,7 @@ static target_ulong h_int_reset(PowerPCCPU *cpu,
         return H_PARAMETER;
     }
=20
-    device_legacy_reset(DEVICE(xive));
+    device_reset_warm(DEVICE(xive));
=20
     if (kvm_irqchip_in_kernel()) {
         Error *local_err =3D NULL;
--=20
2.22.0


