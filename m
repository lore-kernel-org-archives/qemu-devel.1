Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CB4C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:10:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C9502076A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZymfVICG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C9502076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNBeS-0001iW-Tw
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 05:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNBdS-0001Gv-At
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:09:22 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39511)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNBdQ-00020e-8L
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:09:22 -0400
Received: by mail-wm1-x341.google.com with SMTP id t17so1338930wmi.4
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 02:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eWUfh2LX+/uB+0Xo1n3d/Pu9GFYystKkSGGHNiDkG3o=;
 b=ZymfVICGCGTD8jxQtWrSMTeUiXGFKpNUJBumvv500rdXv2nBSw6ODbOXNu9T3b6mpC
 oUdPAZfk84FimM9zXj8CYDvyHiXmOXFZg4CzDkM4Tiv/ZTr/u4dUmqpMmKEIE4bHbQpS
 8WszFhZvujT56unK5a7JCS/zGYK1C/CBoHHsFsqWtKxkMYz8j76tAbqKqgiknmlPOLpW
 jA8qgB9snuOjfbkhY+OR2hz/ODVvGcDdB0kK9M7t/RxtUKBZJeQpEgzEaIE+O3K35cH7
 HXMBJXoNr3pScadQFnbIlhXTqttS+u7uoBAynve874x861TK2ZDBJer/8zaAcex5V6z/
 afRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eWUfh2LX+/uB+0Xo1n3d/Pu9GFYystKkSGGHNiDkG3o=;
 b=KXmesjhQa/KDCE87smGDLnpgaGivU2+FEsskCWFaG0tiURK7FwAK7ABugZ3E/LSSEY
 mHAN1RRj4rXQe1rveCmIeuj8Vs7vL9zkdZDLdzeVzvdCGLrVfv/7jYP+wHSR64GQV1lh
 mlSMEAJ3V0SJ400E6RW7vWpxEuxnBPksa2LeETDHrfsT9okN0sWrRjp/WTvsRqwXZqP+
 TLYW5wP0e3IkKOTOxxzcyi+XMvkRUIpBPWKmXOO7r5d2wHhZJCf/+aEE/lQLAULJ6HoI
 z1b90dbeG65alLgLLDtm3232ucbO2OCsWxoVHusCSg3fav0UEBNRRKi8Qm+Lu0J/L9SO
 hZ0Q==
X-Gm-Message-State: AOAM533c8hAspAdgUcTLWVMvUWFXBYHOKt0pkoaL9r3GW/YooZF8Y0dl
 hERimVvMx6WvNfBllYbUXxg=
X-Google-Smtp-Source: ABdhPJywvwlgahDxL8eMx/Dvkt/DEwOW8ioKkOCqyTCrbhp3JvDYmZZVJrgRN4OTk7+b5Gz9a0TE1g==
X-Received: by 2002:a7b:ce0d:: with SMTP id m13mr3637502wmc.83.1601370557777; 
 Tue, 29 Sep 2020 02:09:17 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id 189sm4541083wmb.3.2020.09.29.02.09.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 02:09:17 -0700 (PDT)
Subject: Re: [PATCH 16/16] tests/acceptance: Test the MIPSsim machine
To: Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
References: <20200928171539.788309-1-f4bug@amsat.org>
 <20200928171539.788309-17-f4bug@amsat.org>
 <CAKJDGDbowgUtu8Ap7K6vm_sksW3-maHU0bk3uib7BNY-5YxMdQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <105e7a4e-adee-284e-cf20-31b1a2781720@amsat.org>
Date: Tue, 29 Sep 2020 11:09:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAKJDGDbowgUtu8Ap7K6vm_sksW3-maHU0bk3uib7BNY-5YxMdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 Thomas Huth <huth@tuxfamily.org>, qemu-devel <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Alex/Daniel

