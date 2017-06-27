Received: from eggs.gnu.org ([2001:4830:134:3::10]:36960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dPquM-0001HC-08
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dPquH-0003rk-15
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:51:58 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:27896 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dPquG-0003lt-Kh
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:51:52 -0400
References: <20170605123908.18777-1-pbonzini@redhat.com>
	<20170605123908.18777-17-pbonzini@redhat.com>
	<e138c191-5f28-ff50-1b86-d4d1a416eadc@virtuozzo.com>
	<37960694-8f25-8201-5f17-e59c3ee67e90@redhat.com>
	<eb056c7c-2bd7-e9b2-cebb-30f716386d00@virtuozzo.com>
	<c9855403-a641-31a7-f6e9-db0388c4b73a@redhat.com>
	<5ed4c5a0-11f3-14e7-77e6-47fa01a07d75@virtuozzo.com>
	<af36087e-de08-4a30-53f7-0a9fafb56a88@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <3a438db2-2c6d-e07b-94eb-b7c08073b9ae@virtuozzo.com>
Date: Tue, 27 Jun 2017 16:51:48 +0300
MIME-Version: 1.0
In-Reply-To: <af36087e-de08-4a30-53f7-0a9fafb56a88@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com

27.06.2017 15:52, Paolo Bonzini wrote:
>
> On 27/06/2017 11:47, Vladimir Sementsov-Ogievskiy wrote:
>> bdrv_enable_dirty_bitmap - writes to the list, it changes 'disabled'
>> field. So it requires both BQL and dirty_bitmap_mutex? But the comment
>> says only about BQL.
> This one is interesting.  There could be a concurrent call to
> bdrv_set_dirty, indeed.  I'll send a patch.
>
>> Also, for example, if I want to create a new bitmap and than somehow
>> change it, should I do it like this:
>>
>> bdrv_create_dirty_bitmap(...)
>>
>> bdrv_dirty_bitmaps_lock(bs)
>>
>> bitmap  = bdrv_find_dirty_bitmap(bs, name)
>>
>> <some changes>
>>
>> bdrv_dirty_bitmaps_unlock(bs)
>>
>> - because we can't now trust the pointer returned by
>> bdrv_create_dirty_bitmap, as it releases bitmap lock before return.
> If you have the big QEMU lock (you do if you are in the QEMU monitor),
> you are protected from changes to the list of bitmaps.
>
> Paolo

but you wrote "Writing to the list requires the BQL _and_ the 
dirty_bitmap_mutex".

should it be BQL only?


-- 
Best regards,
Vladimir
