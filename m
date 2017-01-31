Received: from eggs.gnu.org ([2001:4830:134:3::10]:56420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cYa6H-0004Lm-EJ
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:12:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cYa6D-00009H-Uh
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:12:05 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:13146 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cYa6D-000097-J9
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:12:01 -0500
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
	<20170123121036.4823-10-vsementsov@virtuozzo.com>
	<1d513ca9-a005-4870-7819-981a121e1939@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <1a45d58a-6ad9-3fa8-bac7-8b519dcaa6a3@virtuozzo.com>
Date: Tue, 31 Jan 2017 18:11:45 +0300
MIME-Version: 1.0
In-Reply-To: <1d513ca9-a005-4870-7819-981a121e1939@redhat.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/24] qcow2: add
 .bdrv_load_autoloading_dirty_bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

29.01.2017 01:20, Max Reitz wrote:
> On 23.01.2017 13:10, Vladimir Sementsov-Ogievskiy wrote:
>> Auto loading bitmaps are bitmaps in Qcow2, with the AUTO flag set. They
>> are loaded when the image is opened and become BdrvDirtyBitmaps for the
>> corresponding drive.
>>
>> Extra data in bitmaps is not supported for now.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/Makefile.objs  |   2 +-
>>   block/qcow2-bitmap.c | 712 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   block/qcow2.c        |   2 +
>>   block/qcow2.h        |   3 +
>>   4 files changed, 718 insertions(+), 1 deletion(-)
>>   create mode 100644 block/qcow2-bitmap.c
> [...]
>
>> new file mode 100644
>> index 0000000000..758622dcfc
>> --- /dev/null
>> +++ b/block/qcow2-bitmap.c
> [...]
>
>> +
>> +/*
>> + * Bitmap List end
>> + */
>> +
>> +static int update_ext_header_and_dir_in_place(BlockDriverState *bs,
>> +                                              Qcow2BitmapList *bm_list)
>> +{
>> +    BDRVQcow2State *s = bs->opaque;
>> +    int ret;
>> +
>> +    if (!(s->autoclear_features & QCOW2_AUTOCLEAR_BITMAPS) ||
>> +        bm_list == NULL || QSIMPLEQ_EMPTY(bm_list) ||
>> +        bitmap_list_count(bm_list) != s->nb_bitmaps)
>> +    {
>> +        return -EINVAL;
>> +    }
>> +
>> +    s->autoclear_features &= ~(uint64_t)QCOW2_AUTOCLEAR_BITMAPS;
>> +    ret = update_header_sync(bs);
> This function is defined only in patch 13, until then the code won't
> compile; the definition should be moved into this patch.
>
> Max
>

Stupid omission, sorry =(. I'll move it and add your r-b, ok?


-- 
Best regards,
Vladimir
