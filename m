Received: from eggs.gnu.org ([2001:4830:134:3::10]:60974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cqjTZ-0007di-UV
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:51:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cqjTY-0007JM-Oq
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:51:10 -0400
References: <20170313214001.26339-1-mreitz@redhat.com>
	<20170313214001.26339-2-mreitz@redhat.com>
	<20170320101828.GC17887@stefanha-x1.localdomain>
	<56ea38e1-61fa-9339-741a-dbe8ceed8816@redhat.com>
	<20170322162859.GC16717@stefanha-x1.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <52aecf7b-5cd7-44d0-94bf-bce90588da32@redhat.com>
Date: Wed, 22 Mar 2017 17:50:59 +0100
MIME-Version: 1.0
In-Reply-To: <20170322162859.GC16717@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1mI91uHKlhOJKD3kNuLwCknPsDGG0BoCb"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10 01/16] block: Add
 PreallocMode to BD.bdrv_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1mI91uHKlhOJKD3kNuLwCknPsDGG0BoCb
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <52aecf7b-5cd7-44d0-94bf-bce90588da32@redhat.com>
Subject: Re: [Qemu-block] [PATCH for-2.10 01/16] block: Add PreallocMode to
 BD.bdrv_truncate()
References: <20170313214001.26339-1-mreitz@redhat.com>
 <20170313214001.26339-2-mreitz@redhat.com>
 <20170320101828.GC17887@stefanha-x1.localdomain>
 <56ea38e1-61fa-9339-741a-dbe8ceed8816@redhat.com>
 <20170322162859.GC16717@stefanha-x1.localdomain>
In-Reply-To: <20170322162859.GC16717@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 22.03.2017 17:28, Stefan Hajnoczi wrote:
> On Mon, Mar 20, 2017 at 04:07:16PM +0100, Max Reitz wrote:
>> On 20.03.2017 11:18, Stefan Hajnoczi wrote:
>>> On Mon, Mar 13, 2017 at 10:39:46PM +0100, Max Reitz wrote:
>>>> diff --git a/block/iscsi.c b/block/iscsi.c
>>>> index ab559a6f71..5d6265c4a6 100644
>>>> --- a/block/iscsi.c
>>>> +++ b/block/iscsi.c
>>>> @@ -2060,11 +2060,16 @@ static void iscsi_reopen_commit(BDRVReopenSt=
ate *reopen_state)
>>>>      }
>>>>  }
>>>> =20
>>>> -static int iscsi_truncate(BlockDriverState *bs, int64_t offset, Err=
or **errp)
>>>> +static int iscsi_truncate(BlockDriverState *bs, int64_t offset,
>>>> +                          PreallocMode prealloc, Error **errp)
>>>>  {
>>>>      IscsiLun *iscsilun =3D bs->opaque;
>>>>      Error *local_err =3D NULL;
>>>> =20
>>>> +    if (prealloc !=3D PREALLOC_MODE_OFF) {
>>>> +        return -ENOTSUP;
>>>> +    }
>>>> +
>>>>      if (iscsilun->type !=3D TYPE_DISK) {
>>>>          return -ENOTSUP;
>>>>      }
>>>
>>> Nevermind what I said about adding a BiteSizedTasks entry:
>>>
>>> The missing errp usage is not in qemu.git/master yet.  Please fix up
>>> your bdrv_truncate() errp patch to use errp in all cases, e.g.
>>> error_setg("Unable to truncate non-disk LUN").
>>
>> The thing is that I wasn't comfortable doing that for all block driver=
s.
>> I mean, I can take another look but I'd rather have vague error messag=
es
>> ("truncation failed: #{strerror}") than outright wrong ones because I
>> didn't know what error message to use.
>>
>> Of course you could argue that this may probably come out during revie=
w
>> but that implies that every submaintainer for every block driver would=

>> actually come out for review...
>=20
> I'm worried about errp being set in only a subset of error cases.
>=20
> This is likely to cause bugs if callers use if (local_err).  Grepping
> through the codebase I can see instances of:

Yes, but the generic bdrv_truncate() will always set errp if the driver
hasn't done so.

Max

>   ret =3D foo(..., &local_err);
>   if (local_err) { /* no ret check! */
>       ...
>   }
>=20
> The code would work fine with qcow2 but not iscsi, for example.
>=20
> IMO we should always set errp, even if the error message is vague
> ("truncation failed: #{strerror}").
>=20
> Stefan
>=20



--1mI91uHKlhOJKD3kNuLwCknPsDGG0BoCb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljSq3MSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AQMIH/jc1ZKVrfqgJJYrWJ62rbvQ8UZSg2U5i
Vro9irK/xUKv0wFr6UYDFDk8EETzvEjINTODYbXTpBUAc9Wfp15NnsiO3Ry3S33p
y1wqoSljVLx8SfQBwk3QfWeV5PfCTS41ldUMrF/hl1Zm2OoJAOZfAHn0jx97gCZg
T51DLDkQF0lev2ewYRI0h74rMD7NEpS5D+qjtvYO1xcgtuE24up9giwuyG2ILFly
PvD1fcdBEGbYolTwFAtUXLdl7eii9ThKE4b+6FlYaZrcLGvqkYlKlF5jigJ/ur+/
YfynE76j1oUhPkKlgdZE2uyKYMSX84UtyUVsJTFi9PdVQIjt0I1HuAc=
=UV7J
-----END PGP SIGNATURE-----

--1mI91uHKlhOJKD3kNuLwCknPsDGG0BoCb--
