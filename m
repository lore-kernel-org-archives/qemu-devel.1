Received: from eggs.gnu.org ([2001:4830:134:3::10]:55949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dPmml-0007bJ-M3
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:27:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dPmmh-0004oH-OA
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:27:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dPmmh-0004o6-I2
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:27:47 -0400
References: <20170605123908.18777-1-pbonzini@redhat.com>
	<20170605123908.18777-17-pbonzini@redhat.com>
	<e138c191-5f28-ff50-1b86-d4d1a416eadc@virtuozzo.com>
	<37960694-8f25-8201-5f17-e59c3ee67e90@redhat.com>
	<eb056c7c-2bd7-e9b2-cebb-30f716386d00@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c9855403-a641-31a7-f6e9-db0388c4b73a@redhat.com>
Date: Tue, 27 Jun 2017 11:27:42 +0200
MIME-Version: 1.0
In-Reply-To: <eb056c7c-2bd7-e9b2-cebb-30f716386d00@virtuozzo.com>
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



On 27/06/2017 11:07, Vladimir Sementsov-Ogievskiy wrote:
> 26.06.2017 19:54, Paolo Bonzini wrote:
>>
>> On 26/06/2017 18:07, Vladimir Sementsov-Ogievskiy wrote:
>>> HI!
>>>
>>> One question here, should not 'bdrv_undo_clear_dirty_bitmap' be under
>>> lock too?
>> Any call to dirty bitmap functions between bdrv_clear_dirty_bitmap and
>> bdrv_undo_clear_dirty_bitmap is problematic anyway, so
>> bdrv_clear_dirty_bitmap really only needs the lock in the !out case;
>> bdrv_undo_clear_dirty_bitmap is only called when out != NULL.
>>
>> However, I agree it would be cleaner to add the lock there, too.
> 
> Also, you've added comment "Called with BQL taken" both to functions
> that calls bdrv_dirty_bitmaps_lock and that do not... What is BQL?

It's the "big QEMU lock", also known as "iothread lock".  The locking policy
is documented in block_int.h:

    /* Writing to the list requires the BQL _and_ the dirty_bitmap_mutex.
     * Reading from the list can be done with either the BQL or the
     * dirty_bitmap_mutex.  Modifying a bitmap only requires
     * dirty_bitmap_mutex.  */
    QemuMutex dirty_bitmap_mutex;
    QLIST_HEAD(, BdrvDirtyBitmap) dirty_bitmaps;

and the comments in block/dirty-bitmap.c reflect the above comment.

Paolo
