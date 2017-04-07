Received: from eggs.gnu.org ([2001:4830:134:3::10]:49672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cwPag-0002hQ-W2
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 04:50:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cwPad-0003XG-Sr
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 04:49:59 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <da7174ff-38c1-07fd-96b6-fa9280524002@redhat.com>
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<da7174ff-38c1-07fd-96b6-fa9280524002@redhat.com>
Date: Fri, 07 Apr 2017 10:49:51 +0200
Message-ID: <w511st47gb4.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] Proposed qcow2 extension: subcluster
 allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu 06 Apr 2017 06:40:41 PM CEST, Eric Blake wrote:

>> This e-mail is the formal presentation of my proposal to extend the
>> on-disk qcow2 format. As you can see this is still an RFC. Due to the
>> nature of the changes I would like to get as much feedback as
>> possible before going forward.
>
> The idea in general makes sense; I can even remember chatting with
> Kevin about similar ideas as far back as 2015, where the biggest
> drawback is that it is an incompatible image change, and therefore
> images created with the flag cannot be read by older tools.

That's correct.

>> =3D=3D=3D Changes to the on-disk format =3D=3D=3D
>>=20
>> The qcow2 on-disk format needs to change so each L2 entry has a
>> bitmap indicating the allocation status of each subcluster. There are
>> three possible states (unallocated, allocated, all zeroes), so we
>> need two bits per subcluster.
>
> You also have to add a new incompatible feature bit, so that older
> tools know they can't read the new image correctly, and therefore
> don't accidentally corrupt it.

Yes, of course. The name that I'm considering is something like
QCOW2_INCOMPAT_SUBCLUSTER, and for the creation options either
'subclusters=3Don/off' or 'subcluster_size=3DXXX' (depending on whether the
size is configurable or not).

>> (1) Storing the bitmap inside the 64-bit entry
>>=20
>>     This is a simple alternative and is the one that I chose for my
>>     prototype. There are 14 unused bits plus the "all zeroes" one. If
>>     we steal one from the host offset we have the 16 bits that we need
>>     for the bitmap and we have 46 bits left for the host offset, which
>>     is more than enough.
>
> Note that because you are using exactly 8 subclusters, you can require
> that the minimum cluster size when subclusters are enabled be 4k (since
> we already have a lower-limit of 512-byte sector operation, and don't
> want subclusters to be smaller than that); at which case you are
> guaranteed that the host cluster offset will be 4k aligned.  So in
> reality, once you turn on subclusters, you have:
>
> 63    56 55    48 47    40 39    32 31    24 23    16 15     8 7      0
> 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> **<----> <-----------------------------------------------><---------->*
>   Rsrved              host cluster offset of data             Reserved
>   (6 bits)                (44 bits)                           (11 bits)
>
> where you have 17 bits plus the "all zeroes" bit to play with, thanks to
> the three bits of host cluster offset that are now guaranteed to be zero
> due to cluster size alignment (but you're also right that the "all
> zeroes" bit is now redundant information with the 8 subcluster-is-zero
> bits, so repurposing it does not hurt)

The lower bits of the offset field are guaranteed to be zero if the
cluster size is anything other than the minimum (4KB), so alternatively
"host cluster offset" could become "host cluster index", where
host_cluster_offset =3D host_cluster_index * cluster_size.

With the 56 bits that we have now we can address 64 PB of data. In
theory QEMU can create larger qcow2 files if the cluster size is big
enough. The current hard limit is QCOW_MAX_L1_SIZE =3D 0x2000000, which
implies:

|--------------+------------------|
| Cluster size | Max virtual size |
|--------------+------------------|
| 512 bytes    | 128 GB           |
|   1 KB       | 512 GB           |
|   2 KB       |   2 TB           |
|   4 KB       |   8 TB           |
|   8 KB       |  32 TB           |
|  16 KB       | 128 TB           |
|  32 KB       | 512 TB           |
|  64 KB       |   2 PB           |
| 128 KB       |   8 PB           |
| 256 KB       |  32 PB           |
| 512 KB       | 128 PB           |
|   1 MB       | 512 PB           |
|   2 MB       |   2 EB           |
|--------------+------------------|

In practice however 64PB ought to be enough for anybody=E2=84=A2, so maybe =
it's
not worth doing this.

>>     * Cons:
>>       - Only 8 subclusters per cluster. We would not be making the
>>         most of this feature.
>>=20
>>       - No reserved bits left for the future.
>
> I just argued you have at least one, and probably 2, bits left over
> for future in-word expansion.

You're correct in any case, 512 subclusters should be the absolute
minimum.

>> (2) Making L2 entries 128-bit wide.
>>=20
>>     In this alternative we would double the size of L2 entries. The
>>     first half would remain unchanged and the second one would store
>>     the bitmap. That would leave us with 32 subclusters per cluster.
>
> Although for smaller cluster sizes (such as 4k clusters), you'd still
> want to restrict that subclusters are at least 512-byte sectors, so
> you'd be using fewer than 32 of those subcluster positions until the
> cluster size is large enough.

I think in that case what would make sense is to increase the minimum
cluster size instead, or is there any reason why we would want smaller
clusters if we already guarantee that the minimum allocation is 512
bytes?

If we're going to reserve all 64 bits for the bitmap anyway I don't know
if there's a good reason not to use them all.

>> (3) Storing the bitmap somewhere else
>>=20
>>     This would involve storing the bitmap separate from the L2 tables
>>     (perhaps using the bitmaps extension? I haven't looked much into
>>     this).
>>=20
>>     * Pros:
>>       + Possibility to make the number of subclusters configurable
>>         by the user (32, 64, 128, ...)
>>       + All existing metadata structures would remain untouched
>>         (although the "all zeroes" bit in L2 entries would probably
>>         become unused).
>
> It might still remain useful for optimization purposes, although then
> we get into image consistency questions (if the all zeroes bit is set
> but subcluster map claims allocation, or if the all zeroes bit is
> clear but all subclusters claim zero, which one wins).

If we keep the bit we'd need to define its semantics clearly. We're
going to run into a similar problem with the subcluster state bits (we
have three states but two bits, so four possible values).

> Having the subcluster table directly in the L2 means that updating the
> L2 table is done with a single write. You are definitely right that
> having the subcluster table as a bitmap in a separate cluster means
> two writes instead of one, but as always, it's hard to predict how
> much of an impact that is without benchmarks.

Yes, this one almost feels like the cleanest alternative of the three I
described, but I suspect its effect on I/O performance would be
noticeable.

> The fact that you already have numbers proving the speedups that are
> possible when first allocating the image make this sound like a useful
> project, even though it is an incompatible image change that old tools
> won't be able to recognize. You'll want to make sure 'qemu-img amend'
> can rewrite an image with subclusters into an older image.

Yes, definitely.

Thanks a lot for your feedback!

Berto
