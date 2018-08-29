Received: from eggs.gnu.org ([2001:4830:134:3::10]:54667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuzR4-0007uG-Aw
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 08:19:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuzR0-00036H-BB
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 08:18:58 -0400
References: <cover.1535291602.git.berto@igalia.com>
	<054195c8f83f524ee1f4d117407ac507dd18b0d8.1535291602.git.berto@igalia.com>
	<af713c19-bc70-c581-aa9c-58aa08ab5e55@redhat.com>
	<w51tvnd2xt6.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <26c1da0d-5076-0fd3-e761-4c0d61e4856e@redhat.com>
Date: Wed, 29 Aug 2018 14:18:45 +0200
MIME-Version: 1.0
In-Reply-To: <w51tvnd2xt6.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SiZwRMDv1mi9hy5srx0xmURp2kGvsL6eI"
Subject: Re: [Qemu-devel] [PATCH 3/9] block: Remove child references from
 bs->{options, explicit_options}
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
--SiZwRMDv1mi9hy5srx0xmURp2kGvsL6eI
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <26c1da0d-5076-0fd3-e761-4c0d61e4856e@redhat.com>
Subject: Re: [PATCH 3/9] block: Remove child references from
 bs->{options,explicit_options}
References: <cover.1535291602.git.berto@igalia.com>
 <054195c8f83f524ee1f4d117407ac507dd18b0d8.1535291602.git.berto@igalia.com>
 <af713c19-bc70-c581-aa9c-58aa08ab5e55@redhat.com>
 <w51tvnd2xt6.fsf@maestria.local.igalia.com>
In-Reply-To: <w51tvnd2xt6.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-29 13:53, Alberto Garcia wrote:
> On Wed 29 Aug 2018 12:43:06 PM CEST, Max Reitz wrote:
>> On 2018-08-26 16:09, Alberto Garcia wrote:
>>> Block drivers allow opening their children using a reference to an
>>> existing BlockDriverState. These references remain stored in the
>>> 'options' and 'explicit_options' QDicts, but we don't need to keep
>>> them once everything is open.
>>>
>>> What is more important, these values can become wrong if the children=

>>> change:
>>>
>>>     $ qemu-img create -f qcow2 hd0.qcow2 10M
>>>     $ qemu-img create -f qcow2 hd1.qcow2 10M
>>>     $ qemu-img create -f qcow2 hd2.qcow2 10M
>>>     $ $QEMU -drive if=3Dnone,file=3Dhd0.qcow2,node-name=3Dhd0 \
>>>             -drive if=3Dnone,file=3Dhd1.qcow2,node-name=3Dhd1,backing=
=3Dhd0 \
>>>             -drive file=3Dhd2.qcow2,node-name=3Dhd2,backing=3Dhd1
>>>
>>> After this hd2 has hd1 as its backing file. Now let's remove it using=

>>> block_stream:
>>>
>>>     (qemu) block_stream hd2 0 hd0.qcow2
>>>
>>> Now hd0 is the backing file of hd2, but hd2's options QDicts still
>>> contain backing=3Dhd1.
>>>
>>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>>> ---
>>>  block.c | 12 +++++++++++-
>>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> Also, the question is, why would we discard the child options, but
>> keep the references (which we do not add, so we only have the ones
>> specified by the user).
>=20
> We discussed this a couple of weeks ago:=20
>=20
> https://lists.gnu.org/archive/html/qemu-block/2018-08/msg00478.html
>=20
> In the end I got convinced that we didn't need to keep the child
> references.

OK, so your argument was "because references are indeed options for the
parent".  But as I said, that's only valid if all references are there,
which they aren't necessarily.

(If the user specifies the @file options inline, then you won't get a
reference for @file in bs->options.)

But since you discussed all of that already anyway, it doesn't really
matters.  What matters is that I don't disagree. :-)

>>> @@ -3313,6 +3317,12 @@ void bdrv_reopen_commit(BDRVReopenState *reope=
n_state)
>>>      bs->open_flags         =3D reopen_state->flags;
>>>      bs->read_only =3D !(reopen_state->flags & BDRV_O_RDWR);
>>> =20
>>> +    /* Remove child references from bs->options and bs->explicit_opt=
ions */
>>> +    QLIST_FOREACH(child, &bs->children, next) {
>>> +        qdict_del(bs->explicit_options, child->name);
>>> +        qdict_del(bs->options, child->name);
>>> +    }
>>> +
>>
>> Why don't you remove the child options as well?
>=20
> Because there's no child options here at this point. They are removed
> from the parent QDict in bdrv_reopen_queue_child():
>=20
>   QLIST_FOREACH(child, &bs->children, next) {
>       /* ... */
>       child_key_dot =3D g_strdup_printf("%s.", child->name);
>       qdict_extract_subqdict(explicit_options, NULL, child_key_dot);
>       qdict_extract_subqdict(options, &new_child_options, child_key_dot=
);
>       g_free(child_key_dot);
>=20
>       bdrv_reopen_queue_child(bs_queue, child->bs, new_child_options, 0=
,
>                               child->role, options, flags);
>   }

Hm.  It's a bit weird to split child options and child references into
two parts, but I suppose it makes sense.

We need to handle inline child options before the reopen, because those
are reopen options for the current child (and not intended to replace
anything).  We do not want to remove child references there, because
specifying a reference means attaching a different child.[1]

In commit, we want to remove references, because we don't want them in
bs->*options.  We'd also want to remove inline child options, but as you
say, there is no need to, because they have been removed already.

What do you think of adding a note to make it more clear?
(e.g. "(The inline child options have been handled in
bdrv_reopen_queue_child() already)")

Max


[1] On second thought, we do probably want to check the references
there, at least.  If you attach a new child, there is no need to reopen
the current child, so we should skip the bdrv_reopen_queue_child() -- or
rather, we should call it on the new child the user wants to attach.
But that's not something for this series.


--SiZwRMDv1mi9hy5srx0xmURp2kGvsL6eI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluGjyUACgkQ9AfbAGHV
z0AtkwgAwLcIMNRoe8l1XxZVqRFTWkF2oDLdIUdfLtBmnUhEJ1IPppxOR+pB+BJQ
kTNjrhZo14DCT58779LLMBLfy3O6/ZrfDBabVR5y8IcHfo5ZNEAu7Ej38OuY+/aE
/uFs9pduMhNf5SS8VB+D/FBImba53uvYBESctaYV1FH8MFZ1hx23yDQAI7g5hv3T
bJMkO8pCwuedau7P2wzJ6BSEl4FMH7+KGtpkKhCw/Me7a+7CD7BJ7w9nmLnJBfgv
XY9SCxeDDD5Cs6k45HZEsiaAM1IhZQ0iFjr7Bvdu8umTL3VUTMWFiA2DlBlHx2La
/JNvfVlTQRPr9nYLYWYjeQJ5gj203g==
=nSoY
-----END PGP SIGNATURE-----

--SiZwRMDv1mi9hy5srx0xmURp2kGvsL6eI--
