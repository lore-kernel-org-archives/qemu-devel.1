Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE471ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:37:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A1DA2067B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QPr80sNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1DA2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK2P8-0003gt-Kk
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 11:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2OP-0003Bf-14
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:36:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2ON-0001ve-R7
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:36:16 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42903)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2ON-0001vL-LJ
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:36:15 -0400
Received: by mail-oi1-x244.google.com with SMTP id i185so14067494oif.9
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 08:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=aon3RehBDE2fWEQvWFNGKmlKtZuPKRHzLBFzBefocu4=;
 b=QPr80sNjdoNP3bzzbitYefaMoSWseR/mI/x9enTwKMYw6m0ioxtpjZPLIKCllr+yOW
 UhR/pJxHhZ1aVtnFKxdpXIM1q92kbXXSDplG/fB6gTO5H2Z2QmPawIcYDXsJHoevcHzQ
 tzwxUKkK8lmXoyh7KlorAKULmYnLGhWSys84aQq5qyZ1GWWdfs5lfCPIAHogFqOrpLh1
 2Di5dj8hYduToLriyf1xNEDB00soKPcB1cbX4Kb2+8p+xpks1S/G4+Wi2bFG8R7MoFxQ
 wUOTarqzqZEmdh9ryS3kE+9/Hz/E7WtLAi6WudUG37VMqeumcUhO5sx+WmqJEqhRbE5+
 y7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=aon3RehBDE2fWEQvWFNGKmlKtZuPKRHzLBFzBefocu4=;
 b=UBq5FsWDY3hQnZjD7jJTw/ZPvYCdzQFFfx+JrLPg59mLWHQosuV/ZGROn52IqkqEkU
 grPZNprT4ppQvw9/WDwurSlFGXTpopGc3O6g5/RdnvLnn8XGms+WJRcldSMU7rNTtfjB
 ZoL93zLWKr5eM58fOIfsSucnCOqqJX0UJDXCY623b5mk2qC8MNyZ5i4zrMQUQ9/VZjqM
 94WkKC7m4GD2AwXSxyxALwKJHectVKC6QxmJ9ohLimO1hhBZx3qSy865IQ5CfWSqfKxp
 7t1oqCjtFWm5mXnOMDck5Xb5ef5m/viyjFm86nPbRQFwlK5fJ/H9FwQ3Rpj6UT2zGpLp
 TDpA==
X-Gm-Message-State: APjAAAUupWyqcr8fhG5Ka/N2E/9r8BiL+3cPiD4t8RvNg/eFR673rOkl
 z23PI42y0fv8s4xTlqmM/MvQviC8zYnqqPirBgXNGQ==
X-Google-Smtp-Source: APXvYqy2D/G39aB1GnSiqwrIK4W3tLfK9yKU+UrcvAl3MJ7edbzAIkfs/Zk0bolZu6PUe6TNfOeKtlJwKLtXcRZLKU0=
X-Received: by 2002:aca:3b41:: with SMTP id i62mr23694683oia.48.1571067374864; 
 Mon, 14 Oct 2019 08:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-7-f4bug@amsat.org>
In-Reply-To: <20190926173428.10713-7-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2019 16:36:03 +0100
Message-ID: <CAFEAcA-cbTqYaRr8epJVgUV+tkGgCuf__aM3GxRzbKuqgWfPYQ@mail.gmail.com>
Subject: Re: [PATCH 06/19] hw/char/bcm2835_aux: Add trace events
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: =?UTF-8?Q?Zolt=C3=A1n_Baldaszti?= <bztemail@gmail.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 26 Sep 2019 at 18:34, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> The BCM2835 AUX UART is compatible with the 16650 model, when
> the registers belong the the 16650 block, use its trace events,
> else use bcm2835_aux_read/write.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

> +    if (is_16650(offset)) {
> +        trace_serial_ioport_read((offset & 0x1f) >> 2, res);
> +    } else {
> +        trace_bcm2835_aux_read(offset, res);
> +    }

I'm not really a fan of this. I would expect that if I turn
on the trace point for reads from the device that I see all
the reads, not just a subset of them. The device may be
minimally software-compatible with a 16650, but it isn't actually
a 16650, and there doesn't seem to be much point in sharing
the serial_ioport_read() tracepoint.

thanks
-- PMM

