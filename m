Received: from eggs.gnu.org ([2001:4830:134:3::10]:47679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dDtsJ-0000Pb-Os
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:36:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dDtsG-0001At-Lz
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:36:27 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <w51a861rwbs.fsf@maestria.local.igalia.com>
References: <cover.1495536228.git.berto@igalia.com>
	<142326a3-eaa4-8333-9580-ae0063f8a876@redhat.com>
	<w51shjutjz7.fsf@maestria.local.igalia.com>
	<0e3fc298-d47b-4066-c8c8-02f620c50b89@virtuozzo.com>
	<w51poeytefj.fsf@maestria.local.igalia.com>
	<713bf6bf-0c62-f3d7-e486-86a581689e3e@virtuozzo.com>
	<w51a861rwbs.fsf@maestria.local.igalia.com>
Date: Thu, 25 May 2017 16:35:42 +0200
Message-ID: <w517f15rold.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/7] qcow2: Reduce the number
 of I/O ops when doing COW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu 25 May 2017 01:48:39 PM CEST, Alberto Garcia wrote:
>>>> I agree; as mentioned we have similar patches and they don't
>>>> conflict much.  We noticed a performance regression on HDD though,
>>>> for the presumably optimized case (random 4k write over a large
>>>> backed image); so the patches were put on hold.
>>> 
>>> Interesting, I think that scenario was noticeably faster in my
>>> tests. What cluster size(s) and image size(s) were you using?
>>> 
>> 64k cluster, 2g image, write 32m in portions of 4k at random offsets
>
> I just tried that and the optimized case performs better (as
> expected), almost twice as fast in fact:
>
> write: io=32892KB, bw=162944B/s, iops=39, runt=206705msec
> write: io=32892KB, bw=309256B/s, iops=75, runt=108911msec
>
> I'll try in a different machine.

I made more tests of that same scenario with a different HDD:

write: io=32892KB, bw=588588B/s, iops=143, runt= 57224msec
write: io=32892KB, bw=779951B/s, iops=190, runt= 43184msec

And here are the results without a backing file:

write: io=32892KB, bw=1510.2KB/s, iops=377, runt= 21781msec
write: io=32892KB, bw=5417.1KB/s, iops=1354, runt=  6071msec

Berto
