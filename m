Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C65C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 09:10:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE69D20747
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 09:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGZqsM+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE69D20747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXKzg-0007Bo-A3
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 05:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXKyW-00067g-3f
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:09:04 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:41911)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXKyU-0007mi-Hy
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:09:03 -0400
Received: by mail-ej1-x642.google.com with SMTP id s15so1111512ejf.8
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 02:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5Sa7KkCToyFFdXLpqzmxWHyj6CfgnR+okIrghQJVwbw=;
 b=GGZqsM+BRI9IjpGjLB95A0/tbnF3P1adIiRr8JPATXjdHHZCP8F0kdcDBxVc0U0mUX
 j0Htv80sblpfEYmw6gvnPVUL27jWU+R/LuVIXd/MxUoliz/QJMsXGX3OTxfJvS7dpK2q
 jUsZiglVbuRnxu2bFqYH//jo/0xogcgQMeWzZP4uAIk4Cd8CJSVKoGycHQfjidkMoHHR
 6uBF8Aig/jUjkcRLZsKaEL+pXUB0xq5SbPM4C/oIDCHXnMDXvvUabdnpOz4TPWyW+DL9
 wScwpu20kvdT2DRZNeYonBMF7fnmwzEbaT1Ng7ZuoxnzIcQXJvMGlzf36tVN8cJeW8eD
 Gfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5Sa7KkCToyFFdXLpqzmxWHyj6CfgnR+okIrghQJVwbw=;
 b=hb+Z8bmexNCToePbIfg1tONoa/OfCRh11BBL3gFM/GVCwV2inZF0gnYoM5TUxHsWRE
 VwkdkZIVIO/8unfw21/aHqAi4mthTVVFRt3jMDDQilcwnwuYucDBudZcM5Lreg5AtoN4
 YZj24wHXBRXnX2bx0kMGK6hX6g4c3WSIgnRV+llWf1dIgKUzfPHNFISwTLGsRvapkPMk
 B2kUQpGWvHfmq7FKbC3pbaBb18QZIEpkVywm1FYdVkexO7H5kA1wx6pCqrwesMaK2Xmp
 bIak7aa3O9WG1YCbjUBRXlcQgO48bAjLimRwxgF75ftYqAi0Td17pL8gklDSPxdh0ICj
 6l1A==
X-Gm-Message-State: AOAM53228I+j2txBNUTGL6p9u0ZK6is+VD6RIfnQw9uJupnTeDHIN8w3
 Tz0iDqoSh3A5y5YrSmwOIPo=
X-Google-Smtp-Source: ABdhPJyGIAAQGzKdFK6PQASfkEfMrHnKJAWEX9j+YIQRZZRAnsCp0ZK2s2OWQeEIl9jb3ZWRAy8BHw==
X-Received: by 2002:a17:906:53d6:: with SMTP id
 p22mr1348490ejo.517.1603789741139; 
 Tue, 27 Oct 2020 02:09:01 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id s12sm536915edu.28.2020.10.27.02.09.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2020 02:09:00 -0700 (PDT)
Subject: Re: [PATCH 4/9] dev-serial: add trace-events for baud rate and data
 parameters
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 kraxel@redhat.com, samuel.thibault@ens-lyon.org
References: <20201026083401.13231-1-mark.cave-ayland@ilande.co.uk>
 <20201026083401.13231-5-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7becc50e-ef9f-d878-ab45-d80706c3fc0c@amsat.org>
Date: Tue, 27 Oct 2020 10:08:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201026083401.13231-5-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-2.167,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/26/20 9:33 AM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/usb/dev-serial.c | 3 +++
>  hw/usb/trace-events | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
> index abc316c7bf..badf8785db 100644
> --- a/hw/usb/dev-serial.c
> +++ b/hw/usb/dev-serial.c
> @@ -307,6 +307,7 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
>          }
>  
>          s->params.speed = (48000000 / 2) / (8 * divisor + subdivisor8);
> +        trace_usb_serial_set_baud(bus->busnr, dev->addr, s->params.speed);
>          qemu_chr_fe_ioctl(&s->cs, CHR_IOCTL_SERIAL_SET_PARAMS, &s->params);
>          break;
>      }
> @@ -340,6 +341,8 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
>              goto fail;
>          }
>  
> +        trace_usb_serial_set_data(bus->busnr, dev->addr, s->params.parity,
> +                                  s->params.data_bits, s->params.stop_bits);
>          qemu_chr_fe_ioctl(&s->cs, CHR_IOCTL_SERIAL_SET_PARAMS, &s->params);
>          /* TODO: TX ON/OFF */
>          break;
> diff --git a/hw/usb/trace-events b/hw/usb/trace-events
> index e5871cbbbc..9e984b2e0c 100644
> --- a/hw/usb/trace-events
> +++ b/hw/usb/trace-events
> @@ -328,3 +328,5 @@ usb_serial_unsupported_parity(int bus, int addr, int value) "dev %d:%d unsupport
>  usb_serial_unsupported_stopbits(int bus, int addr, int value) "dev %d:%d unsupported stop bits %d"
>  usb_serial_unsupported_control(int bus, int addr, int request, int value) "dev %d:%d got unsupported/bogus control 0x%x, value 0x%x"
>  usb_serial_bad_token(int bus, int addr) "dev %d:%d bad token"
> +usb_serial_set_baud(int bus, int addr, int baud) "dev %d:%d baud rate %d"
> +usb_serial_set_data(int bus, int addr, int parity, int data, int stop) "dev %d:%d parity %c, data bits %d, stop bits %d"
> 

Using "%u" for addr:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


