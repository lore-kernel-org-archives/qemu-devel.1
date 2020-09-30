Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4382EC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 09:50:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C72D5206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 09:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="So2U5s9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72D5206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNYlC-0002V9-RL
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 05:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kNYja-0000tB-AV
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 05:49:14 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41442)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kNYjX-0003yo-LR
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 05:49:13 -0400
Received: by mail-wr1-x444.google.com with SMTP id w5so1031584wrp.8
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 02:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=3w3k+GPdyeJGimG/zSK/cAH9sNUBLBW7KCAdZx46uKY=;
 b=So2U5s9hd/XFGL0Ivn2FMmLAxhdpsQXPt6pylO7VOvGyyZpbDve0oh3VdxYJRfTFYM
 fSCMQOjNzAFSWxdZ8ockziTJckUSW1mT+71u+ICHmm3YtrxyQNq6o+0gt4zk08VfHYvd
 HPCcyims8wJ+e15ssqPHefyOU99nufwYGB+G+tvKFh9nWbaL+QWWgUuLZuNvyqJ5tj/Z
 ghBOeqhGUAdU4hEmj+b2G4fep6Y2WHp8q4RhpAhP1kupZEEx6wurvHWH3N/WH7wlYJZA
 m5K7jHzaH00FONDaNPurBpWHZgh+4IIPbK19dRqBj+M7CRuFnSKJKoO/8iJSWRlkBAZo
 EVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=3w3k+GPdyeJGimG/zSK/cAH9sNUBLBW7KCAdZx46uKY=;
 b=q/Ty7xEsgRGYDqndjkKRQfCuxDglS/DD8MQUbEOHVAP+4XitOm3giA2yKUUVEPUvl1
 lWQZc2a2P3k8IQM6c0pwgyXrYFI0yutB3zBxdz8EE+QY5paKbURPVOmRlE5GZpGSdxbJ
 z+D3ED9QZc2VPEPUD9l5jtIM7B0SDETARMn21i2eELYMGcOH+Uzj/fzyI428yKfJthRJ
 MG4l5Hc2/9ut+PXHDTuQcTF+gVNZ2FfyZb8mcT3dZgmTOFqdIXch0miGq38Ay17UQ/UR
 nu8FcsxtzYH3JqnNNFEXI3d1Nb9IfMs331xnoyEEgH6Hbqy+j3c3rrrFVZQKsRcpZW7I
 Zzhw==
X-Gm-Message-State: AOAM532hQX2OFK4aeopBfNxun7PqPwW2+v1rZX3KOZV3l2ANw4vTM2vD
 5yxqVI7v2oRyzPLzIPddjlYJIQ==
X-Google-Smtp-Source: ABdhPJwC6VLhnjXGOMJN1/Q5f1bi3cx3xhq0YQ5rsp5PJBO9cfSGNZ1Q12N16n98SmPg4VGWltMjYA==
X-Received: by 2002:adf:f986:: with SMTP id f6mr2075012wrr.270.1601459348994; 
 Wed, 30 Sep 2020 02:49:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c14sm1929667wrv.12.2020.09.30.02.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 02:49:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 984501FF7E;
 Wed, 30 Sep 2020 10:49:06 +0100 (BST)
References: <20200928171539.788309-1-f4bug@amsat.org>
 <20200928171539.788309-17-f4bug@amsat.org>
 <CAKJDGDbowgUtu8Ap7K6vm_sksW3-maHU0bk3uib7BNY-5YxMdQ@mail.gmail.com>
 <105e7a4e-adee-284e-cf20-31b1a2781720@amsat.org>
 <87r1qkq5wp.fsf@linaro.org> <20200930084300.GA2264779@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 16/16] tests/acceptance: Test the MIPSsim machine
