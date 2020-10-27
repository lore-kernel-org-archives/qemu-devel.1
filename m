Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0818C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 09:09:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FDB920747
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 09:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecu9+7X2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FDB920747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXKym-0006G2-5i
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 05:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXKxj-0005Ne-FW
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:08:15 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:46856)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXKxe-0007R6-Es
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:08:15 -0400
Received: by mail-ej1-x644.google.com with SMTP id t25so1085271ejd.13
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 02:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wKq+se10KdSNan2PBVkUfPeS0nLsbfuDsDSqTiukAZ8=;
 b=ecu9+7X2Ju7Z1y586sUC+Kx6abvNZRPAAXhfjmeWJvEKD99pzGCLOZ1YoBGXs08c8s
 VaTsOvtqDoMKXUNijSfxIZ6btagDwHRG+yYQtvF/a9mvl/Ts+szJca2vbO/3aSHS9BMx
 tU8RvxQTitFDhl1AvPzBL0WkZAbjY1U8Kjy3v6mzeCVxaDuNS0MZ+LuTTK1cg375oJfM
 /nrepNNmBoTwTlGicFYIlOIdd0Q+bXoEYM37/ABmwnC5Bs9Wh8RWQ6mQZ2XWCv8j12n2
 0aZjEKec4eBcPgGntzbTuYPCVLed+MIs5SL6uuOlTMhdvamYUxCd4b6Cuf7NTpq5Ul5m
 njxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wKq+se10KdSNan2PBVkUfPeS0nLsbfuDsDSqTiukAZ8=;
 b=X3XFbVNONd7X8x/XDdyP59RoL6aWdwoBlKQ4pCBT39fEpXPbe8XU+ovzzD3AA7UjHD
 ogR+TSL8UDiipJabJdQH/m9FsglkwpfQFDW+uujb6AoTIm79ciq0uc2uaiUlV8tI3RgU
 xpiohxHNiQNT/3lPKoNs2W9LTx9+5nBISYLmGGydOfQ8aMbgo2ZK1+O63t9q9oIXmBzJ
 tmhh32xrvL9BC65ykomX4U3N36eFvoSxsVg6rR0f5oARM+LqEFctDziiAHIflZuLHfqe
 A73orzKU4/tJ9CzmBUTUuSO9qWlh9cWrmpjBatJCEx9gV2yhwUFABg0ueZXgjkzl5Zl7
 CdJg==
X-Gm-Message-State: AOAM532w/C6rX/3oFGNkMRLoJQPQieO+gwiXYS2yxKgPZuSti9Q9skjv
 qSEiw3B4NuJAalJC6rprQNmGAMdvBJE=
X-Google-Smtp-Source: ABdhPJzTvdBpycQOpf3g/rxj/8PyjUoHibQWfDloghNreq2xYqKBNkxOClp8cZ1vzPJ6+ieat50ULA==
X-Received: by 2002:a17:907:4273:: with SMTP id
 nq3mr1406027ejb.439.1603789688592; 
 Tue, 27 Oct 2020 02:08:08 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id h26sm523056edr.71.2020.10.27.02.08.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2020 02:08:07 -0700 (PDT)
Subject: Re: [PATCH 3/9] dev-serial: convert from DPRINTF to trace-events
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 kraxel@redhat.com, samuel.thibault@ens-lyon.org
References: <20201026083401.13231-1-mark.cave-ayland@ilande.co.uk>
 <20201026083401.13231-4-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8fb3618a-d8e5-0907-1834-3d6740772df4@amsat.org>
