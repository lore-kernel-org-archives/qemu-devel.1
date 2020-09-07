Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAA0C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 10:00:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D08421531
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 10:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vfj9O5hf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D08421531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFDwl-00021e-Fn
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 06:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFDw4-0001Om-E3
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:59:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55963
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFDw0-0007ex-Fv
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599472775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wnwf+zkh5TJXklbvl8ZnTlo8KhCQaAAgLALx5Yp/PxU=;
 b=Vfj9O5hfDZVeeEpZJTXtypPKw8PQPKJ5x6s4Rqta1FVG7/9TAmMIGeI4JBn0NVrLF2cobW
 mgPcoTyEZKqp8+BSLTqDsGgLkKHkKaoCHRlhtCeHdxPEY+kxXd0wNfjb1fGgRyDI5ThSgo
 TGRNBkAH1AIIBCu5ahYCys97ys33OeQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-Td_hAKqcPKiDbU5TdBXG7A-1; Mon, 07 Sep 2020 05:59:23 -0400
X-MC-Unique: Td_hAKqcPKiDbU5TdBXG7A-1
Received: by mail-wm1-f71.google.com with SMTP id u5so3542945wme.3
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 02:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=wnwf+zkh5TJXklbvl8ZnTlo8KhCQaAAgLALx5Yp/PxU=;
 b=Vngrc1gH455qwkWfWyjcEAyvz71KS5+PxMS7UucMY5A3Z6V6cwhX9zKdgQCMAb7sHm
 +ntt4PtpwxS6dLnm0wIKtbOOXFEOnsOVQKXEeMu5EgAL/efO0hxQ/S971gBekPdiFs2T
 m3uBgN5rOerrA8o7sP0/LVV7lKUrRnETA/9vM+xEDw+Ld/qWihszo971wTIw8BinedAW
 VtIZog50EMqyUIHRUTATNscS67MWiEhsSzJJu9kV2ecXY9leRNkRCuDvjRf6dnrZFyh8
 hwvykUG9xZEE0VF/vVJbmSuZkTWNZvlV3FRdzkfaP23vJGmiPWQX1y8P5X+rwndVkBWG
 NZfA==
X-Gm-Message-State: AOAM533mkz0roTHW59Y/mQPrgQiezzYAbTxIM9dtY7ogIpfid5o/nM6C
 6CgPB7v+BjS864iGJuMksJFUih8W+RYilXcfatMKpB6HiV9RaaK+KgmoObRvtHcnKrrIofs5G76
 HOvX7n2Vk+e+BjXg=
X-Received: by 2002:a7b:c8c9:: with SMTP id f9mr20370506wml.67.1599472761620; 
 Mon, 07 Sep 2020 02:59:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWugrD1HvwqFHrKhG/yxXY2Vu/TKcDVrfzpaHVFiBjEw+zyaYUO5p+cOrk60bnjrTNQ5Y/LA==
X-Received: by 2002:a7b:c8c9:: with SMTP id f9mr20370456wml.67.1599472761128; 
 Mon, 07 Sep 2020 02:59:21 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id i26sm27759414wmb.17.2020.09.07.02.59.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2020 02:59:20 -0700 (PDT)
Subject: Re: [PATCH 1/4] Acceptance tests: use an available kernel image
 package for arm
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200907042000.415931-1-crosa@redhat.com>
 <20200907042000.415931-2-crosa@redhat.com>
 <001385a1-92eb-d311-88b5-8e1e7f6f1f48@redhat.com>
 <20200907093930.GD810755@redhat.com>
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
Message-ID: <34814b29-a47a-efd3-971b-520bc5ac6309@redhat.com>
Date: Mon, 7 Sep 2020 11:59:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200907093930.GD810755@redhat.com>
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Antony Pavlov <antonynpavlov@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Fabien Chouteau <chouteau@adacore.com>,
 qemu-arm@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/7/20 11:39 AM, Daniel P. Berrangé wrote:
