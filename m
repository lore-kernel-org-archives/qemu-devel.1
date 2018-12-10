Received: from eggs.gnu.org ([2001:4830:134:3::10]:52878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gWRXX-0004iF-RZ
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 14:48:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gWRXW-0001Ux-2i
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 14:48:27 -0500
References: <1544465367-16302-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<34f9335a-1cd8-aa06-1fe7-0f2ab33515d0@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b4aaefb3-89a9-49e1-633f-fcdc629bc9e3@redhat.com>
Date: Mon, 10 Dec 2018 13:48:10 -0600
MIME-Version: 1.0
In-Reply-To: <34f9335a-1cd8-aa06-1fe7-0f2ab33515d0@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5] qemu-img info lists bitmap directory
 entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, Denis Lunev <den@virtuozzo.com>

On 12/10/18 12:50 PM, Vladimir Sementsov-Ogievskiy wrote:
> 10.12.2018 21:09, Andrey Shinkevich wrote:
>> In the 'Format specific information' section of the 'qemu-img info'
>> command output, the supplemental information about existing QCOW2
>> bitmaps will be shown, such as a bitmap name, flags and granularity:
>>
> 
> [...]
> 
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -4270,6 +4270,19 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs)
>>                .refcount_bits      = s->refcount_bits,
>>            };
>>        } else if (s->qcow_version == 3) {
>> +        bool has_bitmaps;
>> +        Qcow2BitmapInfoList *bitmaps;
>> +        Error *local_err = NULL;
>> +
>> +        bitmaps = qcow2_get_bitmap_info_list(bs, &local_err);
>> +        if (local_err) {
>> +            /* TODO: Report the Error up to the caller when implemented */
>> +            error_free(local_err);
>> +            /* The 'bitmaps' empty list designates a failure to get info */
>> +            has_bitmaps = true;

I think you got it backwards.  I would prefer has_bitmaps = false on 
error,...

>> +        } else {
>> +            has_bitmaps = !!bitmaps;

...and an empty list when you successfully determined that there are no 
bitmaps.


>> +++ b/qapi/block-core.json
>> @@ -69,6 +69,11 @@
>>    # @encrypt: details about encryption parameters; only set if image
>>    #           is encrypted (since 2.10)
>>    #
>> +# @bitmaps: list of qcow2 bitmaps details; the empty list designates
>> +#           "fail to load bitmaps" if it is passed to the caller or
>> +#           "no bitmaps" otherwise;
>> +#           unsupported for the format QCOW2 v2 (since 4.0)
> 
> 
> For me, it looks simpler to declare alternative approach, assuming that absence
> of the field means error, like this:
> 
> @bitmaps: optional field with uncommon semantics:
>             Absence of the field means that bitmaps info query failed (which doesn't
>             imply the whole query failure).
>             If the field exists in query results, there were no errors, and it represents
>             list of qcow2 bitmaps details. So, successful result will always use empty
>             list to show that there are no bitmaps.
>             Note: bitmaps are not supported before QCOW2 v3, so for elder versions
>             @bitmaps will always be an empty list.

I'd prefer:

@bitmaps: A list of qcow2 bitmap details (possibly empty, such as for v2
           images which do not support bitmaps).  Absent if bitmap
           information could not be obtained. (since 4.0)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
