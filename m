Received: from eggs.gnu.org ([2001:4830:134:3::10]:43489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cyevM-0000cN-P1
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 09:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cyevJ-0004Z3-Kz
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 09:36:36 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <3654f226-d51a-5013-8301-5beb83200aa8@openvz.org>
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<2b915695-29b5-df8d-4d89-080eeaaaff13@openvz.org>
	<w51shlcv7sb.fsf@maestria.local.igalia.com>
	<565c1e1b-b9e1-e9c5-790e-283d04afc747@openvz.org>
	<20170413130555.GC5095@noname.redhat.com>
	<3654f226-d51a-5013-8301-5beb83200aa8@openvz.org>
Date: Thu, 13 Apr 2017 15:36:27 +0200
Message-ID: <w51mvbkv38k.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu 13 Apr 2017 03:09:53 PM CEST, Denis V. Lunev wrote:
>>> For nowadays SSD we are facing problems somewhere else. Right now I
>>> can achieve only 100k IOPSes on SSD capable of 350-550k. 1 Mb block
>>> with preallocation and fragmented L2 cache gives same 100k. Tests
>>> for initially empty image gives around 80k for us.
>> Preallocated images aren't particularly interesting to me. qcow2 is
>> used mainly for two reasons. One of them is sparseness (initially
>> small file size) mostly for desktop use cases with no serious I/O, so
>> not that interesting either. The other one is snapshots, i.e. backing
>> files, which doesn't work with preallocation (yet).
>>
>> Actually, preallocation with backing files is something that
>> subclusters would automatically enable: You could already reserve the
>> space for a cluster, but still leave all subclusters marked as
>> unallocated.
>
> I am spoken about fallocate() for the entire cluster before actual
> write() for originally empty image. This increases the performance of
> 4k random writes 10+ times. In this case we can just write those 4k
> and do nothing else.

You're talking about using fallocate() for filling a cluster with zeroes
before writing data to it.

As noted earlier in this thread, this works if the image is empty or if
it doesn't have a backing file.

And if the image is not empty you cannot guarantee that the cluster
contains zeroes (you can use FALLOC_FL_ZERO_RANGE, but that won't work
in all cases).

Berto
