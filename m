Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CABBC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:42:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 573E72089C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="udBMBXSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573E72089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhuhr-00026H-5F
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 07:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48339)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hhugg-0001Rt-GJ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hhuge-0001QJ-Nh
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:41:34 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38689)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hhuge-0001PY-Ik
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:41:32 -0400
Received: by mail-oi1-x241.google.com with SMTP id v186so9680759oie.5
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 04:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kW1B7Lmz5RxF1lCoBPinTk9h2AVo14zSE6ptZ0lxOZg=;
 b=udBMBXScKI6WS2TDX85Nohec7/YzTLzTKQlKlyM5iLzqeJhpKl4s0RvmF55M9bIeEt
 OjfRUDCnHFRajtypk8LbGA0+5HphMQ6mLPyKBYUz6+EC0JhAMmMQ8WdcPNRfKiSb9LzB
 /JA5/QeSX34XbygBVILA+8/Iut+zdy3teVZA8D6dcbOfxjLHcnafYdmLfSUCR39+/3q1
 tZNpvYkNQRNUDhTMTJpiEUqrkZWGBkJ4Do9YpFnF9VJe7dhpqskN1CF/W6tlZeFvj3Av
 uerC5re8XnTDkymxtjR4+TiZT2Ywibbsd/0WZlbCHb9hd6BYxLdtFkj8L/IbRMA6A0Ql
 Ix4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kW1B7Lmz5RxF1lCoBPinTk9h2AVo14zSE6ptZ0lxOZg=;
 b=e+otRNAKkdKfMpHdfobORLSS6GGRStOleuiZ+HQox11rPPmeBL1Dq5WXxr47q3229z
 4WQmf+o46rzVxI4f55Ma30P+UWEByGMQTeddo0iNo2HPIoygB3E29ETm5K4ufzbJM5CA
 DThIafQX4MAB2KJXoW41PH+5C6RRV9Km8Ayup8eMRpwP+HoaL2kECjKqNoPjbtxrICmn
 UFRvEIaViLuLQkWsoodb4YMtseL6sQ+WsA05rEasi1BL247TBuIJxd3oiwBBiBs0we51
 uKr4oHdwLYyoortX7c6t9YZsjLF0Fc28jdWFwgiBD+LKE6lovX/A0Nv9RNQhc3TKhbhi
 qA3w==
X-Gm-Message-State: APjAAAXe1z9GnWHAsJZpTKcDlk3FtIEt+B+xGQn188AC59ACqF+7N5qo
 Y0+KbAhNskAIkKEiMccE3jNfKR7sOYAT4JMgtBw=
X-Google-Smtp-Source: APXvYqzMIpNbv4zxxxt+tS0f/TvTHFnEEHXZwAQbFZWtgKTQjdeJbd/kDYEmYprkpDbNPStBsnMKS2264r5xgKU9Uw0=
X-Received: by 2002:aca:4588:: with SMTP id s130mr6155144oia.79.1561981290826; 
 Mon, 01 Jul 2019 04:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190629130017.2973-1-richard.henderson@linaro.org>
 <20190629130017.2973-16-richard.henderson@linaro.org>
 <CAL1e-=ghMjUtEyqKX+s15RcyQp6uQO_hJ_u4RTSJ5ZyPvFnymw@mail.gmail.com>
 <b376dc86-6879-2a72-3261-7fdf06172456@linaro.org>
 <CAL1e-=hS_nQQYY39j-mx1QBFw+Xe3V5NgFW7ifrkMZRxFbB=OA@mail.gmail.com>
 <38326483-d804-02c6-42bc-9633fc4d5028@linaro.org>
In-Reply-To: <38326483-d804-02c6-42bc-9633fc4d5028@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 1 Jul 2019 13:41:16 +0200
Message-ID: <CAL1e-=gWBkA+tWZJ9E7JNk1X_gwnhKbRfT_CtNr+o5uy+e-oDw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v6 15/16] tcg/ppc: Update vector support to
 v2.07
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 1, 2019 at 12:29 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/1/19 5:57 AM, Aleksandar Markovic wrote:
> >
> > On Jun 30, 2019 5:12 PM, "Richard Henderson" <richard.henderson@linaro.org
> > <mailto:richard.henderson@linaro.org>> wrote:
> >>
> >> On 6/30/19 3:37 PM, Aleksandar Markovic wrote:
> >> >>  bool have_isa_2_06;
> >> >>  bool have_isa_2_06_vsx;
> >> >> +bool have_isa_2_07_vsx;
> >> >
> >> > Does this flag indicate support for PowerISA 2.07 or VSX?
> >>
> >> VSX & 2.07,
> >>
> >> >> +    if (hwcap2 & PPC_FEATURE2_ARCH_2_07) {
> >> >> +        if (hwcap & PPC_FEATURE_HAS_VSX) {
> >> >> +            have_isa_2_07_vsx = true;
> >> >> +        }
> >> >> +    }
> >>
> >> Like so.
> >>
> >> While it would have been possible to have one single have_isa_vsx, we would
> >> then also have to check a second flag to see which revision.  Therefore I
> >> created these composite flags so that we only have to check one.
> >>
> >
> > Yes, but, in this patch, for example, among other things, the support for
> > doubleword integer max/min vector operation is implemented. Why is the
> > existence of that support dependant on VSX (PPC_FEATURE_HAS_VSX)?
>
> Because otherwise the instruction doesn't exist?
>

If we go back to my example, it appears to me that doubleword
integer max/min Altivec instruction do not depend on VSX in any
way, or, at least, I did not find anything in Altivec docs that
mentions it (I could be wrong). The same concern for majority
of Altivec instructions used in this patch. What is your reason
for considering all of them needing VSX?

Regards,
Aleksandar

>
> r~

