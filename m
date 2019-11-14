Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F37C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 15:48:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C5020637
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 15:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYYzdD1e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C5020637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVHLq-0001Zd-Od
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 10:48:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iVHKa-0000yc-BM
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 10:46:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iVHKY-00020M-QF
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 10:46:48 -0500
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:45044)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iVHKY-0001zo-Io
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 10:46:46 -0500
Received: by mail-lf1-x143.google.com with SMTP id z188so5408500lfa.11
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 07:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=flo/gWsBAXL6Ml7UdRwcwagXiQJH9IDJFtlGIABhEX4=;
 b=dYYzdD1eYjG5/jzb+HlxN5P4GUkf9wtozhMqmf0Ctk844o3bsc0zKKoGMmfLcY6PMy
 +jIdzYmerkJ2oF8ZQdW8Pdb4+6LxgzGxj/c5/tpiWLlDV+5eceBE0XF3dT7qsrTyG9rq
 eNIZGCOJzRkPjH9ZgTc5G1EvMCXhQnDkb7TYYaaThmxbHKCkCg9xeEW+228vbASCHd/A
 gxt58wjwWehVh1nfN+2rDpJN4iL7FMSiHG1O/Lou7iRznFXio1jGKP9kSTlTAdSTt+am
 +tSbJ4pi/B7mgK4rnn8iCeiWvjcfD2nj9q1FjexRmeyA3wLcBIrzAmg25WGvEzf+4ve7
 Bv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=flo/gWsBAXL6Ml7UdRwcwagXiQJH9IDJFtlGIABhEX4=;
 b=HmVIZlDXgCgtPLNb1t02dzo0hJB0r/puvjivl2dlvNgjOQi12qoBMsLKncabM38+zm
 3H3F1fl7hbNHSrlF9DfeN/9lHomIrnvM0b1k9l91ay93JtbsBzl+IXcg2BoxDbyObrxk
 aNAhtj1IsT1xmg3tFTvXR9CE53MINlGyg537SvsDFx/7UTwwGcY7k2Fd47Al9kpgrJAh
 hZKCc2/3f7WP39qfxl1s5e1vc7J/tJNgKqGChrS6gz5wb3gUHXuJZL0r+DafsmT5RJ5V
 VLyDjVrIp8q6fhQ6mKc2vmBEpWIZztIbcuYHevd4aJNO+ZRGrh8RDLDcFWo6YSEvYANy
 rfgw==
X-Gm-Message-State: APjAAAU8+oI8tnfcx3ot84H4RlU6Sya3e0YxIvM0LWUZ17uWj6P+uRqu
 CkHkbk/Z8Ed9EoipQSav/sKcnRFxixudMlOBGBk=
X-Google-Smtp-Source: APXvYqw9SFyFHFKDQDMtIphlbvJVoWX1Khw5QK4jQO1LEB3RPIfoEZiNKsf4kcrWoOzFmYaSyAjHbtd90CF8U5d+JTM=
X-Received: by 2002:ac2:4a8f:: with SMTP id l15mr7176903lfp.5.1573746404684;
 Thu, 14 Nov 2019 07:46:44 -0800 (PST)
MIME-Version: 1.0
References: <89ada4b1-ee3d-a512-07c2-9bc1ba5806da@redhat.com>
 <20191024224622.12371-1-keithp@keithp.com> <8736fhm9tw.fsf@linaro.org>
 <87pnik4w9n.fsf@keithp.com>
 <CAFEAcA-g+RkvYjseDE=1Z=gnLum0Cjvn_7bqB3ti+cBq9UZ3Eg@mail.gmail.com>
 <87mudo4owu.fsf@keithp.com>
 <CAFEAcA-nnkHuj4y8+vFu5=virUoxwarg=kqQvUWeN73SDs+TzA@mail.gmail.com>
 <87eeymx603.fsf@keithp.com>
 <CAFEAcA9rSS8jwSOSFjHd7GZ0gNywEDDJPBJhJ4FxhyqqtjU6OQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9rSS8jwSOSFjHd7GZ0gNywEDDJPBJhJ4FxhyqqtjU6OQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 14 Nov 2019 07:46:16 -0800
Message-ID: <CAKmqyKNneo1NOn=mPmFmE-AxiaJPC2oiykZsW49Soiy=1aW__g@mail.gmail.com>
Subject: Re: [PATCH] Semihost SYS_READC implementation (v4)
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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
Cc: Atish Patra <Atish.Patra@wdc.com>, Keith Packard <keithp@keithp.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 11, 2019 at 6:51 AM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> On Tue, 5 Nov 2019 at 05:10, Keith Packard <keithp@keithp.com> wrote:
> >
> > Peter Maydell <peter.maydell@linaro.org> writes:
> >
> > > I'm going to push for somebody actually writing out a
> > > document and putting it somewhere that we can point to
> > > and say "that's the authoritative spec", please...
> > > it doesn't have to be a big formal thing, but I do
> > > think you want it written down, because the whole point
> > > is for multiple implementations and users to interoperate.
> >
> > That happened in June -- I was just looking at the wrong version of the
> > spec. In the current version, which can be found here:
> >
> >         https://riscv.org/specifications/
> >
> >                    The RISC-V Instruction Set Manual
> >                        Volume I: Unprivileged ISA
> >                 Document Version 20190608-Base-Ratified
> >
> > Section 2.8 says:
> >
> >         Another use of EBREAK is to support =E2=80=9Csemihosting=E2=80=
=9D, where the
> >         execution environment includes a debugger that can provide
> >         services over an alternate system call interface built around
> >         the EBREAK instruction.  Because the RISC-V base ISA does not
> >         provide more than one EBREAK instruction, RISC-V semihosting
> >         uses a special sequence of instructions to distinguish a
> >         semihosting EBREAK from a debugger inserted EBREAK.
> >
> >                 slli x0, x0, 0x1f   # Entry NOP
> >                 ebreak              # Break to debugger
> >                 srai x0, x0, 7      # NOP encoding the semihosting call=
 number 7
> >
> >         Note that these three instructions must be 32-bit-wide
> >         instructions, i.e., they mustn=E2=80=99t be among the compresse=
d 16-bit
> >         instructions described in Chapter 16.
> >
> >         The shift NOP instructions are still considered available for
> >         use as HINTS.
> >
> >         Semihosting is a form of service call and would be more
> >         naturally encoded as an ECALL using an existing ABI, but this
> >         would require the debugger to be able to intercept ECALLs, whic=
h
> >         is a newer addition to the debug standard.  We intend to move
> >         over to using ECALLs with a standard ABI, in which case,
> >         semihosting can share a service ABI with an existing standard.
> >
> >         We note that ARM processors have also moved to using SVC instea=
d
> >         of BKPT for semihosting calls in newer designs.
>
> That defines the instruction sequence used to make a semihosting
> call, but not the specification of what the calls are:
>  * what call numbers perform which functions
>  * how arguments are passed to the call (registers? parameter
>    blocks in memory? other?)
>  * the semantics of each function supported (number of arguments,
>    behaviour, error handling)
>
> That's really what I had in mind by the overall semihosting spec.

This sounds like something that the platform spec should contain.

+Atish +Palmer who are in charge of that.

@Keith maybe you should contact the platform spec group and ask them
to look into this?

Alistair

>
> PS: the parenthetical about ARM semihosting at the bottom  of
> the text you quote is wrong, incidentally. The traditional insn
> for semihosting on A-profile devices has always been SWI/SVC; it
> is BKPT only on M-profile devices; and the latest revision of the
> semihosting spec recommends the HLT instruction for both A- and M-.
>
> thanks
> -- PMM
>

