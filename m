Received: from eggs.gnu.org ([2001:4830:134:3::10]:48809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqgPY-0008Cw-AL
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:11:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqgPX-0005SY-FV
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:11:36 -0400
References: <20180802144834.520904-1-eblake@redhat.com>
	<20180802144834.520904-3-eblake@redhat.com>
	<c7dc405d-0b83-b680-6e45-db4b211d3ef2@virtuozzo.com>
	<f3dd742c-cca3-3ee1-797e-72721752493e@redhat.com>
	<4e759caf-4493-a473-fc63-82670e62c3b6@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <18e4e9df-2155-39b5-117d-8e6e68c37859@redhat.com>
Date: Fri, 17 Aug 2018 10:11:28 -0500
MIME-Version: 1.0
In-Reply-To: <4e759caf-4493-a473-fc63-82670e62c3b6@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] nbd/server: Advertise actual minimum
 block size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, rjones@redhat.com, qemu-block@nongnu.org

On 08/17/2018 10:04 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Can you create a dirty bitmap with a granularity smaller than=20
>> request_alignment?=C2=A0 I know you can configure dirty bitmap granula=
rity=20
>> independently from cluster size (in both directions: either smaller or=
=20
>> larger than cluster size), but that it has a least a minimum lower=20
>> bounds of 512.=C2=A0 You're probably right that we also want it to hav=
e a=20
>> minimum lower bound of the request_alignment (if you're using a device=
=20
>> with 4k minimum I/O, request_alignment would be 4k, and having a dirty=
=20
>> bitmap any smaller than that granularity is wasted space).
>>
>> On the other hand, I also think we're safe for this patch: even if you=
=20
>> waste the space by creating a bitmap with too-small granularity, the=20
>> actions that write bits into the bitmap will still be aligned to=20
>> request_alignment,
>=20
> Not quite right: nbd_export_bitmap searches through the backing chain=20
> for the bitmap, and it may correspond to the bds with smaller=20
> request_alignment.

Hmm. Interesting setup:

base (512-byte alignment, bitmap granularity) <- active (4k alignment)

so you're stating that exporting 'active' but with the 'bitmap'=20
inherited from the backing chain from base means that the bitmap may=20
have transitions in between the alignment advertised by active.  Then it=20
sounds like nbd/server.c:bitmap_to_extents() should be aware of that=20
fact, and intentionally round up (anywhere that it finds a mid-alignment=20
transition, treat the entire aligned region as dirty. It never hurts to=20
mark more of the image dirty than necessary, but does hurt to expose a=20
mid-alignment transition to an NBD client not expecting one).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
