Return-Path: <SRS0=1g4J=U5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8381C5B57E
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 11:36:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86B9F20665
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 11:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2SIVPPg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B9F20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhY8Y-0003U8-3G
	for qemu-devel@archiver.kernel.org; Sun, 30 Jun 2019 07:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57752)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hhY7Y-00032s-Bi
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 07:35:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hhY7X-0006MK-D2
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 07:35:48 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:36633)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hhY7X-0006Lk-7p
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 07:35:47 -0400
Received: by mail-ot1-x329.google.com with SMTP id r6so10601671oti.3
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 04:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=Ns+10xnH0tQMuKskb1lL6JXrSaWsP0++qCF9d71vJ7M=;
 b=Y2SIVPPgADiP/lJ8AOs16IpBEp6XQgBjK8m87bLzx+uGyQZrXSQ9gAs1Xd6e/ylvVV
 OQ88u5b23jD6ePHj2MjtnNMoNs08ev1RSlEtmAXrMOxnqdmRsDvSBsDDXmkl4cBgY6tS
 U+WckKHmlhq1+EQm1iECRt7hrWPS0W6is9U2SMcUIVVsqfaNVlGBeflQbBDtI7ByQ4Nm
 iuoMfi/obCMSoRGZhT65Lc2w5lpRBMQxjF1qeKfomyyB6sIWcByCPB/rkzOHJamxgG//
 GqSSCnPRkuajtKZCgbaR3CeyUxygVpbUU8cT3Xg+7YNSVzjN0Mbu5I/L+PaII+OiBbXc
 +6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=Ns+10xnH0tQMuKskb1lL6JXrSaWsP0++qCF9d71vJ7M=;
 b=So/uAX0FuwuJigZh2I6Yvy2ljpNz1J4PPiCOJQbqPcxKf0X1Ak740ea7g++h1PJjdQ
 +052Qm2rRtz7xXYauhSZBnlG+u2NLk2OMrX09S70j1cujh4pP5nbQi8sPSa9yn+h64za
 PKbe3zYjK7NkBBxveTwF2u8lSiFx9VD0y5aSoYtxr8Yb5K2RoiPhTXchF1y5sorMK660
 kxpcZVoT7cWXVS7aN4MghiDNToa7pvtlzsYwjbkhchqcGyGnJ2uR66fdgPYtGvE5piHB
 TaX4SBr3MaIYSW0pkmKHVG56ArixDG00d32UGQkhifPFYw27+8nlzg1fOfdMltyyG83e
 CYgA==
X-Gm-Message-State: APjAAAWgTau9DwxEQiiJ7VP14eb/gYX0nBk0N0a5ws5pmC0R0kZVzn3w
 HsfFaZ0nJ+oknLm9KKDCCJG81v69/aaykzSuThk=
X-Google-Smtp-Source: APXvYqzmh1zTU0VWyJHnfY49COeyeaH/v9+GSyCdPjQnHgfx6ulfx7MneFG0CEQlHvlzCJH3HxjeP82kSkyOo2URZs4=
X-Received: by 2002:a9d:5cc1:: with SMTP id r1mr12133228oti.341.1561894546001; 
 Sun, 30 Jun 2019 04:35:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP; Sun, 30 Jun 2019 04:35:45
 -0700 (PDT)
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP; Sun, 30 Jun 2019 04:35:45
 -0700 (PDT)
In-Reply-To: <f29f6f66-8b68-94b2-adaf-1d8dfbb54e89@linaro.org>
References: <20190629130017.2973-1-richard.henderson@linaro.org>
 <20190629130017.2973-10-richard.henderson@linaro.org>
 <CAL1e-=hwJmYvYbbdWoQjEcFqNginiTY8xDsgDwDY5t8GF6qBWg@mail.gmail.com>
 <f29f6f66-8b68-94b2-adaf-1d8dfbb54e89@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 30 Jun 2019 13:35:45 +0200
Message-ID: <CAL1e-=ixy=Yk_FTG6dEG4-SSWK5rYbEtat-MsqxOAqphjdY9Bw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v6 09/16] tcg/ppc: Prepare case for vector
 multiply
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
Cc: mark.cave-ayland@ilande.co.uk,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 30, 2019 12:49 PM, "Richard Henderson" <richard.henderson@linaro.org=
>
wrote:
>
> On 6/30/19 11:52 AM, Aleksandar Markovic wrote:
> >
> >
> > On Saturday, June 29, 2019, Richard Henderson <
richard.henderson@linaro.org
> > <mailto:richard.henderson@linaro.org>> wrote:
> >
> >     This line is just preparation for full vector multiply support
> >     in some of subsequent patches.
> >
> >
> > This patch should be aquashed into the patch on implementing multiply.
>
> Yes it should.
>
> Incidentally, why did you split it out in the first place?
>

I wanted to split the patch 1 from v4 into smaller patches, and use
remaining v4 patches as-is, so I did not want to meld this segment (from
patch 1) and one of remaining patches (mul), otherwise remaining patches
wouldn't be as-is.

But v5 was done mainly for debugging purposes. Normally, two mentioned
partches on =E2=80=9Cmultiply=E2=80=9D should obviously be melded.

>
> r~
