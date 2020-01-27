Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B3CC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 11:09:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83235214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 11:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TvFRYc0E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83235214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw2Gm-0000zG-Oj
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 06:09:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iw2GB-0000So-LW
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:08:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iw2GA-0000Do-Ir
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:08:51 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:39320)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iw2GA-0000D4-Dr
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:08:50 -0500
Received: by mail-ot1-x32c.google.com with SMTP id 77so7945519oty.6
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 03:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=r4ygOw7omS3u7JkyowqLghvf6J0uVd/gnM/TNC7b0WI=;
 b=TvFRYc0EkVmOOk61kqkfFxO8Pog4Am9lZdoXdp0qD4osQ7giXGlJw1bH/K1S8Ck0X8
 rRyTGEXM2VS1OyI2OJuZwnrnMoGnZhvH7SDwGGWCqNjOUZLlV5bFJXzGhbFQGVELCyRJ
 ESq6FXa+kcnpSpO47to+nAEzmJlXfvDrK9QFNaokJVFaLVmi07V4ZVXGeJCH9esXA27a
 ypRmgBYYsRLdh5QDBIU/HJwrynWJgobQmg2yvkQGcXSz73x4Yy4b4KUJ1gQfzHG9sqVx
 SlBAjVruVXqWGWYWUatxSHtck30RSvaZPqhbqbD3j5OG8TbYEex3Y+Sx5qrfHvHb4vTV
 A7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=r4ygOw7omS3u7JkyowqLghvf6J0uVd/gnM/TNC7b0WI=;
 b=D8y3omaoylWCOiztycTzpb9e/zCtUULODXeKefoAFwcm+rMK/HJMSy93aO1wMcivV1
 Ua1fgZkSjVvxTVOmoTfBUVHKKxCo2/Nzn1xndVKTl9ZafkYKHw6W0yK/jItPXDBzSaW0
 pUmhSATyUAiZvg6vEIqsK1ZZwc4kO7L5fZr30pJqwWQXYOJbhxIrppbud5AH5IzccKgq
 N/HF56sJCe8qF1jpgHq4EbiLTlwNaVm1klnIq//ZpfUv9NMqavnzG8n88TW+uR8/VIiY
 YHGPU12h1jBCGPCnJ3MbePE9HhNOE5wvfAdAdyoECCOa5VaiuwP62N/dLev/cDbq7PZO
 5y5Q==
X-Gm-Message-State: APjAAAWvVO1z06/bM5F941ikUMZlGK+oM3HUUzLf6n7uroWwb7w5Ipnm
 iu0WW8etZYXQC909W07sV8u5UPc0+qQwsrUCrIO7/Q==
X-Google-Smtp-Source: APXvYqxtay+AqzAOeX+puGxUzL3N/YGUm7LI8CwWxAp3uEW6344eXX7z6kDxI2bv/OtDmS7105D6Kd49H1LCVCm6X9M=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr11392089otq.97.1580123329402; 
 Mon, 27 Jan 2020 03:08:49 -0800 (PST)
MIME-Version: 1.0
References: <1579897115-57129-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579897115-57129-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jan 2020 11:08:38 +0000
Message-ID: <CAFEAcA9yZyBP4tO2vy3J+Yzj6jTWrOpcow2NP2h1-TEYui5JPQ@mail.gmail.com>
Subject: Re: [PULL v4 00/58] Misc (x86 and QOM) patches for 2020-01-23
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32c
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

On Fri, 24 Jan 2020 at 20:19, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 3e08b2b9cb64bff2b73fa9128c0e49bfcde0dd=
40:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/edk2-next-2020=
0121' into staging (2020-01-21 15:29:25 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to db5adeaa84d0d70dabd41500e72493fec04408ac:
>
>   build-sys: clean up flags included in the linker command line (2020-01-=
24 20:59:17 +0100)
>
> ----------------------------------------------------------------
> * Register qdev properties as class properties (Marc-Andr=C3=A9)
> * Cleanups (Philippe)
> * virtio-scsi fix (Pan Nengyuan)
> * Tweak Skylake-v3 model id (Kashyap)
> * x86 UCODE_REV support and nested live migration fix (myself)
> * Advisory mode for pvpanic (Zhenwei)
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

