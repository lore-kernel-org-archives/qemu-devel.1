Received: from eggs.gnu.org ([2001:4830:134:3::10]:33258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d0pQZ-0001R9-EM
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 09:13:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d0pQY-0001qI-Bp
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 09:13:47 -0400
References: <20170413160625.27719-1-mreitz@redhat.com>
	<20170413160625.27719-2-mreitz@redhat.com>
	<1f7840f6-d59f-2533-aeea-1ea6c1baf910@amsat.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ca5773bc-4100-e5e4-41a8-bca09209c4e9@redhat.com>
Date: Wed, 19 Apr 2017 15:13:36 +0200
MIME-Version: 1.0
In-Reply-To: <1f7840f6-d59f-2533-aeea-1ea6c1baf910@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="j5sNP8cRQVICLsVDFmrqs3drvXoRRlRHj"
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/2] block: An empty filename
 counts as no filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable <qemu-stable@nongnu.org>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j5sNP8cRQVICLsVDFmrqs3drvXoRRlRHj
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable <qemu-stable@nongnu.org>,
 qemu-devel@nongnu.org
Message-ID: <ca5773bc-4100-e5e4-41a8-bca09209c4e9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/2] block: An empty filename counts
 as no filename
References: <20170413160625.27719-1-mreitz@redhat.com>
 <20170413160625.27719-2-mreitz@redhat.com>
 <1f7840f6-d59f-2533-aeea-1ea6c1baf910@amsat.org>
In-Reply-To: <1f7840f6-d59f-2533-aeea-1ea6c1baf910@amsat.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 17.04.2017 14:51, Philippe Mathieu-Daud=E9 wrote:
> Hi Max,
>=20
> On 04/13/2017 01:06 PM, Max Reitz wrote:
>> Reproducer:
>>     $ ./qemu-img info ''
>>     qemu-img: ./block.c:1008: bdrv_open_driver: Assertion
>>         `!drv->bdrv_needs_filename || bs->filename[0]' failed.
>>     [1]    26105 abort (core dumped)  ./qemu-img info ''
>>
>> This patch fixes this to be:
>>     $ ./qemu-img info ''
>>     qemu-img: Could not open '': The 'file' block driver requires a fi=
le
>>     name
>>
>> Cc: qemu-stable <qemu-stable@nongnu.org>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block.c b/block.c
>> index 1fbbb8d606..46da908c93 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -1167,7 +1167,7 @@ static int bdrv_open_common(BlockDriverState
>> *bs, BlockBackend *file,
>>          filename =3D qdict_get_try_str(options, "filename");
>>      }
>>
>> -    if (drv->bdrv_needs_filename && !filename) {
>> +    if (drv->bdrv_needs_filename && (!filename || !filename[0])) {
>=20
> What do you think about adding an inline function in "qemu/option.h"
> like "is_valid_[option_]filename()" to avoid this bug template?

Well, I won't do it now but it's a good idea and if I hit this issue
again (or maybe if/when I realize how much code there is that uses
constructs like this...) I'll add it.

(Although it may actually be useful with a more common name, like
string_is_empty(). Unfortunately, there isn't anything like g_strlen0(),
apparently...)

> Anyway:
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Thanks! (For your other reviews as well, of course.)

Max

>=20
>>          error_setg(errp, "The '%s' block driver requires a file name"=
,
>>                     drv->format_name);
>>          ret =3D -EINVAL;
>>



--j5sNP8cRQVICLsVDFmrqs3drvXoRRlRHj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlj3YoASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A5lgIAMJZivlEZf+dxYKNNy7HJA0IhhYQxrGz
44LN+yRpjhBUZOBn+XWt5E70BqWn8SOzIcFqaV4v09XHoOCl/yk51zVK8qeqEgjR
jcvcRarIX0m68hUp2oaYd4dWDWt+wxSnehZuXDjou0OlZJwAWiCLoV6GMJZd2euc
k7Fvnn8MTjAE6rif9vJC8+Akac4XuN6v+iAGN4RdXPR5CG8PxXQz39BXfsrpOPy+
0vYJkqtqH8Qk9PljoOweUhXlqfRyw+s6y1Xn5Ns/tFaN4PnMpxEOX4vJlAv+K/G3
q0cH0/z2pOOWr1rBeLZGSVjEMeRqHhijZesIggC1jUtjU3/QMVndjqU=
=a5Lx
-----END PGP SIGNATURE-----

--j5sNP8cRQVICLsVDFmrqs3drvXoRRlRHj--
