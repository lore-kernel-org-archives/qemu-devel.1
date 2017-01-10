Received: from eggs.gnu.org ([2001:4830:134:3::10]:45772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cR1Th-0001uT-DL
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 13:49:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cR1Tg-0004qK-64
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 13:49:01 -0500
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
	<20170109110427.GC30228@stefanha-x1.localdomain>
	<20170110060521.GF30425@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <d78b851c-d9db-f665-9fe4-8444136b3e49@redhat.com>
Date: Tue, 10 Jan 2017 13:48:51 -0500
MIME-Version: 1.0
In-Reply-To: <20170110060521.GF30425@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/21] new backup architecture
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, den@openvz.org, pbonzini@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>



On 01/10/2017 01:05 AM, Jeff Cody wrote:
> On Mon, Jan 09, 2017 at 11:04:27AM +0000, Stefan Hajnoczi wrote:
>> On Fri, Dec 23, 2016 at 05:28:43PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>
>> Jeff or John: are you reviewing this?
> 
> It's in my review queue, but it would probably be a good one for John to
> review as well if he has time.
> 

Sorry, just back from vacation. It may take me a bit to get to it.

>>
>>> This is a new architecture for backup. It solves some current problems:
>>> 1. intersecting requests: for now at request start we wait for all intersecting requests, which means that
>>>     a. we may wait even for unrelated to our request clusters
>>>     b. not full async: if we are going to copy clusters 1,2,3,4, when 2 and 4 are in flight, why should we wait for 2 and 4 to be fully copied? Why not to start 1 and 3 in parallel with 2 and 4?
>>>
>>> 2. notifier request is internally synchronous: if notifier starts copying clusters 1,2,3,4, they will be copied one by one in synchronous loop.
>>>
>>> 3. notifier wait full copying of corresponding clusters (when actually it may wait only for _read_ operations to be finished)
>>>
>>> In short, what is done:
>>> 1. full async scheme
>>> 4. no intersecting requests
>>> 3. notifiers can wait only for read, not for write
>>> 4. notifiers wait only for corresponding clusters
>>> 5. time limit for notifiers
>>> 5. skip unallocated clusters for full mode
>>> 6. use HBitmap as main backup bitmap and just init it from dirty bitmap for incremental case
>>> 7. retrying: do not reread on write fail
>>>
>>> # Intro
>>>
>>> Instead of sync-copying + async-notifiers as in old backup, or aio requests like in mirror, this scheme just start 24 workers - separate coroutines, each of them copying clusters synchronously. Copying is only done by one cluster, there are no large requests.
>>> The only difference for clusters, awaited by write notifiers, is larger priority. So, notifiers do not start io requests, they just mark some clusters as awaited and yield. Then, when some worker completes read of last cluster, awaited by this notifier it will enter it.
>>>
>>> # Some data structures
>>>
>>> Instead of done_bitmap - copy_bitmap, like in mirror.
>>> HBitmap copy_bitmap
>>>     Exactly, what should be copied:
>>>     0 - may mean one of three things:
>>>         - this cluster should not be copied at all
>>>         - this cluster is in flight
>>>         - this cluster is already copied
>>>     1 - means that cluster should be copied, but not touched yet (no async io exists for it)
>>>
>>> New bitmap: notif_wait_bitmap - not HBitmap, just Bitmap.
>>>     Exactly, in flight clusters, waiting for read operation:
>>>     0 - may mean one of three things:
>>>         - this cluster should not be copied at all
>>>         - this cluster is in flight and it is _already_ read to memory
>>>         - this cluster is already copied
>>>     1 - means that cluster is in flight, but read operation have not finished
>>>         yet
>>>     The only exception is none-mode: in this case 1 means in flight: in io read or write. This is needed for image fleecing.
>>>
>>> Cluster states (copy_bitmap, notif_wait_bitmap)
>>>
>>> 0, 0 - Ignored (should not be copied at all) or In flight (read done) or Copied
>>> 0, 1 - In flight, read operation not finished (or write op. - for none-mode)
>>> 1, 0 - Should be copied, but not touched yet
>>> 1, 1 - Impossible state
>>>
>>> NotifierRequest - request from notifier, it changes sequence of cluster copying by workers.
>>> NotifierRequest {
>>>     int64_t start;
>>>     int64_t end;
>>>     int nb_wait; // nb clusters (in specified range) that should be copied but not already read, i.e. clusters awaited by this notifier
>>>     Coroutine *notif; // corresponding notifier coroutine
>>> }
>>>
>>> notifier_reqs - list of notifier requests
>>>
>>> # More info
>>>
>>> At backup start copy_bitmap is inited to sync_bitmap for incremental backup. For top/full backup it is inited to all ones, but in parallel with workers main coroutine skips not allocated clusters.
>>>
>>> Worker coroutines are copying clusters, preferable awaited by notifiers (for which NotifierRequest exists in the list). Function get_work helps them.
>>> Workers will copy clusters, awaited by notifiers even if block-job is paused - it is the same behaviour  as in old architecture.
>>>
>>> Old backup fails guest-write if notifier fails to backup corresponding clusters. In the new scheme there is a little difference: notifier just wait for 5s and if backup can't copy all corresponding clusters in this time - guest-write fails.
>>> Error scenarios was considered on list, the final solution was to provide user a possibility to chose what should be failed: backup or guest-write. I'll add this later.
>>>
>>> Worker can exit (no more clusters to copy or fatal error) or pause (error or user pause or throttling). When last worker goes to pause it rings up main block-job coroutine, which will handle user pause or errors. We need to handle errors in main coroutine because of nature of block_job_error_action, which may yield.
>>>
>>> There also is a bonus: new io-retrying scheme: if there is an error on read or write, worker just yield in the retrying loop and if it will be resumed (with job->error_exit = false) it will continue from the same place, so if we have failed write after successful read we will not reread.
>>>
>>> Vladimir Sementsov-Ogievskiy (21):
>>>   backup: move from done_bitmap to copy_bitmap
>>>   backup: init copy_bitmap from sync_bitmap for incremental
>>>   backup: improve non-dirty bits progress processing
>>>   backup: use copy_bitmap in incremental backup
>>>   hbitmap: improve dirty iter
>>>   backup: rewrite top mode cluster skipping
>>>   backup: refactor: merge top/full/incremental backup code
>>>   backup: skip unallocated clusters for full mode
>>>   backup: separate copy function
>>>   backup: refactor backup_copy_cluster()
>>>   backup: move r/w error handling code to r/w functions
>>>   iotests: add supported_cache_modes to main function
>>>   coroutine: add qemu_coroutine_add_next
>>>   block: add trace point on bdrv_close_all
>>>   bitmap: add bitmap_count_between() function
>>>   hbitmap: add hbitmap_count_between() function
>>>   backup: make all reads not serializing
>>>   backup: new async architecture
>>>   backup: refactor backup_do_cow
>>>   backup: move bitmap handling from backup_do_cow to get_work
>>>   backup: refactor: remove backup_do_cow()
>>>
>>>  block.c                       |   1 +
>>>  block/backup.c                | 871 +++++++++++++++++++++++++++++++-----------
>>>  block/trace-events            |  34 +-
>>>  blockjob.c                    |  29 +-
>>>  include/block/blockjob.h      |  15 +-
>>>  include/qemu/bitmap.h         |   4 +
>>>  include/qemu/coroutine.h      |   2 +
>>>  include/qemu/hbitmap.h        |  26 +-
>>>  tests/qemu-iotests/055        |   4 +-
>>>  tests/qemu-iotests/129        |   6 +-
>>>  tests/qemu-iotests/iotests.py |   7 +-
>>>  util/bitmap.c                 |  27 ++
>>>  util/hbitmap.c                |  32 +-
>>>  util/qemu-coroutine.c         |   7 +
>>>  14 files changed, 805 insertions(+), 260 deletions(-)
>>>
>>> -- 
>>> 1.8.3.1
>>>
> 
> 
