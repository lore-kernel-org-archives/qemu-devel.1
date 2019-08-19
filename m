Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E771BC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 16:39:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B08742070B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 16:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BYKbTk6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08742070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzkgp-0002HX-S4
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 12:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chihmin.chao@sifive.com>) id 1hzkfu-00014j-6T
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 12:38:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1hzkfs-0000K4-Bj
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 12:38:30 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:46141)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1hzkfs-0000JV-1i
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 12:38:28 -0400
Received: by mail-io1-xd42.google.com with SMTP id x4so5641630iog.13
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 09:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LqaMVi2bhKEsy7fqdRpYFiDwvc9O1DVGTsv5s250QcQ=;
 b=BYKbTk6DJmlvdHwMz0s5lx0Iz1BHVk/HfPHqprIxOOXp+cFQ3tuwZp2IXzRY9P5X1p
 KSwzUxJdbxKSBCGiC0ClvxjqY9Cwqw9IwVHcPg06c7TSMutrPtfkiiIkBvIZP2VENpcl
 ihFDwL9lM917d1G8HteBs5/h9Rh37ZqHnEHok+6XcIU4AdPx1RVUjnB1XzfMJRU6A5PR
 0Nx9aSvSh3653IZrvzVUV8D+Nk2Xa+QQlkFhAn+nTc423Oho71hLUJDnextu6WKGMXr0
 rc5WC5DXM4eFRP19dUiuJidl9Tk5Hq59sGaodnFHTrBUuB9Xn48U0PCYTeHbsZqxWKCB
 HoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LqaMVi2bhKEsy7fqdRpYFiDwvc9O1DVGTsv5s250QcQ=;
 b=pf7u8pfVc8VqvwnNmJ8odwAY9tdJchkoWj7Pv0QzYmRQs7YKr5Nt/QoYYnz4NwxQCQ
 eFlKT2b6Zad7hmy/xUmZzKt4b4YyGSbmLUL7oYw6i1E/OJlgkpUBNV9/+BWI+aoDBfnz
 lIS00hopY3/Vi+akupEVXYzFMgJJ4GPxmybMFYAzEdpyzeNqHtFMmX5p3W8xn3nxxnXh
 PIRHx1elvEp9fSv8dXpLaNkDlLgNxXYdrjXWiIM/hMJcRSl5uk192OQ2HDRGrmmKxlKi
 LDaW9LBfezdlJaQzZWlGxzGSNnwmUZMIpDbYv4s2r/6u+Agw2elYsfKfKVw6FhBmhKjr
 YbjQ==
X-Gm-Message-State: APjAAAXgqtVDDzGsu66A1k2a/pdhytg38fF6ofDwq554kCOurU6082Ad
 /qL6D3e675UHZOFQFrKOH1u4fZRnZmw3xB9S7Vw1+w==
X-Google-Smtp-Source: APXvYqzib2XRArNBbh1PVLHZC9BtixpPG2+lrquZCIF1Zvpj0GPnt8XIKD9LBCc60gaB2wZHL/p5pr41jhdl4ITcCyI=
X-Received: by 2002:a05:6602:228e:: with SMTP id
 d14mr26772808iod.85.1566232706956; 
 Mon, 19 Aug 2019 09:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <0141541d-43ff-98d8-e9d4-4a2fdcfdcf36@c-sky.com>
 <CAKmqyKPr0V6acB2-Y+N1-aoj-5LSofwi=Jz=u6KFJN1fPUWjzA@mail.gmail.com>
 <2b741fb0-0f12-0f07-a516-9cc23abc0b6e@c-sky.com>
In-Reply-To: <2b741fb0-0f12-0f07-a516-9cc23abc0b6e@c-sky.com>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Tue, 20 Aug 2019 00:38:15 +0800
Message-ID: <CAEiOBXU1SbdgJdsn_Cvny4=7NTxE+XQPrQQn6NevBxwB8Wox5w@mail.gmail.com>
To: liuzhiwei <zhiwei_liu@c-sky.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [Qemu-riscv]  RISCV: when will the CLIC be ready?
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 19, 2019 at 9:47 PM liuzhiwei <zhiwei_liu@c-sky.com> wrote:

>
> On 2019/8/17 =E4=B8=8A=E5=8D=881:29, Alistair Francis wrote:
> > On Thu, Aug 15, 2019 at 8:39 PM liuzhiwei<zhiwei_liu@c-sky.com>  wrote:
> >> Hi, Palmer
> >>
> >> When Michael Clark still was the maintainer of RISCV QEMU, he wrote in
> the mail list, "the CLIC interrupt controller is under testing,
> >> and will be included in QEMU 3.1 or 3.2". It is pity that the CLIC is
> not in
> >> included even in QEMU 4.1.0.
> > I see that there is a CLIC branch available here:
> > https://github.com/riscv/riscv-qemu/pull/157
> >
> > It looks like all of the work is in a single commit
> > (
> https://github.com/riscv/riscv-qemu/pull/157/commits/206d9ac339feb9ef2c32=
5402a00f0f45f453d019
> )
> > and that most of the other commits in the PR have already made it into
> > master.
> >
> > Although the CLIC commit is very large it doesn't seem impossible to
> > manually pull out the CLIC bits and apply it onto master.
> >
> > Do you know the state of the CLIC model? If it's working it shouldn't
> > be too hard to rebase the work and get the code into mainline.
> >
> > Alistair
> >
> Hi,  Alistair
>
> In my opinion, the CLIC code almost works.
>
> Last year when my workmate ported an RTOS, I once read the CLIC
> specification and used the CLIC model code. It worked through  all the
> tests after fixed two bugs. I also had sent the patch to Michael, but
> without response(maybe a wrong email address).
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 7bf6cbc..95d80ab 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -505,6 +505,9 @@ static target_ulong riscv_intr_pc(CPURISCVState *env,
>       if (!(async || clic)) {
>           return tvec & ~0b11;
>       }
> +    if (clic) {
> +        cause &=3D 0x3ff;
> +    }
>
>       /* bits [1:0] encode mode; 0 =3D direct, 1 =3D vectored, 2 >=3D res=
erved */
>       switch (mode1) {
> @@ -645,6 +648,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>           riscv_cpu_set_mode(env, PRV_M);
>       }
>
> +    if (clic) {
> +        env->exccode =3D 0;
> +    }
>       /* NOTE: it is not necessary to yield load reservations here. It is
> only
>          necessary for an SC from "another hart" to cause a load
> reservation
>          to be yielded. Refer to the memory consistency model section of
> the
>
> After that, the specification has updated and the code may changed. I
> didn't pull new code again.
>
> If the CLIC model may merged into the mainline, and no body maintain the
> code, I'd like to work on it, fixing the bugs and updating the code
> according to latest specification.
>
> Best Regards,
> Zhiwei
>
> >> As we have cpus using CLIC, I have to use the out of tree qemu code in
> SIFIVE
> >> a long time. Could you tell me when it will be upstreamed?
> >>
> >> Best Regards
> >> Zhiwei
> >>
>
>
Hi Zhiwei,

I think what Alistair point out is the latest clic version (or
https://github.com/riscv/riscv-qemu/tree/riscv-qemu-3.1).  The two
versions, on pull request and 3.1 branch, should be similar.
As far as I know, there is no concrete plan on CLIC patch in short term.
It is good to know that the clic patch has been run with real RTOS.
It is also great if you could update the implementation to latest spec and
send the patch again.

chihmin
