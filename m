Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25737C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 22:32:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E11BA22CF4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 22:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFiD2wKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11BA22CF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Cfv-0001Jv-5H
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 18:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i0Cey-0000ra-Nx
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 18:31:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i0Cex-0002WY-Fr
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 18:31:24 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:35074)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i0Cex-0002Vh-A4
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 18:31:23 -0400
Received: by mail-ot1-x335.google.com with SMTP id g17so244890otl.2
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 15:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=IlJoSs8JEHgXY07+Mg405702kWrI8U+Pwv4Qs5ym4yg=;
 b=GFiD2wKX1s918v33mDxu91Yuxw/W8GqAqMeldk9gM3hW/7D9UZvL8j/5cV8k4Rl5fd
 WWoaYWYkh9JTH6GTVyZ4WfgPWAnmA2QfVy+lP5sNuTfSIS2dhHc1Q0o1LSyHuhoKICIO
 LM3gY9h1aJCvNcvjGIR0zVgKRYIvWFp9HYkZhyFBJIRpX/1fnvt8doZXGI3pV89/SJeD
 3p5lt2hkAzrLICewN2ljjVfpgfyFzpGDGpYPlyYIhc5i/oeAs1qBT1cNhX8USsH9/mMq
 1Tch9A1Y24O5hJNp7Y0ilgmfNNfGLsX6uMyNVi6m9muFiMrYIYBAtHLV6hmf2gSpPDDI
 Dc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=IlJoSs8JEHgXY07+Mg405702kWrI8U+Pwv4Qs5ym4yg=;
 b=OfWaBCdwnokIJEL8opsPOaMnrPeyDP/gb8b2K+drWd0AkcPEAZtStIfdTwe1cqqy4/
 EOpz4xRxA9f/n3aT2W+c66I9UViggTmswTFhLmusa3/0lVycUH/Yy0/jhCceEgOaVqf/
 SpqvV/9lV8TCWeM9U+aE0GxGKMftUNPJ+6nxzCvvNwrdpdb6S/aD+u/cOKiwuhzeAAi6
 3hQDOnadMPCmDOVXj3sSQAiNFU5P/kt2C+/hCHs44gIOEHJzAZ8Tcp4WSsNd0Sqi+YoR
 ri3yTjS0rok/WPYQDmQWzlJfh/noipPaPa2a4ak0d9Qw9cpMqjHSWtHyxzZb4kmNS/ED
 r7vw==
X-Gm-Message-State: APjAAAVZX4lHgwPBUchpWrQFcqFXe2L+namSCaKsh923Ay5msHAAth5Q
 dbAURqMqRXUJAlFb9wNX5dNlsBccgqgckpFP08c=
X-Google-Smtp-Source: APXvYqx4Up4Y5z/lquIUIHpetMFBiNAaDJtd8UTrafdFXX/ZG9MVfxa9DQWjPgNcLNCwnziWtBCk7OGV2a1uNINUnhU=
X-Received: by 2002:a05:6830:1d75:: with SMTP id
 l21mr22954905oti.121.1566340282428; 
 Tue, 20 Aug 2019 15:31:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Tue, 20 Aug 2019 15:31:21
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Tue, 20 Aug 2019 15:31:21
 -0700 (PDT)
In-Reply-To: <156633742863.16769.2783105280357246181.malone@wampee.canonical.com>
References: <155216177409.9624.16357609956497374456.malonedeb@gac.canonical.com>
 <156633742863.16769.2783105280357246181.malone@wampee.canonical.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 21 Aug 2019 00:31:21 +0200
Message-ID: <CAL1e-=gp6ZEP8GeseG9hPJbP7=ma4+GkV7RLrV8ttqQvnUQJxA@mail.gmail.com>
To: Bug 1819289 <1819289@bugs.launchpad.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::335
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [Bug 1819289] Re: Windows 95 and Windows 98 will
 not install or run
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.08.2019. 23.56, "Brad Parker" <1819289@bugs.launchpad.net> =D1=98=D0=B5 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> So it looks like even though that commit fixed it, it seems to break
> again (differently) in 3.0.0, so I'll need to do another bisect between
> cfcca36 and v3.0.0 then I guess. And keep working my way up to master as
> well.
>
> --

At least you will have an interesting debugging story to tell afterwards. I
wish you luck!

Aleksandar

> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1819289
>
> Title:
>   Windows 95 and Windows 98 will not install or run
>
> Status in QEMU:
>   New
>
> Bug description:
>   The last version of QEMU I have been able to run Windows 95 or Windows
>   98 on was 2.7 or 2.8. Recent versions since then even up to 3.1 will
>   either not install or will not run 95 or 98 at all. I have tried every
>   combination of options like isapc or no isapc, cpu pentium  or cpu as
>   486. Tried different memory configurations, but they just don't work
>   anymore.
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1819289/+subscriptions
>
