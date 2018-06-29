Received: from eggs.gnu.org ([2001:4830:134:3::10]:35932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYykv-0000ZM-F3
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:08:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYyks-000215-87
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 15:08:29 -0400
Date: Fri, 29 Jun 2018 16:08:22 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180629190822.GW7451@localhost.localdomain>
References: <153018086531.336571.17029459443980070626.stgit@bahia.lan>
	<153018091454.336571.7311461748726927045.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153018091454.336571.7311461748726927045.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH 2/3] spapr: compute default value of
 "hpt-max-page-size" later
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>

On Thu, Jun 28, 2018 at 12:15:14PM +0200, Greg Kurz wrote:
[...]
> @@ -2527,6 +2527,18 @@ static void spapr_machine_init(MachineState *machine)
>      QLIST_INIT(&spapr->phbs);
>      QTAILQ_INIT(&spapr->pending_dimm_unplugs);
>  
> +    /* This is for pseries-2.12 and older machine types */
> +    if (!smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE]) {
> +        uint8_t mps;
> +
> +        if (kvmppc_hpt_needs_host_contiguous_pages()) {
> +            mps = ctz64(qemu_getrampagesize());
> +        } else {
> +            mps = 34; /* allow everything up to 16GiB, i.e. everything */
> +        }
> +        smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] = mps;

Initializing class fields on instance init functions is a sign
that the information doesn't belong to the class struct.  Can't
this be handled at default_caps_with_cpu()?

> +    }
> +
>      /* Determine capabilities to run with */
>      spapr_caps_init(spapr);
>  
> @@ -4103,17 +4115,16 @@ static void spapr_machine_2_12_instance_options(MachineState *machine)
>  static void spapr_machine_2_12_class_options(MachineClass *mc)
>  {
>      sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
> -    uint8_t mps;
>  
>      spapr_machine_3_0_class_options(mc);
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_12);
>  
> -    if (kvmppc_hpt_needs_host_contiguous_pages()) {
> -        mps = ctz64(qemu_getrampagesize());
> -    } else {
> -        mps = 34; /* allow everything up to 16GiB, i.e. everything */
> -    }
> -    smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] = mps;
> +    /* We depend on kvm_enabled() to choose a default value for the
> +     * hpt-max-page-size capability. Of course we can't do it here
> +     * because this is too early and the HW accelerator isn't initialzed
> +     * yet. Postpone this to spapr_machine_init().
> +     */
> +    smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] = 0;
>  }
>  
>  DEFINE_SPAPR_MACHINE(2_12, "2.12", false);
> 

-- 
Eduardo