In-reply-to: <20200930084300.GA2264779@redhat.com>
Date: Wed, 30 Sep 2020 10:49:06 +0100
Message-ID: <877dsbppbh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
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


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Sep 29, 2020 at 10:38:30AM +0100, Alex Benn=C3=A9e wrote:
>>=20
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>>=20
>> > +Alex/Daniel
>> >
>> > On 9/28/20 10:33 PM, Willian Rampazzo wrote:
>> >> On Mon, Sep 28, 2020 at 2:31 PM Philippe Mathieu-Daud=C3=A9 <f4bug@am=
sat.org> wrote:
>> >>>
>> >>> Add a test for the mipssim machine, based on the recommended
>> >>> test setup from Thomas Huth:
>> >>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg606846.html
>> >>>
>> >>> The test is quick and can be run as:
>> >>>
>> >>>   $ avocado --show=3Dconsole run -t machine:mipssim tests/acceptance/
>> >>>    (1/1) tests/acceptance/machine_mips_mipssim.py:MipsSimMachine.tes=
t_mipssim_linux_console:
>> >>>   console: Linux version 3.6.11 (root@711bb8ba16a7) (gcc version 4.8=
.3 (Buildroot 2014.11) ) #2 Sun Sep 27 13:39:35 UTC 2020
>> >>>   console: Setting default memory size 0x02000000
>> >>>   console: bootconsole [early0] enabled
>> >>>   console: CPU revision is: 00019300 (MIPS 24Kc)
>> >>>   console: FPU revision is: 00739300
>> >>>   ...
>> >>>   console: CPU frequency 12.00 MHz
>> >>>   console: Calibrating delay loop... 950.27 BogoMIPS (lpj=3D4751360)
>> >>>   ...
>> >>>   console: MIPSNet Ethernet driver. Version: 2007-11-17. (c)2005 MIP=
S Technologies, Inc.
>> >>>   ...
>> >>>   console: Welcome to Buildroot
>> >>>   console: buildroot login: root
>> >>>   console: # root
>> >>>   console: -sh: root: not found
>> >>>   console: # ping -c 3 10.0.2.2
>> >>>   console: PING 10.0.2.2 (10.0.2.2): 56 data bytes
>> >>>   console: 64 bytes from 10.0.2.2: seq=3D0 ttl=3D255 time=3D48.231 ms
>> >>>   console: 64 bytes from 10.0.2.2: seq=3D1 ttl=3D255 time=3D9.407 ms
>> >>>   console: 64 bytes from 10.0.2.2: seq=3D2 ttl=3D255 time=3D2.298 ms
>> >>>   console: --- 10.0.2.2 ping statistics ---
>> >>>   console: 3 packets transmitted, 3 packets received, 0% packet loss
>> >>>   PASS (7.99 s)
>> >>>
>> >>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> >>> ---
>> >>> Cc: Thomas Huth <huth@tuxfamily.org>
>> >>> ---
>> >>>  MAINTAINERS                              |  1 +
>> >>>  tests/acceptance/machine_mips_mipssim.py | 56 +++++++++++++++++++++=
+++
>> >>>  2 files changed, 57 insertions(+)
>> >>>  create mode 100644 tests/acceptance/machine_mips_mipssim.py
>> >>>
>> >>> diff --git a/MAINTAINERS b/MAINTAINERS
>> >>> index 5eed1e692b4..17d8a012b0e 100644
>> >>> --- a/MAINTAINERS
>> >>> +++ b/MAINTAINERS
>> >>> @@ -240,6 +240,7 @@ F: include/hw/misc/mips_*
>> >>>  F: include/hw/timer/mips_gictimer.h
>> >>>  F: tests/acceptance/linux_ssh_mips_malta.py
>> >>>  F: tests/acceptance/machine_mips_malta.py
>> >>> +F: tests/acceptance/machine_mips_mipssim.py
>> >>>  F: tests/tcg/mips/
>> >>>  K: ^Subject:.*(?i)mips
>> >>>
>> >>> diff --git a/tests/acceptance/machine_mips_mipssim.py b/tests/accept=
ance/machine_mips_mipssim.py
>> >>> new file mode 100644
>> >>> index 00000000000..b2749917b08
>> >>> --- /dev/null
>> >>> +++ b/tests/acceptance/machine_mips_mipssim.py
>> >>> @@ -0,0 +1,56 @@
>> >>> +# Functional tests for the MIPS simulator (MIPSsim machine)
>> >>> +#
>> >>> +# Copyright (c) 2020 Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> >>> +#
>> >>> +# This work is licensed under the terms of the GNU GPL, version 2 o=
r later.
>> >>> +# See the COPYING file in the top-level directory.
>> >>> +#
>> >>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> >>> +
>> >>> +import os
>> >>> +import logging
>> >>> +import time
>> >>> +
>> >>> +from avocado import skipUnless
>> >>> +from avocado_qemu import Test
>> >>> +from avocado_qemu import exec_command_and_wait_for_pattern
>> >>> +from avocado_qemu import interrupt_interactive_console_until_pattern
>> >>> +from avocado_qemu import wait_for_console_pattern
>> >>> +
>> >>> +class MipsSimMachine(Test):
>> >>> +
>> >>> +    timeout =3D 30
>> >>> +    KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
>> >>> +
>> >>> +    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrust=
ed code')
>> >>> +    def test_mipssim_linux_console(self):
>> >>> +        """
>> >>> +        Boots the Linux kernel and checks that the console is opera=
tional
>> >>> +        :avocado: tags=3Darch:mipsel
>> >>> +        :avocado: tags=3Dmachine:mipssim
>> >>> +        :avocado: tags=3Ddevice:mipsnet
>> >>> +        """
>> >>> +        kernel_url =3D ('https://github.com/philmd/qemu-testing-blo=
b/raw/'
>> >>> +                      '32ea5764e1de8fffa0d59366c44822cd06d7c8e0/'
>> >>> +                      'mips/mipssim/mipsel/vmlinux')
>> >>=20
>> >> So, are you willing to maintain some images on your GitHub to avoid
>> >> the image changes when they are not found?
>> >
>> > No, I am not willing to do that.
>> >
>> > But I see it pointless to have everyone (including CI) to spend 1h
>> > building this image, when the sources and build recipe is available,
>> > making the built image reproducible.
>>=20
>> I agree we don't want to build from scratch each time. However as we
>> move from relying on third parties (which outside of the major distros
>> has proved very flaky) we are getting to the point of managing our GPL
>> liabilities.
>
> I'm wondering what the 1 hour time to build the images is
> spent on, and what does the image need to actually do ?

Buildroot will also build the toolchain and libc of chouce before
building it's rootfs. To be honest the rootfs part of the build is
fairly minimal if it's mostly busybox.

> Is it anything more than boot the kernel successfully ?
>
> I've not tried a timed build, but surely a minimal / tiny
> Linx kernel build is much less than an hour ? Combine with
> a tiny C program that simply prints "OK" as /bin/init and
> powers off the VM. Or we need more advanced then a minimal
> busybox build.

Starting from a buildroot is useful for development certainly because
it's a lot easier to add stuff to it if you need to.

> I think it'd be great if we could self-build a minimal
> kernel+init for all platforms we target, using distro
> provided cross-compilers.

We've been down this round before haven't we? Wasn't that what the JeOS
builds where all about?

Anyway things have moved on from the bad old days of crosstool and the
distros are better at packaging sane cross compilers that can build
kernels and basic user space. However leaving everyone to use their own
distro compiler is going to lead to repeatability problems - or maybe we
just treat it like we do with the existing TCG tests?

>
>
> Regards,
> Daniel


--=20
Alex Benn=C3=A9e

