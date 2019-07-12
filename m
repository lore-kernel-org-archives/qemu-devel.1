Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B16BC742C7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 15:15:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECC2B206B8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 15:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SykJTpuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC2B206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlxGm-0003ib-3C
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 11:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57874)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hlxGa-0003Cl-2z
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:15:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hlxGZ-00034w-0i
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:15:20 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:45288)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hlxGY-00033i-P2
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:15:18 -0400
Received: by mail-ot1-x32f.google.com with SMTP id x21so9756857otq.12
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 08:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=uCC0QRT7wl/ESzJcBXz00+kNWd+AUgQbPJeFfirFU5w=;
 b=SykJTpuTojGjr/I4DMf2bizaJCIbs+dF21ALj+i/8kl+73GJtQC+3mQHJSonqQVt8N
 H6tqnW7vV9QQY8p9XtLgEPPzLZQFXpYeRqeImy+DeDYCTu4oG6dYECW3V6/WiIFGo+kW
 OfKo1FMOFZkkx4NeBYHRr6jBlGoAUtJzF1iCB4b4DkTz+kti6c13kLJdIiqVESOYoZUB
 jaLkqu1K3Z3+GXbtzKdQ1ESdOFg91hTaCY0V7G49YSLoRooxR4i+B5MjR0FrgXOSAE7g
 ADL34vKS3VY1AFsFh9DRzfembR55AIN77jpQOUDNueYDQnow4ikGUocP0jo3GYVPvarZ
 lN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uCC0QRT7wl/ESzJcBXz00+kNWd+AUgQbPJeFfirFU5w=;
 b=uZ1hugAQjXe01/xVMKeww7NFv1bdst6OHhBTCvIBpTAGBZcUBXNLneLL+iP/HBjKd4
 Rk2pCyxtH+/q93MTwwr05rpnvsMkajjuiLhmzH17zj8qgzU4Y/m8FWZYKJsycqDgANq/
 TvXouXRXPisH1xatW9mEUpzIU3eXTtApcLsbPdZjTGRRIrfNxMQ4Lpa82wotwb6K1Pbp
 iL+L6Nm1c7+iVhoW0ULqcV6Wvg/i99ql0uZaqvUujsA0bkvWBMXr/zjfPgRQTgWHivBZ
 SbVBTlyoCLJuL0FTYElkWG96o33hWrTjGPXqu9bMmoY72pik49EMQDAUpm5/QMmySjBN
 +LDA==
X-Gm-Message-State: APjAAAVqleZxj+BRdTl0CI+SH7Y9IMR1bS2RjuQw0RBd9fdVnSWrWVlj
 td9Gd0LQ6PBdGQlyRRfaTVAODyERJOuAfy1UBCTCiQ==
X-Google-Smtp-Source: APXvYqzF48Y3nqjpXYNG9EfJ338xcS1cSO/+OlFG4VkHOOpqxUo4PInTXr/O6hZ25psL5l4GsRDDjjYELqkxzAAABMs=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr3721792otn.135.1562944517575; 
 Fri, 12 Jul 2019 08:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190711155703.15627-1-philmd@redhat.com>
 <20190711155703.15627-3-philmd@redhat.com>
In-Reply-To: <20190711155703.15627-3-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jul 2019 16:15:06 +0100
Message-ID: <CAFEAcA8RQDOJNgyWSpr5L0sgXoxvoToU3EGTX8O0+D5kmeMegg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32f
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v4 2/5] hw/block/pflash_cfi01: Use
 the correct READ_ARRAY value
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
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 11 Jul 2019 at 16:58, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> In the "Read Array Flowchart" the command has a value of 0xFF.
>
> In the document [*] the "Read Array Flowchart", the READ_ARRAY
> command has a value of 0xff.
>
> Use the correct value in the pflash model.
>
> There is no change of behavior in the guest, because:
> - when the guest were sending 0xFF, the reset_flash label
>   was setting the command value as 0x00
> - 0x00 was used internally for READ_ARRAY
>
> To keep migration with older versions behaving correctly, we
> decide to always migrate the READ_ARRAY as 0x00.
>
> [*] "Common Flash Interface (CFI) and Command Sets"
>     (Intel Application Note 646)
>     Appendix B "Basic Command Set"
>
> Reviewed-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Regression-tested-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---

These changes look correct as far as they go, but are
we sure that command value 0x00 will never be a valid
command in some future version? If it ever does, then we
have a problem because we can't distinguish "0xff with
a silly encoding" from "really 0x00" in the incoming
migration data stream.

If we're 100% confident that there will never be a true
command 0x00 then this approach is OK.

thanks
-- PMM

