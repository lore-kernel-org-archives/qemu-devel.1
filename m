Received: from eggs.gnu.org ([209.51.188.92]:42515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gtxQ2-0004e6-QF
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:29:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gtxQ0-0006Oj-VP
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:29:54 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:50501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gtxPz-0006HY-Gf
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:29:52 -0500
Received: by mail-wm1-x334.google.com with SMTP id x7so3182049wmj.0
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 08:29:47 -0800 (PST)
References: <20181206151401.13455-1-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181206151401.13455-1-peter.maydell@linaro.org>
Date: Wed, 13 Feb 2019 16:29:44 +0000
Message-ID: <87ftsrird3.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] arm: Allow system registers for KVM guests
 to be changed by QEMU code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Dongjiu Geng <gengdongjiu@huawei.com>


Peter Maydell <peter.maydell@linaro.org> writes:

> At the moment the Arm implementations of kvm_arch_{get,put}_registers()
> don't support having QEMU change the values of system registers
> (aka coprocessor registers for AArch32). This is because although
> kvm_arch_get_registers() calls write_list_to_cpustate() to
> update the CPU state struct fields (so QEMU code can read the
> values in the usual way), kvm_arch_put_registers() does not
> call write_cpustate_to_list(), meaning that any changes to
> the CPU state struct fields will not be passed back to KVM.
>
> The rationale for this design is documented in a comment in the
> AArch32 kvm_arch_put_registers() -- writing the values in the
> cpregs list into the CPU state struct is "lossy" because the
> write of a register might not succeed, and so if we blindly
> copy the CPU state values back again we will incorrectly
> change register values for the guest. The assumption was that
> no QEMU code would need to write to the registers.
>
> However, when we implemented debug support for KVM guests, we
> broke that assumption: the code to handle "set the guest up
> to take a breakpoint exception" does so by updating various
> guest registers including ESR_EL1.
>
> Support this by making kvm_arch_put_registers() synchronize
> CPU state back into the list. We sync only those registers
> where the initial write succeeds, which should be sufficient.

So my test is boot the guest:

  qemu-system-aarch64 -nodefaults -cpu host \
                      -machine type=3Dvirt,gic-version=3Dhost,accel=3Dkvm \
                      -display none -m 4096 -serial mon:stdio \
                      -netdev user,id=3Dunet,hostfwd=3Dtcp::2222-:22 \
                      -device virtio-net-pci,netdev=3Dunet \
                      -device virtio-scsi-pci \
                      -blockdev driver=3Draw,node-name=3Dhd,discard=3Dunmap=
,file.driver=3Dhost_device,file.filename=3D/dev/idun-vg/debian-buster-arm64=
 \
                      -device scsi-hd,drive=3Dhd \
                      -kernel ../linux.git/arch/arm64/boot/Image \
                      -append "console=3DttyAMA0 root=3D/dev/sda2" -s -S

And then in another window:

  gdb vmlinux -ex "target remote localhost:1234"

and then:
  c
  disable 1
  <break>
  enable 1

This leaves a hardware breakpoint enabled and therefor KVM guest
debugging aware. Then I ssh into the guest and debug some of our test
cases:

  gdb ./aarch64-linux-user/tests/fcvt
  start

