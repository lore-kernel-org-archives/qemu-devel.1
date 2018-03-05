Received: from eggs.gnu.org ([2001:4830:134:3::10]:50203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1esmft-0001Kr-0w
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 04:44:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1esmfr-0007fJ-Tn
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 04:44:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40388 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1esmfr-0007et-Ll
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 04:44:51 -0500
Date: Mon, 5 Mar 2018 10:44:47 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180305104447.41953c9e@redhat.com>
In-Reply-To: <1519998711-73430-4-git-send-email-mjc@sifive.com>
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
	<1519998711-73430-4-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 03/23] RISC-V CPU Core Definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Sat,  3 Mar 2018 02:51:31 +1300
Michael Clark <mjc@sifive.com> wrote:

> Add CPU state header, CPU definitions and initialization routines
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  target/riscv/cpu.c      | 432 ++++++++++++++++++++++++++++++++++++++++++++++++
>  target/riscv/cpu.h      | 296 +++++++++++++++++++++++++++++++++
>  target/riscv/cpu_bits.h | 411 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1139 insertions(+)
>  create mode 100644 target/riscv/cpu.c
>  create mode 100644 target/riscv/cpu.h
>  create mode 100644 target/riscv/cpu_bits.h
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> new file mode 100644
> index 0000000..4851890
> --- /dev/null
> +++ b/target/riscv/cpu.c
[...]

> +
> +typedef struct RISCVCPUInfo {
> +    const int bit_widths;
> +    const char *name;
> +    void (*initfn)(Object *obj);
> +} RISCVCPUInfo;
> +
[...]

> +static const RISCVCPUInfo riscv_cpus[] = {
> +    { 96, TYPE_RISCV_CPU_ANY,              riscv_any_cpu_init },
> +    { 32, TYPE_RISCV_CPU_RV32GCSU_V1_09_1, rv32gcsu_priv1_09_1_cpu_init },
> +    { 32, TYPE_RISCV_CPU_RV32GCSU_V1_10_0, rv32gcsu_priv1_10_0_cpu_init },
> +    { 32, TYPE_RISCV_CPU_RV32IMACU_NOMMU,  rv32imacu_nommu_cpu_init },
> +    { 32, TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_init },
> +    { 32, TYPE_RISCV_CPU_SIFIVE_U34,       rv32gcsu_priv1_10_0_cpu_init },
> +    { 64, TYPE_RISCV_CPU_RV64GCSU_V1_09_1, rv64gcsu_priv1_09_1_cpu_init },
> +    { 64, TYPE_RISCV_CPU_RV64GCSU_V1_10_0, rv64gcsu_priv1_10_0_cpu_init },
> +    { 64, TYPE_RISCV_CPU_RV64IMACU_NOMMU,  rv64imacu_nommu_cpu_init },
> +    { 64, TYPE_RISCV_CPU_SIFIVE_E51,       rv64imacu_nommu_cpu_init },
> +    { 64, TYPE_RISCV_CPU_SIFIVE_U54,       rv64gcsu_priv1_10_0_cpu_init },
> +    { 0, NULL, NULL }
> +};
> +
[...]

> +static void cpu_register(const RISCVCPUInfo *info)
> +{
> +    TypeInfo type_info = {
> +        .name = info->name,
> +        .parent = TYPE_RISCV_CPU,
> +        .instance_size = sizeof(RISCVCPU),
> +        .instance_init = info->initfn,
> +    };
> +
> +    type_register(&type_info);
> +}
[...]

> +void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf)
> +{
> +    const RISCVCPUInfo *info = riscv_cpus;
> +
> +    while (info->name) {
> +        if (info->bit_widths & TARGET_LONG_BITS) {
> +            (*cpu_fprintf)(f, "%s\n", info->name);
> +        }
> +        info++;
> +    }
> +}
> +
> +static void riscv_cpu_register_types(void)
> +{
> +    const RISCVCPUInfo *info = riscv_cpus;
> +
> +    type_register_static(&riscv_cpu_type_info);
> +
> +    while (info->name) {
> +        if (info->bit_widths & TARGET_LONG_BITS) {
> +            cpu_register(info);
> +        }
> +        info++;
> +    }
> +}
> +
> +type_init(riscv_cpu_register_types)
This still isn't fixed as requested
 http://lists.gnu.org/archive/html/qemu-devel/2018-02/msg06412.html

[...]
