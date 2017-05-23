Received: from eggs.gnu.org ([2001:4830:134:3::10]:53608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dDB9y-0002cX-TR
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dDB9v-0000vj-MW
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:51:42 -0400
Received: from mail-eopbgr20115.outbound.protection.outlook.com
	([40.107.2.115]:20256
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1dDB9u-0000v5-Pw
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:51:39 -0400
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
	<3768e2ea-9333-750f-0228-1014863223b1@redhat.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
Message-ID: <33f2d819-1bab-15db-76ab-5754b3e478c7@virtuozzo.com>
Date: Tue, 23 May 2017 17:51:30 +0300
MIME-Version: 1.0
In-Reply-To: <3768e2ea-9333-750f-0228-1014863223b1@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v1 00/13] qcow2: space preallocation and
 COW improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, Alberto Garcia <berto@igalia.com>

On 05/23/2017 05:35 PM, Eric Blake wrote:
> On 05/19/2017 04:34 AM, Anton Nefedov wrote:
>> This pull request is to address a few performance problems of qcow2 format:
>>
>>   1. non cluster-aligned write requests (to unallocated clusters) explicitly
>>     pad data with zeroes if there is no backing data. This can be avoided
>>     and the whole clusters are preallocated and zeroed in a single
>>     efficient write_zeroes() operation, also providing better host file
>>     continuity
>>
>>   2. moreover, efficient write_zeroes() operation can be used to preallocate
>>     space megabytes ahead which gives noticeable improvement on some storage
>>     types (e.g. distributed storages where space allocation operation is
>>     expensive)
>>
>>   3. preallocating/zeroing the clusters in advance makes possible to enable
>>     simultaneous writes to the same unallocated cluster, which is beneficial
>>     for parallel sequential write operations which are not cluster-aligned
>>
>> Performance test results are added to commit messages (see patch 3, 12)
> And now Berto has posted parallel patches. I'm not sure which ones to
> focus on, or if you can work it out between you on the best approach
> forward...
>
> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg05236.html
>
I have seen those patches and will comment.

yes, they are intersect. He is concentrating on the fact of performing
operation in minimal read/write amount. We have made an attempt
to minimize amount of IO in the expand case.

Frankly speaking Berto patches are not that influenced. We definitely
should merge IO if write_zeroes are impossible. Thus both could
be merged in parallel.

What I want to note is the fact that there is another big problem
in QCOW2 layer. We have 64k block by default. Guest request
can be 4-5Mb in total. If the image is fragmented, most like
it will if it is old, we will have sequentially read/write the data.
Thus in ideal world we should switch to co-routine pool and the
same approach would be the best in COW too.

Pls note, that this also would very positively influence VM downtime
on migration as bdrv_drain_all is one the most important time hogs.

Den
