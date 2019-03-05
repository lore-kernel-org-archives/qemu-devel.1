Received: from eggs.gnu.org ([209.51.188.92]:53187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h12EW-0005Ue-0s
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 00:03:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h12ET-0008TH-06
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 00:03:14 -0500
Date: Tue, 5 Mar 2019 16:03:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190305050300.GI7877@umbus.fritz.box>
References: <20190214043916.22128-1-david@gibson.dropbear.id.au>
	<20190214043916.22128-2-david@gibson.dropbear.id.au>
	<20190228083317-mutt-send-email-mst@kernel.org>
	<20190305005207.GA7877@umbus.fritz.box>
	<20190304211451-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y96v7rNg6HAoELs5"
Content-Disposition: inline
In-Reply-To: <20190304211451-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH 1/5] virtio-balloon: Remove unnecessary
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>


--y96v7rNg6HAoELs5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2019 at 09:29:24PM -0500, Michael S. Tsirkin wrote:
> On Tue, Mar 05, 2019 at 11:52:08AM +1100, David Gibson wrote:
> > On Thu, Feb 28, 2019 at 08:36:58AM -0500, Michael S. Tsirkin wrote:
> > > On Thu, Feb 14, 2019 at 03:39:12PM +1100, David Gibson wrote:
> > > > When the balloon is inflated, we discard memory place in it using m=
advise()
> > > > with MADV_DONTNEED.  And when we deflate it we use MADV_WILLNEED, w=
hich
> > > > sounds like it makes sense but is actually unnecessary.
> > > >=20
> > > > The misleadingly named MADV_DONTNEED just discards the memory in qu=
estion,
> > > > it doesn't set any persistent state on it in-kernel; all that's nec=
essary
> > > > to bring the memory back is to touch it.  MADV_WILLNEED in contrast
> > > > specifically says that the memory will be used soon and faults it i=
n.
> > > >=20
> > > > This patch simplify's the balloon operation by dropping the madvise=
()
> > > > on deflate.  This might have an impact on performance - it will mov=
e a
> > > > delay at deflate time until that memory is actually touched, which
> > > > might be more latency sensitive.  However:
> > > >=20
> > > >   * Memory that's being given back to the guest by deflating the
> > > >     balloon *might* be used soon, but it equally could just sit aro=
und
> > > >     in the guest's pools until needed (or even be faulted out again=
 if
> > > >     the host is under memory pressure).
> > > >=20
> > > >   * Usually, the timescale over which you'll be adjusting the ballo=
on
> > > >     is long enough that a few extra faults after deflation aren't
> > > >     going to make a difference.
> > > >=20
> > > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > > Reviewed-by: David Hildenbrand <david@redhat.com>
> > > > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > >=20
> > > I'm having second thoughts about this. It might affect performance but
> > > probably won't but we have no idea.  Might cause latency jitter after
> > > deflate where it previously didn't happen.  This kind of patch should
> > > really be accompanied by benchmarking results, not philosophy.
> >=20
> > I guess I see your point, much as it's annoying to spend time
> > benchmarking a device that's basically broken by design.
>=20
> Because of 4K page thing?

For one thing.  I believe David H has bunch of other reasons.

> It's an annoying bug for sure.  There were
> patches to add a feature bit to just switch to plan s/g format, but they
> were abandoned. You are welcome to revive them though.
> Additionally or alternatively, we can easily add a field specifying
> page size.

We could, but I'm pretty disinclined to work on this when virtio-mem
is a better solution in nearly every way.

> > That said.. I don't really know how I'd go about benchmarking it.  Any
> > guesses at a suitable workload which would be most likely to show a
> > performance degradation here?
>=20
> Here's one idea - I tried to come up with a worst case scenario here.
> Basically based on idea by Alex Duyck. All credits are his, all bugs are
> mine:

Ok.  I'll try to find time to implement this and test it.

> Setup:
> Memory-15837 MB
> Guest Memory Size-5 GB
> Swap-Disabled
> Test Program-Simple program which allocates 4GB memory via malloc, touche=
s it via memset and exits.
> Use case-Number of guests that can be launched completely including the s=
uccessful execution of the test program.
> Procedure:
> Setup:
> A first guest is launched and once its console is up,
> test allocation program is executed with 4 GB memory request (Due to
> this the guest occupies almost 4-5 GB of memory in the host)
> Afterwards balloon is inflated by 4Gbyte in the guest.
> We continue launching the guests until a guest gets
> killed due to low memory condition in the host.
>=20
>=20
> Now repeatedly, in each guest in turn, balloon is deflated and
> test allocation program is executed with 4 GB memory request (Due to
> this the guest occupies almost 4-5 GB of memory in the host)
> After program finishes balloon is inflated by 4GB again.
>=20
> Then we switch to another guest.
>=20
> Time how many cycles of this we can do.
>=20
>=20
> Hope this helps.
>=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--y96v7rNg6HAoELs5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx+AwQACgkQbDjKyiDZ
s5IVHhAAm/wRMSXDrGCVM21vrIsT0VuUCQRTiUt8R7pDFuJo9/pojyuxeuUue+WC
QZ2SGofel0npecK8J4GeALsMRIIMS7YqczlhmuHVn9JYTnsFeC2DNUfDlguSZ2nm
R7npagi0q+iZVq3vEZ8EGEapXXGJwXKIh7RrkXCxgPdM3+k0WnzPsCYQ7sIo8Hws
LS9yk9khT5PCrFNtSwiIwf5f1PvM1frtwz6MNX1LON0dEoQpqKPAdRIlH1qOph4j
ZIPNgCXkZVn+MSj9w2c6+/UMIEAzRkUk+qHgJha30AVtOAxY5TGItWtwIhijV4gN
dALM0nEJLpQ8oqgLCSFrDTsxbIvgUXSw/+iwcnh7g8z1TpasDH2wwOAIhCAd9rrC
QWEMFhwqbOVHISiL4MarA5wTe9LMF0NMslyfKT7Bjm8d2/eF5KyXJMDP8l9EAQtW
qmsTHpvIL9XsmcgIfMGcrKE7sc+w56LYc8qgK7GrV1WHPcWB+57TNf9WO3nb0m5U
TsxIUgxcifdwWxi/dPlwfq5+DeLy4KRRj5iCuyHTISOdJgZv2qQYYVVkUtAeOS2t
jhaOk9zb3199gs+zszhw9ZhHNJ7ZMkWcRXTxPT7f5IG0hNdUyHUU/o9JTnCc9mad
IgNTZezjxD7lM6GOvRa5FTuyFEiCqwABuMD99gAAA7CGMum5obk=
=ov6n
-----END PGP SIGNATURE-----

--y96v7rNg6HAoELs5--
