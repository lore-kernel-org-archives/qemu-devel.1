Received: from eggs.gnu.org ([2001:4830:134:3::10]:59749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dD3Xm-0006CA-L7
	for qemu-devel@nongnu.org; Tue, 23 May 2017 02:43:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dD3Xi-0000qn-MS
	for qemu-devel@nongnu.org; Tue, 23 May 2017 02:43:46 -0400
Date: Tue, 23 May 2017 16:37:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170523063719.GT30246@umbus.fritz.box>
References: <149518991537.24289.6673616934370284758.stgit@bahia.lan>
	<149518994010.24289.12584852638589552255.stgit@bahia.lan>
	<20170522020413.GF30246@umbus.fritz.box>
	<20170522105950.4af008c1@bahia.lan>
	<20170522151325.0ce5e89a@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CMEQapY8OuP5ao1l"
Content-Disposition: inline
In-Reply-To: <20170522151325.0ce5e89a@bahia.lan>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 3/4] target/ppc: consolidate
 CPU device-tree id computation in helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Laurent Vivier <lvivier@redhat.com>, Cedric Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>


--CMEQapY8OuP5ao1l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2017 at 03:13:25PM +0200, Greg Kurz wrote:
> On Mon, 22 May 2017 10:59:50 +0200
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > On Mon, 22 May 2017 12:04:13 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > On Fri, May 19, 2017 at 12:32:20PM +0200, Greg Kurz wrote: =20
> > > > For historical reasons, we compute CPU device-tree ids with a non-t=
rivial
> > > > logic. This patch consolidate the logic in a single helper to be us=
ed
> > > > in various places where it is currently open-coded.
> > > >=20
> > > > It is okay to get rid of DIV_ROUND_UP() because we're sure that the=
 number
> > > > of threads per core in the guest cannot exceed the number of thread=
s per
> > > > core in the host.   =20
> > >=20
> > > However, your new logic still gives different answers in some cases.
> > > In particular when max_cpus is not a multiple of smp_threads.  Which
> > > is generally a bad idea, but allowed for older machine types for
> > > compatibility.   e.g. smp_threads=3D4, max_cpus=3D6 smt=3D8
> > >=20
>=20
> FWIW, this topology was never supported for pseries >=3D 2.7 since commit
> 94a94e4c4919 ("spapr: convert boot CPUs into CPU core devices", QEMU 2.7):
>=20
> qemu-system-ppc64: max_cpus (6) must be multiple of threads (4)
>=20
> The same happens goes with smp_cpus.

Yes, pre-2.7 is what I meant by older machine types.

> If we care for compat with pre-2.7 machine types (ie, no support for CPU
> hotplug),

We do.. RHEL 7.3 is still 2.6 based, for one thing.

> this topology isn't valid anymore since QEMU 2.9, with these
> commits:
>=20
> 0c86d0fd92aa ("pseries: Always use core objects for CPU construction") wh=
ich
> causes the following error if we only set max_cpus:
>=20
> qemu-system-ppc64: This machine version does not support CPU hotplug

That patch has explicit provision for allowing the last core to have a
not-full complement of threads.

> 8149e2992f78 ("pseries: Enforce homogeneous threads-per-core") which
> causes the following error if we set smp_cpus (or smp_cpus =3D=3D max_cpu=
s):
>=20
> qemu-system-ppc64: invalid nr-threads 2, must be 4

This one does indeed do what you say - but that's a bug :(.  It means
migration from older versions may be broken.

> So in the end, we already enforce max_cpus and smp_cpus to be multiple
> of smp_threads for all machine types. In this case...
>=20
> > > Old logic:
> > > 	         DIV_ROUND_UP(6 * 8, 4)
> > > 	       =3D =E2=8C=8848 / 4=E2=8C=89 =3D 12
> > >=20
> > > New logic gives: =E2=8C=8A6 / 4=E2=8C=8B * 8 + (6 % 4)
> > >                =3D 1 * 8 + 2
> > > 	       =3D 10
> > >  =20
> >=20
> > I now realize this two formulas are hardly reconcilable... this
> > probably means that this patch shouldn't try to consolidate the
> > logic in hw/ppc/spapr.c with the one in target/ppc/translate_init.c.
>=20
> ... both formulas are equivalent, unless I'm missing something. Or
> do we really want to re-allow the funky topologies for older
> machines ?

Want to?  Not really.  Have to for compatibility?  Yes, absolutely.

I've just sent a patch to address this.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CMEQapY8OuP5ao1l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZI9icAAoJEGw4ysog2bOS8+oP/3X+yLH2+7qPBl9sCE9L67Dv
v8fONCw47+W+vo+8kOM0BT98HgsOKB4DHBAYrVSaEWueJrh1iB5AHwb2SyeU2Zwx
z59jIazrnEyClMfF8BMEnrqYyc0a8v1iVVzxSamYt8zthKTlcyQ3pa02voJms3il
etCdoBMIJUwa9vme2f5Cd2JkwcQY9DUy48mJ3ukFhOFaYr7uLjOUyqZvsMNbm5eM
5rKhsYSI6D7pCPlzNqbRZxdxXjnpXXxSK99LFy0RW228VoAqttuarcj34ojLhLFz
epFRxOSbE5K1idcNKkbCju5D57z3Dnmz7+XZdhQ9P6Cqhh3J19g2hjc+KPYVwFtv
VsfY6uc1VMPUHceOe5YyvmnoIkGE4ld6Fe61aJOGp6iRzq6hXg+h3e6DBZDlgRUW
Q6B9HE9etc/7x0NxkARIUgZwx+rsaHdpcqVxC5Zjs0yhcgEKgtMC9SHNGPd9SZnv
qcvW2msvYD5RHbChD+mz0K9itSELI+dxuTyGLY+wLGoYsehrcp6lugSzcRxlA5lo
aZgZuqZN8VQtUB5NTEuKjmNaLQe4v5qyrD8FVocZf1o99v9jll7Y/LUxMbeKad9R
A81HKeLkTZOXvIgGDSQdBuiAZDinix7fOLeYpFrLJ5JgKIoBmMWJGW4wSlSXduc+
4AhMY9ZY0nFNp4BzzWVA
=DDOi
-----END PGP SIGNATURE-----

--CMEQapY8OuP5ao1l--
