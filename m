Received: from eggs.gnu.org ([2001:4830:134:3::10]:35936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gJmZX-0005hu-0G
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 16:38:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gJmZR-0002ES-3C
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 16:38:07 -0500
References: <1539981546-10596-1-git-send-email-Liam.Merwick@oracle.com>
	<1539981546-10596-7-git-send-email-Liam.Merwick@oracle.com>
	<3037dd84-e7b9-b786-4594-107ae737af2c@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <858844d0-9e9d-d25f-b105-d8ddf2a58ab7@oracle.com>
Date: Mon, 5 Nov 2018 21:38:20 +0000
MIME-Version: 1.0
In-Reply-To: <3037dd84-e7b9-b786-4594-107ae737af2c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 6/8] block: dump_qlist() may dereference
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
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, berrange@redhat.com



On 05/11/18 00:07, Max Reitz wrote:
> On 19.10.18 22:39, Liam Merwick wrote:
>> A NULL 'list' passed into function dump_qlist() isn't correctly
>> validated and can be passed to qlist_first() where it is dereferenced.
>>
>> Given that dump_qlist() is static, and callers already do the right
>> thing, just add an assert to catch future potential bugs (plus the
>> added benefit of suppressing a warning from a static analysis tool
>> and removing this noise will help us better find real issues).
> 
> But can't you fix the tool? 

I don't have access to the tool source but have been filing bugs against 
it as I run it on the QEMU codebase and discover false positives.

> My opinion is still that large parts of our
> code do not assert that some parameter is not NULL, and I think it isn't
> a good idea to make them assert that.  

Yeah, that can be a slippery slope....

> I don't know what makes this
> function special, and I wonder why it is special to your tool -- as I've
> said in the last version, dump_qdict() is basically the same in this
> regard.  I wonder why your tool doesn't mind that.
> 

I had gone though the code paths to try to see how the tool was happy 
with one and not the other - the implementation differed slightly w.r.t 
macro usage but I couldn't see any obvious reason.

> Can you not whitelist something as false positives?  I know we have a
> lot of those in Coverity, and we just mark them as such, and that's it.

Yeah, I can flag this as a FP and have it fall off my list.

I'll will drop this patch in v5

Regards,
Liam

> 
> Finally, one could argue that the nonnull GCC function attribute would
> be a better fit, actually.
> 
> But overall, I just don't think it's a good idea to start changing the
> code to accommodate for false positives in static analyzers, because in
> my experience the number of false positives only rises with time.
> 
> Max
> 
>> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>>   block/qapi.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
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
