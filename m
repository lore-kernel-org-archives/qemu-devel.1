Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0463FCA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:00:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C18372089C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lxaF4xje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18372089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLVbm-0002XJ-IB
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 13:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iLVa4-0001F9-1i
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iLVZy-0003us-QR
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:58:21 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46105)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iLVZy-0003sP-Ku
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:58:18 -0400
Received: by mail-ot1-x343.google.com with SMTP id 89so5513476oth.13
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 09:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6Vw5JEKY7XK+klh3K7KSH90DzcAkWBFboMgSM3fJzrM=;
 b=lxaF4xje6lcouaosLDnZySZ5fBy1TcoNQAIlCnOLH5LRSTA2qIQCQkEQjR+gKFFQ75
 xrYAL1Fj4iNsEyVaZUcnMmCnp/wmbsZxuFQNljgh1EBKPKQ4pmu7cLdC2Ov9DAOjxidT
 xkH8+Ur/oxxQ+UpDmkDoJmKH9Hd38rZ4gYm6vXMPHDYY2ubc5w6s+Q6XE6D+TWdBF5Vg
 ONrtRWrWwhWg3Ks/0aYVG8i2mapsmofeBOnkZxMf7EmcjypJgagVmn8EtZk3dvDBkLgl
 8jdjremQCufHb5hCj4FPjOhF70Aii48739VxN4JBJFJpSs2tS3KhNqpbVrzqCb+2dkxw
 jzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6Vw5JEKY7XK+klh3K7KSH90DzcAkWBFboMgSM3fJzrM=;
 b=KotReqPSgGcU8cjUqa9hWO0xSxfWPIIVaqm+KqW0++sDYg+iaqCaDRSPGcA619eVWO
 OB1PLl+KI36NakGbcejXpkmwQdvo+z9/zhzipyha6rU40kDTVORppO1oL7oRxuGKzjbl
 B45zjz7ZlKHowYegnlJuxqAfqIYHsXgaxSsglBO4SeGKES/W/++OCMRjwYV7jEbpme5k
 MFG+qoDHgOFwDEsCXK8x2Fym3Bnerv+iERzE+l+uxCePXwIqZVsG8vRy6jUqHzQWjKz3
 2sn1OMrFUcFJOjHZjJU78dhg4nGRPFkDjbWC6gEyy3D0nAxZs8FQy9elkjLwWnku/vFK
 DrtA==
X-Gm-Message-State: APjAAAVPCtRCwqvYjIhiEaqa5oAf0EBeYVj9o+wzxU2zBlqyZUveuV7P
 x63lnI7TTZ8EkO1gkFeeUezI1T9e5M2OOb06m9KrHg==
X-Google-Smtp-Source: APXvYqxkcsoqCta1MhtmAKTy73mVp3pS7kqGfbGzBj4nNg94RPrdBk8cXyfcW4j38k+2v+8oNLGJmXmcL2sGERpQbFE=
X-Received: by 2002:a05:6830:4c1:: with SMTP id
 s1mr8796928otd.232.1571417895348; 
 Fri, 18 Oct 2019 09:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191018154212.13458-1-marcandre.lureau@redhat.com>
 <20191018154212.13458-13-marcandre.lureau@redhat.com>
In-Reply-To: <20191018154212.13458-13-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2019 17:58:04 +0100
Message-ID: <CAFEAcA-Sf=rc89R+H3VwHwB52RW=BfA2VU70-OcNPx=MJD+zaA@mail.gmail.com>
Subject: Re: [PATCH 12/14] omap-gpio: remove PROP_PTR
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Oct 2019 at 16:43, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Since clock are not QOM objects, replace PROP_PTR of clocks with
> setters methods.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> -/* Using qdev pointer properties for the clocks is not ideal.
> - * qdev should support a generic means of defining a 'port' with
> - * an arbitrary interface for connecting two devices. Then we
> - * could reframe the omap clock API in terms of clock ports,
> - * and get some type safety. For now the best qdev provides is
> - * passing an arbitrary pointer.
> - * (It's not possible to pass in the string which is the clock
> - * name, because this device does not have the necessary information
> - * (ie the struct omap_mpu_state_s*) to do the clockname to pointer
> - * translation.)
> - */

Ah, here's what's effectively a todo comment that you could
repurpose/adapt/move.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

