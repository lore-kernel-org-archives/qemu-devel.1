Received: from eggs.gnu.org ([2001:4830:134:3::10]:57989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elfdg-0007Gd-Om
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 13:49:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elfdf-0006s5-2X
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 13:49:12 -0500
References: <e6d0b42b-2e23-b518-5c1f-1049a286aff4@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1a0aa4be-adb5-43ab-03ba-ff18e941c460@redhat.com>
Date: Tue, 13 Feb 2018 12:48:47 -0600
MIME-Version: 1.0
In-Reply-To: <e6d0b42b-2e23-b518-5c1f-1049a286aff4@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] block_status automatically added flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 02/13/2018 11:36 AM, Vladimir Sementsov-Ogievskiy wrote:
> Hi Eric!
>=20
> I'm now testing my nbd block status realization (block_status part, not=
=20
> about dirty bitmaps), and faced into the following effect.
>=20
> I created empty qcow2 image and wrote to the first sector, so
>=20
> qemu-io -c map x
>=20
> reports:
>=20
> 64 KiB (0x10000) bytes=C2=A0=C2=A0=C2=A0=C2=A0 allocated at offset 0 by=
tes (0x0)
> 9.938 MiB (0x9f0000) bytes not allocated at offset 64 KiB (0x10000)
>=20
> But I can't get same results, when connecting to nbd server, exporting=20
> the same qcow2 file, I get
>=20
> 10 MiB (0xa00000) bytes=C2=A0=C2=A0=C2=A0=C2=A0 allocated at offset 0 b=
ytes (0x0)

Is this with or without your NBD_CMD_BLOCK_STATUS patches applied?  And=20
are you exposing the data over NBD as raw ('qemu-nbd -f qcow2'/'qemu-io=20
-f raw') or as qcow2 ('qemu-nbd -f raw'/'qemu-io -f qcow2')?

/me does a quick reproduction

Yes, I definitely see that behavior without any NBD_CMD_BLOCK_STATUS=20
patches and when the image is exposed over NBD as raw, but not when=20
exposed as qcow2, when testing the 2.11 release:

$ qemu-img create -f qcow2 file3 10M
Formatting 'file3', fmt=3Dqcow2 size=3D10485760 cluster_size=3D65536=20
lazy_refcounts=3Doff refcount_bits=3D16
$ qemu-io -c 'w 0 64k' -c map -f qcow2 file3
wrote 65536/65536 bytes at offset 0
64 KiB, 1 ops; 0.0579 sec (1.079 MiB/sec and 17.2601 ops/sec)
64 KiB (0x10000) bytes     allocated at offset 0 bytes (0x0)
9.938 MiB (0x9f0000) bytes not allocated at offset 64 KiB (0x10000)
$ qemu-nbd -f qcow2 -x foo file3
$ qemu-io -f raw -c map nbd://localhost:10809/foo
10 MiB (0xa00000) bytes     allocated at offset 0 bytes (0x0)
$ qemu-nbd -f raw -x foo file3
$ qemu-io -f qcow2 -c map nbd://localhost:10809/foo
64 KiB (0x10000) bytes     allocated at offset 0 bytes (0x0)
9.938 MiB (0x9f0000) bytes not allocated at offset 64 KiB (0x10000)

Right now, without NBD block status, the NBD driver reports the entire=20
file as allocated, as it can't do any better (NBD has no backing file,=20
and all data .  Presumably, once NBD_CMD_BLOCK_STATUS is implemented, we=20
can then use that for more accurate information.

>=20
>=20
> Finally, I understand the reason:
>=20
> for local file, qemu-io calls bdrv_is_allocated, which calls=20
> bdrv_common_block_status_above with want_zero=3Dfalse. So, it doesn't s=
et=20
> BDRV_BLOCK_ZERO, and doesn't set BDRV_BLOCK_ALLOCATED.

'qemu-io map' is a bit unusual; it is the only UI that easily exposes=20
bdrv_is_allocated() to the outside world ('qemu-img map' does not).=20
(The fact that both operations are named 'map' but do something=20
different is annoying; for back-compat reasons, we can't change=20
qemu-img, and I don't know if changing qemu-io is worth it.)


> And, even if we=20
> change want_zero to true,

Well, you'd do that by invoking bdrv_block_status() (via 'qemu-img map',=20
for example).

> here, it will set BDRV_BLOCK_ZERO, but will=20
> not set BDRV_BLOCK_ALLOCATED, which contradicts with it's definition:
>=20
>  =C2=A0BDRV_BLOCK_ALLOCATED: the content of the block is determined by =
this
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 layer (short=
 for DATA || ZERO), set by block layer

This text is wrong; it gets fixed in my still-pending concluding series=20
for byte-based block status:

https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg00955.html

Conceptually, BDRV_BLOCK_ALLOCATED means "is THIS layer of the backing=20
chain responsible for the contents at this guest offset"; and there are=20
cases where we know that we read zeroes but where the current layer is=20
not responsible for the contents (such as a qcow2 that has a backing=20
file with shorter length, where we return BDRV_BLOCK_ZERO but not=20
BDRV_BLOCK_ALLOCATED).  But since NBD has no backing chain, the entire=20
image is considered allocated.  Meanwhile, asking whether something is=20
allocated ('qemu-io -c map') is not the usual question you want to ask=20
when determining what portions of a file are zero.

>=20
>=20
> for nbd, we go through the similar way on server (but with want_zero =3D=
=20
> true), and we finally have BDRV_BLOCK_ZERO without BDRV_BLOCK_ALLOCATED=
,=20
> which maps to NBD_STATE_HOLE+NBD_STATE_ZERO. But then, in the client we=
=20
> have BDRV_BLOCK_ZERO not automatically added by block layer but directl=
y=20
> from nbd driver, therefor BDRV_BLOCK_ALLOCATED is set and I get=20
> different result.

Drivers should never set BDRV_BLOCK_ALLOCATED; only the code in io.c=20
should set it; and output based on BDRV_BLOCK_ALLOCATED is only useful=20
in backing chain scenarios (which NBD does not have).

>=20
>=20
> this all looks weird for me.
>=20
> BDRV_BLOCK_ALLOCATED definition should be fixed, to show that this flag=
=20
> show only reported by driver flags, not automatically added.

If we need to report yet more flags, where the driver can report=20
additional information, then that's different.  But changing the=20
BDRV_BLOCK_ALLOCATED semantics would probably have knock-on effects that=20
I'm not prepared to audit for (that is, we'd rather fix the=20
documentation to match reality, which my pending patch does, and NOT=20
change the code to  match the current incorrect documentation).

>=20
> And then the situation with nbd looks strange, because automatically=20
> added flag becomes "flag, reported by block driver".
>=20
> On the other hand, it is not wrong.
>=20
>=20
> I think, to test the feature, I'll improve qemu-io map, to show zeros=20
> (or is it better to add separate command?) and leave the other things a=
s=20
> is. What do you think?


If you want to add a new qemu-io command that matches more what=20
'qemu-img map' does, be my guest.  In fact, renaming the existing=20
'qemu-io map' to something else may be warranted (qemu-io has a much=20
smaller user base, and is not documented as being stable, so back-compat=20
is not an issue, as long as iotests still pass).  But I do know that=20
existing iotests depend on the current 'qemu-io map' semantics of being=20
a thin veneer around bdrv_is_allocated(), and that we can't change those=20
semantics.  So if we do anything, adding a new command may be smarter.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
