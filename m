Received: from eggs.gnu.org ([2001:4830:134:3::10]:48846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cH8b2-0002iG-FL
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 07:23:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cH8az-0004GJ-8b
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 07:23:44 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:46352 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cH8ay-0004FW-Tj
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 07:23:41 -0500
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
	<1479835586-74394-8-git-send-email-vsementsov@virtuozzo.com>
	<b80f7704-75c4-6390-aacf-d3af1e7853c7@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <eb802f93-aeb6-9ec2-651a-f41a4d4902ff@virtuozzo.com>
Date: Wed, 14 Dec 2016 15:23:22 +0300
MIME-Version: 1.0
In-Reply-To: <b80f7704-75c4-6390-aacf-d3af1e7853c7@redhat.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/21] qcow2: add bitmaps extension
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

07.12.2016 21:25, Max Reitz wrote:
> On 22.11.2016 18:26, Vladimir Sementsov-Ogievskiy wrote:
>> Add bitmap extension as specified in docs/specs/qcow2.txt.
>> For now, just mirror extension header into Qcow2 state and check
>> constraints.
>>
>> For now, disable image resize if it has bitmaps. It will be fixed later.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>> ---
>>   block/qcow2.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>>   block/qcow2.h |  24 +++++++++++++
>>   2 files changed, 129 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 6d5689a..7908657 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -63,6 +63,7 @@ typedef struct {
>>   #define  QCOW2_EXT_MAGIC_END 0
>>   #define  QCOW2_EXT_MAGIC_BACKING_FORMAT 0xE2792ACA
>>   #define  QCOW2_EXT_MAGIC_FEATURE_TABLE 0x6803f857
>> +#define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
>>   
>>   static int qcow2_probe(const uint8_t *buf, int buf_size, const char *filename)
>>   {
>> @@ -92,6 +93,7 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
>>       QCowExtension ext;
>>       uint64_t offset;
>>       int ret;
>> +    Qcow2BitmapHeaderExt bitmaps_ext;
>>   
>>   #ifdef DEBUG_EXT
>>       printf("qcow2_read_extensions: start=%ld end=%ld\n", start_offset, end_offset);
>> @@ -162,6 +164,81 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
>>               }
>>               break;
>>   
>> +        case QCOW2_EXT_MAGIC_BITMAPS:
>> +            if (ext.len != sizeof(bitmaps_ext)) {
>> +                error_setg_errno(errp, -ret, "bitmaps_ext: "
>> +                                 "Invalid extension length");
>> +                return -EINVAL;
>> +            }
>> +
>> +            if (!(s->autoclear_features & QCOW2_AUTOCLEAR_BITMAPS)) {
>> +                fprintf(stderr,
>> +                        "WARNING: a program lacking bitmap support modified "
>> +                        "this file, so all bitmaps are now considered "
>> +                        "inconsistent");
>> +                break;
>> +            }
> I think It would be nice if qemu-img check could remove all bitmaps and
> related data if this bit is not set. Otherwise, we're practically
> leaking data.

Is it safe? Can old version somehow reuse these clusters? Actually, all 
data will be removed on check, as there will be no refcounts if this bit 
is not set.

So, IMHO, only extension header should be deleted additionally in 
qemu-img check.

>
> (But this can be added in a later patch.)
>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
>


-- 
Best regards,
Vladimir
