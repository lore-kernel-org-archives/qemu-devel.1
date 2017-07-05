Received: from eggs.gnu.org ([2001:4830:134:3::10]:53307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dSoRd-0007MA-ED
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:50:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dSoRc-00055L-75
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:50:33 -0400
References: <20170703122505.32017-1-mreitz@redhat.com>
	<20170703122505.32017-4-mreitz@redhat.com>
	<87k23ne4oh.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <043a875c-ee75-4716-6b31-35a92a9f58b7@redhat.com>
Date: Wed, 5 Jul 2017 19:50:20 +0200
MIME-Version: 1.0
In-Reply-To: <87k23ne4oh.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="G84Ei0kXpJUq5m94N4snr81usLsMUAmwu"
Subject: Re: [Qemu-devel] [PATCH v3 3/5] block: qobject_is_equal() in
 bdrv_reopen_prepare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G84Ei0kXpJUq5m94N4snr81usLsMUAmwu
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <043a875c-ee75-4716-6b31-35a92a9f58b7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/5] block: qobject_is_equal() in
 bdrv_reopen_prepare()
References: <20170703122505.32017-1-mreitz@redhat.com>
 <20170703122505.32017-4-mreitz@redhat.com>
 <87k23ne4oh.fsf@dusky.pond.sub.org>
In-Reply-To: <87k23ne4oh.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-05 09:14, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> Currently, bdrv_reopen_prepare() assumes that all BDS options are
>> strings. However, this is not the case if the BDS has been created
>> through the json: pseudo-protocol or blockdev-add.
>>
>> Note that the user-invokable reopen command is an HMP command, so you
>> can only specify strings there. Therefore, specifying a non-string
>> option with the "same" value as it was when originally created will no=
w
>> return an error because the values are supposedly similar (and there i=
s
>> no way for the user to circumvent this but to just not specify the
>> option again -- however, this is still strictly better than just
>> crashing).
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block.c | 31 ++++++++++++++++++-------------
>>  1 file changed, 18 insertions(+), 13 deletions(-)
>>
>> diff --git a/block.c b/block.c
>> index 913bb43..45eb248 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -2947,19 +2947,24 @@ int bdrv_reopen_prepare(BDRVReopenState *reope=
n_state, BlockReopenQueue *queue,
>>          const QDictEntry *entry =3D qdict_first(reopen_state->options=
);
>> =20
>>          do {
>> -            QString *new_obj =3D qobject_to_qstring(entry->value);
>> -            const char *new =3D qstring_get_str(new_obj);
>> -            /*
>> -             * Caution: while qdict_get_try_str() is fine, getting
>> -             * non-string types would require more care.  When
>> -             * bs->options come from -blockdev or blockdev_add, its
>> -             * members are typed according to the QAPI schema, but
>> -             * when they come from -drive, they're all QString.
>> -             */
>> -            const char *old =3D qdict_get_try_str(reopen_state->bs->o=
ptions,
>> -                                                entry->key);
>> -
>> -            if (!old || strcmp(new, old)) {
>> +            QObject *new =3D entry->value;
>> +            QObject *old =3D qdict_get(reopen_state->bs->options, ent=
ry->key);
>> +
>> +            /* TODO: When using -drive to specify blockdev options, a=
ll values
>> +             * will be strings; however, when using -blockdev, blockd=
ev-add or
>> +             * filenames using the json:{} pseudo-protocol, they will=
 be
>> +             * correctly typed.
>> +             * In contrast, reopening options are (currently) always =
strings
>> +             * (because you can only specify them through qemu-io; al=
l other
>> +             * callers do not specify any options).
>> +             * Therefore, when using anything other than -drive to cr=
eate a BDS,
>> +             * this cannot detect non-string options as unchanged, be=
cause
>> +             * qobject_is_equal() always returns false for objects of=
 different
>> +             * type.  In the future, this should be remedied by corre=
ctly typing
>> +             * all options.  For now, this is not too big of an issue=
 because
>> +             * the user simply can not specify options which cannot b=
e changed
>> +             * anyway, so they will stay unchanged. */
>=20
> I'm not the maintainer, and this is not a demand: consider winging this=

> comment and wrapping lines around column 70.

I actually did consider wrapping around column 70 and decided against it
because this comment is already indented by 12 characters, so none of
the lines exceed 65 characters (80 - (12 + strlen(" * "))).

About winging...  For some reason I don't quite like it here.  But it
probably is better because the comment is not immediately related to the
qobject_is_equal() call below, so I'll do it.

> As much as I fancy word play (see your reply to Eric), I have to admit
> that I had to read "the user simply can not specify options" about thre=
e
> times to make sense of it.  Please consider a wording that's easier to
> grasp, perhaps "the user can simply refrain from specifying options tha=
t
> cannot be changed".

Aw.  I've wanted this to be an example I could point people to to
educate them about the difference.  Now, alas, none shall learn. :-(

Max


--G84Ei0kXpJUq5m94N4snr81usLsMUAmwu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZXSbcEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQCVd
CACn7n6v5vXa2fGaRmTuXF1rYvpASnyMhsLVVSKeKq4y0tF6VYN/VN23k6uEoiSx
ECyUgABryNC+RH77ZjK092mxTyxg20AbmJGhZotFhh6k3pJNsWXdpPw2q86bCRyc
S8wIEvF1IhgGWt2c70eiYNor8kugHKAtpG6BmQrhoVlRVndqWn5y+MM3HNre+xs4
NpNBdOnjA8F9O6aNCH6Be3gp2iiZ43GbXYQXrrq0Y3pfSr5HDfaVgjtcdrzG3/4p
dGdejTVoGfrFkLv/qZyRFI2QsvF6gRgf9sdh+FER/EYTA4CML1rTHd/lPm3XkVhp
DCdjNcvWNPkl4c+m4eik0J9x
=7ZIC
-----END PGP SIGNATURE-----

--G84Ei0kXpJUq5m94N4snr81usLsMUAmwu--
