Received: from eggs.gnu.org ([209.51.188.92]:56579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glg6R-0003Vw-U3
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:23:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glg6Q-00029M-5A
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:23:27 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1glg6M-00026d-4P
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:23:22 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so12058419wmc.1
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 12:23:19 -0800 (PST)
References: <1548097698-28951-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1548097698-28951-5-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ec573511-8d0d-b2ed-1b50-ea3b0aad0d2c@redhat.com>
Date: Mon, 21 Jan 2019 21:23:16 +0100
MIME-Version: 1.0
In-Reply-To: <1548097698-28951-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/6] target/mips: Correct the second
 argument type of cpu_supports_isa()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: smarkovic@wavecomp.com, arikalo@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net

On 1/21/19 8:08 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> "insn_flags" bitfield was expanded from 32-bit to 64-bit at one moment.

"at one moment" -> "in f9c9cd63e3"

> However, this was not reflected at the second argument of the function
> cpu_supports_isa(). By chance, this did not create a wrong behavior,
> since the second argument was always with the left-most half zero, but
> it is still a bug waiting to happen. correct by changint the type of
> the second argument to be 64-bit always.

Oops.

> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/mips/cpu.h       | 2 +-
>  target/mips/translate.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 03c03fd..fd22bd5 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -1011,7 +1011,7 @@ int cpu_mips_signal_handler(int host_signum, void *pinfo, void *puc);
>  #define CPU_RESOLVING_TYPE TYPE_MIPS_CPU
>  
>  bool cpu_supports_cps_smp(const char *cpu_type);
> -bool cpu_supports_isa(const char *cpu_type, unsigned int isa);
> +bool cpu_supports_isa(const char *cpu_type, uint64_t isa);
>  void cpu_set_exception_base(int vp_index, target_ulong address);
>  
>  /* mips_int.c */
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index ceaa582..b660235 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -29803,7 +29803,7 @@ bool cpu_supports_cps_smp(const char *cpu_type)
>      return (mcc->cpu_def->CP0_Config3 & (1 << CP0C3_CMGCR)) != 0;
>  }
>  
> -bool cpu_supports_isa(const char *cpu_type, unsigned int isa)
> +bool cpu_supports_isa(const char *cpu_type, uint64_t isa)
>  {
>      const MIPSCPUClass *mcc = MIPS_CPU_CLASS(object_class_by_name(cpu_type));
>      return (mcc->cpu_def->insn_flags & isa) != 0;
> 
