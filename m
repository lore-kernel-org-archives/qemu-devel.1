Received: from eggs.gnu.org ([2001:4830:134:3::10]:37522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fv043-0001eg-Dj
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 08:59:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fv042-0000xi-6V
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 08:59:15 -0400
References: <cover.1535291602.git.berto@igalia.com>
	<d470d52cfc97265fec584e6b7d4b5a89c37a1739.1535291602.git.berto@igalia.com>
	<c9cb16fe-8e23-50c4-67c0-3c5952163099@redhat.com>
	<w51r2ih2w5m.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c147ca8a-da5e-bb8d-86ab-b9c34acddcf3@redhat.com>
Date: Wed, 29 Aug 2018 14:59:01 +0200
MIME-Version: 1.0
In-Reply-To: <w51r2ih2w5m.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="yI1BiUG9v6tyxH2667JglGi4bE16BBlP4"
Subject: Re: [Qemu-devel] [PATCH 5/9] block: Allow child references on reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yI1BiUG9v6tyxH2667JglGi4bE16BBlP4
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <c147ca8a-da5e-bb8d-86ab-b9c34acddcf3@redhat.com>
Subject: Re: [PATCH 5/9] block: Allow child references on reopen
References: <cover.1535291602.git.berto@igalia.com>
 <d470d52cfc97265fec584e6b7d4b5a89c37a1739.1535291602.git.berto@igalia.com>
 <c9cb16fe-8e23-50c4-67c0-3c5952163099@redhat.com>
 <w51r2ih2w5m.fsf@maestria.local.igalia.com>
In-Reply-To: <w51r2ih2w5m.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-29 14:29, Alberto Garcia wrote:
> On Wed 29 Aug 2018 01:26:46 PM CEST, Max Reitz wrote:
>> On 2018-08-26 16:09, Alberto Garcia wrote:
>>> In the previous patches we removed all child references from
>>> bs->{options,explicit_options} because keeping them is useless and
>>> wrong.
>>>
>>> Because of this, any attempt to reopen a BlockDriverState using a
>>> child reference as one of its options would result in a failure,
>>> because bdrv_reopen_prepare() would detect that there's a new option
>>> (the child reference) that wasn't present in bs->options.
>>>
>>> But passing child references on reopen can be useful. It's a way to
>>> specify a BDS's child without having to pass recursively all of the
>>> child's options, and if the reference points to a different BDS then
>>> this can allow us to replace the child.
>>>
>>> However, replacing the child is something that needs to be implemente=
d
>>> case by case and only when it makes sense. For now, this patch allows=

>>> passing a child reference as long as it points to the current child o=
f
>>> the BlockDriverState.
>>
>> "For now"?  If you intend it to be case-by-case, won't it be handled b=
y
>> the driver's bdrv_reopen_prepare() implementation?
>=20
> Yes, it will (except the "backing" reference which is handled by the
> main bdrv_reopen_prepare() function).
>=20
> What I meant with "For now" is that this patch doesn't add support for
> any other case.

OK.

>>> @@ -3241,6 +3241,25 @@ int bdrv_reopen_prepare(BDRVReopenState *reope=
n_state, BlockReopenQueue *queue,
>>>              QObject *new =3D entry->value;
>>>              QObject *old =3D qdict_get(reopen_state->bs->options, en=
try->key);
>>> =20
>>> +            /* We allow child references 'child_name'=3D'value'
>>> +             * if 'child_name' is an existing child of the BDS
>>> +             * and 'value' is the child's node name (a string). */
>>> +            if (qobject_type(new) =3D=3D QTYPE_QSTRING) {
>>> +                BdrvChild *child;
>>> +                QLIST_FOREACH(child, &reopen_state->bs->children, ne=
xt) {
>>> +                    if (!strcmp(child->name, entry->key)) {
>>> +                        break;
>>> +                    }
>>> +                }
>>> +
>>> +                if (child) {
>>> +                    const char *str =3D qobject_get_try_str(new);
>>> +                    if (!strcmp(child->bs->node_name, str)) {
>>> +                        continue; /* Found child with this name, ski=
p option */
>>> +                    }
>>> +                }
>>> +            }
>>> +
>>
>> Looks good, but I think the comment looks a bit convoluted.  Maybe add=

>> a note like "(so the child has to stay the same)"?
>=20
> Ok, I can think of making it shorter.

I didn't really mean "convoluted" in the sense of "it's too much".  It's
mostly just hard to grasp because it tries to be as exact as possible.
Adding a short "colloquial" summary would help.

>> Third...  Hm.  This is just a general question.  So as far as I
>> understand we decided that when you don't specify an option for
>> reopen, it means that the default is used, and that we don't want to
>> retain the old value.
>=20
> Correct.
>=20
>> Specifically, that means when you don't specify @backing, the default
>> chain will be opened and may replace the current one.
>=20
> At the moment "backing" is the only child option that can be omitted,
> all others must be specified. So if you leave "backing" out on reopen()=

> we have the following possibilities:
>=20
>   a) We open the default backing file from disk. I don't think we want
>      to open a new image on reopen(). Plus, what happens if the current=

>      backing image is the default one? Do we need to detect that? And
>      what if it's the default image but has non-default options? The
>      whole thing looks like a can of worms.

True.

>   b) We leave the current backing file untouched.

