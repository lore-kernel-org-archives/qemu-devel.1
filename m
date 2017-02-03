Received: from eggs.gnu.org ([2001:4830:134:3::10]:44561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZk4K-0003ds-OD
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 15:02:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZk4J-00013y-N4
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 15:02:52 -0500
References: <87bmukmlau.fsf@dusky.pond.sub.org>
	<20170202202739.GA15804@work-vm> <87shnvhfwc.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6e65ad3c-db00-0ce5-a9c6-0e8ba84ad3c6@redhat.com>
Date: Fri, 3 Feb 2017 21:02:42 +0100
MIME-Version: 1.0
In-Reply-To: <87shnvhfwc.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cKIKgm4JTH8H4QBiLhNaspa8t16ufmE1n"
Subject: Re: [Qemu-devel] [Qemu-block] Non-flat command line option argument
 syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cKIKgm4JTH8H4QBiLhNaspa8t16ufmE1n
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <6e65ad3c-db00-0ce5-a9c6-0e8ba84ad3c6@redhat.com>
Subject: Re: [Qemu-block] [Qemu-devel] Non-flat command line option argument
 syntax
References: <87bmukmlau.fsf@dusky.pond.sub.org>
 <20170202202739.GA15804@work-vm> <87shnvhfwc.fsf@dusky.pond.sub.org>
In-Reply-To: <87shnvhfwc.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 03.02.2017 08:50, Markus Armbruster wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
>=20
>> * Markus Armbruster (armbru@redhat.com) wrote:
>>> =3D Introduction =3D
>>>
>>
>> <snip>
>>
>>> =3D Structured option argument syntax =3D
>>>
>>> =3D=3D JSON =3D=3D
>>>
>>> The obvious way to provide the expressiveness of JSON on the command
>>> line is JSON.  Easy enough[2].  However, besides not being compatible=
,
>>> it's rather heavy on syntax, at least for simple cases.  Compare:
>>>
>>>     -machine q35,accel=3Dkvm
>>>     -machine '{ "type": "q35", "accel": "kvm"}'
>>>
>>> It compares a bit more favourably in cases that use our non-flat hack=
s.
>>> Here's a flat list as KEY=3DVALUE,... with repeated keys, and as JSON=
:
>>>
>>>     -semihosting-config enable,arg=3Deins,arg=3Dzwei,arg=3Ddrei
>>>     -semihosting-config '{ "enable": true, "arg": [ "eins", "zwei", "=
drei" ] }'
>>>
>>> Arbitrary nesting with dotted key convention:
>>>
>>>     -drive driver=3Dqcow2,file.driver=3Dgluster,
>>>            file.volume=3Dtestvol,file.path=3D/path/a.qcow2,file.debug=
=3D9,
>>>            file.server.0.type=3Dtcp,
>>>            file.server.0.host=3D1.2.3.4,
>>>            file.server.0.port=3D24007,
>>>            file.server.1.type=3Dunix,
>>>            file.server.1.socket=3D/var/run/glusterd.socket
>>>     -drive '{ "driver": "qcow2",
>>>               "file": {
>>>                   "driver": "gluster", "volume": "testvol",
>>>                   "path": "/path/a.qcow2", "debug": 9,
>>>                   "server": [ { "type": "tcp",
>>>                                 "host": "1.2.3.4", "port": "24007"},
>>>                               { "type": "unix",
>>>                                 "socket": "/var/run/glusterd.socket" =
} ] } }'
>>
>> So while I generally hate JSON, the -drive dotted key syntax makes
>> me mad when it gets like this;  have a look
>> at the block replication and quorum setups especially, that can end up=

>> with (from docs/COLO-FT.txt):
>>
>>   -drive if=3Dvirtio,id=3Dprimary-disk0,driver=3Dquorum,read-pattern=3D=
fifo,vote-threshold=3D1,\
>>          children.0.file.filename=3D1.raw,\
>>          children.0.driver=3Draw -S
>>
>>    that's just way too many .'s to ever properly understand.
>> (I'm sure it used to be more complex).
>=20
> Here's an idea to cut down on the dottery that drives you mad (and me
> too): if KEY starts with '.', combine it with a prefix of the previous
> one so that the result has the same number of name components.
>=20
> Your example becomes
>=20
>     -drive if=3Dvirtio,id=3Dprimary-disk0,driver=3Dquorum,read-pattern=3D=
fifo,vote-threshold=3D1,\
>            children.0.file.filename=3D1.raw,.driver=3Draw -S

No, the last option would be children.0.file.driver=3Draw when expanded
(which is wrong, it should be children.0.driver).

>=20
> My example
>=20
>      -drive driver=3Dqcow2,file.driver=3Dgluster,
>             file.volume=3Dtestvol,file.path=3D/path/a.qcow2,file.debug=3D=
9,
>             file.server.0.type=3Dtcp,
>             file.server.0.host=3D1.2.3.4,
>             file.server.0.port=3D24007,
>             file.server.1.type=3Dunix,
>             file.server.1.socket=3D/var/run/glusterd.socket
>=20
> becomes
>=20
>      -drive driver=3Dqcow2,
>             file.driver=3Dgluster,
>                 .volume=3Dtestvol,
>                 .path=3D/path/a.qcow2,
>                 .debug=3D9,
>             file.server.0.type=3Dtcp,
>                          .host=3D1.2.3.4,
>                          .port=3D24007,
>             file.server.1.type=3Dunix,
>                          .socket=3D/var/run/glusterd.socket
>=20
> Mind, I'm not at all sure this is a *good* idea.  I suspect it's more
> magic than it's worth.

As someone who likes dot syntax very much, I don't like it. If you
structure it like this, it's OK, but then you can just write the full
prefix (which gets the point across just as well because I can quickly
tell from a glance that it's the same prefix).

OTOH, when joined into a single line it doesn't change much in terms of
legibility, in my opinion.

Max


--cKIKgm4JTH8H4QBiLhNaspa8t16ufmE1n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliU4eISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AEfMIAK2hF3EtquvgLwSDYszNY4tdlzGPD/Xn
KZtxGGmAvTrANaulckHNqifpfL+CyLX0CCTtK9NgnO/l4aADxxxPbC6f4+535ZG6
ofsSMrSQ9F0JmJnmU49wT5K6pHG0TSIR7pSSsCM7+4otqDeraXfbl967Hkk8Dqpj
5GfosDXHvsvhBLNc6llP+f+Ga9Qvig1gO0mH05W23xu7d+CzK6pjGHzbGNtXNL4g
RTWnGZ112fUQm5w/7akMSCw6iBMqmCv8OOxeVD2msXjX9Bh5RqHUEl+ukRouJ6xW
HISHV220KZal3kIiuIsgZSz1rEEm4KATr7NI2jTY4rVPkl8qaZKACRw=
=5cOX
-----END PGP SIGNATURE-----

--cKIKgm4JTH8H4QBiLhNaspa8t16ufmE1n--
