Received: from eggs.gnu.org ([2001:4830:134:3::10]:34497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eAHtp-0002Ve-L8
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 11:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eAHto-0007uz-RH
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 11:59:21 -0400
From: Max Reitz <mreitz@redhat.com>
References: <20170929165347.29658-1-mreitz@redhat.com>
	<20170929165347.29658-10-mreitz@redhat.com>
	<w51h8ugk7zx.fsf@maestria.local.igalia.com>
	<332bd2e4-6c1a-8d41-e204-776b29d42cfb@redhat.com>
Message-ID: <b50479a1-c590-f882-e01c-a0b378218911@redhat.com>
Date: Thu, 2 Nov 2017 16:59:07 +0100
MIME-Version: 1.0
In-Reply-To: <332bd2e4-6c1a-8d41-e204-776b29d42cfb@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pO6rq2Aum31EjU1HHQuxFLPWR9bJaiWwA"
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
--pO6rq2Aum31EjU1HHQuxFLPWR9bJaiWwA
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>
Message-ID: <b50479a1-c590-f882-e01c-a0b378218911@redhat.com>
Subject: Re: [PATCH v6 09/25] block: Fix bdrv_find_backing_image()
References: <20170929165347.29658-1-mreitz@redhat.com>
 <20170929165347.29658-10-mreitz@redhat.com>
 <w51h8ugk7zx.fsf@maestria.local.igalia.com>
 <332bd2e4-6c1a-8d41-e204-776b29d42cfb@redhat.com>
In-Reply-To: <332bd2e4-6c1a-8d41-e204-776b29d42cfb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-02 16:45, Max Reitz wrote:
> On 2017-10-30 15:47, Alberto Garcia wrote:
>> On Fri 29 Sep 2017 06:53:31 PM CEST, Max Reitz wrote:
>>> @@ -4096,22 +4086,31 @@ BlockDriverState *bdrv_find_backing_image(Blo=
ckDriverState *bs,
>>>          } else {
>>>              /* If not an absolute filename path, make it relative to=
 the current
>>>               * image's filename path */
>>> -            path_combine_deprecated(filename_tmp, PATH_MAX, curr_bs-=
>filename,
>>> -                                    backing_file);
>>> +            filename_tmp =3D bdrv_make_absolute_filename(curr_bs, ba=
cking_file,
>>> +                                                       NULL);
>>> +            if (!filename_tmp) {
>>> +                continue;
>>> +            }
>>> =20
>>>              /* We are going to compare absolute pathnames */
>>>              if (!realpath(filename_tmp, filename_full)) {
>>> +                g_free(filename_tmp);
>>>                  continue;
>>>              }
>>> +            g_free(filename_tmp);
>>
>> This feels a bit too verbose, doesn't it? (especially because you're
>> doing the same thing twice, see below). It could be made a bit shorter=
,
>> something like:
>>
>>     bool have_filename =3D filename_tmp && realpath(filename_tmp, file=
name_full);
>>     g_free(filename_tmp);
>>     if (!have_filename) {
>>          continue;
>>     }
>=20
> Well, but then again
>=20
> if (filename_tmp && realpath(filename_tmp, filename_full)) {

(err, I mean ||, of course.)

>     g_free(filename_tmp);
>     continue;
> }
> g_free(filename_tmp);
>=20
> has the same length. :-)
>=20
> (Actually, overall it'd be one line shorter because I'd have to use an
> own line for the "bool have_filename" declaration (to put it at the
> start of the block).)
>=20
> So I'll do that, yes.
>=20
> Thanks for reviewing (and this suggestion)!
>=20
> Max
>=20
>>
>>> -            path_combine_deprecated(filename_tmp, PATH_MAX, curr_bs-=
>filename,
>>> -                                    curr_bs->backing_file);
>>> +            filename_tmp =3D bdrv_get_full_backing_filename(curr_bs,=
 NULL);
>>> +            if (!filename_tmp) {
>>> +                continue;
>>> +            }
>>> =20
>>>              if (!realpath(filename_tmp, backing_file_full)) {
>>> +                g_free(filename_tmp);
>>>                  continue;
>>>              }
>>> +            g_free(filename_tmp);
>>
>> Berto
>>
>=20
>=20



--pO6rq2Aum31EjU1HHQuxFLPWR9bJaiWwA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAln7QMsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AvLcH/R99VWS0F4Vykvdb4lCqgo2iv+u9u3R+
E2BhHiwu3xEFrWKOR3wMaAjlWwAsySJtwbhkmpHkeEHHOziEBYiMrkeNSnW8RPZp
NOEVsQqkSWyg/445YSlBsjXI//EYg9HyEcaTDd6gaNVyYUI7qc+4/BZ8t0kmqswu
G7OBi4KU0by8H4gUtFV526odT2R2manm5l5EHA5GaKkVhZGnkPeZ5A53cpmie9zT
uNH57RsVwbp0Pt2WCKzOVKqOojSn9YkAFvl9Dt4VlazRr0cRs8JUV1ErFHrF+n2o
3GPKw9IjTyU7vvbogYgEIhUOiLR9NzqzeZzefyN9L24258ZcDAhMIaI=
=rvJR
-----END PGP SIGNATURE-----

--pO6rq2Aum31EjU1HHQuxFLPWR9bJaiWwA--
