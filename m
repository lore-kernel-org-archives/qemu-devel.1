Received: from eggs.gnu.org ([2001:4830:134:3::10]:52836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cVeRX-0003gr-1x
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 08:13:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cVeRW-0001G2-3L
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 08:13:55 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1484467275-27919-1-git-send-email-douly.fnst@cn.fujitsu.com>
Date: Mon, 23 Jan 2017 14:13:46 +0100
In-Reply-To: <1484467275-27919-1-git-send-email-douly.fnst@cn.fujitsu.com>
	(Dou Liyang's message of "Sun, 15 Jan 2017 16:01:13 +0800")
Message-ID: <87y3y1ex6d.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 0/2] block/qapi: refactor and optimize
 the qmp_query_blockstats()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: stefanha@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, famz@redhat.com, danpb@redhat.com, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

Cc'ing qemu-block.

Dou Liyang <douly.fnst@cn.fujitsu.com> writes:

> Change log v3 -> v4:
>  1. Develop these into the non-RFC patches.
>  2. Fix some comments.
>  3. do declarations first.
>
> Change log v2 -> v3:
>  1. Remove the unnecessary code for the bdrv_next_node().
>  2. Remove the change of the locking rules.
>     Even if this change can improve the performance, but it may
>     effect the consistency.
>
> The Qemu uses the qmp_query_blockstats() function to get the
> blockstats. As the function has been changed several times, it
> becomes more complex and longer.
>
> For the multi-disks guest, if we want to execute I/O operations
> and this function at the same time. we can use the dataplane
> feature to hold I/O performance does not drop. But, Normally
> without this feature, How to reduce the decline in performance?
>
> These patches refactor the qmp_query_blockstats() to make the
> code easier to follow, and shorter as follows:
>
> From:
>
> +--------------+      +---------------------+
>  | 1            |      | 4.                  |
>  |next_query_bds|      |bdrv_query_bds_stats +---+
>  |              |      |                     |   |
>  +--------^-----+      +-------------^-------+   |
>           |                          |           |
> +---------+----------+      +--------+-------+   |
> | 0.                 |      | 2.             |   |
> |qmp_query_blockstats+------>bdrv_query_stats<----
> |                    |      |                |
> +--------------------+      +--------+-------+
>                                      |
>                        +-------------v-------+
>                        | 3.                  |
>                        |bdrv_query_blk_stats |
>                        |                     |
>                        +---------------------+
>
> To:
>
>                                     +--------------+
>                                     |              |
>                            +--------v-----------+  |
>                        +--->  3.                |  |
> +-------------------+  |   |bdrv_query_bds_stats+--+
> | 1.                +--+   |                    |
> |                   +      +--------------------+
> |qmp_query_blockstats--+
> |                   |  |
> +-------------------+  |   +--------------------+
>                        |   | 2.                 |
>                        +--->                    |
>                            |bdrv_query_blk_stats|
>                            |                    |
>                            +--------------------+
>
>
> They also optimize the fuction by reducing its running time.
>
> 1. The function running time
>
> the time it takes(ns) in each requests:
> the disk numbers     | 10    | 500
> -------------------------------------
> before these patches | 19429 | 667722 
> after these patches  | 18536 | 627945
>
> 2. For the performance
> used the dd command likes this to test: 
> dd if=date_1.dat of=date_2.dat conv=fsync oflag=direct bs=1k count=100k.
>
> the I/O performance is degraded(%) during the monitor:
> the disk numbers     | 10    | 500
> -------------------------------------
> before these patches | 1.3   | 14.2
> after these patches  | 1.0   | 11.3

Series
Reviewed-by: Markus Armbruster <armbru@redhat.com>
