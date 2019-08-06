Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E405C32751
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 10:01:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1F82216F4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 10:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A4bSsgDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F82216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huwHL-0002Lb-A6
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 06:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38627)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1huwGS-0001Ic-41
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 06:00:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1huwGQ-00080R-1G
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 06:00:19 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35883)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1huwGO-0007z2-00
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 06:00:16 -0400
Received: by mail-oi1-x242.google.com with SMTP id c15so10300175oic.3
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 03:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xQ9rvOA4yllu34jtpdFTkP3+LnU6bZ5qPXS670owBSU=;
 b=A4bSsgDwGdLXvvBrIrUF8zO060rddgpaM5bUEW4IZuraj7dpvhtesrdZ+nV31JXpYY
 9roDFpcintRFriFmq9zAtsQtyMjxG/Cpn9yW1+UXN1LSfOKdUTvNHiRyblSBSqdhUeGI
 bZi/sZEGXtANhbrNIum2mzG1nxXjd9NquOKWDvD5sSBjwsoVZPCTxYOqJJVt8KSho9gB
 Y7QlRSpPQKllkv8kNKAVrhjEfkN+YiiPAltBukPg+xgnofpExf1JEzCowpB47c/55TAL
 1ra1fX/BqB1CIwt9AZKZnhy3HIT1N5Ao5GY7FPORl6JqLy/yyKDqCbM5jyuEa+ztDFf7
 Tp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xQ9rvOA4yllu34jtpdFTkP3+LnU6bZ5qPXS670owBSU=;
 b=rOsy6QZ9pkp76khiak2QeeM7puGtLIJZupQT8NHWhzaIfvr8R4kKAhIg3xZ/eQHJ9m
 5z7nl/65mVtKZuDHG52ov7f2NRNTUVUdt9uAJqSYhQzfOW8TbNTstRSeFWKiW7IM0+sI
 AXcmVKIwkFcvWo+xCXmqVe6xWjIyTlZoqQRI2FO7Dyg8Br94TEMwQoTUNZv4oTLMcay3
 Wl1XxS+YBpjCOZe3Coxa7zKFtYKKL9m98THc7t7fSJwxGHFAfXU5mjOBGQAMTA0rqUKW
 ymHLzLE8QdeGW2C3rIwKvMHiTX6fM5YObu//RcUseGdRfVJaM4nOs0zFXd9CpZCCLtNs
 7Dfg==
X-Gm-Message-State: APjAAAUQtmNkTvTFKabf1c1Eb/EF1ZNjNfWObqwwEMnBFZfJvRzg6XOw
 PNxpRbu8lBdVgZXk+d9BiIyPlNTktuXsOWaraFHpyg==
X-Google-Smtp-Source: APXvYqw+2Uxt4JSnPwPPQlJ202JF81PmBI8uuAXbbcBcCVVdTrSqzJoKv5AGSXJvH5pdGgDtpOi6Jt7dIRxCI4kig+o=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr1073152oie.48.1565085613691; 
 Tue, 06 Aug 2019 03:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-7-richard.henderson@linaro.org>
 <CAFEAcA_kmuX6bxR50eU_3nTdRcjON2nVTqVWiRamSRe6jui3ig@mail.gmail.com>
 <09b930e2-0a92-25a3-4e26-8bea1f437039@linaro.org>
In-Reply-To: <09b930e2-0a92-25a3-4e26-8bea1f437039@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Aug 2019 11:00:03 +0100
Message-ID: <CAFEAcA9yQQSYnwEeSNbx4P94deuG5v5fKs7gW4VgG7LFzBX03w@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH 06/67] target/arm: Introduce pc_read
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jul 2019 at 01:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/29/19 7:05 AM, Peter Maydell wrote:
> > On Fri, 26 Jul 2019 at 18:50, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> We currently have 3 different ways of computing the architectural
> >> value of "PC" as seen in the ARM ARM.
> >>
> >> The value of s->pc has been incremented past the current insn,
> >> but that is all.  Thus for a32, PC = s->pc + 4; for t32, PC = s->pc;
> >> for t16, PC = s->pc + 2.  These differing computations make it
> >> impossible at present to unify the various code paths.
> >>
> >> Let s->pc_read hold the architectural value of PC for all cases.
> >>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >>  target/arm/translate.h | 10 ++++++++
> >>  target/arm/translate.c | 53 ++++++++++++++++++------------------------
> >>  2 files changed, 32 insertions(+), 31 deletions(-)
> >>
> >> diff --git a/target/arm/translate.h b/target/arm/translate.h
> >> index a20f6e2056..2dfdd8ca66 100644
> >> --- a/target/arm/translate.h
> >> +++ b/target/arm/translate.h
> >> @@ -9,7 +9,17 @@ typedef struct DisasContext {
> >>      DisasContextBase base;
> >>      const ARMISARegisters *isar;
> >>
> >> +    /*
> >> +     * Summary of the various values for "PC":
> >> +     * base.pc_next -- the start of the current insn
> >> +     * pc           -- the start of the next insn
> >
> > These are confusingly named -- logically "pc_next" ought to
> > be the PC of the next instruction and "pc" ought to be
> > that of the current one...
>
> Yes, well.  I don't quite remember why "pc_next" was chosen for this field.  It
> is the "next" upon entry to tr_foo_disas_insn().  Often the target will
> increment s->base.pc_next immediately, so it will also be the "next" insn
> throughout translation.  Though that isn't currently the case for ARM.
>
> Once most of the uses of s->pc get moved to s->pc_read, it might be reasonable
> to rename the remaining "s->base.pc_next" -> "s->pc_orig" and "s->pc" ->
> "s->base.pc_next".  Perhaps that would be clearer, I'm not sure.

Renaming pc_next would be a cross-target change, so let's put that
on the shelf for the moment. Maybe just put a TODO comment to the
effect that we could consider renaming in future ?

Or we could just copy s->base.pc_next into s->some_field_we_choose_the_name_of,
eating 8 unnecessary bytes in the DisasContext struct but giving us a more
uniform s->something for all of the different PC variants rather than
having one of them be in s->base.something.

thanks
-- PMM

