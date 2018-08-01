Received: from eggs.gnu.org ([2001:4830:134:3::10]:32811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fkt9J-0005Vr-PJ
	for Qemu-devel@nongnu.org; Wed, 01 Aug 2018 11:34:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fkt9G-00028U-K5
	for Qemu-devel@nongnu.org; Wed, 01 Aug 2018 11:34:53 -0400
References: <20180731180033.GA1455@redhat.com>
	<e6627b0e-3939-7b4e-3482-6a6be49e6b58@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <732fb983-2f3c-d90e-a7e7-2a77929a03c2@redhat.com>
Date: Wed, 1 Aug 2018 10:34:48 -0500
MIME-Version: 1.0
In-Reply-To: <e6627b0e-3939-7b4e-3482-6a6be49e6b58@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu NBD client behaviour when device size is not
 a multiple of 512
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>, qemu-block <qemu-block@nongnu.org>, "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>

On 07/31/2018 01:25 PM, Eric Blake wrote:
> On 07/31/2018 01:00 PM, Richard W.M. Jones wrote:
>>
>> Hi Eric.=C2=A0 Is this a bug?
>>

>=20
> Note that with qemu as server:
>=20
> $ truncate --size=3D1023 file
> $ qemu-nbd -f raw -x '' file
>=20
> the client now sees:
>=20
> 423068@1533060754.229106:nbd_opt_go_info_block_size Block sizes are=20
> 0x200, 0x1000, 0x2000000
> ...
> 423068@1533060754.229156:nbd_receive_negotiate_size_flags Size is 1024,=
=20
> export flags 0x1ed
>=20
> where qemu as server is 0-padding the source file in all read requests;=
=20
> and that probably explains why I haven't noticed the problem with=20
> unaligned images in the client before (since qemu as NBD server doesn't=
=20
> advertise unaligned images).=C2=A0 What's more, a write request to the =
tail=20
> of the partial sector (when not using a read-only connection) succeeds,=
=20
> and resizes the file in the process (at least, on protocols that suppor=
t=20
> live resizing); but I wouldn't count on it behaving sanely for all=20
> protocols.

What's more, with qemu as server, then 'qemu-img map' as client dies=20
because the server is sending incorrect data according to protocol.

> At any rate, you've given me plenty to work with for fixing things,=20
> although it probably won't make it into 3.0-rc3 and I don't know if=20
> we'll have an -rc4.

Not a regression introduce in 3.0 (it exists in 2.12), so not serious=20
enough of a show-stopper to cause an -rc4 release.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
