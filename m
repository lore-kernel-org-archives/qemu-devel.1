Received: from eggs.gnu.org ([2001:4830:134:3::10]:57178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fAyx3-0003ab-MV
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 10:29:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fAyx2-0005A0-Jm
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 10:29:49 -0400
Date: Tue, 24 Apr 2018 16:29:15 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180424142915.GB4080@localhost.localdomain>
References: <20180419075232.31407-1-stefanha@redhat.com>
	<20180419075232.31407-3-stefanha@redhat.com>
	<20180419090546.GA2730@work-vm>
	<20180420030221.GC10319@stefanha-x1.localdomain>
	<20180420062513.GB4078@localhost.localdomain>
	<20180424140411.GB5120@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <20180424140411.GB5120@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 24.04.2018 um 16:04 hat Stefan Hajnoczi geschrieben:
> On Fri, Apr 20, 2018 at 08:25:13AM +0200, Kevin Wolf wrote:
> > Am 20.04.2018 um 05:02 hat Stefan Hajnoczi geschrieben:
> > > On Thu, Apr 19, 2018 at 10:05:47AM +0100, Dr. David Alan Gilbert wrot=
e:
> > > > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > > > This commit is for debugging only.  Do not merge it.
> > > > >=20
> > > > > mincore(2) checks whether pages are resident.  Use it to verify t=
hat
> > > > > page cache has been dropped.
> > > > >=20
> > > > > You can trigger a verification failure by mmapping the image file=
 from
> > > > > another process and loading a byte from a page so that it becomes
> > > > > resident.  bdrv_co_invalidate_cache() will fail while the process=
 is
> > > > > alive.
> > > >=20
> > > > It doesn't seem a bad diagnostic to keep in (with a switch to activ=
ate)
> > > > for when we're faced with some weird corruption on some weird stora=
ge
> > > > system.
> > >=20
> > > Okay.  It's very slow to mmap an entire image file and query mincore(=
2)
> > > so it needs to be off by default.
> >=20
> > Also, having it enabled breaks localhost migration at least on tmpfs
> > (which was what I tried out first).
> >=20
> > I wonder if the kernel would add some way to query whether the "advice"
> > was actually acted upon if we asked. Either with a new function that
> > returns an error if not everything is dropped (basically
> > .bdrv_invalidate_cache on the kernel level), or a function that just
> > queries if any page is allocated (or maybe the address of the first
> > allocated page in a given range) without having to use mincore() and
> > iterating over all the pages in userspace.
>=20
> I'm trying to figure out how to expose the optional mincore check on the
> command-line/QMP:
>=20
> 1. Add a check_consistency bool argument to bdrv_invalidate_cache*().
>    Add command-line/QMP option to -incoming and migrate_incoming.  This
>    is messy and won't be easy to access for libvirt users.
>=20
> 2. Add a BlockdevOptionsFile *check-cache-consistency bool field.  This
>    is specified at .bdrv_open() time.  It can be changed at runtime with
>    .bdrv_reopen*().
>=20
> 3. Add a 'blockdev-check-cache-consistency' QMP command that calls a new
>    .bdrv_check_cache_consistency() callback that is implemented by
>    file-posix.c.  The problem is users might issue this command after
>    I/O has resumed and pages have become resident again.  It only makes
>    sense if the guest is still paused.  Probably a bad interface...
>=20
> Have I missed a good way to expose this optional check functionality?
>=20
> Which approach do you prefer?  I'm leaning towards #2.

Yes, I think that makes the most sense.

In its current form, this can probably only be a debugging feature,
though, so maybe x-check-cache-consistency? I also don't think libvirt
should mess with this.

Kevin

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJa3z87AAoJEH8JsnLIjy/Wxj8P/AiZyDPBKMKIg1dAS0uGsYKJ
zeKNKVJ6vMHzwE8CN9BDcDcHSphJZI22qUt4PtkeXuumfHYET/WGl9RQ+vVDzjsH
s+WFEqo261SWtmW1TywOZ4UxujZHXlDv4I4ntOBH80rGoFJjQRoIFYG3t6Spjmt8
n+G32eea64cdGYbQlt9MXq6+LfOKx9W2HiaK4KQMNS7UmUofzykhT8nWOzYoXj8i
rWTVC+Ky3vade9Yi02vOl+yO0JvzExjsec/JCi0rnoi597Ihg4rIVwYuC7jCxEqC
l2QSsynoA1PYexEDlNmINNhY7xPLBF6KhamKI8wTHwr0Hshy2zZ8rC7/PcCkh+MN
IwP310NfVzhofVk2uDjJbFLUY1qg4iHTz/Jz6MJ2bNYyDpEylr3zQ4pyiplfkco+
CFSLt4yjW1aiTAEW5BYuqOzLs72VAhZxdsNgA3bgwCBFT80XtLAyZwaamRwxC5W8
UXk/QjPopAfbMY2raVQUXV7QAp9bVGh2kfh0YRWobIvTAfOyZyJKStrJlhHZfuW4
ZpLxEIeIeTJwOQ+F4AiOCtjqE4p7Oq1XogpuS87dr/mBLhG2r3mSQxg2tzXnMbdD
W2cnmjMoGLIxFOAXfjLf6/B/bBdUZa27BhpcFQ1PZz9kNQo1au5YVtYQNer7Pz5r
Z5ZZqsileneowyJUcVU7
=RuvR
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
