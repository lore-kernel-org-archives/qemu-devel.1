Received: from eggs.gnu.org ([2001:4830:134:3::10]:60638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dXqF3-0000tj-Pa
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 10:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dXqEy-0005tv-Rv
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 10:46:21 -0400
Received: from ivanoab5.miniserver.com ([78.31.111.25]:42476
	helo=www.kot-begemot.co.uk)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1dXqEy-0005rg-LW
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 10:46:16 -0400
References: <20170718170819.28494-1-anton.ivanov@cambridgegreys.com>
	<20170718170819.28494-3-anton.ivanov@cambridgegreys.com>
	<03702920-f5b1-6579-0c59-a0d46274a6d9@redhat.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <d237447d-f581-d452-bef3-243d2e6db1ee@cambridgegreys.com>
Date: Wed, 19 Jul 2017 15:46:05 +0100
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

I can try that in the next version.

>
> Then again, it does match what NetdevL2TPv3Options did :(
>
>> +#
>> +# @sequence: have sequence counter
>> +#
>> +# @pinsequence: pin sequence counter to zero -
>> +#              workaround for buggy implementations or
>> +#              networks with packet reorder
>> +#
>> +# @txkey: 32 bit transmit key
>> +#
>> +# @rxkey: 32 bit receive key
> Worth listing what the defaults are for these optional fields when not
> present?

GRE header is incremental.

If there is no tx/rxkey the header is shorter and these are not present 
in the header.

If a key is specified the header is longer to accommodate the key.

They are optional - similar to the l2tpv3 cookie.

>
>> +#
>> +# Note - gre checksums are not supported at present
>> +#
>> +#
>> +# Since 2.9
> You've missed 2.9 by a long shot.  You've also missed 2.10 softfreeze
> for a new feature, so this should read since 2.11.

The patch has been sitting in my outgoing queue for reasons outside my 
control for months. I apologise for that and I am re-aligning all of 
them for 2.11

>
>> @@ -3966,7 +4000,7 @@
>>   ##
>>   { 'enum': 'NetClientDriver',
>>     'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde', 'dump',
>> -            'bridge', 'hubport', 'netmap', 'vhost-user' ] }
>> +            'bridge', 'hubport', 'netmap', 'vhost-user', 'gre' ] }
> Worth adding a comment that 'gre' is since 2.11 (look for other enums
> that have had additions after the initial release of the enum, for an
> example of the preferred format).

Ack.

>
>>   
>>   ##
>>   # @Netdev:
>> @@ -3996,7 +4030,8 @@
>>       'bridge':   'NetdevBridgeOptions',
>>       'hubport':  'NetdevHubPortOptions',
>>       'netmap':   'NetdevNetmapOptions',
>> -    'vhost-user': 'NetdevVhostUserOptions' } }
>> +    'vhost-user': 'NetdevVhostUserOptions',
>> +    'gre':      'NetdevGREOptions' } }
> Okay.
>
>>   
>>   ##
>>   # @NetLegacy:
>> @@ -4027,7 +4062,7 @@
>>   ##
>>   { 'enum': 'NetLegacyOptionsType',
>>     'data': ['none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
>> -           'dump', 'bridge', 'netmap', 'vhost-user'] }
>> +           'dump', 'bridge', 'netmap', 'vhost-user', 'gre'] }
> Not okay.  NetLegacy should never grow again (that's the whole point of
> it being legacy - we're trying to phase it out).

OK, I will revise the patch before the next submission.

A.


-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/
