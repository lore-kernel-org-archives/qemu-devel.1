Received: from eggs.gnu.org ([2001:4830:134:3::10]:43486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dIkQr-0007l9-32
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 19:32:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dIkQn-0006hQ-Sx
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 19:32:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dIkQn-0006h5-JV
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 19:32:05 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v57NTNuh085321
	for <qemu-devel@nongnu.org>; Wed, 7 Jun 2017 19:32:03 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2axnnvw3u9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 19:32:03 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 7 Jun 2017 19:32:02 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <149687574611.20132.13119959702428537045@loki>
References: <20170606130534.11019-1-david@gibson.dropbear.id.au>
	<20170606130534.11019-3-david@gibson.dropbear.id.au>
	<149687574611.20132.13119959702428537045@loki>
Date: Wed, 07 Jun 2017 18:31:54 -0500
Message-Id: <149687831426.5725.1889099825669243733@loki>
Subject: Re: [Qemu-devel] [RFC 2/3] spapr: Start hotplugged PCI devices in
 ISOLATED state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: sursingh@redhat.com, qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, bharata@linux.vnet.ibm.com

Quoting Michael Roth (2017-06-07 17:49:06)
> Quoting David Gibson (2017-06-06 08:05:33)
> > PCI DRCs, and only PCI DRCs, are immediately moved to UNISOLATED isolat=
ion
> > state once the device is attached.  This has been there from the initial
> > implementation, and it's not clear why.
> > =

> > The state diagram in PAPR 13.4 suggests PCI devices should start in
> > ISOLATED state until the guest moves them into UNISOLATED, and the code=
 in
> > the guest-side drmgr tool seems to work that way too.
> =

> I think this was a misguided attempt to disallow detach() to finalize a
> device immediately after attach(), but up until v1.3.3 drmgr actually
> explicitly put the device right back into ISOLATED before doing
> entity-sense, then back to UNISOLATED right before calling
> configure-connector and eventually bringing the device to a configured
> state. So I doesn't seem like this would have had any effect up until
> drmgr v1.3.3+.
> =

> For drmgr v1.3.3+, this patch would have the effect of allowing detach()
> during the initial entity-sense/set-power-level RTAS calls the guest
> might be doing in response to attach(), but the guest code seems capable
> of dealing with that particular case gracefully.
> =

> I'm a bit concerned if we have *multiple* attach()/detach() pairs being
> executed while drmgr is processing a single hotplug add event though:
> =

> host               guest
> =

> attach()
> notify
>                    rtas-set-indicator(DR_INDICATOR_ON)
>                    rtas-entity-sense =3D> device_present
>                    rtas-set-power-level(on)
> detach()
> attach()
>                    rtas-set-sensor-state(ISOLATION_STATE_UNISOLATED)
>                    rtas-configure-connector =3D> configured
>                    guest actually onlines device, but dr-indicator and
>                    power domain aren't necessarily in the expected
>                    state
> =

> In practice, this one isn't a big issue since we emulate an
> 'automatic' power domain in QEMU that makes any rtas-set-power-level
> calls a no-op, and we don't rely on the dr-indicator (anymore, at
> least), but it does end up being the wrong value, and makes me think

Actually, since we set it explicitly in attach(), dr-indicator does end
up being correct, but correct for the wrong reasons still.

> we should find some way to disallow immediate detach() after attach()
> outside of the scenarios set_signalled() was added for. So I think
> this patch seems reasonable, but maybe patch 3 should instead
> repurpose set_signalled to handle this, or be replaced with some
> other alternative that has the same effect.
> =

> > =

> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> =

> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> =

> > ---
> >  hw/ppc/spapr_drc.c | 10 ----------
> >  1 file changed, 10 deletions(-)
> > =

> > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > index c73fae0..22f9224 100644
> > --- a/hw/ppc/spapr_drc.c
> > +++ b/hw/ppc/spapr_drc.c
> > @@ -291,16 +291,6 @@ void spapr_drc_attach(sPAPRDRConnector *drc, Devic=
eState *d, void *fdt,
> >      }
> >      g_assert(fdt || coldplug);
> > =

> > -    /* NOTE: setting initial isolation state to UNISOLATED means we ca=
n't
> > -     * detach unless guest has a userspace/kernel that moves this state
> > -     * back to ISOLATED in response to an unplug event, or this is done
> > -     * manually by the admin prior. if we force things while the guest
> > -     * may be accessing the device, we can easily crash the guest, so =
we
> > -     * we defer completion of removal in such cases to the reset() hoo=
k.
> > -     */
> > -    if (spapr_drc_type(drc) =3D=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
> > -        drc->isolation_state =3D SPAPR_DR_ISOLATION_STATE_UNISOLATED;
> > -    }
> >      drc->dr_indicator =3D SPAPR_DR_INDICATOR_ACTIVE;
> > =

> >      drc->dev =3D d;
> > -- =

> > 2.9.4
> > =

> =

>=20
