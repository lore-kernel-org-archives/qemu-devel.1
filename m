Received: from eggs.gnu.org ([2001:4830:134:3::10]:39794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dB14I-0002kV-Ac
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:40:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dB14D-0005qX-Ct
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:40:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35437
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dB14D-0005q4-7p
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:40:49 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4HFcqUK130312
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 11:40:48 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2agq0k8k4h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 11:40:47 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 17 May 2017 09:40:47 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <8ee42025-7ba2-1b30-fff1-47f9df699052@linux.vnet.ibm.com>
References: <20170505204746.14116-1-danielhb@linux.vnet.ibm.com>
	<20170505204746.14116-5-danielhb@linux.vnet.ibm.com>
	<20170512061224.GH12908@umbus.fritz.box>
	<8ee42025-7ba2-1b30-fff1-47f9df699052@linux.vnet.ibm.com>
Date: Mon, 15 May 2017 22:02:28 -0500
Message-Id: <149490374808.29340.16071835944145654917@loki>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v9 4/6] hw/ppc/spapr.c: migrate
 pending_dimm_unplugs of spapr state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

Quoting Daniel Henrique Barboza (2017-05-12 14:54:57)
> =

> =

> On 05/12/2017 03:12 AM, David Gibson wrote:
> > On Fri, May 05, 2017 at 05:47:44PM -0300, Daniel Henrique Barboza wrote:
> >> To allow for a DIMM unplug event to resume its work if a migration
> >> occurs in the middle of it, this patch migrates the non-empty
> >> pending_dimm_unplugs QTAILQ that stores the DIMM information
> >> that the spapr_lmb_release() callback uses.
> >>
> >> It was considered an apprach where the DIMM states would be restored
> >> on the post-_load after a migration. The problem is that there is
> >> no way of knowing, from the sPAPRMachineState, if a given DIMM is going
> >> through an unplug process and the callback needs the updated DIMM Stat=
e.
> >>
> >> We could migrate a flag indicating that there is an unplug event going
> >> on for a certain DIMM, fetching this information from the start of the
> >> spapr_del_lmbs call. But this would also require a scan on post_load to
> >> figure out how many nr_lmbs are left. At this point we can just
> >> migrate the nr_lmbs information as well, given that it is being calcul=
ated
> >> at spapr_del_lmbs already, and spare a scanning/discovery in the
> >> post-load. All that we need is inside the sPAPRDIMMState structure
> >> that is added to the pending_dimm_unplugs queue at the start of the
> >> spapr_del_lmbs, so it's convenient to just migrated this queue it if i=
t's
> >> not empty.
> >>
> >> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> > NACK.
> >
> > As I believe I suggested previously, you can reconstruct this state on
> > the receiving side by doing a full scan of the DIMM and LMB DRC states.
> =

> Just had an idea that I think it's in the line of what you're =

> suggesting. Given
> that the information we need is only created in the spapr_del_lmbs
> (as per patch 1), we can use the absence of this information in the
> release callback as a sort of a flag, an indication that a migration got
> in the way and we need to reconstruct the nr_lmbs states again, using
> the same scanning function I've used in v8.
> =

> The flow would be like this (considering the changes in the
> previous 3 patches so far):
> =

> ------------
> =

> /* Callback to be called during DRC release. */
> void spapr_lmb_release(DeviceState *dev)
> {
>       HotplugHandler *hotplug_ctrl;
> =

>       uint64_t addr =3D spapr_dimm_get_address(PC_DIMM(dev));
>       sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>       sPAPRDIMMState *ds =3D spapr_pending_dimm_unplugs_find(spapr, addr);
> =

>      // no DIMM state found in spapr - re-create it to find out how may =

> LMBs are left
>      if (ds =3D=3D NULL) {
>          uint32 nr_lmbs  =3D ***call_scanning_LMB_DRCs_function(dev)***
>          // recreate the sPAPRDIMMState element and add it back to spapr
>      }
> =

>      ( resume callback as usual )
> =

> -----------
> =

> Is this approach be adequate? Another alternative would be to use another

Seems reasonable to me.

> way of detecting if an LMB unplug is happening and, if positive, do the s=
ame
> process in the post_load(). In this case I'll need to take a look in the =

> code and
> see how we can detect an ongoing unplug besides what I've said above.

You could scan DRCs/LMBs for each DIMM and generate an sPAPRDIMMState for a=
ny
case where DRCs/LMBs are not all present. But doing it the way you've
proposed above lets us re-generate them as needed and avoid the exhaustive
scan. I'd be sure to document it in the comments as a migration-specific ho=
ok
though since you lose that understanding by moving it out of postload and
future refactorings might forget why we have a hook that regenerates it
even though spapr_del_lmbs always sets it initially.

> =

> =

> Thanks,
> =

> =

> Daniel
> =

> >
> >> ---
> >>   hw/ppc/spapr.c | 31 +++++++++++++++++++++++++++++++
> >>   1 file changed, 31 insertions(+)
> >>
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index e190eb9..30f0b7b 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -1437,6 +1437,36 @@ static bool version_before_3(void *opaque, int =
version_id)
> >>       return version_id < 3;
> >>   }
> >>   =

> >> +static bool spapr_pending_dimm_unplugs_needed(void *opaque)
> >> +{
> >> +    sPAPRMachineState *spapr =3D (sPAPRMachineState *)opaque;
> >> +    return !QTAILQ_EMPTY(&spapr->pending_dimm_unplugs);
> >> +}
> >> +
> >> +static const VMStateDescription vmstate_spapr_dimmstate =3D {
> >> +    .name =3D "spapr_dimm_state",
> >> +    .version_id =3D 1,
> >> +    .minimum_version_id =3D 1,
> >> +    .fields =3D (VMStateField[]) {
> >> +        VMSTATE_UINT64(addr, sPAPRDIMMState),
> >> +        VMSTATE_UINT32(nr_lmbs, sPAPRDIMMState),
> >> +        VMSTATE_END_OF_LIST()
> >> +    },
> >> +};
> >> +
> >> +static const VMStateDescription vmstate_spapr_pending_dimm_unplugs =
=3D {
> >> +    .name =3D "spapr_pending_dimm_unplugs",
> >> +    .version_id =3D 1,
> >> +    .minimum_version_id =3D 1,
> >> +    .needed =3D spapr_pending_dimm_unplugs_needed,
> >> +    .fields =3D (VMStateField[]) {
> >> +        VMSTATE_QTAILQ_V(pending_dimm_unplugs, sPAPRMachineState, 1,
> >> +                         vmstate_spapr_dimmstate, sPAPRDIMMState,
> >> +                         next),
> >> +        VMSTATE_END_OF_LIST()
> >> +    },
> >> +};
> >> +
> >>   static bool spapr_ov5_cas_needed(void *opaque)
> >>   {
> >>       sPAPRMachineState *spapr =3D opaque;
> >> @@ -1535,6 +1565,7 @@ static const VMStateDescription vmstate_spapr =
=3D {
> >>       .subsections =3D (const VMStateDescription*[]) {
> >>           &vmstate_spapr_ov5_cas,
> >>           &vmstate_spapr_patb_entry,
> >> +        &vmstate_spapr_pending_dimm_unplugs,
> >>           NULL
> >>       }
> >>   };
>=20
