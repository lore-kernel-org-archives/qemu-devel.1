Received: from eggs.gnu.org ([2001:4830:134:3::10]:43186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fC2Oq-0001Z4-Pp
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:22:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fC2Op-0002aV-NQ
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:22:52 -0400
Date: Fri, 27 Apr 2018 11:06:08 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180427100608.GB6999@stefanha-x1.localdomain>
References: <20180419075232.31407-1-stefanha@redhat.com>
	<20180419075232.31407-3-stefanha@redhat.com>
	<20180419090546.GA2730@work-vm>
	<20180420030221.GC10319@stefanha-x1.localdomain>
	<20180420062513.GB4078@localhost.localdomain>
	<20180424140411.GB5120@stefanha-x1.localdomain>
	<20180424142915.GB4080@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline
In-Reply-To: <20180424142915.GB4080@localhost.localdomain>
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


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2018 at 04:29:15PM +0200, Kevin Wolf wrote:
> Am 24.04.2018 um 16:04 hat Stefan Hajnoczi geschrieben:
> > On Fri, Apr 20, 2018 at 08:25:13AM +0200, Kevin Wolf wrote:
> > > Am 20.04.2018 um 05:02 hat Stefan Hajnoczi geschrieben:
> > > > On Thu, Apr 19, 2018 at 10:05:47AM +0100, Dr. David Alan Gilbert wr=
ote:
> > > > > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > > > > This commit is for debugging only.  Do not merge it.
> > > > > >=20
> > > > > > mincore(2) checks whether pages are resident.  Use it to verify=
 that
> > > > > > page cache has been dropped.
> > > > > >=20
> > > > > > You can trigger a verification failure by mmapping the image fi=
le from
> > > > > > another process and loading a byte from a page so that it becom=
es
> > > > > > resident.  bdrv_co_invalidate_cache() will fail while the proce=
ss is
> > > > > > alive.
> > > > >=20
> > > > > It doesn't seem a bad diagnostic to keep in (with a switch to act=
ivate)
> > > > > for when we're faced with some weird corruption on some weird sto=
rage
> > > > > system.
> > > >=20
> > > > Okay.  It's very slow to mmap an entire image file and query mincor=
e(2)
> > > > so it needs to be off by default.
> > >=20
> > > Also, having it enabled breaks localhost migration at least on tmpfs
> > > (which was what I tried out first).
> > >=20
> > > I wonder if the kernel would add some way to query whether the "advic=
e"
> > > was actually acted upon if we asked. Either with a new function that
> > > returns an error if not everything is dropped (basically
> > > .bdrv_invalidate_cache on the kernel level), or a function that just
> > > queries if any page is allocated (or maybe the address of the first
> > > allocated page in a given range) without having to use mincore() and
> > > iterating over all the pages in userspace.
> >=20
> > I'm trying to figure out how to expose the optional mincore check on the
> > command-line/QMP:
> >=20
> > 1. Add a check_consistency bool argument to bdrv_invalidate_cache*().
> >    Add command-line/QMP option to -incoming and migrate_incoming.  This
> >    is messy and won't be easy to access for libvirt users.
> >=20
> > 2. Add a BlockdevOptionsFile *check-cache-consistency bool field.  This
> >    is specified at .bdrv_open() time.  It can be changed at runtime with
> >    .bdrv_reopen*().
> >=20
> > 3. Add a 'blockdev-check-cache-consistency' QMP command that calls a new
> >    .bdrv_check_cache_consistency() callback that is implemented by
> >    file-posix.c.  The problem is users might issue this command after
> >    I/O has resumed and pages have become resident again.  It only makes
> >    sense if the guest is still paused.  Probably a bad interface...
> >=20
> > Have I missed a good way to expose this optional check functionality?
> >=20
> > Which approach do you prefer?  I'm leaning towards #2.
>=20
> Yes, I think that makes the most sense.
>=20
> In its current form, this can probably only be a debugging feature,
> though, so maybe x-check-cache-consistency? I also don't think libvirt
> should mess with this.

Cool, I will implement this.

Stefan

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa4vYQAAoJEJykq7OBq3PIPugH+wYWvgOVrwAOqiL3HHEcC0+4
2m49vVPAeTGE9GnNhPj/43sRtYZFVjuyBC5WyQ2NuKhHnMj7JxD6+hYnU0suwfEb
ij2Yf6YF9kQSi/4sbjPU8PViaLWXGpM6YzRMspGshDGVPWX70YbWKivX1Conbblm
UptPweu7ygBsaNl+yNoDgYjFPQAEFExCLzf444/Putv61iFFy3U4vE7N5Y6NQuOh
5bQ7GPfQHf61CicA7C/faXHz9hOvlqY3e4XbeArPxaRdCK7PJj5SbV16IoQ+PoAJ
OxRFB+qSKgIeWf79eAwk7LXa8UPhxxebsf88NGL8IVLrRnDHhx9g/N+IMflGRYA=
=KE64
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--
