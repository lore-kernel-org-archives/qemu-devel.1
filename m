Received: from eggs.gnu.org ([2001:4830:134:3::10]:52482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dPrnF-0004Ah-Q4
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 10:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dPrnB-0006NA-Nk
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 10:48:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dPrnB-0006L3-IP
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 10:48:37 -0400
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
	<5458c8fb-f73b-6651-b418-87bab8d3d143@redhat.com>
	<54703f2c-46ea-15b5-5c46-7520728bdd1c@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <72a6a322-f016-9726-3175-3578d4a72093@redhat.com>
Date: Tue, 27 Jun 2017 16:48:26 +0200
MIME-Version: 1.0
In-Reply-To: <54703f2c-46ea-15b5-5c46-7520728bdd1c@virtuozzo.com>
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



On 27/06/2017 16:43, Vladimir Sementsov-Ogievskiy wrote:
>> The write side is invoked under the 'big QEMU lock' so there cannot be
>> two concurrent writes.
>>
>> A bitmap can be written to after bdrv_find_dirty_bitmap returns, but
>> only if _you_ tell another thread about the bitmap you've just created.
> 
> no, I'm not about touching just created bitmap. I'm about creating
> bitmap with the same name by other thread (unlikely case, but possible).

You can't unless you drop the BQL.

>> If that doesn't happen, the bitmap cannot change.  And it can also
>> disappear because _your_ thread is the one with the big QEMU lock.
> 
> So, if I under BQL, I don't need dirty_bitmap_lock?

Writing to the list requires _both_ BQL and dirty_bitmap_lock.  Write
functions actually have "called with BQL taken" in dirty-bitmap.c,
because dirty-bitmap.c will call dirty_bitmap_lock/unlock itself.

Reading from the list requires one of the two locks.  Such functions
have "called with BQL or dirty_bitmap lock taken".

For reading/writing to the bitmap itself, you need dirty_bitmap_lock.
dirty-bitmap.c can take the lock itself but, there are also functions
named *_locked where the caller takes the lock.

Paolo
