Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C14C83008
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 07:21:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D38C206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 07:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjN4GTQa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D38C206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTKYK-00073m-Mr
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 03:21:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTKUt-0002Wg-4d
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 03:18:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTKLy-0006B5-SL
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 03:12:38 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39968)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTKLy-0006Ab-G9
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 03:08:26 -0400
Received: by mail-wm1-x341.google.com with SMTP id u16so1551948wmc.5
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 00:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5oP4mmikIghGlgfWO0z7U4Amo+eBw2P2Uqr4MvxQdRg=;
 b=jjN4GTQa9RsqJPPqOLl17St2hAwfWpT+UVDun2OkmqhsHckHKpaIJtKgjTMvrwrNQm
 1fQlriemo1B+zY5XUo63aJypcO4FgKAjZ7UBxQPWibAdqhz0JBjtvNgzhyjQem4A6it/
 iApkUAo5McVa16uMfygBYux54/SfvzQG2PwuERaR2NmCWXG9PfEgagPuoJRmoMvfhlcb
 EaGfcKpquyJAxC5P4MHGXi0M3/q/tZ/qW9UhlISLnvjd0t3CoppnQ//XU6WGmRDWiiWn
 f1MDF9CA2cJ8xbi8KxtTM9itzbTjs38InUHVHG49eKRoGJfmp4STz+Iz2xJsRpwXI2ne
 l2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=5oP4mmikIghGlgfWO0z7U4Amo+eBw2P2Uqr4MvxQdRg=;
 b=prk/VQFl+ELCg5d6ssvK7YU5/rZGs9RftYy7pSZd3vtuHPKAxtEfMvYeLLtkRoKEWx
 yP6cdLj9/evAnVBQ3KF244n9eMzao6nM1JgjfP7FehhDv6vIACsl6lefiQKr6kl++UUH
 05OAeeLIN9GuM3reyPyTFZBuBCJNDcTgKyXdmvUi29OKvM1STBPc0GWQT0+b7xobeldg
 Y0vIt6zub8NczLm7RsSY+F22kzZfAqwikYp9RKrXOvuSIk0VUN4fgD4bEXNdRyh7ndl+
 Ah2TukoF5/ks8p75ldC2984dOqtX0SHpNgvkvoTJWBMY+JFYkvspDpbx700kQIf/Yd+H
 9Kew==
X-Gm-Message-State: AGi0PuYDMcNqKGiLFJMix5jiVbVl9hrBq3NJzyu+hDha9cpaDwg7vy4x
 kXhGKP3LiVsQyJ9aWEEUVSCv4RIDNR4=
X-Google-Smtp-Source: APiQypLSyqBd5yWG+WwxzuDCqnsLauhjQxG6A59iPU9NX2T/nAUEn7BE1RAhfOlkzzTZHPSFS3VNdg==
X-Received: by 2002:a05:600c:4102:: with SMTP id
 j2mr3068313wmi.159.1588057704649; 
 Tue, 28 Apr 2020 00:08:24 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id j10sm2123483wmi.18.2020.04.28.00.08.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2020 00:08:24 -0700 (PDT)
Subject: Re: [PATCH v4 7/7] raspi2 acceptance test: add test for dwc-hsotg
 (dwc2) USB host
To: Paul Zimmerman <pauldzim@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20200428022232.18875-1-pauldzim@gmail.com>
 <20200428022232.18875-8-pauldzim@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <e7447043-0a82-fb47-5c3c-7d323a5f4421@amsat.org>
Date: Tue, 28 Apr 2020 09:08:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200428022232.18875-8-pauldzim@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 4:22 AM, Paul Zimmerman wrote:
> Add a check for functional dwc-hsotg (dwc2) USB host emulation to
> the Raspi 2 acceptance test
> 
> Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
> ---
>  tests/acceptance/boot_linux_console.py | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index f825cd9ef5..efa4803642 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -373,13 +373,18 @@ class BootLinuxConsole(Test):
>  
>          self.vm.set_console()
>          kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
> -                               serial_kernel_cmdline[uart_id])
> +                               serial_kernel_cmdline[uart_id] +
> +                               ' root=/dev/mmcblk0p2 rootwait ' +
> +                               'dwc_otg.fiq_fsm_enable=0')
>          self.vm.add_args('-kernel', kernel_path,
>                           '-dtb', dtb_path,
> -                         '-append', kernel_command_line)
> +                         '-append', kernel_command_line,
> +                         '-device', 'usb-kbd')
>          self.vm.launch()
>          console_pattern = 'Kernel command line: %s' % kernel_command_line
>          self.wait_for_console_pattern(console_pattern)
> +        console_pattern = 'Product: QEMU USB Keyboard'
> +        self.wait_for_console_pattern(console_pattern)

Awesome, thanks for this patch!

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>  
>      def test_arm_raspi2_uart0(self):
>          """
> 