this works with a temporary SW bkpt (and comes through
kvm_arm_handle_debug and is delivered to the guest).

  (gdb) x/10i $pc
  =3D> 0x400d2c <main+16>:  adrp    x0, 0x44f000 <dl_iterate_phdr+224>
     0x400d30 <main+20>:  add     x0, x0, #0xec0
     0x400d34 <main+24>:  bl      0x407998 <puts>
     0x400d38 <main+28>:  str     wzr, [sp, #44]
     0x400d3c <main+32>:  b       0x400da8 <main+140>
  (gdb) hbreak *0x400d38
  Hardware assisted breakpoint 2 at 0x400d38: file /home/alex/lsrc/qemu.git=
/tests/tcg/arm/fcvt.c, line 409.
  (gdb) b *0x400d3c
  Breakpoint 3 at 0x400d3c: file /home/alex/lsrc/qemu.git/tests/tcg/arm/fcv=
t.c, line 409.

Then I hit i (stepi):

  Breakpoint 3, main (argc=3D1, argv=3D0x7ffffff848) at /home/alex/lsrc/qem=
u.git/tests/tcg/arm/fcvt.c:409
  409         for (i =3D 0; i < ARRAY_SIZE(round_flags); ++i) {
  =3D> 0x400d3c <main+32>:  b       0x400da8 <main+140>

stepi doesn't work but we do hit the SW breakpoint. It's expected that
hbreak won't work as while the host is doing guest debugging with
hardware breakpoints it uses them all. However if you switch the host to
use SW breakpoints then you get:

  Breakpoint 2, main (argc=3D1, argv=3D0x7ffffff848) at /home/alex/lsrc/qem=
u.git/tests/tcg/arm/fcvt.c:409
  409         for (i =3D 0; i < ARRAY_SIZE(round_flags); ++i) {
  =3D> 0x400d38 <main+28>:  str     wzr, [sp, #44]
     0x400d3c <main+32>:  b       0x400da8 <main+140>
     0x400d40 <main+36>:  adrp    x0, 0x485000

As you can multiplex breakpoints between the host and guest fine
(although if the guest happened to somehow set a SW breakpoint at the
same place the host had set a SW breakpoint the host would "win").

If the host deletes all breakpoints the guest can use all the facilities
fine which is to be expected as nothing comes through
kvm_arm_handle_debug for that.

The reason single-step doesn't work is because the kernel suppresses the
guests ability to do it while single-stepping is in effect.

   if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP) {
           *vcpu_cpsr(vcpu) |=3D  DBG_SPSR_SS;
           mdscr =3D vcpu_read_sys_reg(vcpu, MDSCR_EL1);
           mdscr |=3D DBG_MDSCR_SS;
           vcpu_write_sys_reg(vcpu, mdscr, MDSCR_EL1);
   } else {
           mdscr =3D vcpu_read_sys_reg(vcpu, MDSCR_EL1);
           mdscr &=3D ~DBG_MDSCR_SS;
           vcpu_write_sys_reg(vcpu, mdscr, MDSCR_EL1);
   }

And of course because it does this we check in qemu:

  case EC_SOFTWARESTEP:
      if (cs->singlestep_enabled) {
          return true;
      } else {
          /*
           * The kernel should have suppressed the guest's ability to
           * single step at this point so something has gone wrong.
           */
          error_report("%s: guest single-step while debugging unsupported"
                       " (%"PRIx64", %"PRIx32")",
                       __func__, env->pc, debug_exit->hsr);
          return false;
      }
      break;

I wonder if this restriction is being too restrictive. I'll have to
experiment....

Anyway:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I think this patch:
>  * should be necessary for the current KVM debug code to be able
>    to actually set the ESR_EL1 for the guest when it wants to
>    deliver a breakpoint exception to it
>  * will also be necessary for Dongjiu's patchset to inject
>    external aborts on memory errors
>
> I have tagged it "RFC" because I don't have a setup to test
> that; I've just given it a quick smoke test that it runs a
> VM OK. Please test this and check whether it really does
> fix the bugs I think it does :-)
>
> Opinions welcome on whether the "try the write-and-read-back"
> approach in write_cpustate_to_list() is too hacky and it
> would be better to actually record whether write_list_to_cpustate()
> succeeded for each register. (That would require another array.)
> ---
>  target/arm/cpu.h     |  9 ++++++++-
>  target/arm/helper.c  | 27 +++++++++++++++++++++++++--
>  target/arm/kvm32.c   | 20 ++------------------
>  target/arm/kvm64.c   |  2 ++
>  target/arm/machine.c |  2 +-
>  5 files changed, 38 insertions(+), 22 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 2a73fed9a01..c0c111378ea 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2321,18 +2321,25 @@ bool write_list_to_cpustate(ARMCPU *cpu);
>  /**
>   * write_cpustate_to_list:
>   * @cpu: ARMCPU
> + * @kvm_sync: true if this is for syncing back to KVM
>   *
>   * For each register listed in the ARMCPU cpreg_indexes list, write
>   * its value from the ARMCPUState structure into the cpreg_values list.
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
>
>  #define ARM_CPUID_TI915T      0x54029152
>  #define ARM_CPUID_TI925T      0x54029252
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 0da1424f72d..bc2969eb4d8 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -263,7 +263,7 @@ static bool raw_accessors_invalid(const ARMCPRegInfo =
*ri)
>      return true;
>  }
>
> -bool write_cpustate_to_list(ARMCPU *cpu)
> +bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync)
>  {
>      /* Write the coprocessor state from cpu->env to the (index,value) li=
st. */
>      int i;
> @@ -272,6 +272,7 @@ bool write_cpustate_to_list(ARMCPU *cpu)
>      for (i =3D 0; i < cpu->cpreg_array_len; i++) {
>          uint32_t regidx =3D kvm_to_cpreg_id(cpu->cpreg_indexes[i]);
>          const ARMCPRegInfo *ri;
> +        uint64_t newval;
>
>          ri =3D get_arm_cp_reginfo(cpu->cp_regs, regidx);
>          if (!ri) {
> @@ -281,7 +282,29 @@ bool write_cpustate_to_list(ARMCPU *cpu)
>          if (ri->type & ARM_CP_NO_RAW) {
>              continue;
>          }
> -        cpu->cpreg_values[i] =3D read_raw_cp_reg(&cpu->env, ri);
> +
> +        newval =3D read_raw_cp_reg(&cpu->env, ri);
> +        if (kvm_sync) {
> +            /*
> +             * Only sync if the previous list->cpustate sync succeeded.
> +             * Rather than tracking the success/failure state for every
> +             * item in the list, we just recheck "does the raw write we =
must
> +             * have made in write_list_to_cpustate() read back OK" here.
> +             */

"in the last call to write_list_to_cpustate()"?

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
> @@ -387,24 +387,8 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>          return ret;
>      }
>
> -    /* Note that we do not call write_cpustate_to_list()
> -     * here, so we are only writing the tuple list back to
> -     * KVM. This is safe because nothing can change the
> -     * CPUARMState cp15 fields (in particular gdb accesses cannot)
> -     * and so there are no changes to sync. In fact syncing would
> -     * be wrong at this point: for a constant register where TCG and
> -     * KVM disagree about its value, the preceding write_list_to_cpustat=
e()
> -     * would not have had any effect on the CPUARMState value (since the
> -     * register is read-only), and a write_cpustate_to_list() here would
> -     * then try to write the TCG value back into KVM -- this would either
> -     * fail or incorrectly change the value the guest sees.
> -     *
> -     * If we ever want to allow the user to modify cp15 registers via
> -     * the gdb stub, we would need to be more clever here (for instance
> -     * tracking the set of registers kvm_arch_get_registers() successful=
ly
> -     * managed to update the CPUARMState with, and only allowing those
> -     * to be written back up into the kernel).
> -     */
> +    write_cpustate_to_list(cpu, true);
> +
>      if (!write_list_to_kvmstate(cpu, level)) {
>          return EINVAL;
>      }
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 0a502091e76..d8ac978d7c3 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -834,6 +834,8 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>          return ret;
>      }
>
> +    write_cpustate_to_list(cpu, true);
> +
>      if (!write_list_to_kvmstate(cpu, level)) {
>          return EINVAL;
>      }
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index 7a22ebc2098..0dd0157f4d4 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -626,7 +626,7 @@ static int cpu_pre_save(void *opaque)
>              abort();
>          }
>      } else {
> -        if (!write_cpustate_to_list(cpu)) {
> +        if (!write_cpustate_to_list(cpu, false)) {
>              /* This should never fail. */
>              abort();
>          }

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
