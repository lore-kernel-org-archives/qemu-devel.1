Received: from eggs.gnu.org ([2001:4830:134:3::10]:50646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cZfDu-0005X9-4Y
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 09:52:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cZfDo-0000rf-Vu
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 09:52:26 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cZfDo-0000rC-OS
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 09:52:20 -0500
Received: by mail-wm0-x244.google.com with SMTP id u63so4829993wmu.2
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 06:52:20 -0800 (PST)
Date: Fri, 3 Feb 2017 14:52:18 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170203145218.GE642@stefanha-x1.localdomain>
References: <1486045515-8009-1-git-send-email-den@openvz.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ytoMbUMiTKPMT3hY"
Content-Disposition: inline
In-Reply-To: <1486045515-8009-1-git-send-email-den@openvz.org>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] mirror: do not increase offset
 during initial zero_or_discard phase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>


--ytoMbUMiTKPMT3hY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 02, 2017 at 05:25:15PM +0300, Denis V. Lunev wrote:
> From: Anton Nefedov <anton.nefedov@virtuozzo.com>
>=20
> If explicit zeroing out before mirroring is required for the target image,
> it moves the block job offset counter to EOF, then offset and len counters
> count the image size twice. There is no harm but stats are confusing,
> specifically the progress of the operation is always reported as 99% by
> management tools.
>=20
> The patch skips offset increase for the first "technical" pass over the
> image. This should not cause any further harm.
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Jeff Cody <jcody@redhat.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Eric Blake <eblake@redhat.com>
> ---
> Changes from v1:
> - changed the approach - we do not allow to increase the offset rather th=
en
>   to move it back
> - description rewritten
> - kludges to tests are removed as not actually needed with this approach
>=20
>  block/mirror.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Another option is to put the flag in MirrorOp instead of MirrorBlockJob.
That reduces the scope of the variable, but this is okay too:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ytoMbUMiTKPMT3hY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYlJkiAAoJEJykq7OBq3PIGvsIAIPeMNyrLeg71wby9OP2YN5y
NsmbYJ1AZRblqTBR+cNSf+AW1Xn5ItgqzXeEeQN/3AJcu4ttvho0qgNMIs5zWBo4
AQ7pbEFjgBdakIdMWKhZEtXatQgJknDUkttORXcbB9pgEVVihK98N5Qlfiwc3BF3
zUxv7oBnIl4+Zweei4Q6SdhvYRMi0ANVhMtPkgpOUulJYbA7q7NC8iU3f5dxAXWU
U08gys5G/lHVTo7J7Ov3impQJYm/Tjg4y8Atgj4iFPdAaFXUlZE//C+Gh1sQk7by
mOcaf/1tWqhTMTKuMFpafPS3gm5BB5iQ7vl13/AwD9zzUma70kUpEv2/Tq+OGI4=
=cwRx
-----END PGP SIGNATURE-----

--ytoMbUMiTKPMT3hY--
