Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8885C33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 06:10:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A574920663
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 06:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Hyh5BhzR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A574920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixPVx-0008QR-Rm
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 01:10:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ixPUo-0006af-Ak
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 01:09:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ixPUm-0000Ia-VS
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 01:09:37 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:45669)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ixPUm-0008UR-6e; Fri, 31 Jan 2020 01:09:36 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4886Hr5TRRz9sRR; Fri, 31 Jan 2020 17:09:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580450968;
 bh=dCdn1ruMSLsjZuuCJv7VxVhSfR0TgqtIsrQxGA4YTIk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Hyh5BhzR9XryLL/qHuv79n/GajVrhk7NO2MD39VNPsoffkIvbTg99ljqr015BvoNG
 AJ7ZR/neLDgbb2JuKQypqxSHjRNMufOYMKZQbaFx5Ax8RA43YKEzSmuzDeYh8XbQHe
 SZ7UW5Vp5lbh2OC0IXENqG4EL6JLWZ/iQLJ6awEM=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 02/34] ppc/pnv: improve error logging when a PNOR update fails
Date: Fri, 31 Jan 2020 17:08:52 +1100
Message-Id: <20200131060924.147449-3-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131060924.147449-1-david@gibson.dropbear.id.au>
References: <20200131060924.147449-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Print out the offset at which the error occured.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20200108090348.21224-3-clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_pnor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv_pnor.c b/hw/ppc/pnv_pnor.c
index 060c6e6a31..c365ee58b8 100644
--- a/hw/ppc/pnv_pnor.c
+++ b/hw/ppc/pnv_pnor.c
@@ -47,7 +47,8 @@ static void pnv_pnor_update(PnvPnor *s, int offset, int=
 size)
     ret =3D blk_pwrite(s->blk, offset, s->storage + offset,
                      offset_end - offset, 0);
     if (ret < 0) {
-        error_report("Could not update PNOR: %s", strerror(-ret));
+        error_report("Could not update PNOR offset=3D0x%" PRIx32" : %s",=
 offset,
+                     strerror(-ret));
     }
 }
=20
--=20
2.24.1


