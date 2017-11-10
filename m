Received: from eggs.gnu.org ([2001:4830:134:3::10]:54083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDFuH-00087g-2a
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:28:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDFuG-0002vJ-4e
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:28:05 -0500
References: <cover.1510339534.git.berto@igalia.com>
	<e089c66e7c20289b046d782cea4373b765c5bc1d.1510339534.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e84b73c5-5d27-0a99-0f39-00719bb4f61b@redhat.com>
Date: Fri, 10 Nov 2017 21:27:51 +0100
MIME-Version: 1.0
In-Reply-To: <e089c66e7c20289b046d782cea4373b765c5bc1d.1510339534.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4uiEwPnQPuKtbg7AV8wHJrVmxH1hkiGbx"
Subject: Re: [Qemu-devel] [PATCH 2/3] block: Leave valid throttle timers
 when removing a BDS from a backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, sochin jiang <sochin.jiang@huawei.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4uiEwPnQPuKtbg7AV8wHJrVmxH1hkiGbx
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, sochin jiang <sochin.jiang@huawei.com>
Message-ID: <e84b73c5-5d27-0a99-0f39-00719bb4f61b@redhat.com>
Subject: Re: [PATCH 2/3] block: Leave valid throttle timers when removing a
 BDS from a backend
References: <cover.1510339534.git.berto@igalia.com>
 <e089c66e7c20289b046d782cea4373b765c5bc1d.1510339534.git.berto@igalia.com>
In-Reply-To: <e089c66e7c20289b046d782cea4373b765c5bc1d.1510339534.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-10 19:54, Alberto Garcia wrote:
> If a BlockBackend has I/O limits set then its ThrottleGroupMember
> structure uses the AioContext from its attached BlockDriverState.
> Those two contexts must be kept in sync manually. This is not
> ideal and will be fixed in the future by removing the throttling
> configuration from the BlockBackend and storing it in an implicit
> filter node instead, but for now we have to live with this.
>=20
> When you remove the BlockDriverState from the backend then the
> throttle timers are destroyed. If a new BlockDriverState is later
> inserted then they are created again using the new AioContext.
>=20
> There'a a couple of problems with this:
>=20
>    a) The code manipulates the timers directly, leaving the
>       ThrottleGroupMember.aio_context field in an inconsisent state.
>=20
>    b) If you remove the I/O limits (e.g by destroying the backend)
>       when the timers are gone then throttle_group_unregister_tgm()
>       will attempt to destroy them again, crashing QEMU.
>=20
> While b) could be fixed easily by allowing the timers to be freed
> twice, this would result in a situation in which we can no longer
> guarantee that a valid ThrottleState has a valid AioContext and
> timers.
>=20
> This patch ensures that the timers and AioContext are always valid
> when I/O limits are set, regardless of whether the BlockBackend has a
> BlockDriverState inserted or not.
>=20
> Reported-by: sochin jiang <sochin.jiang@huawei.com>
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/block-backend.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--4uiEwPnQPuKtbg7AV8wHJrVmxH1hkiGbx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloGC8cSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AuoIH/RCx1xTGjacauzY1wuaIDx58hCOUlQnH
+9gwOCp9RUAQjC/0hVOXBrjclg7DEuNXLrymATtyz7cKFjaFu1gPnj4s/dU6xEAx
Rz3kaK8L8BWeEfVW5saCE1mbbDh3d99jBYA9UakhaSyCiOw69FzaBEtex3JW0Fn+
JMsMOG8G85B9N5hQm/tZ2lJ3PKL1vJ4J70TqMNSexdF3RUQPZttdvrPpum8R+Ngc
DEg33CPOChh1AwD6IMiv5wMEgjXrmuN4sWklQkN5zcblcqTKzGbEGhtU0eLY5LdR
JmCmg3tYYuXOvlb9jlxJ+ST2fLlulm1ooA7+f9Tv4zFHQtU5ZWArSqs=
=+aKI
-----END PGP SIGNATURE-----

--4uiEwPnQPuKtbg7AV8wHJrVmxH1hkiGbx--
