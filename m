Received: from eggs.gnu.org ([2001:4830:134:3::10]:39753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fumCF-0003zf-Ek
	for Qemu-devel@nongnu.org; Tue, 28 Aug 2018 18:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fum1H-00034w-0I
	for Qemu-devel@nongnu.org; Tue, 28 Aug 2018 17:59:30 -0400
References: <c8301133-5f39-3fa5-af3e-9bc60ce44172@redhat.com>
	<8c51bdec-2862-211d-3818-ee69b51ef17c@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <045562f3-6c25-244d-7ba5-1ae8650ab405@redhat.com>
Date: Tue, 28 Aug 2018 16:59:25 -0500
MIME-Version: 1.0
In-Reply-To: <8c51bdec-2862-211d-3818-ee69b51ef17c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] blkdebug get_status bug [was: [Qemu-block] NBD
 structured reads vs. block size]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu block <qemu-block@nongnu.org>, Kevin O'Connor <kevin@koconnor.net>, "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>

[following up to a different set of emails]

On 08/28/2018 03:41 PM, Eric Blake wrote:
> Revisiting this:
>=20
> On 08/01/2018 09:41 AM, Eric Blake wrote:
>> Rich Jones pointed me to questionable behavior in qemu's NBD server=20
>> implementation today: qemu advertises a minimum block size of 512 to=20
>> any client that promises to honor block sizes, but when serving up a=20
>> raw file that is not aligned to a sector boundary, attempting to read=20
>> that final portion of the file results in a structured read with two=20
>> chunks, the first for the data up to the end of the actual file, and=20
>> the second reporting a hole for the rest of the sector. If a client is=
=20
>> promising to obey block sizes on its requests, it seems odd that the=20
>> server is allowed to send a result that is not also aligned to block=20
>> sizes.
>>
>> Right now, the NBD spec says that when structured replies are in use,=20
>> then for a structured read:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 The server MAY split the reply into any numbe=
r of content chunks;
>> =C2=A0=C2=A0=C2=A0=C2=A0 each chunk MUST describe at least one byte, a=
lthough to minimize
>> =C2=A0=C2=A0=C2=A0=C2=A0 overhead, the server SHOULD use chunks with l=
engths and offsets as
>> =C2=A0=C2=A0=C2=A0=C2=A0 an integer multiple of 512 bytes, where possi=
ble (the first and
>> =C2=A0=C2=A0=C2=A0=C2=A0 last chunk of an unaligned read being the mos=
t obvious places for
>> =C2=A0=C2=A0=C2=A0=C2=A0 an exception).
>>
>> I'm wondering if we should tighten that to require that the server=20
>> partition the reply chunks to be aligned to the advertised minimum=20
>> block size (at which point, qemu should either advertise 1 instead of=20
>> 512 as the minimum size when serving up an unaligned file, or else=20
>> qemu should just send the final partial sector as a single data chunk=20
>> rather than trying to report the last few bytes as a hole).
>>
>> For comparison, on block status, we require:
>>
>> =C2=A0=C2=A0=C2=A0 The server SHOULD use descriptor
>> =C2=A0=C2=A0=C2=A0=C2=A0 lengths that are an integer multiple of 512 b=
ytes where possible
>> =C2=A0=C2=A0=C2=A0=C2=A0 (the first and last descriptor of an unaligne=
d query being the
>> =C2=A0=C2=A0=C2=A0=C2=A0 most obvious places for an exception), and MU=
ST use descriptor
>> =C2=A0=C2=A0=C2=A0=C2=A0 lengths that are an integer multiple of any a=
dvertised minimum
>> =C2=A0=C2=A0=C2=A0=C2=A0 block size.
>>
>> And qemu as a client currently hangs up on any server that violates=20
>> that requirement on block status (that is, when qemu as the server=20
>> tries to send a block status that was not aligned to the advertised=20
>> block size, qemu as the client flags it as an invalid server - which=20
>> means qemu as server is currently broken).=C2=A0 So I'm thinking we sh=
ould=20
>> copy that requirement onto servers for reads as well.
>=20
> Vladimir pointed out that the problem is not necessarily just limited t=
o=20
> the implicit hole at the end of a file that was rounded up to sector=20
> size.=C2=A0 Another case where sub-region changes occur in qemu is wher=
e you=20
> have a backing file with 512-byte hole granularity (qemu-img create -f=20
> qcow2 -o cluster_size=3D512 backing.qcow2 100M) and an overlay with lar=
ger=20
> granularity (qemu-img create -f qcow2 -b backing.qcow2 -F qcow2 -o=20
> cluster_size=3D4k active.qcow2). On a cluster where the top layer defer=
s=20
> to the underlying layer, it is possible to alternate between holes and=20
> data at sector boundaries but at subsets of the cluster boundary of the=
=20
> top layer.=C2=A0 As long as qemu advertises a minimum block size of 512=
=20
> rather than the cluster size, then this isn't a problem, but if qemu=20
> were to change to report the qcow2 cluster size as its minimum I/O=20
> (rather than merely its preferred I/O, because it can do=20
> read-modify-write on data smaller than a cluster), this would be anothe=
r=20
> case where unaligned replies might confuse a client.

So, I tried to actually create this scenario, to see what actually=20
happens, and we have a worse bug that needs to be resolved first.  That=20
is, bdrv_block_status_above() chokes when there is a blkdebug node in=20
the works:

