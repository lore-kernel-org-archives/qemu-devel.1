Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A783C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:49:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08CED2251A
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rmYkLPiN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08CED2251A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpsM8-0005Zn-2u
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 06:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42182)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hpsLv-00056a-0X
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:49:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hpsLt-0001x7-Jx
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:49:02 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41124)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hpsLt-0001ql-1d
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:49:01 -0400
Received: by mail-ot1-x342.google.com with SMTP id o101so43537624ota.8
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 03:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NpCRcb+8mLrZgQ2PoYHtIBJ1d7RcV/5H4CEl+QRBORA=;
 b=rmYkLPiNyX56WNDWszSTXN/nuIlupl3uSXiQ9Lp9nFNJvFhXEiBBYURUFXVHThiRnJ
 Eg0/gU4bMB2/mmhw36v/+y8BtsVTM+bTUomQoocPAiKgCnb3FmEw/q/zmZUna/5CgKmY
 zHDCETFSi3ZvLO69kNd0Q1jewxDjDGSrAQzxigPjg2uZGQU5FNOwuLveyVBqPAMk2DRC
 zcNX+yDZ9cc333fFp7nqC4m2TRUJppOq+/fAqnXXl/aJX8qVWE2zXHVL6KpLQ22OZao9
 8Owts/3Yvh+BbUWerCBnmvN05hROW8dMQz8jCWWePDK3DQeoN1SQ/sywky1CqmhQyTFn
 Ph2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NpCRcb+8mLrZgQ2PoYHtIBJ1d7RcV/5H4CEl+QRBORA=;
 b=M6EVYvjGAO6EPDInZrJefSod1jWpIHhvlpNdTfHtq40plHL82g3K/fz4zH4P30ctkG
 Y/YflwtEVyWtzUwzFy98eYY4SzXKsfsObn8ubmNBFFA0/ggB2clXAYYpWJxlJfAHT0Hu
 gAPT2yq9gqA7jsYIb3+FmGAwHCLV2R2NwI87rjBCsTBJtvSMlQUCJASU4NxLqgaMnsQ0
 7/WLTriy8JIE6wsk1tbnEiZWJRUAZt+oh0jqmSywoXJSj78NDButvwT+PeYS+rJAo761
 sXxhwAr6ysoVGIO5WD+SfuzigrheUhou71ira3S5NqtHV483NMec/xdXYqw7Fuo4vBL/
 w//Q==
X-Gm-Message-State: APjAAAW0wVeDgDKnWDnLIpe3kjBr+W7QwI/ybNvwa9AMH0BX443qerhF
 oNoklxWIFr/z5FCA7FS3JCK4H8EkrO73vU2aMFkwnw==
X-Google-Smtp-Source: APXvYqy68Y918nCwnB1U+hGlVcyWW65mNDrpuk5Mz2YZsGf6ZxD9uLEcL8Sj9Ee67ggmlhfOLXD5k+qXNQYXeAKxxDA=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr52483562otj.97.1563878938725; 
 Tue, 23 Jul 2019 03:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190723093558.13700-1-philmd@redhat.com>
In-Reply-To: <20190723093558.13700-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jul 2019 11:48:47 +0100
Message-ID: <CAFEAcA-6mUaktymqqwC92owK9LSsJ_RdBi-Bp+7XUaEE0HoTiw@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PULL v2 0/2] pflash-next patches for v4.1.0-rc2
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jul 2019 at 10:36, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> The following changes since commit 23da9e297b4120ca9702cabec91599a44255fe=
96:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
90722' into staging (2019-07-22 15:16:48 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/pflash-next-20190723
>
> for you to fetch changes up to 124e4cfaa42bb5a14eec33ea47d3502b5f46eb33:
>
>   hw/block/pflash_cfi02: Rewrite a fall through comment (2019-07-23 11:31=
:07 +0200)
>
> ----------------------------------------------------------------
> One bugfix and silent a fallthru warning.
>
> ----------------------------------------------------------------
> v2: Replace Laszlo's Regression-tested-by tag
>
> Philippe Mathieu-Daud=C3=A9 (2):
>   hw/block/pflash_cfi01: Add missing DeviceReset() handler
>   hw/block/pflash_cfi02: Rewrite a fall through comment
>
>  hw/block/pflash_cfi01.c | 19 +++++++++++++++++++
>  hw/block/pflash_cfi02.c |  2 +-
>  2 files changed, 20 insertions(+), 1 deletion(-)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

