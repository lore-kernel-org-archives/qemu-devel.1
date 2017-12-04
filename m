Received: from eggs.gnu.org ([2001:4830:134:3::10]:41284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eLzHn-0007lc-4t
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 17:32:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eLzHl-0008Mh-TP
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 17:32:27 -0500
References: <1509551048-129830-1-git-send-email-anton.nefedov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <51f11f12-3cd1-2db0-8969-1c5b2cdcdae4@redhat.com>
Date: Mon, 4 Dec 2017 17:32:16 -0500
MIME-Version: 1.0
In-Reply-To: <1509551048-129830-1-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 00/15] qcow2: space
 preallocation and COW improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@virtuozzo.com, qemu-block@nongnu.org, mreitz@redhat.com

Friendly ping; this has gone over 30 days without a reply on the list. I
recommend rebasing and trying again after 2.11 hits.

Thanks,
--John

On 11/01/2017 11:43 AM, Anton Nefedov wrote:
> v5: rebased, patches slightly reordered;
>     cluster allocation (to avoid writing zero-buffers)
>     now goes before an optional ahead preallocation
> 
> v4: http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg00109.html
> 
> This pull request is to improve a few performance problems of qcow2 format:
> 
>   1. non cluster-aligned write requests (to unallocated clusters) explicitly
>      pad data with zeroes if there is no backing data.
>      Resulting increase in ops number and potential cluster fragmentation
>      (on the host file) is already solved by:
>        ee22a9d qcow2: Merge the writing of the COW regions with the guest data
>      However, in case of zero COW regions, that can be avoided at all
>      but the whole clusters are preallocated and zeroed in a single
>      efficient write_zeroes() operation
> 
>   2. moreover, efficient write_zeroes() operation can be used to preallocate
>      space megabytes (*configurable number) ahead which gives noticeable
>      improvement on some storage types (e.g. distributed storage)
>      where the space allocation operation might be expensive)
> 
>   3. this will also allow to enable simultaneous writes to the same unallocated
>      cluster after the space has been allocated & zeroed but before
>      the first data is written and the cluster is linked to L2.
>      (Not included in this patchset).
> 
> Efficient write_zeroes usually implies that the blocks are not actually
> written to but only reserved and marked as zeroed by the storage.
> In this patchset, file-posix driver is marked as supporting this operation
> if it supports (/configured to support) fallocate() operation.
> 
> Existing bdrv_write_zeroes() falls back to writing zero buffers if
> write_zeroes is not supported by the driver.
> A new flag (BDRV_REQ_ALLOCATE) is introduced to avoid that but return ENOTSUP.
> Such allocate requests are also implemented to possibly overlap with the
> other requests. No wait is performed but an error returned in such case as well.
> So the operation should be considered advisory and a fallback scenario still
> handled by the caller (in this case, qcow2 driver).
> 
> Anton Nefedov (12):
>   mirror: inherit supported write/zero flags
>   blkverify: set supported write/zero flags
>   block: introduce BDRV_REQ_ALLOCATE flag
>   block: treat BDRV_REQ_ALLOCATE as serialising
>   file-posix: support BDRV_REQ_ALLOCATE
>   block: support BDRV_REQ_ALLOCATE in passthrough drivers
>   qcow2: move is_zero() up
>   qcow2: skip writing zero buffers to empty COW areas
>   qcow2: set inactive flag
>   qcow2: do not zero out clusters if already preallocated
>   iotest 198: test BDRV_REQ_ALLOCATE
>   iotest 134: test cluster-misaligned encrypted write
> 
> Denis V. Lunev (2):
>   qcow2: preallocation at image expand
>   qcow2: truncate preallocated space
> 
> Pavel Butsykin (1):
>   qcow2: check space leak at the end of the image
> 
>  block/qcow2.h                      |  18 ++++
>  include/block/block.h              |   6 +-
>  include/block/block_int.h          |   2 +-
>  block/blkdebug.c                   |   3 +-
>  block/blkverify.c                  |   9 ++
>  block/file-posix.c                 |   8 ++
>  block/io.c                         |  47 +++++++--
>  block/mirror.c                     |   5 +
>  block/qcow2-cluster.c              |  14 ++-
>  block/qcow2-refcount.c             |   7 ++
>  block/qcow2.c                      | 202 +++++++++++++++++++++++++++++++++----
>  block/raw-format.c                 |   3 +-
>  block/trace-events                 |   1 +
>  qemu-options.hx                    |   4 +
>  tests/qemu-iotests/026.out         |  94 +++++++++++++----
>  tests/qemu-iotests/026.out.nocache |  94 +++++++++++++----
>  tests/qemu-iotests/029.out         |   5 +-
>  tests/qemu-iotests/060             |   2 +-
>  tests/qemu-iotests/060.out         |  13 ++-
>  tests/qemu-iotests/061.out         |   5 +-
>  tests/qemu-iotests/066             |   2 +-
>  tests/qemu-iotests/066.out         |   9 +-
>  tests/qemu-iotests/098.out         |   7 +-
>  tests/qemu-iotests/108.out         |   5 +-
>  tests/qemu-iotests/112.out         |   5 +-
>  tests/qemu-iotests/134             |   9 ++
>  tests/qemu-iotests/134.out         |  10 ++
>  tests/qemu-iotests/198             | 146 +++++++++++++++++++++++++++
>  tests/qemu-iotests/198.out         |  50 +++++++++
>  tests/qemu-iotests/group           |   1 +
>  30 files changed, 693 insertions(+), 93 deletions(-)
>  create mode 100755 tests/qemu-iotests/198
>  create mode 100644 tests/qemu-iotests/198.out
> 
