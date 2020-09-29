Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1B8C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:41:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B2CF20897
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kAQEaNrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2CF20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNC8Q-0004wH-Sw
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 05:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kNC5o-0003KS-K8
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:38:40 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44756)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kNC5k-00067K-9K
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:38:38 -0400
Received: by mail-wr1-x441.google.com with SMTP id s12so4545415wrw.11
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 02:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=J46/4jgOFSrpPIGoYM1TmW53dyavxiFrnOhGLSkJStk=;
 b=kAQEaNrcJfmKp3kB7WKakQ8ZimfrHZQHThXzqI+Q4fMQSW/8NyeRJ3FXdrHPE4mNpp
 GxBbEYC7qu8Df/vRZh0mA5NhGpkw3aIIIK9cQ2jlcLJ5PdPNpJyDZMY6yRkqYVRvaRIL
 cB+tlV34XPFUMy+qGGbOi1hkfPTw7fCgNYLwXEILT/LtpYTI6+ke3/buF/zjG5SLySqI
 +7l+p8KaRhmP6pAT4pCJ00mK03n/9IYE52/h01htzFF4hzMgdOlkbH6fxw6wB1xXqSgg
 soDAfBOjtq0Jh0EPrHD32Jeps3feNQuqAqWF24r/XaEb11qKZZxHUZ2o1OGdhLum/cmA
 eidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=J46/4jgOFSrpPIGoYM1TmW53dyavxiFrnOhGLSkJStk=;
 b=Ha+Uy8y/nhawPDgw1MzcCBAg0Fi+dciMyWpeud+PE+KzwA2i2w34LzPjbfJCJpP0uS
 T+Xc+B+c9FVVK8Vo+plhx8UbOnUWveZ6F2dwjNuLoJyqw35QH9SAfgneejrR97XZMoRF
 QPmowICq/aecN4TKEpAXGqx+nxzCGLrOqOH2SqKQ+wyze2FvxAqm8xsaj5TCfPyyS7Sp
 7X+bbVx+ZJ/nrLuAOgZhzx6ZzBMEhkXs0yry3TxiUjCkccHDLaivNszC7EuLJZwExzsP
 zwFF3htMex2/lLG74P5fSplwuhb0hmfVs783PIVf0ol6KBWICfdSHCye/bcCSM3Y5cPi
 Gsjw==
X-Gm-Message-State: AOAM531GMh8OL2B+27akOnu8YKbu+ZWl87WWvAN11rXzl8BDLLeCC3R5
 WtaBiQre5UpD6wlUOlTCsiEuKw==
X-Google-Smtp-Source: ABdhPJzBzwXfi5CI2NlYpf41+symb3SPOQYHTjPTITHCBQw7FaYfL4H1mO/94v2VySFvJuoLUzQn0w==
X-Received: by 2002:adf:ab54:: with SMTP id r20mr3209198wrc.293.1601372313106; 
 Tue, 29 Sep 2020 02:38:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h186sm4733955wmf.24.2020.09.29.02.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 02:38:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0CE9F1FF7E;
 Tue, 29 Sep 2020 10:38:31 +0100 (BST)
References: <20200928171539.788309-1-f4bug@amsat.org>
 <20200928171539.788309-17-f4bug@amsat.org>
 <CAKJDGDbowgUtu8Ap7K6vm_sksW3-maHU0bk3uib7BNY-5YxMdQ@mail.gmail.com>
 <105e7a4e-adee-284e-cf20-31b1a2781720@amsat.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 16/16] tests/acceptance: Test the MIPSsim machine
