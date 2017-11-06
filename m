Received: from eggs.gnu.org ([2001:4830:134:3::10]:37432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eBeXk-0003YE-N0
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:22:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eBeXh-0005c9-Fu
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:22:12 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:4366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eBeXg-0005UK-UD
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:22:09 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Mon, 6 Nov 2017 10:21:47 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA461521@DGGEMA505-MBS.china.huawei.com>
References: <1509949271-36280-1-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1509949271-36280-1-git-send-email-longpeng2@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] crypto: afalg: fix a NULL pointer
 dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: longpeng <longpeng2@huawei.com>, "berrange@redhat.com" <berrange@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


> -----Original Message-----
> From: longpeng
> Sent: Monday, November 06, 2017 2:21 PM
> To: berrange@redhat.com; pbonzini@redhat.com; Gonglei (Arei)
> Cc: longpeng; qemu-devel@nongnu.org
> Subject: [PATCH] crypto: afalg: fix a NULL pointer dereference
>=20
> Test-crypto-hash calls qcrypto_hash_bytesv/digest/base64 with
> errp=3DNULL, this will cause a NULL poniter deference if afalg_driver
> doesn't support requested algos:
>     ret =3D qcrypto_hash_afalg_driver.hash_bytesv(alg, iov, niov,
>                                                 result, resultlen,
>                                                 errp);
>     if (ret =3D=3D 0) {
>         return ret;
>     }
>=20
>     error_free(*errp);  // <--- here
>=20
> So we must check 'errp & *errp' before dereference.
>=20
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Gonglei <arei.gonglei@huawei.com>

Thanks,
-Gonglei

>  crypto/hash.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/crypto/hash.c b/crypto/hash.c
> index ac59c63..c464c78 100644
> --- a/crypto/hash.c
> +++ b/crypto/hash.c
> @@ -60,7 +60,9 @@ int qcrypto_hash_bytesv(QCryptoHashAlgorithm alg,
>       * TODO:
>       * Maybe we should treat some afalg errors as fatal
>       */
> -    error_free(*errp);
> +    if (errp && *errp) {
> +        error_free(*errp);
> +    }
>  #endif
>=20
>      return qcrypto_hash_lib_driver.hash_bytesv(alg, iov, niov,
> --
> 1.8.3.1
>=20
