Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F79CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E40262064B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GeN9REyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E40262064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMb6u-00011r-8F
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 13:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iMb5W-0008D7-P3
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:03:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iMb5V-0003Om-R5
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:03:22 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:47009)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iMb5V-0003OR-Kn
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:03:21 -0400
Received: by mail-pg1-x542.google.com with SMTP id e15so8149825pgu.13
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 10:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YretDNAG4e9jCKQB17m7IqnbbDa7fHH/XpvR5+yujK8=;
 b=GeN9REyzUZMAWGm1Li5nAHqXE5nS/4D3iLAHkgCHctHgnojs0QdFhoVyDJCH7F2gtv
 6EtwfHv27A23T+JMAMqQROw7uJFnJsu4uQVJcYl0AhB3mqKz6OVfCHzDNlHStUE2SF26
 px6mGQVS19qvVGi8bIXrgISBudaAc5faqTcJOkLzXTL+39SBEqHpatrbMcMy4jUibZx4
 8wd/cKJ8CVGYfsogRX/ViPE0eRjvAL1KuxpFuKn/lGbTFsN4KB0J7G5P76kbvaTlUo2Y
 BWWz2CvuGtyTTyZvsdBWsPCJQ4Zg9aa/mYvi4gznHuDGr7zW5tGTCJOZgzDt5DyAmHZI
 VHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YretDNAG4e9jCKQB17m7IqnbbDa7fHH/XpvR5+yujK8=;
 b=HFC5InwibgSxrjOBWJf8HH8INOm0Qh1fSiXEqKSMm1QybK6tVZdIVBnKAcW1nzdIpE
 Rbs0dQB2CvBkDHHRX22Onlk6sq7gH4G5MsCEQ3NRtIFbna8Vy/sdaGdHWzVNpL499/3Y
 Gh1E8tMlWEJ9kScm/O+Argb14T1mDAKs6cCAZmh00yAvebbkndrr0nauqlKkP17XV/8r
 HFS2ACXeIrQyprvXt9mO3yc3jdLBkbn2d4J5uMF1zi2XPM1DpA7/byXJq5eLAcwiCmt/
 2jOBes6F38JDhaA+nf1+B88nXXLEeLvKKr2JWKL/rBHzlxhNuf32Q52FriBXNS6zq6VR
 dtwA==
X-Gm-Message-State: APjAAAVa5b0qWHKh0PiPm6rGDuCcrfS/KrX70TNbJ6JYJ9eXY1TFK0xd
 uTpJZXshfGb1cnU95Fyf46EHcQ==
X-Google-Smtp-Source: APXvYqzZQJ43+eWSvu/2dajUVT1rywM7T1++XS0NMq6+urFdaI5On6DeqpolyDyeBr3m/KhV5lgmNQ==
X-Received: by 2002:aa7:838f:: with SMTP id u15mr23260134pfm.13.1571677400333; 
 Mon, 21 Oct 2019 10:03:20 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g9sm14362541pjl.20.2019.10.21.10.03.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Oct 2019 10:03:18 -0700 (PDT)
Subject: Re: [PATCH 05/21] hw/arm/omap1: Create the RAM in the board
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-6-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <47214ca3-0fb1-f181-a32e-12eebeb49a29@linaro.org>
Date: Mon, 21 Oct 2019 10:03:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191020225650.3671-6-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: Paul Burton <pburton@wavecomp.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Leif Lindholm <leif.lindholm@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jan Kiszka <jan.kiszka@web.de>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/19 3:56 PM, Philippe Mathieu-Daudé wrote:
> The SDRAM is incorrectly created in the OMAP310 SoC.
> Move its creation in the board code, this will later allow the
> board to have the QOM ownership of the RAM.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/arm/omap1.c        | 12 +++++-------
>  hw/arm/omap_sx1.c     |  8 ++++++--
>  hw/arm/palm.c         |  8 ++++++--
>  include/hw/arm/omap.h |  6 ++----
>  4 files changed, 19 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



