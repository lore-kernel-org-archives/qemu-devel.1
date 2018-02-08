Received: from eggs.gnu.org ([2001:4830:134:3::10]:57717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejoYA-00017V-On
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:55:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejoY9-00075y-L3
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:55:50 -0500
References: <20180208132336.6519-1-edgar.kaziakhmedov@virtuozzo.com>
	<60f2b126-21f2-c46b-d4c9-143b28b1f613@redhat.com>
	<5e16ec84-cb79-33be-a90c-fbb411a832f9@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1f510426-833b-522f-eee0-cecc473d66cf@redhat.com>
Date: Thu, 8 Feb 2018 09:55:25 -0600
MIME-Version: 1.0
In-Reply-To: <5e16ec84-cb79-33be-a90c-fbb411a832f9@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] nbd: increase maximum size of the
 PWRITE_ZERO request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, nbd list <nbd@other.debian.org>

On 02/08/2018 09:28 AM, Edgar Kaziakhmedov wrote:

>> We've got a potential problem.=C2=A0 Unless you have out-of-band=20
>> communication of the maximum NBD_CMD_WRITE_ZEROES sizing (or if the=20
>> NBD protocol is enhanced to advertise that as an additional piece of=20
>> block size information during NBD_OPT_GO), then a client CANNOT assume=
=20
>> that the server will accept a request this large. We MIGHT get lucky=20
>> if all existing servers that accept WRITE_ZEROES requests either act=20
>> on large requests or reply with EINVAL but do not outright drop the=20
>> connection (which is different from servers that DO outright drop the=20
>> connection for an NBD_CMD_WRITE larger than 32M).=C2=A0 But I don't kn=
ow if=20
>> that's how all servers behave, so sending a too-large WRITE_ZEROES=20
>> request may have the unintended consequence of killing the connection.
> Actually, I do not understand why current NBD servers shouldn't accept=20
> such large requests, because most servers should apply some=20
> optimizations avoiding direct filling with zeroes.

Just because a server CAN optimize doesn't mean that it is REQUIRED to=20
optimize.  You cannot make assumptions that a server will be happy with=20
a larger request, merely because less data was sent over the wire,=20
because the server may still have to allocate memory locally to perform=20
the request.

> As for block-mirroring over NBD, it works fine with QEMU server=20
> implementation and isn't it the main application?

Yes, qemu-to-qemu interoperating as efficiently as possible is nice; but=20
I'm worried about qemu-to-other interoperating as well.  The point of a=20
public specification is to avoid one-way silos, so that you CAN=20
mix-and-match a server from one implementation with a client from=20
another, rather than being forced to use qemu as the server when qemu is=20
the client.  Note that portability can include hand-shaking to fall back=20
to the least-common denominator, rather than requiring both sides to=20
always understand all extensions; but the important part is that neither=20
party should make assumptions about the other side without using the=20
spec as their guide.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
