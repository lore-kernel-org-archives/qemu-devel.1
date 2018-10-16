Received: from eggs.gnu.org ([2001:4830:134:3::10]:34402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCOPm-000164-M3
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCOPj-0000y0-PV
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:25:34 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:40883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gCOPj-0000uq-8v
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:25:31 -0400
Received: by mail-ot1-x329.google.com with SMTP id w67so22289872ota.7
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 05:25:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <17713fbc-6311-87b4-d3d4-6a72cadd6b41@redhat.com>
References: <20180313211441.5179-1-jsnow@redhat.com>
	<20180313211441.5179-12-jsnow@redhat.com>
	<CAFEAcA8K9eV=GSrvLsz+XmxsD0g1MrZ+MRFbPHYVR6zR7hucQg@mail.gmail.com>
	<CAFEAcA9hNc1_f7qrJV41pP_WKAb7Zfn9riQyZGBJnanTLd3vnw@mail.gmail.com>
	<17713fbc-6311-87b4-d3d4-6a72cadd6b41@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 13:25:07 +0100
Message-ID: <CAFEAcA-uE5PKdC4dTi9CCscUrkvAs82uk60Kfp6btqgWSDf+TQ@mail.gmail.com>
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

On 20 June 2018 at 17:58, John Snow <jsnow@redhat.com> wrote:
>
>
> On 06/20/2018 12:43 PM, Peter Maydell wrote:
>> On 27 April 2018 at 14:22, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> On 13 March 2018 at 21:14, John Snow <jsnow@redhat.com> wrote:
>>>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>>
>>>> Postcopy migration of dirty bitmaps. Only named dirty bitmaps are migrated.
>>>>
>>>> If destination qemu is already containing a dirty bitmap with the same name
>>>> as a migrated bitmap (for the same node), then, if their granularities are
>>>> the same the migration will be done, otherwise the error will be generated.
>>>>
>>>> If destination qemu doesn't contain such bitmap it will be created.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>>> Message-id: 20180313180320.339796-12-vsementsov@virtuozzo.com
>>>> [Changed '+' to '*' as per list discussion. --js]
>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>
>>>> +static int init_dirty_bitmap_migration(void)
>>>> +{
>>>
>>> Hi; Coverity (CID1390625) complains about a possible dereference
>>> after NULL check in this function:
>>>
>>>> +    BlockDriverState *bs;
>>>> +    BdrvDirtyBitmap *bitmap;
>>>> +    DirtyBitmapMigBitmapState *dbms;
>>>> +    BdrvNextIterator it;
>>>> +
>>>> +    dirty_bitmap_mig_state.bulk_completed = false;
>>>> +    dirty_bitmap_mig_state.prev_bs = NULL;
>>>> +    dirty_bitmap_mig_state.prev_bitmap = NULL;
>>>> +    dirty_bitmap_mig_state.no_bitmaps = false;
>>>> +
>>>> +    for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
>>>> +        const char *drive_name = bdrv_get_device_or_node_name(bs);
>>>> +
>>>> +        /* skip automatically inserted nodes */
>>>> +        while (bs && bs->drv && bs->implicit) {
>>>> +            bs = backing_bs(bs);
>>>> +        }
>>>
>>> The 'bs' test in this while() loop implies that we might
>>> leave the loop because bs == NULL...
>>>
>>>> +
>>>> +        for (bitmap = bdrv_dirty_bitmap_next(bs, NULL); bitmap;
>>>
>>> ...but this call to bdrv_dirty_bitmap_next() will always
>>> dereference bs, so if it's NULL we'll crash.
>>>
>>>> +             bitmap = bdrv_dirty_bitmap_next(bs, bitmap))
>>
>> Hi -- just a nudge that Coverity thinks this one is still unfixed.

> Thank you for the reminder, I've been a bit scatter-brained recently.

Ping? This is still in Coverity's list of unfixed issues.

thanks
-- PMM
