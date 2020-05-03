Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B067AC47256
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 07:47:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AA21207DD
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 07:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEIIf6Tm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA21207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jV9LW-00047B-MR
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 03:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1jV9Kg-0003bC-F5
 for qemu-devel@nongnu.org; Sun, 03 May 2020 03:46:38 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46622)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1jV9Kf-0004Zv-Hl
 for qemu-devel@nongnu.org; Sun, 03 May 2020 03:46:38 -0400
Received: by mail-wr1-x444.google.com with SMTP id f13so17012240wrm.13
 for <qemu-devel@nongnu.org>; Sun, 03 May 2020 00:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=2s5pH4lt5wnKw6fLxmVQqYjLhG6XnK9V068LEHtX8e0=;
 b=cEIIf6Tmw9vDuxa4hakc2NOB1DSEPX3D19lD2T56C18zt1ZxSwOkH+un1ytw9KDJXn
 VyPv4svprgCbL0qTiTkhMzgC7tAQ873aTazSVWBBn2UPbNkLiBKinlR0m7Tr8h3brOFu
 rZMkyXqlajirZMOqyvu83m6u6Fi78eIB5ffIUensnIECNaHRQTHLhERTBokB5NFQ2HLp
 4O/JCmmhM2YogfI/y2fdi3CS2TB3wjk1c/Z9n1g1F6vhIUw1UuFTDHOrbhgGurXoqGFe
 RnabxVKFhGMXTb3e4n224MmsKld2kKVWEXGG522/bHwxOEYxM8g3srsgxRxNWlhegJEV
 HrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=2s5pH4lt5wnKw6fLxmVQqYjLhG6XnK9V068LEHtX8e0=;
 b=CKQzyMBPXwQDpGFE2kdYQhGcIQADEMxchx528jW8cl3LnJ6U1APxgD984x4lt+XiBM
 JzQK58CrBHLtb9teJUyEgDuP6W3krinqr8PZ0DvjO1W1+xeQAS4d1nAYYg3OlNiPfd/y
 Izl6rGakniwUzECKv6nE1SAKcN2Zudlh5uMUD6E7C2bjs55LnLsGroPTdqIjwjYUqWsz
 w7URymL6JvUr5JqnkN7nIpCSXf1gd26v9wu4YdkaJJEcG8T2RjcBbkoqswGjoB+TsniL
 gvCJncKy8tOBptMlVaYr81IoZZ22EDOpzR6t8oUp/5Nvbxneb84k3uX38oM7Rx1F0hOM
 nUdw==
X-Gm-Message-State: AGi0PuZozbISr/Vw9u5agNkxfZC8R3lWA1juyNgYdwQ44eXhi+hmW3iy
 UsIJxnconmHl6Aw0yQpqMGw=
X-Google-Smtp-Source: APiQypKC/0LWn0G+08zuht6EaSTqXYeu1GTDP/EGnFw5qC9N81u2HO6EQWgbjrDmK0xjs2MoyiVKyQ==
X-Received: by 2002:adf:aa8e:: with SMTP id h14mr14056664wrc.371.1588491995569; 
 Sun, 03 May 2020 00:46:35 -0700 (PDT)
Received: from [192.168.86.46] ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id d143sm7680510wmd.16.2020.05.03.00.46.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 May 2020 00:46:34 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] hw/pci/pcie: Forbid hot-plug if it's disabled on
 the slot
To: Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org
References: <20200427182440.92433-1-jusual@redhat.com>
 <20200427182440.92433-2-jusual@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <2aa78889-043e-32af-e30f-f6d337f26d3f@gmail.com>
Date: Sun, 3 May 2020 10:46:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200427182440.92433-2-jusual@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=marcel.apfelbaum@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 4/27/20 9:24 PM, Julia Suvorova wrote:
> Raise an error when trying to hot-plug/unplug a device through QMP to a device
> with disabled hot-plug capability. This makes the device behaviour more
> consistent and provides an explanation of the failure in the case of
> asynchronous unplug.
>
> Signed-off-by: Julia Suvorova <jusual@redhat.com>
> ---
> v2:
>      * Change error text [Igor, Michael]
>      * Move cleanup to a separate patch [Marcel]
>
>   hw/pci/pcie.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 0eb3a2a5d2..6b48d04d2c 100644
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
> +    /* Check if hot-plug is disabled on the slot */
> +    if ((sltcap & PCI_EXP_SLTCAP_HPC) == 0) {
> +        error_setg(errp, "Hot-plug failed: unsupported by the port device '%s'",
> +                         DEVICE(hotplug_pdev)->id);
> +        return;
> +    }
> +
>       /* To enable multifunction hot-plug, we just ensure the function
>        * 0 added last. When function 0 is added, we set the sltsta and
>        * inform OS via event notification.
> @@ -470,6 +478,17 @@ void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
>       Error *local_err = NULL;
>       PCIDevice *pci_dev = PCI_DEVICE(dev);
>       PCIBus *bus = pci_get_bus(pci_dev);
> +    PCIDevice *hotplug_pdev = PCI_DEVICE(hotplug_dev);
> +    uint8_t *exp_cap = hotplug_pdev->config + hotplug_pdev->exp.exp_cap;
> +    uint32_t sltcap = pci_get_word(exp_cap + PCI_EXP_SLTCAP);
> +
> +    /* Check if hot-unplug is disabled on the slot */
> +    if ((sltcap & PCI_EXP_SLTCAP_HPC) == 0) {
> +        error_setg(errp, "Hot-unplug failed: "
> +                         "unsupported by the port device '%s'",
> +                         DEVICE(hotplug_pdev)->id);
> +        return;
> +    }
>   
>       pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev, &local_err);
>       if (local_err) {

Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Thanks,
Marcel


