Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFDCC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 07:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A668B208C7
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 07:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VSh9Vqp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A668B208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFBxN-0005t6-Rz
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 03:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFBwk-00056Q-C5
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 03:52:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25736
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFBwi-0005fr-Du
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 03:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599465131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+wSsF8eTINKgZSHvd5ZHdV6zTMB/1j30M/WThtSZOeA=;
 b=VSh9Vqp+5wpVPfJ5u73Zwm1HqfuYJQtPxpCUmziwQikb82bURpYKpAn0au6x5hAruFjWx3
 UKpYBEMfQLuXOV5gLJ+Osg0khWHfUm0+nGSEuMZqs00SDU6csB4R4u5Ms1QCelS9AS2tcx
 hZMXu2OMFF3B5ICwbMdwXQnhMEIeBlg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-Xm9pMYrMPw2A6OYytScmnA-1; Mon, 07 Sep 2020 03:52:07 -0400
X-MC-Unique: Xm9pMYrMPw2A6OYytScmnA-1
Received: by mail-wm1-f70.google.com with SMTP id c186so3677939wmd.9
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 00:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=+wSsF8eTINKgZSHvd5ZHdV6zTMB/1j30M/WThtSZOeA=;
 b=AlzOr/JEguLTRqE57stgnQmZN2890tdot3Mxe/xJM4HMOnxasBRxZrCy6ixz1Gtmzy
 DsfGXcX6DAY7uHHVzNv8NF9XzWkA+XaNDg9OpteEU99PAqGOyq/DDoihOHtLNzBWGXou
 i2p2hg8l+RxqwMA4Yv5IME7tgy1WxZCTs51pMbmqefpsX3S4rfwh8NIpeK53vxqFCs6q
 2d9QPqzjaeybYZAF71I/DpqbX0MzCxjQnLOeSivM3myFBRUlySjiETanrjQx8/yKdF14
 W9zD8KQl0828euo8pZoQkHKq/B3XAgwK2WagaKLkyGGzkrjxn2BbK7TCNXspN18MqG/C
 3WvA==
X-Gm-Message-State: AOAM533qdRBEYxeXoDAe0RxD1uy7WZIGHfIdqsK15FepklZfJpXF7wqV
 TuIsQUAzYHn2FsbQkIRnYRgxgtzDcn45WDq542Yz3+WLtMgNmy9/YFizOIj5xxc1nSUUSTOqora
 +RTeeV+fC4h9oKpE=
X-Received: by 2002:a7b:c958:: with SMTP id i24mr20133991wml.50.1599465126214; 
 Mon, 07 Sep 2020 00:52:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0wqC0li6cGbQJ06p3zjalgcPeScj6kHWYrYHLz6Hm4TyTbYZ1Nn6qROT9ggm7wki6tviO1w==
X-Received: by 2002:a7b:c958:: with SMTP id i24mr20133951wml.50.1599465125934; 
 Mon, 07 Sep 2020 00:52:05 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id p3sm6329146wmm.40.2020.09.07.00.52.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2020 00:52:05 -0700 (PDT)
Subject: Re: [PATCH 2/4] boot linux test: update arm bionic URL
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20200907042000.415931-1-crosa@redhat.com>
 <20200907042000.415931-3-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
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
Message-ID: <261b05da-0546-23fb-3e01-df0d17c0a825@redhat.com>
Date: Mon, 7 Sep 2020 09:52:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200907042000.415931-3-crosa@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 02:54:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.69, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Fabien Chouteau <chouteau@adacore.com>,
 qemu-arm@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Cleber,

On 9/7/20 6:19 AM, Cleber Rosa wrote:
> Which uses an xz compressed file, which has builtin support for
> decompression on avocado.utils.archive.

This line doesn't make sense without the patch subject
prepended "Update arm bionic URL". To make commit
descriptions coherent, please copy the subject.

Not all email clients display email subject right
before the email content.

> So the check for P7ZIP can be
> dropped, and extraction logic simplified.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/acceptance/boot_linux_console.py | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 751b47b8fd..c75c512c8b 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -22,12 +22,6 @@ from avocado.utils import process
>  from avocado.utils import archive
>  from avocado.utils.path import find_command, CmdNotFoundError
>  
> -P7ZIP_AVAILABLE = True
> -try:
> -    find_command('7z')
> -except CmdNotFoundError:
> -    P7ZIP_AVAILABLE = False
> -
>  """
>  Round up to next power of 2
>  """
> @@ -687,7 +681,6 @@ class BootLinuxConsole(LinuxKernelTest):
>          self.vm.wait()
>  
>      @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
> -    @skipUnless(P7ZIP_AVAILABLE, '7z not installed')
>      def test_arm_orangepi_bionic(self):
>          """
>          :avocado: tags=arch:arm
> @@ -695,14 +688,13 @@ class BootLinuxConsole(LinuxKernelTest):
>          :avocado: tags=device:sd
>          """
>  
> -        # This test download a 196MB compressed image and expand it to 1GB
> +        # This test download a 275MB compressed image and expand it to 1.1GB
>          image_url = ('https://dl.armbian.com/orangepipc/archive/'
> -                     'Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.7z')
> -        image_hash = '196a8ffb72b0123d92cea4a070894813d305c71e'
> -        image_path_7z = self.fetch_asset(image_url, asset_hash=image_hash)
> -        image_name = 'Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.img'
> -        image_path = os.path.join(self.workdir, image_name)
> -        process.run("7z e -o%s %s" % (self.workdir, image_path_7z))
> +                     'Armbian_20.08.1_Orangepipc_bionic_current_5.8.5.img.xz')
> +        image_hash = 'b4d6775f5673486329e45a0586bf06b6dbe792199fd182ac6b9c7bb6c7d3e6dd'
> +        image_path_xz = self.fetch_asset(image_url, asset_hash=image_hash,
> +                                         algorithm='sha256')
> +        image_path = archive.extract(image_path_xz, self.workdir)
>          image_pow2ceil_expand(image_path)

Nack, this is not the same test. You might be lucky it test the
same things, but this is not what the developer tested.
This is not how acceptance tests are supposed to work IMHO.

>  
>          self.vm.set_console()
> 


