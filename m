Received: from eggs.gnu.org ([209.51.188.92]:42465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1Jq0-0003UY-VD
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 18:51:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1Jpy-00062A-9V
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 18:51:07 -0500
Date: Wed, 6 Mar 2019 10:35:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190305233512.GB19715@umbus.fritz.box>
References: <20190214043916.22128-1-david@gibson.dropbear.id.au>
	<20190214043916.22128-2-david@gibson.dropbear.id.au>
	<20190228083317-mutt-send-email-mst@kernel.org>
	<20190305005207.GA7877@umbus.fritz.box>
	<20190304211451-mutt-send-email-mst@kernel.org>
	<20190305050300.GI7877@umbus.fritz.box>
	<20190305094050-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <20190305094050-mutt-send-email-mst@kernel.org>
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


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2019 at 09:41:34AM -0500, Michael S. Tsirkin wrote:
> On Tue, Mar 05, 2019 at 04:03:00PM +1100, David Gibson wrote:
> > On Mon, Mar 04, 2019 at 09:29:24PM -0500, Michael S. Tsirkin wrote:
> > > On Tue, Mar 05, 2019 at 11:52:08AM +1100, David Gibson wrote:
> > > > On Thu, Feb 28, 2019 at 08:36:58AM -0500, Michael S. Tsirkin wrote:
> > > > > On Thu, Feb 14, 2019 at 03:39:12PM +1100, David Gibson wrote:
> > > > > > When the balloon is inflated, we discard memory place in it usi=
ng madvise()
> > > > > > with MADV_DONTNEED.  And when we deflate it we use MADV_WILLNEE=
D, which
> > > > > > sounds like it makes sense but is actually unnecessary.
> > > > > >=20
> > > > > > The misleadingly named MADV_DONTNEED just discards the memory i=
n question,
> > > > > > it doesn't set any persistent state on it in-kernel; all that's=
 necessary
> > > > > > to bring the memory back is to touch it.  MADV_WILLNEED in cont=
rast
> > > > > > specifically says that the memory will be used soon and faults =
it in.
> > > > > >=20
> > > > > > This patch simplify's the balloon operation by dropping the mad=
vise()
> > > > > > on deflate.  This might have an impact on performance - it will=
 move a
> > > > > > delay at deflate time until that memory is actually touched, wh=
ich
> > > > > > might be more latency sensitive.  However:
> > > > > >=20
> > > > > >   * Memory that's being given back to the guest by deflating the
> > > > > >     balloon *might* be used soon, but it equally could just sit=
 around
> > > > > >     in the guest's pools until needed (or even be faulted out a=
gain if
> > > > > >     the host is under memory pressure).
> > > > > >=20
> > > > > >   * Usually, the timescale over which you'll be adjusting the b=
alloon
> > > > > >     is long enough that a few extra faults after deflation aren=
't
> > > > > >     going to make a difference.
> > > > > >=20
> > > > > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > > > > Reviewed-by: David Hildenbrand <david@redhat.com>
> > > > > > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > > > >=20
> > > > > I'm having second thoughts about this. It might affect performanc=
e but
> > > > > probably won't but we have no idea.  Might cause latency jitter a=
fter
> > > > > deflate where it previously didn't happen.  This kind of patch sh=
ould
> > > > > really be accompanied by benchmarking results, not philosophy.
> > > >=20
> > > > I guess I see your point, much as it's annoying to spend time
> > > > benchmarking a device that's basically broken by design.
> > >=20
> > > Because of 4K page thing?
> >=20
> > For one thing.  I believe David H has bunch of other reasons.
> >=20
> > > It's an annoying bug for sure.  There were
> > > patches to add a feature bit to just switch to plan s/g format, but t=
hey
> > > were abandoned. You are welcome to revive them though.
> > > Additionally or alternatively, we can easily add a field specifying
> > > page size.
> >=20
> > We could, but I'm pretty disinclined to work on this when virtio-mem
> > is a better solution in nearly every way.
>=20
> Then one way would be to just let balloon be. Make it behave same as
> always and don't make changes to it :)

I'd love to, but it is in real world use, so I think we do need to fix
serious bugs in it - at least if they can be fixed on one side,
without needing to roll out both qemu and guest changes (which adding
page size negotiation would require).

>=20
> > > > That said.. I don't really know how I'd go about benchmarking it.  =
Any
> > > > guesses at a suitable workload which would be most likely to show a
> > > > performance degradation here?
> > >=20
> > > Here's one idea - I tried to come up with a worst case scenario here.
> > > Basically based on idea by Alex Duyck. All credits are his, all bugs =
are
> > > mine:
> >=20
> > Ok.  I'll try to find time to implement this and test it.
> >=20
> > > Setup:
> > > Memory-15837 MB
> > > Guest Memory Size-5 GB
> > > Swap-Disabled
> > > Test Program-Simple program which allocates 4GB memory via malloc, to=
uches it via memset and exits.
> > > Use case-Number of guests that can be launched completely including t=
he successful execution of the test program.
> > > Procedure:
> > > Setup:
> > > A first guest is launched and once its console is up,
> > > test allocation program is executed with 4 GB memory request (Due to
> > > this the guest occupies almost 4-5 GB of memory in the host)
> > > Afterwards balloon is inflated by 4Gbyte in the guest.
> > > We continue launching the guests until a guest gets
> > > killed due to low memory condition in the host.
> > >=20
> > >=20
> > > Now repeatedly, in each guest in turn, balloon is deflated and
> > > test allocation program is executed with 4 GB memory request (Due to
> > > this the guest occupies almost 4-5 GB of memory in the host)
> > > After program finishes balloon is inflated by 4GB again.
> > >=20
> > > Then we switch to another guest.
> > >=20
> > > Time how many cycles of this we can do.
> > >=20
> > >=20
> > > Hope this helps.
> > >=20
> > >=20
> > >=20
> >=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx/B7AACgkQbDjKyiDZ
s5KlbxAAmLUrYPdkcJ7QQyIfY3X0dWKNOWEcaMQPgvGROICkzzuZtQhVMkf7j7cu
2ep9VZNzKSVGfSmBJuPZmva0+jztGd8OlpfXWZpRe1oOH50AQo42lMv2XfaQo0DA
sLJAWW0VdbswR8T0/9Z4ujTjzNGhKNX+KAbtQHgIcEc/SPjPtGM8i1siX1mFPlXa
PzOhzOA5ZLiu8GwRjbC0cDIcXvfNS7QSASG2hRTN79rhUnKIldp8nUVyyZgs9pzq
ZF1dwUvqNm4K96lBC1a82qlI26noqQ+BPW3sDOU5X17KLPpY2p5bazQTh7jIdUq3
uXgmSeUPnjda76l+F5TfAu/OLHTMhRojZmqVXeU6qUyP/sLTet3ucn4P7RKlFgj3
YPqmX4p59cNRvLgsWxdPMa0kwGLqm4xbGnfLPPHrLT+ptz4VWCPy8cEu8AtDx7pA
2naDuOhpojH7zNMVZvRiDK7K+ewiny0js8lWhEsTjQzB8yim9fxxnw+34SCmzAhV
gQ3+PFi/n3luTmvRQkxCb5B4i9mU/mgi+gzeyF6gY2Jen5rRPMTik0vwPh7eudX5
Qdu9DIkFK/0EJ3zE3IhER8J1Ut3JJMuAMlzo9drVOUYqdBOhrzsnlZfTPAU00YC6
AxhSh2MFQkptJaFWruewy1z7R+QO5I0VXOy0QTqjNtV6UftGNfU=
=p/HW
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
