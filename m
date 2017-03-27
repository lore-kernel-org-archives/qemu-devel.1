Received: from eggs.gnu.org ([2001:4830:134:3::10]:47892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csVUp-0004zt-5s
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:19:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csVUo-0003Wr-4j
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:19:47 -0400
References: <20170313214001.26339-1-mreitz@redhat.com>
	<20170313214001.26339-2-mreitz@redhat.com>
	<20170320101828.GC17887@stefanha-x1.localdomain>
	<56ea38e1-61fa-9339-741a-dbe8ceed8816@redhat.com>
	<20170322162859.GC16717@stefanha-x1.localdomain>
	<52aecf7b-5cd7-44d0-94bf-bce90588da32@redhat.com>
	<20170323153241.GG12560@stefanha-x1.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8bc2b49b-3602-388e-c939-1a1a544ffe62@redhat.com>
Date: Mon, 27 Mar 2017 16:19:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170323153241.GG12560@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TJLPuTECpGFpGuXRO4FnMCW8vi4U13Vjq"
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
--TJLPuTECpGFpGuXRO4FnMCW8vi4U13Vjq
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <8bc2b49b-3602-388e-c939-1a1a544ffe62@redhat.com>
Subject: Re: [Qemu-block] [PATCH for-2.10 01/16] block: Add PreallocMode to
 BD.bdrv_truncate()
References: <20170313214001.26339-1-mreitz@redhat.com>
 <20170313214001.26339-2-mreitz@redhat.com>
 <20170320101828.GC17887@stefanha-x1.localdomain>
 <56ea38e1-61fa-9339-741a-dbe8ceed8816@redhat.com>
 <20170322162859.GC16717@stefanha-x1.localdomain>
 <52aecf7b-5cd7-44d0-94bf-bce90588da32@redhat.com>
 <20170323153241.GG12560@stefanha-x1.localdomain>
In-Reply-To: <20170323153241.GG12560@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 23.03.2017 16:32, Stefan Hajnoczi wrote:
> On Wed, Mar 22, 2017 at 05:50:59PM +0100, Max Reitz wrote:
>> On 22.03.2017 17:28, Stefan Hajnoczi wrote:
>>> On Mon, Mar 20, 2017 at 04:07:16PM +0100, Max Reitz wrote:
>>>> On 20.03.2017 11:18, Stefan Hajnoczi wrote:
>>>>> On Mon, Mar 13, 2017 at 10:39:46PM +0100, Max Reitz wrote:
>>>>>> diff --git a/block/iscsi.c b/block/iscsi.c
>>>>>> index ab559a6f71..5d6265c4a6 100644
>>>>>> --- a/block/iscsi.c
>>>>>> +++ b/block/iscsi.c
>>>>>> @@ -2060,11 +2060,16 @@ static void iscsi_reopen_commit(BDRVReopen=
State *reopen_state)
>>>>>>      }
>>>>>>  }
>>>>>> =20
>>>>>> -static int iscsi_truncate(BlockDriverState *bs, int64_t offset, E=
rror **errp)
>>>>>> +static int iscsi_truncate(BlockDriverState *bs, int64_t offset,
>>>>>> +                          PreallocMode prealloc, Error **errp)
>>>>>>  {
>>>>>>      IscsiLun *iscsilun =3D bs->opaque;
>>>>>>      Error *local_err =3D NULL;
>>>>>> =20
>>>>>> +    if (prealloc !=3D PREALLOC_MODE_OFF) {
>>>>>> +        return -ENOTSUP;
>>>>>> +    }
>>>>>> +
>>>>>>      if (iscsilun->type !=3D TYPE_DISK) {
>>>>>>          return -ENOTSUP;
>>>>>>      }
>>>>>
>>>>> Nevermind what I said about adding a BiteSizedTasks entry:
>>>>>
>>>>> The missing errp usage is not in qemu.git/master yet.  Please fix u=
p
>>>>> your bdrv_truncate() errp patch to use errp in all cases, e.g.
>>>>> error_setg("Unable to truncate non-disk LUN").
>>>>
>>>> The thing is that I wasn't comfortable doing that for all block driv=
ers.
>>>> I mean, I can take another look but I'd rather have vague error mess=
ages
>>>> ("truncation failed: #{strerror}") than outright wrong ones because =
I
>>>> didn't know what error message to use.
>>>>
>>>> Of course you could argue that this may probably come out during rev=
iew
>>>> but that implies that every submaintainer for every block driver wou=
ld
>>>> actually come out for review...
>>>
>>> I'm worried about errp being set in only a subset of error cases.
>>>
>>> This is likely to cause bugs if callers use if (local_err).  Grepping=

>>> through the codebase I can see instances of:
>>
>> Yes, but the generic bdrv_truncate() will always set errp if the drive=
r
>> hasn't done so.
>=20
> I prefer consistently setting errp to make patch review easy (no
> checking all callers to see how they behave), making it safe to
> copy-paste the code elsewhere, etc.

The thing is, there is only a single caller for all of the
BlockDriver.bdrv_truncate() functions and that is the generic
bdrv_truncate() function.

I mean, of course I can copy-paste my generic error message from the
global bdrv_truncate() function into every driver where I'm not sure
what error to emit, but I find that a bit... Well, it looks bad when you
just look at the code without the history behind it.

But since you insist, I'll do so gladly. :-)

Max

> It's safer to be consistent, can produce more detailed error messages,
> and the cost of writing error_setg() calls is low.  But it's a matter o=
f
> style, you've pointed out the code is technically correct right now.
>=20
> Stefan
>=20



--TJLPuTECpGFpGuXRO4FnMCW8vi4U13Vjq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljZH3gSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ADX0IALTqw/IZRAzK6z7puSx4ZVBFE1wQE6K0
S8/VgySJ33yW6D04xfUGvVR+c8FJAmMKmfMhegeTZaMnPs6O9xrITIMwunFLiEWA
DC3blymEpyvCEsUV1g6lqVDFj/gJU+eNjpqsu2qhUQVm8yXASKMmQrk2T/MuYu4H
POK5+ci+nW+I92w5ILaqxoF/0HbTLU0HA3Lr8iPQdlyB7d8ckGacHMSfTaEQEwPA
F3BWTGNcv1X1U5Uhd8GDm7SMDDHyRA/2mDSCZWOlDi3xXntbcA2tyJBsXPULlZKs
TM7Y/z1C+JMMxpWbuxrQMKaTbT3t3ggk+T5/ckfRBIzOWwF6rL8+y5U=
=UguB
-----END PGP SIGNATURE-----

--TJLPuTECpGFpGuXRO4FnMCW8vi4U13Vjq--
