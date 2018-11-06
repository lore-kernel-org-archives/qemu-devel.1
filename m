Received: from eggs.gnu.org ([2001:4830:134:3::10]:45669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gJz19-0007xf-PU
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:55:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gJz12-0005N5-J6
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:55:28 -0500
References: <1d1c0473-cd71-c7de-9d56-072596501e4c@redhat.com>
	<CAFEAcA-6hMmfQuiA-23fgzYyp7bz0yb+t-rhD0wt_h0UMH=CgQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d21e2c1f-ee7e-0dcc-fb4b-29b78c28b45f@redhat.com>
Date: Tue, 6 Nov 2018 11:55:07 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-6hMmfQuiA-23fgzYyp7bz0yb+t-rhD0wt_h0UMH=CgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] How to use the 'canon-a1100' machine?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Antony Pavlov <antonynpavlov@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 2018-11-06 11:32, Peter Maydell wrote:
> On 6 November 2018 at 09:40, Thomas Huth <thuth@redhat.com> wrote:
>>
>>  Hi,
>>
>> does anybody know whether the "canon-a1100" machine in QEMU is still
>> usable, or rather how it can be used at all?
>>
>> According to
>> http://lists.infradead.org/pipermail/barebox/2014-July/020327.html the=
re
>> should be support for "-serial stdio" and on
>> https://lists.gnu.org/archive/html/qemu-devel/2013-10/msg02969.html
>> there is a link to a firmware image ... but when I try to use it, ther=
e
>> is simply no output on stdio...
>>
>> Is there a way this machine can still be tested in QEMU?
>=20
> I have an image in my test set:
> $ ~/test-images/digic/runme ./build/x86/arm-softmmu/qemu-system-arm
> Switch to console [cs0]
>=20
>=20
> barebox 2013.12.0-00160-g2e82c4a #507 Thu Dec 12 12:42:43 MSK 2013
>=20
>=20
> Board: Canon PowerShot A1100 IS
> digic-gpio c0220000.gpio: probed gpiochip-1 with base 0
> cfi_flash f8000000.flash: found cfi flash at f8000000, size 4194304
> malloc space: 0x00100000 -> 0x002fffff (size 2 MiB)
> Open /dev/env0 No such file or directory
> no valid environment found on /dev/env0. Using default environment
> running /env/bin/init...
> canon> /
>=20
> Command line is:
>=20
> ${QEMU} \
>   -M canon-a1100 -serial stdio -display none \
>   --machine firmware=3D"$TESTDIR"/canon-a1100-rom1.bin
>=20
> filename suggests that's the same firmware image you link to?
>=20
> $ md5sum ~/test-images/digic/canon-a1100-rom1.bin
> 66e76691cbd8b140549c878ae3849147

Thanks for the hint! My image had a different md5sum, so I think
it's just a bad version that I've downloaded. I've finally also
managed to compile barebox on my own with these steps:

tar -xaf barebox-....tar.bz2
cd barebox-...
cp ./arch/arm/configs/canon-a1100_defconfig .config
make CROSS_PREFIX=3Darm-linux-gnu- ARCH=3Darm CC=3Darm-linux-gnu-gcc \
 LD=3Darm-linux-gnu-ld OBJCOPY=3Darm-linux-gnu-objcopy olddefconfig
make CROSS_PREFIX=3Darm-linux-gnu- ARCH=3Darm CC=3Darm-linux-gnu-gcc \
 LD=3Darm-linux-gnu-ld OBJCOPY=3Darm-linux-gnu-objcopy -j8

And that version indeed prints some output via its emulated serial
console to stdio :-)

CC-ing some "tests/docker" people in case somebody wants to turn
that into a docker-based test, too...

 Thomas
