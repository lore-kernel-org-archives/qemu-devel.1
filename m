Received: from eggs.gnu.org ([2001:4830:134:3::10]:38368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eNJEs-0008GL-3C
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:02:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eNJEm-0003VW-GV
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:02:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1eNJEm-0003VQ-7A
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:02:48 -0500
References: <CAJqJJggWTki8i_U7xr2oRSFR4sZt4eK5hRO+B55iOYVMyfGwDg@mail.gmail.com>
	<20171206091243.GC4207@localhost.localdomain>
	<cd42e58f-4a00-de18-446f-7e2275421992@redhat.com>
	<20171208135139.GC4217@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b5011c59-f9aa-07d1-11e3-179c5f8e73a3@redhat.com>
Date: Fri, 8 Dec 2017 15:02:42 +0100
MIME-Version: 1.0
In-Reply-To: <20171208135139.GC4217@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IcpPEaOVOnR2hlDoi0ci4iMJdlkg6025n"
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: Kangjie Xi <imxikangjie@gmail.com>, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IcpPEaOVOnR2hlDoi0ci4iMJdlkg6025n
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Kangjie Xi <imxikangjie@gmail.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>
Message-ID: <b5011c59-f9aa-07d1-11e3-179c5f8e73a3@redhat.com>
Subject: Re: About [PULL 20/25] block: Guard against NULL bs->drv
References: <CAJqJJggWTki8i_U7xr2oRSFR4sZt4eK5hRO+B55iOYVMyfGwDg@mail.gmail.com>
 <20171206091243.GC4207@localhost.localdomain>
 <cd42e58f-4a00-de18-446f-7e2275421992@redhat.com>
 <20171208135139.GC4217@localhost.localdomain>
In-Reply-To: <20171208135139.GC4217@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2017-12-08 14:51, Kevin Wolf wrote:
> Am 08.12.2017 um 14:39 hat Max Reitz geschrieben:
>> On 2017-12-06 10:12, Kevin Wolf wrote:
>>> Am 06.12.2017 um 08:28 hat Kangjie Xi geschrieben:
>>>> Hi,
>>>>
>>>> I encountered a qemu-nbd segfault, finally I found it was caused by
>>>> NULL bs-drv,  which is located in block/io.c function bdrv_co_flush
>>>> line 2377:
>>>>
>>>> https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dblock/io.c;h=3D4fdf9=
3a0144fa4761a14b8cc6b2a9a6b6e5d5bec;hb=3Dd470ad42acfc73c45d3e8ed5311a4911=
60b4c100#l2377
>>>>
>>>> It is before the patch at line 2402, so the patch needs to be update=
d
>>>> to fix NULL bs-drv at line 2337.
>>>>
>>>> https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg03425.html
>>>
>>> Can you please post a full backtrace? Do you see any error message
>>> on stderr before the process crashes?
>>>
>>> I don't see at the moment how this can happen, except the case that M=
ax
>>> mentioned where bs->drv =3D NULL is set when an image corruption is
>>> detected - this involves an error message, though.
>>>
>>> We check bdrv_is_inserted() as the first thing, which includes a NULL=

>>> check for bs->drv. So it must have been non-NULL at the start of the
>>> function and then become NULL. I suppose this can theoretically happe=
n
>>> in qemu_co_queue_wait() if another flush request detects image
>>> corruption.
>>>
>>> Max: I think bs->drv =3D NULL in the middle of a request was a stupid=

>>> idea. In fact, it's already a stupid idea to have any BDS with
>>> bs->drv =3D NULL. Maybe it would be better to schedule a BH that repl=
aces
>>> the qcow2 node with a dummy node (null-co?) and properly closes the
>>> qcow2 one.
>>
>> Yes, that is an idea John had, too.  It sounded good to me (we'd just
>> need to add a new flag to null-co so it would respond with -ENOMEDIUM =
to
>> all requests or something)...  The only issue I had is how that would
>> work together with the GRAPH_MOD op blocker.
>=20
> In order to answer this question, I'd first have to understand what
> GRAPH_MOD is even supposed to mean and which operations it needs to
> protect. There aren't currently any users of GRAPH_MOD.

That is exactly the reason why we could not come to a conclusion. :-)

Max


--IcpPEaOVOnR2hlDoi0ci4iMJdlkg6025n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloqm4ISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A4jMIAMAsdAwkGeDuxtCB6g9VkFuyOzCTNeql
sYyq3geH7c3epTaIsxCHghI7Lxsnjj/L5gk4gCN1lNQAqUCVYOGbvdq3haOZKOUn
Ad9SgZBBOP0p1nCuNBMi2CbFoDgr4qJh6lkV4RHjfXfk/aP3YKFwgpqyChUGQPRl
XJJNEEoUdnjPgoMHu0SuVyWI6B5SPe73rGr+ptIoO2Bpy7qq5adfflN6y7AAlnUP
uxMYhZrva7VhGI9LOK1ls4NqkIRJZzOVa8AYM+79Xg+ikybQhkAwvGCO8y9+0I48
JywEB51WjxxnOSxN/R1FqxO4X1xKsu+vuphZ5jxchbMhkHdl8TZJAUI=
=sQah
-----END PGP SIGNATURE-----

--IcpPEaOVOnR2hlDoi0ci4iMJdlkg6025n--
