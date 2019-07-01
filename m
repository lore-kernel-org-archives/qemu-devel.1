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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26B1C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 07:01:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A666D205F4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 07:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXDxr+S2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A666D205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhqJl-0004nz-V8
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 03:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48884)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1hhqJC-0004MS-G2
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 03:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1hhqJB-0000oF-Dn
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 03:01:02 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34120)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1hhqJ9-0000fn-As
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 03:00:59 -0400
Received: by mail-wr1-x444.google.com with SMTP id u18so4280672wru.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 00:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=G1Wd5AFp7zFQ7+vYIbsKoaivLr2sp8UHGHM9Ruig1I4=;
 b=QXDxr+S24iSiD66gA994hrKHlXg0Q/unYRmeziacxNlPsDsNQQ7v3AH28S7R5Q63eK
 BQdkZOXFNuBhUd2CNZaRaMl/HxArJPs5AgyMoND7qtJmNvBB3UAtDkXgwuaBzUhKWGHw
 xe88b9Llj3HA3jWMIx45bx8QNxnD4p8Gd2PNx9GN+BdeRCYLIo8gAg2r1dSkkFzyrOMj
 kUgFz5q/Kur+vHhVh68N6X45DJoNFCDHLD1hNpFLjG9Q4DoEdk4DWN3rcNiqb/1VyuHj
 823pkizaAG9AiVzIQ8MKXroQ4H5ltiyC824d+k+SFZuSya+ujOcMqbykvwm8gN24PXh+
 fgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=G1Wd5AFp7zFQ7+vYIbsKoaivLr2sp8UHGHM9Ruig1I4=;
 b=bn3khKIWeUAKHvz/oyp/OrDtG0uyJb5el8KKJDxpMg3+ADa8D1+BkceQAK6ZO5CsDz
 pRkONLpocytWsHT/CUEA0HpPLuTFnnuxNE4gbpIGS5xwsOuiJ2Fl05FIwf5xymzusDC+
 /AGItKQRe67QZCP04VS6vqJzPwmU3Rne5AfIQnZutLnbMT39pvsuqrEjbD0xPTdPP8zF
 wzX3aI0GhLyuiAPmZXN7HUgtcBf/MHCI8aL/9Fd9tN+E4FsHdrlLQOHYolez/iUsd7pI
 EtbahSutSJnpeK72uiH8rFQntbCcK0p4cWJzVkBM7lDiYkAEMKeRkpcImh7Arz9KX+S9
 U+Ig==
X-Gm-Message-State: APjAAAX4CucNq7Vw6cg+w890rusqKjNZgRAU+q/iRwu+6lyuD1r1SbpO
 pgPF47jr1LyUt5fRJQ0Z6K4sq3bG
X-Google-Smtp-Source: APXvYqznRck8j/qfFEg08GY27env15irkfjvDRnfmG5iw+Ceic0gfdv3AaifmCy4xw49KZoFu/R3GQ==
X-Received: by 2002:adf:f80a:: with SMTP id s10mr5040437wrp.39.1561964450831; 
 Mon, 01 Jul 2019 00:00:50 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id y24sm9416313wmi.10.2019.07.01.00.00.49
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jul 2019 00:00:50 -0700 (PDT)
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
References: <20190621064615.20099-1-mst@redhat.com>
 <20190621064615.20099-2-mst@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <ec0c5538-2093-6b19-4635-56597588a172@gmail.com>
Date: Mon, 1 Jul 2019 10:01:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190621064615.20099-2-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH 1/3] pcie: don't skip multi-mask events
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
> If we are trying to set multiple bits at once, testing that just one of
> them is already set gives a false positive. As a result we won't
> interrupt guest if e.g. presence detection change and attention button
> press are both set. This happens with multi-function device removal.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   hw/pci/pcie.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 88c30ff74c..b22527000d 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -383,7 +383,7 @@ static void pcie_cap_slot_event(PCIDevice *dev, PCIExpressHotPlugEvent event)
>   {
>       /* Minor optimization: if nothing changed - no event is needed. */
>       if (pci_word_test_and_set_mask(dev->config + dev->exp.exp_cap +
> -                                   PCI_EXP_SLTSTA, event)) {
> +                                   PCI_EXP_SLTSTA, event) == event) {
>           return;
>       }
>       hotplug_event_notify(dev);

Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Thanks,
Marcel

