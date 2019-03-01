Received: from eggs.gnu.org ([209.51.188.92]:38330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gzoI5-0004Cg-4U
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:57:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gzoI3-0000RP-Vl
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:57:53 -0500
References: <20190301191545.8728-1-jsnow@redhat.com>
	<20190301191545.8728-4-jsnow@redhat.com>
	<66ebf636-43e1-f16a-bd05-e9a8a766d4bd@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <4ee8a7b7-d110-8253-2caa-c8f6ec105bba@redhat.com>
Date: Fri, 1 Mar 2019 14:57:19 -0500
MIME-Version: 1.0
In-Reply-To: <66ebf636-43e1-f16a-bd05-e9a8a766d4bd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/7] block/dirty-bitmaps: add
 block_dirty_bitmap_check function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>



On 3/1/19 2:36 PM, Eric Blake wrote:
> On 3/1/19 1:15 PM, John Snow wrote:
>> Instead of checking against busy, inconsistent, or read only directly,
>> use a check function with permissions bits that let us streamline the
>> checks without reproducing them in many places.
>>
>> Included in this patch are permissions changes that simply add the
>> inconsistent check to existing permissions call spots, without
>> addressing existing bugs.
>>
>> In general, this means that busy+readonly checks become BDRV_BITMAP_DEFAULT,
>> which checks against all three conditions. busy-only checks become
>> BDRV_BITMAP_ALLOW_RO.
>>
>> Notably, remove allows inconsistent bitmaps, so it doesn't follow the pattern.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  include/block/dirty-bitmap.h   | 13 ++++++++-
>>  block/dirty-bitmap.c           | 38 +++++++++++++++++++-------
>>  blockdev.c                     | 49 +++++++---------------------------
>>  migration/block-dirty-bitmap.c | 12 +++------
>>  nbd/server.c                   |  3 +--
>>  5 files changed, 54 insertions(+), 61 deletions(-)
>>
> 
> Diffstat proves its a win, even with the extra documentation for the new
> function. Nice.
> 

It would have been even more obvious if I had added the individual
"inconsistent" checks before conversion, so that it's even close to
breaking even seems like a win.

>> +int bdrv_dirty_bitmap_check(const BdrvDirtyBitmap *bitmap, uint32_t flags,
>> +                            Error **errp)
>> +{
>> +    if ((flags & BDRV_BITMAP_BUSY) && bdrv_dirty_bitmap_busy(bitmap)) {
>> +        error_setg(errp, "Bitmap '%s' is currently in use by another"
>> +                   " operation and cannot be used", bitmap->name);
> 
> Split before space,
> 
>> +        return -1;
>> +    }
>> +
>> +    if ((flags & BDRV_BITMAP_RO) && bdrv_dirty_bitmap_readonly(bitmap)) {
>> +        error_setg(errp, "Bitmap '%s' is readonly and cannot be modified",
>> +                   bitmap->name);
>> +        return -1;
>> +    }
>> +
>> +    if ((flags & BDRV_BITMAP_INCONSISTENT) &&
>> +        bdrv_dirty_bitmap_inconsistent(bitmap)) {
>> +        error_setg(errp, "Bitmap '%s' is inconsistent and cannot be used",
>> +                   bitmap->name);
>> +        error_append_hint(errp, "Try block-dirty-bitmap-remove to delete "
>> +                          "this bitmap from disk");
> 
> split after space.  Looks inconsistent within a single function (pardon
> the pun :)
> 

Ah... I've never known how to split strings. In fact, does anyone?
I'll address this either in staging or as a follow-up, as I assume
Vladimir will have some comments for me.

--js

> That's minor,
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 

Thanks!
