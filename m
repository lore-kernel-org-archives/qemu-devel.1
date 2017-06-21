Received: from eggs.gnu.org ([2001:4830:134:3::10]:47635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNnHL-0005p7-Vv
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 17:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNnHK-0001yp-Sd
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 17:35:12 -0400
References: <20170621134744.8047-1-mreitz@redhat.com>
	<20170621134744.8047-4-mreitz@redhat.com>
	<87h8z9wcjy.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <84e9b47f-ce63-f2cd-09f6-4819b186cfe9@redhat.com>
Date: Wed, 21 Jun 2017 23:34:55 +0200
MIME-Version: 1.0
In-Reply-To: <87h8z9wcjy.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LLl6vF4sdBPnL59f1djLgmpruoWaFA0dX"
Subject: Re: [Qemu-devel] [PATCH v2 3/4] block: qobject_is_equal() in
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
--LLl6vF4sdBPnL59f1djLgmpruoWaFA0dX
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <84e9b47f-ce63-f2cd-09f6-4819b186cfe9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] block: qobject_is_equal() in
 bdrv_reopen_prepare()
References: <20170621134744.8047-1-mreitz@redhat.com>
 <20170621134744.8047-4-mreitz@redhat.com> <87h8z9wcjy.fsf@dusky.pond.sub.org>
In-Reply-To: <87h8z9wcjy.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-21 18:06, Markus Armbruster wrote:
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
>> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block.c | 15 +++------------
>>  1 file changed, 3 insertions(+), 12 deletions(-)
>>
>> diff --git a/block.c b/block.c
>> index fa1d06d..23424d5 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -2950,19 +2950,10 @@ int bdrv_reopen_prepare(BDRVReopenState *reope=
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
>=20
> Your commit message makes me suspect this comment still applies in some=

> form.  Does it?

The only thing that I can think of that may be applicable is what I
wrote in the commit message; this fails now:

$ qemu-io -c 'reopen -o size=3D65536' \
    "json:{'driver':'null-co','size':65536}"
Cannot change the option 'size'

As I wrote in the commit message, though, I don't think this is too bad.
First, before, it just crashed, so this definitely is better behavior.

Secondly, I think this is just good for convenience; it allows the user
to specify an option (to "change" it) even if the block driver doesn't
support changing it. If it actually has not change, this is supposed to
be handled gracefully. But sometimes we cannot easily handle it, so...
We just give an error.

I suspect that at some point we want to fix this by having everything
correctly typed internally...? Until then, in my opinion, we can just
not provide this feature.

However, I should have probably not just deleted the comment and hoped
everyone can find the necessary information through git-blame. I should
leave a comment about this here.


Or we do make an effort to provide this test-unchanged functionality for
every case, in which case we would have to convert either string options
to the correct type (according to the schema) here (but if that were so
simple, we could do that centrally in bdrv_open() already, right?) or
convert typed options to strings and compare them -- but since there are
probably multiple different strings that can mean the same value for
whatever type the option has, this won't work in every case either.

So I'm for leaving a comment and leaving this not quite as it should be
until we have fixed all of the block layer (O:-)). Maybe you have a
better idea though, which would be great.

Max

>> -            const char *old =3D qdict_get_try_str(reopen_state->bs->o=
ptions,
>> -                                                entry->key);
>> +            QObject *new =3D entry->value;
>> +            QObject *old =3D qdict_get(reopen_state->bs->options, ent=
ry->key);
>> =20
>> -            if (!old || strcmp(new, old)) {
>> +            if (!qobject_is_equal(new, old)) {
>>                  error_setg(errp, "Cannot change the option '%s'", ent=
ry->key);
>>                  ret =3D -EINVAL;
>>                  goto error;



--LLl6vF4sdBPnL59f1djLgmpruoWaFA0dX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZSuaAEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQDA0
B/4+3c7VWA+01iv9llNWsK+dPSVzB1kt60fUwJOnZVmmz5dh/isqql6n+Bc6giir
g2YxBTYNtS7PZeSgz/AYiAf28bEw4AIzWv9LGbXZsrS95c4sBfjjR8XgGx2ds7xk
D94h55iB67OvXLzUNxhGCnju2fvT9Tbp23XlvekMil+FvYbhpzIJryjEDRVCSf8I
/hze6P4gAhiZ3hPKIyvxD5vLlBjOp4meAs5E3RwFg22MdltB212dMctEQamPMfc0
GCAEviOILEmao5JyLE/4bQ+Do4l7ikSVeue/l94r+oPzawqz5wa70ekRxXbjEt/z
71QdDa1swFl4u8E/IJbeztL3
=cmqh
-----END PGP SIGNATURE-----

--LLl6vF4sdBPnL59f1djLgmpruoWaFA0dX--
