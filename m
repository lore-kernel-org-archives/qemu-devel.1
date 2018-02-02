Received: from eggs.gnu.org ([208.118.235.92]:37663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehfOn-0000jF-L1
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 12:46:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehfNj-0003H9-Gx
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 12:45:17 -0500
From: Max Reitz <mreitz@redhat.com>
References: <20171120201004.14999-1-mreitz@redhat.com>
	<20171120201004.14999-22-mreitz@redhat.com>
	<w51shcq30wc.fsf@maestria.local.igalia.com>
	<ff4ca1cc-b489-1c4e-8686-1c250e88065f@redhat.com>
Message-ID: <35ab4e44-7829-1a9b-269b-97972d36822c@redhat.com>
Date: Fri, 2 Feb 2018 18:41:46 +0100
MIME-Version: 1.0
In-Reply-To: <ff4ca1cc-b489-1c4e-8686-1c250e88065f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AGcPk1pDGoGkWOGOCfPx482RinhVtqzSr"
Subject: Re: [Qemu-devel] [PATCH v7 for-2.12 21/25] block: Purify
 .bdrv_refresh_filename()
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
--AGcPk1pDGoGkWOGOCfPx482RinhVtqzSr
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>
Message-ID: <35ab4e44-7829-1a9b-269b-97972d36822c@redhat.com>
Subject: Re: [PATCH v7 for-2.12 21/25] block: Purify .bdrv_refresh_filename()
References: <20171120201004.14999-1-mreitz@redhat.com>
 <20171120201004.14999-22-mreitz@redhat.com>
 <w51shcq30wc.fsf@maestria.local.igalia.com>
 <ff4ca1cc-b489-1c4e-8686-1c250e88065f@redhat.com>
In-Reply-To: <ff4ca1cc-b489-1c4e-8686-1c250e88065f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-12-04 19:25, Max Reitz wrote:
> On 2017-12-04 17:37, Alberto Garcia wrote:
>> On Mon 20 Nov 2017 09:10:00 PM CET, Max Reitz wrote:
>>> -static void blkdebug_refresh_filename(BlockDriverState *bs, QDict *o=
ptions)
>>> +static void blkdebug_refresh_filename(BlockDriverState *bs)
>>>  {
>>>      BDRVBlkdebugState *s =3D bs->opaque;
>>> -    QDict *opts;
>>>      const QDictEntry *e;
>>> -    bool force_json =3D false;
>>> -
>>> -    for (e =3D qdict_first(options); e; e =3D qdict_next(options, e)=
) {
>>> -        if (strcmp(qdict_entry_key(e), "config") &&
>>> -            strcmp(qdict_entry_key(e), "x-image"))
>>> -        {
>>> -            force_json =3D true;
>>> -            break;
>>> -        }
>>> -    }
>>> +    int ret;
>>> =20
>>> -    if (force_json && !bs->file->bs->full_open_options) {
>>> -        /* The config file cannot be recreated, so creating a plain =
filename
>>> -         * is impossible */
>>> +    if (!bs->file->bs->exact_filename[0]) {
>>>          return;
>>>      }
>>> =20
>>> -    if (!force_json && bs->file->bs->exact_filename[0]) {
>>> -        int ret =3D snprintf(bs->exact_filename, sizeof(bs->exact_fi=
lename),
>>> -                           "blkdebug:%s:%s", s->config_file ?: "",
>>> -                           bs->file->bs->exact_filename);
>>> -        if (ret >=3D sizeof(bs->exact_filename)) {
>>> -            /* An overflow makes the filename unusable, so do not re=
port any */
>>> -            bs->exact_filename[0] =3D 0;
>>> +    for (e =3D qdict_first(bs->full_open_options); e;
>>> +         e =3D qdict_next(bs->full_open_options, e))
>>> +    {
>>> +        if (strcmp(qdict_entry_key(e), "config") &&
>>> +            strcmp(qdict_entry_key(e), "image") &&
>>
>> Shouldn't this be "x-image" ?
>=20
> Er, yes.  It should.

Actually, it should be both.  That's because the child is attached as
"image" and not "x-image", so when the child options are gathered, they
are put under "image".

And since the child is attached using bdrv_open_child(), you have to
specify all child options in an "image" sub qdict, too (as can be seen
in iotest 099), so this is indeed correct.  (Btw, note that the old code
already put these options under "image".)

(So with "x-image" instead of "image", iotest 162 fails.)

Of course, x-image can be specified, too (although I wouldn't really
mind breaking that for users...), so we have to ignore that, still.


Before this patch, we could ignore "image" because we iterated over the
options before they were newly generated.  Now they are generated
automatically before this function is called, so there may be an "image"
key now.

x-image


--AGcPk1pDGoGkWOGOCfPx482RinhVtqzSr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp0otoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AfNoIAKRsVNDGnJXHBMDIJgQ5mM7QCuCtTmKT
xo83K+/0+w4eM31PXl3Hkewl28iyfamBusotaW9aITSj9BT06DRFYLheWMfi6oBb
IiHL9F/OPvCuJlQpO21DnFlfEhglpWTCqEmYFdIf8gZRtBcC+ZUCCtANDrJFOts7
7gx/1OLbHzmKdhXARS+AOddVG+xelg+IORIiJaqaQ2T9uFJf1gUpmCPuG+gF4Crg
YQL0HCKdrlmRISUxsQs6tLWSGlLzE2lQQI5W0cX1gJKdGshaZeVkZn8PtrR5ZeNj
k1A7KnMKDus/ISid0kGIsA7uv2ibkzYO10Pjs3GuDpk4s/pi9yW8zro=
=dRRY
-----END PGP SIGNATURE-----

--AGcPk1pDGoGkWOGOCfPx482RinhVtqzSr--
