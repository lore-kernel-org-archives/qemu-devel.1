Received: from eggs.gnu.org ([2001:4830:134:3::10]:49598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dAK3T-0001gQ-6A
	for qemu-devel@nongnu.org; Mon, 15 May 2017 13:45:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dAK3S-0002jP-AL
	for qemu-devel@nongnu.org; Mon, 15 May 2017 13:45:11 -0400
From: Max Reitz <mreitz@redhat.com>
References: <20170515140410.14172-1-berrange@redhat.com>
	<20170515140410.14172-5-berrange@redhat.com>
	<e2a74028-c9c0-6b6a-4c13-27fab303a2e1@redhat.com>
Message-ID: <fc00e7f3-38d2-25d2-7c81-5b2dd415342a@redhat.com>
Date: Mon, 15 May 2017 19:44:55 +0200
MIME-Version: 1.0
In-Reply-To: <e2a74028-c9c0-6b6a-4c13-27fab303a2e1@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IIElh0nKujernVmo4mIl56s6EEfwatDnd"
Subject: Re: [Qemu-devel] [PATCH v9 4/4] qemu-img: copy *key-secret opts
 when opening newly created files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IIElh0nKujernVmo4mIl56s6EEfwatDnd
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>
Message-ID: <fc00e7f3-38d2-25d2-7c81-5b2dd415342a@redhat.com>
Subject: Re: [PATCH v9 4/4] qemu-img: copy *key-secret opts when opening newly
 created files
References: <20170515140410.14172-1-berrange@redhat.com>
 <20170515140410.14172-5-berrange@redhat.com>
 <e2a74028-c9c0-6b6a-4c13-27fab303a2e1@redhat.com>
In-Reply-To: <e2a74028-c9c0-6b6a-4c13-27fab303a2e1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-15 19:43, Max Reitz wrote:
> On 2017-05-15 16:04, Daniel P. Berrange wrote:
>> The qemu-img dd/convert commands will create an image file and
>> then try to open it. Historically it has been possible to open
>> new files without passing any options. With encrypted files
>> though, the *key-secret options are mandatory, so we need to
>> provide those options when opening the newly created file.
>>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>> Reviewed-by: Fam Zheng <famz@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>> ---
>>  qemu-img.c | 42 +++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 37 insertions(+), 5 deletions(-)
>>
>> diff --git a/qemu-img.c b/qemu-img.c
>> index e0e3d31..dcddded 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -314,15 +314,18 @@ static BlockBackend *img_open_opts(const char *o=
ptstr,
>>  }
>> =20
>>  static BlockBackend *img_open_file(const char *filename,
>> +                                   QDict *options,
>>                                     const char *fmt, int flags,
>>                                     bool writethrough, bool quiet,
>>                                     bool force_share)
>>  {
>>      BlockBackend *blk;
>>      Error *local_err =3D NULL;
>> -    QDict *options =3D qdict_new();
>> =20
>>      if (fmt) {
>> +        if (!options) {
>> +            options =3D qdict_new();
>> +        }
>=20
> This is the only place where my attempted rebase and your version
> differ. I think this has to be done unconditionally, because otherwise:=

>=20
> $ ./qemu-img info -U null-co://
> [1]    16327 segmentation fault (core dumped)  ./qemu-img info -U null-=
co://
>=20
> Also, I'm not sure the R-bs apply for this patch any longer.
>=20
> (They do for patch 1 because it's just a contextual difference. For
> patch 2, it's a borderline case (I would drop it, but I can understand
> keeping it). For patch 3 it's more than just borderline - I would
> definitely drop the R-b, but the differences are still rather
> mechanical, so it is acceptable to keep it.
> But I think there are too many changes here in this patch to keep the
> R-bs. In fact, I'm pretty sure none of Eric, Fam and me have given an
> R-b to this segfault...)

And just saw v10... Maybe I should start working on my inbox back to
front...

Max


--IIElh0nKujernVmo4mIl56s6EEfwatDnd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZGekYEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQJvX
B/oCB5r6spykPkN/GpJkGyJF8bVMFwx2VOsnenGEvmT8x1hDUE9fVbIiXq+NVV2b
U37ITw6Y7JNy5meqMPnPQhXR5zp5x2BBO6/MGyVJh9sssYgtu9cLxBizkZXppTWE
qGC8Ohgm1V9ESWMk3wKjekiOJpdPD/gKDKx8BYtvkZZYyY87o1B/GiAF8UPwb//i
eJ7CZ0pwL2PTMhB2Ra07rUoETrJRp2Kgn747gwczC/PV/+9Quh905S0u0fWi70Pu
WcJoiHXFf/wETFzuvitff8l94zsGjXcqwFzcYN7e1chlJgSuFFIwWTHv9NGZLyIY
XQjcX747R9d4X1wVdXZabaMl
=BNA+
-----END PGP SIGNATURE-----

--IIElh0nKujernVmo4mIl56s6EEfwatDnd--
