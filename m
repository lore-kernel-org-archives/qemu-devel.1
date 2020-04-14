Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DB8C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 08:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6B732072D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 08:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UONp0UvM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B732072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOGcN-000894-3i
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 04:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1jOGbQ-0007I7-JZ
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 04:07:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1jOGbP-0004TM-AI
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 04:07:28 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38865)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1jOGbL-0004Rs-M7; Tue, 14 Apr 2020 04:07:23 -0400
Received: by mail-wm1-x344.google.com with SMTP id g12so5037249wmh.3;
 Tue, 14 Apr 2020 01:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=kgpir2riDbsEXAJ/iYCwjebfSIsaVTDSawOicLa32RU=;
 b=UONp0UvMkkvJKksGytyRR1BgPYZDyUNpgMBnAVkivH9Um3bWPHb06wS96g/rNisKEH
 /WNVvi+kCJuEhczT4li1EhBctlHlCVPfgGOurFbKhwEHb6vZsEdepb+iI/HxYDV63t7Q
 pPr6cGK07/F9XoprdgvrW1WGzMYAPuPwJxbmfKOFZZc0N+C40G+2zKtFuhIOV7qZZWmf
 bacr7/Ehh5z+zq5r+q2oTnNxhttKEiAClCpH4q7rhGRZH/ykJjpcouCn+YblHDfedHqt
 spdUH6t27u6HXE4GsO/9f61obLMGWvfFQ5tma+EB6ajustlFUjHjVUqCAFtyEhqMWTNP
 bU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=kgpir2riDbsEXAJ/iYCwjebfSIsaVTDSawOicLa32RU=;
 b=SV5T9LFFbYTW6DirgaraJHiLoaAo5Gu51/Tqa1dziJkDOoNvlIAJJitCbqpsSYtTS9
 d6jbm25Ev3IvzyoULphwfBEEINUdEjYs5E94dK9JWf9oj5EFK1MXy0iLIzeYY+N9zI7o
 kgIrE5w93juvSO4GViHEEvaLMpviEl+o2xH1y2s0375k8kK2xRYWHUW6FW7AIfYQm99x
 TEUuwT1CzPwHlXRLvF0uSm4A6Q1FC40QwRNt3fVW+h1mq+ejotpcWQ1W7XjMkK/f+cdI
 CSqaTci7ojghdObPhed+hwg06awb8ShbzQUg6c48R2C5Kk2eAOzxWebFeiAEX5NlFZGp
 0yyg==
X-Gm-Message-State: AGi0PuazcU+A9bAjJFkGhHndx9aApIcP5a5rv1j4BfHG5t0riQxg+aF7
 VbcuNDfa/PNkJ4lJbEaJtIs=
X-Google-Smtp-Source: APiQypLM1u0/o6t3ZHZyZL23KVVquhDmfE/eYVowtgDAj5Ik8SvfrYgezNx9HFHfG1joMQ2ZbzbsYA==
X-Received: by 2002:a1c:678a:: with SMTP id
 b132mr23033147wmc.107.1586851642267; 
 Tue, 14 Apr 2020 01:07:22 -0700 (PDT)
Received: from [192.168.86.37] ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id i25sm17614252wml.43.2020.04.14.01.07.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2020 01:07:21 -0700 (PDT)
Subject: Re: [PATCH] hw/pci/pcie: Forbid hot-plug via QMP if it's disabled on
 the slot
To: Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org
References: <20200407145017.1041256-1-jusual@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <d942234c-df99-c7c3-bddd-ea1a2daf097d@gmail.com>
Date: Tue, 14 Apr 2020 11:07:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200407145017.1041256-1-jusual@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Laine Stump <laine@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Julia,

On 4/7/20 5:50 PM, Julia Suvorova wrote:
> Raise an error when trying to hot-plug/unplug a device through QMP to a device
> with disabled hot-plug capability. This makes the device behaviour more
> consistent and provides an explanation of the failure in the case of
> asynchronous unplug.
>
> Signed-off-by: Julia Suvorova <jusual@redhat.com>
> ---
>   hw/pci/pcie.c | 24 +++++++++++++++++++++---
>   1 file changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 0eb3a2a5d2..e9798caa8a 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -415,6 +415,7 @@ void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>   {
>       PCIDevice *hotplug_pdev = PCI_DEVICE(hotplug_dev);
>       uint8_t *exp_cap = hotplug_pdev->config + hotplug_pdev->exp.exp_cap;
> +    uint32_t sltcap = pci_get_word(exp_cap + PCI_EXP_SLTCAP);
>       PCIDevice *pci_dev = PCI_DEVICE(dev);
>   
>       /* Don't send event when device is enabled during qemu machine creation:
> @@ -430,6 +431,13 @@ void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>           return;
>       }
>   
> +    /* Hot-plug is disabled on the slot */
> +    if ((sltcap & PCI_EXP_SLTCAP_HPC) == 0) {
> +        error_setg(errp, "Device '%s' does not support hot-plug",
> +                         DEVICE(hotplug_dev)->id);
> +        return;
> +    }
> +
>       /* To enable multifunction hot-plug, we just ensure the function
>        * 0 added last. When function 0 is added, we set the sltsta and
>        * inform OS via event notification.
> @@ -464,14 +472,24 @@ static void pcie_unplug_device(PCIBus *bus, PCIDevice *dev, void *opaque)
>       object_unparent(OBJECT(dev));
>   }
>   
> -void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
> +void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_handler,
>                                        DeviceState *dev, Error **errp)
>   {
>       Error *local_err = NULL;
>       PCIDevice *pci_dev = PCI_DEVICE(dev);
>       PCIBus *bus = pci_get_bus(pci_dev);
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

Since this chunk appears twice I would consider refactoring it into
a helper function. (I see the error message is different, but I suppose 
it can be tweaked)

>   
> -    pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev, &local_err);
> +    pcie_cap_slot_plug_common(hotplug_dev, dev, &local_err);

It doesn't seems related to this patch.

>       if (local_err) {
>           error_propagate(errp, local_err);
>           return;
> @@ -490,7 +508,7 @@ void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
>           return;
>       }
>   
> -    pcie_cap_slot_push_attention_button(PCI_DEVICE(hotplug_dev));
> +    pcie_cap_slot_push_attention_button(hotplug_dev);

Same here, maybe you can split it in 2 patches.

Thanks,
Marcel

>   }
>   
>   /* pci express slot for pci express root/downstream port


