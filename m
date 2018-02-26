Received: from eggs.gnu.org ([2001:4830:134:3::10]:48149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eqL5G-0006Jr-6p
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 10:53:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eqL5D-0001fk-1g
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 10:52:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35616 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eqL5C-0001fF-Ld
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 10:52:54 -0500
Date: Mon, 26 Feb 2018 16:52:37 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180226165237.79b6a03d@redhat.com>
In-Reply-To: <1519344729-73482-4-git-send-email-mjc@sifive.com>
References: <1519344729-73482-1-git-send-email-mjc@sifive.com>
	<1519344729-73482-4-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 03/23] RISC-V CPU Core Definition
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

On Fri, 23 Feb 2018 13:11:49 +1300
Michael Clark <mjc@sifive.com> wrote:

> Add CPU state header, CPU definitions and initialization routines
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  target/riscv/cpu.c      | 391 +++++++++++++++++++++++++++++++++++++++++++++
>  target/riscv/cpu.h      | 256 +++++++++++++++++++++++++++++
>  target/riscv/cpu_bits.h | 416 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1063 insertions(+)
>  create mode 100644 target/riscv/cpu.c
>  create mode 100644 target/riscv/cpu.h
>  create mode 100644 target/riscv/cpu_bits.h
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
[...]

> +
> +static const RISCVCPUInfo riscv_cpus[] = {
> +    { TYPE_RISCV_CPU_ANY,                riscv_any_cpu_init },
> +    { TYPE_RISCV_CPU_IMAFDCSU_PRIV_1_09, riscv_imafdcsu_priv1_9_cpu_init },
> +    { TYPE_RISCV_CPU_IMAFDCSU_PRIV_1_10, riscv_imafdcsu_priv1_10_cpu_init },
> +    { TYPE_RISCV_CPU_IMACU_PRIV_1_10,    riscv_imacu_priv1_10_cpu_init },
> +    { TYPE_RISCV_CPU_IMAC_PRIV_1_10,     riscv_imac_priv1_10_cpu_init },
> +    { NULL, NULL }
> +};
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

> +
> +void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf)
> +{
> +    const RISCVCPUInfo *info = riscv_cpus;
> +
> +    while (info->name) {
> +        (*cpu_fprintf)(f, "%s\n", info->name);
> +        info++;
> +    }
> +}
majority targets use object_class_get_list() to get
the list of CPU types, you can use cris_cpu_list() as example.


> +static void riscv_cpu_register_types(void)
> +{
> +    const RISCVCPUInfo *info = riscv_cpus;
> +
> +    type_register_static(&riscv_cpu_type_info);
> +
> +    while (info->name) {
> +        cpu_register(info);
> +        info++;
> +    }
> +}
> +
> +type_init(riscv_cpu_register_types)
[...]

This still hasn't addressed a comment from
 "[PATCH v4 03/22] RISC-V CPU Core Definition"
and uses old approach with RISCVCPUInfo helper structure.

Please, use commit 974e58d2 to model after.
