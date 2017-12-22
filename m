Received: from eggs.gnu.org ([2001:4830:134:3::10]:42130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSNXn-0002aS-Ou
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:39:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSNXn-0006Jv-2X
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:39:23 -0500
Date: Fri, 22 Dec 2017 14:39:11 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171222133911.GG3763@localhost.localdomain>
References: <20171212160450.17510-1-vsementsov@virtuozzo.com>
	<20171212160450.17510-3-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171212160450.17510-3-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] qcow2: handle reopening bitmaps on
 bdrv_invalidate_cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, crosa@redhat.com, ehabkost@redhat.com, den@openvz.org, jsnow@redhat.com

Am 12.12.2017 um 17:04 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Consider migration with shared storage. Persistent bitmaps are stored
> on bdrv_inactivate. Then, on destination
> process_incoming_migration_bh() calls bdrv_invalidate_cache_all() which
> leads to qcow2_load_autoloading_dirty_bitmaps() which fails if bitmaps
> are already loaded on destination start. In this case we should call
> qcow2_reopen_bitmaps_rw instead.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: John Snow <jsnow@redhat.com>

qcow2_invalidate_cache() calls qcow2_close() first, so why are there
still any bitmaps loaded? Isn't this a bug? Do we leak bitmaps when a
qcow2 image is closed?

Kevin
