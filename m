Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC40C4727D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E57B721D42
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gooQv8PT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57B721D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqyP-0005mf-3f
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqxG-0004uL-AY
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:52:19 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:33819)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqxB-0002lr-Sz
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:52:17 -0400
Received: by mail-ed1-x542.google.com with SMTP id k14so3190950edo.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 09:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fYWWpbd8qQvEa6J66gC3jKVZt99mKetVL+4DLYTMXfs=;
 b=gooQv8PTbMdKs82lfd/c7bdymipOwpB7ByueAMrB+7XNrzOstWwap0fhZm+0drMUM6
 04KWELxm9ggdEXeKj0FMZ3XpuejaKWjaUwaB/a8kF7UJF9e7xUW0WJKhBGwOd4mj3D/6
 lnRXvrE7V9hBaopHleioNxHqqpe/vy/nNez1b4Z4WnmWg3jIz5gf1D3qbBETfPJvcvoC
 sQJ7XmS64HaDlmy6wZB0KWSZAPxx7jb3d/7xdAr1sVu21yYIl7uVuMUm8jFxkyohfmcy
 9P17lBPo7qKFTDlO4AZMTRa+0N9SjDhMni7YWBG+2sp76P/oWH/GXCs3x6n6NLuaKneZ
 26Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fYWWpbd8qQvEa6J66gC3jKVZt99mKetVL+4DLYTMXfs=;
 b=BqyZB69gUsBwAIGuqmfWmRPJIx41BWg871a15Hdb+oTC17YS/0KkknPtVjM0ZmW154
 G5lQ6eoXUhNpBJNT+v+BNbrrCH0dpsMfVD11ZfPSt5nIqU1g5B2MEXOKWwwDPHsBamVE
 3hQN+n6MGq6bIhuTyzbnMif9xnRRiFKjvqPdRCz8rZBXwKN940sZO/KJCBUkLk6kYwd+
 aQB/q5iWFO/X9B0JZSWqjU8ccHCgPGpXUtHHJcto1S0I6IFb47W6xtlLVPNcmWDRJNj4
 eU5YRzjYCcjqSImC1g3pGtz3Es5v7bKrXLOJpfoO0XX1IBsLq/oVtNdzcBb3Kv9LSNSx
 +qHQ==
X-Gm-Message-State: AOAM531EzPSBYl4pbakVQrxMIMNLmW1jWIeEADKurjKTB92EsZMQ0WEU
 qr8tSXmI53z8ZeewpZ0ZVU/rQqwFBLs4B8DFVqDG2/1kXBQ58Q==
X-Google-Smtp-Source: ABdhPJwgAssFZTopuiqRjh4NT+uu0NpDFSWdVq9D4vjJ+yRg3NUOd6tgnsxMLRXkDGaBZ+wqdaz9yt806SJP47OESG8=
X-Received: by 2002:a05:6402:202a:: with SMTP id
 ay10mr2371678edb.36.1601052732179; 
 Fri, 25 Sep 2020 09:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200925161408.4016-1-alex.bennee@linaro.org>
In-Reply-To: <20200925161408.4016-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Sep 2020 17:52:01 +0100
Message-ID: <CAFEAcA9ZBRvyc7fEkouMbaxEN+4vG=mOf1L2diTa2jQV=PfMsw@mail.gmail.com>
Subject: Re: [PATCH] configure: make building deprecated targets easier
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 25 Sep 2020 at 17:14, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> While we are ceasing to care about these targets it is useful for CI
> purposes to be able to enable them all without having to remember the
> list.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  configure      | 17 ++++++++++++++++-
>  .gitlab-ci.yml |  4 +---
>  2 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/configure b/configure
> index c5f1b3bec6a8..2436125cf541 100755
> --- a/configure
> +++ b/configure
> @@ -1039,9 +1039,13 @@ for opt do
>    ;;
>    --cpu=3D*)
>    ;;
> -  --target-list=3D*) target_list=3D"$optarg"
> +  --target-list=3D*)
>                     if test "$target_list_exclude"; then
>                         error_exit "Can't mix --target-list with --target=
-list-exclude"
> +                   elif test "$target_list"; then
> +                       target_list=3D"$target_list,$optarg"
> +                   else
> +                       target_list=3D"$optarg"
>                     fi
>    ;;
>    --target-list-exclude=3D*) target_list_exclude=3D"$optarg"
> @@ -1049,6 +1053,13 @@ for opt do
>                         error_exit "Can't mix --target-list-exclude with =
--target-list"
>                     fi
>    ;;
> +  --include-deprecated-targets)
> +                   if test "$target_list"; then
> +                       target_list=3D"$deprecated_targets_list,$target_l=
ist"
> +                   else
> +                       target_list=3D"$deprecated_targets_list"
> +                   fi
> +  ;;

So, this isn't what I expected --include-deprecated-targets to do.
The behaviour I think it should do is basically "disable the
skip-deprecated-targets logic"; so you get the set of targets
that any other options imply, including any deprecated targets
that those options specify or imply. (Whereas the default
without --include-deprecated-targets is that you get the set of
targets that your options imply, but deprecated targets are
filtered out unless you asked for them by name.) So eg
  --disable-system --include-deprecated-targets
should build all the linux-user targets, deprecated or not,
  --target-list-exclude=3Dnios2-softmmu --include-deprecated-targets
should build everything (including deprecated targets) except
nios2-softmmu, and so on.

thanks
-- PMM

