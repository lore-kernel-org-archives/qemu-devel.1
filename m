Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4D0C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 18:59:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AFFD20782
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 18:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QW3yJlvw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFFD20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQbdD-0001oO-IZ
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 14:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48874 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQbbM-0000Sd-EI
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 14:57:04 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQbbL-0002nQ-Pt
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 14:57:04 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34798)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jQbbL-0002kh-DZ
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 14:57:03 -0400
Received: by mail-oi1-x242.google.com with SMTP id x10so9817353oie.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 11:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FwdtcY/OesG4oSj/zJtTRxqrBcLfAQ4ulJLT1GwnR8g=;
 b=QW3yJlvwmiwJnZ+crNUMFBkwD0DPwbsmvMJhK1yKa8Uc5EAePHfLvz7PJmL+4CyW/X
 wdmDyWAH3EAJGhSHxYIrA0P+g6Jq2eLhgzjmfzn01xOzrMvgCnW5wFkNTMopRodR8UTH
 WllCnEZqahExS3YEioNYwH7WiMH7BDy2CG+k2MlKkXNLNoUREfaGIrssl/yV+Ljr1OZD
 fAetNCr892/2XtpTyOkYhsevd6pzZqcjcdJFKAZ/a4QF9OFQoOCQ4byPeQODHIkFRFX1
 5o4IUAOqQmy6oC8iyTeXhPFKaJ+RrYr2rvBcKQVpqMawuiC0lUHtOSzSPv9p9JIs48NH
 2zKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FwdtcY/OesG4oSj/zJtTRxqrBcLfAQ4ulJLT1GwnR8g=;
 b=MkMyzD72RJMYvmhhEs6cQpXY15iilC0hZ3NtrdxRMzbg0kNuXtptd3OtiOIaCjv2Iw
 cZV8pRK8Vrd7RXcZ9HI7hM3BrZs7nbJxwyRsA59sOsGrhU2L56BPqfFRcWGEzhHu0XCM
 zEv1Syf6B/6aOdZMStRdat1JB1eDQ+NyoERWeGpsx1OZkvNq0UKyjIxWb2CcYgbEMglZ
 94vCQyoekXnz9uvTCVbtmgsqKzdY+TZAfKjSJy/MzOTR2frmWrAun2MI0su0cen7G26e
 HhivnZSZPKSMTmd0cdesrOOU41+IynvzOMgQKZXXuaXlN86RKtoSBLbNU9MoCuvv2Zgb
 /32w==
X-Gm-Message-State: AGi0PubfOsDwcUt63/dGADOfhxDT/0cr+uCuC679aHlNWClZz4sccWEr
 bGAzP3/KViUWqn6uO8iV3wnjyOxlGUiQKAhssHgyqQ==
X-Google-Smtp-Source: APiQypLCpHeT04aFu+6RBFrhpvdzxBnfhZSto4lArI2iYsoK2G4l7eP8sVqlBi/ffVJ2FfcnzuAa0xHdylojiQ4HAGA=
X-Received: by 2002:aca:c751:: with SMTP id x78mr614332oif.163.1587409021756; 
 Mon, 20 Apr 2020 11:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200417090749.14310-1-f4bug@amsat.org>
In-Reply-To: <20200417090749.14310-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Apr 2020 19:56:50 +0100
Message-ID: <CAFEAcA-aj77=19d+8jmoWYXBDdm=U8eV8CsHpovMN8bE9uNSvg@mail.gmail.com>
Subject: Re: [PATCH-for-5.0?] target/ppc: Fix TCG temporary leaks in
 gen_slbia()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Dennis Clarke <dclarke@blastwave.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Apr 2020 at 10:08, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> This fixes:
>
>   $ qemu-system-ppc64 \
>   -machine pseries-4.1 -cpu power9 \
>   -smp 4 -m 12G -accel tcg ...
>   ...
>   Quiescing Open Firmware ...
>   Booting Linux via __start() @ 0x0000000002000000 ...
>   Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
>   Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
>   Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
>
> [*] https://www.mail-archive.com/qemu-discuss@nongnu.org/msg05400.html
>
> Fixes: 0418bf78fe8 ("Fix ISA v3.0 (POWER9) slbia implementation")
> Reported-by: Dennis Clarke <dclarke@blastwave.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

I propose to apply this patch for 5.0 rc4 (as well as the
ppc pullreq already sent), since the iscsi bugfix means
we need an rc4 anyway. Any objections?

thanks
-- PMM

