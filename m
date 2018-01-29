Received: from eggs.gnu.org ([2001:4830:134:3::10]:34375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1egBVV-0001kk-Gt
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:38:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1egBVP-0001lx-B2
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:38:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1egBVP-0001lW-2h
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:37:59 -0500
Date: Mon, 29 Jan 2018 16:37:54 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180129163754.6ac70282@redhat.com>
In-Reply-To: <CAHNT7Nt2K=c2PhE24EUQRSB1wwdQHY-x=PkfYD-kh+RyN+NiwA@mail.gmail.com>
References: <1515628000-93285-1-git-send-email-mjc@sifive.com>
	<1515628000-93285-4-git-send-email-mjc@sifive.com>
	<20180115144435.1577c4f1@redhat.com>
	<CAHNT7Nt2K=c2PhE24EUQRSB1wwdQHY-x=PkfYD-kh+RyN+NiwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 03/21] RISC-V CPU Core Definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches+subscribe@groups.riscv.org>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Wed, 24 Jan 2018 10:21:01 -0800
Michael Clark <mjc@sifive.com> wrote:

> On Mon, Jan 15, 2018 at 5:44 AM, Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Wed, 10 Jan 2018 15:46:22 -0800
> > Michael Clark <mjc@sifive.com> wrote:
> >  
> > > Add CPU state header, CPU definitions and initialization routines
> > >
> > > Signed-off-by: Michael Clark <mjc@sifive.com>
> > > ---
> > >  target/riscv/cpu.c      | 391 ++++++++++++++++++++++++++++++  
> > +++++++++++++++  
> > >  target/riscv/cpu.h      | 271 +++++++++++++++++++++++++++++++
> > >  target/riscv/cpu_bits.h | 417 ++++++++++++++++++++++++++++++  
> > ++++++++++++++++++  
> > >  3 files changed, 1079 insertions(+)
> > >  create mode 100644 target/riscv/cpu.c
> > >  create mode 100644 target/riscv/cpu.h
> > >  create mode 100644 target/riscv/cpu_bits.h
> > >
[...]

> > > +
> > > +void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf)
> > > +{
> > > +    const RISCVCPUInfo *info = riscv_cpus;
> > > +
> > > +    while (info->name) {
> > > +        (*cpu_fprintf)(f, "%s\n", info->name);
> > > +        info++;
> > > +    }
> > > +}
> > > +
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
> > > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > > new file mode 100644
> > > index 0000000..9dd131b
> > > --- /dev/null
> > > +++ b/target/riscv/cpu.h
> > > @@ -0,0 +1,271 @@
> > > +#ifndef RISCV_CPU_H
> > > +#define RISCV_CPU_H
> > > +
> > > +/* QEMU addressing/paging config */
> > > +#define TARGET_PAGE_BITS 12 /* 4 KiB Pages */
> > > +#if defined(TARGET_RISCV64)
> > > +#define TARGET_LONG_BITS 64
> > > +#define TARGET_PHYS_ADDR_SPACE_BITS 50
> > > +#define TARGET_VIRT_ADDR_SPACE_BITS 39
> > > +#elif defined(TARGET_RISCV32)
> > > +#define TARGET_LONG_BITS 32
> > > +#define TARGET_PHYS_ADDR_SPACE_BITS 34
> > > +#define TARGET_VIRT_ADDR_SPACE_BITS 32
> > > +#endif
> > > +
> > > +#define ELF_MACHINE EM_RISCV
> > > +#define CPUArchState struct CPURISCVState
> > > +
> > > +#include "qemu-common.h"
> > > +#include "qom/cpu.h"
> > > +#include "exec/cpu-defs.h"
> > > +#include "fpu/softfloat.h"
> > > +
> > > +/* #define DEBUG_OP */
> > > +/* #define RISCV_DEBUG_PRINT */
> > > +
> > > +#define TYPE_RISCV_CPU                    "riscv"
> > > +#define TYPE_RISCV_CPU_ANY                "riscv-any"
> > > +#define TYPE_RISCV_CPU_IMAFDCSU_PRIV_1_09 "riscv-imafdcsu-priv1.9"
> > > +#define TYPE_RISCV_CPU_IMAFDCSU_PRIV_1_10 "riscv-imafdcsu-priv1.10"
> > > +#define TYPE_RISCV_CPU_IMACU_PRIV_1_10    "riscv-imacu-priv1.10"
> > > +#define TYPE_RISCV_CPU_IMAC_PRIV_1_10     "riscv-imac-priv1.10"
> > > +
> > > +#define RISCV_CPU_TYPE_PREFIX TYPE_RISCV_CPU "-"
> > > +#define RISCV_CPU_TYPE_NAME(name) (RISCV_CPU_TYPE_PREFIX name)  
> > typically we use suffix convention here, for base type it would be
> >
> >  #define TYPE_RISCV_CPU "riscv-cpu"
> >
> > then for leaf types it would be
> >
> > #define RISCV_CPU_TYPE_SUFFIX "-" TYPE_RISCV_CPU
> > #define RISCV_CPU_TYPE_NAME(name) (name RISCV_CPU_TYPE_SUFFIX)  
> 
> 
> The choice to invert it for RISC-V was somewhat deliberate.
> 
> In RISC-V land we usually use rv, riscv and the xlen as a prefix to the ISA
> extensions, and spec version, so it made more sense to have riscv on the
> left.
> 
> e.g. rv64imafdc
> 
> At the moment we only have generic CPUs formed using the ISA extensions.
> 
> "imac-priv1.10-riscv-cpu" makes much less sense than "riscv-imac-priv1.10"
> 
> It may make more sense when we have vendor CPU models and their properties
> e.g. extensions and spec versions become intrinsic to the specific CPU
> model.
> 
> I can backwardize it, but the naming in a cpu list will make a little less
> sense.
I don't insist on it but being consistent with how all
other targets name their cpu types has its own benefits,
for example known grep-able suffixes and potential to unify
FOO_cpu_list() handling which currently is a mess.
So if name is not dictated by spec I'd use QEMU's naming convention.

[...]
