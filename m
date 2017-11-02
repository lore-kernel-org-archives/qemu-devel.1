Received: from eggs.gnu.org ([2001:4830:134:3::10]:58462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eAHh4-0007w8-3n
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 11:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eAHgz-0002Ff-SW
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 11:46:10 -0400
References: <20170929165347.29658-1-mreitz@redhat.com>
	<20170929165347.29658-10-mreitz@redhat.com>
	<w51h8ugk7zx.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <332bd2e4-6c1a-8d41-e204-776b29d42cfb@redhat.com>
Date: Thu, 2 Nov 2017 16:45:50 +0100
MIME-Version: 1.0
In-Reply-To: <w51h8ugk7zx.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eD9852R9X4JoVeLsj5hRM5WXDRaEV43M0"
Subject: Re: [Qemu-devel] [PATCH v6 09/25] block: Fix
 bdrv_find_backing_image()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eD9852R9X4JoVeLsj5hRM5WXDRaEV43M0
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>
Message-ID: <332bd2e4-6c1a-8d41-e204-776b29d42cfb@redhat.com>
Subject: Re: [PATCH v6 09/25] block: Fix bdrv_find_backing_image()
References: <20170929165347.29658-1-mreitz@redhat.com>
 <20170929165347.29658-10-mreitz@redhat.com>
 <w51h8ugk7zx.fsf@maestria.local.igalia.com>
In-Reply-To: <w51h8ugk7zx.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-10-30 15:47, Alberto Garcia wrote:
> On Fri 29 Sep 2017 06:53:31 PM CEST, Max Reitz wrote:
>> @@ -4096,22 +4086,31 @@ BlockDriverState *bdrv_find_backing_image(Bloc=
kDriverState *bs,
>>          } else {
>>              /* If not an absolute filename path, make it relative to =
the current
>>               * image's filename path */
>> -            path_combine_deprecated(filename_tmp, PATH_MAX, curr_bs->=
filename,
>> -                                    backing_file);
>> +            filename_tmp =3D bdrv_make_absolute_filename(curr_bs, bac=
king_file,
>> +                                                       NULL);
>> +            if (!filename_tmp) {
>> +                continue;
>> +            }
>> =20
>>              /* We are going to compare absolute pathnames */
>>              if (!realpath(filename_tmp, filename_full)) {
>> +                g_free(filename_tmp);
>>                  continue;
>>              }
>> +            g_free(filename_tmp);
>=20
> This feels a bit too verbose, doesn't it? (especially because you're
> doing the same thing twice, see below). It could be made a bit shorter,=

> something like:
>=20
>     bool have_filename =3D filename_tmp && realpath(filename_tmp, filen=
ame_full);
>     g_free(filename_tmp);
>     if (!have_filename) {
>          continue;
>     }

Well, but then again

if (filename_tmp && realpath(filename_tmp, filename_full)) {
    g_free(filename_tmp);
    continue;
}
g_free(filename_tmp);

has the same length. :-)

(Actually, overall it'd be one line shorter because I'd have to use an
own line for the "bool have_filename" declaration (to put it at the
start of the block).)

So I'll do that, yes.

Thanks for reviewing (and this suggestion)!

Max

>=20
>> -            path_combine_deprecated(filename_tmp, PATH_MAX, curr_bs->=
filename,
>> -                                    curr_bs->backing_file);
>> +            filename_tmp =3D bdrv_get_full_backing_filename(curr_bs, =
NULL);
>> +            if (!filename_tmp) {
>> +                continue;
>> +            }
>> =20
>>              if (!realpath(filename_tmp, backing_file_full)) {
>> +                g_free(filename_tmp);
>>                  continue;
>>              }
>> +            g_free(filename_tmp);
>=20
> Berto
>=20



--eD9852R9X4JoVeLsj5hRM5WXDRaEV43M0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAln7Pa4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AD00H/ir4mAXL2Jv6gt8D0C+F5Ywr/vVFKx6q
WokBguXRr4Lg/XUCiF0p425bpf5xByr4VHhErqlyJNENvipavbHL2A+4Y1Hym1M0
q5SotRSkWrNMsostE7ZXqGh/A080gLI+0FHjDepW1fMv9ngEQ+Pj84JQasDl1D0r
M2CLNzGpHT/+E957RsBPGas3iz5Pboce4/oer+PVb8IQ9TiGu9IYJxqw3rt+Rk2d
qZc/D84OIXHJ9oUbJFzktn7SF9kSMHSm4E9IC8R4imNhNomdVo1way3QYXZ76WMz
Ro05eW4PG1Dckviajgxa5Ja3iI9A+VWfOKK1DryK2yXHkyNOM/wMAuc=
=K1b5
-----END PGP SIGNATURE-----

--eD9852R9X4JoVeLsj5hRM5WXDRaEV43M0--
