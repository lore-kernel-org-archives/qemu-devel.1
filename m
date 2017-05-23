Received: from eggs.gnu.org ([2001:4830:134:3::10]:60969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dD5Oq-00073F-CM
	for qemu-devel@nongnu.org; Tue, 23 May 2017 04:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dD5Ol-0008JU-GE
	for qemu-devel@nongnu.org; Tue, 23 May 2017 04:42:40 -0400
Message-ID: <1495528948.2205.3.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Tue, 23 May 2017 18:42:28 +1000
In-Reply-To: <20170523044836.GI3446@in.ibm.com>
References: <1495172439-1504-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1495172439-1504-5-git-send-email-bharata@linux.vnet.ibm.com>
	<1495434650.2205.1.camel@gmail.com> <20170523044836.GI3446@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH v2 4/4] spapr: Fix migration
 of Radix guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: bharata@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, rnsastry@linux.vnet.ibm.com, qemu-ppc@nongnu.org, sam.bobroff@au1.ibm.com, david@gibson.dropbear.id.au

On Tue, 2017-05-23 at 10:18 +0530, Bharata B Rao wrote:
> On Mon, May 22, 2017 at 04:30:50PM +1000, Suraj Jitindar Singh wrote:
> > On Fri, 2017-05-19 at 11:10 +0530, Bharata B Rao wrote:
> > > Fix migration of radix guests by ensuring that we issue
> > > KVM_PPC_CONFIGURE_V3_MMU for radix case post migration.
> > > 
> > > Reported-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
> > > Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > > ---
> > >  hw/ppc/spapr.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index daf335c..8f20f14 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -1400,6 +1400,18 @@ static int spapr_post_load(void *opaque,
> > > int
> > > version_id)
> > >          err = spapr_rtc_import_offset(&spapr->rtc, spapr-
> > > > rtc_offset);
> > > 
> > >      }
> > 
> > This will break migration for tcg radix guests.
> > 
> > Given that there is essentially nothing special we need to do on
> > incoming tcg migration, I suggest we make it:
> > 
> > if (spapr->patb_entry && kvm_enabled()) {
> >     [snip]
> > }
> > 
> > >  
> > > +    if (spapr->patb_entry) {
> > > +        PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
> > > +        if (kvmppc_has_cap_mmu_radix() && kvm_enabled()) {
> > 
> > Why not make this a bit more generic? Something like:
> > 
> > err = kvmppc_configure_v3_mmu(cpu, !!(spapr->patb_entry &
> > PATBE1_GR),
> > !!(cpu->env.spr[SPR_LPCR] & LPCR_GTSE), spapr->patb_entry);
> > if (err) {
> >     error_report("Process table config unsupported by the host");
> >     return -EINVAL;
> > }
> > 
> > return err;
> > 
> > While I don't think it's possible currently, there is nothing
> > inherently incorrect about having a non-zero process table entry
> > for a
> > hash guest. And this saves a future update.
> 
> How about having this logic in spapr_post_load() ?

Looks a lot better :)

> 
>     if (spapr->patb_entry) {
>         /* Can be Hash(in future?) or Radix guest (current) */
>         PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
>         bool radix = !!(spapr->patb_entry & PATBE1_GR);
>         bool gtse = !!(cpu->env.spr[SPR_LPCR] & LPCR_GTSE);
> 

Don't think we need this if statement though. When hash with patb entry
is possible it will still need to call kvmppc_configure_v3_mmu on
incoming migration, that isn't radix specific.

>         if (radix) {
>             /* Radix guest, configure MMU */
>             /* kvmppc_configure_v3_mmu() is NOP for TCG */
>             err = kvmppc_configure_v3_mmu(cpu, radix, gtse, spapr-
> >patb_entry);
>             if (err) {
>                 error_report("Process table config unsupported by the
> host");
>                 return -EINVAL;
>             }
>         } else {
>             /* Can be Hash guest (in future ?), nothing to do */
>         }
>     } else {

Don't need this else statement. Can just have the comment below if you
feel it's necessary.

>         /* Hash guest (current), nothing to do */
>     }
> 
> Regards,
> Bharata.
> 

Thanks,
Suraj
