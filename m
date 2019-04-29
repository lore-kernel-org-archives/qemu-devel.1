Received: from eggs.gnu.org ([209.51.188.92]:52214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hL3kJ-00051C-TH
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 06:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hL3fx-0004TZ-Tp
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 06:38:22 -0400
Date: Mon, 29 Apr 2019 12:38:16 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190429103816.GE8492@localhost.localdomain>
References: <57c36dca-c4d6-9b70-7799-0be96325d7c5@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57c36dca-c4d6-9b70-7799-0be96325d7c5@yandex-team.ru>
Subject: Re: [Qemu-devel] aio context ownership during bdrv_close()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Kuchin <antonkuchin@yandex-team.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, yc-core =?utf-8?B?KNGA0LDRgdGB0YvQu9C60LAp?= <yc-core@yandex-team.ru>

Am 26.04.2019 um 14:24 hat Anton Kuchin geschrieben:
> I can't figure out ownership of aio context during bdrv_close().
> 
> As far as I understand bdrv_unref() shold be called with acquired aio
> context to prevent concurrent operations (at least most usages in blockdev.c
> explicitly acquire and release context, but not all).

I think the theory is like this:

1. bdrv_unref() can only be called from the main thread

2. A block node for which bdrv_close() is called has no references. If
   there are no more parents that keep it in a non-default iothread,
   they should be in the main AioContext. So no locks need to be taken
   during bdrv_close().

In practice, 2. is not fully true today, even though block devices do
stop their dataplane and move the block nodes back to the main
AioContext on shutdown. I am currently working on some fixes related to
this, afterwards the situation should be better.

> But if refcount reaches zero and bs is going to be deleted in bdrv_close()
> we need to ensure that drain is finished data is flushed and there are no
> more pending coroutines and bottomhalves, so drain and flush functions can
> enter coroutine and perform yield in several places. As a result control
> returns to coroutine caller that will release aio context and when
> completion bh will continue cleanup process it will be executed without
> ownership of context. Is this a valid situation?

Do you have an example where this happens?

Normally, leaving the coroutine means that the AioContext lock is
released, but it is later reentered from the same AioContext, so the
lock will be taken again.

> Moreover if yield happens bs that is being deleted has zero refcount but is
> still present in lists graph_bdrv_states and all_bdrv_states and can be
> accidentally accessed. Shouldn't we remove it from these lists ASAP when
> deletion process starts as we do from monitor_bdrv_states?

Hm, I think it should only disappear when the image file is actually
closed. But in practice, it probably makes little difference either way.

Kevin
