Received: from eggs.gnu.org ([2001:4830:134:3::10]:58045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cvxwT-00006H-E5
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 23:18:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cvxwS-0000Ld-7R
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 23:18:37 -0400
MIME-Version: 1.0
In-Reply-To: <CAOGPPbcNAL4D7d8m+6vTyAwMAeZZ+F0cva8c2YwyheWjXdDQ3w@mail.gmail.com>
References: <1491384478-12325-1-git-send-email-lidongchen@tencent.com>
	<20170405093441.GH21911@redhat.com>
	<CAOGPPbcNAL4D7d8m+6vTyAwMAeZZ+F0cva8c2YwyheWjXdDQ3w@mail.gmail.com>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Thu, 6 Apr 2017 11:18:34 +0800
Message-ID: <CAOGPPbehkj+Q3Mid0hCqjm14pmqJAW5YQNJJv-OpvFO+VU7mpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3] migration/block:limit the time used for
 block migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, Lidong Chen <lidongchen@tencent.com>

On Wed, Apr 5, 2017 at 6:44 PM, 858585 jemmy <jemmy858585@gmail.com> wrote:
> On Wed, Apr 5, 2017 at 5:34 PM, Daniel P. Berrange <berrange@redhat.com> wrote:
>> On Wed, Apr 05, 2017 at 05:27:58PM +0800, jemmy858585@gmail.com wrote:
>>> From: Lidong Chen <lidongchen@tencent.com>
>>>
>>> when migration with high speed, mig_save_device_bulk invoke
>>> bdrv_is_allocated too frequently, and cause vnc reponse slowly.
>>> this patch limit the time used for bdrv_is_allocated.
>>
>> Can you explain why calling bdrv_is_allocated is impacting VNC performance ?
>>
>
> bdrv_is_allocated is called after qemu_mutex_lock_iothread.
>
>     if (bmds->shared_base) {
>         qemu_mutex_lock_iothread();
>         aio_context_acquire(blk_get_aio_context(bb));
>         /* Skip unallocated sectors; intentionally treats failure as
>          * an allocated sector */
>         while (cur_sector < total_sectors &&
>                !bdrv_is_allocated(blk_bs(bb), cur_sector,
>                                   MAX_IS_ALLOCATED_SEARCH, &nr_sectors)) {
>             cur_sector += nr_sectors;
>         }
>         aio_context_release(blk_get_aio_context(bb));
>         qemu_mutex_unlock_iothread();
>     }
>
> and the main thread is also call qemu_mutex_lock_iothread.
>
> #0  0x00007f107322f264 in __lll_lock_wait () from /lib64/libpthread.so.0
> #1  0x00007f107322a508 in _L_lock_854 () from /lib64/libpthread.so.0
> #2  0x00007f107322a3d7 in pthread_mutex_lock () from /lib64/libpthread.so.0
> #3  0x0000000000949ecb in qemu_mutex_lock (mutex=0xfc51a0) at
> util/qemu-thread-posix.c:60
> #4  0x0000000000459e58 in qemu_mutex_lock_iothread () at /root/qemu/cpus.c:1516
> #5  0x0000000000945322 in os_host_main_loop_wait (timeout=28911939) at
> util/main-loop.c:258
> #6  0x00000000009453f2 in main_loop_wait (nonblocking=0) at util/main-loop.c:517
> #7  0x00000000005c76b4 in main_loop () at vl.c:1898
> #8  0x00000000005ceb77 in main (argc=49, argv=0x7fff921182b8,
> envp=0x7fff92118448) at vl.c:4709
>
>> Migration is running in a background thread, so shouldn't be impacting the
>> main thread which handles VNC, unless the block layer is perhaps acquiring
>> the global qemu lock ? I wouldn't expect such a lock to be held for just
>> the bdrv_is_allocated call though.
>>

I'm not sure it's safe to remove qemu_mutex_lock_iothread. i will
analyze and test it later.
this patch is simple, and can solve the problem now.

>> Regards,
>> Daniel
>> --
>> |: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
>> |: http://libvirt.org              -o-             http://virt-manager.org :|
>> |: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
