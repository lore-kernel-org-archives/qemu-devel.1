Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67446C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 12:28:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36278208FE
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 12:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vcMdoytf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36278208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOh9Q-0001PN-CR
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 08:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jOh8g-0000yi-3J
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:27:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jOh8d-00051K-SJ
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:27:33 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36436)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jOh8c-00050k-UQ
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:27:31 -0400
Received: by mail-ot1-x343.google.com with SMTP id b13so3185723oti.3
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 05:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nJ25sZNpT34DazEuKgm82OL6F4vRdvg/0TJ9lqzvG8s=;
 b=vcMdoytfweg/7jWQF3vi0CMFmjxw7OJcK96tfwQaH3GxCk+0HsURVQCdzeLK9xITR3
 4PXGZH+XaHzxWmG+v/MH7D91erQtm+Hr+r6kQNVwCCT6WPG7WFSAo5fTyPfQgUtsq6Rz
 85j6OUG8iz9SAbvz9djPI/11SGq7p92JkuA1jaeq4c290dhaLtCBKG79OQtLIl/fw/DH
 jVVSDNHlkb01LiWwjoyrm4d/fREReng0aQZA6Ls7gSCsKRRl7XAO1w1w+6z/dFWqvkyW
 O6qD46C6s80yP1vQPmOYcxCNvJeGGV4EAB6HbLP0Hbovg7zUj/g1Kat42/R+SVDaj9KO
 7GXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nJ25sZNpT34DazEuKgm82OL6F4vRdvg/0TJ9lqzvG8s=;
 b=rV2wqecPIwbuWl8Tgnon+wXLTbSxqqTndPsfxlCr+4UlNA5wjH8hD1BgUaNrTv3ciA
 tfMH6UEjlC6vWEKUZD+BP+5F9OM08Wchjw/gUxEuhpk8+pVehqHe4yZcWny67nww/NF0
 6s9nB5Jj8pUa93/9owJAsViXVnzX/moJf9QQcdj0PmIjCR+d2SFOudWODhmSxFAuC790
 1eQ/uigvEkzK62KC7FZAjQD+Br5cYBpOk6/7B4Twn5rHlIEXpWibZTymeWGzR2IwmUo0
 w7zlJBYJveUT3hIyLTMydDdfq+y2tTPTLRrp7RmjPIf+R/LfuMbTSmxjwgSzLY3wnoqw
 VmuQ==
X-Gm-Message-State: AGi0PuYDTMDQO6hc5cuwqxbKoUqwWJxK/nwfqHi1ZNdYfoMMF2dL0tJx
 Hdo0nNyNQaKBuJ7oPCzB6kKc17f+fd7uZwOeHTPSIQ==
X-Google-Smtp-Source: APiQypK2BAyRjO7c+3ABrVbJxhRwP9Pp9Re3l1tdZKbm8suEdPC1AG3eN6itZlGp/z27szWFTQmPkRsf8l6+O9ObQPw=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr4013094otj.91.1586953647679; 
 Wed, 15 Apr 2020 05:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200319193323.2038-1-peter.maydell@linaro.org>
 <20200319193323.2038-7-peter.maydell@linaro.org>
 <5012c7e4-c1ec-79e7-ac0a-f15e2eb1fd6e@redhat.com>
In-Reply-To: <5012c7e4-c1ec-79e7-ac0a-f15e2eb1fd6e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Apr 2020 13:27:16 +0100
Message-ID: <CAFEAcA-5NJQu3S56rrw88_P0R2m5tg=gQD6MVMn2VN_LteaGbg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] scripts/coverity-scan: Add Docker support
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Apr 2020 at 12:58, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> On 3/19/20 8:33 PM, Peter Maydell wrote:
> > +    # TODO: This re-downloads the tools every time, rather than
> > +    # caching and reusing the image produced with the downloaded tools=
.
> > +    # Not sure why.
>
> I remember something similar when using -f and COPY.
>
> My guess is using -f somefile instead of a directory, then COPY from
> outside of the directory, the cache is invalidated (or not used). If the
> file copied and the Dockerfile are in the same directory, it works (for m=
e).

The comment turns out to be not entirely accurate -- at least some
of the time it successfully skips re-doing the tools download;
but sometimes it doesn't and I'm not sure what triggers that.



> > +    # TODO: how do you get 'docker build' to print the output of the
> > +    # commands it is running to its stdout? This would be useful for d=
ebug.
>
> Maybe '--progress plain'?

Good find, I'll have to try that.

thanks
-- PMM

