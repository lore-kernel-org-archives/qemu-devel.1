Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC40C55189
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 09:51:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B57A42073A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 09:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0voYnOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B57A42073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRC2r-0006qS-Uh
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 05:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1jRC22-00061K-51
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 05:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1jRC21-0004Op-G0
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 05:51:01 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:39265)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jRC1w-0003om-Ea; Wed, 22 Apr 2020 05:50:56 -0400
Received: by mail-yb1-xb42.google.com with SMTP id h205so866929ybg.6;
 Wed, 22 Apr 2020 02:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vCGKSikB8D27wNRtSYvzPVc7FAOx9psLBPWO7a1IF5w=;
 b=e0voYnOoVNefUOci216v9TGAk0mtegRRHiF4a7iseODkYmtMEf//2iz4B2S5+BiE40
 rxnXFA6vqqdnWjSxz1PJzci/SB4+3DMI/6qJTHgLSIeytQQro4g9cq4JRx/3+FcXfAf0
 5/TqR0cAyAjsXYzceyAgn3arD0mABzyfRZkfHnLvFL7ajCDENTB+DbXnK5eAQLVliBBj
 XSgFEqN46nMERNZqtNSgKXmbZ7JmWjRp5662hrc3PyUCHB0nkqcyMlP3jwEUswYwfjta
 WeS4HVIEQrm8yixuo2kfZbnpzc2zjWb2fqnz1NgRoK86SOUYsAxnPmkjFbmsBqz/K4bo
 76vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vCGKSikB8D27wNRtSYvzPVc7FAOx9psLBPWO7a1IF5w=;
 b=sst27IpZypGHVCuCeAij5FfNHsi1OBARZBsyj2Mx7jiJymrkjyM5PRYZCmStkpNCJF
 RCCJtBDOvrkdKMmRbv6IKrqC4G82ezV1derKM953pkvNb92qXhzgCil39C0z51g/2+Ch
 mQgLv8P7a1aQScwv6HCmznt1l4siBhGh6Lx80N/u5WmH2YotgqUB1svaZnev+twCH7w4
 kkz8s02mUAj4OPwciKZYu1/EOrSBeVR+TvG5hcHsBNnE6gJ1HdxSOQHycnv9HlUHr6aH
 TYZQa0WryLt/6gsYDFJGhuTs9JPwKgZttqQSyW99CEPLrKTedxThfvpOd3+RrXUQqIfB
 qJfw==
X-Gm-Message-State: AGi0Pub8+kZLATYjRO7xTzUG8fXmVl07kdxcOqT3lAq06wjVNK4R4/Ob
 DwnKsBNB+1y063R2k4H07Q5L/IrExpo7kSR+IRY=
X-Google-Smtp-Source: APiQypLWDD8yJODVA4FZ5xQp44cm3IYxQH91RnPUM6BJ6TrHX4gsVx7moS1u+pr1v9lhn97zlOHr3OhpPdigGR87/8M=
X-Received: by 2002:a25:738a:: with SMTP id o132mr4991773ybc.490.1587549053747; 
 Wed, 22 Apr 2020 02:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <1587389038-1549-1-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKMzUzHC1FhV6ccjswjRvQH_h6DuUwEWjte4CAEmxPOKDg@mail.gmail.com>
 <CAEUhbmUTEVPF6f91SqrXL-_M-G_Jg2D29cBjbCs1YBGm2fk6QA@mail.gmail.com>
 <CAEUhbmWsNmTTTFz66M4sK-pEtEMOhfoYzCHYVyEF4AJ2X02twA@mail.gmail.com>
 <bd7da39b-4ece-7e72-a0a0-1d401c3b8c34@redhat.com>
In-Reply-To: <bd7da39b-4ece-7e72-a0a0-1d401c3b8c34@redhat.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 22 Apr 2020 17:50:42 +0800
Message-ID: <CAEUhbmWCNGTn34wGSUvbwAbuY15VeDPPnFF2em4=XKEH5kReKw@mail.gmail.com>
Subject: Re: [PATCH] roms: opensbi: Upgrade from v0.6 to v0.7
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, 
 Anup Patel <anup.patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb42.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::b42
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
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 22, 2020 at 4:15 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 4/22/20 3:30 AM, Bin Meng wrote:
> > Hi Alistair,
> >
> > On Tue, Apr 21, 2020 at 9:34 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >>
> >> Hi Alistair,
> >>
> >> On Tue, Apr 21, 2020 at 2:41 AM Alistair Francis <alistair23@gmail.com=
> wrote:
> >>>
> >>> On Mon, Apr 20, 2020 at 6:25 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >>>>
> >>>> Upgrade OpenSBI from v0.6 to v0.7 and the pre-built bios images.
> >>>>
> >>>> The v0.7 release includes the following commits:
> >>>>
> >>>> f64f4b9 lib: Add a new platform feature to bringup secondary harts
> >>>> b677a9b lib: Implement hart hotplug
> >>>> 5b48240 lib: Add possible hart status values
> >>>> e3f69fc lib: Implement Hart State Management (HSM) SBI extension
> >>>> 6704216 lib: Check MSIP bit after returning from WFI
> [...]
> >>>> 6c7922e lib: Support vector extension
> >>>> 615587c docs: Update README about supported SBI versions
> >>>> 66d0184 lib: Allow overriding SBI implementation ID
> >>>> 9f1b72c include: Bump-up version to 0.7
>
> The git-short-log in the commit message is very appreciated, thanks.
>
> >>>>
> >>>> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> >>>
> >>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> >>>
> >>> Can you share a git branch with this patch? From memory these binary
> >>> patches don't apply well from emails.
>
> Indeed. These patches are good candidate to use the 'git-format-patch
> --no-binary' option with a link to a git repository to fetch the full
> commit:
>

Some other project mailing lists do not prevent binary patch mails. If
this is QEMU convention, I suggest we document this in
https://wiki.qemu.org/Contribute/SubmitAPatch.

>    --no-binary
>      Do not output contents of changes in binary files,
>      instead display a notice that those files changed.
>      Patches generated using this option cannot be applied
>      properly, but they are still useful for code review.
>
> >>
> >> Sure. Please grab the bits from http://github.com/lbmeng/qemu opensbi =
branch.
> >>
> >> You can also use patchwork to help with your custodian work.
> >> http://patchwork.ozlabs.org/project/qemu-devel/patch/1587389038-1549-1=
-git-send-email-bmeng.cn@gmail.com/
> >>
> >> Click on the "mbox" button to download the patch and apply it.
> >
> > Will this be 5.0, or 5.1?
>
> Unlikely 5.1, too late.

I am fine. Just wanted to know the strategy of which QEMU release to
ship which OpenSBI release. +Anup in case he has some comments.

Regards,
Bin

