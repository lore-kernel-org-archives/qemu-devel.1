Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EECFC3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 11:30:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A3B622DBF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 11:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c2rJSIm9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3B622DBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5TU7-0007sH-Gr
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 07:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5TSq-0006PW-8G
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 07:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5TSp-0006hg-1M
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 07:28:40 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37229)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5TSo-0006hS-SZ
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 07:28:38 -0400
Received: by mail-ot1-x343.google.com with SMTP id 97so17373557otr.4
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 04:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VCL5O+brxOnxbT2HQqJ65+K6Udat9GhNCBmzpXoRY3M=;
 b=c2rJSIm9FJKQqCIbnnDp5a/Rk/hlN3vmGvQoAuGZYJqBnByv+brG7xdHoHy/NjujaL
 W2khdpBGmQO7PsORBHPNob9LZdg92C0GWG4aUA7WonDRahtRRn1ewjHAqbQ8aA0cMCGo
 O3LZiqa00zlmTWOjOirqqU0CwWVLv5tMXHXKqchGtagXKu90aFPo6uONYP816QM9zCxv
 pa09DLvAzoK+ajaaH25CKg9rOzqcY3Nh1Lr6vHZ0rQli8XKTfpVyYAN5PAtYSMdt4871
 9iFYd50rkh9qEBzO/T0sxeB/3YxsAaOG0mQWqbtnH2ePx1krn1rpwU1ZE7VFcnYx5O40
 n+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VCL5O+brxOnxbT2HQqJ65+K6Udat9GhNCBmzpXoRY3M=;
 b=D5j+lkRy2D4E3bfZi/45dde+ZMzCaG+leIIQ7fPvtfTZi9R1tAvkCEmhM/nFSCCqAE
 Kyn+a3+1yhvjsVwwt1pS3NgA/VlikNvn7yFHJg+7FcKB7E4aCWAkpPjF7NkJGWJPC7mZ
 7nlmkx1t6zbs0Bqncg6SB3GOJfPD/3W4OFIt7SZk27jMwQ8EFoyTI7ig265DWg4XmNUC
 gMWybYVoTe2k1KBmTBRrfddkEg0U9dfrMJ8tasmOWYJwafz8WSwb8DaIwKvpFyRewbL7
 ldrsXR47bJ3/jOrqxBsXEJX+Gej7F47mXpEka4s0d7M7O8xhZIBE0cjSEtCFt6RypxUM
 dBIg==
X-Gm-Message-State: APjAAAX+hhXvNkF3esbQnejCLAL+kbkjlZPg5jAMk2WXx0QAUIXoI2nj
 ek3Q7UTmtO+Ap0u3SQUM1pwlyPx7m7CD9uJif8ZONg==
X-Google-Smtp-Source: APXvYqxivcTs6BcO/HQ6bXoMi3vaTA5wMwU8x+9Qn/OwiOtWD/xlg8m8R2FyOidmepkZEWaiSCCbnQN1bt7XN/ITjO8=
X-Received: by 2002:a05:6830:1015:: with SMTP id
 a21mr33430395otp.232.1567596516776; 
 Wed, 04 Sep 2019 04:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190902102122.1128-1-alex.bennee@linaro.org>
In-Reply-To: <20190902102122.1128-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Sep 2019 12:28:25 +0100
Message-ID: <CAFEAcA8Ekr=zqLwxxO2EnRGT5JfA5t6975gVeLAEsbM9Dz6OBg@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PULL 00/12] fixes for gdbstub, gitdm and testing
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

On Mon, 2 Sep 2019 at 11:21, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> The following changes since commit 23919ddfd56135cad3cb468a8f54d5a595f024=
f4:
>
>   Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20190827' i=
nto staging (2019-08-27 15:52:36 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-gdbstub-gitdm-testing-020=
919-1
>
> for you to fetch changes up to 4112aff7cdd932f273e920911a45a5d5a2d5d299:
>
>   tests/docker: upgrade docker.py to python3 (2019-09-02 10:52:22 +0100)
>
> ----------------------------------------------------------------
> Various maintainer updates
>
>    - fixes for gdbstub regressions
>    - bunch of gitdm/mailmap updates
>    - module fixes for Travis
>    - docker fixes for shippable
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

