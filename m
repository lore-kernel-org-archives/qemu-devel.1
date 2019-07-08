Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D228C606BD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 16:08:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BB9A20693
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 16:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6oz8I6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BB9A20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkWC5-00006l-8z
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 12:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42410)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <frasse.iglesias@gmail.com>) id 1hkW7D-0004oH-Lc
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 12:03:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frasse.iglesias@gmail.com>) id 1hkW7C-0004po-A3
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 12:03:43 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:44919)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
 id 1hkW7C-0004mD-0x; Mon, 08 Jul 2019 12:03:42 -0400
Received: by mail-lj1-x241.google.com with SMTP id k18so16468282ljc.11;
 Mon, 08 Jul 2019 09:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=KBRi8cQQBvYj9KgVf2TGXS8dksaF/hFUiXEmkZ/cCDY=;
 b=a6oz8I6g+LvCFA04palZPcwOX+tiqF8U9i9sx8lVPAbi41jksm29RNZYh87lVcIT9f
 p4wQ4hwrpYeVK2cQpQRiSDHprReCbZ0CXjh7Oks3nB7tN52XkyBitBPsqgHoUqEolaGd
 5jYzyehU5JNNdT0mjq0z56kQvlQ6Kwl/eGURP0kQmxnGIVj9FDnQWsSThC4Vp745+X95
 1Wt2nWf8rNfLI4fqqC+qxj+v2wcw9795rhS317Ts/YT3XpQ/CNE9XhOyXP8WXwzlMYZc
 qyA13i3M47e1fpSz946Jk2D6gU+RkVNzrT4N20N+MG+mjsnuLXhx9HfGoudnN33z8bII
 7jpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=KBRi8cQQBvYj9KgVf2TGXS8dksaF/hFUiXEmkZ/cCDY=;
 b=TQiNa+AY5HCkWNY24w+JH3zaqSY8uc1HYgJuLjYH68vebdtxhnvltIa3dT2zbdjp10
 UiQ98G124aGKwIvGdTmdXhV0JKayziQEOzBxGntaGaO5VW1C1ULzcUcT3K4aTefZVAzZ
 CK55es5IIRbgtMRix7Q/Of1x82pJtDbeScoBYocTP+OEueRY5TNsHnyQqclhHQTRtN7n
 FkE3w7hYksuymHZuWE6sX40YDQEbQB/GJaB36VNT35uXhmys6UOhge6wN2ZwkcqxuCfA
 3XKR6LC8t1HRQELfU+B8IpxvIAJzVHCVjenfklgkclaLFvXWNMxhNtsUfRCFRMuZCAax
 QBFw==
X-Gm-Message-State: APjAAAValDi6gP3Yg26kYlDyWY2X4jo+5/9MkjA3AoCDkGNWjTeSfKI1
 EDUsyg/p32ijmn2910GHuqo=
X-Google-Smtp-Source: APXvYqzRASdJIgnTV1nPpnut6ER3B32uN3LRuDrVYPM+eTnVXRJQzBvC0Rk1n5gV35/7jHDdMf+AZw==
X-Received: by 2002:a2e:868e:: with SMTP id l14mr10710670lji.16.1562601819690; 
 Mon, 08 Jul 2019 09:03:39 -0700 (PDT)
Received: from fralle-msi (31-208-27-151.cust.bredband2.com. [31.208.27.151])
 by smtp.gmail.com with ESMTPSA id
 z17sm3756526ljc.37.2019.07.08.09.03.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 08 Jul 2019 09:03:39 -0700 (PDT)
Date: Mon, 8 Jul 2019 18:03:37 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190708160335.u3zamevyrbnx6nvb@fralle-msi>
References: <20190708104750.1071-1-philmd@redhat.com>
 <20190708104750.1071-4-philmd@redhat.com>
 <20190708142622.k4s5oknmzzj4brxd@fralle-msi>
 <41f075ef-9b80-cb66-0fb1-d03079cd93a4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41f075ef-9b80-cb66-0fb1-d03079cd93a4@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v5 3/3] hw/ssi/xilinx_spips: Avoid
 out-of-bound access to lqspi_buf[]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Prasad J Pandit <ppandit@redhat.com>, Lei Sun <slei.casper@gmail.com>,
 qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On [2019 Jul 08] Mon 16:58:29, Philippe Mathieu-Daudé wrote:
> Hi Francisco,
> 
> On 7/8/19 4:26 PM, Francisco Iglesias wrote:
> > Hi Philippe,
> > 
> > On [2019 Jul 08] Mon 12:47:50, Philippe Mathieu-Daudé wrote:
> >> Both lqspi_read() and lqspi_load_cache() expect a 32-bit
> >> aligned address.
> >>
> >> From UG1085 datasheet [*] Chapter 22: Quad-SPI Controller:
> > 
> > s/22/24/
> 
> I'm confuse, Chapter 24 is "SD/SDIO Controller", so it seems this Xilinx
> datasheet is not stable to refer to. Maybe I should simply use:
> 
>   From UG1085 datasheet [*] Chapter on 'Quad-SPI Controller':

I just clicked on the link and ended up into this version of the UG1085:

'UG1085 (v1.9) January 17, 2019'

But your right its probably better to refer to a specific version of the
UG1085 instead? Then both should be ok, either to write the way you
suggest above or refer to the chapter number in that UG1085 version (as it
was before).

Best regards,
Francisco

> 
> > 
> > After above change:
> > 
> > Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com> 
> > Tested-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> > 
> > (I tested all three patches so the Tested-by tag can also be appended on the
> > other two)
> 
> Thanks!
> 
> > 
> > Best regards,
> > Francisco Iglesias
> > 
> >>
> >>   Transfer Size Limitations
> >>
> >>     Because of the 32-bit wide TX, RX, and generic FIFO, all
> >>     APB/AXI transfers must be an integer multiple of 4-bytes.
> >>     Shorter transfers are not possible.
> >>
> >> Set MemoryRegionOps.impl values to force 32-bit accesses,
> >> this way we are sure we do not access the lqspi_buf[] array
> >> out of bound.
> >>
> >> [*] https://www.xilinx.com/support/documentation/user_guides/ug1085-zynq-ultrascale-trm.pdf
> >>
> >> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> >> ---
> >> v5: add datasheet reference, drop RFC prefix, fix build (Francisco)
> >> ---
> >>  hw/ssi/xilinx_spips.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> >> index 3c4e8365ee..b29e0a4a89 100644
> >> --- a/hw/ssi/xilinx_spips.c
> >> +++ b/hw/ssi/xilinx_spips.c
> >> @@ -1239,6 +1239,10 @@ static const MemoryRegionOps lqspi_ops = {
> >>      .read_with_attrs = lqspi_read,
> >>      .write_with_attrs = lqspi_write,
> >>      .endianness = DEVICE_NATIVE_ENDIAN,
> >> +    .impl = {
> >> +        .min_access_size = 4,
> >> +        .max_access_size = 4,
> >> +    },
> >>      .valid = {
> >>          .min_access_size = 1,
> >>          .max_access_size = 4
> >> -- 
> >> 2.20.1
> >>

