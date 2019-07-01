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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A07C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 07:04:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54A4B205F4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 07:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1owz0OS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A4B205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhqMv-0006jF-Gl
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 03:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49309)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1hhqLy-0006Hw-1I
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 03:03:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1hhqLv-000333-S3
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 03:03:53 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44999)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1hhqLu-00031W-GA
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 03:03:51 -0400
Received: by mail-wr1-x443.google.com with SMTP id e3so2903840wrs.11
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 00:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=okF+HjwM0hkTIshDJ4O570nshOsgRoP+WSAZr9UnH1Q=;
 b=m1owz0OSsLAMETgY2uktnTj7EfwCiDvnZm5mdKUVI+Bw1O8pMqiPsWHwR25gP5dvU5
 hvM4jhbS11oVasoz6leRhyjtaumofe3nGUg3JUJxBsQfFKTQxPPhWzBVHqLy8rYUIBp1
 yLIMiVXiuHp4oX1TtU8sVVxBHrYx1LHuXw/HpmJA+tD5t6wmTGevvqRZDqohllWAoT+n
 0MYqWAi7spCOuPWhkq0Txc7p3ZAzcQhHGGPUmrbCAI9kCGZvRO57Q+6MigptiQ7Z+Sa0
 S+oRKjFQYQI8J8ua6TvZRJMRsuPYDYf+um9MGw3Ao/OFLimWZ9tpTtDtjIR1NzdYp8J6
 QwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=okF+HjwM0hkTIshDJ4O570nshOsgRoP+WSAZr9UnH1Q=;
 b=KfkxxS6kCBZNNBDfk6rEbV3qfHmzcsqDNc1wAjqmpZx83QwmcU+iBXMRpkwLrOv84w
 AYqiYTPLIBDHRRWvEWZmYYm98Q4EhYuwQ6oNcukErxK7TdkCvutT5+bBhaMJqmbsePbA
 rwokAO0sUDzMKsN7bc1xT8stGB1ByuegPgvBnjnLnNcwLtsPkiwHOUJTdajfMIX/fxuF
 VSxPbmNvD9oE8WZNZcIOGghqXIYBDsrefE5pQw5MllblOZiX6CMkeaZwwqLv1xgbMfCO
 EYpLI+RwerTp5AGG7pvrA/G9F4ylz7yy8Oc5o4/Ypf86+IFcoW+GWeeOjW7+DDMMaxbk
 wqvw==
X-Gm-Message-State: APjAAAVSt6icJzu1r2AXkysYv6qDe/zBz8hgDglUBlHYqiKKT2n+zkCe
 CY3Hla5qHLvNSNp2fbtdn6keWJX1
X-Google-Smtp-Source: APXvYqwAPo0MRLSVKxNWwq8caHlKL+4QjCgkqm6YD/6GUQpRKOL2ARYwAALMgI0DOCd55ZFu+9teUQ==
X-Received: by 2002:a5d:4ec1:: with SMTP id s1mr16419747wrv.19.1561964629200; 
 Mon, 01 Jul 2019 00:03:49 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id r5sm20221301wrg.10.2019.07.01.00.03.48
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jul 2019 00:03:48 -0700 (PDT)
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
References: <20190621064615.20099-1-mst@redhat.com>
 <20190621064615.20099-4-mst@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <4e4314f7-91cc-1413-9853-bfd2bbb26311@gmail.com>
Date: Mon, 1 Jul 2019 10:04:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190621064615.20099-4-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 3/3] pcie: work around for racy guest init
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
> During boot, linux guests tend to clear all bits in pcie slot status
> register which is used for hotplug.
> If they clear bits that weren't set this is racy and will lose events:
> not a big problem for manual hotplug on bare-metal, but a problem for us.
>
> For example, the following is broken ATM:
>
> /x86_64-softmmu/qemu-system-x86_64 -enable-kvm -S -machine q35  \
>      -device pcie-root-port,id=pcie_root_port_0,slot=2,chassis=2,addr=0x2,bus=pcie.0 \
>      -device virtio-balloon-pci,id=balloon,bus=pcie_root_port_0 \
>      -monitor stdio disk.qcow2
> (qemu)device_del balloon
> (qemu)cont
>
> Balloon isn't deleted as it should.
>
> As a work-around, detect this attempt to clear slot status and revert
> status to what it was before the write.
>
> Note: in theory this can be detected as a duplicate button press
> which cancels the previous press. Does not seem to happen in
> practice as guests seem to only have this bug during init.
>
> Note2: the right thing to do is probably to fix Linux to
> read status before clearing it, and act on the bits that are set.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   hw/pci/pcie.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index f8490a00de..c605d32dd4 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -610,6 +610,25 @@ void pcie_cap_slot_write_config(PCIDevice *dev, uint16_t slt_ctl, uint16_t slt_s
>       uint16_t sltsta = pci_get_word(exp_cap + PCI_EXP_SLTSTA);
>   
>       if (ranges_overlap(addr, len, pos + PCI_EXP_SLTSTA, 2)) {
> +        /*
> +         * Guests tend to clears all bits during init.
> +         * If they clear bits that weren't set this is racy and will lose events:
> +         * not a big problem for manual button presses, but a problem for us.
> +         * As a work-around, detect this and revert status to what it was
> +         * before the write.
> +         *
> +         * Note: in theory this can be detected as a duplicate button press
> +         * which cancels the previous press. Does not seem to happen in
> +         * practice as guests seem to only have this bug during init.
> +         */
> +#define PCIE_SLOT_EVENTS (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD | \
> +                          PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_PDC | \
> +                          PCI_EXP_SLTSTA_CC)
> +
> +        if (val & ~slt_sta & PCIE_SLOT_EVENTS) {
> +            sltsta = (sltsta & ~PCIE_SLOT_EVENTS) | (slt_sta & PCIE_SLOT_EVENTS);
> +            pci_set_word(exp_cap + PCI_EXP_SLTSTA, sltsta);
> +        }
>           hotplug_event_clear(dev);
>       }
>   

Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Thanks,
Marcel

