Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E155BC31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 13:04:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7AE920B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 13:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OGK0+T0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7AE920B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw4ZD-0006ir-13
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 09:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53217)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hw4L6-0004RF-5c
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 08:49:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hw4L5-0001kh-7m
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 08:49:48 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40675)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hw4L5-0001kB-3R
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 08:49:47 -0400
Received: by mail-ot1-x341.google.com with SMTP id l15so74851267oth.7
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 05:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1TkpFAAkLJFYRyuEA0QMP0M0MxKFGiouku9c5yV1n1o=;
 b=OGK0+T0ecBBk4h7jbK798nNO4sdImYBefWm3F30WVI4WoJtIdtfn2AJHML4ToVUPww
 RZlfqAAYwBF4uNOzSGAJa8OAkU/9OLwH11gfTCjIgGaFJnfs7qRapqkA516GoYAvPJS4
 9YpE+PszfC16Zc6tNTUYd1QCDqTjjefYbpaj0oWUcrLs0bMVvM1HrqXZ8YfC6PHBevkO
 5Pqs78bzOXgMvzarhZBzDibthlzlDbsBzSTh0XXXTPMuoKQekEle9eMrkJT8+klIdCBK
 cX52sR+OAmGbM4CMq8Ld5RCmEavpuCxpxQMbDM+DyidFTj2S2Hxh70IWDoJiuIO0d+5N
 pYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1TkpFAAkLJFYRyuEA0QMP0M0MxKFGiouku9c5yV1n1o=;
 b=sv326b9IcpyNcwQE7KNhJiM+YXuyBvZzkVXO90Jgj6b4dI1pdnm/seERycnEN6G7xJ
 knIKO6BSHuuHVyiaD82E/oAIN1YUsTPL04c2u5aNZSsjZj32VoPPKI6GxWxOZ48zyhN8
 unsZRPEmJgVHMEYmzj3jscvjMEtYL6GCV7YkMFR7upxUVjxzFDiDCpkaaazh8Lke1TJJ
 y3VJoHrrhcSCzBd4bIfssotXfOCH8rhBwzgL8pDEDpJtAyL1eT5812q8nrkdyuwCzBVb
 CIblnNjwUoFaanVifmtbZWSbV2UUFBlkBDL9BDPefckQnHLhbqTnQgOd1TL0YY55jiVD
 YepQ==
X-Gm-Message-State: APjAAAUjgC+80wyAPYRr9PX24DZlVG/Yoxp1le+2aCXxWNXz5wmx7AzN
 o4dip/DGQDLeQHUrlVNBbEz5CZ77dIpyhXOMjxJlyg==
X-Google-Smtp-Source: APXvYqwdnsjns9g7pXZkEbc0T7t2vq0HDN5J6Z1t88fSxMCTz+BRrzD32xf1yFeR6g7Vag1AG87lNzxlDGywOQq0oIE=
X-Received: by 2002:aca:4bcc:: with SMTP id y195mr5598196oia.146.1565354986178; 
 Fri, 09 Aug 2019 05:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190807045335.1361-1-richard.henderson@linaro.org>
 <CAFEAcA-s3DZcW=L0X=Snxj7PwyLQerhQwrYiKj=icJwkHp6pqw@mail.gmail.com>
In-Reply-To: <CAFEAcA-s3DZcW=L0X=Snxj7PwyLQerhQwrYiKj=icJwkHp6pqw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Aug 2019 13:49:35 +0100
Message-ID: <CAFEAcA9Rp_S-dVzo6_ysAJmJR_bkhxiBLtzJxacYAmPGvonZXg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH 00/11] target/arm: decodetree prep patches
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 7 Aug 2019 at 18:52, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 7 Aug 2019 at 05:53, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > These are split out of my decodetree conversion of the
> > aarch32 general instructions.  With one exception, these
> > are all related to cleaning up how we refer to "PC".
> >
> >
> > r~
> >
> >
> > Richard Henderson (11):
> >   target/arm: Pass in pc to thumb_insn_is_16bit
> >   target/arm: Introduce pc_curr
> >   target/arm: Introduce read_pc
> >   target/arm: Introduce add_reg_for_lit
> >   target/arm: Remove redundant s->pc & ~1
> >   target/arm: Replace s->pc with s->base.pc_next
> >   target/arm: Replace offset with pc in gen_exception_insn
> >   target/arm: Replace offset with pc in gen_exception_internal_insn
> >   target/arm: Remove offset argument to gen_exception_bkpt_insn
> >   target/arm: Use unallocated_encoding for aarch32
> >   target/arm: Remove helper_double_saturate
>
> Whole series
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> I have one query on 3/11 but the change itself is clearly
> correct so it's just a question of if we need to tweak the
> commit message. Once we've figured that out I'll apply the
> series to target-arm.next.

Now applied to target-arm.next with the agreed commit tweak.

thanks
-- PMM

