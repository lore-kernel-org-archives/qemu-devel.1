Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD21C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:30:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AC8B206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HFQofOd6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC8B206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQpF4-0008FY-Pr
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 05:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQpE6-0007cT-7o
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:29:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQpE5-0008U3-94
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:29:57 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37457)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jQpE4-0008Rz-Kp
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:29:56 -0400
Received: by mail-ot1-x341.google.com with SMTP id z17so10688676oto.4
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 02:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=DvbImwBCmjL9YBG1K4U5Q4Z/o1+AmCPlVgcclZu5s/k=;
 b=HFQofOd6+iOdst7T90a/Xf8A9dmYSUP/Is+CQ8a+t2MijuxcUY349JC1cDTpZINa0B
 f6yQipKIhTLEkK9giBRrkqe+xCpq/OL6nUDNkGoAh1O0Ej0ImP9TxPhmmhd0fgipr1Sm
 3qSj5SAVumfRpeng6OWitYcNtZY/xoAuMj3klwSY4ax9JYVFBe5052/ZTnbv6LtBu7tB
 fMXHau7Fbe5Zi9znXYeV/q9cZdq/IDp9iPCVgfHoTkopkT7P/ziYL21lipQNCB86LgVx
 Uo8qtdRKsi/bXYTuIC87CtXixb9ogdlk1mfL/PkpZBW9/8e5VOSYkt1qsngu+6Hh+uSh
 W9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=DvbImwBCmjL9YBG1K4U5Q4Z/o1+AmCPlVgcclZu5s/k=;
 b=KoA9B6XkEVFu3XHezfqoGgxrIsmmW3LG8euehx+n8E1cKTzm0ixF3Iy2rzcKDRSpt4
 +xKYUncjexwk6JpWoII8YAuuyR+CsEziUJMfZUJ17csSvIx8z0c00xV9puLI6uNwnPhT
 dVPH5m+TTM3+5WpUNAkvgbhcivitF0XXK7xoxy5oPnSv+4PfBrW1tGtgva7eH6Bmu/wb
 sJKqIHXuD5h0fYRWycVlyvvAWpTEkwWxYyZBsHhsHGTUwHhLswIuRaGoO6VZraIJH16C
 LRZZWY+pIjEcJCw10uZoeImfE+Kfl7FXowF4B4v9YRVEU5PT9QkCK0eIUfW5OtVf91zn
 ULOw==
X-Gm-Message-State: AGi0PuYxPnUR9iDSizFpLUHmRZVquLLUvuY66ZXEPWwXVS1xB4Y0ouin
 RadgQY/7rkwH+zhE3Yhlbe+AJnivo0fOPAjn/BbCzg==
X-Google-Smtp-Source: APiQypLrOhpuxWUFdaH7uu9y81bdrEvEg+tIj98mNIo5N1WQm20Tss+zDZYQliB5875PNWDNqjSF6G9U6ZbuugD6LhU=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr12686017otj.91.1587461395092; 
 Tue, 21 Apr 2020 02:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200417090749.14310-1-f4bug@amsat.org>
 <CAFEAcA-aj77=19d+8jmoWYXBDdm=U8eV8CsHpovMN8bE9uNSvg@mail.gmail.com>
 <20200421003136.GA52174@umbus.fritz.box>
In-Reply-To: <20200421003136.GA52174@umbus.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Apr 2020 10:29:43 +0100
Message-ID: <CAFEAcA_=+sS7j79+SvpHQ05e9bWjJLXtxerVO=DMC2Ja5igUjQ@mail.gmail.com>
Subject: Re: [PATCH-for-5.0?] target/ppc: Fix TCG temporary leaks in
 gen_slbia()
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::341
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Nicholas Piggin <npiggin@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Dennis Clarke <dclarke@blastwave.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Apr 2020 at 01:39, David Gibson <david@gibson.dropbear.id.au> wr=
ote:
>
> On Mon, Apr 20, 2020 at 07:56:50PM +0100, Peter Maydell wrote:
> > On Fri, 17 Apr 2020 at 10:08, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org> wrote:
> > >
> > > This fixes:
> > >
> > >   $ qemu-system-ppc64 \
> > >   -machine pseries-4.1 -cpu power9 \
> > >   -smp 4 -m 12G -accel tcg ...
> > >   ...
> > >   Quiescing Open Firmware ...
> > >   Booting Linux via __start() @ 0x0000000002000000 ...
> > >   Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
> > >   Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
> > >   Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
> > >
> > > [*] https://www.mail-archive.com/qemu-discuss@nongnu.org/msg05400.htm=
l
> > >
> > > Fixes: 0418bf78fe8 ("Fix ISA v3.0 (POWER9) slbia implementation")
> > > Reported-by: Dennis Clarke <dclarke@blastwave.org>
> > > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >
> > I propose to apply this patch for 5.0 rc4 (as well as the
> > ppc pullreq already sent), since the iscsi bugfix means
> > we need an rc4 anyway. Any objections?
>
> Works for me.


Applied to master, thanks.

-- PMM

