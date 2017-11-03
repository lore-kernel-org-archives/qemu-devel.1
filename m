Received: from eggs.gnu.org ([2001:4830:134:3::10]:43985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eAiAx-0001uD-6L
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 16:02:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eAiAw-00058A-CJ
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 16:02:47 -0400
Date: Fri, 3 Nov 2017 21:02:33 +0100
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171103200233.GI3111@localhost.localdomain>
References: <1509734853-3014-1-git-send-email-cota@braap.org>
	<20171103185610.GA3907@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171103185610.GA3907@flamenco>
Subject: Re: [Qemu-devel] [PATCH] hw: add .min_cpus and .default_cpus fields
 to machine_class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>

On Fri, Nov 03, 2017 at 02:56:10PM -0400, Emilio G. Cota wrote:
> On Fri, Nov 03, 2017 at 14:47:33 -0400, Emilio G. Cota wrote:
> > diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
> > index e2d15a1..395d1b5 100644
> > --- a/hw/arm/xlnx-zcu102.c
> > +++ b/hw/arm/xlnx-zcu102.c
> > @@ -185,6 +185,9 @@ static void xlnx_ep108_machine_class_init(ObjectClass *oc, void *data)
> >      mc->block_default_type = IF_IDE;
> >      mc->units_per_default_bus = 1;
> >      mc->ignore_memory_transaction_failures = true;
> > +    mc->max_cpus = XLNX_ZYNQMP_NUM_APU_CPUS + XLNX_ZYNQMP_NUM_RPU_CPUS;
> > +    mc->min_cpus = XLNX_ZYNQMP_NUM_APU_CPUS;
> > +    mc->default_cpus = XLNX_ZYNQMP_NUM_APU_CPUS;
> >  }
> >  
> >  static const TypeInfo xlnx_ep108_machine_init_typeinfo = {
> > @@ -241,6 +244,8 @@ static void xlnx_zcu102_machine_class_init(ObjectClass *oc, void *data)
> >      mc->units_per_default_bus = 1;
> >      mc->ignore_memory_transaction_failures = true;
> >      mc->max_cpus = XLNX_ZYNQMP_NUM_APU_CPUS + XLNX_ZYNQMP_NUM_RPU_CPUS;
> > +    mc->min_cpus = XLNX_ZYNQMP_NUM_APU_CPUS;
> > +    mc->default_cpus = XLNX_ZYNQMP_NUM_APU_CPUS;
> >  }
> 
> Should we update max_cpus to just NUM_APU_CPUS as well for these boards?
> -smp 5 or 6 (NUM_APU + NUM_RPU) still gets us 4 vCPUs.
> 
> I see there's code for RPU cpus but it seems disabled at compile-time
> at xlnx-zynqmp.c:431:
>    DEFINE_PROP_BOOL("has_rpu", XlnxZynqMPState, has_rpu, false)
> Or is there a run-time way to override this?

Device properties can be overridden using -global, e.g.:

  -global driver=xlnx,,zynqmp,property=has_rpu,value=on

(",," is how commas are escaped in QEMU options)

-- 
Eduardo
