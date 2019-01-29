Received: from eggs.gnu.org ([209.51.188.92]:41087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.rutland@arm.com>) id 1goRqU-000788-2x
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:46:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.rutland@arm.com>) id 1goRqR-0004b7-W6
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:46:25 -0500
Date: Tue, 29 Jan 2019 11:46:09 +0000
From: Mark Rutland <mark.rutland@arm.com>
Message-ID: <20190129114609.GA25983@lakrids.cambridge.arm.com>
References: <87va27n2l8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87va27n2l8.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Kernel boot regression with PAuth and
 aarch64-softmmu -cpu max and el2 enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, "open list:ARM" <qemu-arm@nongnu.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, Richard Henderson <richard.henderson@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Kristina Martsenko <kristina.martsenko@arm.com>

Hi,

[adding Kristina, who is in charge of Linux pointer authentication]

On Tue, Jan 29, 2019 at 11:08:19AM +0000, Alex Benn=C3=A9e wrote:
> Hi,
>=20
> Following up on yesterday's discussion on IRC I thought I'd better
> report on my findings in the permanent record so things don't get lost.
>=20
> As I tend to periodically rebuild my test kernels from the current
> state of linux.git I occasionally run into these things. My test
> invocation is:
>=20
>   qemu-system-aarch64 -machine type=3Dvirt,virtualization=3Don \
>                       -display none -m 4096 -serial mon:stdio \
>                       -kernel ../../kernel-v8-plain.build/arch/arm64/bo=
ot/Image \
>                       -append 'console=3DttyAMA0 panic=3D-1' -no-reboot=
 -cpu max
>
> The kernel is essentially a defconfig kernel with a bunch of the VIRTIO
> device drivers built-in for when I actually boot a more complex setup
> with disks and drives. However this is a boot test so doesn't really
> matter.
>=20
> The -machine type=3Dvirt,virtualization=3Don enables our virt machine m=
odel
> with EL2 turned on. As there is no BIOS involved the kernel is invoked
> directly at EL2.
>=20
> The -cpu max enabled a cortex-a57 + whatever extra features we've
> enabled in QEMU so far. It won't match any "real" CPU but it should be
> architecturally correct in so far we implement prerequisite features fo=
r
> any given feature. The cpuid feature bits should also be correct as we
> test them internally in QEMU to enable features.

Just to check, does this enable VHE?

> The breakage is the kernel never boots (no output on serial port) and o=
n
> attaching with gdb I found it stuck in:
>=20
>   (gdb) bt
>   #0  0xffffff8010a9e480 in overflow_stack ()
>   Backtrace stopped: not enough registers or memory available to unwind=
 further
>=20
> If I turn on exception tracing it looks like we go into an exception
> loop.

As mentioned on IRC, this looks very odd, since overflow_stack is a data
pointer, not code. I can't presently see how we could branch here.

If you pass the kernel 'earlycon keep_bootcon', do you get any output?

> On the QEMU side this breakage comes in at:
>=20
>   commit 1ce32e47db52e3511132c7104770eae65d412144 (HEAD, refs/bisect/ba=
d)
>   Author: Richard Henderson <richard.henderson@linaro.org>
>   Date:   Mon Jan 21 10:23:13 2019 +0000
>=20
>       target/arm: Enable PAuth for -cpu max
>=20
>       Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>       Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>       Message-id: 20190108223129.5570-30-richard.henderson@linaro.org
>       Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>=20
> and as you would expect the system boots fine with -cpu cortex-a57
>=20
> On the kernel side it breaks at:
>=20
>   commit 04ca3204fa09f5f55c8f113b0072004a7b364ff4
>   Author: Mark Rutland <mark.rutland@arm.com>
>   Date:   Fri Dec 7 18:39:30 2018 +0000
>=20
>       arm64: enable pointer authentication
>=20
>       Now that all the necessary bits are in place for userspace, add t=
he
>       necessary Kconfig logic to allow this to be enabled.
>=20
>       Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>       Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
>       Cc: Catalin Marinas <catalin.marinas@arm.com>
>       Cc: Will Deacon <will.deacon@arm.com>
>       Signed-off-by: Will Deacon <will.deacon@arm.com>
>=20
> So predictably we failed at enabling PAuth somewhere between the kernel
> and QEMU.
>=20
> I'm guessing the kernel so far has been tested on the fast model with a
> full chain of TF, UEFI and kernel?

The kernel has been tested on a fast model with the Linux bootwrapper:

https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/

Kristina, could you confirm whether or not it's been tested with
ATF+UEFI?

> I think Richard's tests were without EL2 enabled.
>=20
> So in the case that the kernel boots in EL2 is it expecting anyone else
> to deal with Pauth exceptions or should it be able to cope with an
> enabled Pauth but no firmware underneath it?

So long as the highest implemented exception level is EL2, the kernel
should handle that itself. During boot we'll configure HCR_EL2.{API,APK}
in el2_setup().

>From that point onwards, there should be no traps for pointer
authentication functionality from EL1, AFAICT.

> Either we've got something wrong or we'll need to rethink what features
> the user can have enabled by -cpu max on a direct kernel boot.

It's not immediately clear to me when precisely things are going wrong,
so I think we need to narrow that down first. For example, it's not
clear whether a trap is being taken, or something is unexpectedly
behaving is UNDEF.

Is it possible to watch the exception vectors to see if/when an
exception is taken, and from where?

Thanks,
Mark.
