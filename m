Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829DEC5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 07:03:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5105E2054F
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 07:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDTcK/aG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5105E2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhqLY-0005oR-LR
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 03:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49138)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1hhqKy-0005KW-9E
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 03:02:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1hhqKw-0002FF-Qw
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 03:02:52 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46705)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1hhqKw-0002Dr-Ia
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 03:02:50 -0400
Received: by mail-wr1-x441.google.com with SMTP id n4so12407359wrw.13
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 00:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=0h5lbOb9I8/Qsw5gY0JTT2xd9a8+ou3mIG1FpSOl+bo=;
 b=jDTcK/aGNnTe7UHQCIkhaVCYcesEq6V3ppNw6ogX58yuygp/FUACSvYztsMUjZNDp3
 Lt8yEiU2dE4M9MxNE5LJIago2ysIzswW274H9Jwk9/rbevbKslR5Fy58KzxnLhXjH7+b
 1UgQO+Wv17a+6PTuz/CXnNBVefIM22PI8nH0GRhmI3lfbR9IaRnF8r9/73t9y1bAZ7uj
 JlXcC4Pkea/es5Uv+MvQ2778zGyL1/4a1ciWtUeEb1L/160CMvY1b9qzXzddU6cnavWz
 0MaWRmQ3w7iofTuyFwL0T2DYlXUFnFls+ZSGZUnpz7iKla9wadlX1GbhnAn9pzilZ7JK
 hiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=0h5lbOb9I8/Qsw5gY0JTT2xd9a8+ou3mIG1FpSOl+bo=;
 b=NvYfbQeAoofT1XgXYQvdYQs+iEZnqo+gqKY6xYv75316fxYi4MFcUh2LrKXf+NTUo6
 Sf5tucy6pDrGDN2r0/OoFcERmqdY4X9gYSTvbsyvr2Ko09DqJN+0PMyhRp4dpYyFsUAW
 RXYypU0d3YMoNN1qdRxpb7xYZAT3Sk+ZScEa6HmYD4k/A4YFjJxrNZPQcnr4hHA404+r
 wnBIZV7S1ysAk9csnd1DyArmIkHDTY6Psl2uZl3uEMkuIUzM7hinJzOsp95j/yRqOD4V
 u5bTLz8fEdASrQ//iMfkOOrX/7XmL8cVifePmUjVH4X8irAWapP0/k7uE0dwJtMdmmei
 5HiQ==
X-Gm-Message-State: APjAAAXjMX0mp0XxbhU7vv3T17Z2UNax4/wLdst/ThqjJ+YyRzXszfHG
 BJJx+JaMiI/yoxNOKYkJ4utesotf
X-Google-Smtp-Source: APXvYqziYSHZnibpEjAuQy8WcPkLP+yDEzbr38rKsDuNohvXF7HW+oh/3c/dnF86ZooNn1vC49ZnVg==
X-Received: by 2002:a5d:4a02:: with SMTP id m2mr12358630wrq.193.1561964568794; 
 Mon, 01 Jul 2019 00:02:48 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id i188sm9536306wma.27.2019.07.01.00.02.47
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jul 2019 00:02:48 -0700 (PDT)
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
References: <20190621064615.20099-1-mst@redhat.com>
 <20190621064615.20099-3-mst@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <3cb25a1f-9640-eede-e2db-8816f155d7bf@gmail.com>
