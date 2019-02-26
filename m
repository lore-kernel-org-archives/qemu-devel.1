Received: from eggs.gnu.org ([209.51.188.92]:37669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1gymVH-0001Vc-Bn
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 18:51:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1gymVG-0004mp-Ls
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 18:51:15 -0500
Message-ID: <1551225052.2210.15.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Wed, 27 Feb 2019 10:50:52 +1100
In-Reply-To: <20190226035904.GN6872@umbus.fritz.box>
References: <20190226030531.9932-1-sjitindarsingh@gmail.com>
	<20190226030531.9932-4-sjitindarsingh@gmail.com>
	<20190226035904.GN6872@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH 4/4] target/ppc/spapr: Enable
 the large decrementer by default on POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, clg@kaod.org, qemu-devel@nongnu.org

On Tue, 2019-02-26 at 14:59 +1100, David Gibson wrote:
> On Tue, Feb 26, 2019 at 02:05:31PM +1100, Suraj Jitindar Singh wrote:
> > Enable the large decrementer by default on POWER9 cpu models. The
> > default value applied is that provided in the cpu class.
> > 
> > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > ---
> >  hw/ppc/spapr_caps.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> > index e07568fb94..f48aa367e3 100644
> > --- a/hw/ppc/spapr_caps.c
> > +++ b/hw/ppc/spapr_caps.c
> > @@ -566,11 +566,18 @@ sPAPRCapabilityInfo
> > capability_table[SPAPR_CAP_NUM] = {
> >  static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState
> > *spapr,
> >                                                 const char
> > *cputype)
> >  {
> > +    PowerPCCPUClass *pcc =
> > POWERPC_CPU_CLASS(object_class_by_name(cputype));
> >      sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
> >      sPAPRCapabilities caps;
> >  
> >      caps = smc->default_caps;
> >  
> > +    caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = pcc->hdecr_bits;
> 
> So, the rule with default_caps_with_cpu() is that it can reduce the
> value from the machine-global default, but never increase it (because
> that could change guest visible behaviour for existing machine
> versions).
> 
> I think the line above will do that.

Yep

> 
> > +    if (!ppc_type_check_compat(cputype, CPU_POWERPC_LOGICAL_3_00,
> > +                               0, spapr->max_compat_pvr)) {
> > +        caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = 0;
> 
> And this part I think is redundant, because hdecr_bits won't be large
> for anything pre-POWER9.
> 
> > +    }
> > +
> >      if (!ppc_type_check_compat(cputype, CPU_POWERPC_LOGICAL_2_07,
> >                                 0, spapr->max_compat_pvr)) {
> >          caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
> 
> 