$ qemu-img create -f qcow2 -o cluster_size=3D512 back.qcow2 100M
$ qemu-io -c 'w P1 0 512' -c 'w -P1 1k 512' -f qcow2 back.qcow2
$ qemu-img create -f qcow2 -F qcow2 -b back.qcow2 \
     -o cluster_size=3D1M top.qcow2
$ qemu-img map --output=3Djson -f qcow2 top.qcow2
[{ "start": 0, "length": 512, "depth": 1, "zero": false, "data": true,=20
"offset": 27648},
{ "start": 512, "length": 512, "depth": 1, "zero": true, "data": false},
{ "start": 1024, "length": 512, "depth": 1, "zero": false, "data": true,=20
"offset": 28160},
{ "start": 1536, "length": 104856064, "depth": 1, "zero": true, "data":=20
false}]
$ qemu-img map --output=3Djson --image-opts \
    driver=3Dblkdebug,image.driver=3Dqcow2,image.file.driver=3Dfile,\
image.file.filename=3Dtop.qcow2,align=3D4k
[{ "start": 0, "length": 104857600, "depth": 0, "zero": false, "data":=20
false}]

Yikes! Adding blkdebug says there is no data in the file at all!=20
Actions like 'qemu-img convert' for copying between images would thus=20
behave differently on a blkdebug image than they would on the real=20
image, which somewhat defeats the purpose of blkdebug being a filter node=
.

$ ./qemu-io --image-opts \
    driver=3Dblkdebug,image.driver=3Dqcow2,image.file.driver=3Dfile,\
image.file.filename=3Dtop.qcow2,align=3D4k
qemu-io> r -P1 0 512
read 512/512 bytes at offset 0
512 bytes, 1 ops; 0.0002 sec (1.782 MiB/sec and 3649.6350 ops/sec)
qemu-io> r -P0 512 512
read 512/512 bytes at offset 512
512 bytes, 1 ops; 0.0002 sec (2.114 MiB/sec and 4329.0043 ops/sec)
qemu-io>

Meanwhile, the data from the backing file is clearly visible when read.=20
So the bug must lie somewhere in the get_status operation.  Looking=20
closer, I see this in bdrv_co_block_status_above():

2242	    for (p =3D bs; p !=3D base; p =3D backing_bs(p)) {

When qcow2 is directly opened, this iterates to back.qcow2 and sees that=20
there is data in the first cluster, changing the overall status reported=20
to the caller.  But when the qcow2 is hidden by blkdebug, backing_bs()=20
states that blkdebug has no backing image, and terminates the loop early=20
with JUST the status of the (empty) top file, rather than properly=20
merging in the status from the backing file.

I don't know if the bug lies in backing_bs(), or in the blkdebug driver,=20
or in the combination of the two.  Maybe it is as simple as fixing=20
backing_bs() such that on a filter node bs, it defers to=20
backing_bs(bs->file->bs), to make filter nodes behave as if they have=20
the same backing file semantics as what they are wrapping.

I was _trying_ to figure out if the block layer and/or blkdebug also=20
needs to perform rounding of get_status results: if=20
bs->bl.request_alignment is bigger at the current layer than what it is=20
in the underlying protocol and/or backing layer, who is responsible for=20
rounding the block status up to the proper alignment boundaries exposed=20
by the layer being questioned?  Or should we instead make sure that NBD=20
advertises the smallest alignment of anything in the chain, rather than=20
limiting itself to just the alignment of the top layer in the chain?=20
But since the graph can be modified on the fly, it's possible that the=20
smallest alignment anywhere in the chain can change over time.

And when there is no backing file in the mix, blkdebug does indeed have=20
the problem that it reports boundaries at an alignment smaller than what=20
it was declared to honor:

$  ./qemu-img map --output=3Djson --image-opts \
    driver=3Dblkdebug,image.driver=3Dqcow2,image.file.driver=3Dfile,\
image.file.filename=3Dback.qcow2,align=3D4k
[{ "start": 0, "length": 512, "depth": 0, "zero": false, "data": true,=20
"offset": 27648},
{ "start": 512, "length": 512, "depth": 0, "zero": true, "data": false},
{ "start": 1024, "length": 512, "depth": 0, "zero": false, "data": true,=20
"offset": 28160},
{ "start": 1536, "length": 104856064, "depth": 0, "zero": true, "data":=20
false}]

Presumably, when rounding a collection of smaller statuses from an=20
underlying layer into the aligned status of a current layer with=20
stricter alignment, the sane way to do it would be treating=20
BDRV_BLOCK_DATA/BDRV_BLOCK_ALLOCATED as sticky set (if any subset had=20
data, the overall area should report data), BDRV_BLOCK_ZERO as sticky=20
clear (if any subset does not report zero, the overall area cannot=20
report zero), BDRV_BLOCK_OFFSET_VALID as sticky unset (if any subset=20
does not have a valid mapping, or if valid mappings are not contiguous,=20
the overall area cannot report a mapping). But that logic sounds=20
complicated enough that it's probably better to do it just once in the=20
block layer, rather than having to repeat it in the various block=20
drivers that actually have to cope with the possibility of a protocol or=20
backing layer with a smaller granularity than the current format layer.=20
And maybe we want it to be controlled by a flag (where some callers want=20
to know as precise data as possible, even when the answers are=20
subdivided smaller than the request_alignment of the initial query;=20
while other callers like NBD want to guarantee that the answer is=20
properly rounded to the request_alignment).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
