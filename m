Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33250C2D0E9
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:12:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0CD820719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E2dEw/is"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0CD820719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHZnv-00071U-4N
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 17:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jHZn6-0006bh-KY
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:11:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jHZn5-0005WF-E3
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:11:52 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43786)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jHZn5-0005TA-3S
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:11:51 -0400
Received: by mail-oi1-x243.google.com with SMTP id p125so6875602oif.10
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 14:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OE8Lye9NhShSTcRWEbYa5K6qVq44jKR6cWPExWURM7U=;
 b=E2dEw/isqRMF+n4sWfjij6VOoa2dfGGgyRHHsvU2CBD0PzVQQE5+IREk+rn5nvej4r
 zlD4u8RNEtWnJW9V57fQayyRZy2YotNKLL6BOugZkRRup2gc7nfTJ+a1zqc41JoLvjfG
 AAgd8FQzzVvJUg8HfXH4o3zwYw3lrRDYbfqBMXyvVapuaQQFZdBsxn4WISDsyKo20dYp
 aRdkmDd3Me12lbxhk1/xBah4IT3DIOxlk58vJd33Y/iIBxRfzzIuhhe3WqeUgzub1R6r
 LtMHcXvNErT+EDezT1nTtNZX23XMZ2dq2xp8feBOAjXBNYe3ql3+CTtt+kP0UMZH0blz
 mlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OE8Lye9NhShSTcRWEbYa5K6qVq44jKR6cWPExWURM7U=;
 b=iie0sQtdXOHH5MAqH9k2d1le0FlUOEFneWLY+SJJO2S01iVbgTZAIeRIuuIUgbkr0c
 EU84GHwBAEZA0XtG4QwVLErIWe6fm06eLYXSErBSK+0lWL0AqFr65c0UN5l3oHmup37e
 BEF8qU7C2tw4KtcP/sOtAgHCRoKyqpZjlc/KTvM+bZG9wpaytwbSkEFHk6DOO0kiWCG2
 Th6iL9ZrsPsL55dFBoeVSGlFUvba0UhNbDSi+kTxMHltZLeBqF/o9a0Z8nw9LG3JGOjq
 Y/3nsIhw7fA6vJ+c7D5MwXAjkSRrHLg0p4RXRnY4mvZOIqBRHG57lK7AUHvxNQx/zCS3
 7Sgw==
X-Gm-Message-State: ANhLgQ1uqxC+Vcbb2WMqQH1NPB+9ItOp5e7QYiZtEa/pfjDqig0/Z2O+
 f9VeEOb2dwjTxRKYAWgjPyGemCwUhco/am69jjuOEA==
X-Google-Smtp-Source: ADFU+vsVGodCfKbOV5k1niK3Hr7mnj+ImnuHeIpIsOxVMcG1IppZ+AMts3LvN3uAUZHEqTNTBov59IRwZ+tOaJw53Kw=
X-Received: by 2002:a05:6808:64c:: with SMTP id
 z12mr1730698oih.146.1585257109669; 
 Thu, 26 Mar 2020 14:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200312201638.6375-1-peter.maydell@linaro.org>
 <a550ff78-f639-4048-ba2b-20cea1915d83@redhat.com>
In-Reply-To: <a550ff78-f639-4048-ba2b-20cea1915d83@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2020 21:11:38 +0000
Message-ID: <CAFEAcA8GMPAgxJrHwJZDWOmCWRnTPxb7+9UoAJqZAMpnWxXu=g@mail.gmail.com>
Subject: Re: [PATCH] hw/net/i82596.c: Avoid reading off end of buffer in
 i82596_receive()
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: Helge Deller <deller@gmx.de>, QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Mar 2020 at 06:13, Jason Wang <jasowang@redhat.com> wrote:
> On 2020/3/13 =E4=B8=8A=E5=8D=884:16, Peter Maydell wrote:
> > The i82596_receive() function attempts to pass the guest a buffer
> > which is effectively the concatenation of the data it is passed and a
> > 4 byte CRC value.  However, rather than implementing this as "write
> > the data; then write the CRC" it instead bumps the length value of
> > the data by 4, and writes 4 extra bytes from beyond the end of the
> > buffer, which it then overwrites with the CRC.  It also assumed that
> > we could always fit all four bytes of the CRC into the final receive
> > buffer, which might not be true if the CRC needs to be split over two
> > receive buffers.

> Applied.

Hi Jason -- this doesn't seem to have reached master yet.
Has it gotten lost somewhere along the line?

thanks
-- PMM

