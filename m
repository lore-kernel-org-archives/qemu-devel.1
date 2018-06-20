Received: from eggs.gnu.org ([2001:4830:134:3::10]:59736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVgDL-0003ba-SW
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 12:44:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVgDL-0004qQ-2G
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 12:44:11 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:35811)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVgDK-0004pt-Jy
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 12:44:10 -0400
Received: by mail-oi0-x243.google.com with SMTP id e8-v6so209352oii.2
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 09:44:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8K9eV=GSrvLsz+XmxsD0g1MrZ+MRFbPHYVR6zR7hucQg@mail.gmail.com>
References: <20180313211441.5179-1-jsnow@redhat.com>
	<20180313211441.5179-12-jsnow@redhat.com>
	<CAFEAcA8K9eV=GSrvLsz+XmxsD0g1MrZ+MRFbPHYVR6zR7hucQg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Jun 2018 17:43:48 +0100
Message-ID: <CAFEAcA9hNc1_f7qrJV41pP_WKAb7Zfn9riQyZGBJnanTLd3vnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 11/13] migration: add postcopy migration of
 dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

On 27 April 2018 at 14:22, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 13 March 2018 at 21:14, John Snow <jsnow@redhat.com> wrote:
>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>> Postcopy migration of dirty bitmaps. Only named dirty bitmaps are migrated.
>>
>> If destination qemu is already containing a dirty bitmap with the same name
>> as a migrated bitmap (for the same node), then, if their granularities are
>> the same the migration will be done, otherwise the error will be generated.
>>
>> If destination qemu doesn't contain such bitmap it will be created.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Message-id: 20180313180320.339796-12-vsementsov@virtuozzo.com
>> [Changed '+' to '*' as per list discussion. --js]
>> Signed-off-by: John Snow <jsnow@redhat.com>
>
>> +static int init_dirty_bitmap_migration(void)
>> +{
>
> Hi; Coverity (CID1390625) complains about a possible dereference
> after NULL check in this function:
>
>> +    BlockDriverState *bs;
>> +    BdrvDirtyBitmap *bitmap;
>> +    DirtyBitmapMigBitmapState *dbms;
>> +    BdrvNextIterator it;
>> +
>> +    dirty_bitmap_mig_state.bulk_completed = false;
>> +    dirty_bitmap_mig_state.prev_bs = NULL;
>> +    dirty_bitmap_mig_state.prev_bitmap = NULL;
>> +    dirty_bitmap_mig_state.no_bitmaps = false;
>> +
>> +    for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
>> +        const char *drive_name = bdrv_get_device_or_node_name(bs);
>> +
>> +        /* skip automatically inserted nodes */
>> +        while (bs && bs->drv && bs->implicit) {
>> +            bs = backing_bs(bs);
>> +        }
>
> The 'bs' test in this while() loop implies that we might
> leave the loop because bs == NULL...
>
>> +
>> +        for (bitmap = bdrv_dirty_bitmap_next(bs, NULL); bitmap;
>
> ...but this call to bdrv_dirty_bitmap_next() will always
> dereference bs, so if it's NULL we'll crash.
>
>> +             bitmap = bdrv_dirty_bitmap_next(bs, bitmap))

Hi -- just a nudge that Coverity thinks this one is still unfixed.

thanks
-- PMM
