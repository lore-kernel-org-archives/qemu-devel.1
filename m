Received: from eggs.gnu.org ([2001:4830:134:3::10]:55348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1eb2Ae-0003Xi-8q
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:39:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1eb2Ab-0005tf-12
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:39:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45746
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1eb2Aa-0005tN-R8
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:39:12 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0FAd5QP037293
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 05:39:12 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fgt5hhh05-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 05:39:11 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Mon, 15 Jan 2018 05:39:11 -0500
Date: Mon, 15 Jan 2018 08:38:58 -0200
From: joserz@linux.vnet.ibm.com
References: <20180115072715.25921-1-david@gibson.dropbear.id.au>
	<20180115072715.25921-3-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180115072715.25921-3-david@gibson.dropbear.id.au>
Message-Id: <20180115103858.GA6946@pacoca>
Subject: Re: [Qemu-devel] [PATCH 2/2] spapr: Adjust default VSMT value for
 better migration compatibility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: groug@kaod.org, surajjs@au1.ibm.com, sam.bobroff@au1.ibm.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Mon, Jan 15, 2018 at 06:27:15PM +1100, David Gibson wrote:
> fa98fbfc "PC: KVM: Support machine option to set VSMT mode" introduced the
> "vsmt" parameter for the pseries machine type, which controls the spacing
> of the vcpu ids of thread 0 for each virtual core.  This was done to bring
> some consistency and stability to how that was done, while still allowing
> backwards compatibility for migration and otherwise.
> 
> The default value we used for vsmt was set to the max of the host's
> advertised default number of threads and the number of vthreads per vcore
> in the guest.  This was done to continue running without extra parameters
> on older KVM versions which don't allow the VSMT value to be changed.
> 
> Unfortunately, even that smaller than before leakage of host configuration
> into guest visible configuration still breaks things.  Specifically a guest
> with 4 (or less) vthread/vcore will get a different vsmt value when
> running on a POWER8 (vsmt==8) and POWER9 (vsmt==4) host.  That means the
> vcpu ids don't line up so you can't migrate between them, though you should
> be able to.
> 
> Long term we really want to make vsmt == smp_threads for sufficiently
> new machine types.  However, that means that qemu will then require a
> sufficiently recent KVM (one which supports changing VSMT) - that's still
> not widely enough deployed to be really comfortable to do.
> 
> In the meantime we some default that will work as often as possible.
> This patch changes that default to 8 in all circumstances.  This does
> change guest visible behaviour (including for existing machine versions)
> for many cases - just not the most common/important case.
> 
> Following is case by case justification for why this is still the least
> worst option.  Note that any of the old behaviours can still be duplicated
> after this patch, it's just that it requires manual intervention by
> setting the vsmt property on the command line.
> 
> KVM HV on POWER8 host:
>    This is the overwhelmingly common case in production setups, and is
>    unchanged by design.  POWER8 hosts will advertise a default VSMT mode
>    of 8, and > 8 vthreads/vcore isn't permitted
> 
> KVM HV on POWER7 host:
>    Will break, but POWER7s allowing KVM were never released to the public.
> 
> KVM HV on POWER9 host:
>    Not yet released to the public, breaking this now will reduce other
>    breakage later.
> 
> KVM HV on PowerPC 970:
>    Will theoretically break it, but it was barely supported to begin with
>    and already required various user visible hacks to work.  Also so old
>    that I just don't care.
> 
> TCG:
>    This is the nastiest one; it means migration of TCG guests (without
>    manual vsmt setting) will break.  Since TCG is rarely used in production
>    I think this is worth it for the other benefits.  It does also remove
>    one more barrier to TCG<->KVM migration which could be interesting for
>    debugging applications.
> 
> KVM PR:
>    As with TCG, this will break migration of existing configurations,
>    without adding extra manual vsmt options.  As with TCG, it is rare in
>    production so I think the benefits outweigh breakages.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e35214bfc3..8e5ef7c9de 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2305,9 +2305,14 @@ static void spapr_set_vsmt_mode(sPAPRMachineState *spapr, Error **errp)
>          }
>          /* In this case, spapr->vsmt has been set by the command line */
>      } else {
> -        /* Choose a VSMT mode that may be higher than necessary but is
> -         * likely to be compatible with hosts that don't have VSMT. */
> -        spapr->vsmt = MAX(kvm_smt, smp_threads);
> +        /*
> +         * Default VSMT value is tricky, because we need it to be as
> +         * consistent as possible (for migration), but this requires
> +         * changing it for at least some existing cases.  We pick 8 as
> +         * the value that we'd get with KVM on POWER8, the
> +         * overwhelmingly common case in production systems.
> +         */
> +        spapr->vsmt = 8;
>      }
> 
>      /* KVM: If necessary, set the SMT mode: */
> -- 
> 2.14.3
> 

Great rationale.

Reviewed-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
