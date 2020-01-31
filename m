Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FE6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:30:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E40232063A
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfbRtn/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E40232063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixa83-0004X9-0L
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 12:30:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixa6z-0003vN-Iv
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:29:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixa6y-00024V-5Y
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:29:45 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27990
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixa6y-000241-0j
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580491783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RiUUERfxtQIni726C2SFhdCH+wyDUGW8ag+xGhC92Uk=;
 b=AfbRtn/eaSmHAYopYmwmwvdoFT+v5m5HOf+w9u9FlbjVgAdGc7VyWA497AxynM1+oZiQB9
 xnIPjw1CU8rTvHCOa3RS4AbUPKQvTXC+zP8IJP5Z8owZkYBWIqQB+6lDLBiCpIjadjwxUD
 drYAZ+OyOO1IuTZaTlUzhhXgB44lydg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-Zmkpe2fGOjWqalqmcyUxcg-1; Fri, 31 Jan 2020 12:29:40 -0500
Received: by mail-wr1-f70.google.com with SMTP id c6so3657315wrm.18
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 09:29:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pyWs5en4emEbQSJRUh+L57NzcxSke7rDEsQR7e4lZLw=;
 b=V7l9ZYPpOuzV0WKCJI8ATZLnGFwVmyGXJ0tGqc7Y/UOZiYO85gHXX+acT8dih1DKwj
 4Z0Ki83FXEPW96tk6JinTLHsT2OhNRJ5pIkbZf9QZ7kcvqEqpjpxfNb0e1paMFG2ezQj
 WmIn590aNEsSWlOwn10g7zcRlQuPhfwUyTA6cLdOsHXFxEwY6kSvett7OmkI5qtbwZPN
 4CnuSSIqAG/joRL0PVRrCe6F8L1YxLYZ7WZ/QtnEoU5P2phVgduiebUGs6oo4DQ8fvw4
 71gn8nvbHUKVCAPWBW9yKAO64arxfpeZSlY/CmtwGUFnXN6t/walFZfgaRU0FkNu7KAU
 M0AQ==
X-Gm-Message-State: APjAAAXeTqmAEdZ/Xeg23cfa8YPEOOW7kkTqkYzA+u5hJjm0uiy2oPlq
 B4R55XCWoBFrTthCW/h7JYznN1rQDdUM2KkY9IOm1bjk45ilongPCuI6gJNibTVAs02b0pVYqmx
 hkBpWPrRsPxqCdWo=
X-Received: by 2002:adf:f401:: with SMTP id g1mr12906765wro.129.1580491779567; 
 Fri, 31 Jan 2020 09:29:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqyTzRTw4/UDMuoOlH1Me3o1TAMeNqOm1WdAzDCUbAKqvC14V3FGTNjsFT9rSDLxbQ4gGkrJWA==
X-Received: by 2002:adf:f401:: with SMTP id g1mr12906744wro.129.1580491779258; 
 Fri, 31 Jan 2020 09:29:39 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id r3sm13207724wrn.34.2020.01.31.09.29.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2020 09:29:38 -0800 (PST)
