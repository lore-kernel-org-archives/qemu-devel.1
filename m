Received: from eggs.gnu.org ([2001:4830:134:3::10]:53119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gDbTo-0005be-4w
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gDbTk-0001aW-TU
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:34:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gDbTi-0001N1-Ov
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:34:38 -0400
References: <1535739372-24454-1-git-send-email-Liam.Merwick@oracle.com>
	<1535739372-24454-7-git-send-email-Liam.Merwick@oracle.com>
	<a4732da2-c0d2-c6d9-fac4-1969758b1ff9@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <07eb9a63-0247-ba8d-6528-d7e15293b48e@oracle.com>
Date: Fri, 19 Oct 2018 21:34:56 +0100
MIME-Version: 1.0
In-Reply-To: <a4732da2-c0d2-c6d9-fac4-1969758b1ff9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 6/8] block: dump_qlist() may dereference
 a Null pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org



On 12/10/18 16:22, Max Reitz wrote:
> On 31.08.18 20:16, Liam Merwick wrote:
>> A NULL 'list' passed into function dump_qlist() isn't correctly
>> validated and can be passed to qlist_first() where it is dereferenced.
>>
>> Given that dump_qlist() is static, and callers already do the right
>> thing, just add an assert to catch future potential bugs.
>>
>> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>>   block/qapi.c | 2 ++
>>   1 file changed, 2 insertions(+)
> 
> I don't disagree, but I don't see why the program just wouldn't crash if
> someone passed a NULL pointer.  And I don't quite see why anyone would
> pass a NULL pointer.
> 
> Of course it's reasonable to just add an assert() to reinforce the
> contract; but we have so many functions that just take a pointer that
> they assume to be non-NULL and then immediately dereference it.  Nearly
> every blk_* function takes a BlockBackend that is always assumed to be
> non-NULL, for instance, and I don't really want to put assert()s into
> all of them.  Or another example: dump_qobject() and dump_qdict() do
> exactly the same -- if we added an assertion in dump_qlist(), we would
> actually have to add the very same assertions there, too.
> 
> So I don't really object this patch (because it's not wrong), but I
> don't think it's very useful.


I agree with all the above - however I kept the patch in the series 
given it was helping reduce the static analysis noise (hopefully making 
it easier to spot real issues)

Regards,
Liam


> 
> Max
> 
>> diff --git a/block/qapi.c b/block/qapi.c
>> index c66f949db839..e81be604217c 100644
>> --- a/block/qapi.c
>> +++ b/block/qapi.c
>> @@ -740,6 +740,8 @@ static void dump_qlist(fprintf_function func_fprintf, void *f, int indentation,
>>       const QListEntry *entry;
>>       int i = 0;
>>   
>> +    assert(list);
>> +
>>       for (entry = qlist_first(list); entry; entry = qlist_next(entry), i++) {
>>           QType type = qobject_type(entry->value);
>>           bool composite = (type == QTYPE_QDICT || type == QTYPE_QLIST);
>>
> 
> 
