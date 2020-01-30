Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CDFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 23:47:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B0D020661
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 23:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGAl9LD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0D020661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixJXM-0007rn-FF
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 18:47:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53007)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixJWO-0007IG-CN
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:46:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixJWL-0002rL-Pb
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:46:51 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25894
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixJWK-0002pE-5S
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580428006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E/1/fpM+uIvTTGLaInPwc2lQDzHE5KcORyzhWhPzClE=;
 b=dGAl9LD+rJQDaaweNX/STkFFRHG7807PCBVddImyLBIstF2+wm9qJW50gu9uc20MmbTwoJ
 RSQqmXTsp4qnoI9DOvOEsyOKcrLiHrBeWcX4wxEXqK+IoWFVAHx4YMWFAUrVV+gcby2U7q
 yO+/bwkUDJ7oWTdn42Ga2QCiyqrJU7M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320--XTC4gocMYyXTIQxkOxTOw-1; Thu, 30 Jan 2020 18:46:42 -0500
Received: by mail-wm1-f70.google.com with SMTP id m21so1366699wmg.6
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 15:46:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dLEGO8KYRWQaQYVfnRG/qPNSgEXfE58ncEinyGY2FMY=;
 b=aIOoVMxXw+zUD2h8uYxAM0/0mZxOtYxV57hVeOqvuq0U3WwCz8KumiAGEoIckLwwqH
 wDSXgi4g7Xp5xVMgBEMFjUCCHhVpW1inDAA8EVShS+oqmBeZe2yomsMfSF5iSiGfLzJe
 wEhsrloRH/c62k36aSHq+1mJEiOWFAo/bw3gh87xmUot738cNsQi2W/WElqbraxuTP9e
 xNX340teZcFaOc8WnGeZToYfLo+bRXJtoFkvc47dHfDqbmDr240/ckCtlmC2j+v/8T0r
 01MkQQqO4cvFeksfpJomHTMqVK/QY/sVrOYaqSx1bEMHVZfr1SG2eHPskDm3cdTaMmDO
 qb3Q==
X-Gm-Message-State: APjAAAXlAK5ULCcTA4ZyXBHBBUY+RgfqnJ2xioA1EbABYLuBzSZZZfzF
 WNbk8684EbJ0YggdHpwvHGJFXZ8CCPeFy8EDiCSNwjKuPJ7dzL/YIjPS8utixy2Aj4ValilCf2s
 R6BKFO7fPxXjA0nk=
X-Received: by 2002:a5d:6a88:: with SMTP id s8mr8094145wru.173.1580428001386; 
 Thu, 30 Jan 2020 15:46:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqxyFYKC/hs/Am1qtbd8bupOTLdbsnaW1UdF3fE/g1goEp1qLjjPr5oI2ViFYCzXFzZhk1jKFQ==
X-Received: by 2002:a5d:6a88:: with SMTP id s8mr8094123wru.173.1580428001129; 
 Thu, 30 Jan 2020 15:46:41 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id t9sm7884427wmj.28.2020.01.30.15.46.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 15:46:40 -0800 (PST)
Subject: Re: [RFC PATCH] tests/acceptance: Add a test for the N800 and N810
 arm machines
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200129131920.22302-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <647b2004-4b56-7322-72ba-abb0309938de@redhat.com>
Date: Fri, 31 Jan 2020 00:46:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200129131920.22302-1-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: -XTC4gocMYyXTIQxkOxTOw-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/29/20 2:19 PM, Thomas Huth wrote:
> Old kernels from the Meego project can be used to check that Linux
> is at least starting on these machines.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   The serial console is written to the second UART, so this needs Phil's
>   "Allow to use other serial consoles than default" patch as a prerequisi=
te:
>   Based-on: <20200120235159.18510-5-f4bug@amsat.org>
>=20
>   MAINTAINERS                          |  1 +
>   tests/acceptance/machine_arm_n8x0.py | 49 ++++++++++++++++++++++++++++
>   2 files changed, 50 insertions(+)
>   create mode 100644 tests/acceptance/machine_arm_n8x0.py
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ddf6fe0794..560507e821 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -672,6 +672,7 @@ F: hw/rtc/twl92230.c
>   F: include/hw/display/blizzard.h
>   F: include/hw/input/tsc2xxx.h
>   F: include/hw/misc/cbus.h
> +F: tests/acceptance/machine_arm_n8x0.py
>  =20
>   Palm
>   M: Andrzej Zaborowski <balrogg@gmail.com>
> diff --git a/tests/acceptance/machine_arm_n8x0.py b/tests/acceptance/mach=
ine_arm_n8x0.py
> new file mode 100644
> index 0000000000..e5741f2d8d
> --- /dev/null
> +++ b/tests/acceptance/machine_arm_n8x0.py
> @@ -0,0 +1,49 @@
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
> +class N8x0Machine(Test):
> +    """Boots the Linux kernel and checks that the console is operational=
"""
> +
> +    timeout =3D 90
> +
> +    def __do_test_n8x0(self):
> +        kernel_url =3D ('http://stskeeps.subnetmask.net/meego-n8x0/'
> +                      'meego-arm-n8x0-1.0.80.20100712.1431-'
> +                      'vmlinuz-2.6.35~rc4-129.1-n8x0')
> +        kernel_hash =3D 'e9d5ab8d7548923a0061b6fbf601465e479ed269'
> +        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
> +
> +        self.vm.set_console(console_index=3D1)
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-append', 'printk.time=3D0 console=3DttyS1')
> +        self.vm.launch()
> +        wait_for_console_pattern(self, 'TSC2005 driver initializing')
> +
> +    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted co=
de')
> +    def test_n800(self):
> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:n800
> +        """
> +        self.__do_test_n8x0()
> +
> +    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted co=
de')
> +    def test_n810(self):
> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:n810
> +        """
> +        self.__do_test_n8x0()
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


