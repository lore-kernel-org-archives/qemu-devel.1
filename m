Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9906C31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 09:22:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76908204EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 09:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VTMMdd90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76908204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45528 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcnqH-0000ns-Vv
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 05:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54908)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hcnpS-0000HI-Rm
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 05:21:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hcnpR-0007Sa-Kw
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 05:21:30 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46629)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hcnpR-0007SA-D5
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 05:21:29 -0400
Received: by mail-wr1-x441.google.com with SMTP id n4so9066536wrw.13
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 02:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=9KNqBYuvZXWvcw/2hrNE7EH8FCQxuWpq0kSBC4y9ZKE=;
 b=VTMMdd90J8U6nhKXV1mqFvD4wUi0eUAor4AAGdbXBZF3PkR/+l+pp1IXj93RKKIoe/
 1hJd+I01fSyPPTaVpfBBwtJLyTkUqpLUGELmfu0M3f5ORqs5sWiceGMAfpN53Tzurbbz
 3KknqIkIMSgKLcQo+6iaQeVAxy0BNcgv88HqfXeLyXalNOh3Qm8EzPVk6yAzskd3Ig06
 FhXKCu+xUBIpMOx+I6g+5nIw6thKU/sEV8/qnWZ8aGBr6jQa7fjCD6IBls5cDHRNhgY8
 QY881YJzLN01pJxMoI2oSlgB8H6KwMPerRRPMHROHh+wKjgFCD+CSIPr6AUlOdR8xGZ0
 9Gow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=9KNqBYuvZXWvcw/2hrNE7EH8FCQxuWpq0kSBC4y9ZKE=;
 b=kH0xpB/+06tm9r08Fq3vdllLsAyKyHdIqupEC1RU2svwvvyDEhAsZmuF3TloNc4NbE
 pNUmtQ8c8Ttr3Zry5MeV4YyelnvhwMJc7jkngNi43F5Pq3jjZ6u/d8lyv7IZlJ2++VvL
 bGjFwnVAlcaeZED5hKvnnNhXVafgjMNhJXNMXtqsYCYi33ZVxLaGaGNXoqmdqapg8ve7
 ybDVMEMMvhF3Zn6C2FVPxLYTUb7xCkBVdKT20OgMqbgrQXO2VA4U9ZWFiZzzkU40tgWm
 9/UZOrRaEJoQpgR/OvIPoCxJrrSykRpQDexDQE4buRb11N6KfkC9ROwTQcDHRN64PQJh
 dA3A==
X-Gm-Message-State: APjAAAUmNkbVcR/OrH6TcV9KsFSnE7xahEWu8ZqWbEt8DAAgBvbQvHti
 AtyQBWHEKSvXYTaSl6ljQ+neLg==
X-Google-Smtp-Source: APXvYqxQDRhei26DGRPalC4olAD3AFHPLNqWQogz0YEds3PhtEU2F3gnFUJi96ydRBDR2EshMyICMw==
X-Received: by 2002:adf:fb8a:: with SMTP id a10mr41021510wrr.235.1560763288070; 
 Mon, 17 Jun 2019 02:21:28 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id a81sm17479006wmh.3.2019.06.17.02.21.27
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 17 Jun 2019 02:21:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DC6491FF87;
 Mon, 17 Jun 2019 10:21:26 +0100 (BST)
References: <20190617043858.8290-1-kraxel@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gerd Hoffmann <kraxel@redhat.com>
In-reply-to: <20190617043858.8290-1-kraxel@redhat.com>
Date: Mon, 17 Jun 2019 10:21:26 +0100
Message-ID: <87muigbm95.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v4 00/11] tests/vm: serial console
 autoinstall, misc fixes.
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
 qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Gerd Hoffmann <kraxel@redhat.com> writes:

> This patch series changes the way virtual machines for test builds are
> managed.  They are created locally on the developer machine now.  The
> installer is booted on the serial console and the scripts walks through
> the dialogs to install and configure the guest.
>
> That takes the download.patchew.org server out of the loop and makes it
> alot easier to tweak the guest images (adding build dependencies for
> example).
>
> The install scripts take care to apply host proxy settings (from *_proxy
> environment variables) to the guest, so any package downloads will be
> routed through the proxy and can be cached that way.  This also makes
> them work behind strict firewalls.
>
> There are also a bunch of smaller tweaks for tests/vm to fix issues I
> was struggling with.  See commit messages of individual patches for
> details.
>
> v4:
>  - rebase, drop patches merged.
>  - use in-tree seabios binary, for serial console support.
>  - some minor tweaks.
> v3:
>  - python3 fixes.
>  - openbsd: configure memory limits.
>  - freebsd: configure autoboot delay.
>
<snip>
>   tests/vm: openbsd autoinstall, using serial console
>   tests/vm: freebsd autoinstall, using serial console
>   tests/vm: netbsd autoinstall, using serial console
>   tests/vm: fedora autoinstall, using serial console

For reference there are some minor conflicts with Cleber's copy cleanups
currently in my testing/next. The easiest fix was to apply to a clean
origin/master and then rebase it so I could deal with the conflicts in
git.

Currently testing it out:

  https://github.com/stsquad/qemu/tree/review/test-vm-serial-v4

--
Alex Benn=C3=A9e

