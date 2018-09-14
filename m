Received: from eggs.gnu.org ([2001:4830:134:3::10]:59030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0sZn-0004dP-PR
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 14:12:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0sZm-0000Qe-Vd
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 14:12:19 -0400
References: <20180914165116.23182-1-vsementsov@virtuozzo.com>
	<05b6e954-744f-d52c-1f5e-51d52062e195@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ec75cbe9-8854-9323-db48-1783a657852f@redhat.com>
Date: Fri, 14 Sep 2018 13:12:04 -0500
MIME-Version: 1.0
In-Reply-To: <05b6e954-744f-d52c-1f5e-51d52062e195@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] nbd/server: fix bitmap export
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org
Cc: pbonzini@redhat.com, John Snow <jsnow@redhat.com>, den@openvz.org

On 9/14/18 12:24 PM, Eric Blake wrote:
> On 9/14/18 11:51 AM, Vladimir Sementsov-Ogievskiy wrote:
>> bitmap_to_extents function is broken: it switches dirty variable after
>> every iteration, however it can process only part of dirty (or zero)
>> area during one iteration in case when this area is too large for one
>> extent.
>>
>> Fortunately, the bug don't produce wrong extents: it just inserts
>> zero-length extents between sequential extents representing large dirt=
y
>> (or zero) area. However, zero-length extents are abandoned by NBD
>=20
> s/abandoned by/forbidden by the/
>=20
>> protocol. So, careful client should consider such replay as server
>=20
> s/replay/reply/
>=20
>> fault and not-careful will likely ignore zero-length extents.
>=20
> Which camp is qemu 3.0 as client in? Does it tolerate the zero-length=20
> extent, and still manage to see correct information overall, or does it=
=20
> crash?
>=20
> Hmm - I think we're "safe" with qemu as client - right now, the only wa=
y=20
> qemu 3.0 accesses the qemu dirty bitmap over NBD is with my=20
> x-dirty-bitmap hack (commit 216ee3657), which uses=20
> block/nbd-client.c:nbd_client_co_block_status() to read the bitmap, and=
=20
> that always passes NBD_CMD_FLAG_REQ_ONE.=C2=A0 qemu will assert() if=20
> nbd_client_co_block_status() doesn't make any progress, but from what=20
> I'm reading of your bug report, qemu as client never permits the server=
=20
> to answer with more than one extent, and the bug of a zero-length exten=
t=20
> is triggered only after the first extent has been sent.

A further mitigation - the bug can only occur for a client that requests=20
block status with a length in the range (4G-bitmap_granularity, 4G).=20
Otherwise, the loop terminates after the extent that got truncated to=20
4G-bitmap_granularity, preventing the next iteration of the loop from=20
detecting a 0-length extent.

>=20
> Thus, the primary reason to accept this patch is not because of qemu 3.=
0=20
> as client, but for interoperability with other clients.=C2=A0 I'm plann=
ing on=20
> updating the commit message to add these additional details.
>=20
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
