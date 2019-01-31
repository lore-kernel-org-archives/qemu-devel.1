Received: from eggs.gnu.org ([209.51.188.92]:54071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gpIXl-000169-Ns
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 15:02:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gpIXj-0005cs-6O
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 15:02:37 -0500
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-16-crosa@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <b235e7a9-57ad-5547-b8ca-693159820a8f@redhat.com>
Date: Thu, 31 Jan 2019 18:02:21 -0200
MIME-Version: 1.0
In-Reply-To: <20190117185628.21862-16-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 15/18] Boot Linux Console Test: add a test
 for aarch64 + virt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>, Aleksandar Rikalo <arikalo@wavecomp.com>


On 01/17/2019 04:56 PM, Cleber Rosa wrote:
> Just like the previous tests, boots a Linux kernel on a aarch64 target
> using the virt machine.
>
> One special option added is the CPU type, given that the kernel
> selected fails to boot on the virt machine's default CPU (cortex-a15).
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   .travis.yml                            |  2 +-
>   tests/acceptance/boot_linux_console.py | 20 ++++++++++++++++++++
>   2 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 54100eea5a..595e8c0b6c 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -187,7 +187,7 @@ matrix:
>  =20
>       # Acceptance (Functional) tests
>       - env:
> -        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64=
-softmmu,mips-softmmu,mips64el-softmmu,ppc64-softmmu"
> +        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64=
-softmmu,mips-softmmu,mips64el-softmmu,ppc64-softmmu,aarch64-softmmu"
>           - TEST_CMD=3D"make check-acceptance"
>         addons:
>           apt:
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/=
boot_linux_console.py
> index f3ccd23a7a..107700b517 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -138,3 +138,23 @@ class BootLinuxConsole(Test):
>           self.vm.launch()
>           console_pattern =3D 'Kernel command line: %s' % kernel_comman=
d_line
>           self.wait_for_console_pattern(console_pattern)
> +
> +    def test_aarch64_virt(self):

That test case fails on my system (Fedora 29 x86_64). Avocado seems=20
unable to kill the VM so it=C2=A0 reaches the timeout.

I compiled QEMU with default configuration:

$ configure --python=3D/usr/bin/python3 --target-list=3Dx86_64-softmmu=20
--target-list=3Dx86_64-softmmu,mips-softmmu,mips64el-softmmu,ppc64-softmm=
u,aarch64-softmmu)

Follows a snippet of the Avocado's job.log file:
----
2019-01-31 14:41:34,912 test=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 L0602 INFO | START=20
07-/root/src/qemu/tests/acceptance/boot_linux_console.py:BootLinuxConsole=
.test_aarch64_virt
2019-01-31 14:41:34,912 test=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 L0298 DEBUG| DATA=20
(filename=3Doutput.expected) =3D> NOT FOUND (data sources: variant, test,=
 file)
2019-01-31 14:41:34,913 parameters=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L0=
146 DEBUG| PARAMS (key=3Darch,=20
path=3D*, default=3Daarch64) =3D> 'aarch64'
2019-01-31 14:41:34,913 parameters=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L0=
146 DEBUG| PARAMS=20
(key=3Dqemu_bin, path=3D*, default=3Daarch64-softmmu/qemu-system-aarch64)=
 =3D>=20
