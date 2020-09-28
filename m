Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF3DC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 20:34:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30AFC2080A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 20:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2U9KaA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30AFC2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMzqr-0000Bs-Rz
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 16:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1kMzq8-0007hW-WD
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 16:33:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57363)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1kMzq6-0002Dt-0g
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 16:33:40 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601325214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vPz6APpWCoxl1UibsooudA0bCD57PzP7LngryeyzQ/k=;
 b=M2U9KaA+X8t3nt6qNruduPZJXOXdj40avKfnByz8D0P/25jUf1Ze29LWG9YV1uodH7UU8L
 FMRTThkHRRUyxrYbaIaH8//A4QKkEHRUmCRL/S031O4cXyoRALoeEmI8jZjALhFJXEwfXG
 bAODFgYAk15bhbFuRQhfy45LclRD9DM=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-0PXG0Ss4PIacoHfrmebDwA-1; Mon, 28 Sep 2020 16:33:29 -0400
X-MC-Unique: 0PXG0Ss4PIacoHfrmebDwA-1
Received: by mail-vs1-f71.google.com with SMTP id d21so817863vsf.16
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 13:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vPz6APpWCoxl1UibsooudA0bCD57PzP7LngryeyzQ/k=;
 b=fuQGNBWoigJ4D/tTQRDSZrApb/mrc6P1wwfgVKHhd/0juJE15kYmdF1rrhheFkwEaB
 Lop8VViA+B2N2NF7rF1BP09PnSiGvzizDDtx4iWzEzarr7h0ArNitR8fuXSawIAP8EKG
 Wzv/MwCgJCpquWPitk5Km517b9uiKOemAfUdDI2xgkX7IEljEd7wwohSMIcx6RUBwUuJ
 nYK4FgzVfeqq+n/bAl4zxqnZJ7/Lk6bZ+Y5WATnbCGP8TF3Rt82rl5dJxWRl46yaJreE
 1rC2nHCWZG1voTXjeVQPuwq547Tyx+Nt9kcr6zFkfn+pmR/E1BZOSjtNhwuA56wqgHsz
 2iKA==
X-Gm-Message-State: AOAM530XlohhZ2aIa/2L2boa5hpIDw3STiScMUMz6V7hg7+o9EHP4hMx
 f4vHJ+CPpQf9JtO7WDDQNk9Dld3ABw3+jENheTzo+yy9V7ZSWeh4ZJ4OG+4NoIUNqxFSlQZFdNY
 Q+sOa/t3GHSnlOE/W2NRVAa0UT22mo9k=
X-Received: by 2002:a1f:1e04:: with SMTP id e4mr839711vke.11.1601325208369;
 Mon, 28 Sep 2020 13:33:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCNv8Kl6NNjrWnlPX9ogm25Eh6g5oAhVucdmw178jIuCFWnL1qNNh7nzgNcSgRV8P6KIQSI9fj6QTBzKOsQSc=
X-Received: by 2002:a1f:1e04:: with SMTP id e4mr839694vke.11.1601325208047;
 Mon, 28 Sep 2020 13:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200928171539.788309-1-f4bug@amsat.org>
 <20200928171539.788309-17-f4bug@amsat.org>
