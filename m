Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01081C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 10:56:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C082C20748
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 10:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X1lNx6zS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C082C20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVZGj-0007V8-Cr
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 05:56:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iVZFs-0006rk-Af
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 05:55:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iVZFr-0005Eg-04
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 05:55:07 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36661)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iVZFq-0005Dp-QN
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 05:55:06 -0500
Received: by mail-ot1-x342.google.com with SMTP id f10so7673203oto.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 02:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=09TOp7134heN64Vxw3At/0t17JuHo3igHU2Vp1zZJf8=;
 b=X1lNx6zSXegDOdgxoak/QFKwWILljPqvetqrLagZ/aYQhySEAhCwr3bCeEQ3Gt5gjO
 S56phhIKgtVPndY0mKtUWAJ7hbn/Ggzm8kNvQ6TrquTh+73xfQkE142WyVFPt8JLb/qQ
 XaqtvLn5oVD5EugAQ0lh1m5XLwQKwfvETi1P6P18/tGoh241oqNkjuqJQ7wppsSOX/x0
 bG7V1sM6dxQx7HSpdJj/G/ALPVBPGJrOD3rNFk/fyuY9qp0cPGpF2UK1REBRONzUMcAl
 /U/n3I7ful5NyJWcHuE9V40vn4zkNqxg4e4XtyhxYz/HDCoVj12DRkAvW+Ww5Npr/JOz
 Rg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=09TOp7134heN64Vxw3At/0t17JuHo3igHU2Vp1zZJf8=;
 b=klVtNOnRvaYQYRTMFx+8AyJ/7/n0aR1+Y4k6ZHzt0R1YrJ1pYAxnODd2UBv7FNGMjJ
 PsOfu7d5NAnh+y9rKMFDbHfi1pJIyVOHlJzfOacZjcgob9fbP8B8MaKBO9Dj4b/thHY7
 GjtUlGY8BorQEfIaigU6r+GnbaWet5O/BM1iy/F86/Cy6sNkuiKL7Q0EPFOcV/RLv/Xn
 XbnXs3kMF5dwUGvJF6WTPbixbdzvjO5N/tvNM1Tdsw3esCSKc3hYWwwBNhEd7bv0wBYY
 AMo2gpsljsYG0Pm9Yr+CV17EqBAQPJUVMqC4AZz3JeEfzeeGeUVPdgkMASePjG670taA
 6Z0w==
X-Gm-Message-State: APjAAAUtf7KA5yacfqATUvwvue0Nv6r6FbnIBiAwPN/zAwUz1Vk2VHLD
 ltADQmD0TJ2wXjKgf3sHRVu4yg2gVaCvCKxAeWaamg==
X-Google-Smtp-Source: APXvYqzXCSUVVC0hlVtrUMLGKmZMEe3IAeu3vdANQYAefIon0JWNVK3Z0uQ2YLPhym8bymfRyovxwr4F4lArxx+PicQ=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr11307067otg.232.1573815305531; 
 Fri, 15 Nov 2019 02:55:05 -0800 (PST)
MIME-Version: 1.0
References: <89ada4b1-ee3d-a512-07c2-9bc1ba5806da@redhat.com>
 <20191024224622.12371-1-keithp@keithp.com> <8736fhm9tw.fsf@linaro.org>
 <87pnik4w9n.fsf@keithp.com>
 <CAFEAcA-g+RkvYjseDE=1Z=gnLum0Cjvn_7bqB3ti+cBq9UZ3Eg@mail.gmail.com>
 <87mudo4owu.fsf@keithp.com>
 <CAFEAcA-MRtr9WUpqqwJiX9kc+ybGdgfv7ZB5Tc6_q9xwHwebsQ@mail.gmail.com>
 <d4baa0c3-694a-293a-385a-b3eba7d52d0d@linaro.org> <87r22at7po.fsf@keithp.com>
In-Reply-To: <87r22at7po.fsf@keithp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Nov 2019 10:54:54 +0000
Message-ID: <CAFEAcA8FyDVOrJPYGKs_Lgq1oMHuVENu=ggJe69OugQvZRZ0cA@mail.gmail.com>
Subject: Re: [PATCH] Semihost SYS_READC implementation (v4)
To: Keith Packard <keithp@keithp.com>
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
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 Nov 2019 at 22:27, Keith Packard <keithp@keithp.com> wrote:
>
> Richard Henderson <richard.henderson@linaro.org> writes:
>
> > For semi-hosting, it seems even better if the semi-hosting syscall instruction
> > is not "real", because you're explicitly requesting services from "unreal"
> > hardware.  It should be specified to generate a SIGILL type of exception
> > anywhere semi-hosting is not enabled.
>
> In the QEMU case, yes, it's virtual hardware. However, the other common case
> for semihosting is when doing hardware bringup using JTAG or other
> remote debugging link -- having an instruction which safely traps to the
> debugger is required to make semihosting usable there. Reading through
> the history of the current RISC-V semihosting mechanism, there were many
> designs considered and rejected because they wouldn't work in the JTAG
> environment.
>
> > With that in mind, it may be simpler to handle all of this not in the
> > translator, but in the function that delivers the ebreak exception.  At that
> > point one can arrange to read memory without raising additional
> > exceptions.
>
> I'll go explore and see if I can figure any of this out.
>
> I'd still like to get the non-RISC-V SYS_READC patch landed someday :-)

It's on my queue to review if nobody else gets to it first, but since
we're in freeze right now it won't be landing til after the release
happens (expected mid-December).

thanks
-- PMM

