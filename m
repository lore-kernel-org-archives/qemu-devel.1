Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38927C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:11:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0306821655
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="mwdMFUne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0306821655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7Je-0002TI-96
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38754)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs78E-0005ds-A6
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:00:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs78D-0005fV-EI
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:00:10 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:48394)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hs788-0004hE-Pi; Mon, 29 Jul 2019 11:00:04 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id 742BC96F88;
 Mon, 29 Jul 2019 14:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564412352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k5fLNLBjdV6+7E7c/JKPYT8WFMywRHAMb8K8XSSC0BM=;
 b=mwdMFUnet1WK6hOZ0GrybZr8G+dn0AH10yKxU5oDeUEphyHFiFGd8eRbQH8FQZe7DQu4H7
 t3vxPWw7KQTdU71Fb1hL0S3bisVf6/eNoi3iN2BLepy+cSEN48jB/B4BAiJqh2q1SKq17Y
 hhIPIXONAGZwFDXTK5bvSjeXt3yZHlQ=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 16:56:37 +0200
Message-Id: <20190729145654.14644-17-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729145654.14644-1-damien.hedde@greensocs.com>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564412352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k5fLNLBjdV6+7E7c/JKPYT8WFMywRHAMb8K8XSSC0BM=;
 b=J+UF4NDQCEMvalc7fEX9SKb/5TkfNcyuduk3yQbJ7TvDMubHIzfXCG0tOXdmwD+d6VyiXR
 o11Kz/Gr6KzjWhxO0b8ZqQ8RALCQh67FXxoVSpqcUMW5+nRTowvKjxlYRlJSfsmqYx2Y2+
 I+HBy1/pdXgu3krMN3+H5Kn4BGtDgXg=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564412352; a=rsa-sha256; cv=none;
 b=5Su81pOKhapiikKTtXG6b97g+L6xc017m9bBhDMrB7veGYBnmqNn0vL6N6vomym4+RWlTX
 jhhFE5hlT/2a+YDrattV0QjRUBJqMfOmm0ZxMikIosHqpWpD9PowW1GaHynG7GZqgmVCxz
 gsmgmfAxpwUhX1PFkOwTnmp80/YU+JY=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
X-Spam: Yes
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v3 16/33] hw/input/adb.c: remove qdev_reset_all
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

Replace deprecated qdev_reset_all by device_reset_warm.

This does not impact the behavior.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/input/adb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/input/adb.c b/hw/input/adb.c
index 1446f32521..6b35682aba 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -32,7 +32,7 @@
=20
 static void adb_device_reset(ADBDevice *d)
 {
-    qdev_reset_all(DEVICE(d));
+    device_reset_warm(DEVICE(d));
 }
=20
 int adb_request(ADBBusState *s, uint8_t *obuf, const uint8_t *buf, int l=
en)
--=20
2.22.0


