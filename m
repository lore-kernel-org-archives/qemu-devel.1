Received: from eggs.gnu.org ([2001:4830:134:3::10]:48836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6IDq-00080N-S6
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:59:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6IDl-0007nE-VQ
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:59:14 -0400
Date: Thu, 4 May 2017 15:59:06 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170504145906.GR32376@stefanha-x1.localdomain>
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-15-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4NNqsQ/a67jpuySk"
Content-Disposition: inline
In-Reply-To: <20170420120058.28404-15-pbonzini@redhat.com>
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


--4NNqsQ/a67jpuySk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 20, 2017 at 02:00:55PM +0200, Paolo Bonzini wrote:
> Hot path reqs_lock critical sections are very small; the only large criti=
cal
> sections happen when a request waits for serialising requests, and these
> should never happen in usual circumstances.
>=20
> We do not want these small critical sections to yield in any case,
> which calls for using a spinlock while writing the list.

Is this patch purely an optimization?

I'm hesitant about using spinlocks in userspace.  There are cases where
the thread is descheduled that are beyond our control.  Nested virt will
probably make things worse.  People have been optimizing and trying
paravirt approaches to kernel spinlocks for these reasons for years.

Isn't a futex-based lock efficient enough?  That way we don't hog the
CPU when there is contention.

Also, there are no performance results included in this patch that
justify the spinlock.

--4NNqsQ/a67jpuySk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZC0G6AAoJEJykq7OBq3PIrLMH/2fTCMoH1htzEr42ctw3BIcO
FyaAxU2RaIiJt5/RBZIhtnpxfCB98KJaC7BthL/I5d9xNm12j2U8hMzhfNKVxxSq
BpejL+E2Yqpde3we6if7GiuGPA8haLiDW51BC0TOOlO4FrcKBWb3NRZqoHxSr0Ek
K+87jA6tMKbvYzZECQjPQUusMMlTNOE6iX7QNYk4i0W3RMRDpxMZGqqHoVvyKCK1
nbApx7V2eNZukBh4Rmgy6mj7CnDhicitaE2+A/SEFAG8V4A3sspWhMLdGkoryHuI
PSx95O8ChOQ9whUJEuDH4AZHfypIH+oEPIiSnCkzq8mRQPPuSLEtGFe14wxgrfE=
=hHzt
-----END PGP SIGNATURE-----

--4NNqsQ/a67jpuySk--
