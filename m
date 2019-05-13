Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A949C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 06:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EFD020B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 06:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GlXMtOTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EFD020B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51752 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ4LH-0004A1-5x
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 02:21:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hQ4JQ-0002gx-PT
	for qemu-devel@nongnu.org; Mon, 13 May 2019 02:19:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hQ4JP-0004LA-Mf
	for qemu-devel@nongnu.org; Mon, 13 May 2019 02:19:48 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:40881)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hQ4JO-0004KC-QR; Mon, 13 May 2019 02:19:47 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 452Vz25GCyz9sN1; Mon, 13 May 2019 16:19:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557728382;
	bh=ArXxfw3U498/kSOjRaZfo1gZZ/LtA1dl87OZ9AXBazU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GlXMtOToiYNABkSywlJFYcsW5hukDnamHlm3PeFXse8o0ddsImq8I12obW8uSmMX8
	2SI0okym7I2XrfQ3quBtA1huLfG/LesT0TFZWYY5t+QHMfaN5w/qXbyhiuw4kchvSs
	Uw0yBm6H9MopFBT2WR5vaS08TFdIrfFbCv7TEeh8=
From: David Gibson <david@gibson.dropbear.id.au>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Date: Mon, 13 May 2019 16:19:35 +1000
Message-Id: <20190513061939.3464-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190513061939.3464-1-david@gibson.dropbear.id.au>
References: <20190513061939.3464-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PATCH v4 1/5] pcie: Remove redundant test in
 pcie_mmcfg_data_{read, write}()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: aik@ozlabs.ru, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	groug@kaod.org, qemu-ppc@nongnu.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These functions have an explicit test for accesses above the device's
config size.  But pci_host_config_{read,write}_common() which they're
about to call already have checks against the config space limit and
do the right thing.  So, remove the redundant tests.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/pci/pcie_host.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/pci/pcie_host.c b/hw/pci/pcie_host.c
index 553db56778..1ee4945a6d 100644
--- a/hw/pci/pcie_host.c
+++ b/hw/pci/pcie_host.c
@@ -47,11 +47,6 @@ static void pcie_mmcfg_data_write(void *opaque, hwaddr=
 mmcfg_addr,
     }
     addr =3D PCIE_MMCFG_CONFOFFSET(mmcfg_addr);
     limit =3D pci_config_size(pci_dev);
-    if (limit <=3D addr) {
-        /* conventional pci device can be behind pcie-to-pci bridge.
-           256 <=3D addr < 4K has no effects. */
-        return;
-    }
     pci_host_config_write_common(pci_dev, addr, limit, val, len);
 }
=20
@@ -70,11 +65,6 @@ static uint64_t pcie_mmcfg_data_read(void *opaque,
     }
     addr =3D PCIE_MMCFG_CONFOFFSET(mmcfg_addr);
     limit =3D pci_config_size(pci_dev);
-    if (limit <=3D addr) {
-        /* conventional pci device can be behind pcie-to-pci bridge.
-           256 <=3D addr < 4K has no effects. */
-        return ~0x0;
-    }
     return pci_host_config_read_common(pci_dev, addr, limit, len);
 }
=20
--=20
2.21.0


