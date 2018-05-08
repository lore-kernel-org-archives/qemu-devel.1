Received: from eggs.gnu.org ([2001:4830:134:3::10]:43401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fG08k-00073e-Su
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:46:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fG08j-0004np-Tz
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:46:38 -0400
Date: Tue, 8 May 2018 12:46:23 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180508104623.GA4065@localhost.localdomain>
References: <20180427162312.18583-1-stefanha@redhat.com>
	<20180508103232.GI19710@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <20180508103232.GI19710@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 0/2] block/file-posix:
 allow -drive cache.direct=off live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, Fam Zheng <famz@redhat.com>, Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 08.05.2018 um 12:32 hat Stefan Hajnoczi geschrieben:
> On Fri, Apr 27, 2018 at 05:23:10PM +0100, Stefan Hajnoczi wrote:
> > v2:
> >  * Add comment on !__linux__ situation [Fam]
> >  * Add file-posix.c x-check-cache-dropped=3Don|off option [DaveG, Kevin]
> >=20
> > file-posix.c only supports shared storage live migration with -drive
> > cache.direct=3Doff due to cache consistency issues.  There are two main=
 shared
> > storage configurations: files on NFS and host block devices on SAN LUNs.
> >=20
> > The problem is that QEMU starts on the destination host before the sour=
ce host
> > has written everything out to the disk.  The page cache on the destinat=
ion host
> > may contain stale data read when QEMU opened the image file (before mig=
ration
> > handover).  Using O_DIRECT avoids this problem but prevents users from =
taking
> > advantage of the host page cache.
> >=20
> > Although cache=3Dnone is the recommended setting for virtualization use=
 cases,
> > there are scenarios where cache=3Dwriteback makes sense.  If the guest =
has much
> > less RAM than the host or many guests share the same backing file, then=
 the
> > host page cache can significantly improve disk I/O performance.
> >=20
> > This patch series implements .bdrv_co_invalidate_cache() for block/file=
-posix.c
> > on Linux so that shared storage live migration works.  I have sent it a=
s an RFC
> > because cache consistency is not binary, there are corner cases which I=
've
> > described in the actual patch, and this may require more discussion.
> >=20
> > Regarding NFS, QEMU relies on O_DIRECT rather than the close-to-open
> > consistency model (see nfs(5)), which is the basic guarantee provided b=
y NFS.
> > After this patch cache consistency is no longer provided by O_DIRECT.
> >=20
> > This patch series relies on fdatasync(2) (source) +
> > posix_fadvise(POSIX_FADV_DONTNEED) (destination) instead.  I believe it=
 is safe
> > for both NFS and SAN LUNs.  Maybe we should use fsync(2) instead of
> > fdatasync(2) so that NFS has up-to-date inode metadata?
> >=20
> > Stefan Hajnoczi (2):
> >   block/file-posix: implement bdrv_co_invalidate_cache() on Linux
> >   block/file-posix: add x-check-page-cache=3Don|off option
> >=20
> >  qapi/block-core.json |   7 ++-
> >  block/file-posix.c   | 146 +++++++++++++++++++++++++++++++++++++++++++=
+++++++-
> >  2 files changed, 150 insertions(+), 3 deletions(-)
>=20
> Kevin: Are you happy with this series?

Yes, I think I am.

I'm still kind of concerned about misleading people into believing that
cache=3Dwriteback + live migration is generally safe when it's only in
special cases, but that's not really a concern about the code, but about
how we communicate the feature.

Kevin

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJa8X//AAoJEH8JsnLIjy/WCS0P/1AdQjepzUNrMRnAqwdbTuJu
u+Wm47AT0MvGj1ZOZWm5IJ269q2dZBx/OFsEHXrA5+ZWP+v/SSYiNc3Hf56LcBkd
UiMxqCUOsG4IdlCGDcqMRHWeCOQhOafQyVad+VFhXfNUKXTd0qzbykvJ3PfO9NQ3
k/LrnVntXzszJJEdzAgQTDZhfLLsAJXuup4vnyopDOha7FcOOGAfvlcORmjhLRAM
JUZxa4+Wqlu54SnMJyUyqKmnHT+D/74PrjY5Gtd46wCYN+G/S8srXubxQ0LE68fI
GXqJfGTsCjv01pBvUWnf8U0aK2DIbMh3GkcEn8dj7OTH9UGXHWY0jPBkE7bBkVJT
SObvFZERX7YDEgsiP4WwPRrstTm7y4obJ3itdnVoyA03buNFT2BrK1YZb5FAMwe1
eLV4WH06vIO2NPbYGNGvTUDOdVo88SEcBdRRi3jdEg2fwdrkTTveGONRqkHRoqSw
KfT0WpVrWL2ldZWtBuBwSC43R6qeKRVZY6eM/yM0jztUoKXnO9D8bgC+MBn5Hj1Y
4OzVjsmQ++ysToKjdmNdTX/eB19Zr5m3hsEJyR98h2oRxXDJtH4gBDsIdgd/dHiT
KnwDiAACDVbyAEkkCsFz/thYhsJXYAVhuOi88A1WJygkYxmEOv2UUIbMDdmEPKXG
05XuDW07JCRNMI4ySOlA
=GtBt
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
