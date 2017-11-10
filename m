Received: from eggs.gnu.org ([2001:4830:134:3::10]:39298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eDCWw-0003so-Nc
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 11:51:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eDCWt-0006er-KU
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 11:51:46 -0500
Received: from mail-he1eur01on0102.outbound.protection.outlook.com
	([104.47.0.102]:54725
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1eDCWs-0006bW-TA
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 11:51:43 -0500
References: <37193dd7-a0fc-bfa6-3870-ecbcfefac4e5@virtuozzo.com>
	<bf31a83e-7cd6-4f26-595b-3b1a2def883f@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <608ba1f1-38b3-7312-e27b-8a62b197d53e@virtuozzo.com>
Date: Fri, 10 Nov 2017 19:51:35 +0300
MIME-Version: 1.0
In-Reply-To: <bf31a83e-7cd6-4f26-595b-3b1a2def883f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] NBD BLOCK_STATUS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Wouter Verhelst <w@uter.be>, Alex Bligh <alex@alex.org.uk>, nbd list <nbd@other.debian.org>, qemu-devel <qemu-devel@nongnu.org>

10.11.2017 19:06, Eric Blake wrote:
> On 11/09/2017 06:42 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Hi!
>>
>> Interesting fact: list/set_meta_context options are per-export,
>> so, in the server we should keep context selection per client per export.
>>
>> And it is possible for client to set contexts for one export and than
>> proceed
>> to transmission phase with another one.
> However, we also documented in the spec that
>
> +    A client MUST NOT send `NBD_CMD_BLOCK_STATUS` unless
> +    within the negotiation phase it sent `NBD_OPT_SET_META_CONTEXT`
> +    at least once, and the final time it was sent, it referred
> +    to the export name that was ultimately selected, the server
> +    responded without an error, and returned at least one metadata
> +    context.

I've missed this, then it's OK.

maybe "ultimately selected for transmission phase" would be a bit better.

>
> My take on this is if the client calls:
>
> NBD_OPT_SET_META_CONTEXT (export name "foo")
> NBD_OPT_GO (export name "bar")
>
> then the server has no contexts to remember, and the client must not
> call NBD_CMD_BLOCK_STATUS.  That is, a server is free to track only a
> SINGLE list of context ids (namely, the context ids it replied in the
> last response to NBD_OPT_SET_META_CONTEXT), and then toss that list on
> any further NBD_OPT_SET_META_CONTEXT  or if NBD_OPT_EXPORT_NAME/GO does
> not select the same export name, rather than having to track multiple
> separate per-export lists while waiting for the client to pick which
> export to finally go with.
>
>> This is not really touched in spec, for example
>> "Change the set of active metadata contexts. Issuing this command
>> replaces all previously-set metadata contexts"
>>
>> looks like lacking "for specified export" suffix. May be there are other
>> places.
> No, it is intentional that it replaces ALL previous contexts (not just
> the per-export context), because of the argument that the only context
> that matters as a client is the one you use with NBD_OPT_GO, and if you
> choose GO with a different export than your last SET_META_CONTEXT, then
> you shouldn't be calling NBD_CMD_BLOCK_STATUS.
>
>

Thank you, it's clear for me now.

-- 
Best regards,
Vladimir
