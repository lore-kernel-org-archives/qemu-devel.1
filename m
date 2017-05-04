Received: from eggs.gnu.org ([2001:4830:134:3::10]:38415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6EjY-0000Kv-8M
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6EjU-0003pu-9K
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:15:44 -0400
Date: Thu, 4 May 2017 12:15:36 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170504111536.GG32376@stefanha-x1.localdomain>
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OFj+1YLvsEfSXdCH"
Content-Disposition: inline
In-Reply-To: <20170420120058.28404-2-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 01/17] block: access
 copy_on_read with atomic ops
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


--OFj+1YLvsEfSXdCH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 20, 2017 at 02:00:42PM +0200, Paolo Bonzini wrote:
>  void bdrv_disable_copy_on_read(BlockDriverState *bs)
>  {
> -    assert(bs->copy_on_read > 0);
> -    bs->copy_on_read--;
> +    assert(atomic_read(&bs->copy_on_read) > 0);
> +    atomic_dec(&bs->copy_on_read);
>  }

To make this truly thread-safe:

  old = atomic_dec_fetch(&bs->copy_on_read);
  assert(old > 0);

--OFj+1YLvsEfSXdCH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCw1YAAoJEJykq7OBq3PIKgoH/A6LZoLUwGOhXZ/Ma1ZjRDzI
C+MZq13Fq+NSxFEIjAsz+z+4Tf8QpfpVeQPAfQMGr72YXYPzrtfBAB60IrmpiZmX
kn+/oiXO6o1Rlu0MkYaEdxXdDAwjBl1mKrhkSNKG5OyJ/W/qsdHpHRVhktY3QKGb
aoL3gIbqLu2QGhY5Mh6CICm9/Q42b+kQd1L/Yq5C8tGcQMTy28BRT6MjWJNDo4/5
JSJMSlgEH+36/k+CrWi+YFZW/Dqx0SWKa93IF5gx3pEPBzn/GTcLyPfIntEvjUS8
1eqlNyC+3smMvR+PUz/xyegZblT8HvwFvYAf1jGZT5n7KSiA/R7dUnYCNMmFrTM=
=KrkO
-----END PGP SIGNATURE-----

--OFj+1YLvsEfSXdCH--
