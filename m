Received: from eggs.gnu.org ([2001:4830:134:3::10]:38239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dPr0g-0003In-GV
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dPr0b-0002mb-Hm
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:58:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dPr0b-0002hq-8o
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:58:25 -0400
References: <20170605123908.18777-1-pbonzini@redhat.com>
	<20170605123908.18777-17-pbonzini@redhat.com>
	<e138c191-5f28-ff50-1b86-d4d1a416eadc@virtuozzo.com>
	<37960694-8f25-8201-5f17-e59c3ee67e90@redhat.com>
	<eb056c7c-2bd7-e9b2-cebb-30f716386d00@virtuozzo.com>
	<c9855403-a641-31a7-f6e9-db0388c4b73a@redhat.com>
	<5ed4c5a0-11f3-14e7-77e6-47fa01a07d75@virtuozzo.com>
	<af36087e-de08-4a30-53f7-0a9fafb56a88@redhat.com>
	<3a438db2-2c6d-e07b-94eb-b7c08073b9ae@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e2816225-b5a7-6d60-9772-bff478b10a92@redhat.com>
Date: Tue, 27 Jun 2017 15:58:15 +0200
MIME-Version: 1.0
In-Reply-To: <3a438db2-2c6d-e07b-94eb-b7c08073b9ae@virtuozzo.com>
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



On 27/06/2017 15:51, Vladimir Sementsov-Ogievskiy wrote:
>>>
>>> bdrv_create_dirty_bitmap(...)
>>>
>>> bdrv_dirty_bitmaps_lock(bs)
>>>
>>> bitmap  = bdrv_find_dirty_bitmap(bs, name)
>>>
>>> <some changes>
>>>
>>> bdrv_dirty_bitmaps_unlock(bs)
>>>
>>> - because we can't now trust the pointer returned by
>>> bdrv_create_dirty_bitmap, as it releases bitmap lock before return.
>> If you have the big QEMU lock (you do if you are in the QEMU monitor),
>> you are protected from changes to the list of bitmaps.
>>
>> Paolo
> 
> but you wrote "Writing to the list requires the BQL _and_ the
> dirty_bitmap_mutex".
> 
> should it be BQL only?

bdrv_dirty_bitmaps_lock/unlock is (should be) called by the functions
that write to the list.  I hope I can post the patch today already.

Paolo
