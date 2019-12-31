Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378C0C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 18:40:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D781206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 18:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cmhsXsye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D781206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imMRY-00011G-QY
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 13:40:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imMLC-0000oE-IW
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 13:34:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imMLB-0002jc-Eq
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 13:34:02 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54360
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imMLB-0002hl-AC
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 13:34:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577817240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JXZd2SquiS0EG3VvV3N8IDpXfPy6kYgXfBdN/SKsvKo=;
 b=cmhsXsyegAPnW0SuzLidR2SC4c7TPxzWdHz/L6YcajwQWaDnNI3Ie+fDUIa/tSd86zyCZF
 NB7oAe32OyQEcp6+3noAN2JfOoiPbAyTE6n0+vOrl+DhPn2q9KZm4YXh2I+/DtMEtYQ6Ka
 ErKaWGVd1r6YuLuZxP09v4PymbbwB8o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-BLSZUfFVMcaQXQZ0SrkigQ-1; Tue, 31 Dec 2019 13:33:59 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CC29107ACC7;
 Tue, 31 Dec 2019 18:33:57 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-116-30.ams2.redhat.com [10.36.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EEDB867673;
 Tue, 31 Dec 2019 18:33:52 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 09/14] hw/ppc/Makefile: Simplify the sPAPR PCI objects rule
Date: Tue, 31 Dec 2019 19:32:11 +0100
Message-Id: <20191231183216.6781-10-philmd@redhat.com>
In-Reply-To: <20191231183216.6781-1-philmd@redhat.com>
References: <20191231183216.6781-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: BLSZUfFVMcaQXQZ0SrkigQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The CONFIG_PSERIES already selects CONFIG_PCI.
Simplify the Makefile rules.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/ppc/Makefile.objs | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 101e9fc591..79adf06aa3 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -7,14 +7,11 @@ obj-$(CONFIG_PSERIES) +=3D spapr_pci.o spapr_rtc.o spapr_=
drc.o
 obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o spapr_irq.o
 obj-$(CONFIG_PSERIES) +=3D spapr_tpm_proxy.o
 obj-$(CONFIG_SPAPR_RNG) +=3D  spapr_rng.o
+obj-$(call land,$(CONFIG_PSERIES),$(CONFIG_LINUX)) +=3D spapr_pci_vfio.o s=
papr_pci_nvlink2.o
 # IBM PowerNV
 obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_psi.=
o pnv_occ.o pnv_bmc.o
 obj-$(CONFIG_POWERNV) +=3D pnv_homer.o pnv_pnor.o
=20
-
-ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
-obj-y +=3D spapr_pci_vfio.o spapr_pci_nvlink2.o
-endif
 obj-$(CONFIG_PSERIES) +=3D spapr_rtas_ddw.o
 # PowerPC 4xx boards
 obj-$(CONFIG_PPC405) +=3D ppc405_boards.o ppc405_uc.o
--=20
2.21.0


