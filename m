Received: from eggs.gnu.org ([2001:4830:134:3::10]:57637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dB5VN-0001px-B8
	for qemu-devel@nongnu.org; Wed, 17 May 2017 16:25:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dB5VM-0000q4-CL
	for qemu-devel@nongnu.org; Wed, 17 May 2017 16:25:09 -0400
References: <20170517170941.25850-1-stefanha@redhat.com>
	<20170517170941.25850-4-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <455ebb50-8f37-72b4-eef4-87c4a7c5c6d5@redhat.com>
Date: Wed, 17 May 2017 15:24:55 -0500
MIME-Version: 1.0
In-Reply-To: <20170517170941.25850-4-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kngn0jRVmO5EgwWDc9FXjknFGPKKaVAUx"
Subject: Re: [Qemu-devel] [PATCH 3/3] migration: avoid recursive AioContext
 locking in save_vmstate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kngn0jRVmO5EgwWDc9FXjknFGPKKaVAUx
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org
Message-ID: <455ebb50-8f37-72b4-eef4-87c4a7c5c6d5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] migration: avoid recursive AioContext
 locking in save_vmstate()
References: <20170517170941.25850-1-stefanha@redhat.com>
 <20170517170941.25850-4-stefanha@redhat.com>
In-Reply-To: <20170517170941.25850-4-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/17/2017 12:09 PM, Stefan Hajnoczi wrote:
> AioContext was designed to allow nested acquire/release calls.  It uses=

> a recursive mutex so callers don't need to worry about nesting...or so
> we thought.
>=20
> BDRV_POLL_WHILE() is used to wait for block I/O requests.  It releases
> the AioContext temporarily around aio_poll().  This gives IOThreads a
> chance to acquire the AioContext to process I/O completions.
>=20
> It turns out that recursive locking and BDRV_POLL_WHILE() don't mix.
> BDRV_POLL_WHILE() only releases the AioContext once, so the IOThread
> will not be able to acquire the AioContext if it was acquired
> multiple times.
>=20
> Instead of trying to release AioContext n times in BDRV_POLL_WHILE(),
> this patch simply avoids nested locking in save_vmstate().  It's the
> simplest fix and we should step back to consider the big picture with
> all the recent changes to block layer threading.
>=20
> This patch is the final fix to solve 'savevm' hanging with -object
> iothread.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  migration/savevm.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--kngn0jRVmO5EgwWDc9FXjknFGPKKaVAUx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZHLGXAAoJEKeha0olJ0NqeigIAIZaxExAWMZGLLLf2TmRZfY3
hmePNTrxARKk5z9q18wWnBDz7Pm6MzcUxpQIqZBwwkxG/j5J2/QFrgTjTK9AaqHM
dOkAWTiVWL7tXUiF1d//ksftIXtyhYzELjxW5Z19JvRroC/7870H9vd0SGIEkxZj
mKBAEyi/4pY4nGLreoRcMnQ0vuQEKgQ9fLJiPpzwt8OKLyllxufab2Hql3gOyJPi
/STfTlmfyHekKHV2k/wBK/vMNDZ2LVN7ChMSc7uQ6ezmyhPtrtcsvGuBqJBO5YI5
G+3A/CVeVl+DT2n+x0KJRGt2qpvv0nISxlJwLT02uAfGZYdz3K1L5N/DMqq+isI=
=kdXb
-----END PGP SIGNATURE-----

--kngn0jRVmO5EgwWDc9FXjknFGPKKaVAUx--
