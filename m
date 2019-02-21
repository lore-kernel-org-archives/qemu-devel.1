Received: from eggs.gnu.org ([209.51.188.92]:44880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gwpDH-0006vB-W7
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:20:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gwpD9-0004A4-Av
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:20:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:10156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1gwpCz-0003y7-Ma
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:20:19 -0500
References: <20190214190603.25030-1-peter.maydell@linaro.org>
	<20190214190603.25030-12-peter.maydell@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <72c526bd-6c30-5e7a-4ff0-da8473348d0a@redhat.com>
Date: Thu, 21 Feb 2019 15:20:12 +0100
MIME-Version: 1.0
In-Reply-To: <20190214190603.25030-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 11/27] arm: Allow system registers for KVM
 guests to be changed by QEMU code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

Hi Peter, Alex,
On 2/14/19 8:05 PM, Peter Maydell wrote:
> At the moment the Arm implementations of kvm_arch_{get,put}_registers()
> don't support having QEMU change the values of system registers
> (aka coprocessor registers for AArch32). This is because although
> kvm_arch_get_registers() calls write_list_to_cpustate() to
> update the CPU state struct fields (so QEMU code can read the
> values in the usual way), kvm_arch_put_registers() does not
> call write_cpustate_to_list(), meaning that any changes to
> the CPU state struct fields will not be passed back to KVM.
>=20
> The rationale for this design is documented in a comment in the
> AArch32 kvm_arch_put_registers() -- writing the values in the
> cpregs list into the CPU state struct is "lossy" because the
> write of a register might not succeed, and so if we blindly
> copy the CPU state values back again we will incorrectly
> change register values for the guest. The assumption was that
> no QEMU code would need to write to the registers.
>=20
> However, when we implemented debug support for KVM guests, we
> broke that assumption: the code to handle "set the guest up
> to take a breakpoint exception" does so by updating various
> guest registers including ESR_EL1.
>=20
> Support this by making kvm_arch_put_registers() synchronize
> CPU state back into the list. We sync only those registers
> where the initial write succeeds, which should be sufficient.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Tested-by: Dongjiu Geng <gengdongjiu@huawei.com>
This commit introduces a regression when running with EDK2 FW:

I get the following traces:

error: kvm run failed Function not implemented
 PC=3D000000013f5a6208 X00=3D00000000404003c4 X01=3D000000000000003a
X02=3D0000000000000000 X03=3D00000000404003c4 X04=3D0000000000000000
X05=3D0000000096000046 X06=3D000000013d2ef270 X07=3D000000013e3d1710
X08=3D09010755ffaf8ba8 X09=3Dffaf8b9cfeeb5468 X10=3Dfeeb546409010756
X11=3D09010757ffaf8b90 X12=3Dfeeb50680903068b X13=3D090306a1ffaf8bc0
X14=3D0000000000000000 X15=3D0000000000000000 X16=3D000000013f872da0
X17=3D00000000ffffa6ab X18=3D0000000000000000 X19=3D000000013f5a92d0
X20=3D000000013f5a7a78 X21=3D000000000000003a X22=3D000000013f5a7ab2
X23=3D000000013f5a92e8 X24=3D000000013f631090 X25=3D0000000000000010
X26=3D0000000000000100 X27=3D000000013f89501b X28=3D000000013e3d14e0
X29=3D000000013e3d12a0 X30=3D000000013f5a2518  SP=3D000000013b7be0b0
PSTATE=3D404003c4 -Z-- EL1t


and in host dmesg:
[ 3507.926571] kvm [35042]: load/store instruction decoding not implement=
ed


My qemu cmd line is:

qemu-system-aarch64 -M virt,gic-version=3D3 -cpu host -smp 2 -m 4G
-display none --enable-kvm -serial tcp:localhost:4444,server -qmp
unix:/home/augere/TEST/QEMU/qmp-sock,server,nowait -device
virtio-blk-pci,bus=3Dpcie.0,scsi=3Doff,drive=3Ddrv0,id=3Dvirtio-disk0,boo=
tindex=3D1,werror=3Dstop,rerror=3Dstop
-drive
file=3Daarch64-vm0-rhel-alt-7.6.qcow2,format=3Dqcow2,if=3Dnone,cache=3Dwr=
itethrough,id=3Ddrv0
-device virtio-net-pci,bus=3Dpcie.0,netdev=3Dnic0,mac=3D6a:f5:10:b1:3d:d2
-netdev
tap,id=3Dnic0,script=3D/home/augere/TEST/SCRIPTS/qemu-ifup,downscript=3D/=
home/augere/TEST/SCRIPTS/qemu-ifdown
-bios
/home/augere/UPSTREAM/edk2/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/FV/QEMU_E=
FI.fd
-net none -d guest_errors

reverting the patch removes the guest crash. Any clue?

thanks

Eric