> On Mon, Sep 07, 2020 at 10:06:13AM +0200, Philippe Mathieu-Daudé wrote:
>> [Cc'ing Daniel who usually have good ideas for that
>> kind if project-wide problem]
>>
>> On 9/7/20 6:19 AM, Cleber Rosa wrote:
>>> Which means a newer kernel version.  Expected output was changed
>>> to match the new kernel too.
>>
>> Nack.
>>
>> Acceptance tests are not to test the latest Linux kernel,
>> they aim to assert a specific kernel tested by some developer
>> still works while QEMU evolves.
>> QEMU doesn't have to adapt to the latest kernel;
>> QEMU should keep boot an old kernel.
>>
>> Testing new kernels is good, you are adding coverage. But
>> this break the acceptance testing contract "keep testing
>> the same thing over time".
>>
>> The problem you are trying to fix is the "where to keep
>> assets from public locations where they are being removed?"
>> one. Two years ago [*] you suggested to use some storage on
>> the avocado-project.org:
>>
>>   For Avocado-VT, there are the JeOS images[1], which we
>>   keep on a test "assets" directory.  We have a lot of
>>   storage/bandwidth availability, so it can be used for
>>   other assets proven to be necessary for tests.
>>
>>   As long as distribution rights and licensing are not
>>   issues, we can definitely use the same server for kernels,
>>   u-boot images and what not.
>>
>>   [1] - https://avocado-project.org/data/assets/
> 
> If I look at stuff under that directory I see a bunch of "Jeos" qcow2
> images, and zero information about the corresponding source for the
> images, nor any information about the licenses of software included.
> IOW what is stored their right now does not appear to comply with the
> GPL licensing requirements for providing full and corresponding source.
> 
>> It is time to have QEMU assets managed the same way.
> 
> I'd rather we didn't do anything relying on binary blobs with no
> info about how they were built. Pointing to the 3rd party download
> URLs was the easy way to ensure we don't have to worry about licensing
> problems.

I tried to be very strict including the recipe about how to rebuild
and description of the source (for licensing) in each commits (Alex
Bennée once said Debian/Fedora based was OK):

commit 784b8796380532351737d753a6a092ed4e1ffebf
Author: Philippe Mathieu-Daudé <f4bug@amsat.org>
Date:   Wed Mar 11 23:18:52 2020 +0100

    tests/boot_linux_console: Add a SLOW test booting Ubuntu on OrangePi PC

    This test boots Ubuntu Bionic on a OrangePi PC board.

    As it requires 1GB of storage, and is slow, this test is disabled
    on automatic CI testing.

    It is useful for workstation testing. Currently Avocado timeouts too
    quickly, so we can't run userland commands.

    The kernel image and DeviceTree blob are built by the Armbian
    project (based on Debian):
    https://www.armbian.com/orange-pi-pc/

    The Ubuntu image is downloaded from:
    https://dl.armbian.com/orangepipc/Bionic_current

commit de2749bcb2459d0722022fb70c70310a04413fc1
Author: Philippe Mathieu-Daudé <f4bug@amsat.org>
Date:   Wed Mar 11 23:18:51 2020 +0100

    tests/boot_linux_console: Add a SD card test for the OrangePi PC board

    The kernel image and DeviceTree blob are built by the Armbian
    project (based on Debian):
    https://www.armbian.com/orange-pi-pc/

    The SD image is from the kernelci.org project:
    https://kernelci.org/faq/#the-code

commit c40b1ded0af6ee5b26e4b2eb5e0ce68c308e8de3
Author: Philippe Mathieu-Daudé <f4bug@amsat.org>
Date:   Wed Mar 11 23:18:50 2020 +0100

    tests/boot_linux_console: Add initrd test for the Orange Pi PC board

    This test boots a Linux kernel on a OrangePi PC board and verify
    the serial output is working.

    The kernel image and DeviceTree blob are built by the Armbian
    project (based on Debian):
    https://www.armbian.com/orange-pi-pc/

    The cpio image used comes from the linux-build-test project:
    https://github.com/groeck/linux-build-test

