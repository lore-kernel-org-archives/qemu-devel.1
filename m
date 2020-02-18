Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE58C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 11:39:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0761D207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 11:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1fvSDtD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0761D207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j41E5-0002GD-VI
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 06:39:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60183)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frasse.iglesias@gmail.com>) id 1j41DT-0001e0-I9
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 06:39:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frasse.iglesias@gmail.com>) id 1j41DS-0008EG-K7
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 06:39:03 -0500
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:42447)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
 id 1j41DQ-0008CH-4n; Tue, 18 Feb 2020 06:39:00 -0500
Received: by mail-lf1-x143.google.com with SMTP id y19so14259122lfl.9;
 Tue, 18 Feb 2020 03:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=PDrx0gbrrdaedKVW2szBvbd+d3GsrxxMGWrORoPwLJ4=;
 b=L1fvSDtDylB1Klon8SkIjwo2t0ic8Dig63jin6nQ8GkgER5ez9f4/QoF1nifcaNi+8
 jp2gHSQUwgU7z7Dlu4xDRVOhrICzYqSMY8raKNB2Z8R/ksAEbVIEM4j0yKg0iGkoVbah
 VWHiKX7y3jPvv5DtJEaU7kfRU8CIFg28TsM1XsfIwHuyBwybD6neXzw9kVD0VIU2PB3d
 yLTJn9/HJXWG0WQqx5ZXohXBZX7F81FRx/XFrTN+RfDBxJlPYUOca1X9UtjNuxH0RWKL
 CJtO1t7qjAUfxIUdPomXzcOgsithYkwVysvgIc0kcp2UX0SllsjnPHUcFHeMZXB6OsDN
 UuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=PDrx0gbrrdaedKVW2szBvbd+d3GsrxxMGWrORoPwLJ4=;
 b=Wzbmkk7zrsL4m1TaYQ7OY2FIg/4lorK7WSmCW+HyVaJVnLjW0fVB4vLGgOQjZm69yG
 nZ4XKic1omhkq1YipapUqO97yxg4EoboUy5d4CGdYa2jnO1Tpnr3lv3pHrcp37wVLJNW
 6m8qglYjdwp1N17VfOYAwy508rRdmMkd6IoZeikVWkY7K1JIDdnGhd3+D70aZKIkRnc7
 i0SAA7fDI7RGbVybNa5yCmRnaowqYViLLJ3O+bxEXmL5yAhh1WGtsWqZ6dczKAlTY9z3
 uILvOcSs1SFQl/ieo0O3pEj/xD5eOh3n0DBgYIMzJig4xWKZ9s1AiefLOynujGhC/yUO
 3waQ==
X-Gm-Message-State: APjAAAUJ45sfbKsWyWjvWetMQV9jRf+tfz/Mr3ShmeGx9f1DwkSqMK8m
 Uwh5JJTNqiL30aBmqZvOhrk=
X-Google-Smtp-Source: APXvYqzej9KsmPCjOb9i0QRqM0uW48Heji29j/JQemYQdJlyZE7Rk7xqzR3jG6dPVMZ/tpVbXlThBA==
X-Received: by 2002:a19:4208:: with SMTP id p8mr10428296lfa.160.1582025938580; 
 Tue, 18 Feb 2020 03:38:58 -0800 (PST)
Received: from fralle-msi (31-208-27-151.cust.bredband2.com. [31.208.27.151])
 by smtp.gmail.com with ESMTPSA id
 g15sm2346352ljk.8.2020.02.18.03.38.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 18 Feb 2020 03:38:58 -0800 (PST)
Date: Tue, 18 Feb 2020 12:38:56 +0100
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 3/3] aspeed/smc: Fix number of dummy cycles for
 FAST_READ_4 command
Message-ID: <20200218113855.dedn7xqmt3v3q7uk@fralle-msi>
References: <20200203180904.2727-1-linux@roeck-us.net>
 <20200203180904.2727-3-linux@roeck-us.net>
 <329f6d24-6d47-4e2e-1a66-7683bc0529a9@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <329f6d24-6d47-4e2e-1a66-7683bc0529a9@kaod.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Cédric,

On [2020 Feb 04] Tue 08:45:11, Cédric Le Goater wrote:
> On 2/3/20 7:09 PM, Guenter Roeck wrote:
> > The Linux kernel recently started using FAST_READ_4 commands.
> > This results in flash read failures. At the same time, the m25p80
> > emulation is seen to read 8 more bytes than expected. Adjusting the
> > expected number of dummy cycles to match FAST_READ fixes the problem.
> 
> Which machine are you using for these tests ? the AST2500 evb using
> the w25q256 flash model ? 
> 
> Any how, it looks correct. 
> 
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Fixes: f95c4bffdc4c ("aspeed/smc: snoop SPI transfers to fake dummy cycles")
> 
> I think commit ef06ca3946e2 ("xilinx_spips: Add support for RX discard 
> and RX drain") needs a similar fix. Adding Francisco.

Yes, I agree that a similar fix is needed in the xilinx_spips aswell, I just
provided a patch. Thank you for the notification!

Best regards,
Francisco Iglesias

> 
> Thanks,
> 
> C. 
> 
> 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  hw/ssi/aspeed_smc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> > index f0c7bbbad3..61e8fa57d3 100644
> > --- a/hw/ssi/aspeed_smc.c
> > +++ b/hw/ssi/aspeed_smc.c
> > @@ -762,11 +762,11 @@ static int aspeed_smc_num_dummies(uint8_t command)
> >      case FAST_READ:
> >      case DOR:
> >      case QOR:
> > +    case FAST_READ_4:
> >      case DOR_4:
> >      case QOR_4:
> >          return 1;
> >      case DIOR:
> > -    case FAST_READ_4:
> >      case DIOR_4:
> >          return 2;
> >      case QIOR:
> > 
> 

