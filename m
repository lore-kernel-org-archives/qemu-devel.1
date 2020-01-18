Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852FCC33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 15:37:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F9992468C
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 15:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPqPO7vx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9992468C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isqAW-0006uI-ER
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 10:37:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isq9u-0006Ro-2u
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 10:37:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isq9s-0007QN-5j
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 10:37:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55906
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isq9s-0007PE-1I
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 10:37:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579361826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kZOuSEl4iO6gE6XvSiUZetOAYHSqnjI0Y5AsWQWBUvE=;
 b=JPqPO7vxyPkirtGGb8rtdW2kv9vpYRP6Og5ci4mc+L/kpdLHuqekhSKdtBh9Ypn7oUNGB9
 irKrt/dMg4iJh4FQ3elxb0Elc2O+1Yzp6Si7kOaZfd4Dye5hVYy91Mv0H54x5FVnQcvfVq
 HjSc0CsYCsc7/INa+Bv1AtwQ8oAXLNM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-PR6YvoCvNbSC7RAk0Zv3Kg-1; Sat, 18 Jan 2020 10:37:05 -0500
Received: by mail-wr1-f70.google.com with SMTP id z14so11962888wrs.4
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2020 07:37:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kZOuSEl4iO6gE6XvSiUZetOAYHSqnjI0Y5AsWQWBUvE=;
 b=FBKFe9hlMLhMVT7gTD+cSWGtGPkTvSGI6PVPB01L/ABG2j5m3MknxOiP0uE4EvHZBg
 APs7Xl7SuruYubmgzdvu7rv5aHw/xPG3doVB92mUDPJb4+yZywrHfES9vImOSX+7cmyR
 5CkWJP41xQ2rsM0ArqCqr0hKdlMT4S4yyXpR2J/p77eOHDCWgfSTQNgahPOZtkbMAqV9
 8UZJZtQo1fXNmMwA+TyNNekd40UZjbHjWWWAOd3XLd+ajBO7O8cOZ77IWloLx4zMZJIZ
 PaCDlaZxIs7/MaJvcZrRIgXOewoYQ8cXF+lbgHuJ68MM5G16d97AWXDRimEPZS+yLmc6
 6atA==
X-Gm-Message-State: APjAAAXzWfg7b9xZM//1chPr0mNjOFBQ/aLZdr4obaJ5M4zdg279YSWb
 ykQS3G2duWESnkYnVUpzk4FO9aezsCsnNeJ8p8S4mv/vfljT6uTJbMYWc/3115UQ1+NyYisQqYh
 +hOSK2MbVyaR2laY=
X-Received: by 2002:adf:dfd2:: with SMTP id q18mr9386155wrn.152.1579361824243; 
 Sat, 18 Jan 2020 07:37:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqxCyAa38feU2y8lRbm2w64gjOXtXu3geDtP2soL3p7siOcDp+WcRAilWoQOCiyQU8nXxvRYWg==
X-Received: by 2002:adf:dfd2:: with SMTP id q18mr9386134wrn.152.1579361823951; 
 Sat, 18 Jan 2020 07:37:03 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id z4sm14474137wma.2.2020.01.18.07.37.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jan 2020 07:37:03 -0800 (PST)
Subject: Re: [PATCH v3 03/17] hw/arm/allwinner-h3: add Clock Control Unit
To: Niek Linnenbank <nieklinnenbank@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Damien Hedde <damien.hedde@greensocs.com>
References: <20200108200020.4745-1-nieklinnenbank@gmail.com>
 <20200108200020.4745-4-nieklinnenbank@gmail.com>
 <CAPan3Woz1KdHpPA87ZfgzF+GE=RGOFDGdpDD3aMVkuUJwNSQNA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6dda3ab6-f537-8864-55ef-20d5d523f416@redhat.com>
Date: Sat, 18 Jan 2020 16:37:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAPan3Woz1KdHpPA87ZfgzF+GE=RGOFDGdpDD3aMVkuUJwNSQNA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: PR6YvoCvNbSC7RAk0Zv3Kg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Markus Armbruster <armbru@redhat.com>, Taylor Simpson <tsimpson@quicinc.com>,
 qemu-arm <qemu-arm@nongnu.org>, Michael Rolnik <mrolnik@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Niek,

On 1/13/20 8:18 PM, Niek Linnenbank wrote:
> Hi,
> 
> Just a friendly reminder for review of this patch and the others in this 
> series
> that don't yet have a reviewed-by tag :-)

You are right to ping the list after a week.

Cc'ing Damien for this particular patch, he might have good advises.


Looking at the stats from your cover:

  include/hw/arm/allwinner-h3.h          | 164 +++++
  include/hw/misc/allwinner-cpucfg.h     |  54 ++
  include/hw/misc/allwinner-h3-ccu.h     |  67 ++
  include/hw/misc/allwinner-h3-dramc.h   | 107 +++
  include/hw/misc/allwinner-h3-sysctrl.h |  68 ++
  include/hw/net/allwinner-sun8i-emac.h  | 103 +++
  include/hw/rtc/allwinner-rtc.h         | 129 ++++
  include/hw/sd/allwinner-sdhost.h       | 136 ++++
  hw/arm/allwinner-h3.c                  | 477 ++++++++++++++
  hw/arm/orangepi.c                      | 125 ++++
  hw/misc/allwinner-cpucfg.c             | 282 ++++++++
  hw/misc/allwinner-h3-ccu.c             | 243 +++++++
  hw/misc/allwinner-h3-dramc.c           | 358 ++++++++++
  hw/misc/allwinner-h3-sysctrl.c         | 140 ++++
  hw/misc/allwinner-sid.c                | 170 +++++
  hw/net/allwinner-sun8i-emac.c          | 871 +++++++++++++++++++++++++
  hw/rtc/allwinner-rtc.c                 | 386 +++++++++++
  hw/sd/allwinner-sdhost.c               | 848 ++++++++++++++++++++++++

  39 files changed, 5267 insertions(+), 2 deletions(-)

This is a LOT of code to process, keep in mind your series touches 
different subsystems with different maintainers. It is hard to know all 
of them in details.

Since your SoC is in the same family than the A10, I've Cc'ed Beniamino 
Galvani. You should Cc him in your v4, hopefully he can help reviewing.

Regarding the System Control Unit and SDRAM Controller, as I don't know 
this SoC so I have to digest the whole datasheet, so it takes me time, 
bare with me (I'm using my hobby time to review your work).

The last patch I plan to review in your series is the SD/MMC one:
  10 files changed, 1053 insertions(+), 2 deletions(-)

It is 1/5th of your series in a single patch, each time I try to look at 
it I get scared. Anyway today I could test NetBSD booting from a SD card 
so I am more confident.

Anyway, don't forget this comment from the New Contribution page:
https://wiki.qemu.org/Contribute/SubmitAPatch#Return_the_favor

   Peer review only works if everyone chips in a bit of review time.
   If everyone submitted more patches than they reviewed, we would
   have a patch backlog. A good goal is to try to review at least
   as many patches from others as what you submit.

With the quality of your patches, even if this is your first 
contribution, it is obvious you now understand various part of QEMU.
Don't be shy to look at other patches on the list and help the 
community, as the reviewed authors might review you back :)

That said, your series is almost there!

Regards,

Phil.

> 
> Regards,
> Niek


