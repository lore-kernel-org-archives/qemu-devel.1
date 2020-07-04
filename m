Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FD5C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F07720936
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eckUe1Md"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F07720936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrjqz-0005Bj-Dm
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 11:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjcZ-0000pp-9n
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 10:58:27 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50576)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjcX-00058o-HT
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 10:58:26 -0400
Received: by mail-wm1-x344.google.com with SMTP id l17so34733337wmj.0
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 07:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wGnD9yQeGrAIbVHFvWsaFnkR2rm4rv9OI4zbuWhM3bI=;
 b=eckUe1Mdv60EGOvKCgDUsKo5LvXwedc/kbMbESACW/XAFeUfyXtUy+qVHQZh+VuhRY
 225hrd1kYpT9dZv+nmWRNZ7268obHDlHTfA2rehkA8U+VrkrE+uEpb95ZZeCKC+1oiKa
 wtyZauw/JanQQC2w3Exlrdt6J+uN+rWk11/GdQ15Fn0h0bye9YUqZYMksDUTTcFamkiD
 +9KT9ExBfrNTEyZruhvN/6//RR40WjN0g+jbIyfxzMEnEaIeiXs9ao0dsyMmPiL20hgc
 U2glpBVOkECR8b21fT5xZcgrHUBEuMq82pRyWn7JkuHkB3QbSfrpafYotINCiKQtuWcn
 oQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=wGnD9yQeGrAIbVHFvWsaFnkR2rm4rv9OI4zbuWhM3bI=;
 b=nC4X8BVTzFwoBshCY6DCJ3O/BV3B8yh4gAaPuVJ3aIEOUL2pafc1nJFYXJEJutXc/v
 ZxPEntD7Q4WunVZs/bOAlhlk357S1URkBzlv2QEGtF6t0P+4/jucVCEihJoCBCvWLc4B
 4iN1L8duPngeh36CBnWGUG1L4zgfIPyBTxZnapqI+h1UkuEdCZUjM8bh3r/0zVbdYcSQ
 5hKrjmF4teA0pgiXpR/TkmDMUeVaehAJMD9GSN1GWjHruYILNDj/aCOWjypHmz3fTLn/
 AmPLXwgiOxLo3REIfjeffZQR5TbaMEIy9rd9mjdPh6DI6WN5WeGcpcuAlpv2ZpLMRsln
 7CBg==
X-Gm-Message-State: AOAM533lW9GhfTGMj376kWN1uCapByGx8MqzboQC8yzwzOEJ4/YJ1JMg
 uajuuit/xasWo6smYhj3DSk=
X-Google-Smtp-Source: ABdhPJz+oydzvhmrj6PLx6INN+aLZUO98TXFrz5vYkvreu4Y0EIy1X0J6vBM39ZxY0dBbWGZ2i5Smg==
X-Received: by 2002:a1c:19c5:: with SMTP id 188mr26683208wmz.124.1593874703840; 
 Sat, 04 Jul 2020 07:58:23 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id x185sm17433090wmg.41.2020.07.04.07.58.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2020 07:58:23 -0700 (PDT)
