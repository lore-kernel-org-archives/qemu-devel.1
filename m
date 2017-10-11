Received: from eggs.gnu.org ([2001:4830:134:3::10]:47448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e24Y5-0003gl-69
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 20:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e24Y4-0004kz-4x
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 20:06:57 -0400
Date: Wed, 11 Oct 2017 11:04:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171011000453.GC10496@umbus.fritz.box>
References: <20171010132159.15787-1-david@gibson.dropbear.id.au>
	<20171010164431.168777e9@bahia.lan>
	<955ac977-e20b-4c55-bbaa-a51c41f2bed3@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Content-Disposition: inline
In-Reply-To: <955ac977-e20b-4c55-bbaa-a51c41f2bed3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] spapr: Correct RAM size calculation for
 HPT resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, clg@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2017 at 05:21:53PM +0200, Laurent Vivier wrote:
> On 10/10/2017 16:44, Greg Kurz wrote:
> > On Wed, 11 Oct 2017 00:21:59 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> >> In order to prevent the guest from forcing the allocation of large amo=
unts
> >> of qemu memory (or host kernel memory, in the case of KVM HV), we limit
> >> the size of Hashed Page Table (HPT) it is allowed to allocated, based =
on
> >> its RAM size.
> >>
> >> However, the current calculation is not correct: it only adds up the s=
ize
> >> of plugged memory, ignoring the base memory size.  This patch corrects=
 it.
> >>
> >> While we're there, use get_plugged_memory_size() instead of directly
> >> calling pc_existing_dimms_capacity().  The only difference is that it
> >> will abort on failure, which is right: a failure here indicates someth=
ing
> >> wrong within qemu.
> >>
> >> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >> ---
> >>  hw/ppc/spapr_hcall.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> >> index 8d72bb7c1c..06af1b15c0 100644
> >> --- a/hw/ppc/spapr_hcall.c
> >> +++ b/hw/ppc/spapr_hcall.c
> >> @@ -494,7 +494,7 @@ static target_ulong h_resize_hpt_prepare(PowerPCCP=
U *cpu,
> >>          return H_PARAMETER;
> >>      }
> >> =20
> >> -    current_ram_size =3D pc_existing_dimms_capacity(&error_fatal);
> >> +    current_ram_size =3D ram_size + get_plugged_memory_size();
> >=20
> > current_ram_size is initialized earlier in this function:
> >=20
> >     uint64_t current_ram_size =3D MACHINE(spapr)->ram_size;
> >=20
> > which is is initialized to ram_size in vl.c. Why not doing:
> >=20
> >     current_ram_size +=3D get_plugged_memory_size();
> >=20
> > ?
>=20
> I agree, it seems like the original intend of the first patch...

Yes, I think so.  However, splitting the calculation like that
demonstrably misread someone reading the code (i.e. me), so I'm going
to just ditch the initializerin the new spin.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlndYCIACgkQbDjKyiDZ
s5JWfg//ZhI/IXsGYSw2Nt5BSyBdbk+ulpkqIS2yfxAbLFHN0QG4Acm24IkNzPL4
+iPMqI7h2rvBuoY5764iswZskcpdkjzHCCLdV2aBXaR2iGwvEu36PDAKRNwqztOB
NV/55z+RRSEpdBuBYl34A6Bpt+jV6gafETZHNGlulSzaD5bd+3/IUNlnj3w0rr86
uI3EuXndpFkv8opaZBcybVjFWGVqdiRajoqlUHqSh4lq/HH+TW6oHkE03JBKX2EP
+okOWAl+cXIr8rebX+KN/zrify6Gwfj2xor6KVzZdQh7reRnLZelPYFxhx5mg0nT
k5650oo+fbmzY8ra7hSkAe4WnSRiMW0JImjHY6Vv4lXhRSkJPO6ZxQ8B3nuh42VB
UMJC6BCIZVHm48wdJJgZictHiiO5SAu6X8YFp5Lo+KnL4ZwtIXf2jmcBcfsPTO3f
/j3FxstGvBP596POQfQ0CnjOjoi0SE2ClUmNQuAv8metHMLOESL6sseq2TzXXdfS
9TWjGAXTido8EkG+qEK6e8hLK3t8AhBJ6B/NLuDxpvtd2w0Ysprckwlmi69qUGBv
xrS+AYoDQxt98tnha1GjgGTrTqlO+IztzS+E3l0O+upzwZ9aOnPmUdETPp+o0OvV
N66VwCSeILZiSyGREMNckarKfNyLK4muLFVRXkwhDxZMJBDLI50=
=PpcF
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--
