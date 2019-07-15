Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE50EC76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:37:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 782F62184E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P0QR3bwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782F62184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn26X-000363-KJ
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 10:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36399)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hn266-0001RN-AL
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hn265-0001Qi-C2
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:36:58 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51275)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hn265-0001Pk-3o
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:36:57 -0400
Received: by mail-wm1-x342.google.com with SMTP id 207so15453620wma.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 07:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=IMQnTUKKDALnIX8QU8RZollM1Y56a1BzbjmyeYYMnp0=;
 b=P0QR3bwX/B8QK/gpriZCRr1eyeJVnKTAMYxcLrNlvOPhWxwfOaSaRuKcSBhVExjg7b
 RevgYJ7xoTrqQbITp9FiLZO4Ru1uxIZ3unI7JGXS+lY3TnHK3SMkW8yR+SeEkmnSBqvD
 dTgojxvmQ+7CMdJv8Y6Cc0gJZz5FPjrN8En5HOT3kua3qCGrH3jp4D7CPfBWJVJ0p1J7
 CmmrRecsuEA2FFDwo35geJhA8FHgJSEQQu31iKE7SHU9qWumo4jF+DE65ibPtiP+oZkl
 kRt12wj0Cv+BD79SRh17NThabHKwz2MiLPpRWLN2pTSTqrqjQS+MfsqFFeHVPoowHEq+
 FdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=IMQnTUKKDALnIX8QU8RZollM1Y56a1BzbjmyeYYMnp0=;
 b=dvfU7fYQjnXXX+ANpO8UoHBp4uDCNY/4+yX9uQGxUg7O11ZgsrblEbIN/uiyvq/lpH
 mtmNhWInxnBsg/2jKwAuaKg5nwQ3dXzysA52UeEQGjLdPuMjMV6aSOEDhfPF5QOF0J9g
 048WkkuPAk5VW3IvEhkm+Ut+Oyq8K5+t1U2VTIhOnEQ7wT8IaY0b0AIIsGEsCi07WtVV
 DAa3vDX1x9FY6MjTfWDwhui/UyDWog/A61kcDrfoI34J5kn0RwtZc0vZ1Ov+H3rzGsgS
 neUywUhgABXqPN3CTtBtCFlxXL0vZugip4oeJdJLaVuc/w/JngGsEeKKuvey5nY+ub4R
 EJCQ==
X-Gm-Message-State: APjAAAXKhcRZ6zsq7CDmDzutlvBZ9F7pTc0jrbd6UZM2BrXh5+kKcdSM
 KlV3sP0OvCx90d9EDFZ0Df0FCA==
X-Google-Smtp-Source: APXvYqx0qftBeKwC0OFSGiHNAooroWFrT9w3whhas5zeLDyGKft7qMnwW6ccDZDFVfkS7KiYTQgQug==
X-Received: by 2002:a05:600c:2056:: with SMTP id
 p22mr24565915wmg.155.1563201415099; 
 Mon, 15 Jul 2019 07:36:55 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id o20sm43826001wrh.8.2019.07.15.07.36.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 15 Jul 2019 07:36:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1C0071FF87;
 Mon, 15 Jul 2019 15:36:54 +0100 (BST)
References: <20190708200250.12017-1-marcandre.lureau@redhat.com>
User-agent: mu4e 1.3.3; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
In-reply-to: <20190708200250.12017-1-marcandre.lureau@redhat.com>
Date: Mon, 15 Jul 2019 15:36:54 +0100
Message-ID: <87ims3uzy1.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH] archive-source: also create a stash for
 submodules
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
Cc: Fam Zheng <fam@euphon.net>, thuth@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> "git archive" fails when a submodule has a modification, because "git
> stash create" doesn't handle submodules. Let's teach our
> archive-source.sh to handle modifications in submodules the same way
> as qemu tree, by creating a stash.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Queued to testing/next, thanks.

> ---
>  scripts/archive-source.sh | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> index ca94e49978..fb5d6b3918 100755
> --- a/scripts/archive-source.sh
> +++ b/scripts/archive-source.sh
> @@ -39,14 +39,16 @@ function cleanup() {
>  }
>  trap "cleanup" 0 1 2 3 15
>
> -if git diff-index --quiet HEAD -- &>/dev/null
> -then
> -    HEAD=3DHEAD
> -else
> -    HEAD=3D$(git stash create)
> -fi
> +function tree_ish() {
> +    local retval=3D'HEAD'
> +    if ! git diff-index --quiet --ignore-submodules=3Dall HEAD -- &>/dev=
/null
> +    then
> +        retval=3D$(git stash create)
> +    fi
> +    echo "$retval"
> +}
>
> -git archive --format tar $HEAD > "$tar_file"
> +git archive --format tar "$(tree_ish)" > "$tar_file"
>  test $? -ne 0 && error "failed to archive qemu"
>  for sm in $submodules; do
>      status=3D"$(git submodule status "$sm")"
> @@ -62,7 +64,7 @@ for sm in $submodules; do
>              echo "WARNING: submodule $sm is out of sync"
>              ;;
>      esac
> -    (cd $sm; git archive --format tar --prefix "$sm/" $smhash) > "$sub_f=
ile"
> +    (cd $sm; git archive --format tar --prefix "$sm/" $(tree_ish)) > "$s=
ub_file"
>      test $? -ne 0 && error "failed to archive submodule $sm ($smhash)"
>      tar --concatenate --file "$tar_file" "$sub_file"
>      test $? -ne 0 && error "failed append submodule $sm to $tar_file"


--
Alex Benn=C3=A9e

