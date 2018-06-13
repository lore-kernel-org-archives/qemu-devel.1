Received: from eggs.gnu.org ([2001:4830:134:3::10]:46517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fT6jd-00077u-Jw
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:26:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fT6jZ-0004Se-Bi
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:26:53 -0400
Received: from 7.mo4.mail-out.ovh.net ([178.33.253.54]:37315)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fT6jZ-0004OT-2O
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:26:49 -0400
Received: from player779.ha.ovh.net (unknown [10.109.120.85])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 3A6FE1836E4
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 16:26:47 +0200 (CEST)
Date: Wed, 13 Jun 2018 16:26:39 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180613162639.08d8cc17@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20180613120502.GO30690@umbus.fritz.box>
References: <152882087494.112322.15549780953419438229.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<152882305541.114463.3137854902721347235.stgit@bahia.lan>
	<20180613004506.GM30690@umbus.fritz.box>
	<20180613101915.4cc9485b@bahia.lab.toulouse-stg.fr.ibm.com>
	<20180613120502.GO30690@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/+cbqSFs1r+EK+GHd=vLoFH6";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 3/3] target/ppc: filter out non-zero PCR
 values when using TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

--Sig_/+cbqSFs1r+EK+GHd=vLoFH6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Jun 2018 22:05:02 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Jun 13, 2018 at 10:19:15AM +0200, Greg Kurz wrote:
> > On Wed, 13 Jun 2018 10:45:06 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > On Tue, Jun 12, 2018 at 07:04:15PM +0200, Greg Kurz wrote: =20
> > > > Bits set in the PCR disable features of the processor. TCG currently
> > > > doesn't implement that, ie, we always act like if PCR is all zeros.
> > > >=20
> > > > But it is still possible for the PCR to have a non-null value. This=
 may
> > > > confuse the guest.
> > > >=20
> > > > There are three distinct cases:
> > > >=20
> > > > 1) a powernv guest doing mtspr SPR_PCR
> > > >=20
> > > > 2) reset of a pseries guest if the max-cpu-compat machine property =
is set
> > > >=20
> > > > 3) CAS of a pseries guest
> > > >=20
> > > > This patch adds a ppc_store_pcr() helper that ensures we cannot put
> > > > a non-null value in the PCR when using TCG. This helper also has
> > > > error propagation support, so that each case listed above can be
> > > > handled appropriately:
> > > >=20
> > > > 1) since the powernv machine is mostly used for OpenPOWER FW devel,
> > > >    we just print an error and let QEMU continue execution
> > > >=20
> > > > 2) an error is printed and QEMU exits, ie, same behaviour as when
> > > >    KVM doesn't support the requested compat mode
> > > >=20
> > > > 3) an error is printed and QEMU reports H_HARDWARE to the guest
> > > >=20
> > > > Signed-off-by: Greg Kurz <groug@kaod.org>   =20
> > >=20
> > > I'm not really convinced this is a good idea.  Printing a (non fatal)
> > > error if the guest attempts to write a non-zero value to the PCR
> > > should be ok.  However, you're generating a fatal error if the machine
> > > tries to set the PCR in TCG mode.  That could easily happen using,
> > > e.g. the cap-htm flag on a TCG guest.  That would take TCG from mostly
> > > working, to refusing to run at all.
> > >  =20
> >=20
> > I'm confused... I don't see anything related to HTM in TCG. Also we have
> > the following in cap_htm_apply():
> >=20
> >     if (tcg_enabled()) {
> >         error_setg(errp,
> >                    "No Transactional Memory support in TCG, try cap-htm=
=3Doff");
> >=20
> > I'm probably missing something... can you enlighten me ? =20
>=20
> Ok, so right now when cap-htm=3Doff we don't actually enforce that, we
> just don't advertise it to the guest.  We probably _should_ enforce
> that, and the way we'd do it is to set the appropriate bit in the
> PCR.  That'll do the right thing for KVM (well, once we update KVM to
> actually pass on the PCR value) but would break TCG in conjunction
> with your patch above.
>=20

Hmm... The granularity of the PCR bits is PowerISA versions, not individual
facilities AFAIK... or am I missing something again ?

Anyway, with the current code, if we start the guest with:

-machine accel=3Dtcg,max-cpu-compat=3Dpower8 -cpu POWER9

We get this in the guest:

# grep ^cpu /proc/cpuinfo=20
cpu             : POWER8 (architected), altivec supported

This is the expected result of the CAS negotiation, but
the guest can still execute PowerISA 3.0 instructions
that should cause an invalid instruction exception.

I agree this shouldn't cause QEMU to exit, but I guess we should
at least leave the PCR to all zeroes, so that the guest view
is consistent with what TGC does (ie, raw mode). And maybe an
error message to indicate that the PCR is ignored in TCG... but
since that could be guest triggered, and the user cannot do anything
about it, I'm wondering if this should rather be a trace actually.

Does it make sense for you ?

Cheers,

--
Greg

--Sig_/+cbqSFs1r+EK+GHd=vLoFH6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlshKZ8ACgkQcdTV5YIv
c9ZFvQ/8CbjlgNCkV9wkqfbuPN953d0pZVju5bx20SQO5PLESQ0YsSk4BoLT2DXM
JWrY+WG4SFG/RBLLN1FdHXcUj4SuYLoQSe+m2qoUwXLsSuDNxLHuQHxsb/VFe+pI
1Mj35UvQOU8DdBDz1m5SdvveWB7VZ4uT94C09A0nH5+yZ4IZWLr4nMidXjefyfkq
GyScLkL6IqMLKTk/SuKZo224aMqM0Rx/Gn7uIK9lKp696XxbK5BPJqnj28jKio+1
RVDfywuWkJcXQPDXUQ/37RftWyRGhB7FZzubCP9WKLj8G/SM+vUc3tYGLScPN64u
RvBN4vJc87ufzJ3MZmrNmYQnm7ySyK9HHciFKcWMvvaa+zWFwmI/X+KQSoWdY66B
mbn4c8C+9ioYUrswD+BdCucW9YtP+Z1ngLBltbjC7OQM/vEo5rmmp3Bu2PPVgIR4
NVE2eXwroZacvickb/sKlX8JlW7rmip1EwoWQltHHuDG3V4uCtlChxDMyjEv9qya
c3ykwS75WmTILRQfwtPPT4q7bvJ2XGWWahhx2NX/7t+SPXFI5TwR8oGrFa163nn7
54QYRWinVk2uVAUltVWCgsgWnQF01MLSyVegTU9xaATof7SBknUXNSfzuggSsLgy
TYirOo1bDPOcv6ZQswHOTkygizxlwbWDFs1zx0iTukHiWJbPDWY=
=flTQ
-----END PGP SIGNATURE-----

--Sig_/+cbqSFs1r+EK+GHd=vLoFH6--
