Received: from eggs.gnu.org ([2001:4830:134:3::10]:39732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZzmT-0004pF-9I
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZzmP-0005su-7E
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:21:45 -0400
Date: Tue, 25 Jul 2017 23:21:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170725132129.GH8978@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-15-git-send-email-clg@kaod.org>
	<20170724063534.GM17228@umbus.fritz.box>
	<fa7a0b3f-89d5-b1ef-238d-0bda41beee9f@kaod.org>
	<20170725042027.GC8978@umbus.fritz.box>
	<1d7d50ee-7559-2e6b-4ed0-741d810052d0@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="54u2kuW9sGWg/X+X"
Content-Disposition: inline
In-Reply-To: <1d7d50ee-7559-2e6b-4ed0-741d810052d0@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH 14/26] ppc/xive: add MMIO handlers to
 the XIVE interrupt presenter model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--54u2kuW9sGWg/X+X
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 11:08:46AM +0200, C=E9dric Le Goater wrote:
> On 07/25/2017 06:20 AM, David Gibson wrote:
> > On Mon, Jul 24, 2017 at 04:44:00PM +0200, C=E9dric Le Goater wrote:
> >> On 07/24/2017 08:35 AM, David Gibson wrote:
> >>> On Wed, Jul 05, 2017 at 07:13:27PM +0200, C=E9dric Le Goater wrote:
> >>>> The Thread Interrupt Management Area for the OS is mostly used to
> >>>> acknowledge interrupts and set the CPPR of the CPU.
> >>>>
> >>>> The TIMA is mapped at the same address for each CPU. 'current_cpu' is
> >>>> used to retrieve the targeted interrupt presenter object.
> >>>>
> >>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>>
> >>> Am I right in thinking that this shoehorns the XIVE TIMA state into
> >>> the existing XICS ICP object.  That.. doesn't seem like a good idea.
> >>
> >> The TIMA memory region is under the XIVE object because it is=20
> >> unique for the system. The lookup of the ICP is simply done using=20
> >> 'current_cpu'. The TIMA state is under the ICPState, yes, but this=20
> >> model does not seem incorrect to me as this state contains the=20
> >> interrupt information presented to a CPU.
> >=20
> > Yeah, that's not the point I'm making.  My point is that the TIMA
> > state isn't really the same as xics ICP state.  You're squeezing one
> > into the other in a pretty ugly way.
>=20
> yes, well, we need to have compatible objects between the XICS and XIVE=
=20
> mode because of the CAS negotiation. for migration compatibility, it is=
=20
> much easier to extend existing objects. This approach I am taking today.

Yeah, I really don't think this approach is workable.

Roughly speaking, you're keeping the same structures between xics and
xive, but with mostly different code.  I can't see any way that's not
going to be horribly fragile, with any update to xics OR xive
requiring enormous caution not to break the other.

I really think we have to go one of two ways:

1) Abstract the notion of interrupt source and interrupt presenter, so
we can use a truly common model between xics and xive.

Given the differences between the two, I don't know this is even
possible.

2) Separate the objects entirely.  ICPs are entirely separate from
TIMAs, like wise ICSes and xive interrupt sources.

I think this is probably the way to go.  To make this work with CAS
switching will require different methods, but I don't think it's
impossible.

For example, we could (on the new machine type) create both xics ICSes
and ICPs and xive sources and TIMAs.  We'd have a (migrated) flag in
the machine saying which is currently active.  All the objects would
hang around, but only the active ones would do anything.

Now obviously that means we'd be migrating a bunch of redundant state,
but I still think it's preferable to a Frankenstinian fusion of
xics-ish and xive-ish state.  I think there's a good chance we can
improve on the basic idea to remove most or all of that redundant
state.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--54u2kuW9sGWg/X+X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll3RdYACgkQbDjKyiDZ
s5JvKw/9GMaNFOovXbATfLjDpcFoto5vA1Qc3d29DzRJZYmGb3nTm7ElE2qtrhhE
EughxYeS2K5s/NdHJBP86OYwhaF5N/tT6LdMNYgx2xBp1eAGX4fgFdiFUWNgWCem
KbjPgaf4eEAuZZ4j2ZFC/t6gmplIfVNlfI9AcYgMD7mYVk6vMZE8ZdLAiL9bqM6S
MhNRW2PS1ui0VJnlgxgRp30+mvf8kQjlrQtoFRHZtBtlAOreYXAWp9xGlbw5docc
Az39ALMH6FXqntNT+e7xmT3XNgWtsqOoPajj+szv662KjGkAVY4gb0dlQKE6RcLJ
qAdbNmqn6FcIqe0GrPrIi9nGYCFyPc3lTbY56v8a6y24gZAC95E8ZJrojIW9vBvl
5/0q9XEVTCsQ4O5MkrOoaCFmRZpMSxws7gbbYUkaq/0CgbvBPOF4xwTO0D+KOFtH
EghLg4Epn5CkHdde8m19ONA9tKWiw/QkRYF2SLFhVlhAQrjT7Ei5m6kxXV7kmyh8
fUUu8Pidbjm7+0SGBqS4QBunQmY0iBtBdDIkY2FJqfxEH13vburQSmMqBqPAEGsB
Nnc6Jxf0aA0bfd2gY4WnxrdGdX2a28YlT6ZSNtEmqslj8U4nblnniOtuACndtzzv
lSw4FB0EfxKLSWk4oxNeu7UYI1rLjYCfGrc0jDrw8mbMqTHib+U=
=+BY+
-----END PGP SIGNATURE-----

--54u2kuW9sGWg/X+X--
