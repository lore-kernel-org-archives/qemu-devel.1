Received: from eggs.gnu.org ([2001:4830:134:3::10]:59081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dIICJ-0005kT-RN
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dIICF-0000Lo-74
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:23:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44101)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dIICE-0000LM-UY
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:23:11 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v56HIX97059836
	for <qemu-devel@nongnu.org>; Tue, 6 Jun 2017 13:23:09 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2awxj1yasq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 13:23:09 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Jun 2017 13:23:08 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170606083221.9299-5-david@gibson.dropbear.id.au>
References: <20170606083221.9299-1-david@gibson.dropbear.id.au>
	<20170606083221.9299-5-david@gibson.dropbear.id.au>
Date: Tue, 06 Jun 2017 12:20:34 -0500
Message-Id: <149676963454.2548.14093683337609424658@loki>
Subject: Re: [Qemu-devel] [PATCH 4/7] spapr: Don't misuse DR-indicator in
 spapr_recover_pending_dimm_state()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, sursingh@redhat.com, groug@kaod.org

Quoting David Gibson (2017-06-06 03:32:18)
> With some combinations of migration and hotplug we can lost temporary sta=
te
> indicating how many DRCs (guest side hotplug handles) are still connected
> to a DIMM object in the process of removal.  When we hit that situation
> spapr_recover_pending_dimm_state() is used to scan more extensively and
> work out the right number.
> =

> It does this using drc->indicator state to determine what state of
> disconnection the DRC is in.  However, this is not safe, because the
> indicator state is guest settable - in fact it's more-or-less a purely
> guest->host notification mechanism which should have no bearing on the
> internals of hotplug state management.
> =

> So, replace the test for this with a test on drc->dev, which is a purely
> qemu side managed variable, and updated the same BQL critical section as
> the indicator state.
> =

> This does introduce an off-by-one change, because the indicator state was
> updated before the call to spapr_lmb_release() on the current DRC, whereas
> drc->dev is updated afterwards.  That's corrected by always decrementing
> the nr_lmbs value instead of only doing so in the case where we didn't
> have to recover information.
> =

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> ---
>  hw/ppc/spapr.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> =

> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 671cdbb..e8cecaf 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2683,7 +2683,7 @@ static sPAPRDIMMState *spapr_recover_pending_dimm_s=
tate(sPAPRMachineState *ms,
>          drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
>                                addr / SPAPR_MEMORY_BLOCK_SIZE);
>          g_assert(drc);
> -        if (drc->indicator_state !=3D SPAPR_DR_INDICATOR_STATE_INACTIVE)=
 {
> +        if (drc->dev) {
>              avail_lmbs++;
>          }
>          addr +=3D SPAPR_MEMORY_BLOCK_SIZE;
> @@ -2707,10 +2707,11 @@ void spapr_lmb_release(DeviceState *dev)
>       * during the unplug process. In this case recover it. */
>      if (ds =3D=3D NULL) {
>          ds =3D spapr_recover_pending_dimm_state(spapr, PC_DIMM(dev));
> -        if (ds->nr_lmbs) {
> -            return;
> -        }
> -    } else if (--ds->nr_lmbs) {
> +        /* The DRC being examined by the caller at least must be counted=
 */
> +        g_assert(ds->nr_lmbs);
> +    }
> +
> +    if (--ds->nr_lmbs) {
>          return;
>      }
> =

> -- =

> 2.9.4
>=20