'aarch64-softmmu/qemu-system-aarch64'
2019-01-31 14:41:34,915 download=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 L0070 INFO | Fetching=20
https://sjc.edge.kernel.org/fedora-buffet/fedora/linux/releases/29/Server=
/aarch64/os/images/pxeboot/vmlinuz=20
-> /var/lib/avocado/data/cache/by_name/vmlinuz.3upct2pr
2019-01-31 14:41:35,490 download=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 L0054 DEBUG| Retrieved URL=20
"https://sjc.edge.kernel.org/fedora-buffet/fedora/linux/releases/29/Serve=
r/aarch64/os/images/pxeboot/vmlinuz":=20
content-length 8623423, date: "Thu, 31 Jan 2019 19:41:35 GMT",=20
last-modified: "Sun, 21 Oct 2018 00:43:09 GMT"
2019-01-31 14:41:41,765 qemu=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 L0317 DEBUG| VM launch command:=20
'aarch64-softmmu/qemu-system-aarch64 -chardev=20
socket,id=3Dmon,path=3D/var/tmp/tmpizirkcud/qemu-32609-monitor.sock -mon=20
chardev=3Dmon,mode=3Dcontrol -display none -vga none -machine virt -chard=
ev=20
socket,id=3Dconsole,path=3D/var/tmp/tmpizirkcud/qemu-32609-console.sock,s=
erver,nowait=20
-serial chardev:console -cpu cortex-a53 -kernel=20
/var/lib/avocado/data/cache/by_name/vmlinuz -append console=3DttyAMA0'
2019-01-31 14:41:41,779 qmp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L0167 DEBUG| >>> {'execute':=20
'qmp_capabilities'}
2019-01-31 14:41:41,931 qmp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L0175 DEBUG| <<< {'return': {}}
2019-01-31 14:41:42,830 boot_linux_conso L0041 DEBUG| [=C2=A0=C2=A0=C2=A0=
 0.000000]=20
Booting Linux on physical CPU 0x0000000000 [0x410fd034]

(...)

2019-01-31 14:41:42,833 boot_linux_conso L0041 DEBUG| [=C2=A0=C2=A0=C2=A0=
 0.000000]=20
Policy zone: DMA32
2019-01-31 14:41:42,833 boot_linux_conso L0041 DEBUG| [=C2=A0=C2=A0=C2=A0=
 0.000000]=20
Kernel command line: console=3DttyAMA0
2019-01-31 14:41:42,833 qmp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L0167 DEBUG| >>> {'execute':=20
'quit'}
2019-01-31 14:44:35,636 qemu=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 L0357 WARNI| qemu received=20
signal -9: aarch64-softmmu/qemu-system-aarch64 -chardev=20
socket,id=3Dmon,path=3D/var/tmp/tmpizirkcud/qemu-32609-monitor.sock -mon=20
chardev=3Dmon,mode=3Dcontrol -display none -vga none -machine virt -chard=
ev=20
socket,id=3Dconsole,path=3D/var/tmp/tmpizirkcud/qemu-32609-console.sock,s=
erver,nowait=20
-serial chardev:console -cpu cortex-a53 -kernel=20
/var/lib/avocado/data/cache/by_name/vmlinuz -append console=3DttyAMA0

(...)

2019-01-31 14:44:35,663 runner=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 L0253 ERROR| ERROR Test=20
reported status but did not finish -> TestAbortError:=20
07-/root/src/qemu/tests/acceptance/boot_linux_console.py:BootLinuxConsole=
.test_aarch64_virt.
2019-01-31 14:44:35,664 runner=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 L0062 ERROR| Runner error=20
occurred: Timeout reached
----

- Wainer

> +        """
> +        :avocado: tags=3Darch:aarch64
> +        :avocado: tags=3Dmachine:virt
> +        """
> +        kernel_url =3D ('https://sjc.edge.kernel.org/fedora-buffet/fed=
ora/linux/'
> +                      'releases/29/Server/aarch64/os/images/pxeboot/vm=
linuz')
> +        kernel_hash =3D '8c73e469fc6ea06a58dc83a628fc695b693b8493'
> +        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkern=
el_hash)
> +
> +        self.vm.set_machine('virt')
> +        self.vm.set_console()
> +        kernel_command_line =3D 'console=3DttyAMA0'
> +        self.vm.add_args('-cpu', 'cortex-a53',
> +                         '-kernel', kernel_path,
> +                         '-append', kernel_command_line)
> +        self.vm.launch()
> +        console_pattern =3D 'Kernel command line: %s' % kernel_command=
_line
> +        self.wait_for_console_pattern(console_pattern)
