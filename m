Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2645CC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:28:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9AAA206A2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ohk9nY15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9AAA206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhyS8-0003yo-7I
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 11:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39158)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hhyBE-0002P1-QA
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:25:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hhyBD-0006Qy-Qv
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:25:20 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40765)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hhyBD-0006Px-Ej
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:25:19 -0400
Received: by mail-ot1-x343.google.com with SMTP id e8so13856548otl.7
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 08:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=J5jnrBC9B7cp43w6ntAwQwU4yHdDx/YqgFts1lQu7Uo=;
 b=Ohk9nY154Yem1mRA47Lb5WWFoOrU6Ba3968gI6L278x7B5TLWmAxQNX2j6AnxaGph1
 ox6OqEldxnjaPawZpMQE+eusDveCeEL/gQv5DmthLfjeAD0R7JYh5M51ag7elgRQDOhj
 Zh3ZvNKpya3Ec4b+Je+Hgra5sRFacpBU9Ccz1sGkHEbSFFafIuqdXUXUCGZ8RimnGGtP
 l4sI0z0qG3okgdihVYGhL9J/J4C5V1n18q0j+Axc4YGdB0LjWuq4MWTEu3Kos1QNNwnc
 xfJxWxc7l6DzStnPbLmhDuaXhRjlQl/tdvje++Dxu8YvZZGH21pV2GyUsDq4R2EdWqWp
 +0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=J5jnrBC9B7cp43w6ntAwQwU4yHdDx/YqgFts1lQu7Uo=;
 b=WcwLIPGmFXB8UwKyTXrNTn9OmoiyF6Pw5RJs/Rm8PGXNwwzOQqMwHdnyfQVLF9ujK3
 7LPSpZrP8MkhBPPtJS8UJU/g0Vy0FMgGbtw1DEAO4f7WxQtkEdn69HCS8Lyj0pxDd/Mz
 2qeGGrXFfUZfsOQq3ePLlVhERhQvX7QYbo5eslaAtUkbx5OBd4ic6i7nNlTc5WPgl+XT
 BOQf4cfXDpP9OZ8GZsYO4wACpvwN43F9YDAdoAzBxrKGnc6k01Ix+OSo4f5G58ONR+Bi
 TMb2va9hrVkNDMzh0/QZcqYy6gy761h17x9djIYMUsRgA/KVH3M0MyEXh0FJn9JHDVGB
 ys2Q==
X-Gm-Message-State: APjAAAW8+5azxsHk9vcZI9yymmUUoPP8MoASqoCB4fUx+nxC8sXCMZLU
 vQRJXklr6QBrKtaJ7DiP1LF2+Ar4YQhpz86VBL+kDg==
X-Google-Smtp-Source: APXvYqwBDvgV0wSok7dNdW22AVjUeonoxb/GklKK6myUa7/jS2k5VHGs+XQETEZz0CEFfeiVG4Ki/qpApmJ37G8jyqI=
X-Received: by 2002:a9d:7245:: with SMTP id a5mr21015232otk.232.1561994716772; 
 Mon, 01 Jul 2019 08:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190701132516.26392-1-philmd@redhat.com>
 <20190701132516.26392-19-philmd@redhat.com>
In-Reply-To: <20190701132516.26392-19-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 16:25:05 +0100
Message-ID: <CAFEAcA_XGuB5x+m5zmdBSE3bQP=jBdfWDzj_v0iBeqWmrETsng@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v3 18/27] target/arm: Restrict semi-hosting
 to TCG
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
Cc: Yang Zhong <yang.zhong@intel.com>, Andrew Jones <drjones@redhat.com>,
 Samuel Ortiz <sameo@linux.intel.com>, Rob Bradford <robert.bradford@intel.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 1 Jul 2019 at 14:26, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> Per Peter Maydell:
>
>   Semihosting hooks either SVC or HLT instructions, and inside KVM
>   both of those go to EL1, ie to the guest, and can't be trapped to
>   KVM.
>
> Let check_for_semihosting() return False when not running on TCG.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v3: inline call to g_assert_not_reached if !TCG
> ---
>  target/arm/Makefile.objs | 2 +-
>  target/arm/cpu.h         | 7 +++++++
>  target/arm/helper.c      | 4 +++-
>  3 files changed, 11 insertions(+), 2 deletions(-)

> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 49a0f05cd1..1b4da7aa45 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -20,7 +20,6 @@
>  #include "qemu/qemu-print.h"
>  #include "exec/exec-all.h"
>  #include "exec/cpu_ldst.h"
> -#include "arm_ldst.h"
>  #include <zlib.h> /* For crc32 */
>  #include "hw/semihosting/semihost.h"
>  #include "sysemu/cpus.h"
> @@ -29,6 +28,9 @@
>  #include "qapi/qapi-commands-target.h"
>  #include "qapi/error.h"
>  #include "qemu/guest-random.h"
> +#ifdef CONFIG_TCG
> +#include "arm_ldst.h"
> +#endif

Should this ifdeffing of the arm_ldst.h include have gone in
another patch? It doesn't seem related to the change described
in the commit message.

thanks
-- PMM

