Received: from eggs.gnu.org ([2001:4830:134:3::10]:41564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dXspg-00043x-Fm
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 13:32:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dXspd-0007QW-BS
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 13:32:20 -0400
Received: from ivanoab5.miniserver.com ([78.31.111.25]:42487
	helo=www.kot-begemot.co.uk)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1dXspd-0007QA-5Q
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 13:32:17 -0400
References: <20170718170819.28494-1-anton.ivanov@cambridgegreys.com>
	<20170718170819.28494-3-anton.ivanov@cambridgegreys.com>
	<03702920-f5b1-6579-0c59-a0d46274a6d9@redhat.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <7c19329b-f3dc-1f54-9fac-8ecf43123a8b@cambridgegreys.com>
Date: Wed, 19 Jul 2017 18:32:08 +0100
MIME-Version: 1.0
In-Reply-To: <03702920-f5b1-6579-0c59-a0d46274a6d9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] Unified Datagram Socket Transport -
 GRE support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: jasowang@redhat.com



On 19/07/17 15:40, Eric Blake wrote:
> On 07/18/2017 12:08 PM, anton.ivanov@cambridgegreys.com wrote:
>> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>
>> This adds GRETAP support to the unified socket driver.
>>
>> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>> ---
>>   net/Makefile.objs |   2 +-
>>   net/clients.h     |   4 +
>>   net/gre.c         | 313 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   net/net.c         |   5 +
>>   qapi-schema.json  |  46 +++++++-
>>   qemu-options.hx   |  63 ++++++++++-
>>   6 files changed, 425 insertions(+), 8 deletions(-)
>>   create mode 100644 net/gre.c
>>
> Just an interface review:
>
>> +++ b/qapi-schema.json
>> @@ -3847,7 +3847,41 @@
>>       'txsession':    'uint32',
>>       '*rxsession':   'uint32',
>>       '*offset':      'uint32' } }
>> -
>> +##
>> +# @NetdevGREOptions:
>> +#
>> +# Connect the VLAN to Ethernet over Ethernet over GRE (GRETAP) tunnel
>> +#
>> +# @src: source address
>> +#
>> +# @dst: destination address
>> +#
>> +# @ipv6: force the use of ipv6
> This doesn't quite match what we do with other sockets (where we have
> both ipv4 and ipv6 booleans to allow IPv4-only, IPv6-only, or both).  Is
> this something where we can reuse InetSocketAddress instead of inventing
> yet another way of doing things?
>
> Then again, it does match what NetdevL2TPv3Options did :(

I just reviewed this again.

I do not think  we can today. This is the declaration:

##
{ 'struct': 'InetSocketAddressBase',
   'data': {
     'host': 'str',
     'port': 'str' } }

##

If I read this right port is mandatory, correct?

We may be able to do it if the port portion if InetSocketAddress becomes 
optional. There is no such thing as port for the protocols which use the 
raw families.

I now recall it being the reason why L2TPv3 does it this way.

I am addressing the rest of the comments in the meantime.

A.

[snip]

-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/
