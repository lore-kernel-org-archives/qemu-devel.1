Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9099CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 20:02:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6793520684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 20:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W4MW6UVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6793520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNjJy-0002b0-CS
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 16:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33612)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iNjJB-0001Yu-Kx
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 16:02:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iNjJ9-0003gw-W1
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 16:02:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59334
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iNjJ9-0003ft-Rt
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 16:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571947326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4wXHpqgNWerPN+f5LIpBpKNObcRoG+nvUSmZLrcPTr0=;
 b=W4MW6UVy2/vNFbN3iuDJq9a37Ni2Dx/m4Vhn+wsFOBRMtNgo+TUqSLL2pDs/gG9BCHEynX
 PYN0wEpsRCcb216k5NvAC22XEr4KXSWCKIHyXI52j8IyVpn1in1wH3cWvurnilkCrDgstE
 VpCb7gKEb7AzgJfUrAn+TW4eLWr3JCs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-9qVaEoFGMOe8efKtfYrvLw-1; Thu, 24 Oct 2019 16:02:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1975F107AD31;
 Thu, 24 Oct 2019 20:02:03 +0000 (UTC)
Received: from localhost.localdomain (ovpn-122-152.rdu2.redhat.com
 [10.10.122.152])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A14A3D8F;
 Thu, 24 Oct 2019 20:01:57 +0000 (UTC)
Subject: Re: [Qemu-devel] [PATCH] Acceptance tests: refactor
 wait_for_console_pattern
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <252b6e94-fe8f-f9a7-0d4b-4743b1809a06@redhat.com>
 <20190916164011.7653-1-crosa@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <cf67e6dc-7288-aa30-c913-7967683a9353@redhat.com>
Date: Thu, 24 Oct 2019 17:01:56 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190916164011.7653-1-crosa@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 9qVaEoFGMOe8efKtfYrvLw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Willian Rampazzo <wrampazz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Cleber,