In-reply-to: <105e7a4e-adee-284e-cf20-31b1a2781720@amsat.org>
Date: Tue, 29 Sep 2020 10:38:30 +0100
Message-ID: <87r1qkq5wp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 Thomas Huth <huth@tuxfamily.org>, qemu-devel <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?utf-8?Q?Herv=C3=A9?= Poussineau <hpoussin@reactos.org>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Huacai Chen <chenhc@lemote.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> +Alex/Daniel
>
> On 9/28/20 10:33 PM, Willian Rampazzo wrote:
>> On Mon, Sep 28, 2020 at 2:31 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat=
.org> wrote:
>>>
>>> Add a test for the mipssim machine, based on the recommended
>>> test setup from Thomas Huth:
>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg606846.html
>>>
>>> The test is quick and can be run as:
>>>
>>>   $ avocado --show=3Dconsole run -t machine:mipssim tests/acceptance/
>>>    (1/1) tests/acceptance/machine_mips_mipssim.py:MipsSimMachine.test_m=
ipssim_linux_console:
>>>   console: Linux version 3.6.11 (root@711bb8ba16a7) (gcc version 4.8.3 =
(Buildroot 2014.11) ) #2 Sun Sep 27 13:39:35 UTC 2020
>>>   console: Setting default memory size 0x02000000
>>>   console: bootconsole [early0] enabled
>>>   console: CPU revision is: 00019300 (MIPS 24Kc)
>>>   console: FPU revision is: 00739300
>>>   ...
>>>   console: CPU frequency 12.00 MHz
>>>   console: Calibrating delay loop... 950.27 BogoMIPS (lpj=3D4751360)
>>>   ...
>>>   console: MIPSNet Ethernet driver. Version: 2007-11-17. (c)2005 MIPS T=
echnologies, Inc.
>>>   ...
>>>   console: Welcome to Buildroot
>>>   console: buildroot login: root
>>>   console: # root
>>>   console: -sh: root: not found
>>>   console: # ping -c 3 10.0.2.2
>>>   console: PING 10.0.2.2 (10.0.2.2): 56 data bytes
>>>   console: 64 bytes from 10.0.2.2: seq=3D0 ttl=3D255 time=3D48.231 ms
>>>   console: 64 bytes from 10.0.2.2: seq=3D1 ttl=3D255 time=3D9.407 ms
>>>   console: 64 bytes from 10.0.2.2: seq=3D2 ttl=3D255 time=3D2.298 ms
>>>   console: --- 10.0.2.2 ping statistics ---
>>>   console: 3 packets transmitted, 3 packets received, 0% packet loss
>>>   PASS (7.99 s)
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>> Cc: Thomas Huth <huth@tuxfamily.org>
>>> ---
>>>  MAINTAINERS                              |  1 +
>>>  tests/acceptance/machine_mips_mipssim.py | 56 ++++++++++++++++++++++++
>>>  2 files changed, 57 insertions(+)
>>>  create mode 100644 tests/acceptance/machine_mips_mipssim.py
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 5eed1e692b4..17d8a012b0e 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -240,6 +240,7 @@ F: include/hw/misc/mips_*
>>>  F: include/hw/timer/mips_gictimer.h
>>>  F: tests/acceptance/linux_ssh_mips_malta.py
>>>  F: tests/acceptance/machine_mips_malta.py
>>> +F: tests/acceptance/machine_mips_mipssim.py
>>>  F: tests/tcg/mips/
>>>  K: ^Subject:.*(?i)mips
>>>
>>> diff --git a/tests/acceptance/machine_mips_mipssim.py b/tests/acceptanc=
e/machine_mips_mipssim.py
>>> new file mode 100644
>>> index 00000000000..b2749917b08
>>> --- /dev/null
>>> +++ b/tests/acceptance/machine_mips_mipssim.py
>>> @@ -0,0 +1,56 @@
>>> +# Functional tests for the MIPS simulator (MIPSsim machine)
>>> +#
>>> +# Copyright (c) 2020 Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> +#
>>> +# This work is licensed under the terms of the GNU GPL, version 2 or l=
ater.
>>> +# See the COPYING file in the top-level directory.
>>> +#
>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>> +
>>> +import os
>>> +import logging
>>> +import time
>>> +
>>> +from avocado import skipUnless
>>> +from avocado_qemu import Test
>>> +from avocado_qemu import exec_command_and_wait_for_pattern
>>> +from avocado_qemu import interrupt_interactive_console_until_pattern
>>> +from avocado_qemu import wait_for_console_pattern
>>> +
>>> +class MipsSimMachine(Test):
>>> +
>>> +    timeout =3D 30
>>> +    KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
>>> +
>>> +    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted =
code')
>>> +    def test_mipssim_linux_console(self):
>>> +        """
>>> +        Boots the Linux kernel and checks that the console is operatio=
nal
>>> +        :avocado: tags=3Darch:mipsel
>>> +        :avocado: tags=3Dmachine:mipssim
>>> +        :avocado: tags=3Ddevice:mipsnet
>>> +        """
>>> +        kernel_url =3D ('https://github.com/philmd/qemu-testing-blob/r=
aw/'
>>> +                      '32ea5764e1de8fffa0d59366c44822cd06d7c8e0/'
>>> +                      'mips/mipssim/mipsel/vmlinux')
>>=20
>> So, are you willing to maintain some images on your GitHub to avoid
>> the image changes when they are not found?
>
> No, I am not willing to do that.
>
> But I see it pointless to have everyone (including CI) to spend 1h
> building this image, when the sources and build recipe is available,
> making the built image reproducible.