commit e33ee3097f705bd7d3ae14a177e12a4b16055970
Author: Philippe Mathieu-Daudé <f4bug@amsat.org>
Date:   Fri Jan 17 14:09:30 2020 +0000

    tests/boot_linux_console: Add a SD card test for the CubieBoard

    The kernel image and DeviceTree blob are built by the Armbian
    project (based on Debian):
    https://docs.armbian.com/Developer-Guide_Build-Preparation/

    The cpio image used comes from the linux-build-test project:
    https://github.com/groeck/linux-build-test

commit efdb45bfd72745038909dfd1e970a827cb8d5d7e
Author: Philippe Mathieu-Daudé <f4bug@amsat.org>
Date:   Mon Oct 28 19:04:04 2019 -0400

    tests/boot_linux_console: Run BusyBox on 5KEc 64-bit cpu

    This tests boots a Linux kernel on a Malta machine up to a
    busybox shell on the serial console. Few commands are executed
    before halting the machine (via reboot).

    We use the Fedora 24 kernel extracted from the image at:
    https://fedoraproject.org/wiki/Architectures/MIPS
    and the initrd cpio image from the kerneltests project:
    https://kerneltests.org/

commit 92d9361255a0862379866f156686180902bb63d2
Author: Philippe Mathieu-Daudé <f4bug@amsat.org>
Date:   Mon Oct 28 19:04:04 2019 -0400

    tests/boot_linux_console: Add a test for the Raspberry Pi 2

    Similar to the x86_64/pc test, it boots a Linux kernel on a raspi2
    board and verify the serial is working.

    The kernel image and DeviceTree blob are built by the Raspbian
    project (based on Debian):
    https://www.raspbian.org/RaspbianImages
    as recommended by the Raspberry Pi project:
    https://www.raspberrypi.org/downloads/raspbian/

> 
> IIUC, the majority of our acceptance tests needs should be satisfied
> with a combination of a Linux kernel and busybox tools. We already
> use cross-compilers to build TCG test cases.
> 
> I'd like to see us provide a minimal "config" file for each Linux
> kernel combo we need to test. We should be able to define a fairly
> simple script that do the Linux build, busybox build and then puts
> the combination of them into a disk image.  Something 100% automated
> and reviewable.

For Debian/Fedora this config is available in their package (or source
package).

> 
> Even a minimal linux build takes some time, so we would need to cache
> the binary result in some suitable manner. At least this way we have
> a clear record of what we're building & how and can thus satisfy the
> license rules.

Yes, but if the Debian/Fedora build farms already build/published
their packages, it is easier to use it directly.

QEMU developers are very reluctant to add tests. I suppose we prefer
to develop or fix bugs rather than write tests. If we ask full build
recipe for each tests, I doubt we'll have much testing.

