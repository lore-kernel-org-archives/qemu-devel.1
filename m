Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C77C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 21:15:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCBC4214AF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 21:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvN3WEPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCBC4214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izS1F-0004nc-RR
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 16:15:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1izS0Y-0004Gq-1d
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:14:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1izS0X-0002BN-2E
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:14:49 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:35430)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1izS0W-000259-OF
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:14:49 -0500
Received: by mail-pj1-x1041.google.com with SMTP id q39so1541694pjc.0
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 13:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zMO2Ymewgn99WOcWlRkgeJ3cmfMyMqmGC1SZtv6wxtA=;
 b=lvN3WEPJg9ESEyUbDMMjEJsTRzpCYclHnVSHHkDrJMX3vkCRQGAmmPLB+iuejNTZ5h
 HZumeVZdvcPsE5u7v1O3Xy+35o4UBkl2XKNxUaJDiTRPoU+upByu1IcMR/wsKTpvFrk4
 r1ir6rLdxN6QApnrAkqLOcR4q1jGdQv9e4nUHErS7dGRfo9Lz3c2BhiBNj4tNNopGg4j
 SySVgNyroTRa7qgmHZzICGZLWu6TgPldbg1Fa0UiGh7SxzFaHoxkZ20tv4Arr4Thr91W
 zq4UT98EeyFXVjsqgjk79KJG3nhn4SUafGDyWS2Zf6mU+KHtdIZb/8wrpRYsSKoP5sqf
 YknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zMO2Ymewgn99WOcWlRkgeJ3cmfMyMqmGC1SZtv6wxtA=;
 b=LhkPLiZqJ2qRSKLyNwokz7FYTIlP+Y6KE4z8fpB5o9ufNDI6oKBnvfcTJ58/AYHlpm
 YCl72igqjiXg1U3yl6gMA9ZTsLSlsZELOWR2ScBmmXUp+6KSVwfyF+YkBtXdDJgFGIAl
 Yf0LbD5GtYQJ6aoBaMcGmhk1jhRxVrudR3mivla1E6IDr+YTEV3gMNy7lOsWjrDYdQ66
 TatMH4Wri+wRN22ul1h7R4IMcGmmFVUOVY1Yx+yLYAg6lerpYnQPeItP1V/YDydSEgZk
 6vp77xSlOSMU2c5Y2A90SHfCBf1IZqkl8aejmeDTf9Wrb220eWoCeI5/iqqi1BjqRVHa
 Wfuw==
X-Gm-Message-State: APjAAAUVU+rzysKMo6NgI2pF9YExAHpcCt2qvGw3X6tBRE2KKaYC8JIC
 720Dhi3LRQ2JBOnaV9XtfTgF7oAO2Gzai/GpTZo=
X-Google-Smtp-Source: APXvYqwOZTUGdRABdM10iVBqGGBgiey9AUCAnjzmwYTZrLYoCtdUhmpze8XG1yUhWXj/fMSoWJUuoVwj7XldovQt2YU=
X-Received: by 2002:a17:90a:db0f:: with SMTP id
 g15mr145492pjv.40.1580937287269; 
 Wed, 05 Feb 2020 13:14:47 -0800 (PST)
MIME-Version: 1.0
References: <20191127220602.10827-1-jcmvbkbc@gmail.com>
 <20191127220602.10827-2-jcmvbkbc@gmail.com>
 <bddff04f-3d48-a4d4-85ac-ca19ca7be90c@linaro.org>
In-Reply-To: <bddff04f-3d48-a4d4-85ac-ca19ca7be90c@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 5 Feb 2020 13:14:36 -0800
Message-ID: <CAMo8BfKd-Tw7A-kszK7O56D9mdyhf_R+0bfXSoj6t9hGbfW2zQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] exec: flush CPU TB cache in breakpoint_invalidate
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, changbin.du@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 5, 2020 at 3:00 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/27/19 10:06 PM, Max Filippov wrote:
> > When a breakpoint is inserted at location for which there's currently no
> > virtual to physical translation no action is taken on CPU TB cache. If a
> > TB for that virtual address already exists but is not visible ATM the
> > breakpoint won't be hit next time an instruction at that address will be
> > executed.
> >
> > Flush entire CPU TB cache in breakpoint_invalidate to force
> > re-translation of all TBs for the breakpoint address.
> >
> > This change fixes the following scenario:
> > - linux user application is running
> > - a breakpoint is inserted from QEMU gdbstub for a user address that is
> >   not currently present in the target CPU TLB
> > - an instruction at that address is executed, but the external debugger
> >   doesn't get control.
> >
> > Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> > ---
> > Changes RFC->v1:
> > - do tb_flush in breakpoint_invalidate unconditionally
>
> I know I had reservations about this, but we now have two patches on list that
> fix the problem in this way.
>
> What I would *like* is for each CPUBreakpoint to maintain a list of the TBs to
> which it has been applied, so that each can be invalidated.

I don't see how this can fix this issue: it's not the list of TBs that
we want to
invalidate, it's the TBs that get associated with new virtual addresses that
are currently causing the issue, right?

>  Our current
> management of breakpoints are IMO sloppy.
>
> That said, I don't really have time to work on cleaning this up myself in the
> short term, and this is fixing a real bug.  Therefore, I am going to queue this
> to tcg-next.
>
> I would still like patch 2/2 to be split, and that can probably go through an
> xtensa branch.

Will do.

-- 
Thanks.
-- Max