On 9/28/20 10:33 PM, Willian Rampazzo wrote:
> On Mon, Sep 28, 2020 at 2:31 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> Add a test for the mipssim machine, based on the recommended
>> test setup from Thomas Huth:
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg606846.html
>>
>> The test is quick and can be run as:
>>
>>   $ avocado --show=console run -t machine:mipssim tests/acceptance/
>>    (1/1) tests/acceptance/machine_mips_mipssim.py:MipsSimMachine.test_mipssim_linux_console:
>>   console: Linux version 3.6.11 (root@711bb8ba16a7) (gcc version 4.8.3 (Buildroot 2014.11) ) #2 Sun Sep 27 13:39:35 UTC 2020
>>   console: Setting default memory size 0x02000000
>>   console: bootconsole [early0] enabled
>>   console: CPU revision is: 00019300 (MIPS 24Kc)
>>   console: FPU revision is: 00739300
>>   ...
>>   console: CPU frequency 12.00 MHz
>>   console: Calibrating delay loop... 950.27 BogoMIPS (lpj=4751360)
>>   ...
>>   console: MIPSNet Ethernet driver. Version: 2007-11-17. (c)2005 MIPS Technologies, Inc.
>>   ...
>>   console: Welcome to Buildroot
>>   console: buildroot login: root
>>   console: # root
>>   console: -sh: root: not found
>>   console: # ping -c 3 10.0.2.2
>>   console: PING 10.0.2.2 (10.0.2.2): 56 data bytes
>>   console: 64 bytes from 10.0.2.2: seq=0 ttl=255 time=48.231 ms
>>   console: 64 bytes from 10.0.2.2: seq=1 ttl=255 time=9.407 ms
>>   console: 64 bytes from 10.0.2.2: seq=2 ttl=255 time=2.298 ms
>>   console: --- 10.0.2.2 ping statistics ---
>>   console: 3 packets transmitted, 3 packets received, 0% packet loss
>>   PASS (7.99 s)
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> Cc: Thomas Huth <huth@tuxfamily.org>
>> ---
>>  MAINTAINERS                              |  1 +
>>  tests/acceptance/machine_mips_mipssim.py | 56 ++++++++++++++++++++++++
>>  2 files changed, 57 insertions(+)
>>  create mode 100644 tests/acceptance/machine_mips_mipssim.py
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 5eed1e692b4..17d8a012b0e 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -240,6 +240,7 @@ F: include/hw/misc/mips_*
>>  F: include/hw/timer/mips_gictimer.h
>>  F: tests/acceptance/linux_ssh_mips_malta.py
>>  F: tests/acceptance/machine_mips_malta.py
>> +F: tests/acceptance/machine_mips_mipssim.py
>>  F: tests/tcg/mips/
>>  K: ^Subject:.*(?i)mips
>>
>> diff --git a/tests/acceptance/machine_mips_mipssim.py b/tests/acceptance/machine_mips_mipssim.py
>> new file mode 100644
>> index 00000000000..b2749917b08
>> --- /dev/null
>> +++ b/tests/acceptance/machine_mips_mipssim.py
>> @@ -0,0 +1,56 @@
>> +# Functional tests for the MIPS simulator (MIPSsim machine)
>> +#
>> +# Copyright (c) 2020 Philippe Mathieu-Daudé <f4bug@amsat.org>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or later.
>> +# See the COPYING file in the top-level directory.
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +import os
>> +import logging
>> +import time
>> +
>> +from avocado import skipUnless
>> +from avocado_qemu import Test
>> +from avocado_qemu import exec_command_and_wait_for_pattern
>> +from avocado_qemu import interrupt_interactive_console_until_pattern
>> +from avocado_qemu import wait_for_console_pattern
>> +
>> +class MipsSimMachine(Test):
>> +
>> +    timeout = 30
>> +    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
>> +
>> +    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
>> +    def test_mipssim_linux_console(self):
>> +        """
>> +        Boots the Linux kernel and checks that the console is operational
>> +        :avocado: tags=arch:mipsel
>> +        :avocado: tags=machine:mipssim
>> +        :avocado: tags=device:mipsnet
>> +        """
>> +        kernel_url = ('https://github.com/philmd/qemu-testing-blob/raw/'
>> +                      '32ea5764e1de8fffa0d59366c44822cd06d7c8e0/'
>> +                      'mips/mipssim/mipsel/vmlinux')
> 
> So, are you willing to maintain some images on your GitHub to avoid
> the image changes when they are not found?

No, I am not willing to do that.

But I see it pointless to have everyone (including CI) to spend 1h
building this image, when the sources and build recipe is available,
making the built image reproducible.

I'm not sure we need to run all the tests all the time, but I'd like
to have the tests:

1/ provided with a series, so reviewer are free to rebuild the image
   and test this series works as expected,
2/ committed in the repository, so maintainers can verify future changes
   doesn't introduce regression.

> 
>> +        kernel_hash = '0f9aeca3a2e25b5b0cc4999571f39a7ad58cdc43'
>> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>> +
>> +        initrd_url = ('https://github.com/philmd/qemu-testing-blob/raw/'
>> +                      '32ea5764e1de8fffa0d59366c44822cd06d7c8e0/'
>> +                      'mips/mipssim/mipsel/rootfs.cpio')
>> +        initrd_hash = 'b20359bdfae66387e5a17d6692686d59c189417b'
>> +        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
>> +
>> +        self.vm.set_console()
>> +        self.vm.add_args('-kernel', kernel_path,
>> +                         '-initrd', initrd_path,
>> +                         '-append', self.KERNEL_COMMON_COMMAND_LINE)
>> +        self.vm.launch()
>> +
>> +        wait_for_console_pattern(self, 'Welcome to Buildroot')
>> +        interrupt_interactive_console_until_pattern(self,
>> +                                                    interrupt_string='root\r',
>> +                                                    success_message='#')
>> +        pattern = '3 packets transmitted, 3 packets received, 0% packet loss'
>> +        exec_command_and_wait_for_pattern(self, 'ping -c 3 10.0.2.2', pattern)
>> --
>> 2.26.2
>>
>>
> 
> IMHO, although the solution of spreading images over personal
> repositories is not the best, I don't have a strong opinion to block
> this, so

If the URL is stable (stable commit or even better, tag) it should
be OK.

tag is used in the quanta-gsj tests, see commit 4fe986dd448
("tests/acceptance: console boot tests for quanta-gsj"):

  image_url = (
          'https://github.com/hskinnemoen/openbmc/releases/download/'
          '20200711-gsj-qemu-0/obmc-phosphor-image-gsj.static.mtd.gz')
  image_hash = '14895e634923345cb5c8776037ff7876df96f6b1'

> 
> Reviewed-by: Willian Rampazzo (willianr@redhat.com)
> 

Thanks!

Phil.

