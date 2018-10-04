Received: from eggs.gnu.org ([2001:4830:134:3::10]:58777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g82zw-0002zv-0W
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 08:44:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g82zt-0006QQ-T7
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 08:44:55 -0400
Date: Thu, 4 Oct 2018 14:44:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181004124421.GC6009@localhost.localdomain>
References: <20181001102928.20533-1-vsementsov@virtuozzo.com>
	<20181001102928.20533-14-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001102928.20533-14-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v3 13/18] block: introduce new filter
 driver: fleecing-hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, eblake@redhat.com, armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com, stefanha@redhat.com, jsnow@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com, den@openvz.org

Am 01.10.2018 um 12:29 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Fleecing-hook filter does copy-before-write operation. It should be
> inserted above active disk and has a target node for CBW, like the
> following:
> 
>     +-------+
>     | Guest |
>     +---+---+
>         |r,w
>         v
>     +---+-----------+  target   +---------------+
>     | Fleecing hook |---------->| target(qcow2) |
>     +---+-----------+   CBW     +---+-----------+
>         |                           |
> backing |r,w                        |
>         v                           |
>     +---+---------+      backing    |
>     | Active disk |<----------------+
>     +-------------+        r
> 
> Target's backing may point to active disk (should be set up
> separately), which gives fleecing-scheme.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This lacks an explanation why we need a specialised fleecing hook driver
rather than just a generic bdrv_backup_top block driver in analogy to
what commit and mirror are already doing.

In fact, if I'm reading the last patch of the series right, backup
doesn't even restrict the use of the fleecing-hook driver to actual
fleecing scenarios.

Maybe what doesn't feel right to me is just that it's a misnomer, and if
you rename it into bdrv_backup_top (and make it internal to the block
job), it is very close to what I actually have in mind?

Kevin
