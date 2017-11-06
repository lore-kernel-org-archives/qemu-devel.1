Received: from eggs.gnu.org ([2001:4830:134:3::10]:40657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eBl2w-0007NI-PI
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:18:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eBl2t-0004bA-FC
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:18:50 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:48262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eBl2t-0004ap-6z
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:18:47 -0500
Received: by mail-wm0-x22d.google.com with SMTP id p75so15328692wmg.3
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 09:18:46 -0800 (PST)
Date: Mon, 6 Nov 2017 17:18:44 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171106171844.GI4557@stefanha-x1.localdomain>
References: <1509949271-36280-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zqjkMoGlbUJ91oFe"
Content-Disposition: inline
In-Reply-To: <1509949271-36280-1-git-send-email-longpeng2@huawei.com>
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
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Cc: berrange@redhat.com, pbonzini@redhat.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org


--zqjkMoGlbUJ91oFe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2017 at 02:21:11PM +0800, Longpeng(Mike) wrote:
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

Only errp needs to be checked.  It's okay to invoke error_free(NULL):

  void error_free(Error *err)
  {
      if (err) {

--zqjkMoGlbUJ91oFe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaAJl0AAoJEJykq7OBq3PIR/4IAJ7dgPR0SR8pai0fyLWfnssC
okuGa2FDvXJypxiTBPIjGcmd/vJTPRRyT10xIlEcIooVxEHsafyJ7q8CBFHF37Y+
i8kcfOmu7kfWL1QrOBoLEe78LBZvr92ljIqnB6cSRVJi696Vqh9mK4wD5o7L0NGN
m2eMi+fTb4DaXyAaEuuwpqb65uPyQJFSocZMEhFbUH/bnzS5DrtomhY2GwdUEpSy
oaOwGlFJxmuVai3H6ccL0aBqVLVn8ER2nHtO0siLmR4X9EhtFVlHnXHnIh7JVCgH
yZH4oW5KWIeh80tQ9pfqYtknZp10dobK5ycPlZgc7iQWlaHsRlSVuhkimRO7v6Y=
=CpLr
-----END PGP SIGNATURE-----

--zqjkMoGlbUJ91oFe--
