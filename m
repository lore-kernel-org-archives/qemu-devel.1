Received: from eggs.gnu.org ([2001:4830:134:3::10]:34881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dapk9-0003fs-TV
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 16:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dapk5-0005La-VE
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 16:50:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39884
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dapk5-0005Ky-Ox
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 16:50:45 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6RKmvRv024227
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 16:50:44 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2byjwec5xs-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 16:50:44 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 27 Jul 2017 16:50:44 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <150116311662.21142.16740109690791414399.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <150116311662.21142.16740109690791414399.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Date: Thu, 27 Jul 2017 15:50:37 -0500
Message-Id: <150118863714.22858.14396414884081097996@loki>
Subject: Re: [Qemu-devel] [for-2.10 PATCH] spapr_drc: fix realize and
 unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Quoting Greg Kurz (2017-07-27 08:45:47)
> If object_property_add_alias() returns an error in realize(), we should
> propagate it to the caller and certainly not unref the DRC.

Indeed. I think that was the result of this part of the code
originally living in spapr_dr_connector_new() during development,
where it had previously made sense to free the object if there was a
failure and then return NULL. We definitely shouldn't be during it
now...

> =

> Same thing goes for unrealize(). Since object_property_del() is the last
> call, we can even get rid of the intermediate Error *.
> =

> And finally, unrealize() should undo all registrations performed by
> realize().
> =

> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> =

> David,
> =

> As agreed on the list, here's the version of the fix for 2.10. I'll respin
> my PHB hotplug series on top of it.
> =

> Cheers,
> =

> --
> Greg
> =

>  hw/ppc/spapr_drc.c |   15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> =

> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 15bae5c216a9..47d94e782ac2 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -506,11 +506,11 @@ static void realize(DeviceState *d, Error **errp)
>      trace_spapr_drc_realize_child(spapr_drc_index(drc), child_name);
>      object_property_add_alias(root_container, link_name,
>                                drc->owner, child_name, &err);
> +    g_free(child_name);
>      if (err) {
> -        error_report_err(err);
> -        object_unref(OBJECT(drc));
> +        error_propagate(errp, err);
> +        return;


Since spapr_dr_connector_new() calls realize() with errp =3D NULL, we
basically lose the error now. I think maybe we should at least report it
still, but even better would be to have _new() call object_property_* with
error_abort, since callers of spapr_dr_connector_new() don't all check
for the return value and even if they did the appropriate action would
always be to report+abort() anyway.

Looks good otherwise.

>      }
> -    g_free(child_name);
>      vmstate_register(DEVICE(drc), spapr_drc_index(drc), &vmstate_spapr_d=
rc,
>                       drc);
>      qemu_register_reset(drc_reset, drc);
> @@ -522,16 +522,13 @@ static void unrealize(DeviceState *d, Error **errp)
>      sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(d);
>      Object *root_container;
>      char name[256];
> -    Error *err =3D NULL;
> =

>      trace_spapr_drc_unrealize(spapr_drc_index(drc));
> +    qemu_unregister_reset(drc_reset, drc);
> +    vmstate_unregister(DEVICE(drc), &vmstate_spapr_drc, drc);
>      root_container =3D container_get(object_get_root(), DRC_CONTAINER_PA=
TH);
>      snprintf(name, sizeof(name), "%x", spapr_drc_index(drc));
> -    object_property_del(root_container, name, &err);
> -    if (err) {
> -        error_report_err(err);
> -        object_unref(OBJECT(drc));
> -    }
> +    object_property_del(root_container, name, errp);
>  }
> =

>  sPAPRDRConnector *spapr_dr_connector_new(Object *owner, const char *type,
> =

>=20
