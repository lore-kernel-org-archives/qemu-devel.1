Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C37C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 10:59:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D65BA2075B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 10:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YvEtvVhp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D65BA2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgnaT-0006Os-4R
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 06:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jgnZb-0005rp-IH
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 06:58:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52738
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jgnZa-0003Kc-OG
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 06:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591268290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x61v8BL2rn2n2NvMG5XCrSCx80JZbq2ZYsYCyAZBfTY=;
 b=YvEtvVhp6N6ILydm6aQaBSOHm9Te6qc9/4p4+s9lEw08UtFEZtygb8I3wBKf2eba1xWnw3
 HWkVTvPvRN0252R5GET1Jsb3o8b/2sTeo5ES6o45Syn3roX+WVjchFORxcf+DA7/MveI4R
 icSbo0viVlZenSCXI0aYxPt7RTuooZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-Zt5yf4k6P1CegT4HMYCyNA-1; Thu, 04 Jun 2020 06:58:08 -0400
X-MC-Unique: Zt5yf4k6P1CegT4HMYCyNA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E8B91800D42
 for <qemu-devel@nongnu.org>; Thu,  4 Jun 2020 10:58:07 +0000 (UTC)
Received: from localhost (unknown [10.40.208.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 037AF5C48E;
 Thu,  4 Jun 2020 10:57:59 +0000 (UTC)
Date: Thu, 4 Jun 2020 12:57:55 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [PATCH] hw/pci/pcie: Move hot plug capability check to pre_plug
 callback
Message-ID: <20200604125755.12944ac4@redhat.com>
In-Reply-To: <20200601162934.842648-1-jusual@redhat.com>
References: <20200601162934.842648-1-jusual@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:08:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  1 Jun 2020 18:29:34 +0200
Julia Suvorova <jusual@redhat.com> wrote:

> Check for hot plug capability earlier to avoid removing devices attached
> during the initialization process.
> 
> Run qemu with an unattached drive:
>   -drive file=$FILE,if=none,id=drive0 \
>   -device pcie-root-port,id=rp0,slot=3,bus=pcie.0,hotplug=off
> Hotplug a block device:
>   device_add virtio-blk-pci,id=blk0,drive=drive0,bus=rp0
> If hotplug fails on plug_cb, drive0 will be deleted.
> 
> Signed-off-by: Julia Suvorova <jusual@redhat.com>
> ---
> Hard to say if it's a bug or generally acceptable behaviour, but seems like
> hotplug_handler_plug should never fail.

_unplug shouldn't fail the rest are allowed to, but it's hard to unwind
intialization cleanly to _plug stage so if it's possible to do checks
at _pre_plug time (i.e. before device's realize() is called) we should do so.

Acked-by: Igor Mammedov <imammedo@redhat.com>

> 
>  hw/pci/pcie.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index f50e10b8fb..5b9c022d91 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -407,6 +407,17 @@ static void pcie_cap_slot_plug_common(PCIDevice *hotplug_dev, DeviceState *dev,
>  void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>                                 Error **errp)
>  {
> +    PCIDevice *hotplug_pdev = PCI_DEVICE(hotplug_dev);
> +    uint8_t *exp_cap = hotplug_pdev->config + hotplug_pdev->exp.exp_cap;
> +    uint32_t sltcap = pci_get_word(exp_cap + PCI_EXP_SLTCAP);
> +
> +    /* Check if hot-plug is disabled on the slot */
> +    if (dev->hotplugged && (sltcap & PCI_EXP_SLTCAP_HPC) == 0) {
> +        error_setg(errp, "Hot-plug failed: unsupported by the port device '%s'",
> +                         DEVICE(hotplug_pdev)->id);
> +        return;
> +    }
> +
>      pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev, errp);
>  }
>  
> @@ -415,7 +426,6 @@ void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>  {
>      PCIDevice *hotplug_pdev = PCI_DEVICE(hotplug_dev);
>      uint8_t *exp_cap = hotplug_pdev->config + hotplug_pdev->exp.exp_cap;
> -    uint32_t sltcap = pci_get_word(exp_cap + PCI_EXP_SLTCAP);
>      PCIDevice *pci_dev = PCI_DEVICE(dev);
>  
>      /* Don't send event when device is enabled during qemu machine creation:
> @@ -431,13 +441,6 @@ void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>          return;
>      }
>  
> -    /* Check if hot-plug is disabled on the slot */
> -    if ((sltcap & PCI_EXP_SLTCAP_HPC) == 0) {
> -        error_setg(errp, "Hot-plug failed: unsupported by the port device '%s'",
> -                         DEVICE(hotplug_pdev)->id);
> -        return;
> -    }
> -
>      /* To enable multifunction hot-plug, we just ensure the function
>       * 0 added last. When function 0 is added, we set the sltsta and
>       * inform OS via event notification.


