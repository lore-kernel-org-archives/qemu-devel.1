Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF09C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:19:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10ABA206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LHegkkIw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10ABA206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izfCG-0006Db-V4
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:19:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1izeps-0005tS-7v
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:56:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1izepq-0008Gd-Vc
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:56:40 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:34822)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1izepq-0008CC-Pd
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:56:38 -0500
Received: by mail-oi1-x243.google.com with SMTP id b18so4155445oie.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 02:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hoVpaaxA/IqP5s1JvcpuvxK3sp4hYRopXLBeMPJaOl8=;
 b=LHegkkIwtZCsmEJ8zzORbD7U6aCIUhhGIPofAHyFHEnUzDngNvvsdJ+jF1wCKyxdqR
 a/Uw/syfOmKFTRstECMf7Pkd6taoUe8nzOwtlEK4hBQ+xjcZ899vF3ynRklF7K2+4SHZ
 sFzY5r7nYDnS9nDTaczIbgNygo1vdBaYr6olCGR3wMenB6kAL7n4Z2rukmuHdR1kwiGJ
 1Cn2j0s9/mqlQ6kZXcrH5I6v+1PwMjGoyN3is4ptxJwzfKzm4q3ySGAh7TK+9dIvCxNs
 P+AYK6hzWqVttRErZmW9D/BHPJFPKbkd7/DgJzRwAIHQAYRVRq48QwZibE6drbBlGTSJ
 FXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hoVpaaxA/IqP5s1JvcpuvxK3sp4hYRopXLBeMPJaOl8=;
 b=VoXo41KunuDHb1lqW2YwBhkmUy0RLj0rCmmVTxjGZrQOR8/xcJ6/tgT3S6TstJUyiO
 Ceo+5vbdXL01xqJ8JUvz7ajWkL/SHpqMwbYYzmaZR99SP2KW/mQeEQVZPPPRsvSPhPXP
 g/sU9BJBBuH5ytxvYcDuXqChD2F4Gi0RG2CI73to/75m6Hnn+yzDMJFe/keYDW6MSlud
 fYKYQIeipiJNDr+f1sTk8N7raqhWnk+NS6XIM2VM2uozcKH6f85tAQKkgTuCQKUXXa0K
 kayO2YdfoOLbcwnZYMss0Y70XXY6YWaPzJKHOgvLCCXdnouTu+YhI4bdR6z1ppD0PwBM
 q1Qg==
X-Gm-Message-State: APjAAAW2PIvQ7fEgzfKR5l53uz+x1GIkSD1ujDzlNQdtDkHwOx99H1ho
 4UJkJvKZeOHPqVsK3HhhT4V81q/Fa9F1cpuLjMqfrQ==
X-Google-Smtp-Source: APXvYqwkGVDe2WLXneuG+GzDJ7uHz9RYwiGtcFaYJtJiwOM1q0yhw9LMC6N5FhAGIeZdxlQcXqhwBLagB7qtvyGPELo=
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr6505351oif.163.1580986597881; 
 Thu, 06 Feb 2020 02:56:37 -0800 (PST)
MIME-Version: 1.0
References: <20200206104743.11740-1-alex.bennee@linaro.org>
In-Reply-To: <20200206104743.11740-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Feb 2020 10:56:27 +0000
Message-ID: <CAFEAcA9e=6+Uhdn6rStPqQJQPipoVDf0dANJcV2pt1iSDVQ_kA@mail.gmail.com>
Subject: Re: [PATCH] .readthedocs.yml: specify some minimum python requirements
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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

On Thu, 6 Feb 2020 at 10:47, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> QEMU is all about the Python 3 now so lets also hint that to
> ReadTheDocs in its config file.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  .readthedocs.yml | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 .readthedocs.yml
>
> diff --git a/.readthedocs.yml b/.readthedocs.yml
> new file mode 100644
> index 00000000000..99730364bbc
> --- /dev/null
> +++ b/.readthedocs.yml
> @@ -0,0 +1,17 @@
> +# .readthedocs.yml
> +# Read the Docs configuration file
> +# See https://docs.readthedocs.io/en/stable/config-file/v2.html for deta=
ils
> +
> +# Required
> +version: 2
> +
> +# Build documentation in the docs/ directory with Sphinx
> +sphinx:
> +  configuration: docs/conf.py
> +
> +# We want all the document formats
> +formats: all

> +# We need at least 3.4 for enum, but we enforce 3.5+ for sphinx

A better comment IMHO:

# For consistency, we require that QEMU's Sphinx extensions
# run with at least the same minimum version of Python that
# we require for other Python in our codebase (our conf.py
# enforces this, and some code needs it.)

Otherwise this will become inaccurate in a couple of weeks
as soon as some other extension code lands that really does
have a 3.5 requirement.

> +python:
> +  version: 3.5

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

