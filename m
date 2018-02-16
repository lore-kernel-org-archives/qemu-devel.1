Received: from eggs.gnu.org ([2001:4830:134:3::10]:33476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1emgSS-0001C7-He
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:53:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1emgSO-0001J4-DI
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:53:48 -0500
Received: from mail-db5eur01on0122.outbound.protection.outlook.com
	([104.47.2.122]:64224
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1emgSN-0001IE-JV
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:53:44 -0500
References: <20161214150840.10899-1-alex@alex.org.uk>
	<c2faa919-65c6-d5a3-508d-2f069f2ba61e@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <1e3244d2-daea-6f3f-f852-642bdf216e17@virtuozzo.com>
Date: Fri, 16 Feb 2018 16:53:35 +0300
MIME-Version: 1.0
In-Reply-To: <c2faa919-65c6-d5a3-508d-2f069f2ba61e@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Nbd] [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Alex Bligh <alex@alex.org.uk>, Wouter Verheist <w@uter.be>, nbd list <nbd@other.debian.org>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Pavel Borzenkov <pborzenkov@virtuozzo.com>, stefanha@redhat.com, "Denis V . Lunev" <den@openvz.org>, Markus Pargmann <mpa@pengutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

16.02.2018 15:35, Eric Blake wrote:
> Reviving an old thread, to bring up questions based on a new push to 
> implement this extension in qemu.
>
> On 12/14/2016 09:08 AM, Alex Bligh wrote:
>>
>> * Change NBD_OPT_LIST_METADATA etc. to explicitly send a list of queries
>>    and add a count of queries so we can extend the command later 
>> (rather than
>>    rely on the length of option)
>>
>> * For NBD_OPT_LIST_METADATA make absence of any query (as opposed to 
>> zero
>>    length query) list all contexts, as absence of any query is now 
>> simple.
>>
>> * Move definition of namespaces in the document to somewhere more 
>> appopriate.
>>
>> * Various other minor changes as discussed on the mailing list
>>
>> Signed-off-by: Alex Bligh <alex@alex.org.uk>
>> ---
>>   doc/proto.md | 179 
>> +++++++++++++++++++++++++++++++++++++----------------------
>>   1 file changed, 112 insertions(+), 67 deletions(-)
>>
>
>>   +Metadata contexts are identified by their names. The name MUST
>> +consist of a namespace, followed by a colon, followed by a leaf-name.
>> +The namespace and the leaf-name must each consist entirely of
>> +printable non-whitespace UTF-8 characters other than colons,
>> +and be non-empty. The entire name (namespace, colon and leaf-name)
>> +MUST NOT exceed 255 bytes (and therefore botht he namespace and
>> +leaf-name are guaranteed to be smaller than 255 bytes).
>> +
>> +Namespaces MUST be consist of one of the following:
>> +- `base`, for metadata contexts defined by this document;
>> +- `nbd-server`, for metadata contexts defined by the
>> +   implementation that accompanies this document (none
>> +   currently);
>> +- `x-*`, where `*` can be replaced by any random string not
>
> We're inconsistent on whether extensions are 'x-' or 'X-'; we should 
> tighten that up.  (No real impact to implementing things - a server 
> should just ignore namespaces it doesn't recognize, regardless of how 
> that unknown namespace was spelled).

personally I'm for x- like in qmp, it's just nicer . However I'm sure, 
regardless of the choice, people will avoid both variant fora production 
names)


>
>> +   containing colons, for local experiments. This SHOULD NOT be
>> +   used by metadata contexts that are expected to be widely used.
>> +- A third-party namespace from the list below.
>
>> @@ -932,51 +961,58 @@ of the newstyle negotiation.
>> +    If zero queries are sent, then the server MUST return all
>> +    the metadata contexts it knows about.
>> +
>> +    For details on the query string, see under 
>> `NBD_OPT_SET_META_CONTEXT`.
>> +
>> +    The server MUST either reply with an error (for instance `EINVAL`
>> +    if the option is not supported), or reply with a list of
>> +    `NBD_REP_META_CONTEXT` replies followed by `NBD_REP_ACK`.
>> +    The metadata context ID in these replies is reserved and SHOULD be
>> +    set to zero; clients MUST disregard it.
>
> The question came up whether the server is required/permitted to 
> diagnose bogus queries (a query for "bad" has no colon, and therefore 
> cannot represent any namespace - is that required to be an error, or 
> can the server silently ignore it and process the rest of the 
> requests?  Can the client rely on the server diagnosing bad requests, 
> or must it be prepared for the server to just ignore bad requests?).

What do you mean by 'ignore'? Replying with empty list (if only one 
invalid query)? Hmm. I'm ok with either way.


>
> Here's my thinking:
>
> A server implementation may want to vet only the first 5 characters of 
> a request (because it only supports the namespace "base:").  If that 
> server encounters a client asks for context "X-longname:", that is a 
> valid request (so we should NOT reply with an error, but merely ignore 
> it as an unknown namespace); but if a client asks for namespace 
> "garbage", we have the option of whether to return an error.  But for 
> both of those client requests, there was no colon in the first 5 
> characters.  For a server to robustly distinguish between the two, we 
> have to read the entire request and search for a colon, to decide 
> whether the missing colon warrants an error reply.  But a client can 
> request a name up to 4k in length (the NBD maximum string) - so taking 
> the argument to an extreme, we have to manage a 4k string before 
> making our decision.  Reading 5 bytes fits easily into the stack, but 
> reading 4k bytes onto the stack risks skipping the guard page on an OS 
> with 4k page sizes, for less-than-stellar handling on stack overflow; 
> and reading one byte at a time to check for colon is a pain compared 
> to just deciding after 5 bytes that the rest of the string is 
> irrelevant and skipping ahead in the data stream to the next point 
> where any useful work might be performed.  Thus, I'm arguing that for 
> ease of server implementation, we should permit, but not require, the 
> server to diagnose ill-formed requests that do not begin with 
> namespace-colon; but that we MUST require that the server ignores 
> unknown but well-formed requests rather than treating them as errors.

Completely agree.


>
> But there is another alternative as well - instead of returning a 
> two-part string where colon is the separator, and where the server 
> must parse to locate the colon (or lack thereof), would it make sense 
> to instead change the NBD_OPT_{LIST,SET}_META_CONTEXT and 
> NBD_REP_META_CONTEXT field layout to have two separate length/strings 
> per context (first is length/string for namespace, second is 
> length/string for leaf name), where colon is no longer special (it is 
> no longer possible for a client to pass an ill-formed request that 
> lacks colon), and where the server can immediately tell that 
> 'namespace_length != 5, therefore this is a request for a namespace I 
> don't care about'?

Good idea. But it would be tricky thing to maintain backward 
compatibility with published versions of virtuozzo product. And finally 
our implementation would be more complex because of this simplification.


>
>
>> -    These two fields MAY be repeated as much as is necessary to 
>> select all
>> -    metadata contexts the client is interested in.
>> +    - 32 bits, length of export name.
>> +    - String, name of export for which we wish to list metadata
>> +      contexts.
>> +    - 32 bits, number of queries
>> +    - Zero or more queries, each being:
>> +       - 32 bits, length of query
>> +       - String, query to select metadata contexts. The syntax of this
>> +         query is implementation-defined, except that it MUST start 
>> with a
>> +         namespace and a colon.
>> +
>
> Also, is 32 bits as the length of the query really necessary? Given 
> that NBD strings are capped at 4k, a 16-bit length is sufficient.  
> It's not like we have padding to get things to natural alignments (if 
> it were a matter of always sending 32-bit or 64-bit quantities on 
> natural alignments, we'd have padding in a lot more places).
>

Hm. Finally, you suggested several changes (including already merged 
56c77720 :( ). Suggestions are logical. But if they will be accepted, we 
(Virtuozzo) will have to invent tricky hard-to-maintain code, to 
distinguish by third factors our already published versions. So, I 
suggest to add some negotiation flag (BLOCK_STATUS_FIXED ?), to 
negotiate your changes (including 56c77720). In upstream we can skip 
supporting BLOCK_STATUS without that special flag, but it will help us 
to distinguish our previous versions reliably.

-- 
Best regards,
Vladimir
