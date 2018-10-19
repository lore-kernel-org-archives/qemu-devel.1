Received: from eggs.gnu.org ([2001:4830:134:3::10]:51949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gDbQZ-0002jN-ME
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gDbQY-0004Fe-RF
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:31:23 -0400
From: Liam Merwick <liam.merwick@oracle.com>
References: <1535739372-24454-1-git-send-email-Liam.Merwick@oracle.com>
	<1535739372-24454-4-git-send-email-Liam.Merwick@oracle.com>
	<ed7db5e9-142d-7ab9-0b3a-969490b0099a@redhat.com>
Message-ID: <04cebbe1-e088-b90f-649c-0eb184a5b228@oracle.com>
Date: Fri, 19 Oct 2018 21:31:33 +0100
MIME-Version: 1.0
In-Reply-To: <ed7db5e9-142d-7ab9-0b3a-969490b0099a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/8] block: Null pointer dereference in
 blk_root_get_parent_desc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org



On 12/10/18 15:48, Max Reitz wrote:
> Hi,
> 
> On 31.08.18 20:16, Liam Merwick wrote:
>> The dev_id returned by the call to blk_get_attached_dev_id() in
>> blk_root_get_parent_desc() can be NULL (an internal call to
>> object_get_canonical_path may have returned NULL) so it should
>> be checked before dereferencing.
>>
>> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
>> Reviewed-by: Darren Kenny <Darren.Kenny@oracle.com>
>> Reviewed-by: Mark Kanda <Mark.Kanda@oracle.com>
>> ---
>>   block/block-backend.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/block-backend.c b/block/block-backend.c
>> index fa120630be83..210eee75006a 100644
>> --- a/block/block-backend.c
>> +++ b/block/block-backend.c
>> @@ -136,7 +136,7 @@ static char *blk_root_get_parent_desc(BdrvChild *child)
>>       }
>>   
>>       dev_id = blk_get_attached_dev_id(blk);
>> -    if (*dev_id) {
>> +    if (dev_id && *dev_id) {
>>           return dev_id;
> 
> I rather think that blk_get_attached_dev_id() needs attention first.  It
> returns an explicitly empty string if blk->dev is NULL.  If NULL was a
> valid return value, it should just return NULL there.
> 
> Besides this caller, there are two callers that pass the dev_id to
> qapi_event_send_device_tray_moved().  Now in practice that allows the
> string to be NULL, but there is a comment in visit_type_str() that says
> one should not pass NULL.
> 
> So it's either changing blk_get_attached_dev_id() to return NULL when
> there is no valid ID (instead of the empty string, and then we could
> save ourselves the check "*dev_id" here and elsewhere), but then we have
> to fix all callers.
> 
> Or we make it return an empty string if object_get_canonical_path()
> returned NULL.
> 

I went with the latter and now (in upcoming v4) check the return value 
from object_get_canonical_path() and return an empty string if it's NULL.

Regards,
Liam


> Max
> 
>>       } else {
>>           /* TODO Callback into the BB owner for something more detailed */
>>
> 
> 