Hm.  That doesn't make sense for blockdev-add, so you could argue that
this behavior works as a default for reopen (because it cannot be
"confused" with the blockdev-add default).

>   c) We forbid it, and the user has to pass an explicit child, or NULL.=


That sounds good.

> I chose (b) in this series. I suppose (c) could also be an option. But
> (a) doesn't looke like a good idea.

I agree with the last sentiment, but I'd prefer making it an error
instead of choosing (b).  Yes, you could argue that choosing (b) as a
default makes sense in a way, but in another, it just doesn't make
sense.  (Because while (b) makes no sense for blockdev-add, (a) would
make sense for both blockdev-add and reopen.  Sure, it's horrible to
support, but from a user's POV, it makes sense.  So it's just confusing
not to make that the default for reopen as well).

But the most important point is that it's trivial for the user to keep
the current backing file.  They just need to give the current backing's
node-name.

So choosing (b) yields no real value over (c), and it may be confusing.
Which is why I prefer (c).

(Whereas (a) would provide real value, because the user has no simple
way of opening the default backing chain.  But I agree that we don't
need it (now), and that going for it would spill the can of worms.)

> It it inconsistent with the way blockdev-reopen is supposed to work?
> Maybe it is, but I think we have to make an exception in this case.

Making it an error would definitely be safe, however.

>> So why isn't it mandatory to re-specify all children for now?
>=20
> It is
Is it?  Why does

$ qemu-io -c 'reopen -o lazy-refcounts=3Don' foo.qcow2

work, then?  Shouldn't I have to specify @file?

Max


--yI1BiUG9v6tyxH2667JglGi4bE16BBlP4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluGmJUACgkQ9AfbAGHV
z0CBNAf9HNtf+zEQYOMfPLni/yKQdNbwiZ/dgEbc+2z6uafsLJ845L8yGkEoSdPB
9Dyjy8JtZu01qr0aPizuiC3Yb6xQc+a/3jIWNeFb6vjqx0+GmjiTmmvRUHCxHK9t
7PYVQbmHyH7QE+ORHv11bYQ9p5tdD4v7NbgcBgpdfqjZusn5v/eq1RVtURaMoacR
GthXmYAhLl7um6p66/XFYCL8Jd6GP3aHyzd6J/QFMWTyQqwphSp6y07tXbocQRYY
xCc1X7aIKzR9VAR1ARTPZmbmJQyixcqeG4ei7hmB0sWu/o/gFMrymSFKmYcVP2UB
Ha0CFTBHvLn4EtuMi5a3sAoE02qcBA==
=OkT+
-----END PGP SIGNATURE-----

--yI1BiUG9v6tyxH2667JglGi4bE16BBlP4--
