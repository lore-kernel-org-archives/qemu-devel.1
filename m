Received: from eggs.gnu.org ([2001:4830:134:3::10]:33804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1kDJ-0002XR-Vv
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 21:51:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1kDG-0001z1-Tq
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 21:51:54 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3456
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d1kDG-0001vO-Aa
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 21:51:50 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Sat, 22 Apr 2017 01:51:26 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA2392E2@DGGEMA505-MBS.china.huawei.com>
References: <1492392806-53720-1-git-send-email-longpeng2@huawei.com>
	<1492392806-53720-14-git-send-email-longpeng2@huawei.com>
	<33183CC9F5247A488A2544077AF19020DA238C15@DGGEMA505-MBS.china.huawei.com>
	<58FAB39A.9080400@huawei.com>
In-Reply-To: <58FAB39A.9080400@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 13/18] crypto: cipher: add
 afalg-backend cipher support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: longpeng <longpeng2@huawei.com>
Cc: "berrange@redhat.com" <berrange@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "armbru@redhat.com" <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

>=20
>=20
> On 2017/4/21 20:59, Gonglei (Arei) wrote:
>=20
> >
> >> -----Original Message-----
> >> From: longpeng
> >> Sent: Monday, April 17, 2017 9:33 AM
> >> To: berrange@redhat.com
> >> Cc: Gonglei (Arei); Huangweidong (C); armbru@redhat.com;
> >> eblake@redhat.com; mst@redhat.com; qemu-devel@nongnu.org;
> longpeng
> >> Subject: [PATCH v2 for-2.10 13/18] crypto: cipher: add afalg-backend c=
ipher
> >> support
> >>
> >> Adds afalg-backend cipher support: introduces some private APIs
> >> firstly, and then intergrates them into qcrypto_cipher_afalg_driver.
> >>
> >> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> >> ---
> >>  crypto/Makefile.objs       |   1 +
> >>  crypto/afalgpriv.h         |   9 ++
> >>  crypto/cipher-afalg.c      | 225
> >> +++++++++++++++++++++++++++++++++++++++++++++
> >>  crypto/cipher.c            |  28 +++++-
> >>  crypto/cipherpriv.h        |  11 +++
> >>  include/crypto/cipher.h    |   8 ++
> >>  tests/test-crypto-cipher.c |  10 +-
> >>  7 files changed, 290 insertions(+), 2 deletions(-)
> >>  create mode 100644 crypto/cipher-afalg.c
>=20
> >> +
> >> +static char *
> >> +qcrypto_afalg_cipher_format_name(QCryptoCipherAlgorithm alg,
> >> +                                 QCryptoCipherMode mode,
> >> +                                 Error **errp)
> >> +{
> >> +    char *name;
> >> +    const char *alg_name =3D NULL;
> >> +    const char *mode_name =3D NULL;
> >
> > Superfluous initialization.
>=20
>=20
> Ok.
>=20
> >
> >> +    int ret;
> >> +
>=20
> >> +
> >> +    mode_name =3D QCryptoCipherMode_lookup[mode];
> >> +
> >> +    name =3D (char *)g_new0(int8_t, SALG_NAME_LEN_MAX);
> >
> > s/ (char *)g_new0(int8_t, SALG_NAME_LEN_MAX)/g_new0(char,
> SALG_NAME_LEN_MAX)/
> >
>=20
>=20
> Ok.
>=20
> >
> >> +    ret =3D snprintf(name, SALG_NAME_LEN_MAX, "%s(%s)", mode_name,
> >> +                   alg_name);
> >> +    if (ret < 0 || ret >=3D SALG_NAME_LEN_MAX) {
>=20
> >> +
> >> +QCryptoAFAlg *
> >> +qcrypto_afalg_cipher_ctx_new(QCryptoCipherAlgorithm alg,
> >> +                             QCryptoCipherMode mode,
> >> +                             const uint8_t *key,
> >> +                             size_t nkey, Error **errp)
> >> +{
> >> +    QCryptoAFAlg *afalg;
> >> +    size_t except_niv =3D 0;
> >
> > Doesn't need to initialize it.
> >
>=20
>=20
> Ok.
>=20
> >> +    char *name;
> >> +
> >> +    name =3D qcrypto_afalg_cipher_format_name(alg, mode, errp);
> >> +    if (!name) {
> >> +        return NULL;
> >> +    }
> >> +
> >> +    afalg =3D qcrypto_afalg_comm_alloc(AFALG_TYPE_CIPHER, name, errp)=
;
> >> +    if (!afalg) {
> >> +        goto error;
> >
> > Leak memory pointed by name.
> >
>=20
>=20
> It won't.
>=20
> If failed, the control flow is error->cleanup->return, and 'name' will be=
 freed
> in 'cleanup'.
>=20
> If this method success, then the control flow is cleanup->return, 'name' =
will
> also be freed.
>=20
I see. I suggest you can store the name pointer in afalg, then its easily t=
o free
it in qcrypto_afalg_comm_free(), and we can get enough information about
the alg/mode if needed.

Thanks,
-Gonglei
