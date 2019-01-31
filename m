Received: from eggs.gnu.org ([209.51.188.92]:51571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gp2E5-0001GD-LG
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 21:37:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gp2E3-0003Ol-Es
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 21:37:13 -0500
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-15-crosa@redhat.com> <8736pk1xs8.fsf@linaro.org>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <dc4dff53-8786-c62c-63a9-4203604c03bc@redhat.com>
Date: Wed, 30 Jan 2019 21:37:01 -0500
MIME-Version: 1.0
In-Reply-To: <8736pk1xs8.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 14/18] Boot Linux Console Test: add a test
 for ppc64 + pseries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>



On 1/22/19 11:07 AM, Alex Benn=C3=A9e wrote:
>=20
> Cleber Rosa <crosa@redhat.com> writes:
>=20
>> Just like the previous tests, boots a Linux kernel on a ppc64 target
>> using the pseries machine.
>=20
> So running this on my rather slow SynQuacer I get:
>=20
>  (04/16) /home/alex/lsrc/qemu.git/tests/acceptance/boot_linux_console.p=
y:BootLinuxConsole.test_ppc64_pseries: INTERRUPTED: Test reported status =
but did not finish\nRunner error occurred: Timeout reached\nOriginal stat=
us: ERROR\n{'name': '04-/home/alex/lsrc/qemu.git/tests/acceptance/boot_li=
nux_console.py:BootLinuxConsole.test_ppc64_pseries', 'logdir': '/home/ale=
x/lsrc/qemu.git/te... (60.93 s)
>=20
> which I'm guessing is a timeout occurring.
>=20

Yes, that's what's happening.  It's hard to pinpoint, and control, the
sluggishness points in such a test running on a different environment.
For this one execution, I do trust your assessment, and it's most
certainly caused by your "slow SynQuacer", spending too much running
emulation code.

But, I'd like to mention that there are other possibilities.  One is
that you're hitting a "asset fetcher bug" that I recently fixed in
Avocado[1] (fix to be available on 68.0, to be released next Monday, Feb
4th).

Even with that bug fixed, I feel like it's unfair to test code to spend
its time waiting to download a file when it's not testing *the file
download itself*.  Because of that, there are plans to add an (optional)
job pre-processing step that will make sure the needed assets are in the
cache ahead of time[2][3].

> I wonder if that means we should:
>=20
>   a) set timeouts longer for when running on TCG
>   or
>   b) split tests into TCG and KVM tests and select KVM tests on appropr=
iate HW
>=20

I wonder the same, and I believe this falls into a similar scenario
we've seen with the setup of console devices in the QEMUMachine class.
I've started by setting the device types defined at the framework level,
and then reverted to the machine's default devices (using '-serial'),
because the "default" behavior of QEMU is usually what a test writer
wants when not setting something else explicitly.

> The qemu.py code has (slightly flawed) logic for detecting KVM and
> passing --enable-kvm. Maybe we should be doing that here?
>=20

I'm not sure.  IMO, the common question is: should we magically (at a
framework level) configure tests based on probed host environment
characteristics?  I feel like we should attempt to minimize that for the
sake of tests being more obvious and more easily reproducible.

And because of that, I'd go, *initially*, with an approach more similar
to your option "b".

Having said that, we don't want to rewrite most tests just to be able to
test with either KVM or TCG, if the tests are not explicitly testing KVM
or TCG.  At this point, using KVM or TCG is test/framework
*configuration*, and in Avocado we hope to solve this by having the
executed tests easily identifiable and reproducible (a test ID will
contain a information about the options passed, and a replay of the job
will apply the same configuration).

For now, I think the best approach is to increase the timeout, because I
think it's much worse to have to deal with false negatives (longer
execution times that don't really mean a failure), than having a test
possibly taking some more time to finish.

And sorry for extremely the long answer!
- Cleber.

[1] - https://github.com/avocado-framework/avocado/pull/2996
[2] -
https://trello.com/c/WPd4FrIy/1479-add-support-to-specify-assets-in-test-=
docstring
[3] - https://trello.com/c/CKP7YS6G/1481-on-cache-check-for-asset-fetcher
