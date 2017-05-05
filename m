Received: from eggs.gnu.org ([2001:4830:134:3::10]:49858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6aQy-0004cT-M4
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6aQv-0001KV-Az
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:26:00 -0400
Date: Fri, 5 May 2017 11:25:50 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170505102550.GA11350@stefanha-x1.localdomain>
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-15-pbonzini@redhat.com>
	<20170504145906.GR32376@stefanha-x1.localdomain>
	<a60d65e8-fff3-dbe3-7357-38095a91e83a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <a60d65e8-fff3-dbe3-7357-38095a91e83a@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 14/17] block: optimize access
 to reqs_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2017 at 06:06:39PM +0200, Paolo Bonzini wrote:
> On 04/05/2017 16:59, Stefan Hajnoczi wrote:
> > On Thu, Apr 20, 2017 at 02:00:55PM +0200, Paolo Bonzini wrote:
> >> Hot path reqs_lock critical sections are very small; the only large cr=
itical
> >> sections happen when a request waits for serialising requests, and the=
se
> >> should never happen in usual circumstances.
> >>
> >> We do not want these small critical sections to yield in any case,
> >> which calls for using a spinlock while writing the list.
> >=20
> > Is this patch purely an optimization?
>=20
> Yes, it is, and pretty much a no-op until we have true multiqueue.  But
> I expect it to have a significant effect for multiqueue.
>=20
> > I'm hesitant about using spinlocks in userspace.  There are cases where
> > the thread is descheduled that are beyond our control.  Nested virt will
> > probably make things worse.  People have been optimizing and trying
> > paravirt approaches to kernel spinlocks for these reasons for years.
>=20
> This is true, but here we're talking about a 5-10 instruction window for
> preemption; it matches the usage of spinlocks in other parts of QEMU.

Only util/qht.c uses spinlocks, it's not a widely used primitive.

> The long critical sections, which only happen with combination with
> copy-on-read or RMW (large logical block sizes on the host), take the
> CoMutex.
>=20
> On one hand it's true that the more you nest, the more things get worse.
>  On the other hand there can only ever be contention with multiqueue,
> and the multiqueue scenarios are going to use pinning.
>=20
> > Isn't a futex-based lock efficient enough?  That way we don't hog the
> > CPU when there is contention.
>=20
> It is efficient when there is no contention, but when there is, the
> latency goes up by several orders of magnitude.

Doesn't glibc spin for a while before waiting on the futex?  i.e. the
best of both worlds.

Stefan

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZDFMuAAoJEJykq7OBq3PI/rsIAMItdRWG5rz7JHWf59wZQe+8
igmQerpQJX86Beq4GQA8+uLOP4bN6xhynymEsxTLVXXhVjHtOYhPMtUGI3/ZS4D2
f8/INaCjlf7+AsfQL4xo3PGzHwqvyhIG2BmS3juAw9NzooX0Vc1MJFj0qNiCxwaO
GFRB53HTdRM6uknkFZdF26+/OW/+vqmP8OJNIP7Jtlbj/nJKzJvBzDYNmj146b8r
zq6GHjVHWBgAAQxYGeEi2Ocqa9LX6JVGEsAWt414qlbJEzXoLp23JyzoEDhWSYO1
YJLOwSntHrrS5jsFGAT3uodSoZA+j2cO/CKSkgiLSb7I+dspU1yi0GRaJmXVVJo=
=ueSW
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
