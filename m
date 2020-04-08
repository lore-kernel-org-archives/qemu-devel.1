Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E6EC2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 10:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F71E20771
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 10:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTjWLsq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F71E20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM8KZ-0000AZ-7Q
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 06:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jM8J0-0007vI-7R
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 06:51:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jM8Iz-0007pK-1e
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 06:51:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58181
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jM8Iy-0007nC-UQ
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 06:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586343095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+4fmqeM+Dyoj77F2cDLidSTBH1md85Nd2O7b8zsbyS8=;
 b=WTjWLsq5yq9z7k2/I+zsdT7pCE5t4FfTnXe+Aa5UlwM1jJdqcTS++MafF/AXIoimFsn/eh
 /C0qs8NAUmK4M0ggduWne/AwI31bRBcZwME9fZydGjWLF5yVFiz5IFw4evtHT3Db9id8uP
 OXm2cuTGaKIFVKIY0cxFJd13ZcBRH5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-WFULhHrfNAuMxUPaiXUgSQ-1; Wed, 08 Apr 2020 06:51:33 -0400
X-MC-Unique: WFULhHrfNAuMxUPaiXUgSQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E6E013F6;
 Wed,  8 Apr 2020 10:51:32 +0000 (UTC)
Received: from localhost (unknown [10.40.208.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B19B5E010;
 Wed,  8 Apr 2020 10:51:22 +0000 (UTC)
Date: Wed, 8 Apr 2020 12:51:20 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [PATCH] hw/pci/pcie: Forbid hot-plug via QMP if it's disabled
 on the slot
Message-ID: <20200408125120.7678d9ae@redhat.com>
In-Reply-To: <20200407145017.1041256-1-jusual@redhat.com>
References: <20200407145017.1041256-1-jusual@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: qemu-trivial@nongnu.org,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Laine Stump <laine@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  7 Apr 2020 16:50:17 +0200
Julia Suvorova <jusual@redhat.com> wrote:

> Raise an error when trying to hot-plug/unplug a device through QMP to a device
> with disabled hot-plug capability. This makes the device behaviour more
> consistent and provides an explanation of the failure in the case of
> asynchronous unplug.

it applies to hotplug in general (i.e. not only QMP)

> 
> Signed-off-by: Julia Suvorova <jusual@redhat.com>
> ---
>  hw/pci/pcie.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 0eb3a2a5d2..e9798caa8a 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -415,6 +415,7 @@ void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>  {
>      PCIDevice *hotplug_pdev = PCI_DEVICE(hotplug_dev);
>      uint8_t *exp_cap = hotplug_pdev->config + hotplug_pdev->exp.exp_cap;
> +    uint32_t sltcap = pci_get_word(exp_cap + PCI_EXP_SLTCAP);
>      PCIDevice *pci_dev = PCI_DEVICE(dev);
>  
>      /* Don't send event when device is enabled during qemu machine creation:
> @@ -430,6 +431,13 @@ void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>          return;
>      }
>  
> +    /* Hot-plug is disabled on the slot */
> +    if ((sltcap & PCI_EXP_SLTCAP_HPC) == 0) {
> +        error_setg(errp, "Device '%s' does not support hot-plug",
> +                         DEVICE(hotplug_dev)->id);
plug and unplug_req are synchronous. so one can skip on "Device '%s'",
user will get this error message as response to device_add/del command.

and more exactly it's concrete slot that does not support hotplug, how about
"slot doesn't support ..." or just "hotlpug is not supported"

> +        return;
> +    }
> +
>      /* To enable multifunction hot-plug, we just ensure the function
>       * 0 added last. When function 0 is added, we set the sltsta and
>       * inform OS via event notification.
> @@ -464,14 +472,24 @@ static void pcie_unplug_device(PCIBus *bus, PCIDevice *dev, void *opaque)
>      object_unparent(OBJECT(dev));
>  }
>  
> -void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
> +void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_handler,
>                                       DeviceState *dev, Error **errp)
>  {
>      Error *local_err = NULL;
>      PCIDevice *pci_dev = PCI_DEVICE(dev);
>      PCIBus *bus = pci_get_bus(pci_dev);
> +    PCIDevice *hotplug_dev = PCI_DEVICE(hotplug_handler);
> +    uint8_t *exp_cap = hotplug_dev->config + hotplug_dev->exp.exp_cap;
> +    uint32_t sltcap = pci_get_word(exp_cap + PCI_EXP_SLTCAP);
> +
> +    /* Hot-unplug is disabled on the slot */
> +    if ((sltcap & PCI_EXP_SLTCAP_HPC) == 0) {
> +        error_setg(errp, "Device '%s' does not support hot-unplug",
> +                         DEVICE(hotplug_dev)->id);
> +        return;
> +    }
>  
> -    pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev, &local_err);
> +    pcie_cap_slot_plug_common(hotplug_dev, dev, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> @@ -490,7 +508,7 @@ void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
>          return;
>      }
>  
> -    pcie_cap_slot_push_attention_button(PCI_DEVICE(hotplug_dev));
> +    pcie_cap_slot_push_attention_button(hotplug_dev);
>  }
>  
>  /* pci express slot for pci express root/downstream port