On 9/16/19 1:40 PM, Cleber Rosa wrote:
> The same utility method is already present in two different test
> files, so let's consolidate it into a single utility function.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/acceptance/avocado_qemu/__init__.py | 26 +++++++++++++
>   tests/acceptance/boot_linux_console.py    | 47 +++++++----------------
>   tests/acceptance/linux_ssh_mips_malta.py  | 18 ++-------
>   3 files changed, 42 insertions(+), 49 deletions(-)
>
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
> index bd41e0443c..a0fe16e47f 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -8,6 +8,7 @@
>   # This work is licensed under the terms of the GNU GPL, version 2 or
>   # later.  See the COPYING file in the top-level directory.
>  =20
> +import logging
>   import os
>   import sys
>   import uuid
> @@ -53,6 +54,31 @@ def pick_default_qemu_bin(arch=3DNone):
>           return qemu_bin_from_src_dir_path
>  =20
>  =20
> +def wait_for_console_pattern(test, success_message,
> +                             failure_message=3D'Kernel panic - not synci=
ng'):
> +    """
> +    Waits for messages to appear on the console, while logging the conte=
nt
> +
> +    :param test: an Avocado test containing a VM that will have its cons=
ole
> +                 read and probed for a success or failure message
> +    :type test: :class:`avocado_qemu.Test`
> +    :param success_message: if this message appears, test succeeds
> +    :param failure_message: if this message appears, test fails
> +    """
> +    console =3D test.vm.console_socket.makefile()
> +    console_logger =3D logging.getLogger('console')
> +    while True:
> +        msg =3D console.readline().strip()
> +        if not msg:
> +            continue
> +        console_logger.debug(msg)
> +        if success_message in msg:
> +            break
> +        if failure_message in msg:
> +            fail =3D 'Failure message found in console: %s' % failure_me=
ssage
> +            test.fail(fail)
> +
> +

Note to self: it would be useful if wait_for_console_pattern could=20
return the read lines. Example of use: a test case waits the kernel to=20
boot - if succeed - then it can check if SMP topology is expected by=20
parsing the console lines.

Regardless, this change looks good to me.

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>


>   class Test(avocado.Test):
>       def setUp(self):
>           self._vms =3D {}
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 8a9a314ab4..9ff2213874 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -9,12 +9,12 @@
>   # later.  See the COPYING file in the top-level directory.
>  =20
>   import os
> -import logging
>   import lzma
>   import gzip
>   import shutil
>  =20
>   from avocado_qemu import Test
> +from avocado_qemu import wait_for_console_pattern
>   from avocado.utils import process
>   from avocado.utils import archive
>  =20
> @@ -29,31 +29,10 @@ class BootLinuxConsole(Test):
>  =20
>       KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
>  =20
> -    def wait_for_console_pattern(self, success_message,
> -                                 failure_message=3D'Kernel panic - not s=
yncing'):
> -        """
> -        Waits for messages to appear on the console, while logging the c=
ontent
> -
> -        :param success_message: if this message appears, test succeeds
> -        :param failure_message: if this message appears, test fails
> -        """
> -        console =3D self.vm.console_socket.makefile()
> -        console_logger =3D logging.getLogger('console')
> -        while True:
> -            msg =3D console.readline().strip()
> -            if not msg:
> -                continue
> -            console_logger.debug(msg)
> -            if success_message in msg:
> -                break
> -            if failure_message in msg:
> -                fail =3D 'Failure message found in console: %s' % failur=
e_message
> -                self.fail(fail)
> -
>       def exec_command_and_wait_for_pattern(self, command, success_messag=
e):
>           command +=3D '\n'
>           self.vm.console_socket.sendall(command.encode())
> -        self.wait_for_console_pattern(success_message)
> +        wait_for_console_pattern(self, success_message)
>  =20
>       def extract_from_deb(self, deb, path):
>           """
> @@ -89,7 +68,7 @@ class BootLinuxConsole(Test):
>                            '-append', kernel_command_line)
>           self.vm.launch()
>           console_pattern =3D 'Kernel command line: %s' % kernel_command_=
line
> -        self.wait_for_console_pattern(console_pattern)
> +        wait_for_console_pattern(self, console_pattern)
>  =20
>       def test_mips_malta(self):
>           """
> @@ -112,7 +91,7 @@ class BootLinuxConsole(Test):
>                            '-append', kernel_command_line)
>           self.vm.launch()
>           console_pattern =3D 'Kernel command line: %s' % kernel_command_=
line
> -        self.wait_for_console_pattern(console_pattern)
> +        wait_for_console_pattern(self, console_pattern)
>  =20
>       def test_mips64el_malta(self):
>           """
> @@ -145,7 +124,7 @@ class BootLinuxConsole(Test):
>                            '-append', kernel_command_line)
>           self.vm.launch()
>           console_pattern =3D 'Kernel command line: %s' % kernel_command_=
line
> -        self.wait_for_console_pattern(console_pattern)
> +        wait_for_console_pattern(self, console_pattern)
>  =20
>       def test_mips_malta_cpio(self):
>           """
> @@ -181,7 +160,7 @@ class BootLinuxConsole(Test):
>                            '-append', kernel_command_line,
>                            '-no-reboot')
>           self.vm.launch()
> -        self.wait_for_console_pattern('Boot successful.')
> +        wait_for_console_pattern(self, 'Boot successful.')
>  =20
>           self.exec_command_and_wait_for_pattern('cat /proc/cpuinfo',
>                                                  'BogoMIPS')
> @@ -208,7 +187,7 @@ class BootLinuxConsole(Test):
>                            '-append', kernel_command_line)
>           self.vm.launch()
>           console_pattern =3D 'Kernel command line: %s' % kernel_command_=
line
> -        self.wait_for_console_pattern(console_pattern)
> +        wait_for_console_pattern(self, console_pattern)
>  =20
>       def test_mips_malta32el_nanomips_4k(self):
>           """
> @@ -266,7 +245,7 @@ class BootLinuxConsole(Test):
>                            '-append', kernel_command_line)
>           self.vm.launch()
>           console_pattern =3D 'Kernel command line: %s' % kernel_command_=
line
> -        self.wait_for_console_pattern(console_pattern)
> +        wait_for_console_pattern(self, console_pattern)
>  =20
>       def test_arm_virt(self):
>           """
> @@ -287,7 +266,7 @@ class BootLinuxConsole(Test):
>                            '-append', kernel_command_line)
>           self.vm.launch()
>           console_pattern =3D 'Kernel command line: %s' % kernel_command_=
line
> -        self.wait_for_console_pattern(console_pattern)
> +        wait_for_console_pattern(self, console_pattern)
>  =20
>       def test_arm_emcraft_sf2(self):
>           """
> @@ -314,7 +293,7 @@ class BootLinuxConsole(Test):
>                            '-drive', 'file=3D' + spi_path + ',if=3Dmtd,fo=
rmat=3Draw',
>                            '-no-reboot')
>           self.vm.launch()
> -        self.wait_for_console_pattern('init started: BusyBox')
> +        wait_for_console_pattern(self, 'init started: BusyBox')
>  =20
>       def test_s390x_s390_ccw_virtio(self):
>           """
> @@ -335,7 +314,7 @@ class BootLinuxConsole(Test):
>                            '-append', kernel_command_line)
>           self.vm.launch()
>           console_pattern =3D 'Kernel command line: %s' % kernel_command_=
line
> -        self.wait_for_console_pattern(console_pattern)
> +        wait_for_console_pattern(self, console_pattern)
>  =20
>       def test_alpha_clipper(self):
>           """
> @@ -357,7 +336,7 @@ class BootLinuxConsole(Test):
>                            '-append', kernel_command_line)
>           self.vm.launch()
>           console_pattern =3D 'Kernel command line: %s' % kernel_command_=
line
> -        self.wait_for_console_pattern(console_pattern)
> +        wait_for_console_pattern(self, console_pattern)
>  =20
>       def test_ppc64_pseries(self):
>           """
> @@ -377,4 +356,4 @@ class BootLinuxConsole(Test):
>                            '-append', kernel_command_line)
>           self.vm.launch()
>           console_pattern =3D 'Kernel command line: %s' % kernel_command_=
line
> -        self.wait_for_console_pattern(console_pattern)
> +        wait_for_console_pattern(self, console_pattern)
> diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/=
linux_ssh_mips_malta.py
> index 134f10cac3..da7a386117 100644
> --- a/tests/acceptance/linux_ssh_mips_malta.py
> +++ b/tests/acceptance/linux_ssh_mips_malta.py
> @@ -14,6 +14,7 @@ import time
>  =20
>   from avocado import skipIf
>   from avocado_qemu import Test
> +from avocado_qemu import wait_for_console_pattern
>   from avocado.utils import process
>   from avocado.utils import archive
>  =20
> @@ -56,19 +57,6 @@ class LinuxSSH(Test):
>           },
>       }
>  =20
> -    def wait_for_console_pattern(self, success_message,
> -                                 failure_message=3D'Oops'):
> -        console =3D self.vm.console_socket.makefile()
> -        console_logger =3D logging.getLogger('console')
> -        while True:
> -            msg =3D console.readline()
> -            console_logger.debug(msg.strip())
> -            if success_message in msg:
> -                break
> -            if failure_message in msg:
> -                fail =3D 'Failure message found in console: %s' % failur=
e_message
> -                self.fail(fail)
> -
>       def get_portfwd(self):
>           res =3D self.vm.command('human-monitor-command',
>                                 command_line=3D'info usernet')
> @@ -135,7 +123,7 @@ class LinuxSSH(Test):
>  =20
>           self.log.info('VM launched, waiting for sshd')
>           console_pattern =3D 'Starting OpenBSD Secure Shell server: sshd=
'
> -        self.wait_for_console_pattern(console_pattern)
> +        wait_for_console_pattern(self, console_pattern, 'Oops')
>           self.log.info('sshd ready')
>  =20
>           self.ssh_connect('root', 'root', rsa_hostkey_b64=3Drsa_hostkey_=
b64)
> @@ -143,7 +131,7 @@ class LinuxSSH(Test):
>       def shutdown_via_ssh(self):
>           self.ssh_command('poweroff')
>           self.ssh_disconnect_vm()
> -        self.wait_for_console_pattern('Power down')
> +        wait_for_console_pattern(self, 'Power down', 'Oops')
>  =20
>       def run_common_commands(self):
>           stdout, stderr =3D self.ssh_command('lspci -d 11ab:4620')


