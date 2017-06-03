Received: from eggs.gnu.org ([2001:4830:134:3::10]:48740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dHHd8-0001jW-7S
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 18:34:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dHHd5-000392-ID
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 18:34:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dHHd5-00037D-9b
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 18:34:43 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v53MY5jn071672
	for <qemu-devel@nongnu.org>; Sat, 3 Jun 2017 18:34:41 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2auv446hnp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 03 Jun 2017 18:34:41 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Sat, 3 Jun 2017 16:34:40 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170602072952.25454-6-david@gibson.dropbear.id.au>
References: <20170602072952.25454-1-david@gibson.dropbear.id.au>
	<20170602072952.25454-6-david@gibson.dropbear.id.au>
Date: Sat, 03 Jun 2017 17:34:26 -0500
Message-Id: <149652926658.2695.5793892804950077026@loki>
Subject: Re: [Qemu-devel] [PATCH 5/5] spapr: Remove some non-useful
 properties on DRC objects
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

Quoting David Gibson (2017-06-02 02:29:52)
>  * 'connector_type' is easily derived from the 'index' property, so there=
's
>    no point to it (it's also implicit in the QOM type of the DRC)
>  * 'isolation-state', 'indicator-state' and 'allocation-state' are
>    part of the transaction between qemu and guest during PAPR hotplug
>    operations, and outside tools really have no business looking at it
>    (especially not changing, and these were RW properties)
>  * 'entity-sense' is basically just a weird PAPR encoding of whether there
>    is a device connected to this DRC
> =

> Strictly speaking removing these properties is breaking the qemu interfac=
e.
> However, I'm pretty sure no management tools have ever used these.  For
> debugging there are better alternatives.  Therefore, I think removing the=
se
> broken interfaces is the better option.

Debugging was indeed the primary motivation behind these. I agree these
don't really serve any useful purpose now and probably should've just
been traces from the start.

> =

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> ---
>  hw/ppc/spapr_drc.c | 29 -----------------------------
>  1 file changed, 29 deletions(-)
> =

> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index d43c9cd..4dd26a8 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -228,14 +228,6 @@ static void prop_get_index(Object *obj, Visitor *v, =
const char *name,
>      visit_type_uint32(v, name, &value, errp);
>  }
> =

> -static void prop_get_type(Object *obj, Visitor *v, const char *name,
> -                          void *opaque, Error **errp)
> -{
> -    sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(obj);
> -    uint32_t value =3D (uint32_t)spapr_drc_type(drc);
> -    visit_type_uint32(v, name, &value, errp);
> -}
> -
>  static char *prop_get_name(Object *obj, Error **errp)
>  {
>      sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(obj);
> @@ -243,17 +235,6 @@ static char *prop_get_name(Object *obj, Error **errp)
>      return g_strdup(drck->get_name(drc));
>  }
> =

> -static void prop_get_entity_sense(Object *obj, Visitor *v, const char *n=
ame,
> -                                  void *opaque, Error **errp)
> -{
> -    sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(obj);
> -    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> -    uint32_t value;
> -
> -    drck->entity_sense(drc, &value);
> -    visit_type_uint32(v, name, &value, errp);
> -}
> -
>  static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
>                           void *opaque, Error **errp)
>  {
> @@ -670,20 +651,10 @@ static void spapr_dr_connector_instance_init(Object=
 *obj)
>  {
>      sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(obj);
> =

> -    object_property_add_uint32_ptr(obj, "isolation-state",
> -                                   &drc->isolation_state, NULL);
> -    object_property_add_uint32_ptr(obj, "indicator-state",
> -                                   &drc->indicator_state, NULL);
> -    object_property_add_uint32_ptr(obj, "allocation-state",
> -                                   &drc->allocation_state, NULL);
>      object_property_add_uint32_ptr(obj, "id", &drc->id, NULL);
>      object_property_add(obj, "index", "uint32", prop_get_index,
>                          NULL, NULL, NULL, NULL);
> -    object_property_add(obj, "connector_type", "uint32", prop_get_type,
> -                        NULL, NULL, NULL, NULL);
>      object_property_add_str(obj, "name", prop_get_name, NULL, NULL);
> -    object_property_add(obj, "entity-sense", "uint32", prop_get_entity_s=
ense,
> -                        NULL, NULL, NULL, NULL);
>      object_property_add(obj, "fdt", "struct", prop_get_fdt,
>                          NULL, NULL, NULL, NULL);
>  }
> -- =

> 2.9.4
>=20
