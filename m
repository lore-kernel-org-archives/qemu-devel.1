Received: from eggs.gnu.org ([2001:4830:134:3::10]:43109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbZnq-00029q-MV
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:29:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbZnn-0006us-J2
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:29:26 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:32998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbZnn-0006uT-Ew
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:29:23 -0500
Received: by mail-qk0-x244.google.com with SMTP id 11so19716356qkl.0
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 13:29:21 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1486571580-16417-1-git-send-email-yongbok.kim@imgtec.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cac44178-6a4a-6d6a-c1d9-2081fe60688a@gmail.com>
Date: Wed, 8 Feb 2017 18:29:17 -0300
MIME-Version: 1.0
In-Reply-To: <1486571580-16417-1-git-send-email-yongbok.kim@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 4/8] target-mips: Provide function to
 test if a CPU supports an ISA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yongbok Kim <yongbok.kim@imgtec.com>, aurelien@aurel32.net, Paul Burton <paul.burton@imgtec.com>paul.burton@imgtec.com



On 02/08/2017 01:33 PM, Yongbok Kim wrote:
> From: Paul Burton <paul.burton@imgtec.com>
>
> Provide a new cpu_supports_isa function which allows callers to
> determine whether a CPU supports one of the ISA_ flags, by testing
> whether the associated struct mips_def_t sets the ISA flags in its
> insn_flags field.
>
> An example use of this is to allow boards which generate bootloader code
> to determine the properties of the CPU that will be used, for example
> whether the CPU is 64 bit or which architecture revision it implements.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Reviewed-by: Leon Alrae <leon.alrae@imgtec.com>
> Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
> ---
>  target/mips/cpu.h       |  1 +
>  target/mips/translate.c | 10 ++++++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index e1c78f5..4a4747a 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -815,6 +815,7 @@ int cpu_mips_signal_handler(int host_signum, void *pinfo, void *puc);
>
>  #define cpu_init(cpu_model) CPU(cpu_mips_init(cpu_model))
>  bool cpu_supports_cps_smp(const char *cpu_model);
> +bool cpu_supports_isa(const char *cpu_model, unsigned int isa);
>  void cpu_set_exception_base(int vp_index, target_ulong address);
>
>  /* TODO QOM'ify CPU reset and remove */
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 7f8ecf4..8b4a072 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -20233,6 +20233,16 @@ bool cpu_supports_cps_smp(const char *cpu_model)
>      return (def->CP0_Config3 & (1 << CP0C3_CMGCR)) != 0;
>  }
>
> +bool cpu_supports_isa(const char *cpu_model, unsigned int isa)
> +{
> +    const mips_def_t *def = cpu_mips_find_by_name(cpu_model);
> +    if (!def) {
> +        return false;
> +    }
> +
> +    return (def->insn_flags & isa) != 0;
> +}
> +
>  void cpu_set_exception_base(int vp_index, target_ulong address)
>  {
>      MIPSCPU *vp = MIPS_CPU(qemu_get_cpu(vp_index));
>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
