Received: from eggs.gnu.org ([2001:4830:134:3::10]:34870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gTqkf-00009r-8d
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:07:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gTqkX-0002CN-82
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:07:17 -0500
Date: Mon, 3 Dec 2018 17:06:54 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181203160654.GB6847@localhost.localdomain>
References: <20181129101801.6421-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129101801.6421-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] mirror dead-lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, jcody@redhat.com, pbonzini@redhat.com, dplotnikov@virtuozzo.com, den@openvz.org, qemu-stable@nongnu.org

Am 29.11.2018 um 11:17 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Hi all!
> 
> v2: add fix:)
> 
> We've faced the following mirror bug:
> 
> Just run mirror on qcow2 image more than 1G, and qemu is in dead lock.
> 
> Dead lock described in 01, in short, we have extra aio_context_acquire
> and aio_context_release around blk_aio_pwritev in mirror_read_complete.
> So, write may yield to the main loop, and aio context is acquired. Main
> loop than hangs on trying to lock BQL, which is locked by cpu thread,
> and the cpu thread hangs on trying to acquire aio context.
> 
> Hm, now the thing looks fixed, by I still have a questions:
> 
> Is it a common thing, that we can't yield inside
> aio_context_acquire/release ?
> 
> Was commit b9e413dd3756 
> "block: explicitly acquire aiocontext in aio callbacks that need it"
> wrong? Why it added these acquire/release, when it is written in 
> multiple-iothreads.txt, that "Side note: the best way to schedule a function
> call across threads is to call aio_bh_schedule_oneshot().  No acquire/release
> or locking is needed."
> 
> Can someone in short describe, what BQL and aio context lock means, what they
> protect, and haw they should cooperate?

Thanks, applied patch 1 to the block branch. (We'll use Max' v3 for the
test case.)

Kevin
