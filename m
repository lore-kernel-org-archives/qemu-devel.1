Received: from eggs.gnu.org ([2001:4830:134:3::10]:54208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoGAm-0000ma-NQ
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 17:14:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoGAl-0000Ji-MY
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 17:14:04 -0500
References: <20180220170135.5299-1-berto@igalia.com>
	<2d9713f2-87c1-12ba-3f46-a9a476279cda@redhat.com>
	<6064e2b5-c7aa-7ec1-b917-5431f0dc57a8@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3e28add4-8951-18ad-5d28-2579b790d541@redhat.com>
Date: Tue, 20 Feb 2018 16:13:39 -0600
MIME-Version: 1.0
In-Reply-To: <6064e2b5-c7aa-7ec1-b917-5431f0dc57a8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] specs/qcow2: Fix documentation of the
 compressed cluster descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 02/20/2018 04:03 PM, Eric Blake wrote:

>> boundary. Technically, it might be possible, but qemu does NOT do that=
=20
>> (again, looking at qcow2_alloc_bytes() - we loop if free_in_cluster <=20
>> size) - so we may want to be explicit about this point to prevent=20
>> OTHER implementations from creating a compressed cluster that crosses=20
>> host cluster boundaries (right now, I can't see=20
>> qcow2_decompress_cluster() validating it, though - YIKES).

Aha, I see where I went wrong.

>=20
> That said, a simple patch to try this:
>=20

>=20
> triggers failures in iotests 122:
>=20
> --- /home/eblake/qemu/tests/qemu-iotests/122.out=C2=A0=C2=A0=C2=A0 2017=
-10-06=20
> 13:45:25.559279136 -0500
> +++ /home/eblake/qemu/tests/qemu-iotests/122.out.bad=C2=A0=C2=A0=C2=A0 =
2018-02-20=20
> 15:54:29.890221575 -0600
> @@ -117,8 +117,8 @@
>  =C2=A0convert -c -S 0:
>  =C2=A0read 3145728/3145728 bytes at offset 0
>  =C2=A03 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -read 63963136/63963136 bytes at offset 3145728
> -61 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +qcow2: Marking image as corrupt: Compressed cluster at 0x5ffd2 crosses=
=20
> host cluster boundary; further corruption events will be suppressed
> +read failed: Input/output error
>  =C2=A0[{ "start": 0, "length": 67108864, "depth": 0, "zero": false, "d=
ata":=20
> true}]
>=20
> so it looks like I'm reading qcow2_alloc_bytes() wrong and that we CAN=20
> have a compressed cluster that crosses host cluster boundaries?

We DO allow crossing sector boundaries, IF the newly allocated cluster=20
is contiguous to the cluster that has the unused tail that we are=20
starting in.  Good, because that's less wasteful of the image (suppose=20
every compressed cluster got 49% reduction in size - since each one=20
requires 51% of a cluster, not allowing cluster crossing would require a=20
full cluster each, rather than the expected ~49% reduction in overall=20
image size if we are good at contiguous allocations).

>> So if I may suggest:
>>
>> =C2=A0=C2=A0=C2=A0 x+1 - 61:=C2=A0=C2=A0=C2=A0 Number of additional 51=
2-byte sectors used for the
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 compressed data, beyond the sector containing th=
e
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 offset in the previous field.=C2=A0 These sector=
s must fit
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 within the same host cluster.
>=20
> This sentence needs tweaking to match reality, given that my simple=20
> patch to flag cross-sector hosts triggered (or I need to figure out wha=
t=20
> was wrong with my patch).

So change that sentence to:  As needed, these additional sectors may=20
reside in the next contiguous host cluster.

>=20
>> =C2=A0 Note that the compressed
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 data does not necessarily occupy all of the byte=
s in
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 the final sector; rather, decompression stops wh=
en it
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 has produced a cluster of data.=C2=A0 Another co=
mpressed
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 cluster may map to the tail of the final sector =
used
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 by this compressed cluster.
>>
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
