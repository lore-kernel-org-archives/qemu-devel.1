Received: from eggs.gnu.org ([2001:4830:134:3::10]:36793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eleVh-00045q-LY
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:36:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eleVd-0003rg-Oz
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:36:53 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e6d0b42b-2e23-b518-5c1f-1049a286aff4@virtuozzo.com>
Date: Tue, 13 Feb 2018 20:36:41 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: [Qemu-devel] block_status automatically added flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi Eric!

I'm now testing my nbd block status realization (block_status part, not=20
about dirty bitmaps), and faced into the following effect.

I created empty qcow2 image and wrote to the first sector, so

qemu-io -c map x

reports:

64 KiB (0x10000) bytes=C2=A0=C2=A0=C2=A0=C2=A0 allocated at offset 0 bytes =
(0x0)
9.938 MiB (0x9f0000) bytes not allocated at offset 64 KiB (0x10000)

But I can't get same results, when connecting to nbd server, exporting=20
the same qcow2 file, I get

10 MiB (0xa00000) bytes=C2=A0=C2=A0=C2=A0=C2=A0 allocated at offset 0 bytes=
 (0x0)


Finally, I understand the reason:

for local file, qemu-io calls bdrv_is_allocated, which calls=20
bdrv_common_block_status_above with want_zero=3Dfalse. So, it doesn't set=20
BDRV_BLOCK_ZERO, and doesn't set BDRV_BLOCK_ALLOCATED. And, even if we=20
change want_zero to true, here, it will set BDRV_BLOCK_ZERO, but will=20
not set BDRV_BLOCK_ALLOCATED, which contradicts with it's definition:

 =C2=A0BDRV_BLOCK_ALLOCATED: the content of the block is determined by this
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 layer (short f=
or DATA || ZERO), set by block layer


for nbd, we go through the similar way on server (but with want_zero =3D=20
true), and we finally have BDRV_BLOCK_ZERO without BDRV_BLOCK_ALLOCATED,=20
which maps to NBD_STATE_HOLE+NBD_STATE_ZERO. But then, in the client we=20
have BDRV_BLOCK_ZERO not automatically added by block layer but directly=20
from nbd driver, therefor BDRV_BLOCK_ALLOCATED is set and I get=20
different result.


this all looks weird for me.

BDRV_BLOCK_ALLOCATED definition should be fixed, to show that this flag=20
show only reported by driver flags, not automatically added.

And then the situation with nbd looks strange, because automatically=20
added flag becomes "flag, reported by block driver".

On the other hand, it is not wrong.


I think, to test the feature, I'll improve qemu-io map, to show zeros=20
(or is it better to add separate command?) and leave the other things as=20
is. What do you think?

--=20
Best regards,
Vladimir
