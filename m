Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D63C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 13:09:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45B5D221E9
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 13:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="JauB8c5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45B5D221E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kREd0-000448-9y
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 09:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kREcE-00036R-US; Sat, 10 Oct 2020 09:08:50 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:41904)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kREcA-00079i-5n; Sat, 10 Oct 2020 09:08:50 -0400
Received: from localhost (sekoia-pc.home.lmichel.fr [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPSA id D8CC2C6011D;
 Sat, 10 Oct 2020 13:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1602335322;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jazt9/639w3DEeOI8gAmyV0yKv6DDoDESl64N57weGY=;
 b=JauB8c5eTJDOq8YSd7YrWYVpQIKIDGOzqiKjoREQ1s2NReMjfSCU69rmEolYMluJBIRHPN
 NTkCzJKwN29LGyJC/V2OVSnT98zvMswSa1F9ORY4C0K0Ci0BuT0iaKqbTz/zckouPhewsF
 4NHsDzBRE0FmWRb5DxWBdw7LgNoY9AhM31H3/ICoK5iSLkxTuoJGRb2eswjytk2twNDQiJ
 gJ6o18gzBjjdj3h0K0tifIGa10g1DOzat/EF3WOyhOMFu78fhduR5P6gc/IctL1IAPIB9Y
 9gKHQHxCRi7u5OzWgeTpoyh+UpCjL8i5RYL3cACw4W7BfPM7MCf/7T/UHh1P2w==
Date: Sat, 10 Oct 2020 15:09:43 +0200
From: Luc Michel <luc@lmichel.fr>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 11/15] hw/misc/bcm2835_cprman: implement clock mux
 behaviour
Message-ID: <20201010130943.6qkmhkb2gwbr6ajx@sekoia-pc.home.lmichel.fr>
References: <20201005195612.1999165-1-luc@lmichel.fr>
 <20201005195612.1999165-12-luc@lmichel.fr>
 <d304e1f9-a1ea-17a1-e830-8be1f7671a53@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d304e1f9-a1ea-17a1-e830-8be1f7671a53@amsat.org>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1602335323;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jazt9/639w3DEeOI8gAmyV0yKv6DDoDESl64N57weGY=;
 b=ja8RhR5gUyebZ6nn80phQXiO+i8xpUxjyT44k1qcJKYuGQnDY65CjofUuc32ONJW5GJay6
 gGMu2UX0nM0MsscxD4CRPFIsVgNU/NHT0K0zpYmVS+3mM3Vu7h5tCpDak/puXhVjU833sq
 uJ8m+hyAPXCi7uJ4+uuJOcCp0j/8HWW1WtOqPYBB71MRwWsIEKc1OI5phjxZhV7z63thxO
 pJaSTPIb0kvf92i/LsvkjID9lDTE/P+5ZnFglunpcGvH0iG6s9dwyKfrmjNFYJcEkMU9jw
 CME+lOKY1aIM64j9BrNyny7dJtqRa5xDJSw3fnp5AB9KUaD71jnSDc8ZOizcVw==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1602335323; a=rsa-sha256; cv=none;
 b=dFA/zmfwxSgJOtIFNoRHsQ4wOaQBNCPoVozxcWCLcjbj5rlA1keO5Xo1O4zY0vwho0X0101CQh5v9kjcxUtYneuh36irJ8mnHr4dTrlTUTGagjqhwBBHhX1NFVd1vqHGU3irAzPsS6S+IVp5/FPn25hXy//Q9TAQ8f9TkOj5uDR2rNzoVRGjOGifVKwZv9/bjN9AgeJheZrT98YI4OWvAH5TDlorqXc/RQ416Ji8zscnO8rO8sxRWe82t9U+DL7flQLoTEe2IWY4UtAJzCKOp29z+8NXqbhq8EtKOrX66+xNIFwmRlmt+LeKJppUBxBpDKkUMo4Yq+gH8U1jJcQCbg==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=sekoia smtp.mailfrom=luc@lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 07:32:09
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Havard Skinnemoen <hskinnemoen@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11:04 Tue 06 Oct     , Philippe Mathieu-Daudé wrote:
> On 10/5/20 9:56 PM, Luc Michel wrote:
> > A clock mux can be configured to select one of its 10 sources through
> > the CM_CTL register. It also embeds yet another clock divider, composed
> > of an integer part and a fractional part. The number of bits of each
> > part is mux dependent.
> > 
> > Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> > Signed-off-by: Luc Michel <luc@lmichel.fr>
> > ---
> >  hw/misc/bcm2835_cprman.c | 44 +++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 43 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
> > index a470ce2026..7d59423367 100644
> > --- a/hw/misc/bcm2835_cprman.c
> > +++ b/hw/misc/bcm2835_cprman.c
> > @@ -229,19 +229,61 @@ static const TypeInfo cprman_pll_channel_info = {
> >  };
> >  
> >  
> >  /* clock mux */
> >  
> > +static bool clock_mux_is_enabled(CprmanClockMuxState *mux)
> > +{
> > +    return FIELD_EX32(*mux->reg_cm, CM_CLOCKx_CTL, ENABLE);
> > +}
> > +
> >  static void clock_mux_update(CprmanClockMuxState *mux)
> >  {
> > -    clock_update(mux->out, 0);
> > +    uint64_t freq;
> > +    uint32_t div, src = FIELD_EX32(*mux->reg_cm, CM_CLOCKx_CTL, SRC);
> > +    bool enabled = clock_mux_is_enabled(mux);
> > +
> > +    *mux->reg_cm = FIELD_DP32(*mux->reg_cm, CM_CLOCKx_CTL, BUSY, enabled);
> > +
> > +    if (!enabled) {
> > +        clock_update(mux->out, 0);
> > +        return;
> > +    }
> > +
> > +    freq = clock_get_hz(mux->srcs[src]);
> > +
> > +    if (mux->int_bits == 0 && mux->frac_bits == 0) {
> > +        clock_update_hz(mux->out, freq);
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * The divider has an integer and a fractional part. The size of each part
> > +     * varies with the muxes (int_bits and frac_bits). Both parts are
> > +     * concatenated, with the integer part always starting at bit 12.
> > +     */
> > +    div = mux->reg_cm[1] >> (R_CM_CLOCKx_DIV_FRAC_LENGTH - mux->frac_bits);
> > +    div &= (1 << (mux->int_bits + mux->frac_bits)) - 1;
> 
> I understand the description as:
> 
>                    0
>                   [     12-bit    ][     12-bit    ][   reserved...   ]
>  CM_CLOCKx_DIV    [      FRAC     ][      INT      ][                 ]
>                   [         <frac>][<int>          ][                 ]
>                             ^^^^^^^^^^^^^
Yes, this is correct :)

> 
> What about:
> 
>        div = extract32(mux->reg_cm[1],
>                        R_CM_CLOCKx_DIV_FRAC_LENGTH - mux->frac_bits,
>                        mux->frac_bits, mux->int_bits);
Yes good idea, with s/,/+/ here -------^

> 
> Also consider adding the register visual representation if it is
> correct.
Sure, I'll add a visual representation for more clarity.

Thanks!

-- 
Luc

> 
> > +
> > +    if (!div) {
> > +        clock_update(mux->out, 0);
> > +    }
> > +
> > +    freq = muldiv64(freq, 1 << mux->frac_bits, div);
> > +
> > +    clock_update_hz(mux->out, freq);
> >  }
> >  
> >  static void clock_mux_src_update(void *opaque)
> >  {
> >      CprmanClockMuxState **backref = opaque;
> >      CprmanClockMuxState *s = *backref;
> > +    CprmanClockMuxSource src = backref - s->backref;
> > +
> > +    if (FIELD_EX32(*s->reg_cm, CM_CLOCKx_CTL, SRC) != src) {
> > +        return;
> > +    }
> >  
> >      clock_mux_update(s);
> >  }
> >  
> >  static void clock_mux_init(Object *obj)
> > 

-- 

