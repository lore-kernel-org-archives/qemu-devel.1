Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEF7C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:34:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAD1821E6E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J43tOgj3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD1821E6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvIKa-0003Aj-82
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 05:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57827)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hvIJp-0002Fp-M0
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:33:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hvIJo-0001Gu-L8
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:33:17 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33035)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hvIJo-0001GA-En
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:33:16 -0400
Received: by mail-ot1-x343.google.com with SMTP id q20so101583735otl.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 02:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6j1brw/JDjSUv3md8bS30d2/5N/78wTkxYE/O/zj6cI=;
 b=J43tOgj3BghWr49bCyQuuyrIhHNByOqaOUWUzm8dUVwzcMpeGJAaniUHeeeKqCNRGt
 +ZtdFW/+qa3ZDtWcT0h/7NBoIZqpX/ZxXoPnA5c02HowEsIIvC5KBYHVNNg/UplOztu6
 68D0fdYP7KHc8zim4xObBzgo58/prFqkFkZgY/P7lW0sBuAw4wS64vz/sQnDL8oPRSKx
 G+yHnq3EZUgBjvv4y3cHs3wI++o0NC3gWng/ntpQNzI9oQt5CzoQePba2i+5lZQT8Ey8
 advKEfRk/LONuNjUsmxR2B6kmFWpEgSckMp1ejifPWMvBivDOiHSMnNUyLIRxmhJP3CP
 ShgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6j1brw/JDjSUv3md8bS30d2/5N/78wTkxYE/O/zj6cI=;
 b=lOeNdGbdT7TFo8cmbqMKhX0yTx0lKyT6hgKsjADAap4i+ZZR8enA2e1piKOhMFIjfE
 Ml5zNtiG/BqqQ+omFzULICLAXW/k31AlfBdKIolZO8AmaP3tMFVSB4hUyIkNQp67KWUb
 j6Ae8MR0oAbTK0590J/pSwRsVNVVOvNUPNhyvkYJs+n4bFhQ4vAcAAAdv73RinAIF0n+
 csz7Whd+2OsctH/nT8cLUKt9OFkMDv1IQ2/HvaWzYSqZ2TxaiiIEPhmlYLE7IfmEqTAV
 H/Xk6XlLYSYcZf40YhP0zwupVo4qx3amCf9Y51C0OAvfKdlhLLKKfbB7w76peL7+3+gr
 Q0ng==
X-Gm-Message-State: APjAAAVTUDOEUbartB6JMdgNHggEQfXCSN4No/doatXV5EPAdWVmE3E4
 wA991aEEnor5CX4jpDqv0iKi9q6Rsk6G0mM0QyD13g==
X-Google-Smtp-Source: APXvYqzTSt9TwozaqeGhWKoD50WLqz7Rqq0zSr40AoxwI/Hf3GotAPM2M0UHzf4ly3uQFgLDIsizKVnUbrH7zE1fYf0=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr5457633oij.98.1565170395357; 
 Wed, 07 Aug 2019 02:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <1561574604-1204-1-git-send-email-eajames@linux.ibm.com>
 <CAFEAcA8W44gYFgU7qP9wOUSwZ7xFqqZ+2eWr=0hjKps=qvQMnw@mail.gmail.com>
 <057e55ed-c8f1-8c69-f7f0-c95df5955525@linux.ibm.com>
In-Reply-To: <057e55ed-c8f1-8c69-f7f0-c95df5955525@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Aug 2019 10:33:04 +0100
Message-ID: <CAFEAcA_W_9bn3RRLTorrE6uK4WUMwyu5F0Eg2sk6U6P7D3JrUg@mail.gmail.com>
To: Eddie James <eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH] hw/sd/aspeed_sdhci: New device
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
Cc: Andrew Jeffery <andrew@aj.id.au>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 6 Aug 2019 at 23:12, Eddie James <eajames@linux.ibm.com> wrote:
>
>
> On 8/5/19 9:31 AM, Peter Maydell wrote:
> > On Wed, 26 Jun 2019 at 19:43, Eddie James <eajames@linux.ibm.com> wrote:

> >> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> >> index 7b80b1d..51a733b 100644
> >> --- a/hw/sd/sdhci.c
> >> +++ b/hw/sd/sdhci.c
> >> @@ -213,7 +213,13 @@ static uint8_t sdhci_slotint(SDHCIState *s)
> >>
> >>   static inline void sdhci_update_irq(SDHCIState *s)
> >>   {
> >> -    qemu_set_irq(s->irq, sdhci_slotint(s));
> >> +    int level = sdhci_slotint(s);
> >> +
> >> +    qemu_set_irq(s->irq, level);
> >> +
> >> +    if (s->irq_notify) {
> >> +        s->irq_notify(s, level);
> >> +    }
> > Rather than doing this, just wire the irq lines from
> > the SDHCIState device up to your AspeedSDHCIState device,
> > and then have that update the register state and assert
> > its own irq lines outbound.
>
>
> Sorry I don't follow you at all. Isn't that what I'm doing here? Surely
> I need to take action when sdhci_update_irq is called. I don't see any
> way other way to have my code called at this time.

The way to 'take action when sdhci_update_irq is called'
is to be the function on the other end of the qemu_set_irq()
call, ie be the device at the other end of the qemu_irq line.
You don't need to modify this code in sdhci.c at all.

thanks
-- PMM

