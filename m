Return-Path: <SRS0=aRDT=W3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6999CC3A5A6
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 19:46:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C63121874
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 19:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gn54YAiy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C63121874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i49KZ-0005Ya-Bp
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 15:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1i49JZ-00059b-NS
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 15:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1i49JY-0003Mk-DI
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 15:45:37 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41643)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1i49JY-0003Im-3w
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 15:45:36 -0400
Received: by mail-wr1-x443.google.com with SMTP id j16so10110371wrr.8
 for <qemu-devel@nongnu.org>; Sat, 31 Aug 2019 12:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=fUdgzUdd2IK9hi1Xee/i/1Y1RSl4j7hUT0ioyE6etUY=;
 b=Gn54YAiyRpkyn7c0Nju26TMDRn+nZm1kL1kDZTfhTCF+KPg8P7xbud8HDoFDk8MUvs
 OTjIX96a63zAIxRnw5NBuQf6XkihnmOj7VXAGhOPrkTc2jLTUUJ+yztl/pK115jNB1vq
 /ClOw+9RZk8Jm3wnutjkm+xYMjfV+kGDJ04WpXYpMmMM9pdbkMz//RJikdhrarfYzZBC
 sK9TPslUaGZJHixIBNnVWKcqBCKJnzjXwKJrw6b9JqkECjdF3P4teUmWK6T0NLerMO7C
 MFYNtuVRtBBj6hsf9k3Bx+GFVgXlUQqqbJddjgYO90hLvTrtCtjSTHOS3/0+YELkFaqS
 QHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=fUdgzUdd2IK9hi1Xee/i/1Y1RSl4j7hUT0ioyE6etUY=;
 b=sCa1iPovpdBedNtrWMMumbe1tNz2N36K+62EBRvrveMH2x0fApPnyQw3K8/PxIq5g/
 ZCepJyUVowT4M3KwQfET/stb5Lm7EjmqIY5LotDjxtWevZ705tLkA7epo7BqWx7d+l27
 MfLwoXyYvE0gySaj7hWN7J6N4/0tsktoZI59h1GfNURv3lZpWz2IXL8UtApbIsMAXa0h
 8oAY8l25t93lB11AKB7+Ko8pcW1roH5N0649pHfEocMGMoFxgAMlTx7MYjtORiKy1nTe
 R6ud9X6Fif/CCu6+NxqXJvH2FVCzaF0+cQpRzlP1giYMiKnSe4Hkpi3knctp4nu6+lm6
 kkDw==
X-Gm-Message-State: APjAAAXRiXzN093B8GcPR8/kYYIF52zfvLSsnTEJ/z3EedV+CmZxO0Aj
 xfl/73GB4ymniSBa73/6JqE=
X-Google-Smtp-Source: APXvYqwaRm3ELpF5gl2wmozh+9ZjNogRqfRfLA/ClxIxOL2R3zvqBRx0XWbci3WEJIiU7YF5x++Tgw==
X-Received: by 2002:adf:fad0:: with SMTP id a16mr26007009wrs.195.1567280734551; 
 Sat, 31 Aug 2019 12:45:34 -0700 (PDT)
Received: from [192.168.86.99] ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id b194sm14481545wmg.46.2019.08.31.12.45.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 31 Aug 2019 12:45:33 -0700 (PDT)
To: Sukrit Bhatnagar <skrtbhtngr@gmail.com>, qemu-devel@nongnu.org
References: <20190828142328.24561-1-skrtbhtngr@gmail.com>
 <20190828142328.24561-3-skrtbhtngr@gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <710966e9-d1ac-3c55-0a12-02ff19005531@gmail.com>
