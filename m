Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C6BC04E84
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 16:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F2082070D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 16:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agdoOOaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2082070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39665 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVfPy-0005Nc-Qh
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 12:57:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hVfM0-0002R0-8A
	for qemu-devel@nongnu.org; Tue, 28 May 2019 12:53:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hVfLy-0001Yp-7Y
	for qemu-devel@nongnu.org; Tue, 28 May 2019 12:53:36 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hVfLX-0001Mw-It; Tue, 28 May 2019 12:53:09 -0400
Received: by mail-wr1-x441.google.com with SMTP id s17so21037067wru.3;
	Tue, 28 May 2019 09:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=o1Rh6aAz7/4cgvDMz1Ecw+CCDWO53nq22FgF1mLIcWQ=;
	b=agdoOOaNC9/nfIlJcLGjGMkNPuLNoZgT+k0cymTinZwa4gU65JwrgQQNgCzQEnvW5z
	DVXsCjHFXTUBmMd4jh+j3XOEE8Mf44ZYZJwc6fYJUi+NRIn4dkYwmGbdgcxUg72u7VAQ
	ZRvEcjaCGl13phXVDOC4aUY5BCJbdJWp4tqA7zzM1Z4QtAh4hcYFcWCYclwiEntoSxVk
	ZPJ0sItXDGny33aqDC+3inNt9sb1hF8KGxOf6B4zUfH5yHRIWyX4GecUm3kzUQx7ZqeJ
	8EJsjOFF19QkQ+hTWkAiCttYDC0xL9uygdN/U7T09ov1whw6FIBJXMMbM4cexzXj/Pui
	OR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=o1Rh6aAz7/4cgvDMz1Ecw+CCDWO53nq22FgF1mLIcWQ=;
	b=PqX9pUn3j8eNg+QVa2DGqA6TFK7oNJ1/lzDxg+yrB+5ut8CWuEZt/GfZJNAhccyt8A
	iTcjScTvBR+DMmTg4Vp2cUGhp71M24kBqGHVApHEeB0gQ087YLEU/v1UK89Tl79A8M3u
	KumCHJnke4XK6TR+IOB7ppLT6rTHc/7Y8EjR/lNziFIX0Wf9vcM7su0POxBZWKFZuP2L
	lULLgeK7bkJ6GaWjj4dOj1o6cIlyTptxsm5Zpzx5+ERQU6+TcIWhl4jYOSX1tmAVy6Sh
	a3qKUy0JQ+0vJzdaAWNvPuY07j0sldFoa0Jdejp+rcTzMxuxL0j4rPtU8fE2sh/H5n3G
	bYkA==
X-Gm-Message-State: APjAAAVgbuFht28zGTqt2oFKUKMVJWpJdp/1yPrQ53D1QkNOJxFwhlz0
	Xfjl8zvgTgdW9DYLNrfeINc=
X-Google-Smtp-Source: APXvYqwu/EUzjYtiB+Gpx9oMDQTXN9PK/KPhItPIr+m0N6CbU9sV0c0pJO6Ji04OhMz8IPL3kQMqPQ==
X-Received: by 2002:a5d:6108:: with SMTP id v8mr23321286wrt.150.1559062385960; 
	Tue, 28 May 2019 09:53:05 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.27])
	by smtp.gmail.com with ESMTPSA id
	a10sm17015781wrm.94.2019.05.28.09.53.03
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 28 May 2019 09:53:05 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20190528164020.32250-1-philmd@redhat.com>
	<20190528164020.32250-8-philmd@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <003b3855-8180-b808-03c6-1e3fb160a1a7@gmail.com>
Date: Tue, 28 May 2019 19:53:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528164020.32250-8-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v2 07/10] hw/isa: Use the QOM DEVICE()
 macro to access DeviceState.qdev
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
	Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Markus Armbruster <armbru@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Michael Walle <michael@walle.cc>, Gerd Hoffmann <kraxel@redhat.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/28/19 7:40 PM, Philippe Mathieu-Daudé wrote:
> Rather than looking inside the definition of a DeviceState with
> "s->qdev", use the QOM prefered style: "DEVICE(s)".
>
> This patch was generated using the following Coccinelle script:
>
>      // Use DEVICE() macros to access DeviceState.qdev
>      @use_device_macro_to_access_qdev@
>      expression obj;
>      identifier dev;
>      @@
>      -&obj->dev.qdev
>      +DEVICE(obj)
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>   hw/isa/lpc_ich9.c | 2 +-
>   hw/isa/vt82c686.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index 031ee9cd93..35d17246e9 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -412,7 +412,7 @@ void ich9_lpc_pm_init(PCIDevice *lpc_pci, bool smm_enabled)
>                                    true);
>       }
>   
> -    ich9_lpc_reset(&lpc->d.qdev);
> +    ich9_lpc_reset(DEVICE(lpc));
>   }
>   
>   /* APM */
> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
> index 85d0532dd5..d46754f61c 100644
> --- a/hw/isa/vt82c686.c
> +++ b/hw/isa/vt82c686.c
> @@ -369,7 +369,7 @@ static void vt82c686b_pm_realize(PCIDevice *dev, Error **errp)
>       pci_conf[0x90] = s->smb_io_base | 1;
>       pci_conf[0x91] = s->smb_io_base >> 8;
>       pci_conf[0xd2] = 0x90;
> -    pm_smbus_init(&s->dev.qdev, &s->smb, false);
> +    pm_smbus_init(DEVICE(s), &s->smb, false);
>       memory_region_add_subregion(get_system_io(), s->smb_io_base, &s->smb.io);
>   
>       apm_init(dev, &s->apm, NULL, s);

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel


