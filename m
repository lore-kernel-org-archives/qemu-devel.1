Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7E3C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:59:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32E2C20B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NV9A73xV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E2C20B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iII7m-00007s-IC
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 15:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iIEir-0001lE-CT
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 12:21:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iIEip-00087L-NO
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 12:21:57 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35748)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iIEim-00086I-5o; Wed, 09 Oct 2019 12:21:52 -0400
Received: by mail-wm1-x343.google.com with SMTP id y21so3269059wmi.0;
 Wed, 09 Oct 2019 09:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ryoyJtHg4MPXMh4TNaCEf/rytXkNrnII8j76r7qjP8w=;
 b=NV9A73xV+T4ESvzl8E8+Qy+v5WMQhv8A6XsC3RIi4EB3sZC1yAjP8AAEeX8r50rFcQ
 5tERpz3BkWe/fIIzNsQXuIVRmGz1mW/55fb8YilvGQ/mOt0gct3g7vericSEbIu4LyPV
 oXwDXvvSyu7Bf+SaMrQ8Dx2wjJAbWP+WWz8HMqkTQ42rpG4Yz5nZFTT5M90Y48Dti3/i
 p4WXmjD32cphW6caFoYHchy3/LoK8nn6EloFlYP+V3KM79qHb5tYrq3euTsQbnD+uwD0
 0TO0u5yVjZ/3N3poVBfd/kAzo0BS6RESyXLPxIZhJDg5sZ0814d/cz41UDONVn36R9QL
 591g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ryoyJtHg4MPXMh4TNaCEf/rytXkNrnII8j76r7qjP8w=;
 b=VqnKzK0lIrnGMioC+BdCAQR6PB2tZwjd43sZzT/ZcMZikIDmXheYeoINvsVuxmcu2s
 dW16hqtF8r0xZZEQVNSqJ8qmv/8rER9l1Lu77gSzB3eUcIIar1yvXy81KSGdLBsBnT2l
 mejuQ9cwL3wqmM3jDrsloSCW4SLVX7j0lXv/6yA3te1IWzkilLYHlqN3a2jqUygwX0lR
 knIIDRtPPZBvIRLy1LWEK0Fmz4trp6wiOIEpffkShOwPXkpsCAo4QzIlSlZhBmRANjI3
 jT/FVCkyfjIML/ItweZ8soOfeAAyfax/OSZlMW7d8GBuzCSdQ88NNfYg5moD58jghODq
 tHhg==
X-Gm-Message-State: APjAAAUwUkkGUYGD34bLYxz7IJfWW1LVoV+mzUm5rqe5/vVInTj5E2Ry
 lk8N89MxXvVSrusVwwOW3C0=
X-Google-Smtp-Source: APXvYqyl3KKtp6jsaVIGBl9OCdJOa4mPLcKtmdCCGk8Sn8Kye0iasTL+kP1aolKwpcllCuylhxwUUQ==
X-Received: by 2002:a1c:dfc4:: with SMTP id w187mr3176103wmg.107.1570638110970; 
 Wed, 09 Oct 2019 09:21:50 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id x2sm3215916wrn.81.2019.10.09.09.21.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2019 09:21:50 -0700 (PDT)
Subject: Re: [PATCH 18/19] tests/boot_linux_console: Boot Linux and run few
 commands on raspi3
To: Cleber Rosa <crosa@redhat.com>
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-19-f4bug@amsat.org>
 <20191009161232.GE30349@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <81d4a5fa-8d7e-6c64-c375-b2ecce3543e0@amsat.org>
Date: Wed, 9 Oct 2019 18:21:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191009161232.GE30349@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
 =?UTF-8?Q?Zolt=c3=a1n_Baldaszti?= <bztemail@gmail.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/19 6:12 PM, Cleber Rosa wrote:
