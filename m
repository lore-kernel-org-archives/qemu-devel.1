Received: from eggs.gnu.org ([2001:4830:134:3::10]:45016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ch4HJ-0007zJ-UE
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 20:02:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ch4HG-0005Oi-SG
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 20:02:34 -0500
Received: from ozlabs.org ([103.22.144.67]:38573)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1ch4HG-0005OU-5Q
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 20:02:30 -0500
Date: Fri, 24 Feb 2017 11:16:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170224001613.GG17615@umbus.fritz.box>
References: <CAFEAcA8AZup28Sho8hLeCRVf4iSdLdeFHvz1h4-X7FwVBcANyg@mail.gmail.com>
	<448f3a5f-044e-bcac-60bd-2ce074021be9@redhat.com>
	<20170223224911.GC17615@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GdbWtwDHkcXqP16f"
Content-Disposition: inline
In-Reply-To: <20170223224911.GC17615@umbus.fritz.box>
Subject: Re: [Qemu-devel] using fdt_setprop() to set properties to empty
 values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>


--GdbWtwDHkcXqP16f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2017 at 09:49:11AM +1100, David Gibson wrote:
> On Thu, Feb 23, 2017 at 08:52:01AM -0600, Eric Blake wrote:
> > On 02/23/2017 06:33 AM, Peter Maydell wrote:
> > > What's the right way to use libfdt's fdt_setprop to set a property
> > > to have an empty value? At the moment in QEMU we tend to use
> > >   fdt_setprop(fdt, nodeoffset, "propertyname", NULL, 0);
>=20
> That's what I've always used..
>=20
> > > and git grep 'fdt_setprop.*NULL' produces examples of this usage in
> > > PPC and ARM fdt creation code.
> > >=20
> > > However the fdt_setprop() documentation doesn't document that a NULL
> > > value pointer is OK if the length is 0, and indeed the implementation
> > > unconditionally calls memcpy(prop->data, val, len), which is
> > > undefined behaviour, and warned about by clang sanitizers if you
> > > build libfdt with them:
> > >  dtc/libfdt/fdt_rw.c:288:21: runtime error: null pointer passed
> > >    as argument 2, which is declared to never be null
>=20
> ..but indeed that isn't really technically right.
>=20
> > > So what's the best thing to do here? I can't offhand think of a
> > > non-ugly/non-confusing way to pass a valid pointer here...
> >=20
> > Does fdt_setprop(fdt, nodeoffset, "propertyname", "", 0) do the right t=
hing?
>=20
> That should work, but it's a bit clunky.
>=20
> I guess I should add an fdt_setprop_empty() to libfdt.

Ok, I've pushed libfdt upstream patches to (a) make passing NULL to
setprop() with zero length explicitly safe and (b) add an
fdt_setprop_empty() helper macro.  Do you want me to make a pullreq to
update the qemu submodule?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GdbWtwDHkcXqP16f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYr3tKAAoJEGw4ysog2bOSAhUQAMm4U9hEQeO54jwHmqwBhSWD
ScI+xx2qcyji/g9WRVLunrRvTfioSCfiPVG5E9j/HZyD+q3de8oXz3naQC/UyerH
T2dC+AdGrK8knR1JMJirLduVzc0BKBdMrb2Gz+jdgJ6sw6qAek/jggAIz7Syelq4
AP8BtkD2qRshthuSCQeZOeos6KFTJq3RAosZuIS181gwIqP0JAmIpwAOV/BiMG+n
80m20iyl8UC9aduh/CcCu7kHcC4PTIr46Leg+o1bBdeJ+yCVYNzJW7HmY7TkcLhx
5u26jkx/KDnxB4Bo+hOdrSWManHwV3MwOhNcQ8BOefk03imPbOLN/Uux6nVcqwFc
RZ1UhPgdDZCPMp0JrkeUxi/+fnAaELos4uue/bcNzEcblGF+/u2Z1hdHKo2v0kU5
UNIQQYJAfcDlusf29gWuB40Rm6gfcXfH4U07V/UrS5LzJxQ+isd/IKnb3l8XSBVN
4HNX3alMmhVWpN/w1M9c3olMa+MjhZWpJeBpvu42ij2RPmReUsTjSKd7CbcsiHKj
57b+fI/WHTrJ1SAQGBGnDXBjoeY9zqunvKygYOm3a+VvbGTxXd/EaL+GgpwiNtOn
Ncry1iXtR435FffvxaUQS47xFxgH0hKgr0Mj8NMuQ016EkPDERdtZJ3eLZRNIOyX
82I07TJaCUcwORZUGNLi
=NEWD
-----END PGP SIGNATURE-----

--GdbWtwDHkcXqP16f--
