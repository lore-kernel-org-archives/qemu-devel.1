Received: from eggs.gnu.org ([2001:4830:134:3::10]:55318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f9MMu-0002he-JA
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 23:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f9MMr-0007Ll-EG
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 23:05:48 -0400
Date: Fri, 20 Apr 2018 12:17:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180420021724.GB2434@umbus.fritz.box>
References: <20180419072123.682-1-david@gibson.dropbear.id.au>
	<20180419143318.4e24edaf@redhat.com>
	<20180419145840.324602ff.cohuck@redhat.com>
	<77d0717b-6eba-8b20-6691-c3085937604b@de.ibm.com>
	<065165b5-3ab4-ae1a-f72c-c04f911656c3@redhat.com>
	<20180419180851.461a0db3@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline
In-Reply-To: <20180419180851.461a0db3@bahia.lan>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH for-2.13] Clear mem_path if we
 fall back to anonymous RAM allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Igor Mammedov <imammedo@redhat.com>, ehabkost@redhat.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, pbonzini@redhat.com


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2018 at 06:08:51PM +0200, Greg Kurz wrote:
> On Thu, 19 Apr 2018 16:11:37 +0200
> David Hildenbrand <david@redhat.com> wrote:
>=20
> > On 19.04.2018 15:34, Christian Borntraeger wrote:
> > >=20
> > >=20
> > > On 04/19/2018 02:58 PM, Cornelia Huck wrote: =20
> > >> On Thu, 19 Apr 2018 14:33:18 +0200
> > >> Igor Mammedov <imammedo@redhat.com> wrote:
> > >> =20
> > >>> On Thu, 19 Apr 2018 17:21:23 +1000
> > >>> David Gibson <david@gibson.dropbear.id.au> wrote:
> > >>> =20
> > >>>> If the -mem-path option is set, we attempt to map the guest's RAM =
=66rom a
> > >>>> file in the given path; it's usually used to back guest RAM with h=
ugepages.
> > >>>> If we're unable to (e.g. not enough free hugepages) then we fall b=
ack to
> > >>>> allocating normal anonymous pages.  This behaviour can be surprisi=
ng, but a
> > >>>> comment in allocate_system_memory_nonnuma() suggests it's legacy b=
ehaviour
> > >>>> we can't change.
> > >>>>
> > >>>> What really isn't ok, though, is that in this case we leave mem_pa=
th set.
> > >>>> That means functions which attempt to determine the pagesize of ma=
in RAM
> > >>>> can erroneously think it is hugepage based on the requested path, =
even
> > >>>> though it's not.
> > >>>>
> > >>>> This is particular bad for the pseries machine type.  KVM HV limit=
ations
> > >>>> mean the guest can't use pagesizes larger than the host page size =
used to
> > >>>> back RAM.  That means that such a fallback, rather than merely giv=
ing
> > >>>> poorer performance that expected will cause the guest to freeze up=
 early in
> > >>>> boot as it attempts to use large page mappings that can't work.
> > >>>>
> > >>>> This patch addresses the problem by clearing the mem_path variable=
 when we
> > >>>> fall back to anonymous pages, meaning that subsequent attempts to
> > >>>> determine the RAM page size will get an accurate result.
> > >>>>
> > >>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > >>>> ---
> > >>>>  numa.c | 1 +
> > >>>>  1 file changed, 1 insertion(+)
> > >>>>
> > >>>> Paolo et al, as with my earlier patches adding some extensions to =
the
> > >>>> helpers for determining backing page sizes, if there are no object=
ions
> > >>>> can I get an ack to merge this via my ppc tree?
> > >>>>
> > >>>> diff --git a/numa.c b/numa.c
> > >>>> index 1116c90af9..78a869e598 100644
> > >>>> --- a/numa.c
> > >>>> +++ b/numa.c
> > >>>> @@ -469,6 +469,7 @@ static void allocate_system_memory_nonnuma(Mem=
oryRegion *mr, Object *owner,
> > >>>>              /* Legacy behavior: if allocation failed, fall back to
> > >>>>               * regular RAM allocation.
> > >>>>               */
> > >>>> +            mem_path =3D NULL;
> > >>>>              memory_region_init_ram_nomigrate(mr, owner, name, ram=
_size, &error_fatal);
> > >>>>          }
> > >>>>  #else   =20
> > >>>
> > >>> mem_path is also used by kvm_s390_apply_cpu_model(),
> > >>> and in ccw_init() memory is initialized before CPUs are
>=20
> Something similar happens with spapr: kvm_fixup_page_sizes() calls
> qemu_getrampagesize() during CPU start, which happens before the machine
> init calls allocate_system_memory_nonnuma(). Shouldn't we allocate memory
> before calling spapr_init_cpus() in spapr_machine_init() then ?

