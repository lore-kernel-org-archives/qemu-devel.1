Received: from eggs.gnu.org ([2001:4830:134:3::10]:36063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eoZCI-00021P-Ll
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 13:33:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eoZCC-0006gA-F0
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 13:32:54 -0500
References: <20180220222459.8461-1-eblake@redhat.com>
	<20180220222459.8461-3-eblake@redhat.com>
	<w51tvuak6b0.fsf@maestria.local.igalia.com>
	<37fa8b17-116b-ea53-6f65-68412fdb813c@redhat.com>
	<e2247007-78c1-9f34-f0c9-cc689111f895@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <83a5559e-1e15-ae68-7507-14778ad6e7f9@redhat.com>
Date: Wed, 21 Feb 2018 13:32:34 -0500
MIME-Version: 1.0
In-Reply-To: <e2247007-78c1-9f34-f0c9-cc689111f895@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] qcow2: Avoid memory over-allocation on
 compressed images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, mreitz@redhat.com



On 02/21/2018 10:59 AM, Eric Blake wrote:
> On 02/21/2018 09:00 AM, Eric Blake wrote:
>> On 02/21/2018 04:04 AM, Alberto Garcia wrote:
>>> On Tue 20 Feb 2018 11:24:59 PM CET, Eric Blake wrote:
>>>
>>> I was also preparing a patch to change this, but you arrived first :-=
)
>>>
>>>> So, it's time to cut back on the waste.=C2=A0 A compressed cluster
>>>> will NEVER occupy more than an uncompressed cluster
>=20
>=20
>> And here, csize can only get smaller than the length picked by
>> nb_csectors.=C2=A0 Therefore, csize is GUARANTEED to be <=3D c->sector=
_size.
>>
>>>
>>> - Solution a: check that csize < s->cluster_size and return an error =
if
>>> =C2=A0=C2=A0 it's not. However! although QEMU won't produce an image =
with a
>>> =C2=A0=C2=A0 compressed cluster that is larger than the uncompressed =
one, the
>>> qcow2
>>> =C2=A0=C2=A0 on-disk format in principle allows for that, so arguably=
 we should
>>> =C2=A0=C2=A0 accept it.
>>
>> No, the qcow2 on-disk format does not have enough bits reserved for
>> that.=C2=A0 It is impossible to store an inflated cluster, because you
>> don't have enough bits to record it.
>=20
> Okay, the spec is WRONG, compared to our code base.
>=20
>>
>> That said, we MAY have a bug, more likely to be visible in 512-byte
>> clusters but possible on any size.=C2=A0 While the 'number sectors' fi=
eld
>> IS sufficient for any compressed cluster starting at offset 0 in the
>> cluster, we run into issues if the starting offset is later in the
>> cluster.=C2=A0 That is, even though the compressed length of a 512-byt=
e
>> cluster is <=3D 512 (or we wouldn't compress it), if we start at offse=
t
>> 510, we NEED to read the next cluster to get the rest of the
>> compressed stream - but at 512-byte clusters, there are 0 bits
>> reserved for 'number sectors'.=C2=A0 Per the above calculations with t=
he
>> example offset of 510, nb_csectors would be 1 (it can't be anything
>> else for a 512-byte cluster image), and csize would then be 2 bytes,
>> which is insufficient for reading back enough data to reconstruct the
>> cluster.
>=20
> In fact, here's a demonstration of a discrepancy, where qemu-img and
> John's qcheck tool [1] disagree about the validity of an image created
> by qemu (although it may just be that qcheck hasn't yet learned about
> compressed clusters):
>=20
> [1]https://github.com/jnsnow/qcheck
>=20

I wouldn't trust my tool's ability to understand compressed clusters :)

I didn't get very far, though I did run across the fact that there
appeared to be a discrepancy between the spec and the actual
implementation, IIRC.

It looked like you came to the same conclusion when you stepped through
it manually.

