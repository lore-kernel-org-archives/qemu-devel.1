Received: from eggs.gnu.org ([209.51.188.92]:32814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1goRG1-0006xv-6P
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:08:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1goRFz-00045M-Eu
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:08:45 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1goRFy-0002Yc-5Y
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:08:43 -0500
Received: by mail-wr1-x441.google.com with SMTP id x10so21522763wrs.8
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 03:08:22 -0800 (PST)
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 29 Jan 2019 11:08:19 +0000
Message-ID: <87va27n2l8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Kernel boot regression with PAuth and aarch64-softmmu
 -cpu max and el2 enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, "open list:ARM" <qemu-arm@nongnu.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
Cc: Mark Rutland <mark.rutland@arm.com>, Richard Henderson <richard.henderson@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>


Hi,

Following up on yesterday's discussion on IRC I thought I'd better
report on my findings in the permanent record so things don't get lost.

As I tend to periodically rebuild my test kernels from the current
state of linux.git I occasionally run into these things. My test
invocation is:

  qemu-system-aarch64 -machine type=3Dvirt,virtualization=3Don \
                      -display none -m 4096 -serial mon:stdio \
                      -kernel ../../kernel-v8-plain.build/arch/arm64/boot/I=
mage \
                      -append 'console=3DttyAMA0 panic=3D-1' -no-reboot -cp=
u max

The kernel is essentially a defconfig kernel with a bunch of the VIRTIO
device drivers built-in for when I actually boot a more complex setup
with disks and drives. However this is a boot test so doesn't really
matter.

The -machine type=3Dvirt,virtualization=3Don enables our virt machine model
with EL2 turned on. As there is no BIOS involved the kernel is invoked
directly at EL2.

The -cpu max enabled a cortex-a57 + whatever extra features we've
enabled in QEMU so far. It won't match any "real" CPU but it should be
architecturally correct in so far we implement prerequisite features for
any given feature. The cpuid feature bits should also be correct as we
test them internally in QEMU to enable features.

The breakage is the kernel never boots (no output on serial port) and on
attaching with gdb I found it stuck in:

  (gdb) bt
  #0  0xffffff8010a9e480 in overflow_stack ()
  Backtrace stopped: not enough registers or memory available to unwind fur=
ther

If I turn on exception tracing it looks like we go into an exception
loop.

On the QEMU side this breakage comes in at:

  commit 1ce32e47db52e3511132c7104770eae65d412144 (HEAD, refs/bisect/bad)
  Author: Richard Henderson <richard.henderson@linaro.org>
  Date:   Mon Jan 21 10:23:13 2019 +0000

      target/arm: Enable PAuth for -cpu max

      Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
      Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
      Message-id: 20190108223129.5570-30-richard.henderson@linaro.org
      Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

and as you would expect the system boots fine with -cpu cortex-a57

On the kernel side it breaks at:

  commit 04ca3204fa09f5f55c8f113b0072004a7b364ff4
  Author: Mark Rutland <mark.rutland@arm.com>
  Date:   Fri Dec 7 18:39:30 2018 +0000

      arm64: enable pointer authentication

      Now that all the necessary bits are in place for userspace, add the
      necessary Kconfig logic to allow this to be enabled.

      Signed-off-by: Mark Rutland <mark.rutland@arm.com>
      Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
      Cc: Catalin Marinas <catalin.marinas@arm.com>
      Cc: Will Deacon <will.deacon@arm.com>
      Signed-off-by: Will Deacon <will.deacon@arm.com>

So predictably we failed at enabling PAuth somewhere between the kernel
and QEMU.

I'm guessing the kernel so far has been tested on the fast model with a
full chain of TF, UEFI and kernel?

I think Richard's tests were without EL2 enabled.

So in the case that the kernel boots in EL2 is it expecting anyone else
to deal with Pauth exceptions or should it be able to cope with an
enabled Pauth but no firmware underneath it?

Either we've got something wrong or we'll need to rethink what features
the user can have enabled by -cpu max on a direct kernel boot.

--
Alex Benn=C3=A9e
