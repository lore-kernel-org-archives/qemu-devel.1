Received: from eggs.gnu.org ([2001:4830:134:3::10]:57531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fDHcU-00012s-8t
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 18:50:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fDHcR-00031t-16
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 18:50:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53714 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1fDHcQ-00030x-Rd
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 18:50:02 -0400
References: <20180419164642.9536-1-f4bug@amsat.org>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <1ab5791c-2702-261e-4fbb-a6a845650a71@redhat.com>
Date: Mon, 30 Apr 2018 18:49:51 -0400
MIME-Version: 1.0
In-Reply-To: <20180419164642.9536-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/7] avocado: Add acceptance tests
 parsing the Linux boot console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Zheng Xiang <xiang.zheng@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Alistair Francis <alistair23@gmail.com>



On 04/19/2018 12:46 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi,
>=20
> While previously working on a Super I/O refactor, I encountered some pr=
oblems
> at runtime, after building the codebase successfully and running qtests=
.
> I had to manually start to boot different guests and check the bootlog.
>=20
> I wanted to give a try at Avocado which seems designed to simplify that=
 kind
> of functional tests.
>=20
> I applied Amador Pahim work following Cleber Rosa documentation from
> http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg03891.html,
> however I had to modify few things to parse the boot console.
> Since his work is not merged, I included it in this series.
>=20
> The tests simply expect to find a string reported by Linux printk when =
a
> device is detected/initialized, such "ttyS0 at I/O 0x3f8 (irq =3D 4) is=
 a 16550A"
> and "i8042 KBD port at 0x60,0x64 irq 1" for the Super I/O chip, or such
> "registered as PCnet/PCI II 79C970A" to confirms the PCI subsystem and =
network
> device are correctly detected:
>=20
>=20
>     self.assertIn(u'ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A', bootlo=
g)
>     self.assertIn(u'ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A', bootlo=
g)
>     self.assertIn(u'i8042 KBD port at 0x60,0x64 irq 1', bootlog)
>     self.assertIn(u'i8042 AUX port at 0x60,0x64 irq 12', bootlog)
>=20
> Example of the tests output:
>=20
>     $ avocado run test_linux-boot-console.py -m test_linux-boot-console=
.py.data/parameters.yaml=20
>     JOB ID     : 695094c9bbe8f6011226da7c2031c2c53e949910
>     JOB LOG    : /home/phil/avocado/job-results/job-2018-04-19T13.36-69=
5094c/job.log
>      (1/6) test_linux-boot-console.py:TestAlphaClipperBoot2_6.test_boot=
_console;alpha-2582: PASS (4.76 s)
>      (2/6) test_linux-boot-console.py:TestAlphaClipperBoot2_6.test_boot=
_console;mips-4a72: PASS (0.00 s)
>      (3/6) test_linux-boot-console.py:TestMips4kcMaltaBoot2_6.test_boot=
_console;alpha-2582: PASS (0.00 s)
>      (4/6) test_linux-boot-console.py:TestMips4kcMaltaBoot2_6.test_boot=
_console;mips-4a72: PASS (3.92 s)
>      (5/6) test_linux-boot-console.py:TestMips4kcMaltaBoot3_2.test_boot=
_console;alpha-2582: PASS (0.00 s)
>      (6/6) test_linux-boot-console.py:TestMips4kcMaltaBoot3_2.test_boot=
_console;mips-4a72: PASS (4.08 s)
>     RESULTS    : PASS 6 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUP=
T 0 | CANCEL 0
>     JOB TIME   : 13.31 s
>=20
> Please apologize my ugly Python, this series is just a proof-of-concept=
 :)
> I couldn't figure out how to use the @skipUnless(correct arch) decorato=
r.
>=20
> Regards,
>=20
> Phil.
>=20

Hi Philippe,

Thanks for this interesting RFC/PoC.  As someone who has spent more time
"on the other" side of this code, this perspective is invaluable.  I'll
respond to the major feature utilization points here, and then proceed
to review the individual patches.

One of the distinguishing features of Avocado is the ability to reuse
test code in different scenarios (thus reducing the amount of duplicated
code while still improving the overall coverage).  I noticed you grasped
the overall usage pattern of the "YAML to Mux" plugin, by means of the
"parameter.yaml".

This is an alternative proposal for the "parameter.yaml" file:

--- "parameter.yaml" STARTS HERE
architechture: !mux
   alpha:
      arch: alpha
      machine_type: clipper
      kernel_url:
http://archive.debian.org/debian/dists/lenny/main/installer-alpha/current=
/images/cdrom/vmlinuz
   mips:
     arch: mips
     machine_type: malta
     check_pci: True
     kernel_versions: !mux
        2_6:
           kernel_url:
