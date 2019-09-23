Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1627C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:41:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F03A20673
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BWDzQQ5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F03A20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCPXG-0007hX-Ke
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 10:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iCPVo-00061s-3t
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:40:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iCPVl-00067P-37
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:40:23 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45471)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iCPVh-00063F-VG
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:40:18 -0400
Received: by mail-ot1-x342.google.com with SMTP id 41so12274147oti.12
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 07:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=UVxDV1Cug82JTtKncFbLQTRFqJjzdFnWaiYFroc2csk=;
 b=BWDzQQ5J9U5xpnEso5tBguBnnCR940tCrymriZfiNmByk3neQK0MFOBy8WdocahyNo
 Yh88vGHZs+jOH4dmsQnjWPq3z0nZSv5HUruj+Y5ec/Vykp6wtKPqAW42aRmc9FGn3Gba
 brYan7pMbX18LGJ7AerWSP9l8bvd1uZLrX10QOs0HpgL9LTlCQVZu6TFiJCDss0Gvlcv
 +BwH+6Zgc1Jd0LeUxulMO3ZRUAqM/1dWxCf8a/2iWOEEzH0WOAyETAGC2gA+eG6IqMon
 Zp9GRaf9STu0Nx1R1tKOb5ISXveeE89eGj+4QGPBvzq/scE8IA3yuvKV28ADioiAG/Zi
 ddYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UVxDV1Cug82JTtKncFbLQTRFqJjzdFnWaiYFroc2csk=;
 b=lS77U1Y6t4Wi0iCtxrwbjfjcG+XIkF8Bfgzlqkqy4zH5OylDM9Fp/lALOZ4F6gnjGp
 FnPMxbLrDjyUBGU/aS4jlgFKtSvg2xlDn5cs/PvW79Ap4O6W3XL4rXKzPdQih27XdMzq
 K0O3Ptm76MCd87wf3Nl7s6b7xirvTuWIKPZphgdTqeOYQKLxC3bSx/o1kcRscH1+AmpD
 bUlz0gprUT1+RQUew/c6r2zsU2yTWvAPeqLCdNdSGz+FZx5jhC2mcJBTJHEqPMNgi3d+
 iuJ20LJQxui1GOylS76V/t2qIx2tHKl5VJwoikWRl2aGgZl6iohD/TRllGsjcO9fy99s
 EWKQ==
X-Gm-Message-State: APjAAAUiQ5h8VaFTcDVBCXked8ZP8zzjM0z2pDpl5BEKowAg5Yj5/XPQ
 f72du+UdSC/kkKTurBIS+5esBCV9rNFU/6xHudCY0g==
X-Google-Smtp-Source: APXvYqzVaBtiTn/cmdFjvhDcfZk9hpu5lzilSinhX9Xjh+7zUdMQGtwHbuFCAaWWZ4xfRBiUjkiSDBmr2dqSrhWKNXY=
X-Received: by 2002:a05:6830:1357:: with SMTP id
 r23mr106498otq.91.1569249615442; 
 Mon, 23 Sep 2019 07:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190921101703.17935-1-philmd@redhat.com>
In-Reply-To: <20190921101703.17935-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Sep 2019 15:40:04 +0100
Message-ID: <CAFEAcA8RfAPuV9LfL3c01KU+sCtAcWkHsLR7e-4QNJVcniq7Cg@mail.gmail.com>
Subject: Re: [PATCH] hw/ptimer: Assert next_event is newer than last_event
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Osipenko <digetx@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 21 Sep 2019 at 11:17, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> If the period is too big, the 'delta * period' product result
> might overflow, resulting in a negative number, then the
> next_event ends before the last_event. This is buggy, as there
> is no forward progress. Assert this can not happen.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/core/ptimer.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/core/ptimer.c b/hw/core/ptimer.c
> index d58e2dfdb0..88085d4c81 100644
> --- a/hw/core/ptimer.c
> +++ b/hw/core/ptimer.c
> @@ -125,6 +125,9 @@ static void ptimer_reload(ptimer_state *s, int delta_=
adjust)
>
>      s->last_event =3D s->next_event;
>      s->next_event =3D s->last_event + delta * period;
> +    /* Verify forward progress */
> +    g_assert(s->next_event > s->last_event);
> +
>      if (period_frac) {
>          s->next_event +=3D ((int64_t)period_frac * delta) >> 32;
>      }
> --

Can this only happen if a QEMU timer model using the ptimer
code has a bug, or is it guest-triggerable for some of our
timer models?

thanks
-- PMM

