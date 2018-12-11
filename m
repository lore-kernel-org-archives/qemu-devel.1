Received: from eggs.gnu.org ([2001:4830:134:3::10]:47262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWjNA-0002z1-Or
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:50:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWjN9-0004zL-Qc
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:50:56 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44337)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gWjN9-0004ys-Cj
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:50:55 -0500
Received: by mail-ot1-x344.google.com with SMTP id f18so14216089otl.11
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 06:50:55 -0800 (PST)
MIME-Version: 1.0
References: <20181207103631.28193-1-richard.henderson@linaro.org>
	<20181207103631.28193-2-richard.henderson@linaro.org>
In-Reply-To: <20181207103631.28193-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Dec 2018 14:50:43 +0000
Message-ID: <CAFEAcA9yJu-1OmSPW9G=3C80zdZc49xF+ws6pTxA=otR0-TPNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 01/26] target/arm: Add state for the
 ARMv8.3-PAuth extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>

On Fri, 7 Dec 2018 at 10:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Add storage space for the 5 encryption keys.  Migrate them when
> the extension is enabled.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h     | 23 +++++++++++++++++++++++
>  target/arm/machine.c | 23 +++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index c943f35dd9..0766e32a1b 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -605,6 +605,14 @@ typedef struct CPUARMState {
>          uint32_t cregs[16];
>      } iwmmxt;
>
> +#ifdef TARGET_AARCH64
> +    uint64_t apia_key[2];
> +    uint64_t apib_key[2];
> +    uint64_t apda_key[2];
> +    uint64_t apdb_key[2];
> +    uint64_t apga_key[2];
> +#endif
> +
>  #if defined(CONFIG_USER_ONLY)
>      /* For usermode syscall translation.  */
>      int eabi;
> @@ -3324,6 +3332,21 @@ static inline bool isar_feature_aa64_fcma(const ARMISARegisters *id)
>      return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, FCMA) != 0;
>  }
>
> +static inline bool isar_feature_aa64_pauth(const ARMISARegisters *id)
> +{
> +    /*
> +     * Note that while QEMU will only implement the architected algorithm
> +     * QARMA, and thus APA+GPA, the host cpu for kvm may use implementation
> +     * defined algorithms, and thus API+GPI, and this predicate controls
> +     * migration of the 128-bit keys.
> +     */
> +    return (id->id_aa64isar1 &
> +            (FIELD_DP64(0, ID_AA64ISAR1, APA, -1) |
> +             FIELD_DP64(0, ID_AA64ISAR1, API, -1) |
> +             FIELD_DP64(0, ID_AA64ISAR1, GPA, -1) |
> +             FIELD_DP64(0, ID_AA64ISAR1, GPI, -1))) != 0;
> +}
> +
>  static inline bool isar_feature_aa64_fp16(const ARMISARegisters *id)
>  {
>      /* We always set the AdvSIMD and FP fields identically wrt FP16.  */
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index 7a22ebc209..340b36084c 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -169,6 +169,28 @@ static const VMStateDescription vmstate_sve = {
>          VMSTATE_END_OF_LIST()
>      }
>  };
> +
> +static bool pauth_needed(void *opaque)
> +{
> +    ARMCPU *cpu = opaque;
> +
> +    return cpu_isar_feature(aa64_pauth, cpu);
> +}
> +
> +static const VMStateDescription vmstate_pauth = {
> +    .name = "cpu/pauth",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = pauth_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT64_ARRAY(env.apia_key, ARMCPU, 2),
> +        VMSTATE_UINT64_ARRAY(env.apib_key, ARMCPU, 2),
> +        VMSTATE_UINT64_ARRAY(env.apda_key, ARMCPU, 2),
> +        VMSTATE_UINT64_ARRAY(env.apdb_key, ARMCPU, 2),
> +        VMSTATE_UINT64_ARRAY(env.apga_key, ARMCPU, 2),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};

What's the rationale for migrating these "by hand" rather
than relying on the usual sysreg migration code ?

thanks
-- PMM
