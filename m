Received: from eggs.gnu.org ([2001:4830:134:3::10]:39620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBVZi-00064g-Qf
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 21:19:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBVZh-0008Ia-6R
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 21:19:54 -0400
Date: Thu, 26 Apr 2018 10:55:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180426005555.GA8800@umbus.fritz.box>
References: <20180419062917.31486-1-david@gibson.dropbear.id.au>
	<1524151804.3017.9.camel@redhat.com>
	<20180420023542.GD2434@umbus.fritz.box>
	<1524216670.3017.11.camel@redhat.com>
	<20180420102117.GQ2434@umbus.fritz.box>
	<1524672566.23669.15.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <1524672566.23669.15.camel@redhat.com>
Subject: Re: [Qemu-devel] [RFC for-2.13 0/7] spapr: Clean up pagesize
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: groug@kaod.org, aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 06:09:26PM +0200, Andrea Bolognani wrote:
> On Fri, 2018-04-20 at 20:21 +1000, David Gibson wrote:
> > On Fri, Apr 20, 2018 at 11:31:10AM +0200, Andrea Bolognani wrote:
> > > Is the 16 MiB page size available for both POWER8 and POWER9?
> >=20
> > No.  That's a big part of what makes this such a mess.  HPT has 16MiB
> > and 16GiB hugepages, RPT has 2MiB and 1GiB hugepages.  (Well, I guess
> > tecnically Power9 does have 16MiB pages - but only in hash mode, which
> > the host won't be).
> >=20
> [...]
> > > > This does mean, for example, that if
> > > > it was just set to the hugepage size on a p9, 21 (2MiB) things shou=
ld
> > > > work correctly (in practice it would act identically to setting it =
to
> > > > 16).
> > >=20
> > > Wouldn't that lead to different behavior depending on whether you
> > > start the guest on a POWER9 or POWER8 machine? The former would be
> > > able to use 2 MiB hugepages, while the latter would be stuck using
> > > regular 64 KiB pages.
> >=20
> > Well, no, because 2MiB hugepages aren't a thing in HPT mode.  In RPT
> > mode it'd be able to use 2MiB hugepages either way, because the
> > limitations only apply to HPT mode.
> >=20
> > > Migration of such a guest from POWER9 to
> > > POWER8 wouldn't work because the hugepage allocation couldn't be
> > > fulfilled,
> >=20
> > Sort of, you couldn't even get as far as staring the incoming qemu
> > with hpt-mps=3D21 on the POWER8 (unless you gave it 16MiB hugepages for
> > backing).
> >=20
> > > but the other way around would probably work and lead to
> > > different page sizes being available inside the guest after a power
> > > cycle, no?
> >=20
> > Well.. there are a few cases here.  If you migrated p8 -> p8 with
> > hpt-mps=3D21 on both ends, you couldn't actually start the guest on the
> > source without giving it hugepage backing.  In which case it'll be
> > fine on the p9 with hugepage mapping.
> >=20
> > If you had hpt-mps=3D16 on the source and hpt-mps=3D21 on the other end,
> > well, you don't get to count on anything because you changed the VM
> > definition.  In fact it would work in this case, and you wouldn't even
> > get new page sizes after restart because HPT mode doesn't support any
> > pagesizes between 64kiB and 16MiB.
> >=20
> > > > > I guess 34 corresponds to 1 GiB hugepages?
> > > >=20
> > > > No, 16GiB hugepages, which is the "colossal page" size on HPT POWER
> > > > machines.  It's a simple shift, (1 << 34) =3D=3D 16 GiB, 1GiB pages=
 would
> > > > be 30 (but wouldn't let the guest do any more than 24 ~ 16 MiB in
> > > > practice).
> > >=20
> > > Isn't 1 GiB hugepages support at least being worked on[1]?
> >=20
> > That's for radix mode.  Hash mode has 16MiB and 16GiB, no 1GiB.
>=20
> So, I've spent some more time trying to wrap my head around the
> whole ordeal I'm still unclear about some of the details, though;
> hopefully you'll be willing to answer a few more questions.
>=20
> Basically the only page sizes you can have for HPT guests are
> 4 KiB, 64 KiB, 16 MiB and 16 GiB; in each case, for KVM, you need
> the guest memory to be backed by host pages which are at least as
> big, or it won't work. The same limitation doesn't apply to either
> RPT or TCG guests.

That's right.  The limitation also doesn't apply to KVM PR, just KVM
HV.

[If you're interested, the reason for the limitation is that unlike
 x86 or POWER9 there aren't separate sets of gva->gpa and gpa->hpa
 pagetables. Instead there's just a single gva->hpa (hash) pagetable
 that's managed by the _host_.  When the guest wants to create a new
 mapping it uses an hcall to insert a PTE, and the hcall
 implementation translates the gpa into an hpa before inserting it
 into the HPT.  The full contents of the real HPT aren't visible to
 the guest, but the precise slot numbers within it are, so the
 assumption that there's an exact 1:1 correspondence between guest
 PTEs and host PTEs is pretty much baked into the PAPR interface.  So,
 if a hugepage is to be inserted into the guest HPT, then it's also
 being inserted into the host HPT, and needs to be really, truly host
 contiguous]

> The new parameter would make it possible to make sure you will
> actually be able to use the page size you're interested in inside
> the guest, by preventing it from starting at all if the host didn't
> provide big enough backing pages;

That's right

> it would also ensure the guest
> gets access to different page sizes when running using TCG as an
> accelerator instead of KVM.

Uh.. it would ensure the guest *doesn't* get access to different page
sizes in TCG vs. KVM.  Is that what you meant to say?

> For a KVM guest running on a POWER8 host, the matrix would look
> like
>=20
>     b \ m | 64 KiB |  2 MiB | 16 MiB |  1 GiB | 16 GiB |
>   -------- -------- -------- -------- -------- --------
>    64 KiB | 64 KiB | 64 KiB |        |        |        |
>   -------- -------- -------- -------- -------- --------
>    16 MiB | 64 KiB | 64 KiB | 16 MiB | 16 MiB |        |
>   -------- -------- -------- -------- -------- --------
>    16 GiB | 64 KiB | 64 KiB | 16 MiB | 16 MiB | 16 GiB |
>   -------- -------- -------- -------- -------- --------
>=20
> with backing page sizes from top to bottom, requested max page
> sizes from left to right, actual max page sizes in the cells and
> empty cells meaning the guest won't be able to start; on a POWER9
> machine, the matrix would look like
>=20
>     b \ m | 64 KiB |  2 MiB | 16 MiB |  1 GiB | 16 GiB |
>   -------- -------- -------- -------- -------- --------
>    64 KiB | 64 KiB | 64 KiB |        |        |        |
>   -------- -------- -------- -------- -------- --------
>     2 MiB | 64 KiB | 64 KiB |        |        |        |
>   -------- -------- -------- -------- -------- --------
>     1 GiB | 64 KiB | 64 KiB | 16 MiB | 16 MiB |        |
>   -------- -------- -------- -------- -------- --------
>=20
> instead, and finally on TCG the backing page size wouldn't matter
> and you would simply have
>=20
>     b \ m | 64 KiB |  2 MiB | 16 MiB |  1 GiB | 16 GiB |
>   -------- -------- -------- -------- -------- --------
>           | 64 KiB | 64 KiB | 16 MiB | 16 MiB | 16 GiB |
>   -------- -------- -------- -------- -------- --------
>=20
> Does everything up until here make sense?

Yes, that all looks right.

> While trying to figure out this, one of the things I attempted to
> do was run a guest in POWER8 compatibility mode on a POWER9 host
> and use hugepages for backing, but that didn't seem to work at
> all, possibly hinting at the fact that not all of the above is
> actually accurate and I need you to correct me :)
>=20
> This is the command line I used:
>=20
>   /usr/libexec/qemu-kvm \
>   -machine pseries,accel=3Dkvm \
>   -cpu host,compat=3Dpower8 \
>   -m 2048 \
>   -mem-prealloc \
>   -mem-path /dev/hugepages \
>   -smp 8,sockets=3D8,cores=3D1,threads=3D1 \
>   -display none \
>   -no-user-config \
>   -nodefaults \
>   -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x2,drive=3Dvda \
>   -drive file=3D/var/lib/libvirt/images/huge.qcow2,format=3Dqcow2,if=3Dno=
ne,id=3Dvda \
>   -serial mon:stdio

Ok, so note that the scheme I'm talking about here is *not* merged as
yet.  The above command line will run the guest with 2MiB backing.

With the existing code that should work, but the guest will only be
able to use 64kiB pages.  If it didn't work at all.. there was a bug
fixed relatively recently that broke all hugepage backing, so you
could try updating to a more recent host kernel.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrhI5kACgkQbDjKyiDZ
s5LzVhAAvsNenn14uTWhOG1olbNg7+1CPhfEqwFBN39vnc2VpBIi7QepHPq71eu9
IAjCOu73NTbz+VihLmmYgiZRzstKHzXTz7xn2q6n8jkVUTdbOR8eoiv8h//VGuAq
uihgF99wIpPQTWn0i7xHMqdn3dblm0weI4OyuF2wfHvxDVCdSCvSIWijv2GoUUbJ
HhcvpyE7Jx8UUc7vA2AQoGFAJYgjwbA78ty89R3B2SnukW60Yo/WoIKXQSG80t4W
LPdDwqBUZiyXkClyUnLgxyWf5cWgLR68TD53QNFUucaa8wORiNQ6gW2pFb5tyi8b
Y3DTQ9dN5Ia238lzr/6/u86WzocDTxVUQz9RMe2JyO00HyKa/nlXUNOUsArskTyN
gchPQIAjB657LSaW8yMf8ICrJ3MhEqAGfFLWaXYd+oQ5/4oBAvIx892gWFaddh0H
MnPpVhoCfG4oMQd01h2aoR5g0johEZ8vd61k8iaOL2KCDfuzkL+2UtJ6vPUHj4dt
D8tJLegnAvuKr/SbEh0ngqCtubYbs1Zuj3vrwFHxV2s8ihM2iytHFVdcH6+gtQ7y
wJxfcyIvrG77BgCffX2d+JR9Q+bCyYrd51n2oLFecyWBIK5cF6ess3sWnuRg1m1e
KDDt5dsoUJ6DPWuvMTb6oYivlsZYreVB5CXXQ4UASSSlqpL6Yrc=
=YXYG
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
