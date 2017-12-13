Received: from eggs.gnu.org ([2001:4830:134:3::10]:49477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ePEYD-0004rq-Al
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:26:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ePEYC-0002Bq-9y
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:26:49 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20171206144550.22295-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a8005de2-746c-cdd3-b951-e6c23a7d6c2f@redhat.com>
Date: Wed, 13 Dec 2017 22:26:31 +0100
MIME-Version: 1.0
In-Reply-To: <20171206144550.22295-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/9] blockdev: fix QMP 'transaction'
 with IOThreads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

On 06/12/2017 15:45, Stefan Hajnoczi wrote:
> v2:
>  * Use StrOrNull for x-blockdev-set-iothread iothread argument [eblake]
> 
> (This is for QEMU 2.12 because this bug is not -rc4 critical)
> 
> Previously AioContext was held across QMP 'transaction' in an attempt to
> achieve bdrv_drained_begin/end() semantics.  Nowadays we have
> bdrv_drained_begin/end() and the AioContext lock just protects state.
> Therefore there is no reason to hold AioContext across
> .prepare/.commit/.abort/.clean() anymore.
> 
> Besides being cleanup-worthy, holding AioContext also exposes a bug:
> BDRV_POLL_WHILE() doesn't support recursive AioContext locking and will hang if
> depth > 1.  This is easy to trigger by submitting a transaction with 2 actions
> that touch two drives assigned to an IOThread.  The IOThread's AioContext will
> be locked twice and BDRV_POLL_WHILE() will hang.
> 
> BDRV_POLL_WHILE() is best fixed by eliminating the AioContext lock entirely in
> favor of fine-grained locking.  I discussed some fixes for BDRV_POLL_WHILE()
> with Paolo but we came to the conclusion that it will just add complexity when
> we really want to stop using AioContext locking.
> 
> Summary:
> 
>  * Patch 1 fixes missing AioContext lock protection
> 
>  * Patches 2-6 clean up excessive AioContext locked regions in QMP
>    'transaction' to solve the hang
> 
>  * Patches 7-9 add a qemu-iotests test case and the necessary infrastructure
> 
> Stefan Hajnoczi (9):
>   blockdev: hold AioContext for bdrv_unref() in
>     external_snapshot_clean()
>   block: don't keep AioContext acquired after
>     external_snapshot_prepare()
>   block: don't keep AioContext acquired after drive_backup_prepare()
>   block: don't keep AioContext acquired after blockdev_backup_prepare()
>   block: don't keep AioContext acquired after
>     internal_snapshot_prepare()
>   block: drop unused BlockDirtyBitmapState->aio_context field
>   iothread: add iothread_by_id() API
>   blockdev: add x-blockdev-set-iothread testing command
>   qemu-iotests: add 202 external snapshots IOThread test
> 
>  qapi/block-core.json       |  36 +++++++
>  include/sysemu/iothread.h  |   1 +
>  blockdev.c                 | 258 +++++++++++++++++++++++++++++++++------------
>  iothread.c                 |   7 ++
>  tests/qemu-iotests/202     |  95 +++++++++++++++++
>  tests/qemu-iotests/202.out |  11 ++
>  tests/qemu-iotests/group   |   1 +
>  7 files changed, 339 insertions(+), 70 deletions(-)
>  create mode 100755 tests/qemu-iotests/202
>  create mode 100644 tests/qemu-iotests/202.out
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
