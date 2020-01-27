Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86114C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 15:19:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50E9720674
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 15:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRwfM2LU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E9720674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw6Ay-0007Pt-EH
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 10:19:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iw6AD-0006sd-1t
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 10:18:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iw6AB-0005T2-N6
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 10:18:56 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37060
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iw6AB-0005SU-KE
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 10:18:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580138334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Nm2UeblMIA5MtaE1a+vcuGDgp7ZqXVKbrFqL01t3ac=;
 b=PRwfM2LUL54s8GqzxbN3+6SPcLtGjb6TD3Vyr0APBQ6Gl/d3UdgU2oMHGQ/JHpX+fAloWt
 UECliP57BN7sV13xHvp6honTKYIVz+UzrFhvKnHyH7Iu4/xi6V4+Qsp0qhW9otsBA0YX8t
 tRYXMWk6j3J/TeoY2yjnBoNkGM038YY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-28Jsi0xnMiWkLQWRbi-mbg-1; Mon, 27 Jan 2020 10:18:52 -0500
Received: by mail-wm1-f69.google.com with SMTP id o24so1474104wmh.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 07:18:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hvcpOTXG4vCjHHRiFXVbAAlw33/h0LwmxeMkqtTzrU0=;
 b=KGPEJ3cxC0sIO8V9MNYzBvWDRBTIkZeGNYe+Kti2fB9nHAo9hIPPVXXeNbTrBRaNem
 qWIaQlIGMhKTX+1bMYwinVt3O5+L/sl+EbQDGRGrvXhTRwpSWLcS7g35MhSQZipMvzcu
 YjVmHL96rdfrayVAw6MYdKSQir29nFZx4qHPTTZls2/hGtAnV151xEVQ3TqPxicprcap
 iLGFIlxBWqBqzLzUgPMR6fBivkYTuIHc8jQgFMy/vQdBjkoASjsQBluDmTH2fX5FQjvW
 CMO7K2SN92f+Kjzfcv8tbcu4j3Ycm+PZXwOsUYZP6/SxBjArFGop5nJqLCeES1UPs3+g
 N4HQ==
X-Gm-Message-State: APjAAAUKL9bjTggzyQ6GnZReWkFbuBk7p2UI1V7pQwb9h4kFeBjWUI5+
 cGIdg+6UhdNttCGJIYvvapBWwoqDe/s9oSXhpc9y9Nes0+0TdKoxrLG3O721HvLlryzeMOe3k/Y
 zOwHne0af1F66FOU=
X-Received: by 2002:adf:e591:: with SMTP id l17mr22878356wrm.139.1580138331489; 
 Mon, 27 Jan 2020 07:18:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqxrYJANnR0XEMJ5y33SKomT4U9JBaA5PbPx7rgGLaBPqslZ3XVUxW/oONBCyuFsysU9rahKJQ==
X-Received: by 2002:adf:e591:: with SMTP id l17mr22878322wrm.139.1580138331224; 
 Mon, 27 Jan 2020 07:18:51 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id b16sm21319860wrj.23.2020.01.27.07.18.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2020 07:18:50 -0800 (PST)
Subject: Re: [PATCH] tests/acceptance: Add a test for the canon-a1100 machine
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200127144126.15515-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cd60a444-620e-3366-09e8-e9c8d72894ad@redhat.com>
Date: Mon, 27 Jan 2020 16:18:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200127144126.15515-1-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: 28Jsi0xnMiWkLQWRbi-mbg-1
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
 Antony Pavlov <antonynpavlov@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/27/20 3:41 PM, Thomas Huth wrote:
> The canon-a1100 machine can be used with the Barebox firmware. The
> QEMU Advent Calendar 2018 features a pre-compiled image which we
> can use for testing.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/acceptance/machine_arm_canon-a1100.py | 33 +++++++++++++++++++++
>   1 file changed, 33 insertions(+)
>   create mode 100644 tests/acceptance/machine_arm_canon-a1100.py
>=20
> diff --git a/tests/acceptance/machine_arm_canon-a1100.py b/tests/acceptan=
ce/machine_arm_canon-a1100.py
> new file mode 100644
> index 0000000000..3888168451
> --- /dev/null
> +++ b/tests/acceptance/machine_arm_canon-a1100.py
> @@ -0,0 +1,33 @@
> +# Functional test that boots the canon-a1100 machine with firmware
> +#
> +# Copyright (c) 2020 Red Hat, Inc.
> +#
> +# Author:
> +#  Thomas Huth <thuth@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +from avocado_qemu import Test
> +from avocado_qemu import wait_for_console_pattern
> +from avocado.utils import archive
> +
> +class CanonA1100Machine(Test):
> +
> +    timeout =3D 90
> +
> +    def test_arm_canona1100(self):
> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:canon-a1100

To the maintainer taking this, please add:

            :avocado: tags=3Dpflash_cfi02

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

console: Switch to console [cs0]
console: barebox 2017.02.0 #2 Mon Nov 12 09:28:33 CET 2018
console: Board: Canon PowerShot A1100 IS
console: digic-gpio c0220000.gpio: probed gpiochip-1 with base 0
console: cfi_flash f8000000.flash: found cfi flash at 0xf8000000, size 4 Mi=
B
console: malloc space: 0x00100000 -> 0x002fffff (size 2 MiB)
console: environment load /dev/env0: No such file or directory
console: Maybe you have to create the partition.
console: running /env/bin/init...
PASS (1.86 s)

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +        """
> +        tar_url =3D ('https://www.qemu-advent-calendar.org'
> +                   '/2018/download/day18.tar.xz')
> +        tar_hash =3D '068b5fc4242b29381acee94713509f8a876e9db6'
> +        file_path =3D self.fetch_asset(tar_url, asset_hash=3Dtar_hash)
> +        archive.extract(file_path, self.workdir)
> +        self.vm.set_console()
> +        self.vm.add_args('-bios',
> +                         self.workdir + '/day18/barebox.canon-a1100.bin'=
)
> +        self.vm.launch()
> +        wait_for_console_pattern(self, 'running /env/bin/init')
>=20


