Received: from eggs.gnu.org ([2001:4830:134:3::10]:34643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eBklh-00074j-H3
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:01:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eBkld-0004hx-H0
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:01:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46213)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eBkld-0004hp-7b
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:00:57 -0500
References: <1509949271-36280-1-git-send-email-longpeng2@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d465b265-2f07-34df-4474-d5dd57ec7443@redhat.com>
Date: Mon, 6 Nov 2017 11:00:51 -0600
MIME-Version: 1.0
In-Reply-To: <1509949271-36280-1-git-send-email-longpeng2@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rsoiQpM0vsgdPTcJtrWunqTQoPjVG6tUj"
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
To: "Longpeng(Mike)" <longpeng2@huawei.com>, berrange@redhat.com, pbonzini@redhat.com, arei.gonglei@huawei.com
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rsoiQpM0vsgdPTcJtrWunqTQoPjVG6tUj
From: Eric Blake <eblake@redhat.com>
To: "Longpeng(Mike)" <longpeng2@huawei.com>, berrange@redhat.com,
 pbonzini@redhat.com, arei.gonglei@huawei.com
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Message-ID: <d465b265-2f07-34df-4474-d5dd57ec7443@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] crypto: afalg: fix a NULL pointer
 dereference
References: <1509949271-36280-1-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1509949271-36280-1-git-send-email-longpeng2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/06/2017 12:21 AM, Longpeng(Mike) wrote:
> Test-crypto-hash calls qcrypto_hash_bytesv/digest/base64 with
> errp=3DNULL, this will cause a NULL poniter deference if afalg_driver

s/poniter deference/pointer dereference/

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

No, if we are going to blindly ignore the error from the hash_bytesv()
call, then we should pass NULL rather than errp.

>=20
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
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

Any code that uses 'if (errp && *errp)' is suspicious; I think you need
a v2 that doesn't try to set errp in the first place, rather than
cleaning it up to ignore it after the fact.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--rsoiQpM0vsgdPTcJtrWunqTQoPjVG6tUj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloAlUMACgkQp6FrSiUn
Q2o5ZwgAg1UCxYG6y7/izJgzTTFa2R9GaweJjtTAD97SeZOjJjbo3zC1UyGWr9fh
3GWX1Qxx2Wq3j2A/x4zIrwL+TXiPik4kVhkpGxf1gbYBNCwofEhK6yEDK8Z01YqP
4A93sMEICf1xuWDMEhzbZVdH6Onra9SGTTil+UflyMfFdvq9zg0laSuoRTZULZ1m
ZRosf9tLXpPvB/5/omzq8vvZuowFkppo3CPYFbI8gU1TQ6sKyHAcdzDRHN+IFWur
AJ+jrF6/XaZ0zH0tPUyN5pkUFZC1vdWek7g+GPgAk+oWsSe06Q9V/TTRWxq3p8qq
0aRemCn+2Roo4WqNYqOBAhSLitVCFQ==
=S/5T
-----END PGP SIGNATURE-----

--rsoiQpM0vsgdPTcJtrWunqTQoPjVG6tUj--
