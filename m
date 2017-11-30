Received: from eggs.gnu.org ([2001:4830:134:3::10]:45987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKQtH-0008EF-NT
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 10:36:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKQtD-0002Py-Oj
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 10:36:43 -0500
References: <20171012185916.22776-1-eblake@redhat.com>
	<c77f61fd-62ed-7c81-4017-c39470d979a1@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ed767f8a-eed2-85db-e02f-0f957862a9ee@redhat.com>
Date: Thu, 30 Nov 2017 09:36:25 -0600
MIME-Version: 1.0
In-Reply-To: <c77f61fd-62ed-7c81-4017-c39470d979a1@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 00/20] add byte-based block_status
 driver callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org

On 11/30/2017 07:04 AM, Vladimir Sementsov-Ogievskiy wrote:
> Most of conversions looks fine, but it is not simple to prove the
> correctness, because we start to use internal driver logic on offsets
> and lengths, not aligned to sectors.

The block layer guarantees that it will not pass unaligned data to the 
drivers, given the driver's definition of request_alignment.  For 
drivers that have a request_alignment of 1, you are correct that the 
driver now sees requests at a smaller alignment than before, so it needs 
to be carefully reviewed per-driver.  But for drivers that are still 
sector-based (where request_alignment is 512 for other reasons), there 
is no change in behavior.

> And we can't imagine the
> consequences (at least, I can't and my r-b doesn't give the guarantee)
> of such change. It is like take some function and expand its scope of
> parameters.
> 
> May be I'm too paranoiac. May be it would be good to align requests
> in bdrv_co_block_status to sectors at least for drivers which do not
> provide request_alignment. May be each patch should be reviewed by
> person, knowing that particular driver.

ALL drivers have request_alignment set to a non-zero value; it defaults 
to 1 if the driver provides modern interfaces and does not override the 
value, and defaults to 512 if the driver still uses older sector-based 
interfaces.  But I do welcome additional review; I have to post a v5 anyway.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
