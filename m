Received: from eggs.gnu.org ([2001:4830:134:3::10]:46186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eC9pR-0004bB-Kn
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 14:46:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eC9pO-0002RX-FU
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 14:46:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eC9pO-0002RO-5p
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 14:46:30 -0500
References: <1510054326-31036-1-git-send-email-longpeng2@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <adf0e2ba-9344-0859-3bd6-c98dda7306a0@redhat.com>
Date: Tue, 7 Nov 2017 13:46:27 -0600
MIME-Version: 1.0
In-Reply-To: <1510054326-31036-1-git-send-email-longpeng2@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2Awl67sRui8GxCthkAi441hcC8cX9VgHK"
Subject: Re: [Qemu-devel] [PATCH v2] crypto: afalg: fix a NULL pointer
 dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>, berrange@redhat.com
Cc: armbru@redhat.com, arei.gonglei@huawei.com, pbonzini@redhat.com, stefanha@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2Awl67sRui8GxCthkAi441hcC8cX9VgHK
From: Eric Blake <eblake@redhat.com>
To: "Longpeng(Mike)" <longpeng2@huawei.com>, berrange@redhat.com
Cc: armbru@redhat.com, arei.gonglei@huawei.com, pbonzini@redhat.com,
 stefanha@gmail.com, qemu-devel@nongnu.org
Message-ID: <adf0e2ba-9344-0859-3bd6-c98dda7306a0@redhat.com>
Subject: Re: [PATCH v2] crypto: afalg: fix a NULL pointer dereference
References: <1510054326-31036-1-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1510054326-31036-1-git-send-email-longpeng2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/07/2017 05:32 AM, Longpeng(Mike) wrote:
> From: Longpeng <longpeng2@huawei.com>
>=20
> Test-crypto-hash calls qcrypto_hash_bytesv/digest/base64 with
> errp=3DNULL, this will cause a NULL pointer deference if afalg_driver

s/deference/dereference/

(I called out two typo fixes against v1, but you only fixed one of them).=


> doesn't support requested algos:
>=20
>     ret =3D qcrypto_hash_afalg_driver.hash_bytesv(alg, iov, niov,
>                                                 result, resultlen,
>                                                 errp);
>     if (ret =3D=3D 0) {
>         return ret;
>     }
>=20
>     error_free(*errp);  // <--- here
>=20
> Because the error message is threw away immediately, so we should

s/threw/thrown/
s/so //

> just pass NULL to hash_bytesv(). There is also the same problem in
> afalg-backend cipher & hmac, let's fix them together.
>=20
> Reported-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Longpeng <longpeng2@huawei.com>
> ---

> +++ b/crypto/hash.c
> @@ -51,16 +51,10 @@ int qcrypto_hash_bytesv(QCryptoHashAlgorithm alg,
> =20
>      ret =3D qcrypto_hash_afalg_driver.hash_bytesv(alg, iov, niov,
>                                                  result, resultlen,
> -                                                errp);
> +                                                NULL);
>      if (ret =3D=3D 0) {
>          return ret;
>      }
> -
> -    /*
> -     * TODO:
> -     * Maybe we should treat some afalg errors as fatal
> -     */

The comment is probably still worth keeping (maybe hoisted above the
call to hash_bytesv(, NULL), though).

As moving (instead of deleting) a comment is trivial, I'm okay if a
maintainer does that while applying:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2Awl67sRui8GxCthkAi441hcC8cX9VgHK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloCDZMACgkQp6FrSiUn
Q2q4DAgApF0x+R5Qx6nxgLTSRvKr06WFFO3N11oBc64E7hFb8zKttxZqJDmzJ+d2
iw6LlE3k3or5wGpncf7nxYosk23P0t9KH7M/lpLVRtS7ScAPrW5iG1Vvmpgpx5HJ
rMb4cWmLCBfqSEHwVNSIdwXxERJuBDGTWreURM2zxPSf17WflF2W1OWOPfcdNTfR
pH9UM4NeMHgaC4gcKeeksvMcqiQJ6n/kLngdj6YkiEHUdb06lO2CrDXzksaqSqnv
uAxsWVzf6VmSI7htgs8xtZ3ihBb2SiLLTK0+7Byv4Y4WWr06XbOvRaL/0cxSBzfW
MfFpPwF8BncN9uCH+Bd/9536YxXsYw==
=bGqK
-----END PGP SIGNATURE-----

--2Awl67sRui8GxCthkAi441hcC8cX9VgHK--