> ---
>  target/arm/cpu.h     |  9 ++++++++-
>  target/arm/helper.c  | 27 +++++++++++++++++++++++++--
>  target/arm/kvm32.c   | 20 ++------------------
>  target/arm/kvm64.c   |  2 ++
>  target/arm/machine.c |  2 +-
>  5 files changed, 38 insertions(+), 22 deletions(-)
>=20
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index f0334413ece..bfc05c796a5 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2535,18 +2535,25 @@ bool write_list_to_cpustate(ARMCPU *cpu);
>  /**
>   * write_cpustate_to_list:
>   * @cpu: ARMCPU
> + * @kvm_sync: true if this is for syncing back to KVM
>   *
>   * For each register listed in the ARMCPU cpreg_indexes list, write
>   * its value from the ARMCPUState structure into the cpreg_values list=
.
>   * This is used to copy info from TCG's working data structures into
>   * KVM or for outbound migration.
>   *
> + * @kvm_sync is true if we are doing this in order to sync the
> + * register state back to KVM. In this case we will only update
> + * values in the list if the previous list->cpustate sync actually
> + * successfully wrote the CPU state. Otherwise we will keep the value
> + * that is in the list.
> + *
>   * Returns: true if all register values were read correctly,
>   * false if some register was unknown or could not be read.
>   * Note that we do not stop early on failure -- we will attempt
>   * reading all registers in the list.
>   */
> -bool write_cpustate_to_list(ARMCPU *cpu);
> +bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
> =20
>  #define ARM_CPUID_TI915T      0x54029152
>  #define ARM_CPUID_TI925T      0x54029252
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 5ac335f598c..7653aa6a50a 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -264,7 +264,7 @@ static bool raw_accessors_invalid(const ARMCPRegInf=
o *ri)
>      return true;
>  }
> =20
> -bool write_cpustate_to_list(ARMCPU *cpu)
> +bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync)
>  {
>      /* Write the coprocessor state from cpu->env to the (index,value) =
list. */
>      int i;
> @@ -273,6 +273,7 @@ bool write_cpustate_to_list(ARMCPU *cpu)
>      for (i =3D 0; i < cpu->cpreg_array_len; i++) {
>          uint32_t regidx =3D kvm_to_cpreg_id(cpu->cpreg_indexes[i]);
>          const ARMCPRegInfo *ri;
> +        uint64_t newval;
> =20
>          ri =3D get_arm_cp_reginfo(cpu->cp_regs, regidx);
>          if (!ri) {
> @@ -282,7 +283,29 @@ bool write_cpustate_to_list(ARMCPU *cpu)
>          if (ri->type & ARM_CP_NO_RAW) {
>              continue;
>          }
> -        cpu->cpreg_values[i] =3D read_raw_cp_reg(&cpu->env, ri);
> +
> +        newval =3D read_raw_cp_reg(&cpu->env, ri);
> +        if (kvm_sync) {
> +            /*
> +             * Only sync if the previous list->cpustate sync succeeded=
.
> +             * Rather than tracking the success/failure state for ever=
y
> +             * item in the list, we just recheck "does the raw write w=
e must
> +             * have made in write_list_to_cpustate() read back OK" her=
e.
> +             */
> +            uint64_t oldval =3D cpu->cpreg_values[i];
> +
> +            if (oldval =3D=3D newval) {
> +                continue;
> +            }
> +
> +            write_raw_cp_reg(&cpu->env, ri, oldval);
> +            if (read_raw_cp_reg(&cpu->env, ri) !=3D oldval) {
> +                continue;
> +            }
> +
> +            write_raw_cp_reg(&cpu->env, ri, newval);
> +        }
> +        cpu->cpreg_values[i] =3D newval;
>      }
>      return ok;
>  }
> diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
> index bd51eb43c86..a75e04cc8f3 100644
> --- a/target/arm/kvm32.c
> +++ b/target/arm/kvm32.c
> @@ -387,24 +387,8 @@ int kvm_arch_put_registers(CPUState *cs, int level=
)
>          return ret;
>      }
> =20
> -    /* Note that we do not call write_cpustate_to_list()
> -     * here, so we are only writing the tuple list back to
> -     * KVM. This is safe because nothing can change the
> -     * CPUARMState cp15 fields (in particular gdb accesses cannot)
> -     * and so there are no changes to sync. In fact syncing would
> -     * be wrong at this point: for a constant register where TCG and
> -     * KVM disagree about its value, the preceding write_list_to_cpust=
ate()
> -     * would not have had any effect on the CPUARMState value (since t=
he
> -     * register is read-only), and a write_cpustate_to_list() here wou=
ld
> -     * then try to write the TCG value back into KVM -- this would eit=
her
> -     * fail or incorrectly change the value the guest sees.
> -     *
> -     * If we ever want to allow the user to modify cp15 registers via
> -     * the gdb stub, we would need to be more clever here (for instanc=
e
> -     * tracking the set of registers kvm_arch_get_registers() successf=
ully
> -     * managed to update the CPUARMState with, and only allowing those
> -     * to be written back up into the kernel).
> -     */
> +    write_cpustate_to_list(cpu, true);
> +
>      if (!write_list_to_kvmstate(cpu, level)) {
>          return EINVAL;
>      }
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 089af9c5f02..e3ba1492482 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -838,6 +838,8 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>          return ret;
>      }
> =20
> +    write_cpustate_to_list(cpu, true);
> +
>      if (!write_list_to_kvmstate(cpu, level)) {
>          return EINVAL;
>      }
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index b2925496148..124192bfc26 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -630,7 +630,7 @@ static int cpu_pre_save(void *opaque)
>              abort();
>          }
>      } else {
> -        if (!write_cpustate_to_list(cpu)) {
> +        if (!write_cpustate_to_list(cpu, false)) {
>              /* This should never fail. */
>              abort();
>          }
>=20
