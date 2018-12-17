Received: from eggs.gnu.org ([2001:4830:134:3::10]:35931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYuvZ-0003JQ-B2
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:35:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYuvY-0005cb-CV
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:35:29 -0500
References: <20181215135324.152629-1-eblake@redhat.com>
	<20181215135324.152629-14-eblake@redhat.com>
	<20181215152249.GZ27120@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8b75cf75-ddec-527d-d7ff-8be4af246e61@redhat.com>
Date: Mon, 17 Dec 2018 09:34:56 -0600
MIME-Version: 1.0
In-Reply-To: <20181215152249.GZ27120@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 13/22] nbd/client: Split out
 nbd_send_one_meta_context()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-devel@nongnu.org, nsoffer@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

On 12/15/18 9:22 AM, Richard W.M. Jones wrote:
> On Sat, Dec 15, 2018 at 07:53:15AM -0600, Eric Blake wrote:
>> Refactor nbd_negotiate_simple_meta_context() to pull out the
>> code that can be reused to send a LIST request for 0 or 1 query.
>> No semantic change.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> ---
>> v2: split patch into easier-to-review pieces [Rich, Vladimir]
>> ---
>>   nbd/client.c     | 64 ++++++++++++++++++++++++++++++++++--------------
>>   nbd/trace-events |  2 +-
>>   2 files changed, 46 insertions(+), 20 deletions(-)

>> +    uint32_t queries = !!query;

This initialization...


>> +    uint32_t context_len = 0;
>> +    uint32_t data_len;
>> +    char *data;
>> +    char *p;
>> +
>> +    data_len = sizeof(export_len) + export_len + sizeof(queries);

...plus the fact that it is now sizeof(variable) instead of sizeof(type)...

>> @@ -651,26 +693,10 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
>>       NBDOptionReply reply;
>>       const char *context = info->x_dirty_bitmap ?: "base:allocation";
>>       bool received = false;
>> -    uint32_t export_len = strlen(info->name);
>> -    uint32_t context_len = strlen(context);
>> -    uint32_t data_len = sizeof(export_len) + export_len +
>> -                        sizeof(uint32_t) + /* number of queries */

...was the reason that I dropped the comment here.  The comment made 
sense for explaining why a sizeof(type) was being injected into data_len,

>> -                        sizeof(context_len) + context_len;
>> -    char *data = g_malloc(data_len);
>> -    char *p = data;
>>
>> -    trace_nbd_opt_meta_request(context, info->name);
>> -    stl_be_p(p, export_len);
>> -    memcpy(p += sizeof(export_len), info->name, export_len);
>> -    stl_be_p(p += export_len, 1);

...because the old code was hard-coding 1 query, while the new code uses 
the variable (whose value is the number of queries) rather than a 
hard-coding.


> 
> Although a straightforward refactoring, we still lost the comment
> /* number of queries */.  I'd still perhaps like to see a bit more
> explanation of the layout and reasoning behind the data buffer.

Perhaps a possible improvement would be to introduce a packed struct 
that matches the protocol layout, instead of piece-meal constructing the 
struct.  But I'm not sure how much effort to spend on this code.

> But anyway ..
> 
> Reviewed-by: Richard W.M. Jones <rjones@redhat.com>

Thanks. I'm glad you forced me to split the v1 patch into more 
manageable pieces; I like how it turned out.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
