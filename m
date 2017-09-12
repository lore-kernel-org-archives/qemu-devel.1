Received: from eggs.gnu.org ([2001:4830:134:3::10]:49406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drpuj-0000lT-MP
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drpuf-0004Sb-OS
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:28:01 -0400
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:41091)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1drpuf-0004S6-He
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:27:57 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 16E8CAA8F7
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 20:27:55 +0200 (CEST)
Date: Tue, 12 Sep 2017 20:27:42 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170912202742.6e16b5d0@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <CAFEAcA_geEmuB5mdTZ2BrvpwOve5w9++eAfRXmNTZh+36__VqA@mail.gmail.com>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
	<20170908103558.31632-3-david@gibson.dropbear.id.au>
	<CAFEAcA_geEmuB5mdTZ2BrvpwOve5w9++eAfRXmNTZh+36__VqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/qIdKMWqFS1GOFc4M5K_cn8v";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 02/40] hw/ppc: clear
 pending_events on machine reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, Sam Bobroff <sam.bobroff@au1.ibm.com>

--Sig_/qIdKMWqFS1GOFc4M5K_cn8v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Sep 2017 18:28:04 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 8 September 2017 at 11:35, David Gibson <david@gibson.dropbear.id.au> =
wrote:
> > From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> >
> > The sPAPR machine isn't clearing up the pending events QTAILQ on
> > machine reboot. This allows for unprocessed hotplug/epow events
> > to persist in the queue after reset and, when reasserting the IRQs in
> > check_exception later on, these will be being processed by the OS.
> >
> > This patch implements a new function called 'spapr_clear_pending_events'
> > that clears up the pending_events QTAILQ. This helper is then called
> > inside ppc_spapr_reset to clear up the events queue, preventing
> > old/deprecated events from persisting after a reset.
> >
> > Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au> =20
>=20
> > +void spapr_clear_pending_events(sPAPRMachineState *spapr)
> > +{
> > +    sPAPREventLogEntry *entry =3D NULL;
> > +
> > +    QTAILQ_FOREACH(entry, &spapr->pending_events, next) {
> > +        QTAILQ_REMOVE(&spapr->pending_events, entry, next);
> > +        g_free(entry->extended_log);
> > +        g_free(entry);
> > +    }
> > +} =20
>=20
> Coverity points out that this is a use-after-free error,
> because QTAILQ_FOREACH will access the list pointers of
> entry after the loop body has freed it. You want
> QTAILQ_FOREACH_SAFE, I think. (CID 1381017)
>=20

Yes indeed, QTAILQ_FOREACH_SAFE() is needed when removing
the current element from the list. I'll send a patch.

> thanks
> -- PMM
>=20


--Sig_/qIdKMWqFS1GOFc4M5K_cn8v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWbgnHgAKCRAC/DrrAQHb
whgjAJ41B2DVGh+oUzYJ7S60p5Bmb2CKywCfV2vxgK4nZa85VLcfzMXYfwjE5mo=
=YXYj
-----END PGP SIGNATURE-----

--Sig_/qIdKMWqFS1GOFc4M5K_cn8v--