http://people.debian.org/~aurel32/qemu/mips/vmlinux-2.6.32-5-4kc-malta
        3_2:
           kernel_url:
http://people.debian.org/~aurel32/qemu/mips/vmlinux-3.2.0-4-4kc-malta
--- "parameter.yaml" ENDS HERE

This file content produces the following tree (run it with "avocado -c
-t -m parameter.yaml"):

Multiplex tree representation:
 =E2=94=97=E2=94=81=E2=94=81 run
      =E2=94=97=E2=94=81=E2=94=81 architechture
           =E2=95=A0=E2=95=90=E2=95=90 alpha
           =E2=95=91     =E2=86=92 arch: alpha
           =E2=95=91     =E2=86=92 machine_type: clipper
           =E2=95=91     =E2=86=92 kernel_url:
http://archive.debian.org/debian/dists/lenny/main/installer-alpha/current=
/images/cdrom/vmlinuz
           =E2=95=9A=E2=95=90=E2=95=90 mips
                =E2=94=83   =E2=86=92 check_pci: True
                =E2=94=83   =E2=86=92 arch: mips
                =E2=94=83   =E2=86=92 machine_type: malta
                =E2=94=97=E2=94=81=E2=94=81 kernel_versions
                     =E2=95=A0=E2=95=90=E2=95=90 2_6
                     =E2=95=91     =E2=86=92 kernel_url:
http://people.debian.org/~aurel32/qemu/mips/vmlinux-2.6.32-5-4kc-malta
                     =E2=95=9A=E2=95=90=E2=95=90 3_2
                           =E2=86=92 kernel_url:
http://people.debian.org/~aurel32/qemu/mips/vmlinux-3.2.0-4-4kc-malta


And it generates the following variants (run it with "avocado -m
parameters.yaml"):

Multiplex variants (3):
Variant alpha-deaa:  /run/architechture/alpha
Variant 2_6-6f08:    /run/architechture/mips/kernel_versions/2_6
Variant 3_2-e556:    /run/architechture/mips/kernel_versions/3_2

With these variants, it's possible to have a single code test
implementation.  Here's my alternative implementation of your tests:

--- "test_linux-boot-console.py" STARTS HERE
import os
import tempfile
import gzip

from avocado_qemu import test
from avocado.utils import process


class TestBootCheckDevices(test.QemuTest):
    """
    :avocado: enable
    """
    def get_kernel_uncompressed(self):
        kernel =3D self.fetch_asset(self.params.get("kernel_url"))
        try:
            process.run("gzip -l %s" % kernel)
        except process.CmdError:
            # only deal with gzip compressed kernels here
            return kernel

        kernel_uncompressed_path =3D kernel + ".uncompressed"
        with gzip.open(kernel, 'rb') as kernel_gzip:
            with open(kernel_uncompressed_path, 'wb') as
kernel_uncompressed:
                kernel_uncompressed.write(kernel_gzip.read())
        return kernel_uncompressed_path

    def setUp(self):
        kernel_path =3D self.get_kernel_uncompressed()
        self.console_path =3D tempfile.mkstemp()[1]
        self.vm._args.extend(['-m', '64'])
        self.vm._args.extend(['-kernel', kernel_path])
        self.vm._args.extend(['-append', '"console=3DttyS0 printk.time=3D=
0"'])
        self.vm._args.extend(['-chardev',
'socket,id=3Dsrm,server,nowait,path=3D' + self.console_path])
        self.vm._args.extend(['-serial', 'chardev:srm'])
        # This kernel crashes without VGA display
        self.vm._args.extend(['-vga', 'std'])
        self.vm.launch(self.console_path)
        console =3D self.vm.get_console(console_address=3Dself.console_pa=
th,
login=3DFalse)
        # no filesystem provided on purpose, wait for the Kernel panic
        self.bootlog =3D console.read_until_any_line_matches(["Kernel
panic - not syncing: VFS: Unable to mount root fs"], timeout=3D30.0)[1]
        console.close()

    def test(self):
        # check Super I/O
        self.assertIn(u'ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A',
self.bootlog)
        self.assertIn(u'ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A',
self.bootlog)
        self.assertIn(u'i8042 KBD port at 0x60,0x64 irq 1', self.bootlog)
        self.assertIn(u'i8042 AUX port at 0x60,0x64 irq 12', self.bootlog=
)
        # check PCI
        if self.params.get('check_pci', default=3DFalse):
            self.assertIn(u'registered as PCnet/PCI II 79C970A',
self.bootlog)

    def tearDown(self):
        self.vm.shutdown()
        os.remove(self.console_path)
--- "test_linux-boot-console.py" ENDS HERE

A few points about this code:

1) get_kernel_uncompressed() is a prime candidate for a utility
function, even at the "avocado.utils.archive" level (a better version,
of course).  It's one of those things that arise from writing more
diverse code (again, thanks for this experiment).

2) setUp() still contains a lot of boiler plate code, and can certainly
have some of that moved to "avocado_qemu".  For instance, the
"avocado_qemu" code already knows how to deal with some parameters, such
as "arch" and "machine_type", so "memory", "kernel", etc could be
handled in a similar fashion.

3) It wasn't clear to me if manually creating a serial device and using
it as a console was a hard requirement of the test.  The
QEMUMachine._create_console() method on the "scripts/qemu.py" file
already has some code to create many console types.

Finally, running this code + parameters (by using "avocado run -m
test_linux-boot-console.py.data/parameters.yaml --
test_linux-boot-console.py") results in:

JOB ID     : bb7585de42035a062ddda539801743267aa4431a
JOB LOG    :
/home/cleber/avocado/job-results/job-2018-04-30T18.46-bb7585d/job.log
 (1/3) test_linux-boot-console.py:TestBootCheckDevices.test;alpha-deaa:
PASS (3.04 s)
 (2/3) test_linux-boot-console.py:TestBootCheckDevices.test;2_6-6f08:
PASS (2.83 s)
 (3/3) test_linux-boot-console.py:TestBootCheckDevices.test;3_2-e556:
PASS (2.86 s)
RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 |
CANCEL 0
JOB TIME   : 9.86 s
JOB HTML   :
/home/cleber/avocado/job-results/job-2018-04-30T18.46-bb7585d/results.htm=
l

The resulting "job.log" file can be seen at:

https://paste.fedoraproject.org/paste/G4X-z5PcmMdmmIVBDKVWVg/raw

Now, unto individual commits.
- Cleber.

> Amador Pahim (1):
>   AVOCADO_QEMU: Snapshot commit
>=20
> Philippe Mathieu-Daud=C3=A9 (6):
>   avocado: Update python scripts to upstream codebase
>   qemu.py: Check console arch is supported before calling mktemp()
>   qemu.py: Avoid deprecated tempfile.mktemp()
>   avocado: Add an optional flag 'login' to get_console()
>   avocado: Add a test parsing Linux kernel booting console
>   avocado: Add tests booting the Malta machine
>=20
>  scripts/qemu.py                               |  50 ++-
>  tests/avocado/README.rst                      | 132 ++++++
>  tests/avocado/avocado_qemu/__init__.py        |   0
>  tests/avocado/avocado_qemu/test.py            | 419 ++++++++++++++++++
>  tests/avocado/parameters.yaml                 |  19 +
>  tests/avocado/test_info_memdev_host_nodes.py  |  66 +++
>  tests/avocado/test_linux-boot-console.py      | 180 ++++++++
>  .../parameters.yaml                           |   5 +
>  tests/avocado/test_nec-usb-xhci.py            |  63 +++
>  .../test_nec-usb-xhci.py.data/parameters.yaml |   4 +
>  tests/avocado/test_numa_hotplug.py            | 120 +++++
>  tests/avocado/test_ovmf_with_240_vcpus.py     |  70 +++
>  .../parameters.yaml                           |   2 +
>  tests/avocado/variants.yaml                   |  62 +++
>  14 files changed, 1187 insertions(+), 5 deletions(-)
>  create mode 100644 tests/avocado/README.rst
>  create mode 100644 tests/avocado/avocado_qemu/__init__.py
>  create mode 100644 tests/avocado/avocado_qemu/test.py
>  create mode 100644 tests/avocado/parameters.yaml
>  create mode 100644 tests/avocado/test_info_memdev_host_nodes.py
>  create mode 100644 tests/avocado/test_linux-boot-console.py
>  create mode 100644 tests/avocado/test_linux-boot-console.py.data/param=
eters.yaml
>  create mode 100644 tests/avocado/test_nec-usb-xhci.py
>  create mode 100644 tests/avocado/test_nec-usb-xhci.py.data/parameters.=
yaml
>  create mode 100644 tests/avocado/test_numa_hotplug.py
>  create mode 100644 tests/avocado/test_ovmf_with_240_vcpus.py
>  create mode 100644 tests/avocado/test_ovmf_with_240_vcpus.py.data/para=
meters.yaml
>  create mode 100644 tests/avocado/variants.yaml
>=20

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]