Date: Tue, 27 Oct 2020 10:08:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201026083401.13231-4-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x644.google.com
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
>  hw/usb/dev-serial.c | 28 ++++++++++++++--------------
>  hw/usb/trace-events |  8 ++++++++
>  2 files changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
> index 77ce89d38b..abc316c7bf 100644
> --- a/hw/usb/dev-serial.c
> +++ b/hw/usb/dev-serial.c
> @@ -20,15 +20,8 @@
>  #include "chardev/char-serial.h"
>  #include "chardev/char-fe.h"
>  #include "qom/object.h"
> +#include "trace.h"
>  
> -//#define DEBUG_Serial
> -
> -#ifdef DEBUG_Serial
> -#define DPRINTF(fmt, ...) \
> -do { printf("usb-serial: " fmt , ## __VA_ARGS__); } while (0)
> -#else
> -#define DPRINTF(fmt, ...) do {} while(0)
> -#endif
>  
>  #define RECV_BUF (512 - (2 * 8))
>  
> @@ -205,8 +198,9 @@ static void usb_serial_reset(USBSerialState *s)
>  static void usb_serial_handle_reset(USBDevice *dev)
>  {
>      USBSerialState *s = USB_SERIAL(dev);
> +    USBBus *bus = usb_bus_from_device(dev);
>  
> -    DPRINTF("Reset\n");
> +    trace_usb_serial_reset(bus->busnr, dev->addr);
>  
>      usb_serial_reset(s);
>      /* TODO: Reset char device, send BREAK? */
> @@ -244,9 +238,11 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
>                                        int length, uint8_t *data)
>  {
>      USBSerialState *s = USB_SERIAL(dev);
> +    USBBus *bus = usb_bus_from_device(dev);
>      int ret;
>  
> -    DPRINTF("got control %x, value %x\n", request, value);
> +    trace_usb_serial_handle_control(bus->busnr, dev->addr, request, value);
> +
>      ret = usb_desc_handle_control(dev, p, request, value, index, length, data);
>      if (ret >= 0) {
>          return;
> @@ -326,7 +322,8 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
>              s->params.parity = 'E';
>              break;
>          default:
> -            DPRINTF("unsupported parity %d\n", value & FTDI_PARITY);
> +            trace_usb_serial_unsupported_parity(bus->busnr, dev->addr,
> +                                                value & FTDI_PARITY);
>              goto fail;
>          }
>  
> @@ -338,7 +335,8 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
>              s->params.stop_bits = 2;
>              break;
>          default:
> -            DPRINTF("unsupported stop bits %d\n", value & FTDI_STOP);
> +            trace_usb_serial_unsupported_stopbits(bus->busnr, dev->addr,
> +                                                  value & FTDI_STOP);
>              goto fail;
>          }
>  
> @@ -367,7 +365,8 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
>          break;
>      default:
>      fail:
> -        DPRINTF("got unsupported/bogus control %x, value %x\n", request, value);
> +        trace_usb_serial_unsupported_control(bus->busnr, dev->addr, request,
> +                                             value);
>          p->status = USB_RET_STALL;
>          break;
>      }
> @@ -431,6 +430,7 @@ static void usb_serial_token_in(USBSerialState *s, USBPacket *p)
>  static void usb_serial_handle_data(USBDevice *dev, USBPacket *p)
>  {
>      USBSerialState *s = USB_SERIAL(dev);
> +    USBBus *bus = usb_bus_from_device(dev);
>      uint8_t devep = p->ep->nr;
>      struct iovec *iov;
>      int i;
> @@ -459,7 +459,7 @@ static void usb_serial_handle_data(USBDevice *dev, USBPacket *p)
>          break;
>  
>      default:
> -        DPRINTF("Bad token\n");
> +        trace_usb_serial_bad_token(bus->busnr, dev->addr);
>      fail:
>          p->status = USB_RET_STALL;
>          break;
> diff --git a/hw/usb/trace-events b/hw/usb/trace-events
> index 72e4298780..e5871cbbbc 100644
> --- a/hw/usb/trace-events
> +++ b/hw/usb/trace-events
> @@ -320,3 +320,11 @@ usb_host_parse_interface(int bus, int addr, int num, int alt, int active) "dev %
>  usb_host_parse_endpoint(int bus, int addr, int ep, const char *dir, const char *type, int active) "dev %d:%d, ep %d, %s, %s, active %d"
>  usb_host_parse_error(int bus, int addr, const char *errmsg) "dev %d:%d, msg %s"
>  usb_host_remote_wakeup_removed(int bus, int addr) "dev %d:%d"
> +
> +# dev-serial.c
> +usb_serial_reset(int bus, int addr) "dev %d:%d reset"
> +usb_serial_handle_control(int bus, int addr, int request, int value) "dev %d:%d got control 0x%x, value 0x%x"
> +usb_serial_unsupported_parity(int bus, int addr, int value) "dev %d:%d unsupported parity %d"
> +usb_serial_unsupported_stopbits(int bus, int addr, int value) "dev %d:%d unsupported stop bits %d"
> +usb_serial_unsupported_control(int bus, int addr, int request, int value) "dev %d:%d got unsupported/bogus control 0x%x, value 0x%x"
> +usb_serial_bad_token(int bus, int addr) "dev %d:%d bad token"

In all formats, 'addr' is unsigned -> "%u".

Using %u:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