> $ f=3D12345678
> $ f=3D$f$f$f$f # 32
> $ f=3D$f$f$f$f # 128
> $ f=3D$f$f$f$f # 512
> $ f=3D$f$f$f$f # 2k
> $ f=3D$f$f$f$f # 8k
> $ f=3D$f$f$f$f # 32k
> $ f=3D$f$f$f$f # 128k
> $ printf "$f" > data
> $ qemu-img convert -c -f raw -O qcow2 -o cluster_size=3D512 \
> =C2=A0 data data.qcow2
> $ qemu-img check data.qcow2
> No errors were found on the image.
> 256/256 =3D 100.00% allocated, 100.00% fragmented, 100.00% compressed
> clusters
> Image end offset: 18944
> $ ./qcheck data.qcow2
> ...
> =3D=3D L2 Tables =3D=3D
>=20
> =3D=3D L2 cluster l1[0] : 0x0000000000000800 =3D=3D
> Corrupt entries: 63; Non-zero entries: 64; Corrupt:Non-zero ratio: 0.98=
4375
> =3D=3D L2 cluster l1[1] : 0x0000000000000e00 =3D=3D
> Corrupt entries: 63; Non-zero entries: 64; Corrupt:Non-zero ratio: 0.98=
4375
> =3D=3D L2 cluster l1[2] : 0x0000000000001400 =3D=3D
> Corrupt entries: 63; Non-zero entries: 64; Corrupt:Non-zero ratio: 0.98=
4375
> =3D=3D L2 cluster l1[3] : 0x0000000000001a00 =3D=3D
> Corrupt entries: 63; Non-zero entries: 64; Corrupt:Non-zero ratio: 0.98=
4375
> L2 tables: Could not complete analysis, 257 problems found
>=20
>=20
> =3D=3D Reference Count Analysis =3D=3D
>=20
> Refcount analysis: 00 vacant clusters
> Refcount analysis: 04 leaked clusters
> Refcount analysis: 00 ghost clusters
> Refcount analysis: 04 miscounted clusters
> Refcount analysis: 8 problems found
>=20
>=20
> =3D=3D Cluster Counts =3D=3D
>=20
> Metadata: 0x1000
> Data: 0x800
> Leaked: 0x800
> Vacant: 0x0
> total: 0x2000
> qcheck: 73 problems found
>=20
>=20
>>
>> Not true.=C2=A0 It is (cluster_bits - 9) or (cluster_size / 512).=C2=A0
>> Remember, x =3D 62 - (cluster_bits - 8); for a 512-byte cluster, x =3D
>> 61.=C2=A0 The 'number sectors' field is then bits x+1 - 61 (but you ca=
n't
>> have a bitfield occupying bit 62 upto 61; especially since bit 62 is
>> the bit for compressed cluster).
>=20
> So instead of blindly reading the spec, I'm now going to single-steppin=
g
> through the 'qemu-img convert' command line above, to see what REALLY
> happens:
>=20
> Line numbers from commit a6e0344fa0
> $ gdb --args ./qemu-img convert -c -f raw -O qcow2 -o cluster_size=3D51=
2
> data data.qcow2
> ...
> (gdb) b qcow2_alloc_bytes
> Breakpoint 1 at 0x57610: file block/qcow2-refcount.c, line 1052.
> (gdb) r
> Thread 1 "qemu-img" hit Breakpoint 1, qcow2_alloc_bytes (
> =C2=A0=C2=A0=C2=A0 bs=3Dbs@entry=3D0x555555d87f50, size=3Dsize@entry=3D=
15)
> =C2=A0=C2=A0=C2=A0 at block/qcow2-refcount.c:1052
> 1052=C2=A0=C2=A0=C2=A0 {
> (gdb)
>=20
> So we are compressing 512 bytes down to 15 every time, which means that
> after 34 clusters compressed, we should be at offset 510.=C2=A0 Let's r=
esume
> debugging:
>=20
> (gdb) c 34
> Will ignore next 33 crossings of breakpoint 1.=C2=A0 Continuing.
> [Thread 0x7fffe3cfe700 (LWP 32229) exited]
> [New Thread 0x7fffe3cfe700 (LWP 32300)]
> [New Thread 0x7fffe25ed700 (LWP 32301)]
>=20
> Thread 1 "qemu-img" hit Breakpoint 1, qcow2_alloc_bytes (
> =C2=A0=C2=A0=C2=A0 bs=3Dbs@entry=3D0x555555d87f50, size=3Dsize@entry=3D=
15)
> =C2=A0=C2=A0=C2=A0 at block/qcow2-refcount.c:1052
> 1052=C2=A0=C2=A0=C2=A0 {
> (gdb) n
> 1053=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRVQcow2State *s =3D bs=
->opaque;
> (gdb)
> 1058=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BLKDBG_EVENT(bs->file, B=
LKDBG_CLUSTER_ALLOC_BYTES);
> (gdb)
> 1059=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(size > 0 && size =
<=3D s->cluster_size);
> (gdb) p s->free_byte_offset
> $2 =3D 3070
> (gdb) p 3070%512
> $3 =3D 510
> ...
> (gdb)
> 1076=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free_in_cluster =3D s->c=
luster_size - offset_into_cluster(s,
> offset);
> (gdb)
> 1078=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (!offset || free_in_cluster < size) {
> (gdb) p free_in_cluster
> $4 =3D 2
> 1079=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 int64_t new_cluster =3D alloc_clusters_noref(bs,
> s->cluster_size);
> (gdb)
> 1080=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (new_cluster < 0) {
> (gdb)
> 1084=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (new_cluster =3D=3D 0) {
> (gdb)
> 1091=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (!offset || ROUND_UP(offset, s->cluster_size) !=3D
> new_cluster) {
> (gdb)
> 1095=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free_in_cluster +=3D s->clu=
ster_size;
> (gdb)
> 1099=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
assert(offset);
>=20
> so we got a contiguous cluster, and our goal is to let the caller bleed
> the compressed cluster into to the tail of the current sector and into
> the head of the next cluster.=C2=A0 Continuing:
>=20
> (gdb) fin
> Run till exit from #0=C2=A0 qcow2_alloc_bytes (bs=3Dbs@entry=3D0x555555=
d87f50,
> =C2=A0=C2=A0=C2=A0 size=3Dsize@entry=3D15) at block/qcow2-refcount.c:11=
18
> [Thread 0x7fffe25ed700 (LWP 32301) exited]
> [Thread 0x7fffe3cfe700 (LWP 32300) exited]
> qcow2_alloc_compressed_cluster_offset (bs=3Dbs@entry=3D0x555555d87f50,
> =C2=A0=C2=A0=C2=A0 offset=3Doffset@entry=3D17408, compressed_size=3Dcom=
pressed_size@entry=3D15)
> =C2=A0=C2=A0=C2=A0 at block/qcow2-cluster.c:768
> 768=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cluster_offset < 0) {
> Value returned is $5 =3D 3070
>=20
> (gdb) n
> 773=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nb_csectors =3D ((cluster=
_offset + compressed_size - 1) >> 9) -
> (gdb)
> 774=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (cluster_offset=
 >> 9);
> (gdb)
> 773=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nb_csectors =3D ((cluster=
_offset + compressed_size - 1) >> 9) -
> (gdb)
> 777=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ((uint64_t)nb_csectors << s->csize_shift);
> (gdb) l
> 772=C2=A0=C2=A0=C2=A0
> 773=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nb_csectors =3D ((cluster=
_offset + compressed_size - 1) >> 9) -
> 774=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (cluster_offset=
 >> 9);
> 775=C2=A0=C2=A0=C2=A0
> 776=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cluster_offset |=3D QCOW_=
OFLAG_COMPRESSED |
> 777=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ((uint64_t)nb_csectors << s->csize_shift);
> 778=C2=A0=C2=A0=C2=A0
> 779=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* update L2 table */
> 780=C2=A0=C2=A0=C2=A0
> 781=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* compressed clusters ne=
ver have the copied flag */
> (gdb) p nb_csectors
> $6 =3D 1
> (gdb) p s->csize_shift
> $7 =3D 61
> (gdb) p/x cluster_offset
> $8 =3D 0xbfe
> (gdb) n
> 776=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cluster_offset |=3D QCOW_=
OFLAG_COMPRESSED |
> (gdb)
> 783=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BLKDBG_EVENT(bs->file, BL=
KDBG_L2_UPDATE_COMPRESSED);
> (gdb) p/x cluster_offset
> $9 =3D 0x6000000000000bfe
>=20
> Where is s->csize_shift initialized?=C2=A0 In qcow2_do_open():
>=20
> =C2=A0=C2=A0=C2=A0 s->csize_shift =3D (62 - (s->cluster_bits - 8));
> =C2=A0=C2=A0=C2=A0 s->csize_mask =3D (1 << (s->cluster_bits - 8)) - 1;
> =C2=A0=C2=A0=C2=A0 s->cluster_offset_mask =3D (1LL << s->csize_shift) -=
 1;
>=20
> Revisiting the wording in the spec:
>=20
> Compressed Clusters Descriptor (x =3D 62 - (cluster_bits - 8)):
>=20
> =C2=A0=C2=A0=C2=A0 Bit=C2=A0 0 -=C2=A0 x:=C2=A0=C2=A0=C2=A0 Host cluste=
r offset. This is usually _not_ aligned to a
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cluster boundary!
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x+1 - 61:=C2=A0=C2=A0=C2=A0 Compre=
ssed size of the images in sectors of 512 bytes
>=20
> which says bits 0-61 are the host cluster offset, and 62-61 is the
> number of sectors.=C2=A0 But our code sets s->csize_shift to divide thi=
s
> differently, at 0-60 and 61-61.=C2=A0 Which means your earlier claim th=
at
> there are enough 'number sector' bits to allow for up to 2*cluster_size
> as the size of the compressed stream (rather than my claim of exactly
> cluster_size) is right, and other implementations CAN inflate a cluster
> (if we don't document otherwise), and that even if they DON'T inflate,
> they can STILL cause a read larger than a cluster size when the offset
> is near the tail of one sector (most likely at 512-byte clusters, but
> remotely possible at other cluster sizes as well).
>=20

--=20
=E2=80=94js
