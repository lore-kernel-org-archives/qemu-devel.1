Received: from eggs.gnu.org ([2001:4830:134:3::10]:56482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ct1M7-0003Gx-9U
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 20:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ct1M3-0000TW-0h
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 20:20:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ct1M2-0000TF-NA
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 20:20:50 -0400
Date: Wed, 29 Mar 2017 08:20:46 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170329002046.GA6261@lemon.lan>
References: <1490717566-25516-1-git-send-email-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490717566-25516-1-git-send-email-den@openvz.org>
Subject: Re: [Qemu-devel] [PATCH for 2.9 1/1] block: add missed
 aio_context_acquire into release_drive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>

On Tue, 03/28 19:12, Denis V. Lunev wrote:
> Recently we expirience hang with iothreads enabled with the following
> call trace:
> Thread 1 (Thread 0x7fa95efebc80 (LWP 177117)):
> 0  ppoll () from /lib64/libc.so.6
> 2  qemu_poll_ns () at qemu-timer.c:313
> 3  aio_poll () at aio-posix.c:457
> 4  bdrv_flush () at block/io.c:2641
> 5  bdrv_close () at block.c:2143
> 6  bdrv_delete () at block.c:2352
> 7  bdrv_unref () at block.c:3429
> 8  blk_remove_bs () at block/block-backend.c:427
> 9  blk_delete () at block/block-backend.c:178
> 10 blk_unref () at block/block-backend.c:226
> 11 object_property_del_all () at qom/object.c:399
> 12 object_finalize () at qom/object.c:461
> 13 object_unref () at qom/object.c:898
> 14 object_property_del_child () at qom/object.c:422
> 15 qmp_marshal_device_del () at qmp-marshal.c:1145
> 16 handle_qmp_command () at /usr/src/debug/qemu-2.6.0/monitor.c:3929
> 
> Technically bdrv_flush() stucks in
>     while (rwco.ret == NOT_DONE) {
>         aio_poll(aio_context, true);
>     }
> but rwco.ret is equal to 0 thus we have missed wakeup. Code investigation
> reveals that we do not have performed aio_context_acquire() on this call
> stack.
> 
> This patch adds missed lock.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Eric Blake <eblake@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>

Nit: reading the subject I thought it's an unbalanced acquire/release, but it is
actually a missing pair.

In bdrv_unref we should have asserted we have acquired the AioContext, that way
you wouldn't have been bit by this bug.

Reviewed-by: Fam Zheng <famz@redhat.com>
