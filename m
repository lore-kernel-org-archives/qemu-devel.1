Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218BAC352A2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 08:18:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3C5421741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 08:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2N7z/TL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C5421741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izcMm-0002SX-4r
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 03:18:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1izcLe-0001En-3P
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 03:17:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1izcLc-0007PC-Tz
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 03:17:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50191
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1izcLc-0007M0-QR
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 03:17:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580977036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=hyfpmm0vEwltLDrEULoYVG4ZppCjjvYHwXOIMfQBaKk=;
 b=G2N7z/TLz8J5dqX96vD98TcWRB2dlcEMtJkaleNFjBkvh8YVX3n/JM4w5RPkTvpulABvRD
 Fx9EOTrspj43lPAdFbh24oXW3HrN6LCaJuXJ94Z6s95afxKbxnMnDHMNGqkYVri4Kg0mjq
 N4yl2rnZAWHzLYH5Kda8U1tFbVIPF4Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-kxc8lcLfPSmNFlkl2DnYRg-1; Thu, 06 Feb 2020 03:17:14 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EC66101FC61;
 Thu,  6 Feb 2020 08:17:13 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-151.ams2.redhat.com [10.36.116.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA4535C1B0;
 Thu,  6 Feb 2020 08:17:09 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] ppc/pnv: Fix PCI_EXPRESS dependency
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20200205232016.588202-1-lvivier@redhat.com>
 <20200205232016.588202-3-lvivier@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <15dca322-cbb4-9217-2150-c2a84e07eda7@redhat.com>
Date: Thu, 6 Feb 2020 09:17:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200205232016.588202-3-lvivier@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: kxc8lcLfPSmNFlkl2DnYRg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/02/2020 00.20, Laurent Vivier wrote:
> When PHB4 bridge has been added, the dependencies to PCIE_PORT has been
> added to XIVE_SPAPR and indirectly to PSERIES.
> The build of the PowerNV machine is fine while we also build the PSERIES
> machine.
> If we disable the PSERIES machine, the PowerNV build fails because the
> PCI Express files are not built:
> 
> /usr/bin/ld: hw/ppc/pnv.o: in function `pnv_chip_power8_pic_print_info':
> .../hw/ppc/pnv.c:623: undefined reference to `pnv_phb3_msi_pic_print_info'
> /usr/bin/ld: hw/ppc/pnv.o: in function `pnv_chip_power9_pic_print_info':
> .../hw/ppc/pnv.c:639: undefined reference to `pnv_phb4_pic_print_info'
> /usr/bin/ld: ../hw/usb/hcd-ehci-pci.o: in function `usb_ehci_pci_write_config':
> .../hw/usb/hcd-ehci-pci.c:129: undefined reference to `pci_default_write_config'
> /usr/bin/ld: ../hw/usb/hcd-ehci-pci.o: in function `usb_ehci_pci_realize':
> .../hw/usb/hcd-ehci-pci.c:68: undefined reference to `pci_allocate_irq'
> /usr/bin/ld: .../hw/usb/hcd-ehci-pci.c:72: undefined reference to `pci_register_bar'
> /usr/bin/ld: ../hw/usb/hcd-ehci-pci.o:(.data.rel+0x50): undefined reference to `vmstate_pci_device'
> 
> This patch fixes the problem by adding needed dependencies to POWERNV.
> 
> Fixes: 4f9924c4d4cf ("ppc/pnv: Add models for POWER9 PHB4 PCIe Host bridge")
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
> 
> Notes:
>     v2: remove PCI already selected by PCI_EXPRESS
>         remove PCIE_PORT, set by default to yes with PCI_DEVICES
> 
>  hw/ppc/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index 354828bf132f..dd86e664d215 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -29,6 +29,8 @@ config POWERNV
>      select XICS
>      select XIVE
>      select FDT_PPC
> +    select PCI_EXPRESS
> +    select MSI_NONBROKEN

When only using CONFIG_POWERNV=y in the default-config and using
"configure --without-default-devices --target-list=ppc64-softmmu" I
still get a linking error:

  LINK    ppc64-softmmu/qemu-system-ppc64
hw/ppc/pnv.o: In function `pnv_init':
hw/ppc/pnv.c:846: undefined reference to `serial_hds_isa_init'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:206: qemu-system-ppc64] Error 1

Looks like there is still a "select SERIAL" or something similar missing
here?

 Thomas