Date: Mon, 1 Jul 2019 10:03:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190621064615.20099-3-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH 2/3] pcie: check that slt ctrl changed
 before deleting
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 6/21/19 9:46 AM, Michael S. Tsirkin wrote:
> During boot, linux would sometimes overwrites control of a powered off
> slot before powering it on. Unfortunately QEMU interprets that as a
> power off request and ejects the device.
>
> For example:
>
> /x86_64-softmmu/qemu-system-x86_64 -enable-kvm -S -machine q35  \
>      -device pcie-root-port,id=pcie_root_port_0,slot=2,chassis=2,addr=0x2,bus=pcie.0 \
>      -monitor stdio disk.qcow2
> (qemu)device_add virtio-balloon-pci,id=balloon,bus=pcie_root_port_0
> (qemu)cont
>
> Balloon is deleted during guest boot.
>
> To fix, save control beforehand and check that power
> or led state actually change before ejecting.
>
> Note: this is more a hack than a solution, ideally we'd
> find a better way to detect ejects, or move away
> from ejects completely and instead monitor whether
> it's safe to delete device due to e.g. its power state.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   include/hw/pci/pcie.h              |  3 ++-
>   hw/pci-bridge/pcie_root_port.c     |  5 ++++-
>   hw/pci-bridge/xio3130_downstream.c |  5 ++++-
>   hw/pci/pcie.c                      | 14 ++++++++++++--
>   4 files changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index e30334d74d..8d90c0e193 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -107,7 +107,8 @@ void pcie_cap_lnkctl_reset(PCIDevice *dev);
>   
>   void pcie_cap_slot_init(PCIDevice *dev, uint16_t slot);
>   void pcie_cap_slot_reset(PCIDevice *dev);
> -void pcie_cap_slot_write_config(PCIDevice *dev,
> +void pcie_cap_slot_get(PCIDevice *dev, uint16_t *slot_ctl, uint16_t *slt_sta);
> +void pcie_cap_slot_write_config(PCIDevice *dev, uint16_t slot_ctl, uint16_t slt_sta,
>                                   uint32_t addr, uint32_t val, int len);
>   int pcie_cap_slot_post_load(void *opaque, int version_id);
>   void pcie_cap_slot_push_attention_button(PCIDevice *dev);
> diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
> index 92f253c924..09019ca05d 100644
> --- a/hw/pci-bridge/pcie_root_port.c
> +++ b/hw/pci-bridge/pcie_root_port.c
> @@ -31,10 +31,13 @@ static void rp_write_config(PCIDevice *d, uint32_t address,
>   {
>       uint32_t root_cmd =
>           pci_get_long(d->config + d->exp.aer_cap + PCI_ERR_ROOT_COMMAND);
> +    uint16_t slt_ctl, slt_sta;
> +
> +    pcie_cap_slot_get(d, &slt_ctl, &slt_sta);
>   
>       pci_bridge_write_config(d, address, val, len);
>       rp_aer_vector_update(d);
> -    pcie_cap_slot_write_config(d, address, val, len);
> +    pcie_cap_slot_write_config(d, slt_ctl, slt_sta, address, val, len);
>       pcie_aer_write_config(d, address, val, len);
>       pcie_aer_root_write_config(d, address, val, len, root_cmd);
>   }
> diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
> index 264e37d6a6..899b0fd6c9 100644
> --- a/hw/pci-bridge/xio3130_downstream.c
> +++ b/hw/pci-bridge/xio3130_downstream.c
> @@ -41,9 +41,12 @@
>   static void xio3130_downstream_write_config(PCIDevice *d, uint32_t address,
>                                            uint32_t val, int len)
>   {
> +    uint16_t slt_ctl, slt_sta;
> +
> +    pcie_cap_slot_get(d, &slt_sta, &slt_ctl);
>       pci_bridge_write_config(d, address, val, len);
>       pcie_cap_flr_write_config(d, address, val, len);
> -    pcie_cap_slot_write_config(d, address, val, len);
> +    pcie_cap_slot_write_config(d, slt_ctl, slt_sta, address, val, len);
>       pcie_aer_write_config(d, address, val, len);
>   }
>   
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index b22527000d..f8490a00de 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -594,7 +594,15 @@ void pcie_cap_slot_reset(PCIDevice *dev)
>       hotplug_event_update_event_status(dev);
>   }
>   
> -void pcie_cap_slot_write_config(PCIDevice *dev,
> +void pcie_cap_slot_get(PCIDevice *dev, uint16_t *slt_ctl, uint16_t *slt_sta)
> +{
> +    uint32_t pos = dev->exp.exp_cap;
> +    uint8_t *exp_cap = dev->config + pos;
> +    *slt_ctl = pci_get_word(exp_cap + PCI_EXP_SLTCTL);
> +    *slt_sta = pci_get_word(exp_cap + PCI_EXP_SLTSTA);
> +}
> +
> +void pcie_cap_slot_write_config(PCIDevice *dev, uint16_t slt_ctl, uint16_t slt_sta,
>                                   uint32_t addr, uint32_t val, int len)
>   {
>       uint32_t pos = dev->exp.exp_cap;
> @@ -623,7 +631,9 @@ void pcie_cap_slot_write_config(PCIDevice *dev,
>        * controller is off, it is safe to detach the devices.
>        */
>       if ((sltsta & PCI_EXP_SLTSTA_PDS) && (val & PCI_EXP_SLTCTL_PCC) &&
> -        ((val & PCI_EXP_SLTCTL_PIC_OFF) == PCI_EXP_SLTCTL_PIC_OFF)) {
> +        (val & PCI_EXP_SLTCTL_PIC_OFF) == PCI_EXP_SLTCTL_PIC_OFF &&
> +        (!(slt_ctl & PCI_EXP_SLTCTL_PCC) ||
> +        (slt_ctl & PCI_EXP_SLTCTL_PIC_OFF) != PCI_EXP_SLTCTL_PIC_OFF)) {
>           PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(dev));
>           pci_for_each_device(sec_bus, pci_bus_num(sec_bus),
>                               pcie_unplug_device, NULL);


Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Thanks,
Marcel

