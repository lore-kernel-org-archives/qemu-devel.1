Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E0CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 13:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4F532063A
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 13:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z+DfXpvz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F532063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixWom-0007kU-6O
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 08:58:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39102)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixWo5-0007Bt-0v
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 08:58:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixWo2-0007kK-MY
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 08:58:00 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45197)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixWo2-0007g5-GP
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 08:57:58 -0500
Received: by mail-oi1-x242.google.com with SMTP id v19so7264855oic.12
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 05:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=R9rqJ2nDE5PRDufyA4kHvKJRoc0we2B1RMNZKjx6DCg=;
 b=Z+DfXpvzy+UuadKFJ0FxDP4vwr+LXIuStfbDPzJ3hKpN2Dth0CX686VrVfd7Wl6RMT
 64BWRsBfhZbr1rqHyUxzQcW0Hgq3G8+Dih5G6K1RdGJw5b70kJs7exIIpvL+26RmN+/B
 l6Z+kUxDEN17D8VIyeUYsVAFN5MXrJtOBy+PazI2oHNP+NstK9SXsgDcBI7iqqvyLp7X
 u1ncRc8bcxo/6bHp4svQvCQYFz1ybFOTYk6PyF2XAcRpFhfVEV7BXMH5mPBq0q9QwuK8
 MYTBWL0LGUFxeVoZ3smTlMRkgOo+xyZQ6iRVfAHgJQQCZcdnCDzGtyLcw/vxtb/W41e0
 yadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=R9rqJ2nDE5PRDufyA4kHvKJRoc0we2B1RMNZKjx6DCg=;
 b=qDriiymbK5t3sTm8U1W3bjXRm5R3rjDEBmoyXZH74hkOHQNiFDcLZIN8YCX3OX31VW
 RjqLjs6suA50QDbSLuLu6+LYJ0cLY7id3ff2KTEJRCKD/E1UeM6A7pauV3FxWVxkwwiu
 kDf8VDoUP6BDvZ/FaFH5bdvzfYzHD+CnD+Wfs/Xdj4phorLxSiNeJNfSIZ0qzwJwXUyO
 Sm0E/B+mFxnHPxbPKafpxFu+whKQJsCzAOCrp338n7M9O/XMGHRQE5S2r0K41pg0vDHn
 MVczcQTiwKYZZAZc/2eSZ3oSx+j4H1UtIWY5hZISgy7E4J27NRGjfmYc76E6lpphMBaq
 ET7Q==
X-Gm-Message-State: APjAAAULDXi6YREbtjXUeXj1nsZalbhn1KvhwePA8G4uLPvOn9nP42Rh
 lalvB5jtCN6ZHI4NKAoTNOjitBSSE/npNMuVYhMGdA==
X-Google-Smtp-Source: APXvYqxt6gcw3MQCjsimIj6/EjhhRb4wGjhaF8LTwMRYpgKKDYeiVtfzaXi3S2DO+1zw/pQ/nwL2zkPKomditwcnyPY=
X-Received: by 2002:aca:7514:: with SMTP id q20mr6189062oic.48.1580479077113; 
 Fri, 31 Jan 2020 05:57:57 -0800 (PST)
MIME-Version: 1.0
References: <20200130213814.334195-1-stefanha@redhat.com>
In-Reply-To: <20200130213814.334195-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jan 2020 13:57:46 +0000
Message-ID: <CAFEAcA_=_8ZFC=DF3UkqvWqvjQsCHjc=_fYcMmbXs=iLp7JrcQ@mail.gmail.com>
Subject: Re: [PULL 0/5] Tracing patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Jan 2020 at 21:38, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 928173659d6e5dc368284f73f90ea1d129e1f5=
7d:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-202=
00130' into staging (2020-01-30 16:19:04 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to e144a605a614d22165000c69e8e1dc6986d45cd8:
>
>   qemu_set_log_filename: filename argument may be NULL (2020-01-30 21:33:=
50 +0000)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------
>
> Peter Maydell (3):
>   docs/devel/tracing.txt: Recommend only
>     trace_event_get_state_backends()
>   memory.c: Use trace_event_get_state_backends()
>   hw/display/qxl.c: Use trace_event_get_state_backends()
>
> Philippe Mathieu-Daud=C3=A9 (1):
>   Makefile: Keep trace-events-subdirs ordered
>
> Salvador Fandino (1):
>   qemu_set_log_filename: filename argument may be NULL

Here's a weird one -- with this pullreq applied I
see a new warning running check-tcg on the linux-user
static config build:

  TEST    linux-test on aarch64
  TEST    testthread on aarch64
  TEST    float_madds on aarch64
  DIFF    float_madds.out with
/home/petmay01/linaro/qemu-for-merges/tests/tcg/aarch64/float_ma
dds.ref
  TEST    fcvt on aarch64
warning: TCG temporary leaks before 0000000000400a0c
  DIFF    fcvt.out with
/home/petmay01/linaro/qemu-for-merges/tests/tcg/aarch64/fcvt.ref
  TEST    pauth-1 on aarch64
  TEST    pauth-2 on aarch64

but I'm not sure why any of the patches here would have
provoked that, unless they're now causing a log message
that would previously have been suppressed or directed
somewhere else to be emitted.

thanks
-- PMM

