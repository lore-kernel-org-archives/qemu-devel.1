Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5966BC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 18:57:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2293A20782
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 18:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V0oWV0Mk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2293A20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQbbf-0000Ym-B7
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 14:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48672 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQbaG-0007zS-04
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 14:56:03 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQbaE-000154-Q6
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 14:55:55 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41067)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jQbaE-0000xN-D3
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 14:55:54 -0400
Received: by mail-oi1-x243.google.com with SMTP id k9so9769232oia.8
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 11:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=yccW/wviLq/fZejBiRaMUl/ad0WerqB3Egu7L7HzKz8=;
 b=V0oWV0Mka0qGToVSsTBiF+rwwNHlVQWH7UUQtMiq2iPdYYrgsQq9dXwJkEhh0d47a3
 dGlW5OQNM7yKMdqUog417fqYY+1BhbXK0Nto0rLbno1pxE4r1SRhBNXP6RjkReTKykev
 Vidpw0UqvZcWWfA7ljzchk2vvGv/QquZjj4dksnvy1iKUDIO9FYoYNM75JT30I3n9Gdz
 WhGVL1vS0NVYFaoOat/b7eFtpOB3ARMgpBfkJNYl0WJopyDM1uC77WOpmWKyVr69F+ZB
 O1jTpahmcRB0CI4VGgoKA0WdrmE8j7UsBD/z7zWfUkaarRPs7IPdOTus6H2cDmuFGGPM
 hgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=yccW/wviLq/fZejBiRaMUl/ad0WerqB3Egu7L7HzKz8=;
 b=Io7sEZBVPTOzEynW65ARxbZBYtZy6QVZ/JRUcuEsFBtPPEO+9A3ZzAvzxj96YeUW27
 LymaoLbZt6NUzo0LNu/u/BzT9gdoT05tBr/jWkkJZGAs5g+sg8lUQQyxd1fhsNusgJiT
 r6jMg+YQjKrI65rqZf0tW2oErBNm1OVQpQdF7tMaTzsHH2kaulHzmAHlgiNaNURYnUIU
 UiQ63qvbv9riEd76nNoQiHfgTgmjg5ocq2wHcOl+XeKY3bHzHWjGlJbOUyVDDSqKMRed
 GgUolZz8C5AtzngPi+l10dPw0sQJY6aEjJkPbRXLrZyw8Ef7+nlo+NbIeNcEVAfZ4T+M
 TY0A==
X-Gm-Message-State: AGi0PuYDZtt2UJo2zxu5naEC0l++xFwf+w5GYYG6hwz63A2txpw0yeCt
 Y2M6YmNmyZVQXyVO1uLkIdLnpKg1tWOWZlrMdpXj2g==
X-Google-Smtp-Source: APiQypJrJgYOnzIFpu2bAkicJGmWs5dSOPvHU8eGRxoyLuCiNhExDt7S5UWe/x/cfGmbDrfUG4FQz/3ndKMCN6KU2f8=
X-Received: by 2002:aca:dc56:: with SMTP id t83mr609173oig.48.1587408952853;
 Mon, 20 Apr 2020 11:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200416152829.790561-1-laurent@vivier.eu>
 <CAFEAcA9J=H7RMEEY5BmL=2ObKJDzMQQeWvbUnYYJfxFsntbP6w@mail.gmail.com>
 <2ee4258c-cb88-cdd7-78c2-4f5ac4b008ae@vivier.eu>
 <CAFEAcA-UWSJDvq5xmn2GTKY2zAgenkM7whdvn6FiY1+pUKBhcA@mail.gmail.com>
In-Reply-To: <CAFEAcA-UWSJDvq5xmn2GTKY2zAgenkM7whdvn6FiY1+pUKBhcA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Apr 2020 19:55:41 +0100
Message-ID: <CAFEAcA_hpcJhv9xc0wucozu7C6gkXxjJRNS93BFQJusMLPOYLw@mail.gmail.com>
Subject: Re: [PULL 0/1] Linux user for 5.0 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Apr 2020 at 20:08, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Thu, 16 Apr 2020 at 18:16, Laurent Vivier <laurent@vivier.eu> wrote:
> >
> > Le 16/04/2020 =C3=A0 18:03, Peter Maydell a =C3=A9crit :
> > > On Thu, 16 Apr 2020 at 16:29, Laurent Vivier <laurent@vivier.eu> wrot=
e:
> > >>
> > >> The following changes since commit 20038cd7a8412feeb49c01f6ede89e36c=
8995472:
> > >>
> > >>   Update version for v5.0.0-rc3 release (2020-04-15 20:51:54 +0100)
> > >>
> > >> are available in the Git repository at:
> > >>
> > >>   git://github.com/vivier/qemu.git tags/linux-user-for-5.0-pull-requ=
est
> > >>
> > >> for you to fetch changes up to 386d38656889a40d29b514ee6f34997ca18f7=
41e:
> > >>
> > >>   linux-user/syscall.c: add target-to-host mapping for epoll_create1=
() (2020-04-16 09:24:22 +0200)
> > >>
> > >> ----------------------------------------------------------------
> > >> Fix epoll_create1() for qemu-alpha
> > >>
> > >> ----------------------------------------------------------------
> > >
> > > How critical is this bug fix? After rc3, I really don't want
> > > to have to create an rc4 unless it's unavoidable...
> >
> > See the launchpad bug (https://bugs.gentoo.org/717548): on alpha, it
> > prevents the use of python3 in gentoo chroot, and thus we can't use
> > emerge to install packages. It also impacts cmake on debian (see
> > https://bugs.launchpad.net/bugs/1860553).
> >
> > But it's not a regression, so up to you to reject it. It appears now
> > because most of the distro have switched from python2 to python3.
> >
> > It's a low risk change, only in linux-user and for archs that have a
> > different EPOLL_CLOEXEC value.
>
> Thanks for the explanation. I think that I'll put it to one
> side and if we need an rc4 for some other reason it can go in,
> but it's not sufficiently major to merit an rc4 by itself.

We needed an rc4 for the iscsi fix, so I have applied this pullreq.

thanks
-- PMM

