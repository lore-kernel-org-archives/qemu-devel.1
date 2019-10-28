Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTML_OBFUSCATE_05_10,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B5ECA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 08:09:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFCBF20862
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 08:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAwj2oE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFCBF20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP05Z-0003JH-R7
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 04:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iOzuh-0004C5-9D
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:58:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iOzue-0005Iq-T3
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:58:07 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35533)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iOzue-0005HS-Ji
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:58:04 -0400
Received: by mail-oi1-x241.google.com with SMTP id n16so3042097oig.2
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 00:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=ybsst7nFPMPQhkzJvu43Fi3Ff3Kw0bPszeLknjYLPZI=;
 b=fAwj2oE1bSBI8vAtXVViaYgg66AFzUewbEMZel5/N2SAyhMJUcjs8CHlauhfM83Obd
 nbcdWiznisSgr/YSp7IDOEygA1j1wKickOOq8Z8I7f+EKVSf74Go1ARqs4p0gk4wshdQ
 mkawmPxx8q0d8PS2nJjcVAte52yE0n/9vEhSWvMgHTIxcwidEmRfM2HWhJYia7KuSRIn
 ITwix7/20t2v/1GrQtdxsiVy7noHYjjH0BE7ySMc/5EA1YYubSOF61gNW9vgB61E8urU
 Hy6PymcC2ePRMK0tpskZl4OR3edy4Cbd7zXq1xWGgQyWY3XpBxRpaYz75DlOUNZldbsz
 dopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=ybsst7nFPMPQhkzJvu43Fi3Ff3Kw0bPszeLknjYLPZI=;
 b=Z5LA/C6X2JZdmEW9njGj+Jyf2o3Bmnk8EsAk9XoHDup0MOym5oWSxDx3QH2IjetfQs
 dYt/Pkq4+OUmdMWK8YMccx9omESqrtOS6eps0PHoiUY91uMyWxLJMwAKRZdPBl8c+Im4
 +rFweIx+lBHjyQDZt6NU96H1NvL08as1Em64NCxpj8Eh0XSE5LIMC2gtD5FjJ8cQiZIT
 fxQ3vb19cZXBna0W31R4LlmsR0ZLRLxHOdFiilOHyOBx/RbVZdktmGll0pVxk8CTHgfW
 zFuXYHZLewXu+PRRdjZwAnIs44/sUY/ys1OKi2HcI9ECo4p1M7smiD+o7SlQbbMICOzC
 DeTQ==
X-Gm-Message-State: APjAAAUZ5RllDlA+7Iz8AAeU6Fo2eGNFtwQl1yzYnKe4gi6teShRlq3z
 yrKXxq4V/Dan82H4l58l1XlA5fB0LSFicYeomT4=
X-Google-Smtp-Source: APXvYqx6NvWtNAgI9Bai8Lq/2oqHXCTfpgl00QhEj946qzelc6ALQ90EycpYmI4MeKKYnyb8qzUR+r72t5AMBtrWUIw=
X-Received: by 2002:aca:62d5:: with SMTP id
 w204mr13067000oib.136.1572249481890; 
 Mon, 28 Oct 2019 00:58:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Mon, 28 Oct 2019 00:58:01
 -0700 (PDT)
In-Reply-To: <20191028073441.6448-3-philmd@redhat.com>
References: <20191028073441.6448-1-philmd@redhat.com>
 <20191028073441.6448-3-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 28 Oct 2019 08:58:01 +0100
Message-ID: <CAL1e-=h41H6h-pFDqQY3uwrghaptpkoiwQ-=Hfc9sv=DfRYkDw@mail.gmail.com>
Subject: [PATCH 02/26] Acceptance tests: refactor wait_for_console_pattern
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ddf0c50595f3db3b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, Fabien Chouteau <chouteau@adacore.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ddf0c50595f3db3b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Monday, October 28, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
>
wrote:

> From: Cleber Rosa <crosa@redhat.com>
>
> The same utility method is already present in two different test
> files, so let's consolidate it into a single utility function.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> Message-Id: <20190916164011.7653-1-crosa@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> [PMD: failure_message is optional]
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/acceptance/avocado_qemu/__init__.py | 25 +++++++++++++++++++++
>  tests/acceptance/boot_linux_console.py    | 27 +++++------------------
>  tests/acceptance/linux_ssh_mips_malta.py  | 18 +++------------
>  3 files changed, 33 insertions(+), 37 deletions(-)
>
>

You missed my r-b, that I gave here:

https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg06378.html

A.



