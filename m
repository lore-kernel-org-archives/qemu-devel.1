Received: from eggs.gnu.org ([2001:4830:134:3::10]:37142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cyftw-0005tt-Rw
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 10:39:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cyftv-0006O2-JS
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 10:39:12 -0400
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<2b915695-29b5-df8d-4d89-080eeaaaff13@openvz.org>
	<w51shlcv7sb.fsf@maestria.local.igalia.com>
	<565c1e1b-b9e1-e9c5-790e-283d04afc747@openvz.org>
	<20170413130555.GC5095@noname.redhat.com>
	<3654f226-d51a-5013-8301-5beb83200aa8@openvz.org>
	<w51mvbkv38k.fsf@maestria.local.igalia.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <652aee46-5d72-a5c0-944d-a9712efd3948@openvz.org>
Date: Thu, 13 Apr 2017 17:06:24 +0300
MIME-Version: 1.0
In-Reply-To: <w51mvbkv38k.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset="utf-8"
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
To: Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 04/13/2017 04:36 PM, Alberto Garcia wrote:
> On Thu 13 Apr 2017 03:09:53 PM CEST, Denis V. Lunev wrote:
>>>> For nowadays SSD we are facing problems somewhere else. Right now I
>>>> can achieve only 100k IOPSes on SSD capable of 350-550k. 1 Mb block
>>>> with preallocation and fragmented L2 cache gives same 100k. Tests
>>>> for initially empty image gives around 80k for us.
>>> Preallocated images aren't particularly interesting to me. qcow2 is
>>> used mainly for two reasons. One of them is sparseness (initially
>>> small file size) mostly for desktop use cases with no serious I/O, so=

>>> not that interesting either. The other one is snapshots, i.e. backing=

>>> files, which doesn't work with preallocation (yet).
>>>
>>> Actually, preallocation with backing files is something that
>>> subclusters would automatically enable: You could already reserve the=

>>> space for a cluster, but still leave all subclusters marked as
>>> unallocated.
>> I am spoken about fallocate() for the entire cluster before actual
>> write() for originally empty image. This increases the performance of
>> 4k random writes 10+ times. In this case we can just write those 4k
>> and do nothing else.
> You're talking about using fallocate() for filling a cluster with zeroe=
s
> before writing data to it.
>
> As noted earlier in this thread, this works if the image is empty or if=

> it doesn't have a backing file.
>
> And if the image is not empty you cannot guarantee that the cluster
> contains zeroes (you can use FALLOC_FL_ZERO_RANGE, but that won't work
> in all cases).
>
> Berto
yes, I agree here.

But COW operations suffer more from the amount of IO operations
required rather than from the amount of data transferred. Let us
assume that we have 64k cluster represented as [--------]. With
4k write in the middle of the cluster we will have now 5 IOPSes
to perform the operation: read head, write head, write 4k, read tail,
write tail. Normally this should take 2 operations: read entire
cluster (64kb), write entire cluster (64kb).

In this approach further 64kb read of this cluster will result in
1 host IOPS - the file is continuous from the point of the host file
system.

With 8kb subclusters we will have same 1 read and 1 write after the
tuning. The difference is only the amount of data read: 8kb and
8 kb write instead of 64kb read and 64kb write.

Sure the size of the cluster should be increased. Personally I like
1 MB due to my past experience.

At my opinion there is no difference at all in terms of performance
for rotational drive at all for COW of 1 MB cluster and 64 kb cluster
without subclusters. Reading of 1 Mb and reading of 64 kb are the
same (100-150 IOPSes with 150 Mb/s throughput). Further continuous
reads will be much better with 1 MB blocks and without subclusters.

Yes, there is a difference on "average" SSD drives, which gives
40k-100k IOPSes. We will experience slowdown reading 1 MB
instead of 64kb. But the difference is not that big actually.
Top notch nowadays PCIe SSDs can not be saturated with QEMU
nowadays. I am able to reach only 100k IOPSes instead of
300k-500k in host even when the data is written to the existing
clusters. Thus we will have no difference with them between 1 MB
cluster and 64 kb cluster in terms of COW.

So, at my opinion, simple 1 Mb cluster size along as fragmented
L2 cache is very good from all points. Even from COW point ;)
The situation in real life will not be worse or better from the performan=
ce
point of view as we also will avoid additional metadata updates.

Den
