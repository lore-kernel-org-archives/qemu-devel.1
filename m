Received: from eggs.gnu.org ([2001:4830:134:3::10]:55625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gU37T-00025k-Ih
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 00:19:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gU37R-0007Pc-L6
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 00:19:39 -0500
Date: Tue, 4 Dec 2018 15:26:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181204042629.GI1682@umbus.fritz.box>
References: <20181012032431.32693-1-david@gibson.dropbear.id.au>
	<20181012032431.32693-2-david@gibson.dropbear.id.au>
	<20181012140306-mutt-send-email-mst@kernel.org>
	<996ed901-14b6-7461-a094-771a715cd6b2@redhat.com>
	<20181015063430-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="so9zsI5B81VjUb/o"
Content-Disposition: inline
In-Reply-To: <20181015063430-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [RFC 1/5] virtio-balloon: Remove unnecessary
 MADV_WILLNEED on deflate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, dhildenb@redhat.com, imammedo@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--so9zsI5B81VjUb/o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 06:43:06AM -0400, Michael S. Tsirkin wrote:
> On Mon, Oct 15, 2018 at 08:54:27AM +0200, David Hildenbrand wrote:
> > On 12/10/2018 20:05, Michael S. Tsirkin wrote:
> > > On Fri, Oct 12, 2018 at 02:24:27PM +1100, David Gibson wrote:
> > >> When the balloon is inflated, we discard memory place in it using ma=
dvise()
> > >> with MADV_DONTNEED.  And when we deflate it we use MADV_WILLNEED, wh=
ich
> > >> sounds like it makes sense but is actually unnecessary.
> > >>
> > >> The misleadingly named MADV_DONTNEED just discards the memory in que=
stion,
> > >> it doesn't set any persistent state on it in-kernel; all that's nece=
ssary
> > >> to bring the memory back is to touch it.  MADV_WILLNEED in contrast
> > >> specifically says that the memory will be used soon and faults it in.
> > >>
> > >> Memory that's being given back to the guest by deflating the balloon
> > >> *might* be used soon, but it equally could just sit around in the gu=
est's
> > >> pools until it actually needs it.  And, over the general timescale t=
hat
> > >> memory ballooning operates, it seems unlikely that one extra fault f=
or the
> > >> guest will be a vast performance issue.
> > >=20
> > > Thinking about it, it might be for RT guests.
> > >=20
> > > So I suspect if you want to drop MADV_WILLNEED you need a flag
> > > telling qemu that's not the usecase.
> > >=20
> >=20
> > As far as I know RT guests
> >=20
> > 1. mlock all memory
> > 2. use huge pages
> >=20
> > "MADV_DONTNEED cannot be applied to locked pages, Huge TLB pages, or
> > VM_PFNMAP pages."
> >=20
> > As DONTNEED never succeeded, WILLNEED will do nothing. (e.g. postcopy
> > temporarily has to unlock all memory in order to make DONTNEED work)
>=20
>=20
> Hmm you are right.
> Document this in commit log?
>=20
>=20
> > (And "Expect access in the near future." does not sound like guarantees
> > to me either way)
>=20
> Should we be concerned about impact on performance though?
>=20
> Thinking aloud it might have an impact.  But there is also a benefit.
> Let's document known effects so people know what to look for
> if they see issues?

Ok, my new text in the commit message is:

This patch simplify's the balloon operation by dropping the madvise()      =
                            =20
on deflate.  This might have an impact on performance - it will move a     =
                            =20
delay at deflate time until that memory is actually touched, which         =
                            =20
might be more latency sensitive.  However:                                 =
                            =20
                                                                           =
                            =20
  * Memory that's being given back to the guest by deflating the           =
                            =20
    balloon *might* be used soon, but it equally could just sit around     =
                            =20
    in the guest's pools until needed (or even be faulted out again if     =
                            =20
    the host is under memory pressure).                                    =
                            =20
                                                                           =
                            =20
  * Usually, the timescale over which you'll be adjusting the balloon      =
                            =20
    is long enough that a few extra faults after deflation aren't          =
                            =20
    going to make a difference.                          =20

Does that seem like it covers what it should?

> 	WILLNEED aggressively faults all memory in, removing it
> 	will cause just as much memory as needed to be allocated on access,
> 	slowing down the CPU at that point but conserving host memory.
>=20
> 	With this patch device assignment (e.g. with VFIO) hotplug will take lon=
ger
> 	as it needs to allocate all this memory on hotplug.
> 	While this happens all VM is paused right now.

I'm not sure what you mean by this.  This patch is very specific to
the virtio-balloon deflate path.  "True" memory hotplug (e.g. via ACPI
or PAPR dynamic reconfiguration) is unaffected.  And if VFIO is in
play, all guest memory will generally be locked, just like with
realtime.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--so9zsI5B81VjUb/o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwGAfIACgkQbDjKyiDZ
s5Ktpg/8CjgvVUz2cacFEKaBDQ9XGeMmLgNBI25ntpfE2JbH3JLFIjzYCBD6Vm94
tlHMPeWGdZ5OXSq7Pmv3hvVbWuzVhdv0VOufYhkszXIlc8H/jsP5MPo0fzSwtVhS
umyVNCVhbVMVYxsX3eOCZbg7hcuk8QA+/FCkx4Dal12VUm2/twfRto5NFFRhvUZr
SLE1a0mh2/BS0P9ioM3FyQKXtzOMlAx6uw3sL2dCLyM7jusDmr6vwBaSGx27ZxcH
IcoUum7lff308LUtV8CYNJw2gx9AL+zQ7aLEBK14kmlHBT6iiBsrZeDMns1sqy4/
knNC6T1RP8Iqo+ReFxj/A7H+ILfZTi5FVOfPSMjuTGE8fT5dlZuGhH3xljvxaadQ
CTBw345NbCNRC9qNq5koUv5z5tc7aY5T5zpj56n8P+yHYxAAilt38giPf/bfX7ZI
Agliw1mswKvbEEWuxxvCUOJiBv0EAA4b24QNsS6rEzg7FJKHv0HNMdaxayu0/gGe
w8dpwjbSMXXJYuvxd/bjc4DXB7KMSuOBgWOFT4nf8RjsvFKPhXUKfpkPckp6EVpP
sdRcElXgX/1bWwVGGkIiOy9b89Au1gfL9XEOG8vnGDqDcJHvB4hGNrO1gPZ0FA6O
IT01QZaHraGuX0/3PdbJfw3x9XZQFNjU7toAWB/x+xQXa+JZNgo=
=ylLt
-----END PGP SIGNATURE-----

--so9zsI5B81VjUb/o--
