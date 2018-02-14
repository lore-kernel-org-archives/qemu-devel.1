Received: from eggs.gnu.org ([2001:4830:134:3::10]:43139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1em5aX-00068l-6P
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 17:31:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1em5aW-0003Qm-7L
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 17:31:41 -0500
Message-ID: <1518647487.2430.1.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Thu, 15 Feb 2018 09:31:27 +1100
In-Reply-To: <20180214152039.24ca0cf2@bahia.lan>
References: <20180214065135.11633-1-sjitindarsingh@gmail.com>
	<20180214065135.11633-3-sjitindarsingh@gmail.com>
	<20180214152039.24ca0cf2@bahia.lan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [QEMU-PPC] [PATCH V2 3/3]
 ppc/spapr-caps: For pseries-2.12 change spapr-cap defaults
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On Wed, 2018-02-14 at 15:20 +0100, Greg Kurz wrote:
> On Wed, 14 Feb 2018 17:51:35 +1100
> Suraj Jitindar Singh <sjitindarsingh@gmail.com> wrote:
> 
> > For the pseries-2.12 machine type, make the spapr-caps
> > SPAPR_CAP_CFPC
> > and SPAPR_CAP_SBBC default to workaround. Thus if the host is
> > capable
> > the guest will be able to take advantage of these workarounds by
> > default.
> > Otherwise if the host doesn't have these capabilities qemu will
> > fail to
> > start and they will have to be explicitly disabled on the command
> > line
> > with:
> > -machine pseries,cap-cfpc=broken,cap-sbbc=broken
> > 
> > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > ---
> >  hw/ppc/spapr.c      | 11 ++++++++++-
> >  hw/ppc/spapr_caps.c | 10 ++++++++++
> >  include/hw/compat.h |  2 ++
> >  3 files changed, 22 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 969db6cde2..e2ebb76242 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -3941,13 +3941,20 @@ static const TypeInfo spapr_machine_info =
> > {
> >  /*
> >   * pseries-2.12
> >   */
> > +#define
> > SPAPR_COMPAT_2_12                                              \
> > +    HW_COMPAT_2_12
> > +
> >  static void spapr_machine_2_12_instance_options(MachineState
> > *machine)
> >  {
> >  }
> >  
> >  static void spapr_machine_2_12_class_options(MachineClass *mc)
> >  {
> > -    /* Defaults for the latest behaviour inherited from the base
> > class */
> > +    sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
> > +
> > +    smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_WORKAROUND;
> > +    smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_WORKAROUND;
> 
> As written in the comment, the default for the latest machine type
> should
> be set at the base class level, in spapr_machine_class_init()... not
> sure
> to understand why you set it here...

Ah yes, my bad.

> 
> > +    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_12);
> 
> And so, you shouldn't need to setup 2.12 compat mode before 2.12 was
> even
> released :)

Fair enough :)

> 
> >  }
> >  
> >  DEFINE_SPAPR_MACHINE(2_12, "2.12", true);
> > @@ -3969,6 +3976,8 @@ static void
> > spapr_machine_2_11_class_options(MachineClass *mc)
> >  
> >      spapr_machine_2_12_class_options(mc);
> >      smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_ON;
> > +    smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_BROKEN;
> > +    smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
> >      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_11);
> >  }
> >  
> > diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> > index 05997b0842..c25c2bca52 100644
> > --- a/hw/ppc/spapr_caps.c
> > +++ b/hw/ppc/spapr_caps.c
> > @@ -281,11 +281,21 @@ static sPAPRCapabilities
> > default_caps_with_cpu(sPAPRMachineState *spapr,
> >  
> >      caps = smc->default_caps;
> >  
> > +    if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00,
> > +                          0, spapr->max_compat_pvr)) {
> > +        caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_BROKEN;
> > +    }
> > +
> >      if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_07,
> >                            0, spapr->max_compat_pvr)) {
> >          caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
> >      }
> >  
> > +    if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_06_PLUS,
> > +                          0, spapr->max_compat_pvr)) {
> > +        caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
> > +    }
> > +
> >      if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_06,
> >                            0, spapr->max_compat_pvr)) {
> >          caps.caps[SPAPR_CAP_VSX] = SPAPR_CAP_OFF;
> > diff --git a/include/hw/compat.h b/include/hw/compat.h
> > index 7f31850dfa..13238239da 100644
> > --- a/include/hw/compat.h
> > +++ b/include/hw/compat.h
> > @@ -1,6 +1,8 @@
> >  #ifndef HW_COMPAT_H
> >  #define HW_COMPAT_H
> >  
> > +#define HW_COMPAT_2_12
> > +
> >  #define HW_COMPAT_2_11 \
> >      {\
> >          .driver   = "hpet",\
> 
> 
