Received: from eggs.gnu.org ([2001:4830:134:3::10]:33362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYunF-0007LO-Kv
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:26:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYunE-0006XG-Lk
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:26:53 -0500
References: <20181215135324.152629-1-eblake@redhat.com>
	<20181215135324.152629-13-eblake@redhat.com>
	<20181215151929.GY27120@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9b3c7c13-93cf-55e1-d512-7ed73b008720@redhat.com>
Date: Mon, 17 Dec 2018 09:26:41 -0600
MIME-Version: 1.0
In-Reply-To: <20181215151929.GY27120@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 12/22] nbd/client: Improve error
 handling in nbd_negotiate_simple_meta_context()
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

On 12/15/18 9:19 AM, Richard W.M. Jones wrote:
> On Sat, Dec 15, 2018 at 07:53:14AM -0600, Eric Blake wrote:
>> Always allocate space for the reply returned by the server and
>> hoist the trace earlier, as it is more interesting to trace the
>> server's reply (even if it is unexpected) than parroting our
>> request only on success.  After all, skipping the allocation
>> for a wrong size was merely a micro-optimization that only
>> benefitted a broken server, rather than the common case of a
>> compliant server that meets our expectations.
>>
>> Then turn the reply handling into a loop (even though we still
>> never iterate more than once), to make this code easier to use
>> when later patches do support multiple server replies.  This
>> changes the error message for a server with two replies (a
>> corner case we are unlikely to hit in practice) from:
>>
>> Unexpected reply type 4 (meta context), expected 0 (ack)
>>
>> to:
>>
>> Server replied with more than one context
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> ---
>> v2: split patch into easier-to-review pieces [Rich, Vladimir]
>> ---
>>   nbd/client.c | 16 ++++++++++++----
>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/nbd/client.c b/nbd/client.c
>> index bcccd5f555e..b6a85fc3ef8 100644
>> --- a/nbd/client.c
>> +++ b/nbd/client.c
>> @@ -684,10 +684,11 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
>>           return ret;
>>       }
>>
>> -    if (reply.type == NBD_REP_META_CONTEXT) {
>> +    while (reply.type == NBD_REP_META_CONTEXT) {
> 
> I'm not sure I understand why this change is safe.
> 
> As far as I can see reply.type is only updated in the loop by
> nbd_receive_option_reply, and that reads from the server, and so the
> server might keep sending NBD_REP_META_CONTEXT packets (instead of the
> expected NBD_REP_ACK), so it could now loop forever against a
> malicious server?  (This is not taking into account any later patches)

The loop can execute at most twice:

> 
> Rich.
> 
>>           char *name;
>>
>> -        if (reply.length != sizeof(info->context_id) + context_len) {
>> +        if (reply.length <= sizeof(info->context_id) ||
>> +            reply.length > NBD_MAX_BUFFER_SIZE) {
>>               error_setg(errp, "Failed to negotiate meta context '%s', server "
>>                          "answered with unexpected length %" PRIu32, context,
>>                          reply.length);
>> @@ -708,6 +709,15 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
>>               return -1;
>>           }
>>           name[reply.length] = '\0';
>> +        trace_nbd_opt_meta_reply(name, info->context_id);
>> +
>> +        if (received) {
>> +            error_setg(errp, "Server replied with more than one context");
>> +            g_free(name);
>> +            nbd_send_opt_abort(ioc);
>> +            return -1;
>> +        }

If the server replies with a second context, we break the loop by 
complaining.

The old code accepted at most one context, by complaining if the 
server's second reply was not ACK; the new code accepts at most one 
context, by complaining if the server sent more than one context, so the 
net effect of killing the connection for a misbehaving server response 
to SET is unchanged.

However, your point about a misbehaving server providing an infinite 
stream of responses to NBD_OPT_LIST or NBD_OPT_LIST_META_CONTEXT is an 
interesting question, and may be worth asking upstream to see if the NBD 
protocol should be tweaked to document any boundaries at how many 
listings a server might send before a client should worry about the 
server being malicious.  (Does not affect this patch, but pre-existing 
when we call nbd_receive_list() for servers that lack NBD_OPT_GO, and 
does impact the later patches in this series that call 
NBD_OPT_LIST_META_CONTEXT for 'qemu-nbd --list').

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
