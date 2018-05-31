Received: from eggs.gnu.org ([2001:4830:134:3::10]:35342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fOMDy-0002X6-44
	for qemu-devel@nongnu.org; Thu, 31 May 2018 07:58:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fOMDw-0003ep-UM
	for qemu-devel@nongnu.org; Thu, 31 May 2018 07:58:34 -0400
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20180531132733.5e3eca33@bahia.lan>
References: <20180530144217.8959-1-joel@jms.id.au>
	<1a47f19a-1791-da8a-d9ad-abe4c1e8e1ce@kaod.org>
	<20180531132733.5e3eca33@bahia.lan>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 31 May 2018 21:28:08 +0930
Message-ID: <CACPK8XfpZZ0+bZg0Udt30FLHECS7k+QkjVp3E+duSJ_TGxWqTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc: Allow privileged
 access to SPR_PCR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>, Michael Neuling <mikey@neuling.org>, Michael Ellerman <mpe@ellerman.id.au>

On 31 May 2018 at 20:57, Greg Kurz <groug@kaod.org> wrote:
> On Thu, 31 May 2018 09:38:10 +0200
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
>> On 05/30/2018 04:42 PM, Joel Stanley wrote:
>> > The powerpc Linux kernel[1] and skiboot firmware[2] recently gained ch=
anges
>> > that cause the Processor Compatibility Register (PCR) SPR to be cleare=
d.
>> >
>> > These changes cause Linux to fail to boot on the Qemu powernv machine
>> > with an error:
>> >
>> >  Trying to write privileged spr 338 (0x152) at 0000000030017f0c
>> >
>> > With this patch Qemu makes this register available as a hypervisor
>> > privileged register.
>> >
>> > Note that bits set in this register disable features of the processor.
>> > Currently the only register state that is supported is when the regist=
er
>> > is zeroed (enable all features). This is sufficient for guests to
>> > once again boot.
>> >
>> > [1] https://lkml.kernel.org/r/20180518013742.24095-1-mikey@neuling.org
>> > [2] https://patchwork.ozlabs.org/patch/915932/
>> >
>> > Signed-off-by: Joel Stanley <joel@jms.id.au>
>> > ---
>> >  target/ppc/helper.h             |  1 +
>> >  target/ppc/misc_helper.c        | 10 ++++++++++
>> >  target/ppc/translate_init.inc.c |  9 +++++++--
>> >  3 files changed, 18 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/target/ppc/helper.h b/target/ppc/helper.h
>> > index 19453c68138a..d751f0e21909 100644
>> > --- a/target/ppc/helper.h
>> > +++ b/target/ppc/helper.h
>> > @@ -17,6 +17,7 @@ DEF_HELPER_2(pminsn, void, env, i32)
>> >  DEF_HELPER_1(rfid, void, env)
>> >  DEF_HELPER_1(hrfid, void, env)
>> >  DEF_HELPER_2(store_lpcr, void, env, tl)
>> > +DEF_HELPER_2(store_pcr, void, env, tl)
>> >  #endif
>> >  DEF_HELPER_1(check_tlb_flush_local, void, env)
>> >  DEF_HELPER_1(check_tlb_flush_global, void, env)
>> > diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
>> > index 8c8cba5cc6f1..40c39d08ad14 100644
>> > --- a/target/ppc/misc_helper.c
>> > +++ b/target/ppc/misc_helper.c
>> > @@ -20,6 +20,7 @@
>> >  #include "cpu.h"
>> >  #include "exec/exec-all.h"
>> >  #include "exec/helper-proto.h"
>> > +#include "qemu/error-report.h"
>> >
>> >  #include "helper_regs.h"
>> >
>> > @@ -186,6 +187,15 @@ void ppc_store_msr(CPUPPCState *env, target_ulong=
 value)
>> >      hreg_store_msr(env, value, 0);
>> >  }
>> >
>> > +void helper_store_pcr(CPUPPCState *env, target_ulong value)
>> > +{
>> > +    if (value !=3D 0) {
>> > +        error_report("Unimplemented PCR value 0x"TARGET_FMT_lx, value=
);
>> > +        return;
>> > +    }
>> > +    env->spr[SPR_PCR] =3D value;
>>
>> shouldn't we use pcc->pcr_mask ? and check pcc->pcr_supported also ?
>>
>
> pcc->pcr_mask and ppc->pcr_supported only make sense for pseries machine
> types (ie, when the spapr machine code call ppc_*_compat() functions).
>
> The case here is different: we're running a fully emulated pnv machine,
> ie, PCR can only be set by mtspr() called within the pnv guest. But TCG
> doesn't implement the compatibility mode logic, ie, the CPU always run
> in "raw" mode, ie, we only support PCR =3D=3D 0, actually.

Okay, thanks for clarifying. Cedric suggested offline that I could
change "Unimplemented..." to "Invalid...". Are there any other changes
you would like?

> So, this patch looks good for me. I'm just not sure about what is
> causing the build break with patchew though...

I can't reproduce the failure here either.

Cheers,

Joel
