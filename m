Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0517AC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 23:16:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC4AD2068E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 23:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJooUCLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4AD2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZk4G-0001d9-R1
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 18:16:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iZk2e-0000WS-9H
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 18:14:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iZk2c-0006yl-TM
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 18:14:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26832
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iZk2c-0006yH-PD
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 18:14:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574810082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E7B7zapy1WwElYGkZTcl5/XCcsKz0+BeMH8DChPXN/w=;
 b=AJooUCLN/DJiPRZ0IH472Sy/hptm35zERc4wOJHzQQIUbD3PIv6rLBf22DsjJlJE9tDOwY
 puQUuM9UAeblo2SM6XWZUsccmN0c6aEx0Cex+/1vP61tm5lZUSxYioKcFmdt5UqYrVlx2+
 incoUFoBvWnIceiBA5/KODBFALTnqB0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-rB-rQK4aMECfg-5MA7XqAA-1; Tue, 26 Nov 2019 18:14:40 -0500
Received: by mail-wm1-f70.google.com with SMTP id 20so1182269wmo.9
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 15:14:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V5ZnaVyWO2dYTJrK142eYtFJLe3a7tVXe4mdxlK9gck=;
 b=RvHMm9/D/4qVlyiWPq+aWLhwH93J/07BYtehhwIqEUMRO5XRR+pqYD6WbqOgpLz7Gz
 7mOUefATNyZa49Zx6HPN/5jb5Txn2o9ifC/xvUa0tXUkChcQCIoNP6Sa6T2e2QQrJJSZ
 F2QRrhJ15d9tk1xic7MLatkaKJbA1toNoN+l3QGcGVB42Oo01v8EQQojFxhL2ke1VaOe
 wC0i6+vKiYzxSqC43uLdISfcTTTsiZ3X6QSHA+bvDwrqWDIzUSXRO2KvOgbGJwE++sbq
 49rS5KD4LBsv3J100Kg0VaIdTZ+6ifEbFe4EeXRXhqGWuJgoptQVvA8ZRoXGnXWTiHXI
 rZUA==
X-Gm-Message-State: APjAAAVDV0I2bQf4wPE7xwbVUNrSK72+2JknbxRg+YG//Vgwj/GJkH8B
 bBEoFWg8L5o60glQakYJvjrFE7Q514jM6T+zRGXIhroVhimKwLvjknAmvqTzhk8pgULD3Yk5fc3
 0JPZ0CiaduW5FxlM=
X-Received: by 2002:a5d:6181:: with SMTP id j1mr38321609wru.251.1574810079518; 
 Tue, 26 Nov 2019 15:14:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqzFBVrYcWtCTJWO7tGPq30G4wobUdj5KIplA+lS+sNhMbOMFjVcs2G//lJcCWppBKV00M30Lw==
X-Received: by 2002:a5d:6181:: with SMTP id j1mr38321599wru.251.1574810079312; 
 Tue, 26 Nov 2019 15:14:39 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id p9sm16632330wrs.55.2019.11.26.15.14.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2019 15:14:38 -0800 (PST)
Subject: Re: [PATCH v36 16/17] target/avr: Add Avocado test
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
References: <20191124050225.30351-1-mrolnik@gmail.com>
 <20191124050225.30351-17-mrolnik@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <96b04044-ae40-08c1-a59f-7752a2140f89@redhat.com>
Date: Wed, 27 Nov 2019 00:14:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191124050225.30351-17-mrolnik@gmail.com>
Content-Language: en-US
X-MC-Unique: rB-rQK4aMECfg-5MA7XqAA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: thuth@redhat.com, richard.henderson@linaro.org, dovgaluk@ispras.ru,
 Cleber Rosa <crosa@redhat.com>, imammedo@redhat.com,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michael,

On 11/24/19 6:02 AM, Michael Rolnik wrote:
> The test is based on
> https://github.com/seharris/qemu-avr-tests/tree/master/free-rtos/Demo
> demo which. If working correctly, prints 'ABCDEFGHIJKLMNOPQRSTUVWX' out.
> it also demostrates that timer and IRQ are working
>=20
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Acked-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/acceptance/machine_avr6.py | 36 ++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
>   create mode 100644 tests/acceptance/machine_avr6.py
>=20
> diff --git a/tests/acceptance/machine_avr6.py b/tests/acceptance/machine_=
avr6.py
> new file mode 100644
> index 0000000000..0601080b01
> --- /dev/null
> +++ b/tests/acceptance/machine_avr6.py
> @@ -0,0 +1,36 @@
> +import logging
> +import time
> +import distutils.spawn
> +
> +from avocado import skipUnless

^ not used, can be dropped

> +from avocado_qemu import Test

^ OK

> +from avocado.utils import process

^ not used, can be dropped

> +
> +class AVR6Machine(Test):
> +    timeout =3D 5
> +
> +    def test_freertos(self):
> +        """
> +        :avocado: tags=3Darch:avr
> +        :avocado: tags=3Dmachine:sample
> +        """
> +        """
> +        https://github.com/seharris/qemu-avr-tests/raw/master/free-rtos/=
Demo/AVR_ATMega2560_GCC/demo.elf

As a short documentation, maybe refer to the main.c file instead?

https://github.com/seharris/qemu-avr-tests/blob/36c3e67b8755dcf37e06af6730e=
f5d477b8ed16d/free-rtos/Demo/AVR_ATMega2560_GCC/main.c

> +        constantly prints out 'ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQ=
RSTUVWX'
> +        """
> +        rom_url =3D 'https://github.com/seharris/qemu-avr-tests'
> +        rom_url +=3D '/raw/master/free-rtos/Demo/AVR_ATMega2560_GCC/demo=
.elf'

Please use the commit sha1 instead of 'master', because Sarah might push=20
a new reference to /master, while the commit sha1 stays constant:

            rom_url =3D ('https://github.com/seharris/qemu-avr-tests'
                       '/raw/36c3e67b8755dcf/free-rtos/Demo'
                       '/AVR_ATMega2560_GCC/demo.elf')

> +        rom_hash =3D '7eb521f511ca8f2622e0a3c5e8dd686efbb911d4'
> +        rom_path =3D self.fetch_asset(rom_url, asset_hash=3Drom_hash)
> +
> +        self.vm.set_machine('sample')
> +        self.vm.add_args('-bios', rom_path)
> +        self.vm.add_args('-nographic')
> +        self.vm.launch()
> +
> +        time.sleep(2)
> +        self.vm.shutdown()
> +
> +        match =3D 'ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWX'
> +
> +        self.assertIn(match, self.vm.get_log())
>=20


