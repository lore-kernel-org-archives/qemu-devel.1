Received: from eggs.gnu.org ([2001:4830:134:3::10]:57670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dT3PJ-0000wy-HD
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dT3PI-0000HX-6y
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:49:09 -0400
Date: Thu, 6 Jul 2017 19:46:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170706094626.GQ2180@umbus.fritz.box>
References: <20170621091848.28256-1-david@gibson.dropbear.id.au>
	<f89c6897-9555-100a-7252-a705fcbc8ee6@linux.vnet.ibm.com>
	<20170705110414.GN2180@umbus.fritz.box>
	<0e4deabe-58e9-6c15-5910-cda9f8e63f9b@linux.vnet.ibm.com>
	<149929450093.3492.12871680935157233569@loki>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Tcb1KvpfnM4LxW2s"
Content-Disposition: inline
In-Reply-To: <149929450093.3492.12871680935157233569@loki>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 0/5] spapr: DRC cleanups (part
 VI)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, lvivier@redhat.com, sursingh@redhat.com, qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, bharata@linux.vnet.ibm.com


--Tcb1KvpfnM4LxW2s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 05:41:40PM -0500, Michael Roth wrote:
> Quoting Daniel Henrique Barboza (2017-07-05 16:53:57)
> >=20
> >=20
> > On 07/05/2017 08:04 AM, David Gibson wrote:
> > > On Tue, Jul 04, 2017 at 06:13:31PM -0300, Daniel Henrique Barboza wro=
te:
> > >> I just tested this patch set on top of current ppc-for-2.10 branch (=
which
> > >> contains
> > >> the patches from part V). It applied cleanly but required a couple of
> > >> trivial
> > >> fixes to build probably because it was made on top of an older code =
base.
> > > Right, I fixed that up locally already, but haven't gotten around to
> > > reposting yet.  You can look at the 'drcVI' branch on my github tree,
> > > if you're interested.
> > >
> > >> The trivial migration test worked fine. The libvirt scenario (attach=
ing a
> > >> device on
> > >> target before migration, try to unplug after migration) isn't workin=
g as
> > >> expected
> > >> but we have a different result with this series. Instead of silently=
 failing
> > >> to unplug
> > >> with error messages on dmesg, the hot unplug works on QEMU level:
> > > Thanks for testing.  Just to clarify what you're saying here, you
> > > haven't spotted a regression with this series, but there is a case
> > > which was broken and is still broken with slightly different
> > > symptoms.  Yes?
> > In my opinion, yes. It is debatable if the patch series made it worse=
=20
> > because
> > the guest is now misbehaving, but the feature per se wasn't working
> > prior to it.
>=20
> I think it's the removal of awaiting_allocation.

So.. yes, in the sense that I think we've rediscovered the problem
which prompter the awaiting_allocation flag in the first place.  I
still don't think awaiting_allocation is a sensible fix for.. well,
anything.

So we need to find the right fix for this problem.

> We know currently that
> in the libvirt scenario the DRC is exposed in an pre-hotplug state of
> ISOLATED/UNALLOCATED.

Right, need to understand exactly how we get there.

> In that state, spapr_drc_detach() completes
> immediately because from the perspective of QEMU it apparently has not
> been exposed to the guest yet, or the guest has already quiesced it on
> it's end.

Right.

> awaiting_allocation guarded against this, as it's intention was to make
> sure that resource was put into an ALLOCATED state prior to getting moved
> back into an UNALLOCATED state,

Right, but that seems broken to me.  It means if a cpu is hotplug when
the guest isn't paying attention (e.g. early boot, guest is
halted/crashed), then you can't remove it until you either boot an OS
that allocates then releases it, or you reset (and then release).

> so we didn't immediately unplug a CPU
> while the hotplug was in progress.

But in what sense is the hotplug "in progress"?  The guest has been
given a notification, but it hasn't touched the device yet.  Moving
the state away from UNALLOCATED is never guaranteed to work,
regardless of what notifications have been received.

> So in your scenario the CPU is just mysteriously vanishing out from
> under the guest,

Because the DRC is ending up in UNUSABLE state on the destination when
it should be in some other state (and was on the source)?  Yeah, that
sounds plausible.

> which probably explains the hang. The fix for this
> particular scenario is to fix the initial DRC on the target. I think
> we have a plan for that so I wouldn't consider this a regression
> necessarily.

Yeah.. I'm not quite sure how it's ending up wrong; why isn't the
incoming migration state setting it correctly?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Tcb1KvpfnM4LxW2s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZXgbvAAoJEGw4ysog2bOSxGIP/2Wzgbp0t3oqw4SAje77nLAF
inVBEbJHWxCl9diceXPJMuzqsb7lfWJDvMMdToCu7MT5bmeUyIKd6OvPD6KLadls
Gx15jHwsztCHLmGMTDRkKFQK2ZhyoUWzHsb5dbYOHThpi+sSgEhNSIcXxu44+S8S
tso39zTzxHKFCODmkI+VzJ/y1j4/kddXlSlRcD62GtUUhBiYfyY/dcG3IyqsINhh
vIqZjIB0rP4unAjCBcCOS9AUprjau+f13t+r3NqS8LaeFFdiYzhrtmoQqWriz1uU
XWRMp2FBpvn5DY2r0IS15y1vEBITHoxcqUnXYE7ve+xDVwYEzNPa6dVJhDgXfOVN
CAU7Rus4UNvGYKwgdZwxK7XeMGtxnQ4r/C/248GTzUSThD4TO+2WK8ycIkvKwPuy
HFra8aCQtGm469XABW9GRjf4SvYhR28LORfWNlmg7EnO4aXk7rNXKwf54ljBk0v3
gvmxfCygDsf7q3OdPvbbGXufkNE5zL8Yl86MAAnDJHXUJ6TZZZSCXdXViypbqg2M
CZt81Vho0mR02FN+dUWYR/87KR3mweRuLX9QXumwAJIko7rBH8dFIA4FkDSdxwz9
Uopqidx5S3B0VLbur8eiBeRclLi0tjIUZ2KjJB8Wv1pC6T2vlECrJhCRWnpg+w9Z
QtwrfVyDx4h8m0PeNvif
=vLJ0
-----END PGP SIGNATURE-----

--Tcb1KvpfnM4LxW2s--
