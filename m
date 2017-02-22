Received: from eggs.gnu.org ([2001:4830:134:3::10]:40554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cgW7d-0007iN-Om
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:34:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cgW7c-0008Nu-KK
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:34:17 -0500
Date: Wed, 22 Feb 2017 11:14:33 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170222111433.GA3386@stefanha-x1.localdomain>
References: <20170220165204.1980-1-stefanha@redhat.com>
	<w51tw7nbykn.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <w51tw7nbykn.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-options: explain disk I/O throttling
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, Nini Gu <ngu@redhat.com>, qemu-block@nongnu.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 21, 2017 at 11:58:00AM +0100, Alberto Garcia wrote:
> On Mon 20 Feb 2017 05:52:04 PM CET, Stefan Hajnoczi wrote:
> > The disk I/O throttling options have been listed for a long time but
> > never explained on the QEMU man page.
>=20
> > +@item bps=3D@var{b},bps_rd=3D@var{r},bps_wr=3D@var{w}
> > +Specify bandwidth throttling limits in bytes per second, either for al=
l request
> > +types or for reads or writes only.
>=20
> Perhaps for the manual page it makes sense to use them, but bps, bps_rd,
> etc. are the legacy names for those options. They're internally renamed
> to throttling.bps-total, throttling.bps-read, ...

I used the parameter names already listed in the -drive documentation.
We need to keep the legacy names but I will add another patch that
documents the new names and encourages using them.

> > Values must be larger than the maximum
> > +request size to avoid timeouts or hangs in the guest.  At minimum use =
2 MB/s
> > +for disks.
>=20
> Is this so? throttle_compute_wait() does not use the request size at
> all. The size is used to do the accounting afterwards. In other words:
> requests are not throttled if they exceed the limit, they are throttled
> after the limit has been exceeded by previous requests.
>=20
> A low limit will certainly slow down the guest and can cause
> timeouts, but I don't know if being larger or smaller than the maximum
> request size is what makes the difference.

You are right, I'm still have the behavior of the old throttling
implementation in mind.

I'd still like to recommend a sane minimum because anything around the
size of a single request leads to timeouts and hangs inside the guest.

How about:

  Small values can lead to timeouts or hangs inside the guest.  A safe
  minimum for disks is 2 MB/s.

> > +@item bps_max=3D@var{bm},bps_rd_max=3D@var{rm},bps_wr_max=3D@var{wm}
> > +Specify bursts in bytes per second, either for all request types or fo=
r reads
> > +or writes only.  Bursts allow the guest I/O to spike above the limit
> > +temporarily.  The default burst value is 1/10th of the limit.
>=20
> "The default burst value is 1/10th of the limit" is an implementation
> detail that the user doesn't need to know about. What it means is that a
> bps limit of 10 MB/s is implemented internally as 1MB per 100ms.
>
> I would leave that out, it doesn't even make sense that the burst limit
> is lower than the normal limit, we actually forbid that (aaa1e77ffae52).

Unfortunately the bps_max =3D avg / 10 default value is visible via
query-block.  A bug was recently reported about this:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1414630

Would you prefer a private field in the throttling code so this detail
is hidden from users?

> > +@item iops=3D@var{i},iops_rd=3D@var{r},iops_wr=3D@var{w}
> > +Specify request rate limits in requests per second, either for all req=
uest
> > +types or for reads or writes only.
>=20
> > +@item bps_max=3D@var{bm},bps_rd_max=3D@var{rm},bps_wr_max=3D@var{wm}
>=20
> You meant iops_max, iops_rd_max and iops_wr_max here?

Yes, thanks!  Will fix in v2.

Stefan

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrXKYAAoJEJykq7OBq3PI0AoH/2wrcez+inQcHVMsidaKc38J
NtyrywFupgnHLbLLiwvx2176soF1+HyjAxfEiQ0gUXFiI00r5lVeC+lkG2OkCPQE
SxAq+YpkoWBL4fZv3k6TQb44dctDJXvTC4Od+spofe6WH6DSp6GC3KVXl/jJRNGV
eDbRHe7WHkXe0aPoRBZvk6d0Vw9F0LkSvjFzd+ccOKeID/It081PVeQ9Dj9YcKj7
d3GieNpEwuwc1rk8ufIT7ijswwzpvxXBNrsu/EfSS75T/K9IpHwUoySCqdT479Cx
7Gy+UFGQOmPvgrZAMDjqIql6Hpk7RHgYVDdQJRc+LWXpNvwPnR+KBxaWcX+z0LE=
=W76o
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
