Received: from eggs.gnu.org ([2001:4830:134:3::10]:53826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evLpT-0003xE-5L
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evLpS-0005z6-5x
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:41:23 -0400
Date: Mon, 12 Mar 2018 11:41:01 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180312114101.GJ3493@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180309172713.26318-1-kwolf@redhat.com>
	<20180309172713.26318-5-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180309172713.26318-5-kwolf@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/6] luks: Turn invalid assertion into check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

On Fri, Mar 09, 2018 at 06:27:11PM +0100, Kevin Wolf wrote:
> The .bdrv_getlength implementation of the crypto block driver asserted
> that the payload offset isn't after EOF. This is an invalid assertion t=
o
> make as the image file could be corrupted. Instead, check it and return
> -EIO if the file is too small for the payload offset.
>=20
> Zero length images are fine, so trigger -EIO only on offset > len, not
> on offset >=3D len as the assertion did before.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/crypto.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/crypto.c b/block/crypto.c
> index 2035f9ab13..4908d8627f 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -518,7 +518,10 @@ static int64_t block_crypto_getlength(BlockDriverS=
tate *bs)
> =20
>      uint64_t offset =3D qcrypto_block_get_payload_offset(crypto->block=
);
>      assert(offset < INT64_MAX);
> -    assert(offset < len);
> +
> +    if (offset > len) {
> +       return -EIO;
> +    }
> =20
>      len -=3D offset;

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
