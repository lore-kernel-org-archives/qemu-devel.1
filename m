Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF96BC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:10:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10EDC20B1F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="suo9jj9f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10EDC20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ7L3-0000g0-1j
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 07:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kQ7Jt-0008V3-17
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 07:09:17 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38400)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kQ7Jq-0003rj-S9
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 07:09:16 -0400
Received: by mail-wr1-x443.google.com with SMTP id n18so1670622wrs.5
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 04:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=uiv3OaFqYCcpvMry9h+3mT4rKuYQPnJ3d9uSYnMJJUk=;
 b=suo9jj9frBwbfUlXBrIEuXw310zzYfxAFOcvRPlR6tME+6ZqwgzczWUpoLkrJ7sAg9
 UdeqCLr2F4/Ci+nEHFoS/f01NzkNl17vOEZnEaccATqxsj06LLigeLziWkXClaHJrYDp
 ANySYNCag6CZz69z2tzMTwN6flwEkNPshZBufwqKl1Xy8c8oLK3Z6lVuKD7osiDuGVoG
 klPrJZZYgkt2Tt3ZAvLDq4AS3SxAB2Zu89X/PO2pUtm9j630yNbrd4YHJ2FMWTnuBvKJ
 XoGOb5tEcx1k4VyhRgTIXofGKzwKlqq7O1bDGwlpYDs5KNhL3Wlwbu1Ftu0IS9vsIuOZ
 qIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=uiv3OaFqYCcpvMry9h+3mT4rKuYQPnJ3d9uSYnMJJUk=;
 b=SiolujBAu53kUdOMBqsRwYXdEPw97Yej4Qox/+Xjs7dsBAplNUCMTP6V1AkxwYo0uh
 N+r6RaGp6z92CbDmon2GTONDUp2Vlz/jRqnqsV3UAA5pDhucOFKxVu9B4ZsqjoWQfSZI
 FQlNigSBQIiAM8S5BGpYI79nDGmMiDBhXBiZucAS/MoWq+74o72odGLUgEow6C5VLdfV
 THhy8N+FPfHcdWLuEZW6AD9iiweWSnHVjT7VjjOwNEB373Gav2Wgm8v+NOUgy+/Wh8iV
 /cIQwI1xtU7dn2Ef6naxivuFUGITpHiT4d9Nl2LsUHjJD5YGiY87mJ0lFaXTAZ9qs7ye
 zAfg==
X-Gm-Message-State: AOAM5331FDHisVjPhWtwCuqlcOCOrkUhRE+jIE0VEk/sOXwtNkxowEpP
 SyDOit/qLzmuk9webVtLKkTBOw==
X-Google-Smtp-Source: ABdhPJwKI628NMPkwrx3HBEqrB6ZXhBM5Et0IfnORMum8cIz6mfF4+wapdgihWZODrWEKBuoo0ncIA==
X-Received: by 2002:adf:a29a:: with SMTP id s26mr2916710wra.197.1602068953194; 
 Wed, 07 Oct 2020 04:09:13 -0700 (PDT)
Received: from xora-monster ([2a02:8010:64d6::1d89])
 by smtp.gmail.com with ESMTPSA id k8sm2278476wrl.42.2020.10.07.04.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 04:09:12 -0700 (PDT)
Date: Wed, 7 Oct 2020 12:09:10 +0100
From: Graeme Gregory <graeme@nuviainc.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 1/2] hw/arm/sbsa-ref : Fix SMMUv3 Initialisation
Message-ID: <20201007110910.6tp6uwqj7qbeyi2j@xora-monster>
References: <20201007100732.4103790-1-graeme@nuviainc.com>
 <20201007100732.4103790-2-graeme@nuviainc.com>
 <c518a446-94ca-f21a-2e49-e2cd8171e581@amsat.org>
 <20201007103220.z5pc5qjoyxbowyrb@xora-monster>
 <aafcbb37-dc5a-e608-21fe-6e65e36df5e4@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aafcbb37-dc5a-e608-21fe-6e65e36df5e4@amsat.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=graeme@nuviainc.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, leif@nuviainc.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, rad@semihalf.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 07, 2020 at 12:44:43PM +0200, Philippe Mathieu-Daudé wrote:
> On 10/7/20 12:32 PM, Graeme Gregory wrote:
> > On Wed, Oct 07, 2020 at 12:24:32PM +0200, Philippe Mathieu-DaudÃƒÂ© wrote:
> >> On 10/7/20 12:07 PM, Graeme Gregory wrote:
> >>> SMMUv3 has an error in a previous patch where an i was transposed to a 1
> >>> meaning interrupts would not have been correctly assigned to the SMMUv3
> >>> instance.
> >>>
> >>> Fixes: 48ba18e6d3f3 ("hw/arm/sbsa-ref: Simplify by moving the gic in the machine state")
> >>> Signed-off-by: Graeme Gregory <graeme@nuviainc.com>
> >>
> >> Again, this fix is already in Peter's queue:
> >> https://www.mail-archive.com/qemu-devel@nongnu.org/msg732819.html
> >>
> >> But if you repost, please collect the reviewer tags,
> >> so we don't have to review it again. This one has:
> >> Reviewed-by: Philippe Mathieu-DaudÃƒÂ© <f4bug@amsat.org>
> >> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> >>
> > 
> > Ah I thought splitting the patch invalidated Eric's reviewed by?
> > 
> > This is a different fix to the one you are referring to, previous one
> > was in PCIe.
> > 
> > Apologies if I have missed an email from you but I have not received a
> > Reviewed by from you for the SMMUv3 IRQ fix.
> 
> Oops sorry my bad, I thought this was a repost of the PCIe fix.
> 
> So:
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Looking at 48ba18e6d3f3 I messed create_smmu() and
> create_pcie() but you now fixed both cases.
> 
> And you are right, this patch isn't reviewed by Eric.
> 

Thanks, they are confusingly similar patches.

Graeme

> > 
> > Thanks
> > 
> > Graeme
> > 
> >> Thanks,
> >>
> >> Phil.
> >>
> >>> ---
> >>>  hw/arm/sbsa-ref.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> >>> index 9c3a893bed..65e64883b5 100644
> >>> --- a/hw/arm/sbsa-ref.c
> >>> +++ b/hw/arm/sbsa-ref.c
> >>> @@ -525,7 +525,7 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
> >>>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
> >>>      for (i = 0; i < NUM_SMMU_IRQS; i++) {
> >>>          sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
> >>> -                           qdev_get_gpio_in(sms->gic, irq + 1));
> >>> +                           qdev_get_gpio_in(sms->gic, irq + i));
> >>>      }
> >>>  }
> >>>  
> >>>
> > 

