Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F058FC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 12:37:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCFAE206D6
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 12:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wb37pdd0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCFAE206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1rGo-0006sO-Vw
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 07:37:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1j1rG7-0005yI-8R
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:36:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1j1rG5-0004sy-V2
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:36:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24582
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1j1rG5-0004sh-SB
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:36:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581511009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uK+nU4sgxBEokRAWNZxTnspMu62cAyP8LVtE4DKDHxo=;
 b=Wb37pdd0lMYVyU52jrrTKRalSEl/5oZ5FEfmjqdaImbVJClVuATeO1yht96sJpDgH86gg4
 RN9x8jOmoXuqTt4swkqf3vj8Iapy14E/BOmmLbvjh3Np+QTdY9eSCmgp6CeYkhP6jImbSy
 Vhd9kZRInTBgjhrHEEYv0Ly5HbV++fs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-zIHRCRhmON-oaKobdH2dOw-1; Wed, 12 Feb 2020 07:36:35 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAFC11800D6B;
 Wed, 12 Feb 2020 12:36:33 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5708D60BFB;
 Wed, 12 Feb 2020 12:36:30 +0000 (UTC)
Message-ID: <ca19245076bd5a7f5db1f1d1a2e188df294715e5.camel@redhat.com>
Subject: Re: [PATCH v5 23/26] pci: allocate pci id for nvme
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <k.jensen@samsung.com>, qemu-block@nongnu.org
Date: Wed, 12 Feb 2020 14:36:19 +0200
In-Reply-To: <20200204095208.269131-24-k.jensen@samsung.com>
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095230eucas1p23f3105c4cab4aaec77a3dd42b8158c10@eucas1p2.samsung.com>
 <20200204095208.269131-24-k.jensen@samsung.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: zIHRCRhmON-oaKobdH2dOw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <ghoffman@redhat.com>,
 Beata Michalska <beata.michalska@linaro.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-02-04 at 10:52 +0100, Klaus Jensen wrote:
> The emulated nvme device (hw/block/nvme.c) is currently using an
> internal Intel device id.
> 
> Prepare to change that by allocating a device id under the 1b36 (Red
> Hat, Inc.) vendor id.

> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  MAINTAINERS            |  1 +
>  docs/specs/nvme.txt    | 10 ++++++++++
>  docs/specs/pci-ids.txt |  1 +
>  include/hw/pci/pci.h   |  1 +
>  4 files changed, 13 insertions(+)
>  create mode 100644 docs/specs/nvme.txt
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1f0bc72f2189..14a018e9c0ae 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1645,6 +1645,7 @@ L: qemu-block@nongnu.org
>  S: Supported
>  F: hw/block/nvme*
>  F: tests/qtest/nvme-test.c
> +F: docs/specs/nvme.txt
>  
>  megasas
>  M: Hannes Reinecke <hare@suse.com>
> diff --git a/docs/specs/nvme.txt b/docs/specs/nvme.txt
> new file mode 100644
> index 000000000000..6ec7ddbc7ee0
> --- /dev/null
> +++ b/docs/specs/nvme.txt
> @@ -0,0 +1,10 @@
> +NVM Express Controller
> +======================
> +
> +The nvme device (-device nvme) emulates an NVM Express Controller.
> +
> +
> +Reference Specifications
> +------------------------
> +
> +  https://nvmexpress.org/resources/specifications/

Nitpick: maybe mention the nvme version here, plus some TODOs that are left?

> diff --git a/docs/specs/pci-ids.txt b/docs/specs/pci-ids.txt
> index 4d53e5c7d9d5..abbdbca6be38 100644
> --- a/docs/specs/pci-ids.txt
> +++ b/docs/specs/pci-ids.txt
> @@ -63,6 +63,7 @@ PCI devices (other than virtio):
>  1b36:000b  PCIe Expander Bridge (-device pxb-pcie)
>  1b36:000d  PCI xhci usb host adapter
>  1b36:000f  mdpy (mdev sample device), linux/samples/vfio-mdev/mdpy.c
> +1b36:0010  PCIe NVMe device (-device nvme)
>  
>  All these devices are documented in docs/specs.
>  
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index b5013b834b20..9a20c309d0f2 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -103,6 +103,7 @@ extern bool pci_available;
>  #define PCI_DEVICE_ID_REDHAT_XHCI        0x000d
>  #define PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE 0x000e
>  #define PCI_DEVICE_ID_REDHAT_MDPY        0x000f
> +#define PCI_DEVICE_ID_REDHAT_NVME        0x0010
>  #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
>  
>  #define FMT_PCIBUS                      PRIx64

Other than the actual ID assignment which is not something
I can approve/allocate:

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky




