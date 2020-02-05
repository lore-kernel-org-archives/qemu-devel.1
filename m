Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAAEC352A1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 23:21:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D1EB2082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 23:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eb2ivCMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1EB2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izTzE-0001hG-Hg
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 18:21:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1izTy8-0000F2-PH
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 18:20:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1izTy7-0004Ux-N4
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 18:20:28 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32628
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1izTy7-0004Sg-JV
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 18:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580944827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RPolfk5EprNRzL++Au58u/9mYtG7JfilAiYb7FpEOpc=;
 b=eb2ivCMtcm7qu0qk4/VDk5xMxOvcnrPmgkR8YHe87sy4ppf7NQq1SYK5wVfE6EwPZZQGz+
 Xx6PpumFbLqVIaRDUs+jg9hKkZ06mQr1RW9s+5D6O0ioYCkVBW7sry7Js1nfG8kByJuTFV
 nAV0GzA0LMT+JcJL8IYwGnWck7a4OOw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-VOd_N6mWOIaj5vu0aljInw-1; Wed, 05 Feb 2020 18:20:25 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D01CDB25;
 Wed,  5 Feb 2020 23:20:24 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-116-229.ams2.redhat.com
 [10.36.116.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7BB6384DB4;
 Wed,  5 Feb 2020 23:20:22 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] ppc/pnv: Fix PCI_EXPRESS dependency
Date: Thu,  6 Feb 2020 00:20:16 +0100
Message-Id: <20200205232016.588202-3-lvivier@redhat.com>
In-Reply-To: <20200205232016.588202-1-lvivier@redhat.com>
References: <20200205232016.588202-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: VOd_N6mWOIaj5vu0aljInw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

Notes:
    v2: remove PCI already selected by PCI_EXPRESS
        remove PCIE_PORT, set by default to yes with PCI_DEVICES

 hw/ppc/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 354828bf132f..dd86e664d215 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -29,6 +29,8 @@ config POWERNV
     select XICS
     select XIVE
     select FDT_PPC
+    select PCI_EXPRESS
+    select MSI_NONBROKEN
=20
 config PPC405
     bool
@@ -135,8 +137,6 @@ config XIVE_SPAPR
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


