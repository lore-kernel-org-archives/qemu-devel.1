Received: from eggs.gnu.org ([2001:4830:134:3::10]:38841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDGJf-0007VV-Lt
	for qemu-devel@nongnu.org; Tue, 23 May 2017 16:22:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDGJe-00036f-Oj
	for qemu-devel@nongnu.org; Tue, 23 May 2017 16:22:03 -0400
References: <cover.1495536228.git.berto@igalia.com>
	<504d7d07c4227d4615b72f46deb34ba77efbea2c.1495536228.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f40b58a9-6c63-39fc-b8ef-f830e77f1e68@redhat.com>
Date: Tue, 23 May 2017 15:21:49 -0500
MIME-Version: 1.0
In-Reply-To: <504d7d07c4227d4615b72f46deb34ba77efbea2c.1495536228.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GTQ3hDte7T2a22AnKShGcugRut1LtOmrK"
Subject: Re: [Qemu-devel] [PATCH 1/7] qcow2: Remove unused Error in
 do_perform_cow()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GTQ3hDte7T2a22AnKShGcugRut1LtOmrK
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <f40b58a9-6c63-39fc-b8ef-f830e77f1e68@redhat.com>
Subject: Re: [PATCH 1/7] qcow2: Remove unused Error in do_perform_cow()
References: <cover.1495536228.git.berto@igalia.com>
 <504d7d07c4227d4615b72f46deb34ba77efbea2c.1495536228.git.berto@igalia.com>
In-Reply-To: <504d7d07c4227d4615b72f46deb34ba77efbea2c.1495536228.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/23/2017 06:22 AM, Alberto Garcia wrote:
> qcow2_encrypt_sectors() does not need an Error parameter, and we're
> not checking its value anyway, so we can safely remove it.

Misleading. You are NOT removing the Error parameter from
qcow2_encrypt_sectors(), but rather are explicitly ignoring any errors
by passing NULL.

I'd update the commit message to something like:

We are relying on the return value of qcow2_encrypt_sectors() to flag
problems, but have no way to report that error to the end user.  Since
we are just throwing away the error, we can pass NULL instead for
simpler code.

A more robust solution would figure out how to pass the original error
(rather than a new message related to our -EIO return) back to the
caller, but that is more invasive.

>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20

With a better commit message,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GTQ3hDte7T2a22AnKShGcugRut1LtOmrK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJJndAAoJEKeha0olJ0NqMccIAKrePzXwPZ9H2agC076ykOSY
Lk+hVtuz+XJlMjh0mGOPqCmVGc86AxL4+6aogP8oDZNOwgfRgxV5O2YdJroMcluR
RvmuX3yoBydjKjfvZ2vkVtb2S2mcZu8RfasOO0S1oMLTFnD9ARXNPi2j3oGyOyC+
FiDbYVArxZloVLEh27BJFmcJcCxSuJprFOPWkS3ItqbFJtYmKaioyCkR4CdsbNrU
nCO7tuwBBFryu4SpwBD33Rp484CtpUbEncLI2ddigfIv7zjUIQ1DKbx/D95d7Hdv
MNXDOM3tE3MLVd6L7TtluQoQV+rWVrc93f8i5YMh24iemfh0Ex1kNs8iW/thie8=
=M3W4
-----END PGP SIGNATURE-----

--GTQ3hDte7T2a22AnKShGcugRut1LtOmrK--
