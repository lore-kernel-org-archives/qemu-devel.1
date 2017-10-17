Received: from eggs.gnu.org ([2001:4830:134:3::10]:46374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4LAt-0000G5-9a
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 02:16:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4LAs-0004Ti-7Q
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 02:16:23 -0400
Date: Tue, 17 Oct 2017 17:16:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171017061609.GL2776@umbus.fritz.box>
References: <150789430473.4410.10317971414202753256.stgit@bahia.lan>
	<20171014093337.GG28032@umbus.fritz.box>
	<20171016102638.6977381f@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2+jOUFLb7N+7fooZ"
Content-Disposition: inline
In-Reply-To: <20171016102638.6977381f@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH] spapr_cpu_core: instantiate CPUs separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--2+jOUFLb7N+7fooZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2017 at 10:26:38AM +0200, Igor Mammedov wrote:
> On Sat, 14 Oct 2017 20:33:37 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Fri, Oct 13, 2017 at 01:31:44PM +0200, Greg Kurz wrote:
> > > The current code assumes that only the CPU core object holds a
> > > reference on each individual CPU object, and happily frees their
> > > allocated memory when the core is unrealized. This is dangerous
> > > as some other code can legitimely keep a pointer to a CPU if it
> > > calls object_ref(), but it would end up with a dangling pointer.
> > >=20
> > > Let's allocate all CPUs with object_new() and let QOM frees them
> > > when their reference count reaches zero. This greatly simplify the
> > > code as we don't have to fiddle with the instance size anymore.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org> =20
> >=20
> > So, I'm pretty sure my first drafts of the core stuff did things this
> > waym and it got nacked, for QOM lifetime reasons that I never really
> > understood.
> From what I remember, Andreas would like to see composite CPU object
> allocated in one go and then its children initialized with object_initial=
ize()
> so that no more allocation were needed.

Ah, ok.

> That potentially would benefit hotplug, since we could gracefully
> fail object creation early if there is not enough memory.

Yeah, it sounds nice, but I don't see how we can do it.  In order to
do that the core object has to have enough space for all the threads,
which means we need both the size of each thread object and the number
of them.  The size we have (and will be easier to handle after Igor's
cleanups).  The number, we don't.

> But the way it's implemented currently doesn't really match that initial
> goal as array for threads is dynamically allocated later
> and then we need to dance around it with pointer arithmetic.
>=20
> BTW: almost any allocation failure in qemu currently
> is fatal so whether we fail on array alloc or on individual
> object_new() won't make any difference.
>=20
> I'd rather see this clean up merged as it simplifies code
> in these case.

Ok, works for me.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2+jOUFLb7N+7fooZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnloCYACgkQbDjKyiDZ
s5LkdhAAsS8aUQ3dB2keTO/B8mj1DmIahiJuuaLfLw4vPKRhTXHI2XiMOIGwI67V
4H2tbwT8LpnhYo2R1yYscbDP8jGC0DwAekuKnjnyYPsS5lXRYoXjb3LZkPjgODUr
hPtoMAU83sbhLTfKiMsm/NhkqYyN44YBPli0aLMXbrNXiANTdpq/ySkxKnX0hovw
WXF6zQXoCWBT4V+fWdMtJCGCliu3CyVbC/+Ayx/JoabxGenYGb4x15Cdw0Kh4sqm
Dy0udW4Zu4n0TKsgT93QvWQ3varisnb4GbQhWHkg54O8l/eVbl09JL9vBGPBP/0I
wvoxejvcsuuJK7yY9/0PGh1kX2vtJArwDYTY0VtMGbea8ttAoRuAur0nqoQU5ux0
6utTs1ql/aLoQ/nOe8vDNx764ez06Xyr+rbT74rN8N5m3PUIRlvzaubUMeTgsWmg
ZgS45h/eNGrn0XMnXN190xu7OCfmQ1dXjq2T+R6OZDjJvR+lnbzWgQucaLuJunSV
hW8nubcohP01/gF0bnItVsd4ksrLbQbE1e4rgGrMDcl2QCaOflb8Kdm1CLsCM5P2
w4LCGmXGRZ/cwWEJk3F8Gt8celMrhYYD9UMkzetZ7VSsqm8nkd9p8F9hLR7iiVG6
UoBz5ecKEPBN5v0QLFMomWZVFIBpQwAaNS7Xl6KV64wKeHL3JU8=
=cCC3
-----END PGP SIGNATURE-----

--2+jOUFLb7N+7fooZ--
