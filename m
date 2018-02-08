Received: from eggs.gnu.org ([2001:4830:134:3::10]:59161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgard.kaziakhmedov@virtuozzo.com>)
	id 1ejodf-0003kg-VI
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:01:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgard.kaziakhmedov@virtuozzo.com>)
	id 1ejodc-0002Ro-Tn
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:01:32 -0500
References: <20180208132336.6519-1-edgar.kaziakhmedov@virtuozzo.com>
	<60f2b126-21f2-c46b-d4c9-143b28b1f613@redhat.com>
	<5e16ec84-cb79-33be-a90c-fbb411a832f9@virtuozzo.com>
	<1f510426-833b-522f-eee0-cecc473d66cf@redhat.com>
From: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
Message-ID: <f5edd803-9a1a-eb66-69e0-1deb7221ca6b@virtuozzo.com>
Date: Thu, 8 Feb 2018 19:01:23 +0300
MIME-Version: 1.0
In-Reply-To: <1f510426-833b-522f-eee0-cecc473d66cf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
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
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, nbd list <nbd@other.debian.org>



On 02/08/2018 06:55 PM, Eric Blake wrote:
> On 02/08/2018 09:28 AM, Edgar Kaziakhmedov wrote:
>
>>> We've got a potential problem.=C2=A0 Unless you have out-of-band=20
>>> communication of the maximum NBD_CMD_WRITE_ZEROES sizing (or if the=20
>>> NBD protocol is enhanced to advertise that as an additional piece of=20
>>> block size information during NBD_OPT_GO), then a client CANNOT=20
>>> assume that the server will accept a request this large. We MIGHT=20
>>> get lucky if all existing servers that accept WRITE_ZEROES requests=20
>>> either act on large requests or reply with EINVAL but do not=20
>>> outright drop the connection (which is different from servers that=20
>>> DO outright drop the connection for an NBD_CMD_WRITE larger than=20
>>> 32M).=C2=A0 But I don't know if that's how all servers behave, so sendi=
ng=20
>>> a too-large WRITE_ZEROES request may have the unintended consequence=20
>>> of killing the connection.
>> Actually, I do not understand why current NBD servers shouldn't=20
>> accept such large requests, because most servers should apply some=20
>> optimizations avoiding direct filling with zeroes.
>
> Just because a server CAN optimize doesn't mean that it is REQUIRED to=20
> optimize.=C2=A0 You cannot make assumptions that a server will be happy=20
> with a larger request, merely because less data was sent over the=20
> wire, because the server may still have to allocate memory locally to=20
> perform the request.
>
>> As for block-mirroring over NBD, it works fine with QEMU server=20
>> implementation and isn't it the main application?
>
> Yes, qemu-to-qemu interoperating as efficiently as possible is nice;=20
> but I'm worried about qemu-to-other interoperating as well. The point=20
> of a public specification is to avoid one-way silos, so that you CAN=20
> mix-and-match a server from one implementation with a client from=20
> another, rather than being forced to use qemu as the server when qemu=20
> is the client.=C2=A0 Note that portability can include hand-shaking to fa=
ll=20
> back to the least-common denominator, rather than requiring both sides=20
> to always understand all extensions; but the important part is that=20
> neither party should make assumptions about the other side without=20
> using the spec as their guide.
So, in that case it is required to negotiate about the biggest=20
write_zero chunk size before communication, if such option is featured=20
in mainline NBD.
