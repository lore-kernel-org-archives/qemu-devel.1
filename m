Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0E2C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 18:42:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91E13206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 18:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ezCA4Zv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E13206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imMTb-00047r-B8
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 13:42:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imMLJ-0000zD-8D
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 13:34:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imMLI-0003Ar-1F
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 13:34:09 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59864
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imMLH-00038e-TO
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 13:34:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577817247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lg58DBeDE0DgziQ2gXpd7IhKj12+wCU6SkcB/vIfZkU=;
 b=ezCA4Zv6JDaARAqWcboFbE822jm9CH/sfvr7nZtPRorJm8aQR4erb15ohB2YV4T+z++tVL
 ErrYob7dwE9CJ8xir+QXz33pYg8oh+BaW6n7GHTHv3Ko/FRGoonttthBTDGplJrgm1VDPs
 JEkiBWPcWSM1Hpir23nx7sLKiqMW9Eg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-B3owXEc1Py2IoZnhnZSlPg-1; Tue, 31 Dec 2019 13:34:05 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A88810054E3;
 Tue, 31 Dec 2019 18:34:03 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-116-30.ams2.redhat.com [10.36.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 15EB267673;
 Tue, 31 Dec 2019 18:33:57 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 10/14] hw/ppc/Kconfig: Only select fw_cfg with machines using
 OpenBIOS
Date: Tue, 31 Dec 2019 19:32:12 +0100
Message-Id: <20191231183216.6781-11-philmd@redhat.com>
In-Reply-To: <20191231183216.6781-1-philmd@redhat.com>
References: <20191231183216.6781-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: B3owXEc1Py2IoZnhnZSlPg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The fw_cfg helpers are only used by machines using OpenBIOS.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: "Herv=C3=A9 Poussineau" <hpoussin@reactos.org>
---
 hw/ppc/Kconfig       | 6 ++++++
 hw/ppc/Makefile.objs | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index d8482a5e99..e4ca920507 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -72,6 +72,7 @@ config PREP
     select M48T59
     select PC87312
     select RS6000_MC
+    select FW_CFG_PPC
=20
 config RS6000_MC
     bool
@@ -85,6 +86,7 @@ config MAC_OLDWORLD
     select GRACKLE_PCI
     select HEATHROW_PIC
     select MACIO
+    select FW_CFG_PPC
=20
 config MAC_NEWWORLD
     bool
@@ -96,6 +98,7 @@ config MAC_NEWWORLD
     select MACIO_GPIO
     select MAC_PMU
     select UNIN_PCI
+    select FW_CFG_PPC
=20
 config E500
     bool
@@ -130,3 +133,6 @@ config XIVE_KVM
     bool
     default y
     depends on XIVE_SPAPR && KVM
+
+config FW_CFG_PPC
+    bool
diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 79adf06aa3..5c46c68e44 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -1,5 +1,6 @@
 # shared objects
-obj-y +=3D ppc.o ppc_booke.o fdt.o fw_cfg.o
+obj-y +=3D ppc.o ppc_booke.o fdt.o
+obj-$(CONFIG_FW_CFG_PPC) +=3D fw_cfg.o
 # IBM pSeries (sPAPR)
 obj-$(CONFIG_PSERIES) +=3D spapr.o spapr_caps.o spapr_vio.o spapr_events.o
 obj-$(CONFIG_PSERIES) +=3D spapr_hcall.o spapr_iommu.o spapr_rtas.o
--=20
2.21.0


