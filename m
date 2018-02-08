Received: from eggs.gnu.org ([2001:4830:134:3::10]:36329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ejjRl-0004bX-No
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:28:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ejjRi-0004Ex-HK
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:28:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37252 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ejjRi-0004EJ-BU
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:28:50 -0500
Date: Thu, 8 Feb 2018 11:28:33 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180208112833.34ad3b3d@redhat.com>
In-Reply-To: <CAHNT7NuH1NYdKKau1GgADUGPq29TDxczJPh0GgQ+su5rxo5Lhg@mail.gmail.com>
References: <1517811767-75958-1-git-send-email-mjc@sifive.com>
	<1517811767-75958-3-git-send-email-mjc@sifive.com>
	<20180205160418.34544e1f@redhat.com>
	<CAHNT7NsBQvruhfUpH2aP2BLfiASDU=b7Bsncqpih1ADohxo7cQ@mail.gmail.com>
	<20180206160300.17cab7fb@redhat.com>
	<CAHNT7NuH1NYdKKau1GgADUGPq29TDxczJPh0GgQ+su5rxo5Lhg@mail.gmail.com>
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

On Thu, 8 Feb 2018 15:19:13 +1300
Michael Clark <mjc@sifive.com> wrote:

> On Wed, Feb 7, 2018 at 4:03 AM, Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Tue, 6 Feb 2018 11:09:56 +1300
> > Michael Clark <mjc@sifive.com> wrote:
> >  
> > > On Tue, Feb 6, 2018 at 4:04 AM, Igor Mammedov <imammedo@redhat.com>  
> > wrote:  
> > >  
> > > > On Mon,  5 Feb 2018 19:22:28 +1300
> > > > Michael Clark <mjc@sifive.com> wrote:
> > > >  
> > > > > Add CPU state header, CPU definitions and initialization routines
> > > > >
> > > > > Signed-off-by: Michael Clark <mjc@sifive.com>
> > > > > ---
> > > > >  target/riscv/cpu.c      | 385 ++++++++++++++++++++++++++++++  
> > > > ++++++++++++++  
> > > > >  target/riscv/cpu.h      | 256 +++++++++++++++++++++++++++++
> > > > >  target/riscv/cpu_bits.h | 417 ++++++++++++++++++++++++++++++  
> > > > ++++++++++++++++++  
> > > > >  3 files changed, 1058 insertions(+)
> > > > >  create mode 100644 target/riscv/cpu.c
> > > > >  create mode 100644 target/riscv/cpu.h
> > > > >  create mode 100644 target/riscv/cpu_bits.h
> > > > >
> > > > > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > > > > new file mode 100644
> > > > > index 0000000..684b78b
> > > > > --- /dev/null
> > > > > +++ b/target/riscv/cpu.c  
> > > > [...]  
> > > > > +
> > > > > +static const RISCVCPUInfo riscv_cpus[] = {
> > > > > +#ifdef CONFIG_USER_ONLY
> > > > > +    { TYPE_RISCV_CPU_ANY,                riscv_any_cpu_init },
> > > > > +#else
> > > > > +    { TYPE_RISCV_CPU_IMAFDCSU_PRIV_1_09,  
> > riscv_imafdcsu_priv1_9_cpu_init  
> > > > },  
> > > > > +    { TYPE_RISCV_CPU_IMAFDCSU_PRIV_1_10,  
> > riscv_imafdcsu_priv1_10_cpu_init  
> > > > },  
> > > > > +    { TYPE_RISCV_CPU_IMACU_PRIV_1_10,  
> > riscv_imacu_priv1_10_cpu_init  
> > > > },  
> > > > > +    { TYPE_RISCV_CPU_IMAC_PRIV_1_10,  
> >  riscv_imac_priv1_10_cpu_init },  
> > > > > +#endif
> > > > > +    { NULL, NULL }
> > > > > +};
> > > > > +  
> > > > [...]  
> > > > > +static void cpu_register(const RISCVCPUInfo *info)
> > > > > +{
> > > > > +    TypeInfo type_info = {
> > > > > +        .name = info->name,
> > > > > +        .parent = TYPE_RISCV_CPU,
> > > > > +        .instance_size = sizeof(RISCVCPU),
> > > > > +        .instance_init = info->initfn,
> > > > > +    };
> > > > > +
> > > > > +    type_register(&type_info);
> > > > > +}
> > > > > +
> > > > > +static const TypeInfo riscv_cpu_type_info = {
> > > > > +    .name = TYPE_RISCV_CPU,
> > > > > +    .parent = TYPE_CPU,
> > > > > +    .instance_size = sizeof(RISCVCPU),
> > > > > +    .instance_init = riscv_cpu_init,
> > > > > +    .abstract = false,
> > > > > +    .class_size = sizeof(RISCVCPUClass),
> > > > > +    .class_init = riscv_cpu_class_init,
> > > > > +};  
> > > > [...]
> > > >  
> > > > > +static void riscv_cpu_register_types(void)
> > > > > +{
> > > > > +    const RISCVCPUInfo *info = riscv_cpus;
> > > > > +
> > > > > +    type_register_static(&riscv_cpu_type_info);
> > > > > +
> > > > > +    while (info->name) {
> > > > > +        cpu_register(info);
> > > > > +        info++;
> > > > > +    }
> > > > > +}
> > > > > +
> > > > > +type_init(riscv_cpu_register_types)  
> > > > For simplistic type definitions like that,
> > > > above parts should use DEFINE_TYPES(), see c6678108 for reference.
> > > >
> > > >  
> > > > > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > > > > new file mode 100644
> > > > > index 0000000..8b816ae
> > > > > --- /dev/null
> > > > > +++ b/target/riscv/cpu.h  
> > > > [...]  
> > > > > +#define TYPE_RISCV_CPU                    "riscv"
> > > > > +#define TYPE_RISCV_CPU_ANY                "riscv-any"
> > > > > +#define TYPE_RISCV_CPU_IMAFDCSU_PRIV_1_09 "riscv-imafdcsu-priv1.9"
> > > > > +#define TYPE_RISCV_CPU_IMAFDCSU_PRIV_1_10 "riscv-imafdcsu-priv1.10"
> > > > > +#define TYPE_RISCV_CPU_IMACU_PRIV_1_10    "riscv-imacu-priv1.10"
> > > > > +#define TYPE_RISCV_CPU_IMAC_PRIV_1_10     "riscv-imac-priv1.10"
Also you can use RISCV_CPU_TYPE_NAME() from blow to form above names,
like:

#define TYPE_RISCV_CPU                    "riscv-cpu"
#define TYPE_RISCV_CPU_ANY                RISCV_CPU_TYPE_NAME("any")
...

then whatever naming format is required, you'd be able to
change it just in RISCV_CPU_TYPE_NAME() without touching
the rest.

> > > > > +
> > > > > +#define RISCV_CPU_TYPE_PREFIX TYPE_RISCV_CPU "-"
> > > > > +#define RISCV_CPU_TYPE_NAME(name) (RISCV_CPU_TYPE_PREFIX name)  
> > > > it still uses prefix notation versus commonly used suffix in form of
> > > >  "targetFOO-cpu"
> > > > this prefix approach would get in the way if we try to generalize
> > > > naming <-> type conversion later[*].
> > > > So it would better to be consistent with approach qemu uses for cpu  
> > types  
> > > > (I believe power had prefix based pnv types but it has been fixed
> > > > to common suffix based pattern later).
> > > >
> > > > * discussion on thread "[PATCH v5 0/6]  Add a valid_cpu_types property"
> > > >  
> > >
> > > I can reverse them if needed, just it seems a little odd to have riscv on
> > > the right-hand side of the extensions. I can do this in the v5 spin...  
> > pls, do so + -cpu suffix.
> >  
> > > It may make more sense once we have actual CPU models. Currently, we have
> > > sets of extensions and privilege ISA versions. I guess these will become
> > > implicit properties of a specific CPU model and the extensions will be
> > > visible in the initialization function.  
> > That's what we have in x86 land, code names + _suffix corresponding to
> > real cpus (mostly) with implicit feature set per each.
> > Features could be properties so user would be able to enumerate/query/set
> > them.
> >  
> 
> I just realized I neglected the change in the current patch-set to use the
> suffix scheme i.e. "<extension>-<version>-riscv-cpu" versus the
> "riscv-<extension>-<version>" scheme that we have presently.
Yep, just saw v5 still has old variant,
You also forgot about comment:
"
> +type_init(riscv_cpu_register_types)  
For simplistic type definitions like that,
above parts should use DEFINE_TYPES(), see c6678108 for reference.
"
 
> I would like to discuss with RISC-V folk as how we should name these
> "generic" CPUs and how we should handle extensions and versioning. This is
> certainly going to be an area that is going to be worked on in the future
> so whether we evolve this in-tree or out-of-tree is up for discussion. We
> also have to decide whether we will add CPU models for all typical
> combinations of extensions or if this is handled some other way. There will
> also be actual CPU modules now silicon is becoming more widely available.
> The version number we have currently is essentially the supervisor
> specification version. That won't be necessary once we have real cpu models.
> 
> There is also a future patch that will allow 'misa' extensions to be
> changed on the fly, which will require the extensions to be exposed in
> cpu_get_tb_cpu_state flags.
> 
> One thing is for certain, is that there is no direct comparison to x86 land
> as the RISC-V extension scheme is presently quite different.
See, following thread which might be of interest to you:
  "how to handle QOM 'container' objects whose contents depend on QOM properties?"
