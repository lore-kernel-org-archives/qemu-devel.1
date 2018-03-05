Received: from eggs.gnu.org ([2001:4830:134:3::10]:36267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1esyWb-0005J8-BK
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 17:24:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1esyWZ-0006Tn-RX
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 17:24:05 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:35305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1esyWZ-0006Tc-Jj
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 17:24:03 -0500
Received: by mail-oi0-x243.google.com with SMTP id x10so13346972oig.2
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 14:24:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180305104447.41953c9e@redhat.com>
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
	<1519998711-73430-4-git-send-email-mjc@sifive.com>
	<20180305104447.41953c9e@redhat.com>
From: Michael Clark <mjc@sifive.com>
Date: Tue, 6 Mar 2018 11:24:02 +1300
Message-ID: <CAHNT7NtLiVnRrm35o=-47hBr6CMTOatPEfpJ5jFx5HLTPBY2NA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 03/23] RISC-V CPU Core Definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Mon, Mar 5, 2018 at 10:44 PM, Igor Mammedov <imammedo@redhat.com> wrote:

> On Sat,  3 Mar 2018 02:51:31 +1300
> Michael Clark <mjc@sifive.com> wrote:
>
> > Add CPU state header, CPU definitions and initialization routines
> >
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Sagar Karandikar <sagark@eecs.berkeley.edu>
> > Signed-off-by: Michael Clark <mjc@sifive.com>
> > ---
> >  target/riscv/cpu.c      | 432 ++++++++++++++++++++++++++++++
> ++++++++++++++++++
> >  target/riscv/cpu.h      | 296 +++++++++++++++++++++++++++++++++
> >  target/riscv/cpu_bits.h | 411 ++++++++++++++++++++++++++++++
> +++++++++++++++
> >  3 files changed, 1139 insertions(+)
> >  create mode 100644 target/riscv/cpu.c
> >  create mode 100644 target/riscv/cpu.h
> >  create mode 100644 target/riscv/cpu_bits.h
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > new file mode 100644
> > index 0000000..4851890
> > --- /dev/null
> > +++ b/target/riscv/cpu.c
> [...]
>
> > +
> > +typedef struct RISCVCPUInfo {
> > +    const int bit_widths;
> > +    const char *name;
> > +    void (*initfn)(Object *obj);
> > +} RISCVCPUInfo;
> > +
> [...]
>
> > +static const RISCVCPUInfo riscv_cpus[] = {
> > +    { 96, TYPE_RISCV_CPU_ANY,              riscv_any_cpu_init },
> > +    { 32, TYPE_RISCV_CPU_RV32GCSU_V1_09_1,
> rv32gcsu_priv1_09_1_cpu_init },
> > +    { 32, TYPE_RISCV_CPU_RV32GCSU_V1_10_0,
> rv32gcsu_priv1_10_0_cpu_init },
> > +    { 32, TYPE_RISCV_CPU_RV32IMACU_NOMMU,  rv32imacu_nommu_cpu_init },
> > +    { 32, TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_init },
> > +    { 32, TYPE_RISCV_CPU_SIFIVE_U34,       rv32gcsu_priv1_10_0_cpu_init
> },
> > +    { 64, TYPE_RISCV_CPU_RV64GCSU_V1_09_1,
> rv64gcsu_priv1_09_1_cpu_init },
> > +    { 64, TYPE_RISCV_CPU_RV64GCSU_V1_10_0,
> rv64gcsu_priv1_10_0_cpu_init },
> > +    { 64, TYPE_RISCV_CPU_RV64IMACU_NOMMU,  rv64imacu_nommu_cpu_init },
> > +    { 64, TYPE_RISCV_CPU_SIFIVE_E51,       rv64imacu_nommu_cpu_init },
> > +    { 64, TYPE_RISCV_CPU_SIFIVE_U54,       rv64gcsu_priv1_10_0_cpu_init
> },
> > +    { 0, NULL, NULL }
> > +};
> > +
> [...]
>
> > +static void cpu_register(const RISCVCPUInfo *info)
> > +{
> > +    TypeInfo type_info = {
> > +        .name = info->name,
> > +        .parent = TYPE_RISCV_CPU,
> > +        .instance_size = sizeof(RISCVCPU),
> > +        .instance_init = info->initfn,
> > +    };
> > +
> > +    type_register(&type_info);
> > +}
> [...]
>
> > +void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf)
> > +{
> > +    const RISCVCPUInfo *info = riscv_cpus;
> > +
> > +    while (info->name) {
> > +        if (info->bit_widths & TARGET_LONG_BITS) {
> > +            (*cpu_fprintf)(f, "%s\n", info->name);
> > +        }
> > +        info++;
> > +    }
> > +}
> > +
> > +static void riscv_cpu_register_types(void)
> > +{
> > +    const RISCVCPUInfo *info = riscv_cpus;
> > +
> > +    type_register_static(&riscv_cpu_type_info);
> > +
> > +    while (info->name) {
> > +        if (info->bit_widths & TARGET_LONG_BITS) {
> > +            cpu_register(info);
> > +        }
> > +        info++;
> > +    }
> > +}
> > +
> > +type_init(riscv_cpu_register_types)
> This still isn't fixed as requested
>  http://lists.gnu.org/archive/html/qemu-devel/2018-02/msg06412.html


It's possibly because I explicitly requested a clarification. Pointing at a
commit and being asked to infer what the desired change is, is not what I
would call reasonable feedback. The code has already been reviewed. We have
just expanded on it in a manner consistent with how the ARM port handled
cpu initialization.

I'm happy to comply if you give me detailed instructions on what is wrong,
why, and how to fix it versus infer your problem from this commit to
another architecture.

Apologies if i'm a bit slow, but I really don't understand the change you
intend us to make.