Note that the way kvm_fixup_page_sizes() works is broken in it's own
right - this patch was actually written as a prliminary to fixing
that.

> > >>> so if QEM was started with -mem-path, then before patch
> > >>> created CPU won't have CMM enabled and print warning:
> > >>>  =20
> > >>>  "CMM will not be enabled because it is not compatible with hugetlb=
fs."
> > >>>
> > >>> and after patch it might enable CMM if we clear mem_path.
> > >>> So question is do we care about this? =20
> > >>
> > >> I don't quite remember the cmm semantics here -- Christian? =20
> > >=20
> > > The CMMA interface does not work on large pages. I think the kernel w=
ill react
> > > with EFAULT in some cases (cmma migration and others) so qemu will pr=
obably fail
> > > unexpectedly.=20
> > >=20
> > > But this patch seems to only clear mem-path if we do not allocate at =
all from
> > > hugetlbfs. So things should be ok, no?
> > >=20
> > >  =20
> >=20
> > This even looks like the right thing to me, as hugetlbfs was never
> > supported.
> >=20
>=20
> Unrelated to this patch, -mem-path can be passed something that doesn't s=
it
> in a hugetlbfs, in which case we use getpagesize()... is there a reason f=
or
> kvm_s390_enable_cmma() to filter out this case as well ? Or should we rat=
her
> check mem_path isn't NULL and points to a hugetlbfs ?
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrZTbEACgkQbDjKyiDZ
s5JRag/9EbYTObuSDYp9CSyOyHEPbwxBntoQphW5fpy9sDFuVBmgPaBumN6mju+f
mEejZatO+oXWTY+jVRjqIXB2e6quy41klnvEHyCHfXz7rEj1JkLm1xrUU1OnQG74
0j3W0vCI15S5hUD5kpNLvZnXuolqt4pmnkDWnQc4QzDmG07E2J8Hc6AH47bcl5ox
g0olHySHAptsmctZh+Hc1SH9cOYJHCXMvanPgZEjb3oTZX1k13YuMRvXlan3YVhC
9/OFw6R6wjdpimZ7F2qvUjhlxWvKNovjYpuMUTf8NeH4iKEeQ+6YJQOfJUq8nPhp
V0eof+ZFhS4bo7dWbPl+YQ2qSc72cF1vPAhlEgnM+3odGZa+sh8OlL9seCItiJH6
Ca39LYS/4KbRfEnPitsbEjzvysF90GC4N23z4Q62LLwcp4gdzwsnM6uhgXlcF4dc
acLYigvpqfFL40LLytobAqROyrdNoVL+LSEee0AI7s5+s1N/j8Wga1VteB0z/WAP
oVc1pWFI51OfxXqFJhg3xu4vYMeE+j5jevCf3m8p/GfHMPU0GlJ0/ckC6+g36Zbz
CLJQHSeWZyL30B5O+4eK6nQENMpZ04fLiVcxO9Cwyvcudliw/4diairTvj9Ymq19
Nh4CXduwOx16hpH8OI5pICiogRhwFiiC1x98Hz+Pm8NaDGmFiG4=
=3vRy
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
