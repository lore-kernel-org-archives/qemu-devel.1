Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F05CA9EBC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 19:57:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0950821D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 19:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KDIx+9ub"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0950821D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO5hw-0001gX-RW
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 15:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iO5PR-0001a1-AA
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:38:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iO5PP-0003Zg-Ov
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:38:05 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:37822)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iO5PP-0003ZE-Hy
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:38:03 -0400
Received: by mail-wr1-x436.google.com with SMTP id e11so3633510wrv.4
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 12:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=CLnYlmKhsHXNMFog2TL2EKq9p2R07PJ+8JPulP8UW7E=;
 b=KDIx+9ubPRwv7fUiZ917/TpruJHgoyEWLdGWNzTfB2e/2DmQqgCvNmXikMZIfA+2d4
 VJl2s07Y2PhEByOPt1sARPL9qnlSCXpMGPQOPXmNhqbIesAyaMxoI6Jiea7HwKsrwJs3
 fy/I0sIBplEBf6z3syINRoQTdzRrwp8GhQ8G3EpG0hnf1DqFrpkPI1KOBY9PWB+fpDtW
 B28YU8o7KExwqqYa3XKtCX0Wwzba/ecMKD8nV8f1OJS4j5/OXpt44B9r0JAof0DshiWg
 hLkuQJIkPyFI2RlKXbcSux3l8Tmva4IB9LhJpv3qSXoraSsZp8+5HRnvdQEu6bliM88H
 BKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=CLnYlmKhsHXNMFog2TL2EKq9p2R07PJ+8JPulP8UW7E=;
 b=dHeBncbVhWgva6uHy89E5A13pd8CztUMbhWvWKwzFk6N9M7LZnhBiwc6sqDGjJj5a3
 xv+am8C74OxhQLOu+yegzZEGO8+4kMR6dpauxEZGskgBgWbNA2aKvQ3TGALSQ+8Pjbid
 YVypCd622iahAI9g8OXdvS1HbL6eBa5EsRRDeQc/rGFc2nxURLnC9Fra/lslF+2B7A3S
 l4jGz44wBNtglQOtSYpTWKeoRCZsj0Dflhq7Z5N1XRimH41ZFMUqbnQGNWkY9ANZzJBH
 aSc093GYUDOdgSLBvkyMOFCT3M+r8AG4QCRhokI9P8yvjtlk7qaUJkm5/ZWnuAmNA9zD
 z9Ow==
X-Gm-Message-State: APjAAAUOPBFu7JqBN8NbPQYvGlJUtvwUi/HwBSnHdSIiiwt8UxL0NFnH
 LJ1O4Dn7AgoGbcFbpQ4kK97NmZpTd+M=
X-Google-Smtp-Source: APXvYqyLcgSbe5Z+UzYDXZdmTRe5soiNHecc0oFE0kwlivrZw/Ma/QDVNQmqfuE2UliT71tRrvNJ5g==
X-Received: by 2002:adf:8289:: with SMTP id 9mr4795631wrc.0.1572032282367;
 Fri, 25 Oct 2019 12:38:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f18sm2745056wmh.43.2019.10.25.12.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 12:38:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 36DC51FF8F;
 Fri, 25 Oct 2019 20:38:01 +0100 (BST)
References: <20191025063713.23374-1-alex.bennee@linaro.org>
 <CAFEAcA-Sme=XfPdonOa6=1KAFnJcvqyg+PzNiOVpLHDsy4O+gg@mail.gmail.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL v2 00/73] tcg plugins and testing updates
