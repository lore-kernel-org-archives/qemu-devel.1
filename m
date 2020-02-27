Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10232C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:01:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8C9024692
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KEXzY3Qu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C9024692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Hqw-0001Ac-WA
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 07:01:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7HoO-0005xf-6F
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:58:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7HoM-0006s7-Tn
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:58:39 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46010)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7HoM-0006oR-OW
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:58:38 -0500
Received: by mail-ot1-x343.google.com with SMTP id 59so2596729otp.12
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 03:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fuMS6bSPXVXndu7kBPffnJGnH12mnvSiVJj1p19GFXU=;
 b=KEXzY3Qugo4bGcrQKa3EiqeZt+3+EUcwclHn2FLL9N1W3C5zYxN6DKVkWM2kLUkymv
 TQijMfi7Nq9yq4BB29Ehq7NVEx05G+CX5f9Utfr/moapDE1xHpQ7xOttaXTucFJSKvdc
 Hdo6mkdPS2or4P1SNJ6ILSkPIlRrMwlRAInxtltA8PBKW+bKItdMKSHtkIS8ewX2G2/u
 3cOWRWlbXjACIM8cdtLVcfHqrz8GK3etMyguS64+Cm2ji8rIDSoHEgapmjQ7MJXpL1TT
 7ZyuyW/uFwXSHZz3IcAdcpdgHJgIjWfkLk7CJ/P9FZJEblNMPrwCoReRJs9RL7avsJ9q
 2GCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fuMS6bSPXVXndu7kBPffnJGnH12mnvSiVJj1p19GFXU=;
 b=RvQNi2MdU6NK7vaT66hMUoU5P8prPMaBulYAjdRN1KADo8gnL8eOoapuK6Xah/U3Ft
 O34Cuec3mQXHqC6qwAscamz6SKCNRoXQpHLIUCC1F0Udrv2noFKcoS8jo2GM/Z9/NLkQ
 cv009aKBur2vnRfLi6umC0rtLFPanfZ+vru/gCDTgflFsfJD/TyyoIh0Sa++A9MVKNth
 o2Ar8dZZo/0jWl+cVX0CNAFh3TLKL27cD8vP9Ntg/hawpeGQNRUG46vhnnQomKidmgHi
 LM5V0rKDwwZnFvTHAMuXUDL/v/ZzcbIJT2VOY+QEYm8BcfT62B3g6vsz4Zyy/yvK+8fH
 Ox9g==
X-Gm-Message-State: APjAAAUldD2L7/8jpLlyBWQQMsO8z1CMCKbCVLmSyrKXDJ8Sdbj7Jm1k
 rNgDJFpXRIFX3vnkPiMhuaWWQ3GrP2QgdGQa/H0kfA==
X-Google-Smtp-Source: APXvYqxN/9qjvPIrA/az/jUuzdAubi9YefbOyEnT7cOwIi4gZFA4YeGJL12EEREuX4xe5PdnS/5BxpnQoZ4NvC0sf7E=
X-Received: by 2002:a05:6830:1184:: with SMTP id
 u4mr2810652otq.221.1582804717843; 
 Thu, 27 Feb 2020 03:58:37 -0800 (PST)
MIME-Version: 1.0
References: <20200226113034.6741-1-pbonzini@redhat.com>
 <20200226113034.6741-14-pbonzini@redhat.com>
In-Reply-To: <20200226113034.6741-14-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Feb 2020 11:58:27 +0000
Message-ID: <CAFEAcA_qWUY19ubmSaNoqbwjf8N8d1Dw=vMMD7j5yH8TSwK35A@mail.gmail.com>
Subject: Re: [PATCH 13/18] docs/system: put qemu-block-drivers body in an
 included file
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Feb 2020 at 11:30, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> This removes the "only" directives, and lets us use the conventional
> "DESCRIPTION" section in the manpage.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/system/index.rst                  |   2 -
>  docs/system/qemu-block-drivers.rst     | 987 +------------------------
>  docs/system/qemu-block-drivers.rst.inc | 954 ++++++++++++++++++++++++
>  3 files changed, 966 insertions(+), 977 deletions(-)
>  create mode 100644 docs/system/qemu-block-drivers.rst.inc
>
> diff --git a/docs/system/index.rst b/docs/system/index.rst
> index f66e6ea585..21b5a18b67 100644
> --- a/docs/system/index.rst
> +++ b/docs/system/index.rst
> @@ -13,5 +13,3 @@ Contents:
>
>  .. toctree::
>     :maxdepth: 2
> -
> -   qemu-block-drivers

Why do you drop the documentation from the HTML manual ?

Is the changing in the underline styles for section
headings necessary? It's non-obvious in the diff format
the patch in the email has, but with my local git diff
settings (algorithm=histogram) it shows up better:

> Secure Shell (ssh) disk images
>-------------------------------
>+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Given that rST figures out subsection depth automatically
rather than based on which particular character is used
maybe we could avoid the noise in the diff?

(OTOH, we should probably pick a rST style guide for which
characters to use for which section headings and follow
it here to avoid unnecessarily confusing ourselves...)

thanks
-- PMM

