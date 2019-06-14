Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49C4C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:15:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 405E720850
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t5/bH3jM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405E720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51450 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbm3D-0008BI-BL
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 09:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38929)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbm2H-0007e9-80
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:14:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbm2G-0005AC-4r
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:14:29 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42425)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbm2F-00059o-Va
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:14:28 -0400
Received: by mail-ot1-x342.google.com with SMTP id l15so2564888otn.9
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 06:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MMqp2mdHWGjEB0jSzu1nzPUGcUoQioVvAVXMlik8HyE=;
 b=t5/bH3jMGTnQN/EMxmCPOGWj6E5nx2OMi9tI+vWhIPfgBCTEeM/KzO4ywoF5i1j9nb
 IBfBZ/2iipK8JPIkxHWLRx3CRwrT4tfEPod/kvCJxOwxVS1Sz+pmxqsrauYMA8Hd5Ed2
 49BY6PJbUtaScD5mCqOfdSaOn5VIHltYKBecXpGI13jhYnitWYCyoTC8pVO/xuYyko+R
 76Bj9IbYpThvD2KYgooF4QzJ/aAybiOB4WnyXcI37WIs7pVOF8aON7g6UgLi0qhodTqK
 2YZRBpWT39unq1OeqN0kCnsHRbtwTiNElUQFTYuYnkAS/BavrQ/MbWCT6s+MlUCM5uzw
 wxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MMqp2mdHWGjEB0jSzu1nzPUGcUoQioVvAVXMlik8HyE=;
 b=umQ1g/kvOjd/pUUA13i2eOWCjXNoJ5Fm36dCKxts9VUGl5oOLXqGuyJmDfgs93yT3N
 k1XO5ZxMFnEzXqipD1fwmmyOND3B/NHDorYPETBjcwKUSL66vOyAsqJKIP41LcGuAjcP
 +7GPesDyDhvJERecYAzqaXxFt2osfVbOiTi6EloMinORxL+39/4HvEpTREIrieIHdvtk
 3T8YneYgnvYBAA/StqmxNCXvgtxPt+YUfA5da2pYaaDjjuvIXuNI9SJQDQtpuEP2ksQZ
 JwgaIL5EMrhxuiTJLHFn7aUTt31ve4Xy5RsW0youtgv3ZEfYuYAx/Tva6pIDOxeQcJi8
 3dLg==
X-Gm-Message-State: APjAAAVPrK3uhQpfZ9KPnfT+J003wJudZ6KNycHztECjHFqHT3NAAmZ5
 sLoUU/KP8NraLR+kw+yqy1e7u+haooPY8H+EMdD3/w==
X-Google-Smtp-Source: APXvYqyRXNz09WukobAcVSWZDTbUMo2ivMUVg6juplcv4V0wK9G3kT9ohGw8a1INcOrvfNTjT1S45azH9UggDOABkEA=
X-Received: by 2002:a9d:7245:: with SMTP id a5mr8931033otk.232.1560518066742; 
 Fri, 14 Jun 2019 06:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <1558550785-20098-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1558550785-20098-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1558550785-20098-3-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jun 2019 14:14:15 +0100
Message-ID: <CAFEAcA-tyPqtaHVgUocqf4yT8peAZX6EJSEhNzhZ65iUejyDcg@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH 2/5] linux-user: Add support for tracking
 the target signal mask
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?B?TWlsb8WhIFN0b2phbm92acSH?= <Milos.Stojanovic@rt-rk.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 May 2019 at 19:57, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Milo=C5=A1 Stojanovi=C4=87 <Milos.Stojanovic@rt-rk.com>
>
> If TRACK_TARGET_SIGMASK is defined, add fields in the TaskState structure
> which will hold the target signal and suspend mask and add support for
> initialization and forking. No functional changes are being introduced in
> this commit. The TRACK_TARGET_SIGMASK will be defined in a later commit
> where the target signal masks will be needed in order to implement
> multiplexing of real-time target signals which are out of the host range.
>
> Currently, QEMU has a copy of the host signal and suspend masks and that
> is usually enough, since most of the time the signal mask of the target
> architecture is either the same length or narrower. If however the signal
> mask is wider, then part of it won't be tracked.
>
> This commit enables adding support for separately tracking the target
> signal masks in the following commits.
>
> Signed-off-by: Milo=C5=A1 Stojanovi=C4=87 <Milos.Stojanovic@rt-rk.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

> ---
>  linux-user/qemu.h    | 5 +++++
>  linux-user/signal.c  | 3 +++
>  linux-user/syscall.c | 3 +++
>  3 files changed, 11 insertions(+)
>
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index ef400cb..9f70996 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -141,6 +141,11 @@ typedef struct TaskState {
>       * currently in the middle of such a syscall
>       */
>      sigset_t sigsuspend_mask;
> +#ifdef TRACK_TARGET_SIGMASK
> +    /* Track the target signal and suspend masks. */
> +    target_sigset_t target_signal_mask;
> +    target_sigset_t target_sigsuspend_mask;
> +#endif

These basically do the same thing as the existing sigsuspend_mask
and signal_mask fields. Rather than having two struct fields
that do very similar things, my guess is that we'll end up
with cleaner code if we just always store these masks as
target_sigset_t, and refactor the code that currently treats
them as being host sigset_t to treat them as target_sigset_t.
After all, the signal_mask field is supposed to be "the signal
mask as requested by the guest program", so target_sigset_t
is the more natural way to represent it.

thanks
-- PMM

