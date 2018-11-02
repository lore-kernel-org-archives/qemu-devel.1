Received: from eggs.gnu.org ([2001:4830:134:3::10]:40492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gIULq-0008O4-C4
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 03:58:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gIULn-0008VV-4U
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 03:58:42 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gIULg-0008Rx-4j
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 03:58:34 -0400
Received: by mail-wm1-x344.google.com with SMTP id f19-v6so689469wmb.0
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 00:58:26 -0700 (PDT)
References: <20181101215739.29788-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181101215739.29788-1-richard.henderson@linaro.org>
Date: Fri, 02 Nov 2018 07:58:23 +0000
Message-ID: <87o9b76hcw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/arm: Conditionalize arm_div assert
 on aarch32 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> When populating id registers from kvm, on a host that doesn't support
> aarch32 mode at all, aa32_arm_div will not be supported either.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>
> "Tested" on an APM Mustang, which does support AArch32.  I'm not
> sure, off hand, which cpu(s) don't have it, and Alex didn't say
> in his bug report.  Tsk tsk.  ;-)

It's qemu-test - which I think is a ThunderX. Unfortunately I think we
need the same treatment for the Jazelle test:

  ./aarch64-softmmu/qemu-system-aarch64 -machine virt,gic-version=3D3 -acce=
l kvm -cpu host -serial mon:stdio -nic user,model=3Dvirtio-net-pci,hostfwd=
=3Dtcp::2222-:22 -device virtio-scsi-pci -kernel ../linux.git/arch/arm64/bo=
ot/Image -append "console=3DttyAMA0 panic=3D-1" -display none -m 4096 --no-=
reboot
  qemu-system-aarch64: /home/alex/lsrc/qemu.git/target/arm/cpu.c:866: arm_c=
pu_realizefn: Assertion `cpu_isar_feature(jazelle, cpu)' failed.
  fish: =E2=80=9C./aarch64-softmmu/qemu-system-a=E2=80=A6=E2=80=9D terminat=
ed by signal SIGABRT (Abort)


>
>
> r~
>
> ---
>  target/arm/cpu.h |  5 +++++
>  target/arm/cpu.c | 10 +++++++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 895f9909d8..4521ad5ae8 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -3300,6 +3300,11 @@ static inline bool isar_feature_aa64_fp16(const AR=
MISARegisters *id)
>      return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, FP) =3D=3D 1;
>  }
>
> +static inline bool isar_feature_aa64_a32(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, EL0) =3D=3D 2;
> +}
> +
>  static inline bool isar_feature_aa64_sve(const ARMISARegisters *id)
>  {
>      return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, SVE) !=3D 0;
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index e08a2d2d79..988d97d1f1 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -828,8 +828,16 @@ static void arm_cpu_realizefn(DeviceState *dev, Erro=
r **errp)
>           * include the various other features that V7VE implies.
>           * Presence of EL2 itself is ARM_FEATURE_EL2, and of the
>           * Security Extensions is ARM_FEATURE_EL3.
> +         *
> +         * V7VE requires ARM division.  However, there exist AArch64 cpus
> +         * without AArch32 support.  When KVM queries ID_ISAR0_EL1 on su=
ch
> +         * a host, the value is UNKNOWN.  Similarly, we cannot check
> +         * ID_AA64PFR0 without AArch64 support.  Check everything in ord=
er.
>           */
> -        assert(cpu_isar_feature(arm_div, cpu));
> +        if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)
> +            && cpu_isar_feature(aa64_a32, cpu)) {
> +            assert(cpu_isar_feature(arm_div, cpu));
> +        }
>          set_feature(env, ARM_FEATURE_LPAE);
>          set_feature(env, ARM_FEATURE_V7);
>      }


--
Alex Benn=C3=A9e
