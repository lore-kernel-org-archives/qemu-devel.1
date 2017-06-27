Received: from eggs.gnu.org ([2001:4830:134:3::10]:46308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dPrS9-0004Wp-Du
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 10:26:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dPrS6-00074d-3u
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 10:26:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dPrS5-00071Z-Sy
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 10:26:50 -0400
References: <20170605123908.18777-1-pbonzini@redhat.com>
	<20170605123908.18777-17-pbonzini@redhat.com>
	<e138c191-5f28-ff50-1b86-d4d1a416eadc@virtuozzo.com>
	<37960694-8f25-8201-5f17-e59c3ee67e90@redhat.com>
	<eb056c7c-2bd7-e9b2-cebb-30f716386d00@virtuozzo.com>
	<c9855403-a641-31a7-f6e9-db0388c4b73a@redhat.com>
	<5ed4c5a0-11f3-14e7-77e6-47fa01a07d75@virtuozzo.com>
	<af36087e-de08-4a30-53f7-0a9fafb56a88@redhat.com>
	<3a438db2-2c6d-e07b-94eb-b7c08073b9ae@virtuozzo.com>
	<e2816225-b5a7-6d60-9772-bff478b10a92@redhat.com>
	<13257113-2f2b-ccf5-93d1-66b2b963efce@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5458c8fb-f73b-6651-b418-87bab8d3d143@redhat.com>
Date: Tue, 27 Jun 2017 16:26:43 +0200
MIME-Version: 1.0
In-Reply-To: <13257113-2f2b-ccf5-93d1-66b2b963efce@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 16/19] block: protect modification of dirty
 bitmaps with a mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com



On 27/06/2017 16:20, Vladimir Sementsov-Ogievskiy wrote:
> I'm likely not right, but for me introducing this mutex looks like dirty
> bitmaps may be accessed from concurrent threads. So for me it looks
> strange that only accessors are protected by the mutex and not the whole
> transactions.

There must be something else protecting the whole transaction.

> One example I've wrote above, other examples from code: are
> qmp_block_dirty_bitmap** functions:
> 
> bdrv_create_dirty_bitmap() {
> 
>    bdrv_find_dirty_bitmap()
> 
>    ....
> 
> bdrv_dirty_bitmaps_lock(bs);
>    QLIST_INSERT_HEAD(&bs->dirty_bitmaps, bitmap, list);
>    bdrv_dirty_bitmaps_unlock(bs);
> 
> }
> 
> - we protect inserting into list from other threads, but what prevent
> creating bitmap with the same name from other thread after
> bdrv_find_dirty_bitmap() and before bdrv_dirty_bitmaps_lock() ?

It's like a read-write lock.

The write side is invoked under the 'big QEMU lock' so there cannot be
two concurrent writes.

A bitmap can be written to after bdrv_find_dirty_bitmap returns, but
only if _you_ tell another thread about the bitmap you've just created.
If that doesn't happen, the bitmap cannot change.  And it can also
disappear because _your_ thread is the one with the big QEMU lock.

Paolo
