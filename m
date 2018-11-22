Received: from eggs.gnu.org ([2001:4830:134:3::10]:57155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gPvOO-0002zk-Q2
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 15:16:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gPvOK-0002Qn-Rw
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 15:16:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1gPvOK-0002Oe-Kd
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 15:16:00 -0500
References: <20181121214818.22874-1-crosa@redhat.com>
	<20181121214818.22874-2-crosa@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <d67d31c9-06fe-1f06-66e0-bc6678212ccd@redhat.com>
Date: Thu, 22 Nov 2018 18:15:51 -0200
MIME-Version: 1.0
In-Reply-To: <20181121214818.22874-2-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] RFC: Acceptance tests: add the
 build directory to the system PATH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>


On 11/21/2018 07:48 PM, Cleber Rosa wrote:
> So that when binaries such as qemu-img are searched for, those in the
> build tree will be favored.  As a clarification, SRC_ROOT_DIR is
> dependent on the location from where tests are executed, so they are
> equal to the build directory if one is being used.

On avocado's job.log file I can see the full path of the qemu-img which=20
was called, but I wonder if it wouldn't be better to log that=20
information somewhere more explicitly. It wouldn't prevent this patch=20
from being merged though, it's just an improvement suggestion.

>
> The original motivation is that Avocado libraries such as
> avocado.utils.vmimage.get() may use the matching binaries, but it may
> also apply to any other binary that test code may eventually attempt
> to execute.
>
> Other competing alternatives would be a more explicit path or binary
> registration mechanism, in which we tell the libraries such as
> avocado.utils.vmimage, the binaries to use in advance.  I think the
> model proposed here is simpler though, and is not inconsistent with
> the general approach of favoring the built binaries, and falling back
> to binaries available in the system.  I'd love to have comments on
> that, though.

IMHO it makes sense to pick the built binaries, falling back to system's=20
otherwise. Keep it simple (and consistent) unless we eventually need=20
something robust, I would go for that approach here.

>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/acceptance/avocado_qemu/__init__.py | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptan=
ce/avocado_qemu/__init__.py
> index 1e54fd5932..3d5190cbab 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -49,6 +49,15 @@ class Test(avocado.Test):
>               self.cancel("No QEMU binary defined or found in the sourc=
e tree")
>           self.vm =3D QEMUMachine(self.qemu_bin)
>  =20
> +        # RFC: avocado.utils.vmimage.get() uses qemu-img, from the
> +        # system's PATH, to create a snapshot.  This is a transparent,
> +        # but implicit way of making sure it finds the qemu-img that
> +        # matches the code being tested (as tests it indirectly too).
> +        # As for the cleanup, given that in the Avocado test execution
> +        # model every test is started in a different process, no
> +        # cleanup is needed.
> +        os.environ['PATH'] =3D '%s:%s' % (SRC_ROOT_DIR, os.environ['PA=
TH'])
> +
>       def tearDown(self):
>           if self.vm is not None:
>               self.vm.shutdown()

The boot Linux test (added on patch 02) exits with error when I ran=20
'make check-acceptance'. I am using Fedora 29 x86_64 which don't have=20
qemu-img installed system-wide. See below:

------
# make check-acceptance
 =C2=A0 AVOCADO tests/acceptance
make: *** [/root/qemu/tests/Makefile.include:940: check-acceptance] Error=
 9
# cat tests/results/latest/results.tap
1..8
not ok 1 /root/qemu/tests/acceptance/boot_linux.py:BootLinux.test
# grep -e 'ERROR.*CmdNotFoundError' tests/results/latest/job.log
2018-11-22 14:51:30,540 stacktrace=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L0=
047 ERROR|=C2=A0=C2=A0=C2=A0=C2=A0 raise=20
CmdNotFoundError(cmd, path_paths)
2018-11-22 14:51:30,540 stacktrace=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 L0=
047 ERROR|=20
avocado.utils.path.CmdNotFoundError: Command 'qemu-img' could not be=20
found in any of the PATH dirs: ['/usr/local/bin', '/bin', '/root/bin',=20
'/sbin', '/usr/libexec', '/usr/local/sbin', '/root/qemu', '/usr/bin',=20
'/usr/sbin']
2018-11-22 14:51:30,572 test=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 L0984 ERROR|=20
avocado.utils.path.CmdNotFoundError: Command 'qemu-img' could not be=20
found in any of the PATH dirs: ['/usr/local/bin', '/bin', '/root/bin',=20
'/sbin', '/usr/libexec', '/usr/local/sbin', '/root/qemu', '/usr/bin',=20
'/usr/sbin']
2018-11-22 14:51:30,572 test=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 L0999 ERROR| ERROR=20
1-/root/qemu/tests/acceptance/boot_linux.py:BootLinux.test ->=20
CmdNotFoundError: Command 'qemu-img' could not be found in any of the=20
PATH dirs: ['/usr/local/bin', '/bin', '/root/bin', '/sbin',=20
'/usr/libexec', '/usr/local/sbin', '/root/qemu', '/usr/bin', '/usr/sbin']
------

The same test finished successfully when I ran with 'avocado run (...)'=20
though.

- Wainer