I agree we don't want to build from scratch each time. However as we
move from relying on third parties (which outside of the major distros
has proved very flaky) we are getting to the point of managing our GPL
liabilities.

After a bit of digging in your branches I see this is a buildroot
recipe running in Docker. Are they fully reproducible? Could we have a:

  make acceptance-image-mipsel

which built the same blob that gets inserted into the avocado cache
should your github url ever disappear?

> I'm not sure we need to run all the tests all the time, but I'd like
> to have the tests:
>
> 1/ provided with a series, so reviewer are free to rebuild the image
>    and test this series works as expected,
> 2/ committed in the repository, so maintainers can verify future changes
>    doesn't introduce regression.

Yes these are great goals - my only worry is the shifting sands some of
these images seem to exist on.

>>=20
>>> +        kernel_hash =3D '0f9aeca3a2e25b5b0cc4999571f39a7ad58cdc43'
>>> +        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkern=
el_hash)
>>> +
>>> +        initrd_url =3D ('https://github.com/philmd/qemu-testing-blob/r=
aw/'
>>> +                      '32ea5764e1de8fffa0d59366c44822cd06d7c8e0/'
>>> +                      'mips/mipssim/mipsel/rootfs.cpio')
>>> +        initrd_hash =3D 'b20359bdfae66387e5a17d6692686d59c189417b'
>>> +        initrd_path =3D self.fetch_asset(initrd_url, asset_hash=3Dinit=
rd_hash)
>>> +
>>> +        self.vm.set_console()
>>> +        self.vm.add_args('-kernel', kernel_path,
>>> +                         '-initrd', initrd_path,
>>> +                         '-append', self.KERNEL_COMMON_COMMAND_LINE)
>>> +        self.vm.launch()
>>> +
>>> +        wait_for_console_pattern(self, 'Welcome to Buildroot')
>>> +        interrupt_interactive_console_until_pattern(self,
>>> +                                                    interrupt_string=
=3D'root\r',
>>> +                                                    success_message=3D=
'#')
>>> +        pattern =3D '3 packets transmitted, 3 packets received, 0% pac=
ket loss'
>>> +        exec_command_and_wait_for_pattern(self, 'ping -c 3 10.0.2.2', =
pattern)
>>> --
>>> 2.26.2
>>>
>>>
>>=20
>> IMHO, although the solution of spreading images over personal
>> repositories is not the best, I don't have a strong opinion to block
>> this, so
>
> If the URL is stable (stable commit or even better, tag) it should
> be OK.
>
> tag is used in the quanta-gsj tests, see commit 4fe986dd448
> ("tests/acceptance: console boot tests for quanta-gsj"):
>
>   image_url =3D (
>           'https://github.com/hskinnemoen/openbmc/releases/download/'
>           '20200711-gsj-qemu-0/obmc-phosphor-image-gsj.static.mtd.gz')
>   image_hash =3D '14895e634923345cb5c8776037ff7876df96f6b1'
>
>>=20
>> Reviewed-by: Willian Rampazzo (willianr@redhat.com)
>>=20
>
> Thanks!
>
> Phil.


--=20
Alex Benn=C3=A9e

