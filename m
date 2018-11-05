Received: from eggs.gnu.org ([2001:4830:134:3::10]:35885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gJmZK-0005Ln-Oq
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 16:38:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gJmZI-00027D-SO
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 16:37:57 -0500
References: <1539981546-10596-1-git-send-email-Liam.Merwick@oracle.com>
	<1539981546-10596-4-git-send-email-Liam.Merwick@oracle.com>
	<4aeb3510-9ff4-73e0-f371-58b974dce9e4@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <4ff65e73-6af0-2451-7336-597680413edb@oracle.com>
Date: Mon, 5 Nov 2018 21:38:05 +0000
MIME-Version: 1.0
In-Reply-To: <4aeb3510-9ff4-73e0-f371-58b974dce9e4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 3/8] block: Null pointer dereference in
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
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, berrange@redhat.com



On 04/11/18 23:57, Max Reitz wrote:
> On 19.10.18 22:39, Liam Merwick wrote:
>> The dev_id returned by the call to blk_get_attached_dev_id() in
>> blk_root_get_parent_desc() can be NULL (an internal call to
>> object_get_canonical_path may have returned NULL).
>>
>> Instead of just checking this case before before dereferencing,
>> adjust blk_get_attached_dev_id() to return the empty string if no
>> object path can be found (similar to the case when blk->dev is NULL
>> and an empty string is returned).
>>
>> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
>> ---
>>   block/block-backend.c | 6 +++++-
>>   dtc                   | 2 +-
>>   2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/block-backend.c b/block/block-backend.c
>> index dc0cd5772413..e628920f3cd8 100644
>> --- a/block/block-backend.c
>> +++ b/block/block-backend.c
>> @@ -909,6 +909,7 @@ void *blk_get_attached_dev(BlockBackend *blk)
>>   char *blk_get_attached_dev_id(BlockBackend *blk)
>>   {
>>       DeviceState *dev;
>> +    char *dev_id;
>>   
>>       assert(!blk->legacy_dev);
>>       dev = blk->dev;
>> @@ -918,7 +919,10 @@ char *blk_get_attached_dev_id(BlockBackend *blk)
>>       } else if (dev->id) {
>>           return g_strdup(dev->id);
>>       }
>> -    return object_get_canonical_path(OBJECT(dev));
>> +
>> +    dev_id = object_get_canonical_path(OBJECT(dev));
>> +
>> +    return dev_id ? dev_id : g_strdup("");
>>   }
>>   
>>   /*
> 
> Looks good, but since you'll have to respin anyway because of the hunk
> below, you may want to consider
> 
>      return object_get_canonical_path(OBJECT(dev)) ?: g_strdup("");
> 
> instead.  (We have several instances of binary "?:" in the code already,
> so it's fine to use it.  Of course you don't have to, though, if you
> don't like it.)
> 

I like it. Will make that change in v5


>> diff --git a/dtc b/dtc
>> index 88f18909db73..e54388015af1 160000
>> --- a/dtc
>> +++ b/dtc
>> @@ -1 +1 @@
>> -Subproject commit 88f18909db731a627456f26d779445f84e449536
>> +Subproject commit e54388015af1fb4bf04d0bca99caba1074d9cc42
> 
> I don't think this hunk belongs here.


Indeed.

Regards,
Liam
