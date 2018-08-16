Received: from eggs.gnu.org ([2001:4830:134:3::10]:51038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fq8U5-0004o0-0J
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 22:58:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fq8Ty-0000Sm-VD
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 22:58:00 -0400
References: <20180815025614.53588-1-eblake@redhat.com>
	<20180815025614.53588-3-eblake@redhat.com>
	<48010463-405e-bb08-f9c5-8263dcf3bb48@redhat.com>
	<4aa899d3-c622-6acf-128c-513f95c55ed5@redhat.com>
	<d8c5df8d-7ae2-8ddc-aa71-38ec06b79988@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <58ddf808-3d02-92e8-fa8e-a25339577bfb@redhat.com>
Date: Wed, 15 Aug 2018 21:57:38 -0500
MIME-Version: 1.0
In-Reply-To: <d8c5df8d-7ae2-8ddc-aa71-38ec06b79988@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-img: Add dd seek= option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: fullmanet@gmail.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On 08/15/2018 09:49 PM, Max Reitz wrote:

>>> In my opinion, we do not want feature parity with dd.=C2=A0 What we d=
o want
>>> is feature parity with convert.
>>
>> Well, convert is lacking a way to specify a subset of one file to move
>> to a (possibly different) subset of the other.=C2=A0 I'm fine if we wa=
nt to
>> enhance convert to do the things that right now require a dd-alike
>> interface (namely, limiting the copying to less than the full file, an=
d
>> choosing the offset at which to start [before this patch] or write to
>> [with this patch]).
>=20
> Yes, I would want that.
>=20
>> If convert were more powerful, I'd be fine dropping 'qemu-img dd' afte=
r
>> a proper deprecation period.
>=20
> Technically it has those features already, with the raw block driver's
> offset and size parameters.

Perhaps so, but it will be an interesting exercise in rewriting the=20
shorthand nbd://host:port/export into the proper longhand driver syntax.


>>
>> Because of performance: qemu-nbd + Linux nbd device + real dd is one
>> more layer of data copying (each write() from dd goes to kernel, then =
is
>> sent to qemu-nbd in userspace as a socket message before being sent ba=
ck
>> to the kernel to actually write() to the final destination) compared t=
o
>> just doing it all in one process (write() lands in the final destinati=
on
>> with no further user space bouncing).=C2=A0 And because the additional=
 steps
>> to set it up are awkward (see my other email where I rant about losing
>> the better part of today to realizing that 'dd ...; qemu-nbd -d
>> /dev/nbd1' loses data if you omit conv=3Dfdatasync).
>=20
> I can see the sync problems, but is the performance really that much wo=
rse?

When you don't have sparse file support, reading or writing large blocks=20
of zeroes really is worse over /dev/nbd* than over a server/client pair=20
that know how to do it efficiently.  But for non-sparse data, I don't=20
know if a benchmark would be able to consistently note a difference=20
(might be a fun benchmark for someone to try, but not high on my current=20
to-do list).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