Subject: Re: [PATCH] tests/acceptance: Add a test for the sun4u sparc64 machine
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20200702141050.30073-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <61d682fc-c542-3672-adfe-46b9cbe4902e@amsat.org>
Date: Sat, 4 Jul 2020 16:58:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200702141050.30073-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/2/20 4:10 PM, Thomas Huth wrote:
> We can use the image from the advent calendar 2018 to test the sun4u
> machine. It's not using the "QEMU advent calendar" string, so we can
> not use the do_test_advcal_2018() from boot_linux_console.py, thus
> let's also put it into a separate file to also be able to add an
> entry to the MAINTAINERS file.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS                               |  1 +
>  tests/acceptance/machine_sparc64_sun4u.py | 35 +++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
>  create mode 100644 tests/acceptance/machine_sparc64_sun4u.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dec252f38b..c26bc06e39 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1318,6 +1318,7 @@ F: include/hw/pci-host/sabre.h
>  F: hw/pci-bridge/simba.c
>  F: include/hw/pci-bridge/simba.h
>  F: pc-bios/openbios-sparc64
> +F: tests/acceptance/machine_sparc64_sun4u.py
>  
>  Sun4v
>  M: Artyom Tarasenko <atar4qemu@gmail.com>
> diff --git a/tests/acceptance/machine_sparc64_sun4u.py b/tests/acceptance/machine_sparc64_sun4u.py
> new file mode 100644
> index 0000000000..2506eefe3f
> --- /dev/null
> +++ b/tests/acceptance/machine_sparc64_sun4u.py
> @@ -0,0 +1,35 @@
> +# Functional test that boots a Linux kernel and checks the console
> +#
> +# Copyright (c) 2020 Red Hat, Inc.
> +#
> +# Author:
> +#  Thomas Huth <thuth@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later. See the COPYING file in the top-level directory.
> +
> +import os
> +
> +from avocado_qemu import Test
> +from avocado_qemu import wait_for_console_pattern
> +from avocado.utils import archive
> +
> +class Sun4uMachine(Test):

I'd rather use Sun4uMachine(LinuxKernelTest) here, ...

> +    """Boots the Linux kernel and checks that the console is operational"""
> +
> +    timeout = 90
> +
> +    def test_sparc64_sun4u(self):
> +        """
> +        :avocado: tags=arch:sparc64
> +        :avocado: tags=machine:sun4u
> +        """
> +        tar_url = ('https://www.qemu-advent-calendar.org'
> +                   '/2018/download/day23.tar.xz')
> +        tar_hash = '142db83cd974ffadc4f75c8a5cad5bcc5722c240'
> +        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
> +        archive.extract(file_path, self.workdir)
> +        self.vm.set_console()
> +        self.vm.add_args('-kernel', self.workdir + '/day23/vmlinux')

... to use '-append', self.KERNEL_COMMON_COMMAND_LINE here.

> +        self.vm.launch()
> +        wait_for_console_pattern(self, 'Starting logging: OK')
> 

$ avocado --show=app,console run -t arch:sparc64 tests/acceptance/
Fetching asset from
tests/acceptance/machine_sparc64_sun4u.py:Sun4uMachine.test_sparc64_sun4u
 (1/1)
tests/acceptance/machine_sparc64_sun4u.py:Sun4uMachine.test_sparc64_sun4u:
console: OpenBIOS for Sparc64
console: Configuration device id QEMU version 1 machine id 0
console: kernel phys 404000 virt 40004000 size 0x10b7858
console: kernel cmdline
console: CPUs: 1 x SUNW,UltraSPARC-IIi
console: UUID: 00000000-0000-0000-0000-000000000000
console: Welcome to OpenBIOS v1.1 built on May 21 2020 19:15
console: Type 'help' for detailed information
console: [sparc64] Kernel already loaded
console: [    0.004591] PROMLIB: Sun IEEE Boot Prom 'OBP 3.10.24
1999/01/01 01:01'
console: [    0.006452] PROMLIB: Root node compatible: sun4u
console: [    0.007859] Linux version 4.16.13 (thuth@thuth.remote.csb)
(gcc version 6.4.0 (Buildroot 2018.05.2)) #46 SMP Sun Dec 16 17:16:03
CET 2018
console: [    0.039824] bootconsole [earlyprom0] enabled
console: [    0.042520] ARCH: SUN4U
...
console: [    4.823203] Booting Linux...
console: [    7.067712] rtc-m48t59 rtc-m48t59.0: setting system clock to
2020-07-04 14:52:23 UTC (1593874343)
console: [    7.216252] This architecture does not have kernel memory
protection.
console: Starting logging: OK
PASS (15.28 s)

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Preferably with KERNEL_COMMON_COMMAND_LINE:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Thanks for adding this test!

Phil.

