Return-Path: <SRS0=g5aJ=2O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1F3C2D0C0
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 03:13:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7B5A206D3
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 03:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NafJITCS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B5A206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijadK-000346-PJ
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 22:13:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1ijacK-0002M2-Ah
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 22:12:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1ijacH-0003U9-4u
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 22:12:16 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41366)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1ijacG-0003Sv-To
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 22:12:13 -0500
Received: by mail-pf1-x444.google.com with SMTP id w62so10090435pfw.8
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 19:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5LaBGpXGL1WH0Aox8Wudf6UMqLO5RnVXNA74q4WbVGw=;
 b=NafJITCSXPRXhm0NUkg25SGYc1XFXG7hJ95BMmsLqBVc1IKT9JVlE1IG/sH2WgnvrM
 uo02D3pM9QUYGqP4mFZ4hdojYALhmyQuM8MW0FD/TL6xtm2/GEGlNiHZM9cUNODG+oEb
 y0WyYVodUP866TCnTE4tUNtCOGKCUaSdrx0816QDqguSk1ErtMczm5ZWQSz4uOIvuw2B
 OOD7/UVmO/zh8p0kv/ogbNQp3UzqmZiXrsAU+EKISPHzrbVkTvBOA/Pe/oAkUawodXvy
 uJOxUuYGv2YTFYH/01+AeEOMzW4iKFrEL38AANzypK1s4CSm/NdLK3WoKieqdQb3l3Bu
 OXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5LaBGpXGL1WH0Aox8Wudf6UMqLO5RnVXNA74q4WbVGw=;
 b=D0BqOsYcgtLoG+QzShH5bJjFMk+Hc1SpKpjH7gVfeGmP3+pm2fL60gnMjPXbaV3Vm1
 l88Gz6kSrVqp3vaFUxyp6X6Srbs7eVoKz91KZ/XTtknh0BJqZ3X/MAan0uHAVLs1vPHR
 rZ1hwTKyjhO2W+7g42dGeBp+0/uelOrMms3JubKDkx1Q16HNRtBtojeeyCuxEHEFdEIp
 tGUv75bIyoQcDgvnBn7xH6Z9VJPw3L0p2JY986tsZg41E6xppyKBfIh6oLFTrQJoLaF5
 ufh41QZhOUIeBfl5j0lHW7Ti7zB7qQC1OQirWmdtfaNXr9S/EdFOibGi/mD6xViV1978
 JOOg==
X-Gm-Message-State: APjAAAUdch47cdSaYyYvgG2aECHbSQSDWVK44Lwfh7z6pPmlTY1KVUI7
 WoZ8pV/hw+NSWeU/acGYx+jUzUMpIIukpuIBC2E=
X-Google-Smtp-Source: APXvYqz8jhRcycEQcT9gH05lg+O0LoWc+LCLA7g4Qr27J7njezzXM6o0EcfmkXk3ndWrxlsHPhlN3b4O7SW4Ax8Iv/k=
X-Received: by 2002:a63:5062:: with SMTP id q34mr22320059pgl.378.1577157131504; 
 Mon, 23 Dec 2019 19:12:11 -0800 (PST)
MIME-Version: 1.0
References: <1577155187-12622-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1577155187-12622-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1577155187-12622-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 23 Dec 2019 19:11:58 -0800
Message-ID: <CAMo8Bf+gYien0BWW8EmHNF1TXRoBuc=pOq8Qb5pBTspsnkeAYQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] linux-user: Fix some constants in termbits.h
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 23, 2019 at 6:45 PM Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Some constants were defined in terms of host, instead of target,
> as they should be.
>
> Some additional trivial changes in this patch were forced by
> checkpatch.pl.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
[...]
> index d1e09e6..b1853f0 100644
> --- a/linux-user/xtensa/termbits.h
> +++ b/linux-user/xtensa/termbits.h
[...]
> @@ -286,43 +286,61 @@ struct target_ktermios {
[...]
> -#define TARGET_TIOCMIWAIT  _IO('T', 92) /* wait for a change on serial input line(s) */
> -#define TARGET_TIOCGICOUNT 0x545D  /* read serial port inline interrupt counts */
> +/* wait for a change on serial input line(s) */
> +#define TARGET_TIOCMIWAIT  _IO('T', 92)

This one should also be TARGET_IO, right?

> +/* read serial port inline interrupt counts */
> +#define TARGET_TIOCGICOUNT 0x545D
>  #endif /* XTENSA_TERMBITS_H */

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max

