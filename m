Received: from eggs.gnu.org ([2001:4830:134:3::10]:51448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fAyYP-0003Ue-Ne
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 10:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fAyYO-00019t-Qo
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 10:04:21 -0400
Date: Tue, 24 Apr 2018 15:04:11 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180424140411.GB5120@stefanha-x1.localdomain>
References: <20180419075232.31407-1-stefanha@redhat.com>
	<20180419075232.31407-3-stefanha@redhat.com>
	<20180419090546.GA2730@work-vm>
	<20180420030221.GC10319@stefanha-x1.localdomain>
	<20180420062513.GB4078@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline
In-Reply-To: <20180420062513.GB4078@localhost.localdomain>
Subject: Re: [Qemu-devel] [RFC 2/2] block/file-posix: verify page cache is
 not used
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2018 at 08:25:13AM +0200, Kevin Wolf wrote:
> Am 20.04.2018 um 05:02 hat Stefan Hajnoczi geschrieben:
> > On Thu, Apr 19, 2018 at 10:05:47AM +0100, Dr. David Alan Gilbert wrote:
> > > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > > This commit is for debugging only.  Do not merge it.
> > > >=20
> > > > mincore(2) checks whether pages are resident.  Use it to verify that
> > > > page cache has been dropped.
> > > >=20
> > > > You can trigger a verification failure by mmapping the image file f=
rom
> > > > another process and loading a byte from a page so that it becomes
> > > > resident.  bdrv_co_invalidate_cache() will fail while the process is
> > > > alive.
> > >=20
> > > It doesn't seem a bad diagnostic to keep in (with a switch to activat=
e)
> > > for when we're faced with some weird corruption on some weird storage
> > > system.
> >=20
> > Okay.  It's very slow to mmap an entire image file and query mincore(2)
> > so it needs to be off by default.
>=20
> Also, having it enabled breaks localhost migration at least on tmpfs
> (which was what I tried out first).
>=20
> I wonder if the kernel would add some way to query whether the "advice"
> was actually acted upon if we asked. Either with a new function that
> returns an error if not everything is dropped (basically
> .bdrv_invalidate_cache on the kernel level), or a function that just
> queries if any page is allocated (or maybe the address of the first
> allocated page in a given range) without having to use mincore() and
> iterating over all the pages in userspace.

I'm trying to figure out how to expose the optional mincore check on the
command-line/QMP:

1. Add a check_consistency bool argument to bdrv_invalidate_cache*().
   Add command-line/QMP option to -incoming and migrate_incoming.  This
   is messy and won't be easy to access for libvirt users.

2. Add a BlockdevOptionsFile *check-cache-consistency bool field.  This
   is specified at .bdrv_open() time.  It can be changed at runtime with
   .bdrv_reopen*().

3. Add a 'blockdev-check-cache-consistency' QMP command that calls a new
   .bdrv_check_cache_consistency() callback that is implemented by
   file-posix.c.  The problem is users might issue this command after
   I/O has resumed and pages have become resident again.  It only makes
   sense if the guest is still paused.  Probably a bad interface...

Have I missed a good way to expose this optional check functionality?

Which approach do you prefer?  I'm leaning towards #2.

Stefan

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa3zlbAAoJEJykq7OBq3PIO5kIAJfcblwU+qzojcy4gJDuO7qz
MP58XHknbrPIbBC5rcsGnwpCbsTW2CPv1Dfr0xio/tnUEBe0pzRgqcudKy4gzyNz
YAY4Xqr/wlYuHKSHnL2b+/GSumIpoHD5TQdb8/b8WoO3lnDkPDIcFf6gMwpBtWm3
fqtYkjf1VRW0t1befnyNsL7nYCR4OASAe8ek477v0kSdlDBCzuAhfFA0nYitSHYd
LWD6gZqwaTi8xUv/Rx2UNwFT9dyS2ZLV74DZXFmQkUIVjqc7YTrBuib7MFNnw+vM
EuH1EJSnX/qzEuohQh2qq2kN0vQiGsp2RFJ84KlEhT5SN6his8S6Clb8WJllLKo=
=n5qY
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
