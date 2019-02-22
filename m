Received: from eggs.gnu.org ([209.51.188.92]:42269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gxBad-0007Gw-A5
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:14:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gxBaa-0002in-Lv
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:14:11 -0500
References: <20190131175549.11691-1-kwolf@redhat.com>
	<20190131175549.11691-9-kwolf@redhat.com>
	<67996e1d-1d6f-2990-3b96-22554f261029@redhat.com>
	<20190219085141.GC4727@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1a598bde-1921-3253-ff83-967927e45669@redhat.com>
Date: Fri, 22 Feb 2019 15:12:59 +0100
MIME-Version: 1.0
In-Reply-To: <20190219085141.GC4727@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vUnbWGt3DM6SVdw7CFPAXPESbVPJV8eUQ"
Subject: Re: [Qemu-devel] [RFC PATCH 08/11] qcow2: Add basic data-file
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vUnbWGt3DM6SVdw7CFPAXPESbVPJV8eUQ
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, qemu-devel@nongnu.org
Message-ID: <1a598bde-1921-3253-ff83-967927e45669@redhat.com>
Subject: Re: [RFC PATCH 08/11] qcow2: Add basic data-file infrastructure
References: <20190131175549.11691-1-kwolf@redhat.com>
 <20190131175549.11691-9-kwolf@redhat.com>
 <67996e1d-1d6f-2990-3b96-22554f261029@redhat.com>
 <20190219085141.GC4727@localhost.localdomain>
In-Reply-To: <20190219085141.GC4727@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 19.02.19 09:51, Kevin Wolf wrote:
> Am 19.02.2019 um 00:57 hat Max Reitz geschrieben:
>> On 31.01.19 18:55, Kevin Wolf wrote:
>>> This adds a .bdrv_open option to specify the external data file node.=

>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  qapi/block-core.json |  3 ++-
>>>  block/qcow2.h        |  4 +++-
>>>  block/qcow2.c        | 25 +++++++++++++++++++++++--
>>>  3 files changed, 28 insertions(+), 4 deletions(-)
>>
>> [...]
>>
>>> diff --git a/block/qcow2.h b/block/qcow2.h
>>> index c161970882..e2114900b4 100644
>>> --- a/block/qcow2.h
>>> +++ b/block/qcow2.h
>>
>> [...]
>>
>>> @@ -205,7 +206,8 @@ enum {
>>>      QCOW2_INCOMPAT_DATA_FILE        =3D 1 << QCOW2_INCOMPAT_DATA_FIL=
E_BITNR,
>>> =20
>>>      QCOW2_INCOMPAT_MASK          =3D QCOW2_INCOMPAT_DIRTY
>>> -                                 | QCOW2_INCOMPAT_CORRUPT,
>>> +                                 | QCOW2_INCOMPAT_CORRUPT
>>> +                                 | QCOW2_INCOMPAT_DATA_FILE,
>>
>> This hunk seems to belong somewhere else.
>=20
> Isn't this the first patch that actually allows opening images that hav=
e
> QCOW2_INCOMPAT_DATA_FILE set in their header?

Oh, sorry.  I thought the mask was the mask of all incompatible
features, but it's actually the mask of supported incompatible features.
 Yep, then it's correct here.

>>>  };
>>> =20
>>>  /* Compatible feature bits */
>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>> index ac9934b3ed..376232d3f0 100644
>>> --- a/block/qcow2.c
>>> +++ b/block/qcow2.c
>>> @@ -1441,8 +1441,22 @@ static int coroutine_fn qcow2_do_open(BlockDri=
verState *bs, QDict *options,
>>>          goto fail;
>>>      }
>>> =20
>>> -    /* TODO Open external data file */
>>> -    s->data_file =3D bs->file;
>>> +    /* Open external data file */
>>> +    if (s->incompatible_features & QCOW2_INCOMPAT_DATA_FILE) {
>>> +        s->data_file =3D bdrv_open_child(NULL, options, "data-file",=
 bs,
>>> +                                       &child_file, false, errp);
>>> +        if (!s->data_file) {
>>> +            ret =3D -EINVAL;
>>> +            goto fail;
>>> +        }
>>> +    } else if (qdict_get(options, QCOW2_OPT_DATA_FILE)) {
>>
>> I get the idea, but this isn't crumpled so this key may not exist (but=

>> data-file.driver and data-file.filename may).  Of course the fact that=

>> these options remain unused will be caught by the block layer, but tha=
t
>> makes the error message below a bit less useful.
>=20
> Hmm, good point... So you'd just leave out the check and always let the=

> block layer complain (with a less than helpful message)? Or are you
> suggesting I should try and catch all cases somehow, even if that makes=

> things quite a bit more complicated?

I don't mind either way.  Nice error messages are nice as long as
they're not too much trouble.  It's just that this current state feels a
bit half-baked.

Max


--vUnbWGt3DM6SVdw7CFPAXPESbVPJV8eUQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxwA2sACgkQ9AfbAGHV
z0BFQQf/cIJsOkgsK2oTvMy0yhFuvfBiTXAaFYCOQpq3CsUw24bnFwvV1McStxqT
71A6yjmBkO86hJG4ej9w2ci6WYg3Ox7Qq97r/DJIb/0JI1PRnEf9GFmZE/vli6tJ
ArQPX2YPXLlNU34PXsNbzSij7eO+niWREMGoUkfI5QR9cCvdNgYBtP+vupupnbcp
MTjm84fMtRGhTvfICQNicry/nKcLp863V224+JgPPiu4AKRqlvgGEWLnB938QRZx
fwlBdKIgt7r7oKGw/qjAVLheBk4FrmcEh9e6KtGfc5uAxlblp6uJ07y46aOPyruM
6yx4l7m/DpS62NP6JWk0ZFgNpdW0eg==
=wja1
-----END PGP SIGNATURE-----

--vUnbWGt3DM6SVdw7CFPAXPESbVPJV8eUQ--
