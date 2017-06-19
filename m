Received: from eggs.gnu.org ([2001:4830:134:3::10]:49657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dN5Xa-00024s-Kt
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 18:53:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dN5XX-0006Mt-Vn
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 18:53:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dN5XX-0006MD-MZ
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 18:52:59 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5JMmYHg027402
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 18:52:55 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2b64rtbusr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 18:52:55 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 19 Jun 2017 16:52:54 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170608050930.2613-7-david@gibson.dropbear.id.au>
References: <20170608050930.2613-1-david@gibson.dropbear.id.au>
	<20170608050930.2613-7-david@gibson.dropbear.id.au>
Date: Mon, 19 Jun 2017 17:52:27 -0500
Message-Id: <149791274735.25078.4110942481519654764@loki>
Subject: Re: [Qemu-devel] [PATCH 6/6] spapr: Clean up DRC
 set_isolation_state() path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: bharata@linux.vnet.ibm.com, sursingh@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

Quoting David Gibson (2017-06-08 00:09:30)
> There are substantial differences in the various paths through
> set_isolation_state(), both for setting to ISOLATED versus UNISOLATED
> state and for logical versus physical DRCs.
> =

> So, split the set_isolation_state() method into isolate() and unisolate()
> methods, and give it different implementations for the two DRC types.
> =

> Factor some minimal common checks, including for valid indicator values
> (which we weren't previously checking) into rtas_set_isolation_state().
> =

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr_drc.c         | 145 ++++++++++++++++++++++++++++++++-------=
------
>  include/hw/ppc/spapr_drc.h |   6 +-
>  2 files changed, 105 insertions(+), 46 deletions(-)
> =

> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 9e01d7b..90c0fde 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -46,30 +46,64 @@ uint32_t spapr_drc_index(sPAPRDRConnector *drc)
>          | (drc->id & DRC_INDEX_ID_MASK);
>  }
> =

> -static uint32_t set_isolation_state(sPAPRDRConnector *drc,
> -                                    sPAPRDRIsolationState state)
> +static uint32_t drc_isolate_physical(sPAPRDRConnector *drc)
>  {
> -    trace_spapr_drc_set_isolation_state(spapr_drc_index(drc), state);
> -
>      /* if the guest is configuring a device attached to this DRC, we
>       * should reset the configuration state at this point since it may
>       * no longer be reliable (guest released device and needs to start
>       * over, or unplug occurred so the FDT is no longer valid)
>       */
> -    if (state =3D=3D SPAPR_DR_ISOLATION_STATE_ISOLATED) {
> -        g_free(drc->ccs);
> -        drc->ccs =3D NULL;
> -    }
> +    g_free(drc->ccs);
> +    drc->ccs =3D NULL;
> =

> -    if (state =3D=3D SPAPR_DR_ISOLATION_STATE_UNISOLATED) {
> -        /* cannot unisolate a non-existent resource, and, or resources
> -         * which are in an 'UNUSABLE' allocation state. (PAPR 2.7, 13.5.=
3.5)
> -         */
> -        if (!drc->dev ||
> -            drc->allocation_state =3D=3D SPAPR_DR_ALLOCATION_STATE_UNUSA=
BLE) {
> -            return RTAS_OUT_NO_SUCH_INDICATOR;
> +    drc->isolation_state =3D SPAPR_DR_ISOLATION_STATE_ISOLATED;
> +
> +    /* if we're awaiting release, but still in an unconfigured state,
> +     * it's likely the guest is still in the process of configuring
> +     * the device and is transitioning the devices to an ISOLATED
> +     * state as a part of that process. so we only complete the
> +     * removal when this transition happens for a device in a
> +     * configured state, as suggested by the state diagram from PAPR+
> +     * 2.7, 13.4
> +     */
> +    if (drc->awaiting_release) {
> +        uint32_t drc_index =3D spapr_drc_index(drc);
> +        if (drc->configured) {
> +            trace_spapr_drc_set_isolation_state_finalizing(drc_index);
> +            spapr_drc_detach(drc, DEVICE(drc->dev), NULL);
> +        } else {
> +            trace_spapr_drc_set_isolation_state_deferring(drc_index);
>          }
>      }
> +    drc->configured =3D false;
> +
> +    return RTAS_OUT_SUCCESS;
> +}
> +
> +static uint32_t drc_unisolate_physical(sPAPRDRConnector *drc)
> +{
> +    /* cannot unisolate a non-existent resource, and, or resources
> +     * which are in an 'UNUSABLE' allocation state. (PAPR 2.7,
> +     * 13.5.3.5)
> +     */
> +    if (!drc->dev) {
> +        return RTAS_OUT_NO_SUCH_INDICATOR;
> +    }
> +
> +    drc->isolation_state =3D SPAPR_DR_ISOLATION_STATE_UNISOLATED;
> +
> +    return RTAS_OUT_SUCCESS;
> +}
> +
> +static uint32_t drc_isolate_logical(sPAPRDRConnector *drc)
> +{
> +    /* if the guest is configuring a device attached to this DRC, we
> +     * should reset the configuration state at this point since it may
> +     * no longer be reliable (guest released device and needs to start
> +     * over, or unplug occurred so the FDT is no longer valid)
> +     */
> +    g_free(drc->ccs);
> +    drc->ccs =3D NULL;
> =

>      /*
>       * Fail any requests to ISOLATE the LMB DRC if this LMB doesn't
> @@ -81,35 +115,47 @@ static uint32_t set_isolation_state(sPAPRDRConnector=
 *drc,
>       * If the LMB being removed doesn't belong to a DIMM device that is
>       * actually being unplugged, fail the isolation request here.
>       */
> -    if (spapr_drc_type(drc) =3D=3D SPAPR_DR_CONNECTOR_TYPE_LMB) {
> -        if ((state =3D=3D SPAPR_DR_ISOLATION_STATE_ISOLATED) &&
> -             !drc->awaiting_release) {
> -            return RTAS_OUT_HW_ERROR;
> -        }
> +    if (spapr_drc_type(drc) =3D=3D SPAPR_DR_CONNECTOR_TYPE_LMB
> +        && !drc->awaiting_release) {
> +        return RTAS_OUT_HW_ERROR;
>      }
> =

> -    drc->isolation_state =3D state;
> +    drc->isolation_state =3D SPAPR_DR_ISOLATION_STATE_ISOLATED;
> =

> -    if (drc->isolation_state =3D=3D SPAPR_DR_ISOLATION_STATE_ISOLATED) {
> -        /* if we're awaiting release, but still in an unconfigured state,
> -         * it's likely the guest is still in the process of configuring
> -         * the device and is transitioning the devices to an ISOLATED
> -         * state as a part of that process. so we only complete the
> -         * removal when this transition happens for a device in a
> -         * configured state, as suggested by the state diagram from
> -         * PAPR+ 2.7, 13.4
> -         */
> -        if (drc->awaiting_release) {
> -            uint32_t drc_index =3D spapr_drc_index(drc);
> -            if (drc->configured) {
> -                trace_spapr_drc_set_isolation_state_finalizing(drc_index=
);
> -                spapr_drc_detach(drc, DEVICE(drc->dev), NULL);
> -            } else {
> -                trace_spapr_drc_set_isolation_state_deferring(drc_index);
> -            }
> +    /* if we're awaiting release, but still in an unconfigured state,
> +     * it's likely the guest is still in the process of configuring
> +     * the device and is transitioning the devices to an ISOLATED
> +     * state as a part of that process. so we only complete the
> +     * removal when this transition happens for a device in a
> +     * configured state, as suggested by the state diagram from PAPR+
> +     * 2.7, 13.4
> +     */
> +    if (drc->awaiting_release) {
> +        uint32_t drc_index =3D spapr_drc_index(drc);
> +        if (drc->configured) {
> +            trace_spapr_drc_set_isolation_state_finalizing(drc_index);
> +            spapr_drc_detach(drc, DEVICE(drc->dev), NULL);
> +        } else {
> +            trace_spapr_drc_set_isolation_state_deferring(drc_index);

Not sure this is the right patch to do it, but this refactoring does make
it more apparent that the if (drc->configured) checks should get pushed
down into spapr_drc_detach() like the other deferral checks at some point.

(There are 2 locations that do the detach without checking configured,
but you switched out the one in reset() to use spapr_drc_release()
already, and I don't think drc_set_unusable() without first going
through drc_isolate_*() is a transition that PAPR would allow anyway)
