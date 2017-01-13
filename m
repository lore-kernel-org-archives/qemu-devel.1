Received: from eggs.gnu.org ([2001:4830:134:3::10]:40760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cRzNt-0001Dr-UP
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 05:47:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cRzNq-0003eD-OU
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 05:47:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cRzNq-0003du-GB
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 05:46:58 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1483513091-30661-1-git-send-email-douly.fnst@cn.fujitsu.com>
Date: Fri, 13 Jan 2017 11:46:55 +0100
In-Reply-To: <1483513091-30661-1-git-send-email-douly.fnst@cn.fujitsu.com>
	(Dou Liyang's message of "Wed, 4 Jan 2017 14:58:09 +0800")
Message-ID: <878tqfxmn4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC v3 0/2] block/qapi: refactor and
 optimize the qmp_query_blockstats()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: stefanha@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, famz@redhat.com, danpb@redhat.com, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com, qemu-devel@nongnu.org

Dou Liyang <douly.fnst@cn.fujitsu.com> writes:

> Change log v2 -> v3:
>  1. Remove the unnecessary code for the bdrv_next_node().
>  2. Remove the change of the locking rules.
>     Even if this change can improve the performance, but it may
>     effect the consistency.
>
> For the multi-disks guest, we can use the dataplane feature to
> hold performance does not drop, if we execute some slow monitor
> commands, such as "info blockstats". But, without this feature, 
> How to reduce the decline in performance?
>
> These patches aim to refactor the qmp_query_blockstats() and
> improve the performance by reducing the running time of it.
>
> There are the two jobs:
>
> 1 For the performance:
>
> 1.1 the time it takes(ns) in each time:
> the disk numbers     | 10    | 500
> -------------------------------------
> before these patches | 19429 | 667722 
> after these patches  | 18536 | 627945
>
> 1.2 the I/O performance is degraded(%) during the monitor:
>
> the disk numbers     | 10    | 500
> -------------------------------------
> before these patches | 1.3   | 14.2
> after these patches  | 1.0   | 11.3
>
> used the dd command likes this to test: 
> dd if=date_1.dat of=date_2.dat conv=fsync oflag=direct bs=1k count=100k.
>
> 2 refactor qmp_query_blockstats():
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

Thanks for the picture, it helps.

Your patches make the code easier to follow, and shorter, too.  The
performance impact is unexpected.  But the code cleanup is worthwhile
even without it.  Please develop this into a non-RFC patch submission.