In-reply-to: <CAFEAcA-Sme=XfPdonOa6=1KAFnJcvqyg+PzNiOVpLHDsy4O+gg@mail.gmail.com>
Date: Fri, 25 Oct 2019 20:38:00 +0100
Message-ID: <87eez0wr8n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 25 Oct 2019 at 07:37, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> The following changes since commit 81c1f71eeb874c4cbbb9c5c4d1a1dc0ba7391=
dff:
>>
>>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-=
request' into staging (2019-10-24 10:43:20 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/stsquad/qemu.git tags/pull-testing-and-plugins-2410=
19-2
>>
>> for you to fetch changes up to 18900c2d7901680457b51b3ad3f684ef9cba8b64:
>>
>>   travis.yml: enable linux-gcc-debug-tcg cache (2019-10-24 22:31:29 +010=
0)
>>
>> ----------------------------------------------------------------
>> Core TCG plugin support and testing updates
>>
>>   - TCG plugin support
>>   - netbsd VM autoinstall
>>   - various Travis dependency updates
>>   - enable tcg debug for check-tcg
>>   - additional Xcode build for Cirrus
>>   - dependency tweak for gitlab
>>
>
> This makes the vm-build-netbsd target stop working:
> looking at the log file it seems to try to do an install,
> but there's a pkg_add command failure and then it
> times out because it expects a menu with an 'Enable sshd'
> option and it isn't there:

OK I've dropped this (again) and re-sent a testing only PR. I'll resend
the remaining plugin stuff on Monday.

>
> con recv: >a: Host                      ftp.NetBSD.org
> con recv: b: Base directorypub/pkgsrc/packages/NetBSD
> con recv:  c: Package directory/amd64/8.1/All
> con recv:  d: Userftp
> con recv:  e: Password
> con recv:  f: Proxy
> con recv:  g: Additional packages
> con recv:  h: Configure network
> con recv:  i: Quit installing binary pkgs
> con recv:  x: Install pkgin
> con send: x<enter>
> con recv:  and update package summary a: Host
> ftp.NetBSD.org>x: Install pkgin and update package summary
> con recv: Status: RunningCommand: pkg_add
> http://ftp.NetBSD.org/pub/pkgsrc/packages/NetBSD/amd64/8.1/All/pkgin
> con recv: ---------------------------------------------------------------=
-----------------pkg_add:
> Can't process http://ftp.NetBSD.org:80/pub/pkgsrc/packages/NetBSD/amd64/8=
.1/All/pkgin*:
> Not Found
> con recv: pkg_add: no pkg found for
> 'http://ftp.NetBSD.org/pub/pkgsrc/packages/NetBSD/amd64/8.1/All/pkgin',
> sorry.
> con recv: pkg_add: 1 package addition failed
> con recv: Command failedHit enter to continue
> con send: <enter>
> con recv: Enabling binary packages with pkgin requires setting up the
> repository.  The
> con recv:  following are the host, directory, user, and password that
> will be used.  If
> con recv:  "user" is "ftp", then the password is not needed.
> con recv:
> con recv: >a: Host                      ftp.NetBSD.org
> con recv: b: Base directorypub/pkgsrc/packages/NetBSD
> con recv:  c: Package directory/amd64/8.1/All
> con recv:  d: Userftp
> con recv:  e: Password
> con recv:  f: Proxy
> con recv:  g: Additional packages
> con recv:  h: Configure network
> con recv:  i: Quit installing binary pkgs
> console: *** read timeout ***
> console: waiting for: 'g: Enable sshd'
> console: line buffer:
>
> con recv:  x: Install pkgin and update package summary
>
> Failed to prepare guest environment
> Traceback (most recent call last):
>   File "/home/peter.maydell/qemu-netbsd/tests/vm/basevm.py", line 362, in=
 main
>     return vm.build_image(args.image)
>   File "/home/peter.maydell/qemu-netbsd/tests/vm/netbsd", line 173, in
> build_image
>     self.console_wait_send("g: Enable sshd",           "g\n")
>   File "/home/peter.maydell/qemu-netbsd/tests/vm/basevm.py", line 262,
> in console_wait_send
>     self.console_wait(wait)
>   File "/home/peter.maydell/qemu-netbsd/tests/vm/basevm.py", line 224,
> in console_wait
>     chars =3D vm.console_socket.recv(1)
> socket.timeout: timed out
>
>
> I tried a couple of times and it failed the same way both times.
>
>
> thanks
> -- PMM


--
Alex Benn=C3=A9e

