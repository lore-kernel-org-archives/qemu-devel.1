Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B7FC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 13:34:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0D3622DA7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 13:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWzXwiBg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D3622DA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2y5V-0007Ro-Tr
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 09:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i2y3O-0006fB-32
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 09:32:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i2y3M-0001HZ-Cy
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 09:32:01 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40820)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i2y3M-0001Gy-8C
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 09:32:00 -0400
Received: by mail-ot1-x343.google.com with SMTP id c34so2744635otb.7
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 06:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=PUObxmsF+mhH7/evSm4Dms1ZMlM+XDysXDr9Ro9B8Bg=;
 b=TWzXwiBgW9ZqyYEjSzFXgOSDTkivW8MuEiRRQib85KxUrPmVWfjnkB0A1fApGCcKu2
 BN9z5QmQFyzqINV0hp9IAeyeBNsZLraC3BVVwEn/k6o+nSyEdISNt9QsjhEhuEXmBymw
 ejKzYDOuBIjNOe50gGRU2KyntUw1y2cdUNNVoRvj6udoCjYmnnbJMDMLdTqK174C7nZI
 tm/ejgh6qzHlnwoKTZMOdUYvpU1aSBUIESdaCYg9NoL2D4lXa5q0fynGrrkzAdtM/fG/
 d73xJadZG9/Jm1+aMbT4IN6B2kisofGuED8XMOKfcd15OktnxoWCf2AxdXtM2EYQ5cFF
 scgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=PUObxmsF+mhH7/evSm4Dms1ZMlM+XDysXDr9Ro9B8Bg=;
 b=M9LLftbjl9BEmhMErFFLZ+B6iqgYRAtxn2bBl+v0MQYmrfw6vHbpXSqXdz24uvZA/L
 2cbAw6NP0qemfIM0Jbt3I89JuAuG/WqiLNzziRfYNdIBNz2oCS3HoO08vz545KnuhesA
 JwflTVOP7kyZoD788BLG8iO/O+iLeMk0cSyeNRbrcAbMpGuubHmo/zdzQRnAxUMjb9mk
 7oEHKnOVnlA8ZlNCIABxkwrrDpdy9mRlAKarmN8lQ1QRuG/+xbOuRTPA8j+t8JYZarc3
 3r8zuHORH/DIG8ycTXY7Z+OYThudrur21Cla8M2hOgiIqg1Gf7jqeNvOqULY+wyJyV7S
 Mx9Q==
X-Gm-Message-State: APjAAAXFtKUlvzb29O9ZQgad8sLtkPKidJIuTYlS5dgO+uV34cmGcZ36
 OiJpjsvOsam5DHjrmFdpbDGhznTSieEMhy8WdaviOVFC
X-Google-Smtp-Source: APXvYqxk5nybT3DuJolpXHjhKVpmkjLccWEr2q/NFSFASoiFIHL3BcmhBuxdpJz0gPuFTuQ1wbf5h65FlVxgZkblGjE=
X-Received: by 2002:a9d:1288:: with SMTP id g8mr3214914otg.306.1566999119238; 
 Wed, 28 Aug 2019 06:31:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Wed, 28 Aug 2019 06:31:58
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Wed, 28 Aug 2019 06:31:58
 -0700 (PDT)
In-Reply-To: <20190828120832.9208-7-alex.bennee@linaro.org>
References: <20190828120832.9208-1-alex.bennee@linaro.org>
 <20190828120832.9208-7-alex.bennee@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 28 Aug 2019 15:31:58 +0200
Message-ID: <CAL1e-=iavJP4mb2275ypu9otgShMemr1juWYeWjY9UrgwAX6vA@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v1 6/8] .mailmap/aliases: add some further
 commentary
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

28.08.2019. 14.22, "Alex Benn=C3=A9e" <alex.bennee@linaro.org> =D1=98=D0=B5=
 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> The two files are not interchangeable but a change to one *might*
> require a change to the other so lets flag that up with an explanation
> of what both files are trying to achieve. While we are at it document
> the many forms .mailmap can take in the header.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

>  .mailmap                            | 14 ++++++++++++++
>  contrib/gitdm/aliases               | 20 ++++++++++++++++++--
>  contrib/gitdm/group-map-individuals |  3 ++-
>  3 files changed, 34 insertions(+), 3 deletions(-)
>
> diff --git a/.mailmap b/.mailmap
> index d0fc1d793c6..0756a0bf66d 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1,4 +1,18 @@
>  # This mailmap fixes up author names/addresses.
> +#
> +# If you are adding to this file consider if a similar change needs to
> +# be made to contrib/gitdm/aliases. They are not however completely
> +# analogous. .mailmap is concerned with fixing up damaged author
> +# fields where as the gitdm equivalent is more concerned with making
> +# sure multiple email addresses get mapped onto the same author.
> +#
> +# From man git-shortlog the forms are:
> +#
> +#  Proper Name <commit@email.xx>
> +#  <proper@email.xx> <commit@email.xx>
> +#  Proper Name <proper@email.xx> <commit@email.xx>
> +#  Proper Name <proper@email.xx> Commit Name <commit@email.xx>
> +#
>
>  # The first section translates weird addresses from the original git
import
>  # into proper addresses so that they are counted properly by git
shortlog.
> diff --git a/contrib/gitdm/aliases b/contrib/gitdm/aliases
> index 07fd3391a56..c1e744312f5 100644
> --- a/contrib/gitdm/aliases
> +++ b/contrib/gitdm/aliases
> @@ -1,6 +1,22 @@
>  #
> -# This is the email aliases file, mapping secondary addresses
> -# onto a single, canonical address. Duplicates some info from .mailmap
> +# This is the email aliases file, mapping secondary addresses onto a
> +# single, canonical address. It duplicates some info from .mailmap so
> +# if you are adding something here also consider if the .mailmap needs
> +# updating.
> +#
> +# If you just want to avoid gitdm complaining about author fields
> +# which are actually email addresses with the message:
> +#
> +#   "...is an author name, probably not what you want"
> +#
> +# you can just apply --use-mailmap to you git-log command, e.g:
> +#
> +#   git log --use-mailmap --numstat --since "last 2 years" | $GITDM
> +#
> +# however that will have the effect of squashing multiple addresses to
> +# a canonical address which will distort the stats of those who
> +# contribute in both personal and professional capacities from
> +# different addresses.
>  #
>
>  # weird commits
> diff --git a/contrib/gitdm/group-map-individuals
b/contrib/gitdm/group-map-individuals
> index 05e355d30ec..1c847174380 100644
> --- a/contrib/gitdm/group-map-individuals
> +++ b/contrib/gitdm/group-map-individuals
> @@ -2,7 +2,8 @@
>  # Individual and personal contributors
>  #
>  # This is simply to allow prolific developers with no company
> -# affiliations to be grouped together in the summary stats.
> +# affiliations (or non-company related personal work) to be grouped
> +# together in the summary stats.
>  #
>
>  f4bug@amsat.org
> --
> 2.20.1
>
>
