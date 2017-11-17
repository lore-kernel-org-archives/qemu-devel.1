Received: from eggs.gnu.org ([2001:4830:134:3::10]:44647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eFlF5-0003iw-Om
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:19:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eFlF0-0005QK-Pl
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:19:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eFlF0-0005Nr-H1
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:19:50 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAHICgDu123112
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 13:19:45 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ea4gx147p-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 13:19:44 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Fri, 17 Nov 2017 13:19:43 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <151092340873.11818.16813698420232981002.stgit@bahia>
References: <151092340873.11818.16813698420232981002.stgit@bahia>
Date: Fri, 17 Nov 2017 11:35:49 -0600
Message-Id: <151094014970.31225.12518267907009393872@sif>
Subject: Re: [Qemu-devel] [PATCH for-2.11] spapr: reset DRCs after devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, qemu-stable@nongnu.org

Quoting Greg Kurz (2017-11-17 06:56:48)
> A DRC with a pending unplug request releases its associated device at
> machine reset time.
> =

> In the case of LMB, when all DRCs for a DIMM device have been reset,
> the DIMM gets unplugged, causing guest memory to disappear. This may
> be very confusing for anything still using this memory.
> =

> This is exactly what happens with vhost backends, and QEMU aborts
> with:
> =

> qemu-system-ppc64: used ring relocated for ring 2
> qemu-system-ppc64: qemu/hw/virtio/vhost.c:649: vhost_commit: Assertion
>  `r >=3D 0' failed.
> =

> The issue is that each DRC registers a QEMU reset handler, and we
> don't control the order in which these handlers are called (ie,
> a LMB DRC will unplug a DIMM before the virtio device using the
> memory on this DIMM could stop its vhost backend).
> =

> To avoid such situations, let's reset DRCs after all devices
> have been reset.
> =

> Reported-by: Mallesh N. Koti <mallesh@linux.vnet.ibm.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> ---
>  hw/ppc/spapr.c     |   21 +++++++++++++++++++++
>  hw/ppc/spapr_drc.c |    7 -------
>  2 files changed, 21 insertions(+), 7 deletions(-)
> =

> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 6841bd294b3c..6285f7211f9a 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1411,6 +1411,19 @@ static void find_unknown_sysbus_device(SysBusDevic=
e *sbdev, void *opaque)
>      }
>  }
> =

> +static int spapr_reset_drcs(Object *child, void *opaque)
> +{
> +    sPAPRDRConnector *drc =3D
> +        (sPAPRDRConnector *) object_dynamic_cast(child,
> +                                                 TYPE_SPAPR_DR_CONNECTOR=
);
> +
> +    if (drc) {
> +        spapr_drc_reset(drc);
> +    }
> +
> +    return 0;
> +}
> +
>  static void ppc_spapr_reset(void)
>  {
>      MachineState *machine =3D MACHINE(qdev_get_machine());
> @@ -1434,6 +1447,14 @@ static void ppc_spapr_reset(void)
>      }
> =

>      qemu_devices_reset();
> +
> +    /* DRC reset may cause a device to be unplugged. This will cause tro=
ubles
> +     * if this device is used by another device (eg, a running vhost bac=
kend
> +     * will crash QEMU if the DIMM holding the vring goes away). To avoi=
d such
> +     * situations, we reset DRCs after all devices have been reset.
> +     */
> +    object_child_foreach_recursive(object_get_root(), spapr_reset_drcs, =
NULL);
> +
>      spapr_clear_pending_events(spapr);
> =

>      /*
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 915e9b51c40c..e3b122968e89 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -455,11 +455,6 @@ void spapr_drc_reset(sPAPRDRConnector *drc)
>      }
>  }
> =

> -static void drc_reset(void *opaque)
> -{
> -    spapr_drc_reset(SPAPR_DR_CONNECTOR(opaque));
> -}
> -
>  bool spapr_drc_needed(void *opaque)
>  {
>      sPAPRDRConnector *drc =3D (sPAPRDRConnector *)opaque;
> @@ -518,7 +513,6 @@ static void realize(DeviceState *d, Error **errp)
>      }
>      vmstate_register(DEVICE(drc), spapr_drc_index(drc), &vmstate_spapr_d=
rc,
>                       drc);
> -    qemu_register_reset(drc_reset, drc);
>      trace_spapr_drc_realize_complete(spapr_drc_index(drc));
>  }
> =

> @@ -529,7 +523,6 @@ static void unrealize(DeviceState *d, Error **errp)
>      gchar *name;
> =

>      trace_spapr_drc_unrealize(spapr_drc_index(drc));
> -    qemu_unregister_reset(drc_reset, drc);
>      vmstate_unregister(DEVICE(drc), &vmstate_spapr_drc, drc);
>      root_container =3D container_get(object_get_root(), DRC_CONTAINER_PA=
TH);
>      name =3D g_strdup_printf("%x", spapr_drc_index(drc));
>=20
