Received: from eggs.gnu.org ([2001:4830:134:3::10]:53747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ebNQ9-0005e9-Ka
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 04:20:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ebNQ6-0002qe-GY
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 04:20:41 -0500
Received: from 6.mo5.mail-out.ovh.net ([178.32.119.138]:41104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ebNQ6-0002nH-9W
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 04:20:38 -0500
Received: from player695.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 5395017DD04
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 10:20:28 +0100 (CET)
Date: Tue, 16 Jan 2018 10:20:18 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180116102018.382fd035@bahia.lan>
In-Reply-To: <20180116044714.12571-2-david@gibson.dropbear.id.au>
References: <20180116044714.12571-1-david@gibson.dropbear.id.au>
	<20180116044714.12571-2-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv2 1/2] spapr: Allow some cases where we
 can't set VSMT mode in the kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: joserz@linux.vnet.ibm.com, surajjs@au1.ibm.com, sam.bobroff@au1.ibm.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue, 16 Jan 2018 15:47:13 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> At present if we require a vsmt mode that's not equal to the kernel's
> default, and the kernel doesn't let us change it (e.g. because it's an old
> kernel without support) then we always fail.
> 
> But in fact we can cope with the kernel having a different vsmt as long as
>   a) it's >= the actual number of vthreads/vcore (so that guest threads
>      that are supposed to be on the same core act like it)
>   b) it's a submultiple of the requested vsmt mode (so that guest threads
>      spaced by the vsmt value will act like they're on different cores)
> 
> Allowing this case gives us a bit more freedom to adjust the vsmt behaviour
> without breaking existing cases.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

I could check the following on a POWER9 host:

$ ./ppc64-softmmu/qemu-system-ppc64 -accel kvm -smp threads=1
qemu-system-ppc64: warning: Failed to set KVM's VSMT mode to 8 (errno -22)

and the guest boots.

$ ./ppc64-softmmu/qemu-system-ppc64 -accel kvm -smp threads=2
qemu-system-ppc64: Failed to set KVM's VSMT mode to 8 (errno -22)
On PPC, a VM with 2 threads/core on a host with 1 threads/core requires the
 use of VSMT mode 8.
This KVM seems to be too old to support VSMT.

and QEMU exits.

Tested-by: Greg Kurz <groug@kaod.org>

Just one minor remark below but anyway:

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e35214bfc3..6d3613d934 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2314,17 +2314,29 @@ static void spapr_set_vsmt_mode(sPAPRMachineState *spapr, Error **errp)
>      if (kvm_enabled() && (spapr->vsmt != kvm_smt)) {
>          ret = kvmppc_set_smt_threads(spapr->vsmt);
>          if (ret) {
> +            /* Looks like KVM isn't able to change VSMT mode */
>              error_setg(&local_err,
>                         "Failed to set KVM's VSMT mode to %d (errno %d)",
>                         spapr->vsmt, ret);
> -            if (!vsmt_user) {
> -                error_append_hint(&local_err, "On PPC, a VM with %d threads/"
> -                             "core on a host with %d threads/core requires "
> -                             " the use of VSMT mode %d.\n",
> -                             smp_threads, kvm_smt, spapr->vsmt);
> +            /* We can live with that if the default one is big enough
> +             * for the number of threads, and a submultiple of the one
> +             * we want.  In this case we'll waste some vcpu ids, but
> +             * behaviour will be correct */
> +            if ((kvm_smt >= smp_threads) && (spapr->vsmt % kvm_smt) == 0) {

Inconsistent use of parens in the left and right operands of &&

> +                warn_report_err(local_err);
> +                local_err = NULL;
> +                goto out;
> +            } else {
> +                if (!vsmt_user) {
> +                    error_append_hint(&local_err,
> +                                      "On PPC, a VM with %d threads/core"
> +                                      " on a host with %d threads/core"
> +                                      " requires the use of VSMT mode %d.\n",
> +                                      smp_threads, kvm_smt, spapr->vsmt);
> +                }
> +                kvmppc_hint_smt_possible(&local_err);
> +                goto out;
>              }
> -            kvmppc_hint_smt_possible(&local_err);
> -            goto out;
>          }
>      }
>      /* else TCG: nothing to do currently */
