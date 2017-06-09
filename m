Received: from eggs.gnu.org ([2001:4830:134:3::10]:48741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dJMRA-000643-B6
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 12:07:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dJMR4-0002VK-8c
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 12:07:00 -0400
Received: from smtp1.ntua.gr ([2001:648:2000:de::183]:33040)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dJMR3-0002Sm-Ph
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 12:06:54 -0400
Date: Fri, 9 Jun 2017 19:06:09 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170609160609.r2ivmny4pqvycwp5@postretch>
References: <20170608182113.nmxnvus26vplg5du@postretch>
	<w51k24ll1ke.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nmdy3ebfreoa3ajh"
Content-Disposition: inline
In-Reply-To: <w51k24ll1ke.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [Proposal] I/O throttling through new -object
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>


--nmdy3ebfreoa3ajh
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 09, 2017 at 03:42:41PM +0200, Alberto Garcia wrote:
>Hey Manos, thanks for your proposal and for the good work :)
>
>On Thu 08 Jun 2017 08:21:13 PM CEST, Manos Pitsidianakis wrote:
>
>> As part of my GSoC project, IO throttling is moved to a block filter
>> driver, which means multiple filter nodes sharing ThrottleGroup
>> instances, and also, chaining filter nodes. The old interface will be
>> retained as much as possible. By defining ThrottleGroups with QOM the
>> following interface can be used:
>>     -drive file=3Dfoo.qcow2,throttling.group=3Dbar \
>>     -object throttle-group,iops-total=3D100,id=3Dbar
>
>It should be --object

Both seem to have the result in my qemu build.

>, and I guess the name would be throttling-group?

Hm, I thought throttle-group would be nicer because it's shorter, but I=20
can change it, of course. I am not certain if there's a semantic=20
difference (because I am not a native speaker).

>
>> 'block_set_io_throttle' command can be extended with a "group"
>> argument, that when defined instead of "device", will find and edit
>> the object in question.
>
>Note that block_set_io_throttle() already has a 'group' argument. Its
>current semantics are:
>
>   - bps or iops !=3D 0   -> set the I/O limits of a throttling group. The
>                           selected device is moved to that group if it
>                           wasn't there yet.
>
>   - bps and iops =3D=3D 0  -> remove a device from a throttling group
>                           without touching that group's I/O limits.
>
>where 'device' is mandatory and 'group' defaults to the value of
>'device' if unset.
>
>If I get it right, what you propose is that 'device' is optional and in
>that case 'group' is mandatory and the command updates the throttling
>group parameters.
>
>Note that you can do that already if you select a device that is already
>in the group. These new semantics would allow modifying a group that is
>not being used by any block device.

That was my thinking as well.
>
>I'm not a big fan of overloading block_set_io_throttle() even more, but
>this proposal does actually sound fine.
>
>> Users can hotplug ThrottleGroups with object-add in QMP/HMP, then
>> attach drives to a throttle group (ie adding a filter node in the
>> drive path that points to that throttle group) with an
>> 'attach-throttle' and detach with 'detach-throttle', each taking the
>> drive and throttle group name as arguments. An alternative (but
>> uglier) approach would be to use 'block_set_io_throttle' for this as
>> well.
>
>Yeah I agree that the block_set_io_throttle() approach would be uglier.
>
>> Something that's also sound is a 'block_set_throttle_groups' that
>> takes a list of groups and a drive as arguments.
>
>Would that simply be a foreach(g, groups) { attach(device, g); } ?

Something like=20

foreach(g, groups) { attach(device, g); }
foreach(g, device.groups - groups) { detach(device, g); } #where '-' is=20
the set minus operation)

This would mean you would have to redefine previous groups as well=20
everytime you use 'block_set_throttle_groups' otherwise they would get=20
removed from the device. At least that's a way to avoid using more=20
commands for attaching/detaching.
>
>> Regarding 'query-block'. This case is complicated by the fact that it
>> would be possible for a drive to have many nodes, thus the values
>> printed by 'query-block' might be inaccurate if they only report one
>> of the node configurations.  The current approach is to report only
>> the first filter node in the BDS tree. A user with advanced throttling
>> configurations might have no need for this command.
>
>I guess the user can use 'query-block' and walk the backing chain
>looking for throttling filter nodes?

I think it would be trivial to do this. Isn't the BDS tree always=20
"short"? Otherwise the filter nodes should be cached in BlockBackend for=20
performance, if it can be argued that it's needed.
>
>Berto
>

--nmdy3ebfreoa3ajh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlk6x3EACgkQc2J8L2kN
9xDdPxAAmte+fBD4PWbVzWVMbK6xrD0TM5Q6ddWSfr02I38EY/TXUtSESX1LPCYm
eIHIZpwexIzsrJWNIVWOLb56vn+qqSz9Kbr+rUCVgk3Iya5wGJggxjp97jsAwCPe
PsJpOHKo6+J/258aQCTJV5akEmy1hetUVSTf9R+Wh8zO8/obb4ssler3TXBzvEEw
1qXzUcyh13ctw9V28A9xub2jw3hq8NXc1rrRXDWXah/MwX31zpYcKEafaoZ+11dC
GfnihC0g2CLX3i4HJTDfE2vcBC8B+QNldyMGLfqRJEx3/T4oT6OpodXBtiQQ8l/A
3FPd1CQnOXMyovmHNXQsAULbypfbhPYY4DDEVmd9EHrsLxrKpDkYBzN8RbS6a78o
NVVH5u+Zwof7pUNyz7l+Hwe79LaTVI8OI6wQ0lhQePXKkj/6pSJuk6CJZxuURg9B
VgdA9xVUQWPforXv1ElI3VSa/L7G96Q7rOGLVbKwwYCfIfnSk1+O/SZQuJLpxH4a
ArF3e/dW0FnqDllKXMCs/FiuiU5k54eGcyPvqN6xD/W+p5VcYamb4C4ets9/5H+3
TD6j41L6mPI1GzLthuR2LvbbOYso9etudIVLWdzDjmEHzZsEneymcQDiDCsQdMog
+/joyllInbawztNJVq4Wz8xRRGsqTTZPehID0g989g0iKXrH6qY=
=BI7x
-----END PGP SIGNATURE-----

--nmdy3ebfreoa3ajh--
