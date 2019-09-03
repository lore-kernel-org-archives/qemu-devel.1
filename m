Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733C2C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39C6722CF8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HSxfQvqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C6722CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5BYn-0004l7-Pk
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5B2m-0004yF-6k
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:48:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5B2k-0005ah-Ug
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:48:31 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:42265)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5B2k-0005a0-Oh
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:48:30 -0400
Received: by mail-oi1-x22a.google.com with SMTP id o6so13113267oic.9
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 08:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=H7XWw+MCWtnJlo+7DiYoAH4yPNpwaey8jlUMgVch4TM=;
 b=HSxfQvqNG3V1gvuhmYNQ2KQvkdWkVRmJHxzOq2HU/kvJK2u8pZoYqcHCOY5e/3W4Fu
 JZrPwEYH/E+1m/M4ia7OddW2sMH1zlfLqTzHW4BjQREDaAbkzPYZOwdK1359F+htIKlw
 rMraWy06HcTcMuJIbI0LO7T3EEDPPePZ8zz+l4wUSeIkBwDYQhz9v8LpAqmerxID53PF
 oL13KBYrv9rLgtEIRTWduzE/67+NnYHuMjlRpN9+KAtdUKRFCFPkq5ldHn5c5KW3QOdH
 Uv5vMx9mGTdVe8vhTitJ/jUMy0T2jMDN5fJWfNH/Ae8uRdN65psZE8N7x4YXncfWB+Lj
 9MLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=H7XWw+MCWtnJlo+7DiYoAH4yPNpwaey8jlUMgVch4TM=;
 b=blvFnFKuZNUPAbJk0Wq1fqAHba/FH/bjiEAfQ+/7vYDWXHSaxiHpAFVV7HtdjjqVRF
 3IS1HLkuZ6mIVG7IVVm2qpkTjVzRLeYdtRHQihUDwZC3NC7tFURV3iZEDbEvUCBRXc+O
 fFnoTr6amhD8wbPEcTzoZpXEK6zyVI1oETLfFHLuOEPvY38pKmxAek3awc78YrXADo/e
 Ej8YEoM9iBBS1AWJ7GkGcjvcfVIn1NQQn/D5jel6bfyBe4XaTAFJ4WULMkfHNUCx425a
 lCaHuES07P/8a1ftMW+x5R/llIpE3gG8nqTJo2yqkTT0qU89bZozDpw4hirhNdo5n99U
 NRHA==
X-Gm-Message-State: APjAAAVE98pFR/lrSGLhgkW5jpMNVpPbfzI112UAzcO0sPy2WkpF7hWz
 RKOKEFADFPXVR+zY6Zr+6fn+muiFGfYrHOLhBUt+zg==
X-Google-Smtp-Source: APXvYqyGJoZtfcUkvCF+5jLEZzmS4YrgZKFBa+Q1nqVrBXck6t+rmZpjmecoPFEo0Kf1bFbgO+X2PwCN/aBeo5vXlD0=
X-Received: by 2002:aca:50d8:: with SMTP id e207mr516147oib.48.1567525709634; 
 Tue, 03 Sep 2019 08:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190828192340.14025-1-ehabkost@redhat.com>
In-Reply-To: <20190828192340.14025-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Sep 2019 16:48:18 +0100
Message-ID: <CAFEAcA_=bDSbSqo17HvrD3pv+126695W+LfyXMfGXNCGemffAA@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
Subject: Re: [Qemu-devel] [PULL 0/2] Python queue, 2019-08-28
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 28 Aug 2019 at 20:23, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit 23919ddfd56135cad3cb468a8f54d5a595f024=
f4:
>
>   Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20190827' i=
nto staging (2019-08-27 15:52:36 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/python-next-pull-request
>
> for you to fetch changes up to 406ab2f331555cfcf320fe2a77949d7f8af7ab32:
>
>   configure: more resilient Python version capture (2019-08-27 16:57:24 -=
0300)
>
> ----------------------------------------------------------------
> Python queue, 2019-08-28
>
> Bug fix:
> * configure: more resilient Python version capture (Cleber Rosa)
>
> Cleanup:
> * BootLinuxSshTest: Only use 'test' for unittest.TestCase method
>   names (Philippe Mathieu-Daud=C3=A9)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