Date: Sat, 31 Aug 2019 22:45:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828142328.24561-3-skrtbhtngr@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v1 2/2] hw/pvrdma: add live migration
 support
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
Cc: Yuval Shaia <yuval.shaia@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/28/19 5:23 PM, Sukrit Bhatnagar wrote:
> vmstate_pvrdma describes the PCI and MSIX states as well as the dma
> address for dsr and the gid table of device.
> vmstate_pvrdma_gids describes each gid in the gid table.
>
> pvrdma_post_save() does the job of unregistering gid entries from the
> backend device in the source host.
>
> pvrdma_post_load() maps to dsr using the loaded dma address, registers
> each loaded gid into the backend device, and finally calls load_dsr()
> to perform other mappings and ring init operations.
>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Yuval Shaia <yuval.shaia@oracle.com>
> Signed-off-by: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
> ---
>   hw/rdma/vmw/pvrdma_main.c | 77 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 77 insertions(+)
>
> diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> index 6c90db96f9..6f8b56dea3 100644
> --- a/hw/rdma/vmw/pvrdma_main.c
> +++ b/hw/rdma/vmw/pvrdma_main.c
> @@ -28,6 +28,7 @@
>   #include "sysemu/sysemu.h"
>   #include "monitor/monitor.h"
>   #include "hw/rdma/rdma.h"
> +#include "migration/register.h"
>   
>   #include "../rdma_rm.h"
>   #include "../rdma_backend.h"
> @@ -593,6 +594,81 @@ static void pvrdma_shutdown_notifier(Notifier *n, void *opaque)
>       pvrdma_fini(pci_dev);
>   }
>   
> +static int pvrdma_post_save(void *opaque)
> +{
> +    int i, rc;
> +    PVRDMADev *dev = opaque;
> +
> +    for (i = 0; i < MAX_GIDS; i++) {
> +

No need for the extra line
> +        if (!dev->rdma_dev_res.port.gid_tbl[i].gid.global.interface_id) {
> +            continue;
> +        }
> +        rc = rdma_backend_del_gid(&dev->backend_dev,
> +                                   dev->backend_eth_device_name,
> +                                   &dev->rdma_dev_res.port.gid_tbl[i].gid);
> +        if (rc) {
> +            return -EINVAL;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static int pvrdma_post_load(void *opaque, int version_id)
> +{
> +    int i, rc;
> +    PVRDMADev *dev = opaque;
> +    PCIDevice *pci_dev = PCI_DEVICE(dev);
> +    DSRInfo *dsr_info = &dev->dsr_info;
> +
> +    dsr_info->dsr = rdma_pci_dma_map(pci_dev, dsr_info->dma,
> +                                sizeof(struct pvrdma_device_shared_region));
> +    if (!dsr_info->dsr) {
> +        rdma_error_report("Failed to map to DSR");
> +        return -ENOMEM;
> +    }
> +
> +    for (i = 0; i < MAX_GIDS; i++) {
> +

The same here

> +        if (!dev->rdma_dev_res.port.gid_tbl[i].gid.global.interface_id) {
> +            continue;
> +        }
> +
> +        rc = rdma_backend_add_gid(&dev->backend_dev,
> +                                  dev->backend_eth_device_name,
> +                                  &dev->rdma_dev_res.port.gid_tbl[i].gid);
> +        if (rc) {
> +            return -EINVAL;
> +        }
> +    }
> +
> +    return load_dsr(dev);
> +}
> +
> +static const VMStateDescription vmstate_pvrdma_gids = {
> +    .name = "pvrdma-gids",
> +    .fields = (VMStateField[]) {
> +            VMSTATE_UINT8_ARRAY_V(gid.raw, RdmaRmGid, 16, 0),

Is 16 the array length? If yes, do we have same macro definition?

> +            VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_pvrdma = {
> +    .name = PVRDMA_HW_NAME,
> +    .post_save = pvrdma_post_save,
> +    .post_load = pvrdma_post_load,
> +    .fields = (VMStateField[]) {
> +            VMSTATE_PCI_DEVICE(parent_obj, PVRDMADev),
> +            VMSTATE_MSIX(parent_obj, PVRDMADev),
> +            VMSTATE_UINT64(dsr_info.dma, PVRDMADev),
> +            VMSTATE_STRUCT_ARRAY(rdma_dev_res.port.gid_tbl, PVRDMADev,
> +                                 MAX_PORT_GIDS, 0, vmstate_pvrdma_gids,
> +                                 RdmaRmGid),
> +            VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   static void pvrdma_realize(PCIDevice *pdev, Error **errp)
>   {
>       int rc = 0;
> @@ -688,6 +764,7 @@ static void pvrdma_class_init(ObjectClass *klass, void *data)
>   
>       dc->desc = "RDMA Device";
>       dc->props = pvrdma_dev_properties;
> +    dc->vmsd = &vmstate_pvrdma;
>       set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
>   
>       ir->print_statistics = pvrdma_print_statistics;

Very simple an elegant.
If I understand correctly the live migration of a pvrdma device with no
active workloads works with this patch, right?
If yes, I think we should consider merging this code already.
Yuval, do you agree?

Thanks,
Marcel



