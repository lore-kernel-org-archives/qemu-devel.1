Received: from eggs.gnu.org ([2001:4830:134:3::10]:52171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctTzH-0005Nl-Th
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:55:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctTzH-0004oK-4Y
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 02:55:15 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
	<1490805920-17029-7-git-send-email-armbru@redhat.com>
	<7caffda9-7cbb-4044-7b6a-e398ffa125a6@redhat.com>
Date: Thu, 30 Mar 2017 08:55:07 +0200
In-Reply-To: <7caffda9-7cbb-4044-7b6a-e398ffa125a6@redhat.com> (Eric Blake's
	message of "Wed, 29 Mar 2017 15:02:51 -0500")
Message-ID: <877f37fe44.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [for-2.9 6/8] qapi-schema: SocketAddressFlat
 variants 'vsock' and 'fd'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, namei.unix@gmail.com

Eric Blake <eblake@redhat.com> writes:

> On 03/29/2017 11:45 AM, Markus Armbruster wrote:
>> Note that the new variants are impossible in qemu_gluster_glfs_init(),
>> because the gconf->server can only come from qemu_gluster_parse_uri()
>> or qemu_gluster_parse_json(), and neither can create anything but
>> 'tcp' or 'unix'.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  block/gluster.c  |  2 ++
>>  qapi-schema.json | 19 ++++++++-----------
>>  2 files changed, 10 insertions(+), 11 deletions(-)
>
>> +# This is just like SocketAddress, except it's a flat union rather
>> +# than a simple union.  Nicer because it avoids nesting (i.e. more {})
>> +# on the wire.
>>  #
>>  # Since: 2.9
>>  ##
>>  { 'union': 'SocketAddressFlat',
>>    'base': { 'type': 'SocketAddressFlatType' },
>>    'discriminator': 'type',
>> -  'data': { 'unix': 'UnixSocketAddress',
>> -            'inet': 'InetSocketAddress' } }
>> +  'data': { 'inet': 'InetSocketAddress',
>> +            'unix': 'UnixSocketAddress',
>> +            'vsock': 'VsockSocketAddress',
>> +            'fd': 'String' } }
>
> Can we make 'fd':'str'?  That would be even less pointless nesting on
> the wire.

I guess it's wrapped in an object here to keep the door open for
future extensions.  Perhaps also for symmetry.
