Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63922C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:38:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D5202070B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GeyNQh2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5202070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHrYy-0005um-8i
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 11:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHrVw-0003GN-Jj
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:35:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHrVv-00045q-5W
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:35:04 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40212)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHrVu-00044y-VY
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:35:03 -0400
Received: by mail-wr1-x443.google.com with SMTP id h4so11225326wrv.7
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 08:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=0FYP3lDXKgY51mVS60P8BEys4gyn4fz+okqaBMOeZBw=;
 b=GeyNQh2z8xx4ukLsLGpmymoSeRSBjPoaO72Iq4QcTEU/9WesXxgx3t9vc8kmw0cYEE
 F2B0PLB7Ajs+uVfMgP03O49RGxvvklz+xcYmWpPN95XxSqb823hWvQ1UZHHccRnnmRuy
 4xHuc2LXHhPSuIE0jsKsBWn73BJ0/WJfd0TlYaiM4PtuNhiIi2uIxVdXOrm7B0bbbz1R
 Qi4v5xv3UU9Qp8q3bqSbqSQCvF7/f56eSAnAygLBsGkJMi7wInw8kc+HtRvOruscgvzi
 tcWrz/eCIX6D95td7AbVDM4dbUQzkovmtE08IJ4bdSXv7hBLQT+ur1bhhx3i69mQH5np
 utsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=0FYP3lDXKgY51mVS60P8BEys4gyn4fz+okqaBMOeZBw=;
 b=Ukxc4NyAugTwl4Huzj6THGwM3fn6ig7PLB1TBvodBACfA42yJ65AncBZ5pL9vB4u0+
 durtnODLsuWDVsvY+/88l7qkqAx6xBOX4y0LF3jZG2Hw/VTrQBCaN0V57EWH1xeVT7i1
 K3mtaU/flUow2S277jjDlXDOzCbTxARGCLFbneaxBeQiDZ9wIjpHXFuM1WU+q0JKtBe0
 1POlpa98jDkb8yI4mZFKpKKxTJu73kn+vbpLsLdYxEaY5xaVlWSASygfHlamEvSYg3qw
 2KAx2eMQDCyZhmazpKYfGQ3su4fgF2l0a4C3OzAjr7nRL7RTzvTbwFBNEgsLdWkzNKPp
 lPuA==
X-Gm-Message-State: APjAAAX+o4pjDt/9S3jHlsCXxcORnBVPUURDaAscpc0VCtD3tPHVlPDM
 f4EdwgSF/QGzuT2Hllr8PdwMvRZ7mHA=
X-Google-Smtp-Source: APXvYqyhYxqyLtf5tLtIwAd9pLhcIEUdXiLkCuO1D3f9IYANoSPWfD3fKVdM3YuLoyp1yQ3syw/dTg==
X-Received: by 2002:a05:6000:1204:: with SMTP id
 e4mr21467762wrx.5.1570548901935; 
 Tue, 08 Oct 2019 08:35:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o22sm45624503wra.96.2019.10.08.08.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 08:35:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C2F8C1FF87;
 Tue,  8 Oct 2019 16:35:00 +0100 (BST)
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-18-f4bug@amsat.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 17/19] tests/boot_linux_console: Test the raspi2 UART1
 (16550 based)
In-reply-to: <20190926173428.10713-18-f4bug@amsat.org>
Date: Tue, 08 Oct 2019 16:35:00 +0100
Message-ID: <87lftvi72z.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 =?utf-8?Q?Zolt=C3=A1n?= Baldaszti <bztemail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> The current do_test_arm_raspi2() case tests the PL011 UART0.
> Our model also supports the AUX UART (16550 based).
> We can very simply test the UART1 with Linux, modifying the
> kernel command line.
>
> Add few lines to expand our previous test and cover the AUX
> UART.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/acceptance/boot_linux_console.py | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 7eaf6cb60e..33e8f6c635 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -326,6 +326,7 @@ class BootLinuxConsole(Test):
>          """
>          serial_kernel_cmdline =3D {
>              0: 'earlycon=3Dpl011,0x3f201000 console=3DttyAMA0',
> +            1: 'earlycon=3Duart8250,mmio32,0x3f215040 console=3DttyS1,11=
5200'
>          }
>          deb_url =3D ('http://archive.raspberrypi.org/debian/'
>                     'pool/main/r/raspberrypi-firmware/'
> @@ -336,7 +337,7 @@ class BootLinuxConsole(Test):
>          dtb_path =3D self.extract_from_deb(deb_path, '/boot/bcm2709-rpi-=
2-b.dtb')
>
>          self.vm.set_machine('raspi2')
> -        self.vm.set_console()
> +        self.vm.set_console(console_id=3Duart_id)
>          kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
>                                 serial_kernel_cmdline[uart_id])
>          self.vm.add_args('-kernel', kernel_path,
> @@ -354,6 +355,14 @@ class BootLinuxConsole(Test):
>          """
>          self.do_test_arm_raspi2(0)
>
> +    def test_arm_raspi2_uart1(self):
> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:raspi2
> +        :avocado: tags=3Ddevice:bcm2835_aux
> +        """
> +        self.do_test_arm_raspi2(1)
> +
>      def test_s390x_s390_ccw_virtio(self):
>          """
>          :avocado: tags=3Darch:s390x


--
Alex Benn=C3=A9e

