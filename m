Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECACC33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:29:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A2B420721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UxLmM3yG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A2B420721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iybnR-0002XQ-Pz
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 08:29:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iybmm-0001wC-Hp
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:29:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iybml-0002xz-6t
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:29:08 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36045)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iybmk-0002xN-1t
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:29:07 -0500
Received: by mail-oi1-x242.google.com with SMTP id c16so14737740oic.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 05:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mrIAKnSUpHOc5uUROzH9leiU2NAhwVquxJJQZWU9pNo=;
 b=UxLmM3yGQkapKmkSzl7tD0qkzSldHpAmLiTE0CydI8pe09DqrnNw3wPR3dY3hwkNra
 R9k4mn3NwlY+3Di6pme+8V665lv0ApSQrxP2zp3rnnTDuK3pTO7rCMySh+MDkWGmr0SS
 MD81rJo3fDxP8eBRPxqLt+VXzTjtxBlkNK2wUQ9LsoA+tlbUiZim0r3oTPY3BdZOYs/p
 MLp9CriAMjAbgpIicg1/ooMfjIJyV9RcUX9Tdd0o4TmeVZp/krPcPEiPtSBqgRWpVIcr
 QbqxDypMpnNGnNRlLglkELHeGWifCOv7tiSRxNBKgvGdNXI9cGAgvJfpnx/2TCPkwLk4
 eZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mrIAKnSUpHOc5uUROzH9leiU2NAhwVquxJJQZWU9pNo=;
 b=iQLbBNOHzMGgFc4EaFKIVH07sM52YNT9TmzmP6iUPH/1gw1axHHbblefcX/4z0Wmrp
 58cW+5Hy9qwoe3Id1dHOCSRlGQuAtGYHL5M0O+SVmfChbFS2kTespDmodDOmpmDV/vYb
 SRbuLjZFPLWvTWA0Mwcu8Sg6hPQUKkkMqHkOcWOrOO+5OqR72Y0o6WaAPfsrpGq+c6JE
 SICFTFeAbNkwFc2tz5q0jgGqpq1He0quCVdnXqZekzQObdJ+2bBnKy0OuOAJ+Y+eVwXq
 k4viRea+Q7J09VgfnEuU5mqkGGx3w/B0yZsQCGrQwcQLONShiEsogtMPy5ODXxGGl1T3
 NlVQ==
X-Gm-Message-State: APjAAAWIG+x2Fkb/JNvbvj++KdWGI2L+Sr2cCZCMTnNavyR8262ZAM8v
 2/K68LYxOhMY8EX+vLG+r9JV1dPbsEGpQCC4GzG27w==
X-Google-Smtp-Source: APXvYqxLJLmdB0UumH11bUq61J9mHuNV9nA5dRON/CquJx2MWeJ3yCbY7XsfvWlllJ9EwZEh7VlZ2rxw/+9pHju6bLI=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr14124225oie.146.1580736545130; 
 Mon, 03 Feb 2020 05:29:05 -0800 (PST)
MIME-Version: 1.0
References: <20200203131919.9972-1-thuth@redhat.com>
In-Reply-To: <20200203131919.9972-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Feb 2020 13:28:53 +0000
Message-ID: <CAFEAcA8gzuukXwrLLAyYfP3kNVRNZCXwhPNNhWothXiWfqghOA@mail.gmail.com>
Subject: Re: [qemu-web PATCH] Update the documentation links to point to our
 generated docs
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Feb 2020 at 13:19, Thomas Huth <thuth@redhat.com> wrote:
>
> We are now providing the generated QEMU documentation files directly
> on our www.qemu.org webserver, so we should link to these files now.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  _includes/footer.html |  2 +-
>  documentation.md      | 14 +++++++++++---
>  2 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/_includes/footer.html b/_includes/footer.html
> index 1669ef7..e67ffd7 100644
> --- a/_includes/footer.html
> +++ b/_includes/footer.html
> @@ -14,7 +14,7 @@
>                 </ul>
>                 <ul class="style">
>                         <li><a href="/documentation">Documentation</a></li>
> -                       <li><a href="https://qemu.weilnetz.de/qemu-doc.html">Manual</a></li>
> +                       <li><a href="https://www.qemu.org/docs/master/qemu-doc.html">User manual</a></li>

This is the old texinfo user manual, and it no longer contains
all the information it used to (as we have been moving parts of
it out to the rST manuals). It's going to go away entirely
at some point. The equivalent "here's the top level of the docs"
in the new rST world is https://www.qemu.org/docs/master/,
which has links to the various rST manuals (and also the
qemu-doc.html).

>                         <li><a href="https://wiki.qemu.org/Category:Developer_documentation">Developer docs</a></li>
>                         <li><a href="https://wiki.qemu.org/">Wiki</a></li>
>                 </ul>
> diff --git a/documentation.md b/documentation.md
> index f4ef9f4..e96c39a 100644
> --- a/documentation.md
> +++ b/documentation.md
> @@ -3,9 +3,17 @@ title: QEMU documentation
>  permalink: /documentation/
>  ---
>
> -The [QEMU user manual](https://qemu.weilnetz.de/qemu-doc.html) can be read online, courtesy of Stefan Weil.
> -More documentation is found in the <a href="https://git.qemu.org/?p=qemu.git;a=tree;f=docs;hb=master">`docs`</a>
> -directory of the QEMU git tree.
> +The [QEMU user manual](https://www.qemu.org/docs/master/qemu-doc.html)
> +is the first place to go in case you have questions about using QEMU.
> +
> +A lot of additional documentation can be found in our
> +[documentation section](https://www.qemu.org/docs/master/)
> +which is generated automatically from the QEMU git source tree.

Similarly here we shouldn't directly link to qemu-doc.html.

> +
> +Some text files have not been converted to the new format yet, though.
> +These documentation files can be browsed via the
> +[git web interface](https://git.qemu.org/?p=qemu.git;a=tree;f=docs;hb=master)
> +instead.
>
>  The [QEMU wiki](https://wiki.qemu.org) contains more
>  [user documentation](https://wiki.qemu.org/Category:User_documentation) and
> --
> 2.18.1

thanks
-- PMM

