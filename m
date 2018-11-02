Received: from eggs.gnu.org ([2001:4830:134:3::10]:46919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christoffer.dall@arm.com>) id 1gIfEe-0005jy-63
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 15:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christoffer.dall@arm.com>) id 1gIfEX-0003KV-J7
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 15:35:58 -0400
Date: Fri, 2 Nov 2018 20:35:29 +0100
From: Christoffer Dall <christoffer.dall@arm.com>
Message-ID: <20181102193529.GB12057@e113682-lin.lund.arm.com>
References: <20181102145433.4553-1-richard.henderson@linaro.org>
	<CAFEAcA_tcR_33Q+2ZFHdzo4_9khXggum=gRfZ8+L49KmP3hHiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_tcR_33Q+2ZFHdzo4_9khXggum=gRfZ8+L49KmP3hHiw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/5] target/arm: KVM vs ARMISARegisters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <Dave.Martin@arm.com>

On Fri, Nov 02, 2018 at 04:36:35PM +0000, Peter Maydell wrote:
> On 2 November 2018 at 14:54, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> > My previous patch set for replacing feature bits with id registers
> > failed to consider that these id registers are beginning to control
> > migration, and thus we must fill them in for KVM as well.
> >
> > Thus, we want to initialize these values within CPU from the host.
> >
> > Finally, re-send the T32EE conversion patch, fixing the build
> > failure on an arm32 host in kvm32.c.
> >
> > Changes, v1->v2:
> >   * Remove assert that AArch32 sysreg <= UINT32_MAX.
> >   * Remove unused local variable.
> >   * Add commentary for AArch32 sysregs vs missing AArch32 support.
> 
> As noted on IRC, on my admittedly pretty ancient 4.8.0 kernel some
> of these ID register reads via KVM_GET_ONE_REG fail ENOENT.
> strace says:
> 
> openat(AT_FDCWD, "/dev/kvm", O_RDWR|O_CLOEXEC) = 18
> ioctl(18, KVM_CREATE_VM or LOGGER_GET_LOG_BUF_SIZE, 0) = 19
> ioctl(19, KVM_CREATE_VCPU, 0)           = 20
> ioctl(19, KVM_ARM_PREFERRED_TARGET, 0xffffcfeb4e88) = 0
> ioctl(20, KVM_ARM_VCPU_INIT, 0xffffcfeb4e88) = 0
> ioctl(20, KVM_ARM_SET_DEVICE_ADDR or KVM_GET_ONE_REG, 0xffffcfeb4e28)
> = -1 ENOENT (No such file or directory)
> ioctl(20, KVM_ARM_SET_DEVICE_ADDR or KVM_GET_ONE_REG, 0xffffcfeb4e28)
> = -1 ENOENT (No such file or directory)
> ioctl(20, KVM_ARM_SET_DEVICE_ADDR or KVM_GET_ONE_REG, 0xffffcfeb4e28)
> = -1 ENOENT (No such file or directory)
> ioctl(20, KVM_ARM_SET_DEVICE_ADDR or KVM_GET_ONE_REG, 0xffffcfeb4e28)
> = -1 ENOENT (No such file or directory)
> ioctl(20, KVM_ARM_SET_DEVICE_ADDR or KVM_GET_ONE_REG, 0xffffcfeb4e28) = 0
> ioctl(20, KVM_ARM_SET_DEVICE_ADDR or KVM_GET_ONE_REG, 0xffffcfeb4e28) = 0
> ioctl(20, KVM_ARM_SET_DEVICE_ADDR or KVM_GET_ONE_REG, 0xffffcfeb4e28) = 0
> ioctl(20, KVM_ARM_SET_DEVICE_ADDR or KVM_GET_ONE_REG, 0xffffcfeb4e28) = 0
> ioctl(20, KVM_ARM_SET_DEVICE_ADDR or KVM_GET_ONE_REG, 0xffffcfeb4e28) = 0
> ioctl(20, KVM_ARM_SET_DEVICE_ADDR or KVM_GET_ONE_REG, 0xffffcfeb4e28) = 0
> ioctl(20, KVM_ARM_SET_DEVICE_ADDR or KVM_GET_ONE_REG, 0xffffcfeb4e28)
> = -1 ENOENT (No such file or directory)
> ioctl(20, KVM_ARM_SET_DEVICE_ADDR or KVM_GET_ONE_REG, 0xffffcfeb4e28)
> = -1 ENOENT (No such file or directory)
> ioctl(20, KVM_ARM_SET_DEVICE_ADDR or KVM_GET_ONE_REG, 0xffffcfeb4e28)
> = -1 ENOENT (No such file or directory)
> ioctl(20, KVM_ARM_SET_DEVICE_ADDR or KVM_GET_ONE_REG, 0xffffcfeb4e28)
> = -1 ENOENT (No such file or directory)
> 
> 
> I added a bit of extra tracing, since strace doesn't
> print the ID field for the ioctl:
> 
> peter.maydell@mustang-maydell:~/qemu$
> ~/test-images/virtv8-for-nesting/runme-kvm
> ./build/for-kvm/aarch64-softmmu/qemu-system-aarch64 -enable-kvm -cpu
> max -machine gic-version=max
> read_sys_reg64: reading ID 0x603000000013c030...-1
> read_sys_reg64: reading ID 0x603000000013c031...-1
> read_sys_reg64: reading ID 0x603000000013c020...-1
> read_sys_reg64: reading ID 0x603000000013c021...-1
> read_sys_reg32: reading ID 0x603000000013c010...0
> read_sys_reg32: reading ID 0x603000000013c011...0
> read_sys_reg32: reading ID 0x603000000013c012...0
> read_sys_reg32: reading ID 0x603000000013c013...0
> read_sys_reg32: reading ID 0x603000000013c014...0
> read_sys_reg32: reading ID 0x603000000013c015...0
> read_sys_reg32: reading ID 0x603000000013c017...-1
> read_sys_reg32: reading ID 0x603000000013c018...-1
> read_sys_reg32: reading ID 0x603000000013c019...-1
> read_sys_reg32: reading ID 0x603000000013c01a...-1
> qemu-system-aarch64: Failed to retrieve host CPU features
> 
> It looks like the kernel can handle reads of ID_ISAR0_EL1
> through ID_ISAR5_EL1, but not ID_ISAR6_EL1, any of the
> MVFR*_EL1 or ID_AA64_ISAR* or ID_AA64PFR*.
> 
> This is probably because the kernel is way too old to be
> interestingly supportable for KVM, but we did previously
> manage to boot on this setup.

I'm a little confused. v4.8 used to work (although it was perhaps not
the most stable at that time).  What changed?  Is this attempting to
restore a VM from a newer kernel, or has QEMU been updated to detect
this?

> 
> We should probably at least figure out which version of
> the kernel fixed this bug and made the ID registers available
> to userspace... if it's sufficiently ancient we could
> likely say "not supported", but if it's more recent we
> need a workaround somehow. I have cc'd a couple of kernel
> folks who might be able to help with the "which version"
> question.
> 

It appears the support for exposing a bunch of ID registers was
introduced with:

93390c0a1b20 (arm64: KVM: Hide unsupported AArch64 CPU features from guests, 2017-10-31)

Which Dave (cc'ed) wrote and which was introduced in v4.15.

As per my question above, I'm not exactly sure what (if anything) we
need to fix on the kernel side?


Thanks,

    Christoffer
