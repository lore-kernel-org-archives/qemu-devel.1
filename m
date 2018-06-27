Received: from eggs.gnu.org ([2001:4830:134:3::10]:37619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fY9Dx-0004BH-Fv
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:07:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fY9Dw-0007Nm-44
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:07:01 -0400
Date: Wed, 27 Jun 2018 13:06:51 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180627120651.GM5955@stefanha-x1.localdomain>
References: <20180622193700.6523-1-naravamudan@digitalocean.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nrXiCraHbXeog9mY"
Content-Disposition: inline
In-Reply-To: <20180622193700.6523-1-naravamudan@digitalocean.com>
Subject: Re: [Qemu-devel] [PATCH v4] linux-aio: properly bubble up errors
 from initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org


--nrXiCraHbXeog9mY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 22, 2018 at 12:37:00PM -0700, Nishanth Aravamudan wrote:
> laio_init() can fail for a couple of reasons, which will lead to a NULL
> pointer dereference in laio_attach_aio_context().
>=20
> To solve this, add a aio_setup_linux_aio() function which is called
> early in raw_open_common. If this fails, propagate the error up. The
> signature of aio_get_linux_aio() was not modified, because it seems
> preferable to return the actual errno from the possible failing
> initialization calls.
>=20
> Additionally, when the AioContext changes, we need to associate a
> LinuxAioState with the new AioContext. Use the bdrv_attach_aio_context
> callback and call the new aio_setup_linux_aio(), which will allocate a
> new AioContext if needed, and return errors on failures. If it fails for
> any reason, fallback to threaded AIO with an error message, as the
> device is already in-use by the guest.
>=20
> Add an assert that aio_get_linux_aio() cannot return NULL.
>=20
> Signed-off-by: Nishanth Aravamudan <naravamudan@digitalocean.com>
>=20
> ---
>=20
> Test case 1:
>     Set /proc/sys/fs/max-aio-nr to 0. Start a guest with an aio=3Dnative
>     disk.
>=20
>     Result: laio_init() returns NULL due to not being able to allocate
>     any AIO contexts. This NULL is assigned to ctx->linux_aio and
>     dereferenced in aio_get_linux_aio.
>=20
> Test case 2:
>     Set /proc/sys/fs/max-aio-nr to 128. Start a guest with an aio=3Dnative
>     disk and one in-use I/O thread.
>=20
>     Result: laio_init() returns NULL due to not being able to allocate
>     additional AIO contexts for the I/O thread. This NULL is assigned to
>     ctx->linux_aio and dereferenced in aio_get_linux_aio.
>=20
> Changes from v3 -> v4 (thanks to Fam Zheng and Kevin Wolf for review):
>=20
> Squash patch 2/2 into 1/2.
> Differentiate the possible reasons for laio_init() failing and use an
> Error ** to propagate the errno to the caller.
>=20
> Changes from v2 -> v3 (thanks to Eric Blake and Kevin Wolf for review):
>=20
> Use a boolean false rather than 0 in assignment to use_linux_aio.
> Drop ending '.' from error_report() calls.
> Fix typo in commit message (propogates -> propagates).
> Move aio_setup_linux_aio call to raw_open_common.
>=20
> Changes from v1 -> v2 (thanks to Kevin Wolf for review):
>=20
> Rather than affect virtio-scsi/blk at all, make all the changes internal
> to file-posix.c. Thanks to Kevin Wolf for the suggested change.
>=20
>  block/file-posix.c      | 33 ++++++++++++++++++++++++++++-----
>  block/linux-aio.c       | 12 +++++++++---
>  include/block/aio.h     |  3 +++
>  include/block/raw-aio.h |  2 +-
>  stubs/linux-aio.c       |  2 +-
>  util/async.c            | 14 +++++++++++---
>  6 files changed, 53 insertions(+), 13 deletions(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--nrXiCraHbXeog9mY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbM33bAAoJEJykq7OBq3PI4ssH/0Zqgidv8LhjN/ruNq54OdUV
RG9hkhBCzGh0PMrktNmjr8UyydkCoA+9Aj/+L96ZKUKVuHKfOgkjGninKWh5kBtz
EQv9GLdeZHnyUW07I1d33FxdePQLywISo7OBc1b6VME/LN9jql44RnV27U5Ii8y5
zO4opb2/NvaEWtaBlK3AFKtYD7Qgk0TYI5cR/AE0dSQz1QEkyEozVyfL1hV/73EV
NWI7Xczp2iDjNelRk4qRsnYtgsnrL8cFDwYmq5Ut/l4bJOOtpld0kOPLUQtRJrM7
yVEULQz2G3NZ0a9tnjFJiRxUf+FYshz0EwKSd+RXOAqFSE9VYlpxopKR+j0tFqU=
=U3HL
-----END PGP SIGNATURE-----

--nrXiCraHbXeog9mY--
