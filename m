Received: from eggs.gnu.org ([209.51.188.92]:59628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gxD0i-0007se-Gc
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:45:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gxD0h-00043U-Hi
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:45:12 -0500
References: <20190131175549.11691-1-kwolf@redhat.com>
	<20190131175549.11691-9-kwolf@redhat.com>
	<67996e1d-1d6f-2990-3b96-22554f261029@redhat.com>
	<20190219085141.GC4727@localhost.localdomain>
	<1a598bde-1921-3253-ff83-967927e45669@redhat.com>
	<20190222153853.GC8035@dhcp-200-176.str.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <be812a73-1d72-0dae-9cc9-3a819e42cba5@redhat.com>
Date: Fri, 22 Feb 2019 16:45:04 +0100
MIME-Version: 1.0
In-Reply-To: <20190222153853.GC8035@dhcp-200-176.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="u4TWsUbZTzOF2DwaZC5F1Om7z6acdRSLI"
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
--u4TWsUbZTzOF2DwaZC5F1Om7z6acdRSLI
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, qemu-devel@nongnu.org
Message-ID: <be812a73-1d72-0dae-9cc9-3a819e42cba5@redhat.com>
Subject: Re: [RFC PATCH 08/11] qcow2: Add basic data-file infrastructure
References: <20190131175549.11691-1-kwolf@redhat.com>
 <20190131175549.11691-9-kwolf@redhat.com>
 <67996e1d-1d6f-2990-3b96-22554f261029@redhat.com>
 <20190219085141.GC4727@localhost.localdomain>
 <1a598bde-1921-3253-ff83-967927e45669@redhat.com>
 <20190222153853.GC8035@dhcp-200-176.str.redhat.com>
In-Reply-To: <20190222153853.GC8035@dhcp-200-176.str.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 22.02.19 16:38, Kevin Wolf wrote:
> Am 22.02.2019 um 15:12 hat Max Reitz geschrieben:
>> On 19.02.19 09:51, Kevin Wolf wrote:
>>> Am 19.02.2019 um 00:57 hat Max Reitz geschrieben:
>>>> On 31.01.19 18:55, Kevin Wolf wrote:
>>>>> This adds a .bdrv_open option to specify the external data file nod=
e.
>>>>>
>>>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>>>> ---
>>>>>  qapi/block-core.json |  3 ++-
>>>>>  block/qcow2.h        |  4 +++-
>>>>>  block/qcow2.c        | 25 +++++++++++++++++++++++--
>>>>>  3 files changed, 28 insertions(+), 4 deletions(-)
>>>>
>>>> [...]
>>>>
>>>>> diff --git a/block/qcow2.h b/block/qcow2.h
>>>>> index c161970882..e2114900b4 100644
>>>>> --- a/block/qcow2.h
>>>>> +++ b/block/qcow2.h
>>>>
>>>> [...]
>>>>
>>>>> @@ -205,7 +206,8 @@ enum {
>>>>>      QCOW2_INCOMPAT_DATA_FILE        =3D 1 << QCOW2_INCOMPAT_DATA_F=
ILE_BITNR,
>>>>> =20
>>>>>      QCOW2_INCOMPAT_MASK          =3D QCOW2_INCOMPAT_DIRTY
>>>>> -                                 | QCOW2_INCOMPAT_CORRUPT,
>>>>> +                                 | QCOW2_INCOMPAT_CORRUPT
>>>>> +                                 | QCOW2_INCOMPAT_DATA_FILE,
>>>>
>>>> This hunk seems to belong somewhere else.
>>>
>>> Isn't this the first patch that actually allows opening images that h=
ave
>>> QCOW2_INCOMPAT_DATA_FILE set in their header?
>>
>> Oh, sorry.  I thought the mask was the mask of all incompatible
>> features, but it's actually the mask of supported incompatible feature=
s.
>>  Yep, then it's correct here.
>>
>>>>>  };
>>>>> =20
>>>>>  /* Compatible feature bits */
>>>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>>>> index ac9934b3ed..376232d3f0 100644
>>>>> --- a/block/qcow2.c
>>>>> +++ b/block/qcow2.c
>>>>> @@ -1441,8 +1441,22 @@ static int coroutine_fn qcow2_do_open(BlockD=
riverState *bs, QDict *options,
>>>>>          goto fail;
>>>>>      }
>>>>> =20
>>>>> -    /* TODO Open external data file */
>>>>> -    s->data_file =3D bs->file;
>>>>> +    /* Open external data file */
>>>>> +    if (s->incompatible_features & QCOW2_INCOMPAT_DATA_FILE) {
>>>>> +        s->data_file =3D bdrv_open_child(NULL, options, "data-file=
", bs,
>>>>> +                                       &child_file, false, errp);
>>>>> +        if (!s->data_file) {
>>>>> +            ret =3D -EINVAL;
>>>>> +            goto fail;
>>>>> +        }
>>>>> +    } else if (qdict_get(options, QCOW2_OPT_DATA_FILE)) {
>>>>
>>>> I get the idea, but this isn't crumpled so this key may not exist (b=
ut
>>>> data-file.driver and data-file.filename may).  Of course the fact th=
at
>>>> these options remain unused will be caught by the block layer, but t=
hat
>>>> makes the error message below a bit less useful.
>>>
>>> Hmm, good point... So you'd just leave out the check and always let t=
he
>>> block layer complain (with a less than helpful message)? Or are you
>>> suggesting I should try and catch all cases somehow, even if that mak=
es
>>> things quite a bit more complicated?
>>
>> I don't mind either way.  Nice error messages are nice as long as
>> they're not too much trouble.  It's just that this current state feels=
 a
>> bit half-baked.
>=20
> I think catching everything is just not worth the effort. So I
> considered dropping the check. But then I thought that this half baked
> check will make sure that we'll get full coverage once qcow2 is
> converted to a QAPI-based open interface instead of forgetting to bring=

> the check back. So I'm leaning towards just leaving it as it is now. If=

> you like, I can add a comment that we know this is half baked.

"Once"... :-)

Seems reasonable to me.

Max


--u4TWsUbZTzOF2DwaZC5F1Om7z6acdRSLI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxwGQAACgkQ9AfbAGHV
z0CUpwf/bjnV+3Qm9w61QYb/jRHIJFU8S0JCCSJklCXdGSh6y+2v5JpDNxWh5jOP
kO9ZCsunwSMi5BBvGIw6lAE1Jqi4iF5O18zt1WpsTkC5Fea7jNmNO3DrVXZzuo9e
XRIKsYBbUZInqdTpCS8Ea74mvWdbCiXr3zk9spyNI1/bkk8nh9f0+9v0Q7A+ogfA
644r37dSRW1euEw5biGYoyoK3N++QCiUVJuxQQHpb1T+0LYVOcWzK/7g5t3KuQ6P
6CrkG7PBAacLu48cnuw064NRzgI0FzOq7nkDyd0Z+liuKC+LAu8kaZS04L8wpvn1
LlSq3ZwZvusBaUML95IkpXP2SwF7Tg==
=RTfx
-----END PGP SIGNATURE-----

--u4TWsUbZTzOF2DwaZC5F1Om7z6acdRSLI--
