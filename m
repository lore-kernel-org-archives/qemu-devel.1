Received: from eggs.gnu.org ([2001:4830:134:3::10]:40105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d39FD-0000Bf-1C
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d39F8-000633-UU
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:47:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42015
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1d39F8-00062i-Nu
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:47:34 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3PMhjCw123452
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 18:47:34 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a2ebvje9p-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 18:47:33 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 25 Apr 2017 16:47:33 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170424220828.1472-4-danielhb@linux.vnet.ibm.com>
References: <20170424220828.1472-1-danielhb@linux.vnet.ibm.com>
	<20170424220828.1472-4-danielhb@linux.vnet.ibm.com>
Date: Tue, 25 Apr 2017 17:47:25 -0500
Message-Id: <149316044542.25359.10425152686852824599@loki>
Subject: Re: [Qemu-devel] [PATCH 3/4] migration: spapr: migrate ccs_list in
 spapr state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Quoting Daniel Henrique Barboza (2017-04-24 17:08:27)
> From: Jianjun Duan <duanj@linux.vnet.ibm.com>
> =

> ccs_list in spapr state maintains the device tree related
> information on the rtas side for hotplugged devices. In racing
> situations between hotplug events and migration operation, a rtas
> hotplug event could be migrated from the source guest to target
> guest, or the source guest could have not yet finished fetching
> the device tree when migration is started, the target will try
> to finish fetching the device tree. By migrating ccs_list, the
> target can fetch the device tree properly.
> =

> In theory there would be other alternatives besides migrating the
> css_list to fix this. For example, we could add a flag that indicates
> whether a device is in the middle of the configure_connector during the
> migration process, in the post_load we can detect if this flag
> is active and then return an error informing the guest to restart the
> hotplug process. However, the DRC state can still be modified outside of
> hotplug. Using:
> =

>    drmgr -c pci -s <drc_index> -r
>    drmgr -c pci -s <drc_index> -a
> =

> it is possible to return a device to firmware and then later take it
> back and reconfigure it. This is not a common case but it's not prohibite=
d,
> and performing a migration between these 2 operations would fail because
> the default coldplug state on target assumes a configured state in
> the source*. Migrating ccs_list is one solution that cover this
> case as well.
> =

> ccs_list is put in a subsection in the spapr state VMSD to make
> sure migration across different versions is not broken.
> =

> * see http://lists.nongnu.org/archive/html/qemu-devel/2016-10/msg01763.ht=
ml
> for more information on this discussion.
> =

> Signed-off-by: Jianjun Duan <duanj@linux.vnet.ibm.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> =

> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 35db949..22f351c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1388,6 +1388,37 @@ static bool version_before_3(void *opaque, int ver=
sion_id)
>      return version_id < 3;
>  }
> =

> +static bool spapr_ccs_list_needed(void *opaque)
> +{
> +    sPAPRMachineState *spapr =3D (sPAPRMachineState *)opaque;
> +    return !QTAILQ_EMPTY(&spapr->ccs_list);
> +}
> +
> +static const VMStateDescription vmstate_spapr_ccs =3D {
> +    .name =3D "spaprconfigureconnectorstate",

some word separators wouldn't hurt, since they might show up in
migration error messages.

> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32(drc_index, sPAPRConfigureConnectorState),
> +        VMSTATE_INT32(fdt_offset, sPAPRConfigureConnectorState),
> +        VMSTATE_INT32(fdt_depth, sPAPRConfigureConnectorState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static const VMStateDescription vmstate_spapr_ccs_list =3D {
> +    .name =3D "spaprccslist",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D spapr_ccs_list_needed,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_QTAILQ_V(ccs_list, sPAPRMachineState, 1,
> +                         vmstate_spapr_ccs, sPAPRConfigureConnectorState,
> +                         next),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static bool spapr_ov5_cas_needed(void *opaque)
>  {
>      sPAPRMachineState *spapr =3D opaque;
> @@ -1486,6 +1517,7 @@ static const VMStateDescription vmstate_spapr =3D {
>      .subsections =3D (const VMStateDescription*[]) {
>          &vmstate_spapr_ov5_cas,
>          &vmstate_spapr_patb_entry,
> +        &vmstate_spapr_ccs_list,
>          NULL
>      }
>  };
> -- =

> 2.9.3
> =

>=20