> diff --git a/tests/acceptance/avocado_qemu/__init__.py
> b/tests/acceptance/avocado_qemu/__init__.py
> index bd41e0443c..e3101cba30 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -8,6 +8,7 @@
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
>
> +import logging
>  import os
>  import sys
>  import uuid
> @@ -53,6 +54,30 @@ def pick_default_qemu_bin(arch=3DNone):
>          return qemu_bin_from_src_dir_path
>
>
> +def wait_for_console_pattern(test, success_message, failure_message=3DNo=
ne):
> +    """
> +    Waits for messages to appear on the console, while logging the conte=
nt
> +
> +    :param test: an Avocado test containing a VM that will have its
> console
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
> +        if failure_message and failure_message in msg:
> +            fail =3D 'Failure message found in console: %s' %
> failure_message
> +            test.fail(fail)
> +
> +
>  class Test(avocado.Test):
>      def setUp(self):
>          self._vms =3D {}
> diff --git a/tests/acceptance/boot_linux_console.py
> b/tests/acceptance/boot_linux_console.py
> index 8a9a314ab4..8897e0c253 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -9,12 +9,12 @@
>  # later.  See the COPYING file in the top-level directory.
>
>  import os
> -import logging
>  import lzma
>  import gzip
>  import shutil
>
>  from avocado_qemu import Test
> +from avocado_qemu import wait_for_console_pattern
>  from avocado.utils import process
>  from avocado.utils import archive
>
> @@ -29,31 +29,14 @@ class BootLinuxConsole(Test):
>
>      KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
>
> -    def wait_for_console_pattern(self, success_message,
> -                                 failure_message=3D'Kernel panic - not
> syncing'):
> -        """
> -        Waits for messages to appear on the console, while logging the
> content
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
> -                fail =3D 'Failure message found in console: %s' %
> failure_message
> -                self.fail(fail)
> +    def wait_for_console_pattern(self, success_message):
> +        wait_for_console_pattern(self, success_message,
> +                                 failure_message=3D'Kernel panic - not
> syncing')
>
>      def exec_command_and_wait_for_pattern(self, command,
> success_message):
>          command +=3D '\n'
>          self.vm.console_socket.sendall(command.encode())
> -        self.wait_for_console_pattern(success_message)
> +        wait_for_console_pattern(self, success_message)
>
>      def extract_from_deb(self, deb, path):
>          """
> diff --git a/tests/acceptance/linux_ssh_mips_malta.py
> b/tests/acceptance/linux_ssh_mips_malta.py
> index aa12001942..fc13f9e4d4 100644
> --- a/tests/acceptance/linux_ssh_mips_malta.py
> +++ b/tests/acceptance/linux_ssh_mips_malta.py
> @@ -13,6 +13,7 @@ import time
>
>  from avocado import skipUnless
>  from avocado_qemu import Test
> +from avocado_qemu import wait_for_console_pattern
>  from avocado.utils import process
>  from avocado.utils import archive
>  from avocado.utils import ssh
> @@ -69,19 +70,6 @@ class LinuxSSH(Test):
>      def setUp(self):
>          super(LinuxSSH, self).setUp()
>
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
> -                fail =3D 'Failure message found in console: %s' %
> failure_message
> -                self.fail(fail)
> -
>      def get_portfwd(self):
>          res =3D self.vm.command('human-monitor-command',
>                                command_line=3D'info usernet')
> @@ -137,7 +125,7 @@ class LinuxSSH(Test):
>
>          self.log.info('VM launched, waiting for sshd')
>          console_pattern =3D 'Starting OpenBSD Secure Shell server: sshd'
> -        self.wait_for_console_pattern(console_pattern)
> +        wait_for_console_pattern(self, console_pattern, 'Oops')
>          self.log.info('sshd ready')
>
>          self.ssh_connect('root', 'root')
> @@ -145,7 +133,7 @@ class LinuxSSH(Test):
>      def shutdown_via_ssh(self):
>          self.ssh_command('poweroff')
>          self.ssh_disconnect_vm()
> -        self.wait_for_console_pattern('Power down')
> +        wait_for_console_pattern(self, 'Power down', 'Oops')
>
>      def ssh_command_output_contains(self, cmd, exp):
>          stdout, _ =3D self.ssh_command(cmd)
> --
> 2.21.0
>
>
>

--000000000000ddf0c50595f3db3b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, October 28, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a hre=
f=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redhat.com</a>&gt; =
wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">From: Cleber Rosa &lt;<a href=3D"m=
ailto:crosa@redhat.com" target=3D"_blank">crosa@redhat.com</a>&gt;<br>
<br>
The same utility method is already present in two different test<br>
files, so let&#39;s consolidate it into a single utility function.<br>
<br>
Signed-off-by: Cleber Rosa &lt;<a href=3D"mailto:crosa@redhat.com" target=
=3D"_blank">crosa@redhat.com</a>&gt;<br>
Message-Id: &lt;<a href=3D"mailto:20190916164011.7653-1-crosa@redhat.com" t=
arget=3D"_blank">20190916164011.7653-1-crosa@<wbr>redhat.com</a>&gt;<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redha=
t.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
[PMD: failure_message is optional]<br>
Reviewed-by: David Gibson &lt;<a href=3D"mailto:david@gibson.dropbear.id.au=
" target=3D"_blank">david@gibson.dropbear.id.au</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0tests/acceptance/avocado_<wbr>qemu/__init__.py | 25 +++++++++++++++++=
++++<br>
=C2=A0tests/acceptance/boot_linux_c<wbr>onsole.py=C2=A0 =C2=A0 | 27 +++++--=
----------------<br>
=C2=A0tests/acceptance/linux_ssh_mi<wbr>ps_malta.py=C2=A0 | 18 +++---------=
---<br>
=C2=A03 files changed, 33 insertions(+), 37 deletions(-)<br>
<br></blockquote><div><br></div><div><br></div><div>You missed my r-b, that=
 I gave here:<br></div><div><br></div><div><a href=3D"https://lists.gnu.org=
/archive/html/qemu-devel/2019-10/msg06378.html">https://lists.gnu.org/archi=
ve/html/qemu-devel/2019-10/msg06378.html</a><br></div><div><br></div><div>A=
.</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
diff --git a/tests/acceptance/avocado_qem<wbr>u/__init__.py b/tests/accepta=
nce/avocado_qem<wbr>u/__init__.py<br>
index bd41e0443c..e3101cba30 100644<br>
--- a/tests/acceptance/avocado_qem<wbr>u/__init__.py<br>
+++ b/tests/acceptance/avocado_qem<wbr>u/__init__.py<br>
@@ -8,6 +8,7 @@<br>
=C2=A0# This work is licensed under the terms of the GNU GPL, version 2 or<=
br>
=C2=A0# later.=C2=A0 See the COPYING file in the top-level directory.<br>
<br>
+import logging<br>
=C2=A0import os<br>
=C2=A0import sys<br>
=C2=A0import uuid<br>
@@ -53,6 +54,30 @@ def pick_default_qemu_bin(arch=3DNon<wbr>e):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return qemu_bin_from_src_dir_path<br>
<br>
<br>
+def wait_for_console_pattern(test, success_message, failure_message=3DNone=
):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 Waits for messages to appear on the console, while logging t=
he content<br>
+<br>
+=C2=A0 =C2=A0 :param test: an Avocado test containing a VM that will have =
its console<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0read and pro=
bed for a success or failure message<br>
+=C2=A0 =C2=A0 :type test: :class:`avocado_qemu.Test`<br>
+=C2=A0 =C2=A0 :param success_message: if this message appears, test succee=
ds<br>
+=C2=A0 =C2=A0 :param failure_message: if this message appears, test fails<=
br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 console =3D test.vm.console_socket.makefil<wbr>e()<br>
+=C2=A0 =C2=A0 console_logger =3D logging.getLogger(&#39;console&#39;)<br>
+=C2=A0 =C2=A0 while True:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg =3D console.readline().strip()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not msg:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 console_logger.debug(msg)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if success_message in msg:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if failure_message and failure_message in msg:=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fail =3D &#39;Failure message fo=
und in console: %s&#39; % failure_message<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test.fail(fail)<br>
+<br>
+<br>
=C2=A0class Test(avocado.Test):<br>
=C2=A0 =C2=A0 =C2=A0def setUp(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._vms =3D {}<br>
diff --git a/tests/acceptance/boot_linux_<wbr>console.py b/tests/acceptance=
/boot_linux_<wbr>console.py<br>
index 8a9a314ab4..8897e0c253 100644<br>
--- a/tests/acceptance/boot_linux_<wbr>console.py<br>
+++ b/tests/acceptance/boot_linux_<wbr>console.py<br>
@@ -9,12 +9,12 @@<br>
=C2=A0# later.=C2=A0 See the COPYING file in the top-level directory.<br>
<br>
=C2=A0import os<br>
-import logging<br>
=C2=A0import lzma<br>
=C2=A0import gzip<br>
=C2=A0import shutil<br>
<br>
=C2=A0from avocado_qemu import Test<br>
+from avocado_qemu import wait_for_console_pattern<br>
=C2=A0from avocado.utils import process<br>
=C2=A0from avocado.utils import archive<br>
<br>
@@ -29,31 +29,14 @@ class BootLinuxConsole(Test):<br>
<br>
=C2=A0 =C2=A0 =C2=A0KERNEL_COMMON_COMMAND_LINE =3D &#39;printk.time=3D0 &#3=
9;<br>
<br>
-=C2=A0 =C2=A0 def wait_for_console_pattern(self, success_message,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0failure_message=3D&#39;Kernel =
panic - not syncing&#39;):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Waits for messages to appear on the console, w=
hile logging the content<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 :param success_message: if this message appear=
s, test succeeds<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 :param failure_message: if this message appear=
s, test fails<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 console =3D self.vm.console_socket.makefil<wbr=
>e()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 console_logger =3D logging.getLogger(&#39;cons=
ole&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 while True:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg =3D console.readline().strip=
()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not msg:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 console_logger.debug(msg)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if success_message in msg:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if failure_message in msg:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fail =3D &#39;Fail=
ure message found in console: %s&#39; % failure_message<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.fail(fail)<br=
>
+=C2=A0 =C2=A0 def wait_for_console_pattern(self, success_message):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 wait_for_console_pattern(self, success_message=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0failure_message=3D&#39;Kernel =
panic - not syncing&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def exec_command_and_wait_for_patt<wbr>ern(self, comman=
d, success_message):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0command +=3D &#39;\n&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.vm.console_socket.sendal<wbr>l(comma=
nd.encode())<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_console_pattern(<wbr>success_mes=
sage)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 wait_for_console_pattern(self, success_message=
)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def extract_from_deb(self, deb, path):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
diff --git a/tests/acceptance/linux_ssh_m<wbr>ips_malta.py b/tests/acceptan=
ce/linux_ssh_m<wbr>ips_malta.py<br>
index aa12001942..fc13f9e4d4 100644<br>
--- a/tests/acceptance/linux_ssh_m<wbr>ips_malta.py<br>
+++ b/tests/acceptance/linux_ssh_m<wbr>ips_malta.py<br>
@@ -13,6 +13,7 @@ import time<br>
<br>
=C2=A0from avocado import skipUnless<br>
=C2=A0from avocado_qemu import Test<br>
+from avocado_qemu import wait_for_console_pattern<br>
=C2=A0from avocado.utils import process<br>
=C2=A0from avocado.utils import archive<br>
=C2=A0from avocado.utils import ssh<br>
@@ -69,19 +70,6 @@ class LinuxSSH(Test):<br>
=C2=A0 =C2=A0 =C2=A0def setUp(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0super(LinuxSSH, self).setUp()<br>
<br>
-=C2=A0 =C2=A0 def wait_for_console_pattern(self, success_message,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0failure_message=3D&#39;Oops&#3=
9;):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 console =3D self.vm.console_socket.makefil<wbr=
>e()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 console_logger =3D logging.getLogger(&#39;cons=
ole&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 while True:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg =3D console.readline()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 console_logger.debug(msg.strip<w=
br>())<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if success_message in msg:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if failure_message in msg:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fail =3D &#39;Fail=
ure message found in console: %s&#39; % failure_message<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.fail(fail)<br=
>
-<br>
=C2=A0 =C2=A0 =C2=A0def get_portfwd(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D self.vm.command(&#39;human-monito=
r<wbr>-command&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0command_line=3D&#39;info usernet&#39;=
)<br>
@@ -137,7 +125,7 @@ class LinuxSSH(Test):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://self.log.info" target=
=3D"_blank">self.log.info</a>(&#39;VM launched, waiting for sshd&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0console_pattern =3D &#39;Starting OpenBSD=
 Secure Shell server: sshd&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_console_pattern(<wbr>console_pat=
tern)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 wait_for_console_pattern(self, console_pattern=
, &#39;Oops&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://self.log.info" target=
=3D"_blank">self.log.info</a>(&#39;sshd ready&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.ssh_connect(&#39;root&#39;, &#39;roo=
t&#39;)<br>
@@ -145,7 +133,7 @@ class LinuxSSH(Test):<br>
=C2=A0 =C2=A0 =C2=A0def shutdown_via_ssh(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.ssh_command(&#39;poweroff&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.ssh_disconnect_vm()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_for_console_pattern(<wbr>&#39;Power =
down&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 wait_for_console_pattern(self, &#39;Power down=
&#39;, &#39;Oops&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def ssh_command_output_contains(se<wbr>lf, cmd, exp):<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stdout, _ =3D self.ssh_command(cmd)<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--000000000000ddf0c50595f3db3b--