Subject: Re: [PATCH] tests/acceptance: Add a test for the integratorcp arm
 machine
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200131170233.14584-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0919c227-fcf6-44ae-c3de-2ce2ce13ea3d@redhat.com>
Date: Fri, 31 Jan 2020 18:29:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200131170233.14584-1-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: Zmkpe2fGOjWqalqmcyUxcg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/31/20 6:02 PM, Thomas Huth wrote:
> There is a kernel and initrd available on github which we can use
> for testing this machine.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                                  |  1 +
>   tests/acceptance/machine_arm_integratorcp.py | 43 ++++++++++++++++++++
>   2 files changed, 44 insertions(+)
>   create mode 100644 tests/acceptance/machine_arm_integratorcp.py
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6e4976d366..6a03835037 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -599,6 +599,7 @@ S: Maintained
>   F: hw/arm/integratorcp.c
>   F: hw/misc/arm_integrator_debug.c
>   F: include/hw/misc/arm_integrator_debug.h
> +F: tests/acceptance/machine_arm_integratorcp.py
>  =20
>   MCIMX6UL EVK / i.MX6ul
>   M: Peter Maydell <peter.maydell@linaro.org>
> diff --git a/tests/acceptance/machine_arm_integratorcp.py b/tests/accepta=
nce/machine_arm_integratorcp.py
> new file mode 100644
> index 0000000000..4f9ab40f2f
> --- /dev/null
> +++ b/tests/acceptance/machine_arm_integratorcp.py
> @@ -0,0 +1,43 @@
> +# Functional test that boots a Linux kernel and checks the console
> +#
> +# Copyright (c) 2020 Red Hat, Inc.
> +#
> +# Author:
> +#  Thomas Huth <thuth@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import os
> +
> +from avocado import skipUnless
> +from avocado_qemu import Test
> +from avocado_qemu import wait_for_console_pattern
> +
> +class IntegratorMachine(Test):
> +    """Boots the Linux kernel and checks that the console is operational=
"""
> +
> +    timeout =3D 90
> +
> +    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted co=
de')
> +    def test_integratorcp(self):
> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:integratorcp
> +        """
> +        kernel_url =3D ('https://github.com/zayac/qemu-arm/raw/master/'
> +                      'arm-test/kernel/zImage.integrator')
> +        kernel_hash =3D '0d7adba893c503267c946a3cbdc63b4b54f25468'
> +        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
> +
> +        initrd_url =3D ('https://github.com/zayac/qemu-arm/raw/master/'
> +                      'arm-test/kernel/arm_root.img')
> +        initrd_hash =3D 'b51e4154285bf784e017a37586428332d8c7bd8b'
> +        initrd_path =3D self.fetch_asset(initrd_url, asset_hash=3Dinitrd=
_hash)
> +
> +        self.vm.set_console()
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-initrd', initrd_path,
> +                         '-append', 'printk.time=3D0 console=3DttyAMA0')
> +        self.vm.launch()
> +        wait_for_console_pattern(self, 'Log in as root')
>=20

Nice. I see the framebuffer is also working.

I'd add a test on the CPU, and device listed:

Log in as root with no password.
qemu login: root
login[724]: root login  on `ttyAMA0'



BusyBox v1.1.2 (2006.05.04-15:30+0000) Built-in shell (ash)
Enter 'help' for a list of built-in commands.

# cat /proc/cpuinfo
Processor       : ARM926EJ-Sid(wb) rev 5 (v5l)
BogoMIPS        : 930.61
Features        : swp half thumb fastmult edsp java
CPU implementer : 0x41
CPU architecture: 5TEJ
CPU variant     : 0x0
CPU part        : 0x926
CPU revision    : 5
Cache type      : write-through
Cache clean     : not required
Cache lockdown  : not supported
Cache format    : Harvard
I size          : 4096
I assoc         : 4
I line length   : 32
I sets          : 32
D size          : 65536
D assoc         : 4
D line length   : 32
D sets          : 512

Hardware        : ARM-IntegratorCP
Revision        : 0000
Serial          : 0000000000000000
# cat /proc/io
/proc/iomem     /proc/ioports
# cat /proc/iomem
00000000-07ffffff : System RAM
   00022000-0020431f : Kernel text
   00206000-002670db : Kernel data
15000000-15000fff : mb:15
16000000-16000fff : mb:16
   16000000-16000fff : uart-pl011
17000000-17000fff : mb:17
   17000000-17000fff : uart-pl011
18000000-18000fff : mb:18
   18000000-18000fff : kmi-pl050
19000000-19000fff : mb:19
   19000000-19000fff : kmi-pl050
1c000000-1c000fff : mb:1c
   1c000000-1c000fff : mmci-pl18x
24000000-25ffffff : armflash.0
c0000000-c0000fff : mb:c0
   c0000000-c0000fff : clcd-pl11x
c8000000-c800000f : smc91x.0
   c8000000-c800000f : smc91x
#

Anyway this can be done in another patch on top, so:

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


