Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC174ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 14:06:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91CFD20815
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 14:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MLz+zj/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91CFD20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFInA-0001sK-G9
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 10:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iFIkT-0007oE-SZ
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 10:03:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iFIkS-0006xx-CY
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 10:03:29 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41223)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iFIkS-0006wH-4B
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 10:03:28 -0400
Received: by mail-wr1-x442.google.com with SMTP id h7so15698373wrw.8
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 07:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=SBk+mw3TOLHz533KkD7hOTuvVUzZ0AmohD2RXnzjixQ=;
 b=MLz+zj/Sr06ei3Yayen/aKt7HP711Dr0aMLZz3KCKbuDL4AmiSMRIYLMqPWrtZU8T1
 Mo+9688zcf6Dh5H78/+kbl4HMpOvt9NYN+VELgpn2bGPjN1tB5CtBQ/gEWxneKj5o6yO
 v6Y5R4H2xGNpCyRS4+5iXbW5qK80I8JqfNr8QHBBK5lZRu6tvWknFSN9PXPW/LIul3Dg
 eYt+J/rVS8+KXISt2ssQJ3f+Qz759HtFl4ViNfUWUsS8MMrwy8d2zloIkkw2vvl4A9Cd
 dberucgn0BALO2ZL2vgDmnSeFPW3yKvN3jkz+x8Da6AHdleN3B6IJULYF1uKVqUSQ+mM
 YQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=SBk+mw3TOLHz533KkD7hOTuvVUzZ0AmohD2RXnzjixQ=;
 b=D/JLs1uWTWVofCe6+/KTP08sGM83VLECcnXZ+eXCi+tvB0KtF2zAqsh9XGvXaO9zYt
 2Nlf4xl53zUIzlmkQY2imOo9p4A+TuA5aWsHYEyhYvSoG/DYMjinGzwbrdB2KJE4/5r0
 mmvMUJRK1VfhwZAvkzEKSC5r42//2fp8UMKgj7PWoejfZ6r100zKoL4DaLSOa3ZJcM65
 fE2CRTfyhHjPeFFAa0hmG1RSmbU0jvg9XRmatv27qhf0LUIPydAiM1EIJkniDeZ3AckX
 G3Hn8ZS9/Lpp2iuL+fcGNYuMODxIk24ciiAkTdAlKYe3ZawYyyfP2/RTutSb+yMF3mn9
 1+5Q==
X-Gm-Message-State: APjAAAWGgfFDjW35LiAP+cgSV389PIu/1sd0d/rEM5akgDRZzwJf6e/r
 9FR5HjDhJKBUj3ekNpnBbFaRiQ8gCHI=
X-Google-Smtp-Source: APXvYqx2nVz2IiegpLV6abg2e2wIrNmZjgCzrc+OiRF7LFajxR3ybawL3Hy0YG6ZSUUlN5Ng5LadbQ==
X-Received: by 2002:a05:6000:186:: with SMTP id
 p6mr16735866wrx.136.1569938605342; 
 Tue, 01 Oct 2019 07:03:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c9sm2931641wrt.7.2019.10.01.07.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 07:03:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 877221FF87;
 Tue,  1 Oct 2019 15:03:23 +0100 (BST)
References: <20191001132609.23184-1-marcandre.lureau@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/3] Some win32 fixes
In-reply-to: <20191001132609.23184-1-marcandre.lureau@redhat.com>
Date: Tue, 01 Oct 2019 15:03:23 +0100
Message-ID: <878sq4lg0k.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: pbonzini@redhat.com, sw@weilnetz.de, berrange@redhat.com,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi,
>
> Here are a few patches that should fix some busy looping issues
> already reported >2y ago
> (https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg00420.html),
> and fixing test-char on win32.
>
> hmm, do we have any automated testing/CI on Windows (beside just
> cross-compilation)?

Not that I'm aware of. I did briefly look at CircleCI but never beyond
playing with my own experiments. Ultimately I find it hard to care about
Windows as I don't have a copy myself. Maybe someone else does care and
would like to explore further?

FWIW I believe Travis has Windows support now and there is also
AppVeyor. It's probably worth spreading the love around given how loaded
our Travis jobs are.

>
> thanks
>
> Marc-Andr=C3=A9 Lureau (3):
>   util: WSAEWOULDBLOCK on connect should map to EINPROGRESS
>   tests: skip serial test on windows
>   win32: fix main-loop busy loop on socket/fd event
>
>  tests/test-char.c  | 4 ++--
>  util/async.c       | 6 +++++-
>  util/oslib-win32.c | 6 +++++-
>  3 files changed, 12 insertions(+), 4 deletions(-)


--
Alex Benn=C3=A9e

