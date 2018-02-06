Received: from eggs.gnu.org ([2001:4830:134:3::10]:58835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ej4m5-0006BH-Vi
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:03:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ej4m1-00031W-6h
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:03:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ej4m0-000312-V5
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:03:05 -0500
Date: Tue, 6 Feb 2018 16:03:00 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180206160300.17cab7fb@redhat.com>
In-Reply-To: <CAHNT7NsBQvruhfUpH2aP2BLfiASDU=b7Bsncqpih1ADohxo7cQ@mail.gmail.com>
References: <1517811767-75958-1-git-send-email-mjc@sifive.com>
	<1517811767-75958-3-git-send-email-mjc@sifive.com>
	<20180205160418.34544e1f@redhat.com>
	<CAHNT7NsBQvruhfUpH2aP2BLfiASDU=b7Bsncqpih1ADohxo7cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 03/22] RISC-V CPU Core Definition
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

On Tue, 6 Feb 2018 11:09:56 +1300
Michael Clark <mjc@sifive.com> wrote:

> On Tue, Feb 6, 2018 at 4:04 AM, Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Mon,  5 Feb 2018 19:22:28 +1300
> > Michael Clark <mjc@sifive.com> wrote:
> >  
> > > Add CPU state header, CPU definitions and initialization routines
> > >
> > > Signed-off-by: Michael Clark <mjc@sifive.com>
> > > ---
> > >  target/riscv/cpu.c      | 385 ++++++++++++++++++++++++++++++  
> > ++++++++++++++  
> > >  target/riscv/cpu.h      | 256 +++++++++++++++++++++++++++++
> > >  target/riscv/cpu_bits.h | 417 ++++++++++++++++++++++++++++++  
> > ++++++++++++++++++  
> > >  3 files changed, 1058 insertions(+)
> > >  create mode 100644 target/riscv/cpu.c
> > >  create mode 100644 target/riscv/cpu.h
> > >  create mode 100644 target/riscv/cpu_bits.h
> > >
> > > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > > new file mode 100644
> > > index 0000000..684b78b
> > > --- /dev/null
> > > +++ b/target/riscv/cpu.c  
> > [...]  
> > > +
> > > +static const RISCVCPUInfo riscv_cpus[] = {
> > > +#ifdef CONFIG_USER_ONLY
> > > +    { TYPE_RISCV_CPU_ANY,                riscv_any_cpu_init },
> > > +#else
> > > +    { TYPE_RISCV_CPU_IMAFDCSU_PRIV_1_09, riscv_imafdcsu_priv1_9_cpu_init  
> > },  
> > > +    { TYPE_RISCV_CPU_IMAFDCSU_PRIV_1_10, riscv_imafdcsu_priv1_10_cpu_init  
> > },  
> > > +    { TYPE_RISCV_CPU_IMACU_PRIV_1_10,    riscv_imacu_priv1_10_cpu_init  
> > },  
> > > +    { TYPE_RISCV_CPU_IMAC_PRIV_1_10,     riscv_imac_priv1_10_cpu_init },
> > > +#endif
> > > +    { NULL, NULL }
> > > +};
> > > +  
> > [...]  
> > > +static void cpu_register(const RISCVCPUInfo *info)
> > > +{
> > > +    TypeInfo type_info = {
> > > +        .name = info->name,
> > > +        .parent = TYPE_RISCV_CPU,
> > > +        .instance_size = sizeof(RISCVCPU),
> > > +        .instance_init = info->initfn,
> > > +    };
> > > +
> > > +    type_register(&type_info);
> > > +}
> > > +
> > > +static const TypeInfo riscv_cpu_type_info = {
> > > +    .name = TYPE_RISCV_CPU,
> > > +    .parent = TYPE_CPU,
> > > +    .instance_size = sizeof(RISCVCPU),
> > > +    .instance_init = riscv_cpu_init,
> > > +    .abstract = false,
> > > +    .class_size = sizeof(RISCVCPUClass),
> > > +    .class_init = riscv_cpu_class_init,
> > > +};  
> > [...]
> >  
> > > +static void riscv_cpu_register_types(void)
> > > +{
> > > +    const RISCVCPUInfo *info = riscv_cpus;
> > > +
> > > +    type_register_static(&riscv_cpu_type_info);
> > > +
> > > +    while (info->name) {
> > > +        cpu_register(info);
> > > +        info++;
> > > +    }
> > > +}
> > > +
> > > +type_init(riscv_cpu_register_types)  
> > For simplistic type definitions like that,
> > above parts should use DEFINE_TYPES(), see c6678108 for reference.
> >
> >  
> > > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > > new file mode 100644
> > > index 0000000..8b816ae
> > > --- /dev/null
> > > +++ b/target/riscv/cpu.h  
> > [...]  
> > > +#define TYPE_RISCV_CPU                    "riscv"
> > > +#define TYPE_RISCV_CPU_ANY                "riscv-any"
> > > +#define TYPE_RISCV_CPU_IMAFDCSU_PRIV_1_09 "riscv-imafdcsu-priv1.9"
> > > +#define TYPE_RISCV_CPU_IMAFDCSU_PRIV_1_10 "riscv-imafdcsu-priv1.10"
> > > +#define TYPE_RISCV_CPU_IMACU_PRIV_1_10    "riscv-imacu-priv1.10"
> > > +#define TYPE_RISCV_CPU_IMAC_PRIV_1_10     "riscv-imac-priv1.10"
> > > +
> > > +#define RISCV_CPU_TYPE_PREFIX TYPE_RISCV_CPU "-"
> > > +#define RISCV_CPU_TYPE_NAME(name) (RISCV_CPU_TYPE_PREFIX name)  
> > it still uses prefix notation versus commonly used suffix in form of
> >  "targetFOO-cpu"
> > this prefix approach would get in the way if we try to generalize
> > naming <-> type conversion later[*].
> > So it would better to be consistent with approach qemu uses for cpu types
> > (I believe power had prefix based pnv types but it has been fixed
> > to common suffix based pattern later).
> >
> > * discussion on thread "[PATCH v5 0/6]  Add a valid_cpu_types property"
> >  
> 
> I can reverse them if needed, just it seems a little odd to have riscv on
> the right-hand side of the extensions. I can do this in the v5 spin...
pls, do so + -cpu suffix.

> It may make more sense once we have actual CPU models. Currently, we have
> sets of extensions and privilege ISA versions. I guess these will become
> implicit properties of a specific CPU model and the extensions will be
> visible in the initialization function.
That's what we have in x86 land, code names + _suffix corresponding to
real cpus (mostly) with implicit feature set per each.
Features could be properties so user would be able to enumerate/query/set them.