> 
>>
>> [*] https://www.mail-archive.com/avocado-devel@redhat.com/msg00860.html
>>
>>>
>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>>> ---
>>>  tests/acceptance/boot_linux_console.py | 44 +++++++++++++-------------
>>>  tests/acceptance/replay_kernel.py      |  8 ++---
>>>  2 files changed, 26 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
>>> index aaa781a581..751b47b8fd 100644
>>> --- a/tests/acceptance/boot_linux_console.py
>>> +++ b/tests/acceptance/boot_linux_console.py
>>> @@ -490,12 +490,12 @@ class BootLinuxConsole(LinuxKernelTest):
>>>          :avocado: tags=arch:arm
>>>          :avocado: tags=machine:cubieboard
>>>          """
>>> -        deb_url = ('https://apt.armbian.com/pool/main/l/'
>>> -                   'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb')
>>> -        deb_hash = '1334c29c44d984ffa05ed10de8c3361f33d78315'
>>> +        deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.8.0-sunxi/'
>>> +                   'linux-image-dev-sunxi_20.08_armhf.deb')
>>> +        deb_hash = 'ae553a9f7d43b18abfa8f3e64bf2d31878b9be89'
>>>          deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
>>>          kernel_path = self.extract_from_deb(deb_path,
>>> -                                            '/boot/vmlinuz-4.20.7-sunxi')
>>> +                                            '/boot/vmlinuz-5.8.0-sunxi')
>>>          dtb_path = '/usr/lib/linux-image-dev-sunxi/sun4i-a10-cubieboard.dtb'
>>>          dtb_path = self.extract_from_deb(deb_path, dtb_path)
>>>          initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
>>> @@ -522,7 +522,7 @@ class BootLinuxConsole(LinuxKernelTest):
>>>          exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
>>>                                                  'Allwinner sun4i/sun5i')
>>>          exec_command_and_wait_for_pattern(self, 'cat /proc/iomem',
>>> -                                                'system-control@1c00000')
>>> +                                                '1c00000.system-control')
>>>          # cubieboard's reboot is not functioning; omit reboot test.
>>>  
>>>      def test_arm_cubieboard_sata(self):
>>> @@ -530,12 +530,12 @@ class BootLinuxConsole(LinuxKernelTest):
>>>          :avocado: tags=arch:arm
>>>          :avocado: tags=machine:cubieboard
>>>          """
>>> -        deb_url = ('https://apt.armbian.com/pool/main/l/'
>>> -                   'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb')
>>> -        deb_hash = '1334c29c44d984ffa05ed10de8c3361f33d78315'
>>> +        deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.8.0-sunxi/'
>>> +                   'linux-image-dev-sunxi_20.08_armhf.deb')
>>> +        deb_hash = 'ae553a9f7d43b18abfa8f3e64bf2d31878b9be89'
>>>          deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
>>>          kernel_path = self.extract_from_deb(deb_path,
>>> -                                            '/boot/vmlinuz-4.20.7-sunxi')
>>> +                                            '/boot/vmlinuz-5.8.0-sunxi')
>>>          dtb_path = '/usr/lib/linux-image-dev-sunxi/sun4i-a10-cubieboard.dtb'
>>>          dtb_path = self.extract_from_deb(deb_path, dtb_path)
>>>          rootfs_url = ('https://github.com/groeck/linux-build-test/raw/'
>>> @@ -573,12 +573,12 @@ class BootLinuxConsole(LinuxKernelTest):
>>>          :avocado: tags=arch:arm
>>>          :avocado: tags=machine:orangepi-pc
>>>          """
>>> -        deb_url = ('https://apt.armbian.com/pool/main/l/'
>>> -                   'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb')
>>> -        deb_hash = '1334c29c44d984ffa05ed10de8c3361f33d78315'
>>> +        deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.8.0-sunxi/'
>>> +                   'linux-image-dev-sunxi_20.08_armhf.deb')
>>> +        deb_hash = 'ae553a9f7d43b18abfa8f3e64bf2d31878b9be89'
>>>          deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
>>>          kernel_path = self.extract_from_deb(deb_path,
>>> -                                            '/boot/vmlinuz-4.20.7-sunxi')
>>> +                                            '/boot/vmlinuz-5.8.0-sunxi')
>>>          dtb_path = '/usr/lib/linux-image-dev-sunxi/sun8i-h3-orangepi-pc.dtb'
>>>          dtb_path = self.extract_from_deb(deb_path, dtb_path)
>>>  
>>> @@ -598,12 +598,12 @@ class BootLinuxConsole(LinuxKernelTest):
>>>          :avocado: tags=arch:arm
>>>          :avocado: tags=machine:orangepi-pc
>>>          """
>>> -        deb_url = ('https://apt.armbian.com/pool/main/l/'
>>> -                   'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb')
>>> -        deb_hash = '1334c29c44d984ffa05ed10de8c3361f33d78315'
>>> +        deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.8.0-sunxi/'
>>> +                   'linux-image-dev-sunxi_20.08_armhf.deb')
>>> +        deb_hash = 'ae553a9f7d43b18abfa8f3e64bf2d31878b9be89'
>>>          deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
>>>          kernel_path = self.extract_from_deb(deb_path,
>>> -                                            '/boot/vmlinuz-4.20.7-sunxi')
>>> +                                            '/boot/vmlinuz-5.8.0-sunxi')
>>>          dtb_path = '/usr/lib/linux-image-dev-sunxi/sun8i-h3-orangepi-pc.dtb'
>>>          dtb_path = self.extract_from_deb(deb_path, dtb_path)
>>>          initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
>>> @@ -629,7 +629,7 @@ class BootLinuxConsole(LinuxKernelTest):
>>>          exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
>>>                                                  'Allwinner sun8i Family')
>>>          exec_command_and_wait_for_pattern(self, 'cat /proc/iomem',
>>> -                                                'system-control@1c00000')
>>> +                                                '1c00000.system-control')
>>>          exec_command_and_wait_for_pattern(self, 'reboot',
>>>                                                  'reboot: Restarting system')
>>>          # Wait for VM to shut down gracefully
>>> @@ -641,12 +641,12 @@ class BootLinuxConsole(LinuxKernelTest):
>>>          :avocado: tags=machine:orangepi-pc
>>>          :avocado: tags=device:sd
>>>          """
>>> -        deb_url = ('https://apt.armbian.com/pool/main/l/'
>>> -                   'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb')
>>> -        deb_hash = '1334c29c44d984ffa05ed10de8c3361f33d78315'
>>> +        deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.8.0-sunxi/'
>>> +                   'linux-image-dev-sunxi_20.08_armhf.deb')
>>> +        deb_hash = 'ae553a9f7d43b18abfa8f3e64bf2d31878b9be89'
>>>          deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
>>>          kernel_path = self.extract_from_deb(deb_path,
>>> -                                            '/boot/vmlinuz-4.20.7-sunxi')
>>> +                                            '/boot/vmlinuz-5.8.0-sunxi')
>>>          dtb_path = '/usr/lib/linux-image-dev-sunxi/sun8i-h3-orangepi-pc.dtb'
>>>          dtb_path = self.extract_from_deb(deb_path, dtb_path)
>>>          rootfs_url = ('http://storage.kernelci.org/images/rootfs/buildroot/'
>>> diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
>>> index b79fc8daf8..80a460814f 100644
>>> --- a/tests/acceptance/replay_kernel.py
>>> +++ b/tests/acceptance/replay_kernel.py
>>> @@ -132,12 +132,12 @@ class ReplayKernel(LinuxKernelTest):
>>>          :avocado: tags=arch:arm
>>>          :avocado: tags=machine:cubieboard
>>>          """
>>> -        deb_url = ('https://apt.armbian.com/pool/main/l/'
>>> -                   'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb')
>>> -        deb_hash = '1334c29c44d984ffa05ed10de8c3361f33d78315'
>>> +        deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.8.0-sunxi/'
>>> +                   'linux-image-dev-sunxi_20.08_armhf.deb')
>>> +        deb_hash = 'ae553a9f7d43b18abfa8f3e64bf2d31878b9be89'
>>>          deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
>>>          kernel_path = self.extract_from_deb(deb_path,
>>> -                                            '/boot/vmlinuz-4.20.7-sunxi')
>>> +                                            '/boot/vmlinuz-5.8.0-sunxi')
>>>          dtb_path = '/usr/lib/linux-image-dev-sunxi/sun4i-a10-cubieboard.dtb'
>>>          dtb_path = self.extract_from_deb(deb_path, dtb_path)
>>>          initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
>>>
>>
>>
> 
> Regards,
> Daniel
> 


