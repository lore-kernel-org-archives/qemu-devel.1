Received: from eggs.gnu.org ([2001:4830:134:3::10]:54101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evLqF-0004aa-PD
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:42:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evLqE-0007OG-Pr
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:42:11 -0400
Date: Mon, 12 Mar 2018 11:42:05 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180312114205.GK3493@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180309172713.26318-1-kwolf@redhat.com>
	<20180309172713.26318-6-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180309172713.26318-6-kwolf@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/6] luks: Catch integer overflow for huge
 sizes
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

On Fri, Mar 09, 2018 at 06:27:12PM +0100, Kevin Wolf wrote:
> When you request an image size close to UINT64_MAX, the addition of the
> crypto header may cause an integer overflow. Catch it instead of
> silently truncating the image size.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/crypto.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/block/crypto.c b/block/crypto.c
> index 4908d8627f..1b46519c53 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -102,6 +102,11 @@ static ssize_t block_crypto_init_func(QCryptoBlock=
 *block,
>  {
>      struct BlockCryptoCreateData *data =3D opaque;
> =20
> +    if (headerlen > UINT64_MAX - data->size) {
> +        error_setg(errp, "The requested file size is too large");
> +        return -EFBIG;
> +    }
> +
>      /* User provided size should reflect amount of space made
>       * available to the guest, so we must take account of that
>       * which will be used by the crypto header

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

(if using INT64_MAX as Eric suggests)

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
