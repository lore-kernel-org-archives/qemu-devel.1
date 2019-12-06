Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1270C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:43:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C429A24659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TIJjl7l4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C429A24659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idHdB-0001fA-HN
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:43:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idFvp-00020V-NL
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:54:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idFvo-0002B3-Kz
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:54:13 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46965)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idFvn-00028B-Sn
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:54:12 -0500
Received: by mail-ot1-x342.google.com with SMTP id g18so6123873otj.13
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 07:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HUOLuW+zu4328K45DYw3MAO8g0DCgH1gMC748CA4RxA=;
 b=TIJjl7l47+Tl31lXCp0KNirwrfa6Z8rLNGjtCSay+YUchqumk8gwZ/egGJFNB3uc81
 TtlFzjhW+zfvQz38VOm/BU87P5K0FCsZHfwzP0yyi0welz++Q+W4vQum+2hfdendDxhZ
 1iEmSBWo73JH9PQOKBC7mSPFnl6XpsqJ88d0NBlHujSwq+LtwNyBwHa3PHVrPZ34D4w1
 Hx3EpusmjWrDu89gdYTiIReZT0IozxB/PaGwdEG/GT9sW/RgBs7g8+uPoVXQ4A1q0VmF
 1gjFZ1hg1+GsOYK0F8EqCnKhYos/qKHk6Z6tt6JiowO1SliuPVfNlzaYBWbmTmr9bFSi
 1GpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HUOLuW+zu4328K45DYw3MAO8g0DCgH1gMC748CA4RxA=;
 b=rh2oP+acKyeMEtydF2mdTEtyR+ul+sMSyw+ILWTINRkY5dtQ1fZJRdb4BLH6DgIex5
 /r7P0/KamOCK58deA2dxisqRSfUltU7xFkjWdNKHvbNJNB73E54de1AzWsBiOg7Gy41k
 XVCeKQte+Jmc27LhtFcZXYscc7Fo0OMhyXmHZzh28lUdeg5wZUus7xPrZfigkZ71sb2i
 IhjqdnAMoGlkZVkm1KASazczXWR6/YWGuF5j1SaZo+dpAECpQyyN4ICZd2PHyJAFcLwh
 i4LCZSINfXhr7cr0JlWM15ywqdysejls2QkT8mWdGXJ7zX7cX3v2m1jZEj0BiNvRKHbB
 ISYA==
X-Gm-Message-State: APjAAAWTfs2TNCLubFhaZosRuf8AwyrOhpuRLy0f2Si0PS04iLi3TS7w
 P4rjLjnjTdMHhv2VJRk9bvYH8s++oMyuM4XvySuSAg==
X-Google-Smtp-Source: APXvYqw4miWAQlSN/lwiI8Zk0E/BagNzTYExH6TesvElV4ZqWMvvrqkpgRes4Amt+XHgYjbEDA2KHqgCiWNkRqOCMYw=
X-Received: by 2002:a9d:6745:: with SMTP id w5mr11001009otm.221.1575647649875; 
 Fri, 06 Dec 2019 07:54:09 -0800 (PST)
MIME-Version: 1.0
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-27-richard.henderson@linaro.org>
In-Reply-To: <20191203022937.1474-27-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 15:53:59 +0000
Message-ID: <CAFEAcA-POh-Jt=G-QQ=WtMoU-j0kwrpbPUaVGwtVzrFbGw4AiQ@mail.gmail.com>
Subject: Re: [PATCH v4 26/40] target/arm: Update
 define_one_arm_cp_reg_with_opaque for VHE
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Dec 2019 at 02:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> For ARMv8.1, op1 == 5 is reserved for EL2 aliases of
> EL1 and EL0 registers.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 023b8963cf..1812588fa1 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -7437,13 +7437,10 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
>              mask = PL0_RW;
>              break;
>          case 4:
> +        case 5:
>              /* min_EL EL2 */
>              mask = PL2_RW;
>              break;
> -        case 5:
> -            /* unallocated encoding, so not possible */
> -            assert(false);
> -            break;
>          case 6:
>              /* min_EL EL3 */
>              mask = PL3_RW;
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