> On Thu, Sep 26, 2019 at 07:34:26PM +0200, Philippe Mathieu-Daudé wrote:
>> Add a test which boots Linux and run basic commands using the serial
>> port console.
>>
>> The kernel image is built by the Debian project:
>> https://wiki.debian.org/RaspberryPi
>>
>> The DeviceTree blob comes from the official Raspberry Pi project:
>> https://www.raspberrypi.org/
>>
>> The cpio image used comes from the linux-build-test project:
>> https://github.com/groeck/linux-build-test
>>
>> This test can be run using:
>>
>>    $ avocado run --show=console,app run -t machine:raspi3 tests/acceptance
>>    console: [    0.000000] Linux version 4.14.0-3-arm64 (debian-kernel@lists.debian.org) (gcc version 7.2.0 (Debian 7.2.0-18)) #1 SMP Debian 4.14.12-2 (2018-01-06)
>>    console: [    0.000000] Boot CPU: AArch64 Processor [410fd034]
>>    console: [    0.000000] Machine model: Raspberry Pi 3 Model B
>>    console: [    0.000000] earlycon: pl11 at MMIO 0x000000003f201000 (options '')
>>    console: [    0.000000] bootconsole [pl11] enabled
>>    [...]
>>    console: Starting network: OK
>>    console: Found console ttyAMA0
>>    console: Boot successful.
>>    console: / # cat /proc/cpuinfo
>>    console: processor      : 0
>>    console: BogoMIPS       : 125.00
>>    console: r      : 0x41
>>    console: CPU architecture: 8
>>    console: CPU variant
>>    console: : 0x0
>>    console: CPU part       : 0xd03
>>    console: CPU revision   : 4
>>    console: / # uname -a
>>    console: Linux buildroot 4.14.0-3-arm64 #1 SMP Debian 4.14.12-2 (2018-01-06) aarch64 GNU/Linux
>>    console: reboot
>>    console: / # reboot
>>    console: / # Found console ttyAMA0
>>    console: Stopping network: OK
>>    console: Saving random seed... done.
>>    console: Stopping logging: OK
>>    console: umount: devtmpfs busy - remounted read-only
>>    console: umount: can't unmount /: Invalid argument
>>    console: The system is going down NOW!
>>    console: Sent SIGTERM to all processes
>>    console: Sent SIGKILL to all processes
>>    console: Requesting system reboot
>>    console: kvm: exiting hardware virtualization
>>    console: reboot: Restarting system
>>    PASS (11.08 s)
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> some chars are scrambled on the console...
>> ---
>>   tests/acceptance/boot_linux_console.py | 47 ++++++++++++++++++++++++++
>>   1 file changed, 47 insertions(+)
>>
>> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
>> index 33e8f6c635..2a1a23763e 100644
>> --- a/tests/acceptance/boot_linux_console.py
>> +++ b/tests/acceptance/boot_linux_console.py
>> @@ -363,6 +363,53 @@ class BootLinuxConsole(Test):
>>           """
>>           self.do_test_arm_raspi2(1)
>>   
>> +    def test_arm_raspi3_initrd_uart0(self):
>> +        """
>> +        :avocado: tags=arch:aarch64
>> +        :avocado: tags=machine:raspi3
>> +        """
>> +        deb_url = ('https://snapshot.debian.org/archive/debian/'
>> +                   '20180106T174014Z/pool/main/l/linux/'
>> +                   'linux-image-4.14.0-3-arm64_4.14.12-2_arm64.deb')
>> +        deb_hash = 'e71c995de57921921895c1162baea5df527d1c6b'
>> +        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
>> +        kernel_path = self.extract_from_deb(deb_path,
>> +                                            '/boot/vmlinuz-4.14.0-3-arm64')
>> +
>> +        dtb_url = ('https://github.com/raspberrypi/firmware/raw/'
>> +                   '1.20180313/boot/bcm2710-rpi-3-b.dtb')
>> +        dtb_hash = 'eb14d67133401ef2f93523be7341456d38bfc077'
>> +        dtb_path = self.fetch_asset(dtb_url, asset_hash=dtb_hash)
>> +
>> +        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
>> +                      '9b6b392ea7bc15f0d6632328d429d31c9c6273da/rootfs/'
>> +                      'arm64/rootfs.cpio.gz')
>> +        initrd_hash = '6fd05324f17bb950196b5ad9d3a0fa996339f4cd'
>> +        initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
>> +        initrd_path = self.workdir + "rootfs.cpio"
>> +        gunzip(initrd_path_gz, initrd_path)
>> +
>> +        self.vm.set_machine('raspi3')
>> +        self.vm.set_console()
>> +        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
>> +                               'earlycon=pl011,0x3f201000 console=ttyAMA0 ' +
>> +                               'panic=-1 noreboot')
>> +        self.vm.add_args('-kernel', kernel_path,
>> +                         '-dtb', dtb_path,
>> +                         '-initrd', initrd_path,
>> +                         '-append', kernel_command_line,
>> +                         '-no-reboot')
>> +        self.vm.launch()
>> +
>> +        self.wait_for_console_pattern('Boot successful.')
>> +
>> +        self.exec_command_and_wait_for_pattern('cat /proc/cpuinfo',
>> +                                               'BogoMIPS')
>> +        self.exec_command_and_wait_for_pattern('uname -a',
>> +                                               'Debian')
>> +        self.exec_command_and_wait_for_pattern('reboot',
>> +                                               'reboot: Restarting system')
>> +
>>       def test_s390x_s390_ccw_virtio(self):
>>           """
>>           :avocado: tags=arch:s390x
>> -- 
>> 2.20.1
>>
> 
> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> 
> And even though you mentioned some trouble with the console, I've run
> this 100 times and had no issues that disturbed the test, so:

Ahaha thanks for insisting :)

I ran the Exynos4210 test 20 times and it did not fail, I'll try 80 more 
times.

> 
> Tested-by: Cleber Rosa <crosa@redhat.com>

Thanks!

