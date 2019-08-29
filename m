Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB13C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 21:57:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB80208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 21:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8c5ZGCT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB80208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3SPe-00087j-TC
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 17:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i3SNh-000796-PB
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 17:55:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i3SNf-00085S-W6
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 17:55:01 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:33422)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i3SNf-00080N-1i; Thu, 29 Aug 2019 17:54:59 -0400
Received: by mail-lj1-x242.google.com with SMTP id z17so4566211ljz.0;
 Thu, 29 Aug 2019 14:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xUhUxvH8j7S1GaBgnx3mWeabAqeuaOCZf4HQzE88eIs=;
 b=Q8c5ZGCTb7aw527ePupYWKtOpvgmK3Dhkyeeamp9ol8PxvAyF0Q3jGFjy8TQtzKEhj
 7fil65sa2+2q8MAp4Qdo629GZQiLcwJX5lBC/btVIw1Qa3SzuwftOS8j1aen/NnV+0/E
 oq6+7b6extqITTPEwRDIzOcnAI6mQk3Yjj8HPBvMudn+Waan9yKCj7vpAWeHLvUNLgm3
 VIjwymt1wmU69WXlKPmyeerJPeNBe7GtFb5iEfMCgNBUBGIYxK4F1UK6f9AbTZNIuwyz
 TN73Cnuexk9CNTYQOfqhzVWSPugXi0EuFNe/Xd8qjdVIl948wU+VCenqfK8afvhmzWsF
 y/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xUhUxvH8j7S1GaBgnx3mWeabAqeuaOCZf4HQzE88eIs=;
 b=IBoxB/DMsjUNmmmw2Hwv71/v4F6vS5bZlpDMcc05nHOLPgzBhcQGhJFK30znRHB6pM
 M/K74GDixquD4jJXPmlTx4AtXHi+kh391xPvuQ5MAnk9GP4dGdrUfMcbBBrGproZqLkp
 mFc/wBc7vPF9YLUkyUMoBn8ca7a0e7W7MaZv8JORT+Io+7sM8ecgHE/+2jrKu3TpYurR
 9BlsEA8oC48jWUMCrll1A1bB6GDffmc9ZkSbcgXvY9/sqYxG84cjmaaEb6xSbT5oqM8U
 A5C6Lqz07bGu8OY0AqKwLmyny+Ph+QRpKO6Msbv4GwkUkkczjS4Jb0F8CDid7Dk+LHEN
 nJ2g==
X-Gm-Message-State: APjAAAUm87lDLpwD6vG01saIj4NjnMOLBXEcIW3Az70wmKJttrjuAX1X
 jfWvrH7e8Bb3TOG7sKK9W00Nsh6SFfDJf2tB7M8=
X-Google-Smtp-Source: APXvYqyOfdx2nZIfkGq3JfCIcyKj4fPiGv7TytN5DBavZHp2LAeISmGlABUfy9Ph0CGrTaHce70Mj6V0Khe54lxqnmc=
X-Received: by 2002:a05:651c:109:: with SMTP id
 a9mr6672979ljb.33.1567115695612; 
 Thu, 29 Aug 2019 14:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <1566959818-38369-1-git-send-email-zhiwei_liu@c-sky.com>
 <CAKmqyKMDmaABGWyLZD2R-4J8=jM6hry6Bfmu498+UZzQtxsTMA@mail.gmail.com>
 <af15b620-1350-aa1a-0f02-2a46518f0ef2@c-sky.com>
In-Reply-To: <af15b620-1350-aa1a-0f02-2a46518f0ef2@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 29 Aug 2019 14:50:43 -0700
Message-ID: <CAKmqyKPUxyMZnnOd896aK4ZRoG+6iiBQ0E3MJbEqRv9KudbN7Q@mail.gmail.com>
To: liuzhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [PATCH] RISCV: support riscv vector extension 0.7.1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 29, 2019 at 5:05 AM liuzhiwei <zhiwei_liu@c-sky.com> wrote:
>
> On 2019/8/29 =E4=B8=8A=E5=8D=885:34, Alistair Francis wrote:
> > On Wed, Aug 28, 2019 at 12:04 AM liuzhiwei <zhiwei_liu@c-sky.com> wrote=
:
> >> Change-Id: I3cf891bc400713b95f47ecca82b1bf773f3dcb25
> >> Signed-off-by: liuzhiwei <zhiwei_liu@c-sky.com>
> >> ---
> >>   fpu/softfloat.c                         |   119 +
> >>   include/fpu/softfloat.h                 |     4 +
> >>   linux-user/riscv/cpu_loop.c             |     8 +-
> >>   target/riscv/Makefile.objs              |     2 +-
> >>   target/riscv/cpu.h                      |    30 +
> >>   target/riscv/cpu_bits.h                 |    15 +
> >>   target/riscv/cpu_helper.c               |     7 +
> >>   target/riscv/csr.c                      |    65 +-
> >>   target/riscv/helper.h                   |   354 +
> >>   target/riscv/insn32.decode              |   374 +-
> >>   target/riscv/insn_trans/trans_rvv.inc.c |   484 +
> >>   target/riscv/translate.c                |     1 +
> >>   target/riscv/vector_helper.c            | 26563 ++++++++++++++++++++=
++++++++++
> >>   13 files changed, 28017 insertions(+), 9 deletions(-)
> >>   create mode 100644 target/riscv/insn_trans/trans_rvv.inc.c
> >>   create mode 100644 target/riscv/vector_helper.c
> >>
> > Hello,
> >
> > Thanks for the patch!
> >
> > As others have pointed out you will need to split the patch up into
> > multiple smaller patches, otherwise it is too hard to review almost
> > 30,000 lines of code.
>
> Hi, Alistair
>
> I'm so sorry for the inconvenience. It will be a patch set with a cover
> letter in V2.

No worries.

>
> > Can you also include a cover letter with your patch series describing
> > how you are testing this? AFAIK vector extension support isn't in any
> > compiler so I'm assuming you are handwriting the assembly or have
> > toolchain patches. Either way it will help if you can share that so
> > others can test your implementation.
>
> Yes, it's handwriting assembly. The assembler in Binutils has support
> Vector extension.  First define an function test_vadd_vv_8 in assembly
> and then it can be called from a C program.
>
> The function is something like
>
> /* vadd.vv */
> TEST_FUNC(test_vadd_vv_8)
>          vsetvli        t1, x0, e8, m2
>          vlb.v           v6, (a4)
>          vsb.v           v6, (a3)
>          vsetvli        t1, a0, e8, m2
>          vlb.v           v0, (a1)
>          vlb.v           v2, (a2)
>          vadd.vv     v4, v0, v2
>          vsb.v          v4, (a3)
> ret
>          .size   test_vadd_vv_8, .-test_vadd_vv_8

If possible it might be worth releasing the code that you are using for tes=
ting.

>
> It takes more time to test than to implement the instructions. Maybe
> there is some better test method or some forced test cases in QEMU.
> Could you give me some advice for testing?

Richard's idea of risu seems like a good option.

Thinking about it a bit more we are going to have other extensions in
the future that will need assembly testing so setting up a test
framework seems like a good idea. I am happy to help try and get this
going as well.

Alistair

>
> Best Regards,
>
> Zhiwei
>
> > Alex and Richard have kindly started the review. Once you have
> > addressed their comments and split this patch up into smaller patches
> > you can send a v2 and we can go from there.
> >
> > Once again thanks for doing this implementation for QEMU!
> >
> > Alistair
> >

