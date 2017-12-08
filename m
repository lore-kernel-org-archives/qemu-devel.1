Received: from eggs.gnu.org ([2001:4830:134:3::10]:59435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eNIsL-0004kg-Ju
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 08:39:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eNIsH-0006Au-9V
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 08:39:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1eNIsG-000682-Vv
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 08:39:33 -0500
References: <CAJqJJggWTki8i_U7xr2oRSFR4sZt4eK5hRO+B55iOYVMyfGwDg@mail.gmail.com>
	<20171206091243.GC4207@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <cd42e58f-4a00-de18-446f-7e2275421992@redhat.com>
Date: Fri, 8 Dec 2017 14:39:26 +0100
MIME-Version: 1.0
In-Reply-To: <20171206091243.GC4207@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1U9RBaCEh0eX9K91buLOD0TxkGrwNWPPP"
Subject: Re: [Qemu-devel] About [PULL 20/25] block: Guard against NULL
 bs->drv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Kangjie Xi <imxikangjie@gmail.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1U9RBaCEh0eX9K91buLOD0TxkGrwNWPPP
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Kangjie Xi <imxikangjie@gmail.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>
Message-ID: <cd42e58f-4a00-de18-446f-7e2275421992@redhat.com>
Subject: Re: About [PULL 20/25] block: Guard against NULL bs->drv
References: <CAJqJJggWTki8i_U7xr2oRSFR4sZt4eK5hRO+B55iOYVMyfGwDg@mail.gmail.com>
 <20171206091243.GC4207@localhost.localdomain>
In-Reply-To: <20171206091243.GC4207@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-12-06 10:12, Kevin Wolf wrote:
> Am 06.12.2017 um 08:28 hat Kangjie Xi geschrieben:
>> Hi,
>>
>> I encountered a qemu-nbd segfault, finally I found it was caused by
>> NULL bs-drv,  which is located in block/io.c function bdrv_co_flush
>> line 2377:
>>
>> https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dblock/io.c;h=3D4fdf93a=
0144fa4761a14b8cc6b2a9a6b6e5d5bec;hb=3Dd470ad42acfc73c45d3e8ed5311a491160=
b4c100#l2377
>>
>> It is before the patch at line 2402, so the patch needs to be updated
>> to fix NULL bs-drv at line 2337.
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg03425.html
>=20
> Can you please post a full backtrace? Do you see any error message
> on stderr before the process crashes?
>=20
> I don't see at the moment how this can happen, except the case that Max=

> mentioned where bs->drv =3D NULL is set when an image corruption is
> detected - this involves an error message, though.
>=20
> We check bdrv_is_inserted() as the first thing, which includes a NULL
> check for bs->drv. So it must have been non-NULL at the start of the
> function and then become NULL. I suppose this can theoretically happen
> in qemu_co_queue_wait() if another flush request detects image
> corruption.
>=20
> Max: I think bs->drv =3D NULL in the middle of a request was a stupid
> idea. In fact, it's already a stupid idea to have any BDS with
> bs->drv =3D NULL. Maybe it would be better to schedule a BH that replac=
es
> the qcow2 node with a dummy node (null-co?) and properly closes the
> qcow2 one.

Yes, that is an idea John had, too.  It sounded good to me (we'd just
need to add a new flag to null-co so it would respond with -ENOMEDIUM to
all requests or something)...  The only issue I had is how that would
work together with the GRAPH_MOD op blocker.

Max

>=20
> Kevin
>=20
>>> @@ -2373,6 +2399,12 @@ int coroutine_fn bdrv_co_flush(BlockDriverStat=
e *bs)
>>>      }
>>>
>>>      BLKDBG_EVENT(bs->file, BLKDBG_FLUSH_TO_DISK);
>>> +    if (!bs->drv) {
>>> +        /* bs->drv->bdrv_co_flush() might have ejected the BDS
>>> +         * (even in case of apparent success) */
>>> +        ret =3D -ENOMEDIUM;
>>> +        goto out;
>>> +    }
>>>      if (bs->drv->bdrv_co_flush_to_disk) {
>>>          ret =3D bs->drv->bdrv_co_flush_to_disk(bs);
>>>      } else if (bs->drv->bdrv_aio_flush) {
>>
>> I have tested the latest qemu-2.11.0-rc2 and I am sure the qemu-nbd
>> segfault is caused by NULL bs-drv in block/io.c line 2337.
>>
>> kernel: qemu-nbd[18768]: segfault at f8 ip 000055a24f7536a7 sp
>> 00007f59b1137a40 error 4 in qemu-nbd[55a24f6d1000+188000]
>>
>> However I have no methods to reproduce the segfault manually, the
>> qemu-nbd segfaut just occurs in my server cluster every week.
>>
>> Thanks
>> -Kangjie



--1U9RBaCEh0eX9K91buLOD0TxkGrwNWPPP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloqlg4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A5ZQH/RBAby68JDjlwLW9X1U1TpQrM5WOBjf7
SxNvZBZ5dbB5a6Fq+XBKgPbHj2cuOhiPqrCalZYKiVlFtj022nJqkRFpg8axCW2i
j4XUNC/n3SgQAyNmC3yPWBxulaYBuWWES3I1GC1/FnJwhk/WJOZNPYNjm7WraA44
OeTn7U+tDsJoZ55ephV2vPuFyJrbm7zTXOcOhPVYi9ZG0TE4DMWgX+jp+jfbFMko
aqEQrmmfRdZUeesjcTFyQlnzUia2HMYapEnAgouieKrAOsFVybtPnc+jB4gQivS/
B3Cjx5fV3eqE2OO/7hyoGltHz6k18vJcXJm3J3DN9lcd3XsJMug8X8o=
=SQb9
-----END PGP SIGNATURE-----

--1U9RBaCEh0eX9K91buLOD0TxkGrwNWPPP--
