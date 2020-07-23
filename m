Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318FBC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0C0720768
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wZtikG9r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C0720768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyaUw-0002d2-9j
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 08:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jyaUO-0002C6-Dl
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:38:20 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:37111)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jyaUM-000583-7N
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:38:20 -0400
Received: by mail-ot1-x333.google.com with SMTP id w17so4222622otl.4
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 05:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=e1jjFeXJLXRzZp9cl9O1hsUQ9iLkPm9KlDitpE93l4E=;
 b=wZtikG9rvxj1HfzUF+zAiiSU0AbZME9FkMnqYhzGc3z1BK9kr5SWv3ycUPr2DieT/L
 liD68KdWHhqJe6VgXqPAJe0lqDreBJC4PKBy2bBCBMjHcUrB01v2czm4Eac0hzbOWmGc
 23Hln4GbzRjRy4jKbcBis4oe6CIsnbkbuPbqZSDjF1oWttEmjK1HD279Sb68JvMbqVlb
 uON4ttsUfI4BYCRt56I0KcCvrwCl1MqvSJT8kzVmjgBSqxTJeIwcRaMG/gbQ7mWfk+EL
 /ofoO0DJn4M8UXBaCBf+0ToHNzWqhCisYhCsBnalMVoB9eXHL/14Nm9ZmfgK7Bv5Y5qr
 r1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=e1jjFeXJLXRzZp9cl9O1hsUQ9iLkPm9KlDitpE93l4E=;
 b=MscLPucz7LdmKbfDqVKNuui9QcYCrowRff1goVTDm/cg+PTAX5f+S2HOu/1c9DkpOT
 THWtXpgHtOz8RH80zesZVFHt1pHjEYSb7F7yVMm0jxWEDNTJbNh86S+WtooCGSCMv56J
 PB/KkF41it6r9easdENucFXfSF89qxVkXKEvbrh6Myy7xC5KrKLiPUyxKW2YZaLGd+wU
 9+oEBeP9rJOTDp6sdRNzK6MrRDrWYmMi3lNWePAeyxlM2UzYWJyRY6G6WcsO0kPZHDRK
 JVD5QW4VDN4EpwOCgipGk0ILA9HbzlAgkhNo4tAqL3W9xzLkX/7TfXBLCrXJhdwOBZeT
 aueA==
X-Gm-Message-State: AOAM532yqtLLhfrqeVIV+Lm+mgfPuj/R3S1JJzkwgVu/odwTMbVft1HC
 E8rnaKrzfIsbcqXzbj3FZs5eOat0dtuXPZdd6nRcDQ==
X-Google-Smtp-Source: ABdhPJxERnt/Bxt36bHyYtbPEhbB5/tQaJ5EvESHjmbGlZvczZ6Lf/Ok8/2AwXxs676AchQd8jq/C584Yj5OsdjrxgU=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr4052596oto.135.1595507896762; 
 Thu, 23 Jul 2020 05:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200721180137.11136-1-f4bug@amsat.org>
In-Reply-To: <20200721180137.11136-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Jul 2020 13:38:05 +0100
Message-ID: <CAFEAcA8Kco9p8NAsvvQ5xoUskaD9n9Vh5JB=dSvfrT2ffzYwTw@mail.gmail.com>
Subject: Re: [PULL 0/4] AVR patches for 2020-07-21
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x333.google.com
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
Cc: Stefan Weil <sw@weilnetz.de>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Michael Rolnik <mrolnik@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jul 2020 at 19:03, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> The following changes since commit 90218a9a393c7925f330e7dcc08658e2a01d3b=
d4:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-202=
0-07=3D
> -21' into staging (2020-07-21 10:24:38 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/avr-20200721
>
> for you to fetch changes up to 5e29521a82e540552880c3572cb8274bcaa1002c:
>
>   hw/avr/boot: Fix memory leak in avr_load_firmware() (2020-07-21 16:13:0=
4 +0=3D
> 200)
>
> ----------------------------------------------------------------
> AVR patches
>
> Fixes a memory leak reported by Coverity (CID 1430449).
>
> CI jobs result:
> . https://gitlab.com/philmd/qemu/-/pipelines/168722631
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

