Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5C3C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:20:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E902146E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nbb602jL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E902146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhuM5-00080H-JO
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 07:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43190)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hhuIW-0006DT-W4
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:16:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hhuIT-0007kE-SP
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:16:35 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:46721)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hhuIL-0007Yi-Tw
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:16:32 -0400
Received: by mail-oi1-x241.google.com with SMTP id 65so9598658oid.13
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 04:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KIEmBy/a7wKzF0PB+2CHUobKrsso4Ohw1YI229nUZMY=;
 b=Nbb602jLHgTGXzNEPnD5fJRBtHJbhb8ijwCi7+vCT41sYFK3GnDV07qEvvWXuMLExL
 IoHjwYQAlvAR83ySz8GQXLRZjWmhVv+mW2L4lyCuRNHLGVwMKz/Nwgf98Ras0bhTHbwl
 5TV0xcPfTPYVkhLrSZtSzPc6a6IdGVfLscQiKsT+MuCJTmxbDkDvcUIf6lnQhHqvxIyT
 QMBPzdc+KCWGYzGACI5e43r0wXWuHydp3pmNTXE1+QqwS75YNMowPJAEeWjec5Xeb6og
 U2hM1eGO1cdBEzC+ctwYziR1ZugiHvdWmIoNdHxnN/tDrDkJcqSMhTX5kUVHEgo0q9z3
 iskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KIEmBy/a7wKzF0PB+2CHUobKrsso4Ohw1YI229nUZMY=;
 b=gP2n+i95/HKUEaXR+2rqWKia/4mofOupyRUkm7Tc7A5/yHqSUcFOXEJNJW0uSJzFba
 iYL0L6WEqz6syaDW9lQT+M/isRQNAB+kkw0o2IEKwPNMJjFkC2F+Z2ScDYAZ3SqdG7AJ
 79n1ojeeToJeiuvxPXp+BYJ4B/Qu0Q4bjc4hvSBB1T2I7VOSEyuhzrqLhFiAS3c5c1OL
 M+2PM72vPGFojCW1OS2RSkXbZnlMAsSzLvVD2Z/Gd0MSMNmxSkPwy3GjclVeG4kKFSxo
 hZUFeK3HqN58LBrrResKMyov7Z0Kh9AIwxvut4s0cP/Bv1rcOjJhT3Uon+7II99by2OB
 lm8Q==
X-Gm-Message-State: APjAAAVjCgXX+dclWySfWtnD4M4eY+QSs3DzE9Mt/c5K6AqD2XV1gpSS
 ilXLp6dWvZK0DXTCJBXT3pnZ9UbiMj9EdX19MDMzBw==
X-Google-Smtp-Source: APXvYqyoyWAaxrf0mb32O3eUx+swMA/3IwqkVoR21VI714hIoTJnOaoOApyLI5uFPkCrmTT6phJbYn+2G7EBQSRD9x0=
X-Received: by 2002:aca:6185:: with SMTP id v127mr6629275oib.163.1561979775599; 
 Mon, 01 Jul 2019 04:16:15 -0700 (PDT)
MIME-Version: 1.0
References: <fc5404f7-4d1d-c28f-6e48-d8799c82acc0@web.de>
In-Reply-To: <fc5404f7-4d1d-c28f-6e48-d8799c82acc0@web.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 12:16:04 +0100
Message-ID: <CAFEAcA_X2mQsRqtEOW4bUfsfY48niEG2yMu6aegrVf53GnV=eg@mail.gmail.com>
To: Jan Kiszka <jan.kiszka@web.de>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH] hw/arm/virt: Add support for Cortex-A7
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
Cc: qemu-arm <qemu-arm@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 30 Jun 2019 at 16:13, Jan Kiszka <jan.kiszka@web.de> wrote:
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> No reason to deny this type.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  hw/arm/virt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 431e2900fd..ed009fa447 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -176,6 +176,7 @@ static const int a15irqmap[] = {
>  };
>
>  static const char *valid_cpus[] = {
> +    ARM_CPU_TYPE_NAME("cortex-a7"),
>      ARM_CPU_TYPE_NAME("cortex-a15"),
>      ARM_CPU_TYPE_NAME("cortex-a53"),
>      ARM_CPU_TYPE_NAME("cortex-a57"),
> --



Applied to target-arm.next (with a commit message tweak
along the lines suggested by Philippe), thanks.

-- PMM

