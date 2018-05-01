Received: from eggs.gnu.org ([2001:4830:134:3::10]:48139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fDchK-0003PY-Uk
	for qemu-devel@nongnu.org; Tue, 01 May 2018 17:20:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fDchG-0005D8-PT
	for qemu-devel@nongnu.org; Tue, 01 May 2018 17:20:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43114 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1fDchG-0005Cz-Gf
	for qemu-devel@nongnu.org; Tue, 01 May 2018 17:20:26 -0400
References: <20180419164642.9536-1-f4bug@amsat.org>
	<20180419164642.9536-8-f4bug@amsat.org>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <9625a044-5b34-b967-2a3c-5bef6fec1550@redhat.com>
Date: Tue, 1 May 2018 17:20:14 -0400
MIME-Version: 1.0
In-Reply-To: <20180419164642.9536-8-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 7/7] avocado: Add tests booting the
 Malta machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Zheng Xiang <xiang.zheng@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Alistair Francis <alistair23@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

On 04/19/2018 12:46 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/avocado/test_linux-boot-console.py      | 92 +++++++++++++++++++
>  .../parameters.yaml                           |  2 +
>  2 files changed, 94 insertions(+)
>=20
> diff --git a/tests/avocado/test_linux-boot-console.py b/tests/avocado/t=
est_linux-boot-console.py
> index f54d10dd79..4ae1e3bf37 100644
> --- a/tests/avocado/test_linux-boot-console.py
> +++ b/tests/avocado/test_linux-boot-console.py
> @@ -86,3 +86,95 @@ class TestAlphaClipperBoot2_6(test.QemuTest):
> =20
>      def tearDown(self):
>          os.remove(self.console_path)
> +
> +
> +class TestMips4kcMaltaBoot2_6(test.QemuTest):
> +    """
> +    :avocado: enable
> +    :avocado: tags=3Darch_mips
> +    """
> +    ARCH =3D "mips"
> +
> +    def kernel_url(self):
> +        return 'http://people.debian.org/~aurel32/qemu/mips/vmlinux-2.=
6.32-5-4kc-malta'
> +
> +    def setUp(self):
> +        self.console_path =3D tempfile.mkstemp()[1]
> +        kernel_path =3D cachedfile(self.kernel_url())
> +        self.vm._args.extend(['-machine', 'malta'])
> +        self.vm._args.extend(['-m', '64'])
> +        self.vm._args.extend(['-kernel', kernel_path])
> +        self.vm._args.extend(['-append', '"console=3DttyS0 printk.time=
=3D0"'])
> +        self.vm._args.extend(['-chardev', 'socket,id=3Duart0,server,no=
wait,path=3D' + self.console_path])
> +        self.vm._args.extend(['-serial', 'chardev:uart0'])
> +        self.vm._args.extend(['-nographic'])
> +
> +    def test_boot_console(self):
> +        """
> +        :avocado: tags=3Duart,printk
> +        """
> +        if self.params.get('arch') !=3D self.ARCH:
> +            return
> +
> +        self.vm.launch(self.console_path)
> +        console =3D self.vm.get_console(console_address=3Dself.console=
_path, login=3DFalse)
> +        # no filesystem provided on purpose, wait for the Kernel panic
> +        bootlog =3D console.read_until_any_line_matches(["Kernel panic=
 - not syncing: VFS: Unable to mount root fs"], timeout=3D6.0)[1]
> +        console.close()
> +        # check Super I/O
> +        self.assertIn(u'ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A', b=
ootlog)
> +        self.assertIn(u'ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A', b=
ootlog)
> +        self.assertIn(u'i8042 KBD port at 0x60,0x64 irq 1', bootlog)
> +        self.assertIn(u'i8042 AUX port at 0x60,0x64 irq 12', bootlog)
> +        # check PCI (network interface)
> +        self.assertIn(u'registered as PCnet/PCI II 79C970A', bootlog)
> +        self.vm.shutdown()
> +
> +    def tearDown(self):
> +        os.remove(self.console_path)
> +
> +# FIXME this is a copy of TestMips4kcMaltaBoot2_6 with a different the=
 kernel url
> +class TestMips4kcMaltaBoot3_2(test.QemuTest):
> +    """
> +    :avocado: enable
> +    :avocado: tags=3Darch_mips
> +    """
> +    ARCH =3D "mips"
> +
> +    def kernel_url(self):
> +        return 'http://people.debian.org/~aurel32/qemu/mips/vmlinux-3.=
2.0-4-4kc-malta'
> +
> +    def setUp(self):
> +        self.console_path =3D tempfile.mkstemp()[1]
> +        kernel_path =3D cachedfile(self.kernel_url())
> +        self.vm._args.extend(['-machine', 'malta'])
> +        self.vm._args.extend(['-m', '64'])
> +        self.vm._args.extend(['-kernel', kernel_path])
> +        self.vm._args.extend(['-append', '"console=3DttyS0 printk.time=
=3D0"'])
> +        self.vm._args.extend(['-chardev', 'socket,id=3Duart0,server,no=
wait,path=3D' + self.console_path])
> +        self.vm._args.extend(['-serial', 'chardev:uart0'])
> +        self.vm._args.extend(['-nographic'])
> +
> +    def test_boot_console(self):
> +        """
> +        :avocado: tags=3Duart,printk
> +        """
> +        if self.params.get('arch') !=3D self.ARCH:
> +            return
> +
> +        self.vm.launch(self.console_path)
> +        console =3D self.vm.get_console(console_address=3Dself.console=
_path, login=3DFalse)
> +        # no filesystem provided on purpose, wait for the Kernel panic
> +        bootlog =3D console.read_until_any_line_matches(["Kernel panic=
 - not syncing: VFS: Unable to mount root fs"], timeout=3D6.0)[1]
> +        console.close()
> +        # check Super I/O
> +        self.assertIn(u'ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A', b=
ootlog)
> +        self.assertIn(u'ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A', b=
ootlog)
> +        self.assertIn(u'i8042 KBD port at 0x60,0x64 irq 1', bootlog)
> +        self.assertIn(u'i8042 AUX port at 0x60,0x64 irq 12', bootlog)
> +        # check PCI (network interface)
> +        self.assertIn(u'registered as PCnet/PCI II 79C970A', bootlog)
> +        self.vm.shutdown()
> +
> +    def tearDown(self):
> +        os.remove(self.console_path)
> diff --git a/tests/avocado/test_linux-boot-console.py.data/parameters.y=
aml b/tests/avocado/test_linux-boot-console.py.data/parameters.yaml
> index ed8c08058c..156f271a73 100644
> --- a/tests/avocado/test_linux-boot-console.py.data/parameters.yaml
> +++ b/tests/avocado/test_linux-boot-console.py.data/parameters.yaml
> @@ -1,3 +1,5 @@
>  architecture: !mux
>      alpha:
>          arch: alpha
> +    mips:
> +        arch: mips
>=20

The reply to PATCH 0 showed that by a bit more configuration, all of
this code could be dropped.  That approach also solved the check for
architecture and canceling tests if they don't match.

I'd like to understand if this approach makes sense, or if you can see
any drawbacks.

Thanks!
- Cleber.
