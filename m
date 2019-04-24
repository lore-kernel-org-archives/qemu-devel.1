Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFD8C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 04:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7144020878
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 04:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="dqmU1hsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7144020878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35434 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ9Pg-0007ZJ-Hh
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 00:21:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJ9OH-0006J5-SN
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJ9OH-0008Kw-0v
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:20:13 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:58057)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hJ9OG-0007ud-C6; Wed, 24 Apr 2019 00:20:12 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44pnCk0CFQz9s5c; Wed, 24 Apr 2019 14:20:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1556079602;
	bh=RHUPFBMkFYu4hWKdf7/Df7eUjK+AtZJm7HDAbd4EALs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dqmU1hsNsb6SjVgpIxonA0opKNJsMDmyJn7038h7aMhvDecrUo9mhBJJ/+a4UApSZ
	4UxSDBSRdB6yaH2bT5FVyVEZ1/t6sspEqrsakOjQAiNyeQWy49XIZDjQNIn2h5p0oE
	aGnFhtCdh/z4hsMa3B9V6dyyDnuIgN1xS1PDi+Jk=
From: David Gibson <david@gibson.dropbear.id.au>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>, Greg Kurz <groug@kaod.org>
Date: Wed, 24 Apr 2019 14:19:57 +1000
Message-Id: <20190424041959.4087-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424041959.4087-1-david@gibson.dropbear.id.au>
References: <20190424041959.4087-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PATCH v2 1/3] pcie: Remove redundant test in
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
Cc: qemu-ppc@nongnu.org, clg@kaod.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190424041957.A8cK_RZve2FWNWo1h0izZ5aQVNWWZ3gu992gkm6x6I8@z>

These functions have an explicit test for accesses above the device's
config size.  But pci_host_config_{read,write}_common() which they're
about to call already have checks against the config space limit and
do the right thing.  So, remove the redundant tests.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
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
2.20.1


