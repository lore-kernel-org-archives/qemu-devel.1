Received: from eggs.gnu.org ([2001:4830:134:3::10]:59054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dIICH-0005kF-UD
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dIICD-0000Ky-06
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:23:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43903
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dIICC-0000Km-Pb
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:23:08 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v56HIbJ9075735
	for <qemu-devel@nongnu.org>; Tue, 6 Jun 2017 13:23:07 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2awy7kvy77-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 13:23:07 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Jun 2017 13:23:06 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170606083221.9299-3-david@gibson.dropbear.id.au>
References: <20170606083221.9299-1-david@gibson.dropbear.id.au>
	<20170606083221.9299-3-david@gibson.dropbear.id.au>
Date: Tue, 06 Jun 2017 11:21:24 -0500
Message-Id: <149676608476.2548.3465140774718898504@loki>
Subject: Re: [Qemu-devel] [PATCH 2/7] spapr: Abolish DRC get_name method
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

Quoting David Gibson (2017-06-06 03:32:16)
> DRConnectorClass has a get_name method, however:
>   * There's only one implementation, and only ever likely to be one
>   * There's exactly one caller, which is (now) local
>   * The implementation is trivial
> =

> So just open-code what we need.
> =

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> ---
>  hw/ppc/spapr_drc.c         | 11 ++---------
>  include/hw/ppc/spapr_drc.h |  1 -
>  2 files changed, 2 insertions(+), 10 deletions(-)
> =

> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index da3779e..9140b48 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -167,11 +167,6 @@ static uint32_t set_allocation_state(sPAPRDRConnecto=
r *drc,
>      return RTAS_OUT_SUCCESS;
>  }
> =

> -static const char *get_name(sPAPRDRConnector *drc)
> -{
> -    return drc->name;
> -}
> -
>  /* has the guest been notified of device attachment? */
>  static void set_signalled(sPAPRDRConnector *drc)
>  {
> @@ -221,8 +216,7 @@ static void prop_get_index(Object *obj, Visitor *v, c=
onst char *name,
>  static char *prop_get_name(Object *obj, Error **errp)
>  {
>      sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(obj);
> -    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> -    return g_strdup(drck->get_name(drc));
> +    return g_strdup(drc->name);
>  }
> =

>  static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
> @@ -653,7 +647,6 @@ static void spapr_dr_connector_class_init(ObjectClass=
 *k, void *data)
>      drck->set_isolation_state =3D set_isolation_state;
>      drck->set_indicator_state =3D set_indicator_state;
>      drck->set_allocation_state =3D set_allocation_state;
> -    drck->get_name =3D get_name;
>      drck->attach =3D attach;
>      drck->detach =3D detach;
>      drck->release_pending =3D release_pending;
> @@ -848,7 +841,7 @@ int spapr_drc_populate_dt(void *fdt, int fdt_offset, =
Object *owner,
>          g_array_append_val(drc_power_domains, drc_power_domain);
> =

>          /* ibm,drc-names */
> -        drc_names =3D g_string_append(drc_names, drck->get_name(drc));
> +        drc_names =3D g_string_append(drc_names, drc->name);
>          drc_names =3D g_string_insert_len(drc_names, -1, "\0", 1);
> =

>          /* ibm,drc-types */
> diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> index f892b94..795b7dd 100644
> --- a/include/hw/ppc/spapr_drc.h
> +++ b/include/hw/ppc/spapr_drc.h
> @@ -223,7 +223,6 @@ typedef struct sPAPRDRConnectorClass {
>                                      sPAPRDRIndicatorState state);
>      uint32_t (*set_allocation_state)(sPAPRDRConnector *drc,
>                                       sPAPRDRAllocationState state);
> -    const char *(*get_name)(sPAPRDRConnector *drc);
> =

>      /* QEMU interfaces for managing hotplug operations */
>      void (*attach)(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
> -- =

> 2.9.4
>=20
