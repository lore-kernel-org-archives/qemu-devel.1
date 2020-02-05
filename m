Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63FAC35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 20:42:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EFA52072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 20:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ivEV2lwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EFA52072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56227 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izRVT-0001PP-Ov
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 15:42:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39318)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1izRUU-0008J6-TD
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:41:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1izRUI-000586-7S
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:41:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40097
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1izRUI-000580-3r
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:41:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580935289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M8P6BmY+O55DEFSXtp2nwUql2twMfR2ioptvYQiaZKo=;
 b=ivEV2lwh0XpAHMnI67iUNut0bZKb1B7ETs1eFFAzz1E8CfhAKWiZGXyZ5GPJeeScNv28F8
 fpTnde0y/3s3ej1X4g/14gHj7X1pPVdbuKBxuE/jeqzjh3yfh4Vq5Hu9byq1xvW9wXbw/f
 mddGjFrDgMlLjjYdVKmth4nO3YeUcsk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-G2khIUioNCG4q2EdBySK_Q-1; Wed, 05 Feb 2020 15:41:28 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02C261005F67;
 Wed,  5 Feb 2020 20:41:27 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-116-229.ams2.redhat.com
 [10.36.116.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5783A10013A1;
 Wed,  5 Feb 2020 20:41:24 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] ppc/pnv: Fix PCI_EXPRESS dependency
Date: Wed,  5 Feb 2020 21:41:15 +0100
Message-Id: <20200205204115.555212-3-lvivier@redhat.com>
In-Reply-To: <20200205204115.555212-1-lvivier@redhat.com>
References: <20200205204115.555212-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: G2khIUioNCG4q2EdBySK_Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When PHB4 bridge has been added, the dependencies to PCIE_PORT has been
added to XIVE_SPAPR and indirectly to PSERIES.
The build of the PowerNV machine is fine while we also build the PSERIES
machine.
If we disable the PSERIES machine, the PowerNV build fails because the
PCI Express files are not built:

/usr/bin/ld: hw/ppc/pnv.o: in function `pnv_chip_power8_pic_print_info':
.../hw/ppc/pnv.c:623: undefined reference to `pnv_phb3_msi_pic_print_info'
/usr/bin/ld: hw/ppc/pnv.o: in function `pnv_chip_power9_pic_print_info':
.../hw/ppc/pnv.c:639: undefined reference to `pnv_phb4_pic_print_info'
/usr/bin/ld: ../hw/usb/hcd-ehci-pci.o: in function `usb_ehci_pci_write_conf=
ig':
.../hw/usb/hcd-ehci-pci.c:129: undefined reference to `pci_default_write_co=
nfig'
/usr/bin/ld: ../hw/usb/hcd-ehci-pci.o: in function `usb_ehci_pci_realize':
.../hw/usb/hcd-ehci-pci.c:68: undefined reference to `pci_allocate_irq'
/usr/bin/ld: .../hw/usb/hcd-ehci-pci.c:72: undefined reference to `pci_regi=
ster_bar'
/usr/bin/ld: ../hw/usb/hcd-ehci-pci.o:(.data.rel+0x50): undefined reference=
 to `vmstate_pci_device'

This patch fixes the problem by adding needed dependencies to POWERNV.

Fixes: 4f9924c4d4cf ("ppc/pnv: Add models for POWER9 PHB4 PCIe Host bridge"=
)
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/ppc/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 354828bf132f..3e11d0b53e11 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -29,6 +29,10 @@ config POWERNV
     select XICS
     select XIVE
     select FDT_PPC
+    select PCI
+    select PCI_EXPRESS
+    select MSI_NONBROKEN
+    select PCIE_PORT
=20
 config PPC405
     bool
@@ -135,8 +139,6 @@ config XIVE_SPAPR
     default y
     depends on PSERIES
     select XIVE
-    select PCI
-    select PCIE_PORT
=20
 config XIVE_KVM
     bool
--=20
2.24.1


