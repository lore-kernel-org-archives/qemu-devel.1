Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E33C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 11:23:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E706F206BB
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 11:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KDRACVHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E706F206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHnaD-000667-2K
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 07:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHnZO-0005Y5-8v
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHnZM-0004Np-SV
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:22:21 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33172)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHnZL-0004Ml-HD
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:22:19 -0400
Received: by mail-wm1-x344.google.com with SMTP id r17so2147447wme.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 04:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=AH3jPH+i0W+CL9FV2+ec+wh2iMgVkQ17kzaHGG5gOds=;
 b=KDRACVHg4JM2QDaxGzq33Hr6v1aUgQtTpr/qcExlHo+lwHns/jdWwmmc9Afem+QVuJ
 er+ghRT1ZiCeVQHQHj98msiqDV8IJahpdX7t7CaYGif+srMR8Tr9C+gjFzqtoAZNluRO
 GWyO/ALIfkiGIf5BeqGdocoWYJ3CRSEl36kKX91OjmsvRDf+kmqwgg3YdMkyr1BK3p7V
 ls+Hxt1ClMe1OR5zopimGt7CcpqrUc4hq3zUqwQ5bQxiIjSjh3uVXCawiR8T2AfPLs3P
 2qWXv7Nle8yU2kyoKChT1kjYLKEiLbsHOzVIMYmryKkAi9D8hAQry6upvHK9ZtiWKgIh
 Q2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=AH3jPH+i0W+CL9FV2+ec+wh2iMgVkQ17kzaHGG5gOds=;
 b=Hd5SgT+cmldUaAUYJK6OdA7QU1LWdb08nLxna3oSZk/7UAltP5ZHQSSs0LS4v1x1K+
 8e3/E6g2hbUlNYQslmTk1yQetTVOSYNqozoPCHDkHqzSagLSYdFc7fKh5XRf7QS2LNhv
 bBlkxXBmAB1VUSmx83sLioFIGtmDKX6Ur56xE18NlFstZbSMSGfWdznK6KQdQhvXxwSV
 TfcAiDtaA7EhzIDh5hUxMLQS+qLxRSKx5+ZZOoXVKTYgBbsLZwIU6gXv6akEoFB92jMu
 9WaDwu14zyqOSvZ82Ws4ZTxHcP0DvHS/4yVEmkgh9L5V8H0gWLry3NMM4W2/fHfqNMDo
 uJRQ==
X-Gm-Message-State: APjAAAWvo9GyWgSgM4EXlwIYGsesB3V12Vm35rem7jx+WNppZOkxW9gk
 aOJK0kwI3EkAxvd1bqJb39Xw2g==
X-Google-Smtp-Source: APXvYqxvllo9HT4rUPOwzhgqeiytmqeQFcC2Vv1lUt14kyTdXTfHmtTzDqArBpmF/gCgKqPBiss10g==
X-Received: by 2002:a1c:4e09:: with SMTP id g9mr3485437wmh.96.1570533737846;
 Tue, 08 Oct 2019 04:22:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q192sm4652163wme.23.2019.10.08.04.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 04:22:17 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 810641FF87;
 Tue,  8 Oct 2019 12:22:16 +0100 (BST)
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-7-f4bug@amsat.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
Subject: Re: [PATCH 06/19] hw/char/bcm2835_aux: Add trace events
In-reply-to: <20190926173428.10713-7-f4bug@amsat.org>
Date: Tue, 08 Oct 2019 12:22:16 +0100
Message-ID: <87y2xviis7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?utf-8?Q?Zolt=C3=A1n?= Baldaszti <bztemail@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Philippe =?utf-8?Q?Mathieu-Dau?= =?utf-8?Q?d=C3=A9?= <f4bug@amsat.org>,
 Esteban Bosse <estebanbosse@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> The BCM2835 AUX UART is compatible with the 16650 model, when
> the registers belong the the 16650 block, use its trace events,
> else use bcm2835_aux_read/write.

My only concern here is how we surface that detail to the potential
user. It's not a major thing as I assume most users of the trace points
are developers so maybe...
> diff --git a/hw/char/trace-events b/hw/char/trace-events
> index 2ce7f2f998..a7d477ab1e 100644
> --- a/hw/char/trace-events
> +++ b/hw/char/trace-events
> @@ -1,5 +1,9 @@
>  # See docs/devel/tracing.txt for syntax documentation.
>
> +# bcm2835_aux.c

"(accesses to the 16650 areas are logged via the serial_ioport_write tracep=
oint)"?

> +bcm2835_aux_read(uint64_t addr, uint32_t value) "read addr 0x%"PRIx64" v=
alue 0x%x"
> +bcm2835_aux_write(uint64_t addr, uint32_t value) "read addr 0x%"PRIx64" =
value 0x%x"
> +
>  # parallel.c
>  parallel_ioport_read(const char *desc, uint16_t addr, uint8_t value) "re=
ad [%s] addr 0x%02x val 0x%02x"
>  parallel_ioport_write(const char *desc, uint16_t addr, uint8_t value) "w=
rite [%s] addr 0x%02x val 0x%02x"

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e

