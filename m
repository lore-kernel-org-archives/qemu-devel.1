Received: from eggs.gnu.org ([2001:4830:134:3::10]:38816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cIwX3-0006wd-G9
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 06:55:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cIwWy-0007UO-NU
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 06:55:05 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:11569 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cIwWy-0007Tz-A2
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 06:55:00 -0500
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
	<1479835586-74394-10-git-send-email-vsementsov@virtuozzo.com>
	<2e03e805-9226-fdc7-7069-814c1346edd2@redhat.com>
	<81adfcb0-77cf-2370-6aca-0b9bcfe5ca0a@virtuozzo.com>
	<3e6a1526-d0ea-8d15-505b-07101e777da0@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <8d98327f-c8f4-361b-b10b-c5a5ac6e2424@virtuozzo.com>
Date: Mon, 19 Dec 2016 14:54:37 +0300
MIME-Version: 1.0
In-Reply-To: <3e6a1526-d0ea-8d15-505b-07101e777da0@redhat.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/21] qcow2: add
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

16.12.2016 17:37, Max Reitz wrote:
> On 14.12.2016 16:54, Vladimir Sementsov-Ogievskiy wrote:
>> 07.12.2016 23:51, Max Reitz wrote:
>>> On 22.11.2016 18:26, Vladimir Sementsov-Ogievskiy wrote:
>>>> Auto loading bitmaps are bitmaps in Qcow2, with the AUTO flag set. They
>>>> are loaded when the image is opened and become BdrvDirtyBitmaps for the
>>>> corresponding drive.
>>>>
>>>> Extra data in bitmaps is not supported for now.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>>    block/Makefile.objs  |   2 +-
>>>>    block/qcow2-bitmap.c | 663
>>>> +++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>    block/qcow2.c        |   2 +
>>>>    block/qcow2.h        |   3 +
>>>>    4 files changed, 669 insertions(+), 1 deletion(-)
>>>>    create mode 100644 block/qcow2-bitmap.c
>>>>
>>> [...]
>>>
>>>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>>>> new file mode 100644
>>>> index 0000000..0f797e6
>>>> --- /dev/null
>>>> +++ b/block/qcow2-bitmap.c
>>>> @@ -0,0 +1,663 @@
>>> [...]
>>>
>>>> +/* Check table entry specification constraints. If cluster_size is
>>>> 0, offset
>>>> + * alignment is not checked. */
>>>> +static int check_table_entry(uint64_t entry, int cluster_size)
>>>> +{
>>>> +    uint64_t offset;
>>>> +
>>>> +    if (entry & BME_TABLE_ENTRY_RESERVED_MASK) {
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    offset = entry & BME_TABLE_ENTRY_OFFSET_MASK;
>>>> +    if (offset != 0) {
>>>> +        /* if offset specified, bit 0 must is reserved */
>>> -must
>>>
>>>> +        if (entry & 1) {
>>>> +            return -EINVAL;
>>>> +        }
>>>> +
>>>> +        if ((cluster_size != 0) && (entry % cluster_size != 0)) {
>>> Why would cluster_size be 0? Also, shouldn't it be offset instead of
>>> entry?
>> the comment says: "If cluster_size is 0, offset alignment is not checked"
> Oops, right. Is there any place where this function is called with
> cluster_size being 0, though?

Hmm, I can't find it. Will remove this extra feature.

[...]


-- 
Best regards,
Vladimir
