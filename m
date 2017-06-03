Received: from eggs.gnu.org ([2001:4830:134:3::10]:48753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dHHd8-0001jt-TC
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 18:34:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dHHd5-0003A1-TE
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 18:34:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35039)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dHHd5-000384-Jx
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 18:34:43 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v53MY4HL034698
	for <qemu-devel@nongnu.org>; Sat, 3 Jun 2017 18:34:42 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2auuqyygab-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 03 Jun 2017 18:34:42 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Sat, 3 Jun 2017 16:34:41 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170602072952.25454-5-david@gibson.dropbear.id.au>
References: <20170602072952.25454-1-david@gibson.dropbear.id.au>
	<20170602072952.25454-5-david@gibson.dropbear.id.au>
Date: Sat, 03 Jun 2017 17:27:47 -0500
Message-Id: <149652886727.2695.14249081582792918118@loki>
Subject: Re: [Qemu-devel] [PATCH 4/5] spapr: Eliminate
 spapr_drc_get_type_str()
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

Quoting David Gibson (2017-06-02 02:29:51)
> This function was used in generating the device tree.  However, now that
> we have different QOM types for different DRC types we can easily store
> the information we need in the class structure and avoid this specialized
> lookup function.
> =

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> ---
>  hw/ppc/spapr_drc.c         | 31 ++++---------------------------
>  include/hw/ppc/spapr_drc.h |  1 +
>  2 files changed, 5 insertions(+), 27 deletions(-)
> =

> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 27d4bd3..d43c9cd 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -716,6 +716,7 @@ static void spapr_drc_cpu_class_init(ObjectClass *k, =
void *data)
>      sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k);
> =

>      drck->typeshift =3D SPAPR_DR_CONNECTOR_TYPE_SHIFT_CPU;
> +    drck->typename =3D "CPU";
>  }
> =

>  static void spapr_drc_pci_class_init(ObjectClass *k, void *data)
> @@ -723,6 +724,7 @@ static void spapr_drc_pci_class_init(ObjectClass *k, =
void *data)
>      sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k);
> =

>      drck->typeshift =3D SPAPR_DR_CONNECTOR_TYPE_SHIFT_PCI;
> +    drck->typename =3D "28";
>  }
> =

>  static void spapr_drc_lmb_class_init(ObjectClass *k, void *data)
> @@ -730,6 +732,7 @@ static void spapr_drc_lmb_class_init(ObjectClass *k, =
void *data)
>      sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k);
> =

>      drck->typeshift =3D SPAPR_DR_CONNECTOR_TYPE_SHIFT_LMB;
> +    drck->typename =3D "MEM";
>  }
> =

>  static const TypeInfo spapr_dr_connector_info =3D {
> @@ -796,31 +799,6 @@ sPAPRDRConnector *spapr_drc_by_id(const char *type, =
uint32_t id)
>                                | (id & DRC_INDEX_ID_MASK));
>  }
> =

> -/* generate a string the describes the DRC to encode into the
> - * device tree.
> - *
> - * as documented by PAPR+ v2.7, 13.5.2.6 and C.6.1
> - */
> -static const char *spapr_drc_get_type_str(sPAPRDRConnectorType type)
> -{
> -    switch (type) {
> -    case SPAPR_DR_CONNECTOR_TYPE_CPU:
> -        return "CPU";
> -    case SPAPR_DR_CONNECTOR_TYPE_PHB:
> -        return "PHB";
> -    case SPAPR_DR_CONNECTOR_TYPE_VIO:
> -        return "SLOT";
> -    case SPAPR_DR_CONNECTOR_TYPE_PCI:
> -        return "28";
> -    case SPAPR_DR_CONNECTOR_TYPE_LMB:
> -        return "MEM";
> -    default:
> -        g_assert(false);
> -    }
> -
> -    return NULL;
> -}
> -
>  /**
>   * spapr_drc_populate_dt
>   *
> @@ -902,8 +880,7 @@ int spapr_drc_populate_dt(void *fdt, int fdt_offset, =
Object *owner,
>          drc_names =3D g_string_insert_len(drc_names, -1, "\0", 1);
> =

>          /* ibm,drc-types */
> -        drc_types =3D g_string_append(drc_types,
> -                                    spapr_drc_get_type_str(spapr_drc_typ=
e(drc)));
> +        drc_types =3D g_string_append(drc_types, drck->typename);
>          drc_types =3D g_string_insert_len(drc_types, -1, "\0", 1);
>      }
> =

> diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> index 53b0f8b..8a4889a 100644
> --- a/include/hw/ppc/spapr_drc.h
> +++ b/include/hw/ppc/spapr_drc.h
> @@ -212,6 +212,7 @@ typedef struct sPAPRDRConnectorClass {
> =

>      /*< public >*/
>      sPAPRDRConnectorTypeShift typeshift;
> +    const char *typename; /* used in device tree, PAPR 13.5.2.6 & C.6.1 =
*/
> =

>      /* accessors for guest-visible (generally via RTAS) DR state */
>      uint32_t (*set_isolation_state)(sPAPRDRConnector *drc,
> -- =

> 2.9.4
>=20
