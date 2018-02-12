Received: from eggs.gnu.org ([2001:4830:134:3::10]:36168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1elGps-0005yF-0w
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:20:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1elGpr-0005p4-0z
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:20:08 -0500
References: <1516366207-109842-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516366207-109842-8-git-send-email-anton.nefedov@virtuozzo.com>
	<w51y3k4u97c.fsf@maestria.local.igalia.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <4f824a36-5d4f-267d-2bcb-04e118117abe@virtuozzo.com>
Date: Mon, 12 Feb 2018 19:19:57 +0300
MIME-Version: 1.0
In-Reply-To: <w51y3k4u97c.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 7/8] file-posix: account
 discard operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@virtuozzo.com, qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com, pbonzini@redhat.com



On 7/2/2018 6:10 PM, Alberto Garcia wrote:
> On Fri 19 Jan 2018 01:50:06 PM CET, Anton Nefedov wrote:
>> This will help to identify how many of the user-issued discard operations
>> (accounted on a device level) have actually suceeded down on the host file
>> (even though the numbers will not be exactly the same if non-raw format
>> driver is used (e.g. qcow2 sending metadata discards)).
>>
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/file-posix.c | 21 +++++++++++++++++++--
>>   1 file changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/file-posix.c b/block/file-posix.c
>> index 36ee89e..544ae58 100644
>> --- a/block/file-posix.c
>> +++ b/block/file-posix.c
>> @@ -158,6 +158,11 @@ typedef struct BDRVRawState {
>>       bool page_cache_inconsistent:1;
>>       bool has_fallocate;
>>       bool needs_alignment;
>> +    struct {
>> +        int64_t discard_nb_ok;
>> +        int64_t discard_nb_failed;
>> +        int64_t discard_bytes_ok;
>> +    } stats;
> 
> Shouldn't this new structure be defined in a header file so other
> drivers can use it? Or did you define it here because you don't see that
> happening soon?
> 

I guess there's no reason to burden the common header files as long as
it's not really used anywhere else.