In-Reply-To: <20200928171539.788309-17-f4bug@amsat.org>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Mon, 28 Sep 2020 17:33:17 -0300
Message-ID: <CAKJDGDbowgUtu8Ap7K6vm_sksW3-maHU0bk3uib7BNY-5YxMdQ@mail.gmail.com>
Subject: Re: [PATCH 16/16] tests/acceptance: Test the MIPSsim machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=wrampazz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=wrampazz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 28, 2020 at 2:31 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Add a test for the mipssim machine, based on the recommended
> test setup from Thomas Huth:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg606846.html
>
> The test is quick and can be run as:
>
>   $ avocado --show=3Dconsole run -t machine:mipssim tests/acceptance/
>    (1/1) tests/acceptance/machine_mips_mipssim.py:MipsSimMachine.test_mip=
ssim_linux_console:
>   console: Linux version 3.6.11 (root@711bb8ba16a7) (gcc version 4.8.3 (B=
uildroot 2014.11) ) #2 Sun Sep 27 13:39:35 UTC 2020
>   console: Setting default memory size 0x02000000
>   console: bootconsole [early0] enabled
>   console: CPU revision is: 00019300 (MIPS 24Kc)
>   console: FPU revision is: 00739300
>   ...
>   console: CPU frequency 12.00 MHz
>   console: Calibrating delay loop... 950.27 BogoMIPS (lpj=3D4751360)
>   ...
>   console: MIPSNet Ethernet driver. Version: 2007-11-17. (c)2005 MIPS Tec=
hnologies, Inc.
>   ...
>   console: Welcome to Buildroot
>   console: buildroot login: root
>   console: # root
>   console: -sh: root: not found
>   console: # ping -c 3 10.0.2.2
>   console: PING 10.0.2.2 (10.0.2.2): 56 data bytes
>   console: 64 bytes from 10.0.2.2: seq=3D0 ttl=3D255 time=3D48.231 ms
>   console: 64 bytes from 10.0.2.2: seq=3D1 ttl=3D255 time=3D9.407 ms
>   console: 64 bytes from 10.0.2.2: seq=3D2 ttl=3D255 time=3D2.298 ms
>   console: --- 10.0.2.2 ping statistics ---
>   console: 3 packets transmitted, 3 packets received, 0% packet loss
>   PASS (7.99 s)
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Cc: Thomas Huth <huth@tuxfamily.org>
> ---
>  MAINTAINERS                              |  1 +
>  tests/acceptance/machine_mips_mipssim.py | 56 ++++++++++++++++++++++++
>  2 files changed, 57 insertions(+)
>  create mode 100644 tests/acceptance/machine_mips_mipssim.py
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5eed1e692b4..17d8a012b0e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -240,6 +240,7 @@ F: include/hw/misc/mips_*
>  F: include/hw/timer/mips_gictimer.h
>  F: tests/acceptance/linux_ssh_mips_malta.py
>  F: tests/acceptance/machine_mips_malta.py
> +F: tests/acceptance/machine_mips_mipssim.py
>  F: tests/tcg/mips/
>  K: ^Subject:.*(?i)mips
>
> diff --git a/tests/acceptance/machine_mips_mipssim.py b/tests/acceptance/=
machine_mips_mipssim.py
> new file mode 100644
> index 00000000000..b2749917b08
> --- /dev/null
> +++ b/tests/acceptance/machine_mips_mipssim.py
> @@ -0,0 +1,56 @@
> +# Functional tests for the MIPS simulator (MIPSsim machine)
> +#
> +# Copyright (c) 2020 Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
> +# See the COPYING file in the top-level directory.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import os
> +import logging
> +import time
> +
> +from avocado import skipUnless
> +from avocado_qemu import Test
> +from avocado_qemu import exec_command_and_wait_for_pattern
> +from avocado_qemu import interrupt_interactive_console_until_pattern
> +from avocado_qemu import wait_for_console_pattern
> +
> +class MipsSimMachine(Test):
> +
> +    timeout =3D 30
> +    KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
> +
> +    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted co=
de')
> +    def test_mipssim_linux_console(self):
> +        """
> +        Boots the Linux kernel and checks that the console is operationa=
l
> +        :avocado: tags=3Darch:mipsel
> +        :avocado: tags=3Dmachine:mipssim
> +        :avocado: tags=3Ddevice:mipsnet
> +        """
> +        kernel_url =3D ('https://github.com/philmd/qemu-testing-blob/raw=
/'
> +                      '32ea5764e1de8fffa0d59366c44822cd06d7c8e0/'
> +                      'mips/mipssim/mipsel/vmlinux')

So, are you willing to maintain some images on your GitHub to avoid
the image changes when they are not found?

> +        kernel_hash =3D '0f9aeca3a2e25b5b0cc4999571f39a7ad58cdc43'
> +        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
> +
> +        initrd_url =3D ('https://github.com/philmd/qemu-testing-blob/raw=
/'
> +                      '32ea5764e1de8fffa0d59366c44822cd06d7c8e0/'
> +                      'mips/mipssim/mipsel/rootfs.cpio')
> +        initrd_hash =3D 'b20359bdfae66387e5a17d6692686d59c189417b'
> +        initrd_path =3D self.fetch_asset(initrd_url, asset_hash=3Dinitrd=
_hash)
> +
> +        self.vm.set_console()
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-initrd', initrd_path,
> +                         '-append', self.KERNEL_COMMON_COMMAND_LINE)
> +        self.vm.launch()
> +
> +        wait_for_console_pattern(self, 'Welcome to Buildroot')
> +        interrupt_interactive_console_until_pattern(self,
> +                                                    interrupt_string=3D'=
root\r',
> +                                                    success_message=3D'#=
')
> +        pattern =3D '3 packets transmitted, 3 packets received, 0% packe=
t loss'
> +        exec_command_and_wait_for_pattern(self, 'ping -c 3 10.0.2.2', pa=
ttern)
> --
> 2.26.2
>
>

IMHO, although the solution of spreading images over personal
repositories is not the best, I don't have a strong opinion to block
this, so

Reviewed-by: Willian Rampazzo (willianr@redhat.com)


