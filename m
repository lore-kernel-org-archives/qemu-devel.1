Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E65C46466
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4433E2068D
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="N2WXytjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4433E2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP8tj-0001V3-95
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 14:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kP8rz-0000UI-2b; Sun, 04 Oct 2020 14:36:28 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:43512)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kP8rw-0003Nz-O9; Sun, 04 Oct 2020 14:36:26 -0400
Received: from localhost (sekoia-pc.home.lmichel.fr [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPSA id 863E8C60F16;
 Sun,  4 Oct 2020 18:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1601836579;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oYrPmGapUrL8sbllpEjU/XZ4BAVyq3utolvb2tZ2CQU=;
 b=N2WXytjPhf9ZiqjlGepmRjdDkLbJMKmCBcAHzbS8qfZcENekLuY8I+MkUBFxPORetBLMVy
 FRPmN63Z/s2cmtQGK8f9IwUchTnvo9Mb1YL1y/G99j5Nh6Q+PQCqGBOPoWBzxXMSzC3GVx
 npxILmZd6G1BX6U3/OFcFWASG1PvneMQp1varXqnNDG0IliHOyfxVlp1coNjc2OZONQa5n
 cDplVEjDAyso4Ho1NWN+VlqJHb8L+95QJud2pCFW+SXJSFC2nSfiWYceRoI0g2rYiramA2
 ep9Mn1YO9LBY/NyKdkTHMIR7K0+rBsQ4lV/o6KgqJeoBhCsExv6CL/8HTXSUEA==
Date: Sun, 4 Oct 2020 20:37:19 +0200
From: Luc Michel <luc@lmichel.fr>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 10/14] hw/misc/bcm2835_cprman: implement clock mux
 behaviour
Message-ID: <20201004183719.m3tsetxcgvc5ea2m@sekoia-pc.home.lmichel.fr>
References: <20200925101731.2159827-1-luc@lmichel.fr>
 <20200925101731.2159827-11-luc@lmichel.fr>
 <76aae8af-dff0-b76f-cf04-0e3231eaf2bb@amsat.org>
 <2ca8802e-3295-bd22-e705-931ae8dbbd1d@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ca8802e-3295-bd22-e705-931ae8dbbd1d@amsat.org>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1601836579;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oYrPmGapUrL8sbllpEjU/XZ4BAVyq3utolvb2tZ2CQU=;
 b=SXe2tJozztdlXfHaThnIncvtgJTXXjP2Djg3jMntdui+7wMRfsv/QIOV3Eqzcn5Rqks/wu
 WjjX6xo0j1vHQAgXO9fGYxl+fa71icmlwvINGh5hJ11wrU8CZgV5Fyplj//RWz9EmcIGlS
 DmbrdJ1PM312yl67nbd0sgprXSYW4J1ebVGyg2aSErGr0z7bs4aeVOUI69PX1JgI8G5dBw
 Q+p9j88tuHkjKjHEeY6FPgZGq5eWMmpQqvH8WsmXs0bOa2TaDKJNm/ecu5I0L/dd4dCXXq
 dKDuxoYzZBybdJIqzMOFSbP5QbrbJaJNj2KZomIJJdgDlDcm39bd9M3Tr0yz0w==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1601836579; a=rsa-sha256; cv=none;
 b=caikVKz2or3ZkhbvaBRVRYr9A9BZj9e/sQbDkie+2Y5IKtfLFnESivxZsqU/nP47golzn7Y/OYWpBw6kJuBtzAyIRO4J3wMYBoJaUnKbJ+6sSvDRplkfV+6gOlVLz9ORWxep1UXQjN6FDeVrxGpTVx6bPdzbLQVhsDkIhbfY91tBAf9zgV1Mmxn2p1q0FRj5Kl/blJcAVoMDxARIBbIDOeiOAeYpNawJUaU8Tj3gl/AV3+vHlHaGUNg16d/d+HPhyeB16Qsxg4IBmqxgNmwNVFGkK2RpY2vQxYiFcDl0GlNLQ0bk0QzUvqxIpIrCFvdxj/GW7E85EW7Wo892X+ZQbg==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=sekoia smtp.mailfrom=luc@lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/04 14:36:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16:51 Fri 02 Oct     , Philippe Mathieu-Daudé wrote:
> On 9/26/20 11:40 PM, Philippe Mathieu-Daudé wrote:
> > On 9/25/20 12:17 PM, Luc Michel wrote:
> >> A clock mux can be configured to select one of its 10 sources through
> >> the cm_ctl register. It also embeds yet another clock divider, composed
> >> of an integer part and a fractionnal part. The number of bits of each
> > 
> > Typo "fractional".
> > 
> >> part is mux dependant.
> > 
> > Typo "dependent"?
> > 
> >>
> >> Signed-off-by: Luc Michel <luc@lmichel.fr>
> >> ---
> >>  hw/misc/bcm2835_cprman.c | 43 +++++++++++++++++++++++++++++++++++++++-
> >>  1 file changed, 42 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
> >> index 8df2db0fd9..75bc11939b 100644
> >> --- a/hw/misc/bcm2835_cprman.c
> >> +++ b/hw/misc/bcm2835_cprman.c
> >> @@ -229,19 +229,60 @@ static const TypeInfo cprman_pll_channel_info = {
> >>  };
> >>  
> >>  
> >>  /* clock mux */
> >>  
> >> +static bool clock_mux_is_enabled(CprmanClockMuxState *mux)
> >> +{
> >> +    return FIELD_EX32(*mux->reg_cm, CM_CLOCKx_CTL, ENABLE);
> >> +}
> >> +
> >>  static void clock_mux_update(CprmanClockMuxState *mux)
> >>  {
> >> -    clock_update(mux->out, 0);
> >> +    uint64_t freq, div;
> >> +    uint32_t src = FIELD_EX32(*mux->reg_cm, CM_CLOCKx_CTL, SRC);
> >> +    bool enabled = clock_mux_is_enabled(mux);
> >> +
> >> +    *mux->reg_cm = FIELD_DP32(*mux->reg_cm, CM_CLOCKx_CTL, BUSY, enabled);
> >> +
> >> +    if (!enabled) {
> >> +        clock_update(mux->out, 0);
> >> +        return;
> >> +    }
> >> +
> >> +    freq = clock_get_hz(mux->srcs[src]);
> >> +
> >> +    if (mux->int_bits == 0 && mux->frac_bits == 0) {
> >> +        clock_update_hz(mux->out, freq);
> >> +        return;
> >> +    }
> >> +
> >> +    /*
> >> +     * The divider has an integer and a fractional part. The size of each part
> >> +     * varies with the muxes (int_bits and frac_bits). Both parts are
> >> +     * concatenated, with the integer part always starting at bit 12.
> >> +     */
> >> +    div = mux->reg_cm[1] >> (R_CM_CLOCKx_DIV_FRAC_LENGTH - mux->frac_bits);
> >> +    div &= (1 << (mux->int_bits + mux->frac_bits)) - 1;
> 
> Eventually:
> 
>     div &= MAKE_64BIT_MASK(mux->int_bits + mux->frac_bits, 64);
I think this is MAKE_64BIT_MASK(0, mux->int_bits + mux->frac_bits)
(The shift macro parameter is 0 to have the ones positioned at the
mask's LSBs.
I'll use this macro in my next re-roll.

> 
> >> +
> >> +    freq = (freq << mux->frac_bits) / div;
> 
> Maybe:
> 
>     freq = muldiv64(freq, 1 << mux->frac_bits, div);
OK

> 
> >> +
> >> +    clock_update_hz(mux->out, freq);
> >>  }
> >>  
> >>  static void clock_mux_src_update(void *opaque)
> >>  {
> >>      CprmanClockMuxState **backref = opaque;
> >>      CprmanClockMuxState *s = *backref;
> >> +    CprmanClockMuxSource src = backref - s->backref;
> >> +    uint32_t current_src;
> 
> Maybe avoid current_src and use in place.
OK

> 
> Otherwise:
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Thanks !

-- 
Luc

> 
> >> +
> >> +    current_src = FIELD_EX32(*s->reg_cm, CM_CLOCKx_CTL, SRC);
> >> +
> >> +    if (current_src != src) {
> >> +        return;
> >> +    }
> >>  
> >>      clock_mux_update(s);
> >>  }
> >>  
> >>  static void clock_mux_init(Object *obj)
> >>
> > 

-- 

