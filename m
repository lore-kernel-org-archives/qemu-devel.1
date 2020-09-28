Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F55C4727F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:37:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A026B21D95
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="NOm68y4G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A026B21D95
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMpaf-00069l-LA
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 05:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kMpZe-0005aq-DY
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:35:58 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37462)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kMpZb-00052R-Sv
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:35:58 -0400
Received: by mail-wm1-x343.google.com with SMTP id a9so411772wmm.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 02:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=ynyAuloBqMxpWXLnS0x1CRYgjLxv7glQL157MRYGbaQ=;
 b=NOm68y4GdOW95blTIQOEA3PlCVuKuVXVjrKBDXAbxFjkC7fgtvoxvgRK2DeuGk3dJx
 vKJcauN1XSCD7BLZv/H4dlw2UQ8Zqpm0kx5m5/tk7RC31JkmbYBhulp372x7e4fxXqSA
 D1BiAS9UHDx9UPtoIb17zkfcyWniYZOf1QA5dmRtof6VG3Z/ueIkcRBoCs+ZNjz0R8zk
 oP343K+HiO46/LmGCESPKE69Y2+a1xF+ebx884SU8lYvtSbrKb02bbUWG588CtHMIyxH
 KieOIFuPzAJ8p7WY5moIx163tHSxHHEF/GTu5vNjpNMmkdHCVdo7VP0LwKEYXvEwMSNM
 syBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ynyAuloBqMxpWXLnS0x1CRYgjLxv7glQL157MRYGbaQ=;
 b=tiJIeP/UXP32csErpn9p5xzSpR3AFK+z0yrFXcIKgVWou5554RLTiXNHxtg5nlhwrN
 ms6gxxf5v9FhMvUEG90Y3D6vRjnpiMFJ0LVTrpUqSmWi3VhP5mJe3qB4Qt3yazayqvtS
 dangLDPZD9OZ+Pdl/sxQZCq3a+vUpfr9OoplkIzGJ9offH5l6aGeejVyyNAl4bhEfI/B
 6R0a2b/HBJZF0Ha2dhHl/VJGgHd5Rg+1CMtie//SouvHUi8C3hU2VVYHhrhPXbopIqDd
 pGrckYsqf8VTlwn5EdzP93HKjvP5oZ/xhvAZerw89jhwn91yF2Sj25lPeh9VTDPgcvUE
 zwtg==
X-Gm-Message-State: AOAM531V4GCe7VKbucOZSYGG6WSjDpPvb4ld9bdN9GFIoBYt/5H9UYdd
 zW7uXtCF0N8SFMQF4591onSEUQ==
X-Google-Smtp-Source: ABdhPJxujOKGhgndeeleUHszQoLOrCfkJ/3Hvd9F9W+vJezWEA3CL0ZPdZysVuunxFesYXnzl1wg6w==
X-Received: by 2002:a7b:c090:: with SMTP id r16mr734026wmh.56.1601285753984;
 Mon, 28 Sep 2020 02:35:53 -0700 (PDT)
Received: from xora-monster ([2a02:8010:64d6::1d89])
 by smtp.gmail.com with ESMTPSA id d13sm672886wrp.44.2020.09.28.02.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 02:35:53 -0700 (PDT)
Date: Mon, 28 Sep 2020 10:35:50 +0100
From: Graeme Gregory <graeme@nuviainc.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH] hw/arm/sbsa-ref : Fix SMMUv3 Initialisation
Message-ID: <20200928093550.epbudrvdk2v47bct@xora-monster>
References: <20200925133902.28349-1-graeme@nuviainc.com>
 <f67b75fe-c5ce-8b95-e19b-fc4ce2217b31@redhat.com>
 <e548848c-75ac-e82e-f40d-7c1ae70a6e02@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e548848c-75ac-e82e-f40d-7c1ae70a6e02@amsat.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=graeme@nuviainc.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, jamie@nuviainc.com, rad@semihalf.com,
 qemu-devel@nongnu.org, Auger Eric <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 leif@nuviainc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Sep 26, 2020 at 09:45:24AM +0200, Philippe Mathieu-Daudé wrote:
> Hi Gregory,
> 
> On 9/25/20 4:00 PM, Auger Eric wrote:
> > Hi Gregory,
> > 
> > On 9/25/20 3:39 PM, Graeme Gregory wrote:
> >> SMMUv3 has an error in previous patch where a i was transposed to a 1
> >> meaning interrupts would not have been correctly assigned to the SMMUv3
> >> instance.
> 
> This is a first issue, fixing 48ba18e6d3f3.
> 
> >>
> >> The code also contained an error in that the IRQs were never allocated
> >> in the irqmap.
> 
> This is another issue, not well explained. IIUC IRQs *are* allocated as
> IRQ #0, right?
> 
> This fixes commit e9fdf453240 ("hw/arm: Add arm SBSA reference machine,
> devices part"). Can you split this in another patch please? Eventually
> Cc'ing qemu-stable@nongnu.org as suggested by Peter.
> 

Ok I will split and issue v2 ASAP

Thanks

Graeme

> >>
> >> Fixes: 48ba18e6d3f3 ("hw/arm/sbsa-ref: Simplify by moving the gic in the machine state")
> >> Signed-off-by: Graeme Gregory <graeme@nuviainc.com>
> > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > 
> > Thanks
> > 
> > Eric
> > 
> >> ---
> >>  hw/arm/sbsa-ref.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> >> index 257ada9425..9109fb58be 100644
> >> --- a/hw/arm/sbsa-ref.c
> >> +++ b/hw/arm/sbsa-ref.c
> >> @@ -138,6 +138,7 @@ static const int sbsa_ref_irqmap[] = {
> >>      [SBSA_SECURE_UART_MM] = 9,
> >>      [SBSA_AHCI] = 10,
> >>      [SBSA_EHCI] = 11,
> >> +    [SBSA_SMMU] = 12, /* ... to 15 */
> >>  };
> >>  
> >>  static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
> >> @@ -530,7 +531,7 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
> >>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
> >>      for (i = 0; i < NUM_SMMU_IRQS; i++) {
> >>          sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
> >> -                           qdev_get_gpio_in(sms->gic, irq + 1));
> >> +                           qdev_get_gpio_in(sms->gic, irq + i));
> 
> BTW this fix is already in Peter's queue:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg732819.html
> 
> Thanks,
> 
> Phil.
> 
> >>      }
> >>  }
> >>  
> >>
> > 
> 

