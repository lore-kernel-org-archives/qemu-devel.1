Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D11BC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:21:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55D0C206F5
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aA9Nq7gR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D0C206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJzmi-0001P2-Ip
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 09:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jJzm7-0000tH-5F
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jJzm5-0007kj-De
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:20:50 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38245)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jJzm5-0007j5-6N
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:20:49 -0400
Received: by mail-wr1-x444.google.com with SMTP id c7so4165341wrx.5
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 06:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=/HlFum5x8cLR+UhvOUaeCSvZqOCl06v0HkN8wJYEr7c=;
 b=aA9Nq7gRefDmthB4r5e9GorUzffJVZDUN+OpXWPybnXJapdbPflt39QL/ZgxSFxbIJ
 BDJH8Z4N96f/12JjGRAMu87OmIkrf99ROsjWHQBoGkzuL270Y2aacARZFFFHo49NqLsy
 m9z2KC5TQN1HGYqmRZ8rUh1MMfdP1rg0dt45l8d7K0hZY/0ggX9KhIGvQoR/w/MrmQUf
 tbmgsDUKuVDiljfspPR7z45PXGUCAxxNRgJJ+H7MVOhmABm3AuEk3si9IFTspuZKozTf
 IPUfNKgsoVbzNv2RvWDGgAFcU7aPNz0AJIxbUsoAgLCQ4z6ZFKylFlQE4fbCZSE1wdIf
 BpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=/HlFum5x8cLR+UhvOUaeCSvZqOCl06v0HkN8wJYEr7c=;
 b=afrf7KF4L4+jOS1sUPZnQfkjVaJhUGn2j9IAYRB3OrSzb6XwypFT79wreX3I+EJg8m
 pBbHKD7qjYXHvI0tJNPFmZwrwwQPcvE1XU93T3fdYUALlPRuj5YjVuCshwDh8faLzRsm
 nAMCa42fOW3YD7j8UmIE1GyJayABYP08hXjE1dUW1s2HdeDcdsrvfmZUoU5sLkLzHdzo
 czKeboGJ3Pw7JCE+IjODlDtLFwcoQ18bKpykvF1YS4iN5FT5cPDThwMb81fz7b3jpPw1
 ttbm0ixDjCJX/ZW1UFvGOk9mqGJj/S8kTpQ+NX1bdID3D6Y6z1tny1tSIpZdal1t1TMr
 a5Qg==
X-Gm-Message-State: AGi0PuZ1cE+dMDy/ZvQrHrq5PBh1qUyI8KNL+jVjQXktBvQ3K864722o
 25Ro2LHMOnWULVLWha1eRBrROw==
X-Google-Smtp-Source: APiQypL4DG6O3iVn7fmKBKNRopteod78xuFkNXFyO2QOThHmwarnuACWqbFdm94zjZBpF8g2+AKFtg==
X-Received: by 2002:adf:ee4c:: with SMTP id w12mr2301835wro.378.1585833647482; 
 Thu, 02 Apr 2020 06:20:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s131sm7327336wmf.35.2020.04.02.06.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2020 06:20:46 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7A5101FF7E;
 Thu,  2 Apr 2020 14:20:45 +0100 (BST)
References: <CABLmASEaKJKzDdvKGv+iWfp=0vdr9bupM76zvLZZ6sZFAPkuRg@mail.gmail.com>
 <6ad7d2d1-658c-04db-4ce0-77c498efbba4@redhat.com>
 <CABLmASEBUzdzu8wt-2YbcntOAfNbsVm7W=W-Uk85ieu1757pMA@mail.gmail.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Howard Spoelstra <hsp.cat7@gmail.com>
Subject: Re: qemu-system-ppc 5.0 rc1 crashing on Windows
In-reply-to: <CABLmASEBUzdzu8wt-2YbcntOAfNbsVm7W=W-Uk85ieu1757pMA@mail.gmail.com>
Date: Thu, 02 Apr 2020 14:20:45 +0100
Message-ID: <87h7y2dnwy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Howard Spoelstra <hsp.cat7@gmail.com> writes:

> On Thu, Apr 2, 2020 at 12:47 PM Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com>
> wrote:
>
>> Cc'ing the persons referenced in the commit you referred,
>> who happened to be chatting about this issue few hours ago on IRC.
>>
>>
> Thanks, adding --disable-pie to configure solves this issue, but I guess
> the default detection should work ;-)

Could you try the following patch:

  Subject: [PATCH for-5.0] configure: Add -Werror to PIE probe
  Date: Wed,  1 Apr 2020 14:47:56 -0700
  Message-Id: <20200401214756.6559-1-richard.henderson@linaro.org>

which fixed the win mxe cross compile failures.

>
> Best,
> Howard
>
>
>
>> On 4/2/20 11:28 AM, Howard Spoelstra wrote:
>> > Hi,
>> >
>> > I just compiled qemu-system-ppc for Windows, using native msys2 on
>> > Windows 10 64 bit and the 64 bit mingw cross compiler on Fedora 31. Bo=
th
>> > create executables that crash:
>> >
>> > qemu-system-ppc.exe -L pc-bios -boot c -m 512 -M mac99,via=3Dpmu -h
>> > da C:\Mac-disks\9.2.img
>> > Exception code=3D0xc0000005 flags=3D0x0 at 0x00007FFB2A602078. Access
>> > violation - attempting to write data at address 0x00000000034C76EC
>> >
>> > I bisected this down to:
>> >
>> > d2cd29e30736afd4a1e8cac3cf4da360bbc65978 is the first bad commit
>> > commit d2cd29e30736afd4a1e8cac3cf4da360bbc65978
>> > Author: Richard Henderson <richard.henderson@linaro.org
>> > <mailto:richard.henderson@linaro.org>>
>> > Date:   Tue Dec 17 13:47:37 2019 -1000
>> >
>> >      configure: Do not force pie=3Dno for non-x86
>> >
>> >      PIE is supported on many other hosts besides x86.
>> >
>> >      The default for non-x86 is now the same as x86: pie is used
>> >      if supported, and may be forced via --enable/--disable-pie.
>> >
>> >      The original commit (40d6444e91c) said:
>> >
>> >        "Non-x86 are not changed, as they require TCG changes"
>> >
>> >      but I think that's wrong -- there's nothing about PIE that
>> >      affects TCG one way or another.
>> >
>> >      Tested on aarch64 (bionic) and ppc64le (centos 7) hosts.
>> >
>> >      Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org
>> > <mailto:alex.bennee@linaro.org>>
>> >      Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org
>> > <mailto:alex.bennee@linaro.org>>
>> >      Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>> > <mailto:philmd@redhat.com>>
>> >      Signed-off-by: Richard Henderson <richard.henderson@linaro.org
>> > <mailto:richard.henderson@linaro.org>>
>> >
>> > Please note that I tried again after applying patch
>> > https://patchwork.ozlabs.org/patch/1265368/ However, this has not
>> solved
>> > my issue.
>> >
>> > Best,
>> > Howard
>> >
>> >
>>
>>


--=20
Alex Benn=C3=A9e

