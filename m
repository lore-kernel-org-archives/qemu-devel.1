Received: from eggs.gnu.org ([2001:4830:134:3::10]:51087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f9PU9-0006S1-2l
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 02:25:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f9PU7-0002Nv-PB
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 02:25:28 -0400
Date: Fri, 20 Apr 2018 08:25:13 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180420062513.GB4078@localhost.localdomain>
References: <20180419075232.31407-1-stefanha@redhat.com>
	<20180419075232.31407-3-stefanha@redhat.com>
	<20180419090546.GA2730@work-vm>
	<20180420030221.GC10319@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline
In-Reply-To: <20180420030221.GC10319@stefanha-x1.localdomain>
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


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 20.04.2018 um 05:02 hat Stefan Hajnoczi geschrieben:
> On Thu, Apr 19, 2018 at 10:05:47AM +0100, Dr. David Alan Gilbert wrote:
> > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > This commit is for debugging only.  Do not merge it.
> > >=20
> > > mincore(2) checks whether pages are resident.  Use it to verify that
> > > page cache has been dropped.
> > >=20
> > > You can trigger a verification failure by mmapping the image file from
> > > another process and loading a byte from a page so that it becomes
> > > resident.  bdrv_co_invalidate_cache() will fail while the process is
> > > alive.
> >=20
> > It doesn't seem a bad diagnostic to keep in (with a switch to activate)
> > for when we're faced with some weird corruption on some weird storage
> > system.
>=20
> Okay.  It's very slow to mmap an entire image file and query mincore(2)
> so it needs to be off by default.

Also, having it enabled breaks localhost migration at least on tmpfs
(which was what I tried out first).

I wonder if the kernel would add some way to query whether the "advice"
was actually acted upon if we asked. Either with a new function that
returns an error if not everything is dropped (basically
=2Ebdrv_invalidate_cache on the kernel level), or a function that just
queries if any page is allocated (or maybe the address of the first
allocated page in a given range) without having to use mincore() and
iterating over all the pages in userspace.

Kevin

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJa2YfJAAoJEH8JsnLIjy/W7YcP/RbPrB6gdiGmQdiuROmsaJ+E
Uysj7L/Vbgv4YxQV+KSDQOw0VSmQ2GUNt5/jU7Gd6OrCr9p0gFwfOh6cIP8g6PMP
eH/NFHPaWlYWuZg32UfMkUEkbjY1rT8H2nDOdH9Ip58Wm6Cz3J4XngXmCU0yBY0V
ty72ueeKaKwSmDMatsGhlY4vNWagoxvj0ZE8r0UtgK83UM9zhWqNR89qJEwhYOYn
OOLBoXDxYPOcFz7YhE1doHf3HhauK1Iue2tkrMigmxEAsJ9B74CvhMMzxmqAeZQD
p3vj9Nvru2Up4TpAHT7ayE2D2M+9gfEdOWLzjfvC2FseN+Q0Nqmwor1J0duM4a0Q
/fXf2zMAzqyx8/cEW3InX5SYm7yT4PQwwzMn2qxfRc3I5hJjlxvZwrHL6X1TKQ+x
6QeW+avmvxvY0mffpPhrlLXfukv9DIhztKe3fbK/yQb0aB6c6P4lVZUJUu42sKQA
QBt8fX4hedy0rfoAdehTcuQ1DgwpmpzXJNswg+lRjmxLhYgoqmVz5VjYftMT4Y6u
j1HV+YbMxChwUCXp5f000Jn8ZsxDQZzdhwon2rrn2+CE1fqpX1joYENk6l+5NEpG
iR7oMFomzvqKHO2wtg0Mry6AisqG/NCSl9kV8gciImg8ngvj7XxbAUv6WpSSUteN
5gFVj0jwcU57r7psqDhE
=p9/H
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
