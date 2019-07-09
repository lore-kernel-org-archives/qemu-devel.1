Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE8CC73C46
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 17:01:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 590BA2082A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 17:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pq3CAL2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 590BA2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hktUZ-0000Vz-MX
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 13:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46285)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1hktSG-0007VC-0S
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 12:59:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1hktSE-0000kv-R1
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 12:58:59 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:41421)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lucienmp.qemu@gmail.com>)
 id 1hktSE-0000hm-1g
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 12:58:58 -0400
Received: by mail-qk1-x742.google.com with SMTP id v22so16555139qkj.8
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 09:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HPQ1tvy+lFmiR442HCJw9Ev+cSVFjJw7MuU1lWnI/nY=;
 b=Pq3CAL2YhhehKuhfKMRb/CIZbj1s5j+2Y5bYmIoQyq8ZxpozyQmq7Hhjqg2xLt5lwY
 6tinbflSpoHECKZfzR1G5nrbiFFnrh0/ViOXlCBJqxvHKiMxxYXP6IIAXJm/kH1kNEMp
 E/R09tMDlCsqOL1B7fZug/7g2+CrUP+IggOlber29PXrYBwbSapLtUBE3ur7k9GkziSn
 WGlMWHMRxBqUGlcXV8kff69KVCY5qJbAXzJzCW/Ty5aUiekcaW3kuq1mf+KYa1lvtoHq
 2EB1A1ICZ1HuewOogeJ/bYnf+57jq7Hdv4egnE5KK7u3SDQFBW2g6DUUHOJstu9jTWpd
 xV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HPQ1tvy+lFmiR442HCJw9Ev+cSVFjJw7MuU1lWnI/nY=;
 b=P+YUjTmIccM9iTurhA0SGspAQZxSVoQOvtMHD/EqO0VycKmoTP475hstaFfzm4Rg9f
 LbB80niNNbV3zE1fvD2nYINpLE9409WLpvPc5GWWE/bu2Wq8iktZzQvc6FPoswzL46+n
 FMaIGWsIXdHFCbJIHNHID6cAJrrpIWODBTZCq326kq0ve1oG/kzCqXgwKOFIHByiKqLS
 q+veA/z0RJ1xQxJktb6DPtSZNfUBRutqYLirmktvRqxOmDzkHI3pZSyCF4ImDK8q/MRN
 hxL4jDwyxzF2AstK4EhDqv9fLJTX1ByQveVCnJXjNKjrWso/QIEtYf+NWFNpI3vEBqxh
 KnQg==
X-Gm-Message-State: APjAAAVDUgWWqA9dtT8/1V7m66y/wDtwAIh1N9F8eUcWhvVMkq3Fpzo3
 LNRgKlMLsQk268HQI7onQ3wXEnEAmk/M83fXQ4U=
X-Google-Smtp-Source: APXvYqz/GDwLrcPehHkWu2lcRJe+VpMo6oixaTM2cTp9s1nKwJV73ZbRmA1hTOfnd2CY5yZAcSEwilCXK4YHs0zzlBY=
X-Received: by 2002:a05:620a:4:: with SMTP id
 j4mr19561311qki.269.1562691535245; 
 Tue, 09 Jul 2019 09:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <2136180936.260219.1561641583358.ref@mail.yahoo.com>
 <2136180936.260219.1561641583358@mail.yahoo.com>
 <1079763171.281101.1561641752988@mail.yahoo.com>
 <e4c1fbc4-3e43-5df4-a17c-527d98d9763c@linaro.org>
 <20190628002713.GA19257@localhost.localdomain>
 <eadb57ae-256d-0bb7-5988-f493662a5caf@linaro.org>
 <20190628155030.GA34320@localhost.localdomain>
 <ea16a81c-5b94-8dd0-8339-2bd82733aed2@linaro.org>
 <20190629163621.GA111724@localhost.localdomain>
 <CAFEAcA9sfNisAz-zAZAx=ZNFmsEpP0Ec2DeRedtZSd9KQ4fvNA@mail.gmail.com>
 <1399218244.1210557.1561982640362@mail.yahoo.com>
 <CAFEAcA-0vGg_1nfkbq+o6JwoDsRyP=6mnv6ADi-atV0ROX269Q@mail.gmail.com>
In-Reply-To: <CAFEAcA-0vGg_1nfkbq+o6JwoDsRyP=6mnv6ADi-atV0ROX269Q@mail.gmail.com>
From: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Date: Wed, 10 Jul 2019 01:58:40 +0900
Message-ID: <CALvKS=GvAkNr3OKZzjGoTGG_Eys76zjcjodiN4hKXjFM5B0a4A@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] RFC: Why does target/m68k RTE insn. use
 gen_exception
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
Cc: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 1, 2019 at 9:11 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> > On Mon, 1 Jul 2019 at 13:04, Lucien Anti-Spam
> > <lucienmp_antispam@yahoo.com> wrote:
> > > Further to my initial problem I noticed that TRAP #0 also jumps to the
> handlers +1 instruction.
> > > Same behavior can also be seen with ARM "SWI #0".    (PC shows 0x0C vs
> the expected 0x08)
> >
> > Yes, that's a known bug for arm -- we treat "single step" as
> > "execute one instruction", whereas I think most debuggers will
> > treat "we took an exception" as a reason to stop the single step
> > and return control to the user, rather than executing the insn at
> > the exception entry point as the one instruction of the step.
> > (You can see similar odd behaviour if you try to single step a
> > load instruction which causes a data abort, for instance -- on
> > arm at least we will execute the first insn of the data abort
> > handler before completing the step.)
> > thanks
> > -- PMM
>

As recommended in the previous email this is fixable with a call to handle
debug
when were in single step -  I will submit that patch if nobody else it
working on this?

I also then found the m68k stack frame is fouled for 68010/68020 (wrong
frame type,
and it does not honor the special status word aka SSW).

In real hardware the handler code should alter the stack frame chaning the
SSW.
RTE should then start/or-not-start the "pipeline" again from the setting in
the SSW.
This allows for stage B/C stage re-runs, thus a retry on the read
instruction.
I suspect it will keep looping, and retrying until the exception handler
decides to turn
off the rerun.

I am thinking the easiest method would be to check the re-run bits in the
SSW and
jump back to next_pc instead of pc inside the RTE instruction handler.

Any suggestions on how to obtain pc_next from the "m68k_cpu_do_interrupt(
CPUState *cs)" ?

What do we think of this approach?

Cheers,
Luc
