Received: from eggs.gnu.org ([2001:4830:134:3::10]:39054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePC0o-00062B-Kq
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:44:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePC0k-0003Lw-M2
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:44:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePC0k-0003LU-Et
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:44:06 -0500
Date: Wed, 13 Dec 2017 18:43:58 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171213184358.GF8317@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-16-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z+pzSjdB7cqptWpS"
Content-Disposition: inline
In-Reply-To: <20171205055200.16305-16-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v5 15/26] monitor: let suspend_cnt be thread
 safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--z+pzSjdB7cqptWpS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 01:51:49PM +0800, Peter Xu wrote:
> Monitor code now can be run in more than one thread.  Let it be thread
> safe when accessing suspend_cnt counter.

Please add doc comments to the functions explaining which thread they
may be called from (especially public functions).  Without this
information other people will have a hard time keeping code thread-safe.

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

=46rom docs/devel/atomics.txt:

  Macros defined by qemu/atomic.h fall in three camps:

  - compiler barriers: barrier();

  - weak atomic access and manual memory barriers: atomic_read(),
    atomic_set(), smp_rmb(), smp_wmb(), smp_mb(), smp_mb_acquire(),
    smp_mb_release(), smp_read_barrier_depends();

  - sequentially consistent atomic access: everything else.

The atomic_read() and atomic_set() calls in this patch aren't effective
without memory barriers.  Please use atomic_mb_read() and
atomic_mb_set() instead.

--z+pzSjdB7cqptWpS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMXTuAAoJEJykq7OBq3PIF4UIAMePx1ajYf1keMsql+Fqpeh4
/IchuBI2WY1Y+kQyGxYnf7jFsdU+uOFnoE5N/5oFJeDlh/OZ23jZR0bZXeMQ+cyN
SQL8u68spJU+09BHPC8uaiYSsjaPlbXqk+6Gn++UhsHVWdiB882w4DCSpyfh9pRa
VCFtubvK8v7pg0VlAo+VLnfq5xj41iSnEdOaswNZlLF11GgeOcLVxeDgJcCO2XM5
v/q746U77YyyrnjYlsNKMSiOFOgOmKEeMFMixQ1gKK8tW9BHM5NvcbAI4ZeLBoQ7
oR6BI92ZCiyeFUTAXDWE6hdJqYRgMHnY7bVCCF8yTMA4lWCg7VALDiLQIJKNjZo=
=AjPO
-----END PGP SIGNATURE-----

--z+pzSjdB7cqptWpS--
