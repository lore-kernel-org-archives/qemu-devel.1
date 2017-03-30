Received: from eggs.gnu.org ([2001:4830:134:3::10]:38367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctUUK-0005W6-SZ
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 03:27:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctUUJ-00072q-L0
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 03:27:20 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
	<1490805920-17029-8-git-send-email-armbru@redhat.com>
	<b4d833b8-c6fd-567c-f500-354acf8c5cc7@redhat.com>
Date: Thu, 30 Mar 2017 09:27:09 +0200
In-Reply-To: <b4d833b8-c6fd-567c-f500-354acf8c5cc7@redhat.com> (Max Reitz's
	message of "Wed, 29 Mar 2017 21:46:51 +0200")
Message-ID: <87shlvdy2a.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [for-2.9 7/8] nbd: Tidy up blockdev-add interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, pbonzini@redhat.com, namei.unix@gmail.com

Max Reitz <mreitz@redhat.com> writes:

> On 29.03.2017 18:45, Markus Armbruster wrote:
>> SocketAddress is a simple union, and simple unions are awkward: they
>> have their variant members wrapped in a "data" object on the wire, and
>> require additional indirections in C.  I intend to limit its use to
>> existing external interfaces, and convert all internal interfaces to
>> SocketAddressFlat.
>> 
>> BlockdevOptionsNbd is an external interface using SocketAddress, but
>> it's new in 2.9.  Replace it by SocketAddressFlat while we can.  This
>> simplifies
>> 
>>     { "execute": "blockdev-add",
>>       "arguments": { "node-name": "foo", "driver": "nbd",
>>                      "server": { "type": "inet",
>> 		                 "data": { "host": "localhost",
>> 				           "port": "12345" } } } }
>> 
>> to
>> 
>>     { "execute": "blockdev-add",
>>       "arguments": { "node-name": "foo", "driver": "nbd",
>>                      "server": { "type": "inet",
>> 		                 "host": "localhost", "port": "12345" } } }
>> 
>> Since the internal interfaces still take SocketAddress, this requires
>> conversion function socket_address_crumple().  It'll go away when I
>> update the interfaces.
>> 
>> Unfortunately, SocketAddress is also visible in -drive since 2.8.  Add
>> still more gunk to nbd_process_legacy_socket_options().  You can now
>> shorten
>> 
>>     -drive if=none,driver=nbd,server.type=inet,server.data.host=127.0.0.1,server.data.port=12345
>> 
>> to
>> 
>>     -drive if=none,driver=nbd,server.type=inet,server.host=127.0.0.1,server.port=12345
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  block/nbd.c          | 131 ++++++++++++++++++++++++++++++++++++++++-----------
>>  qapi/block-core.json |   2 +-
>>  2 files changed, 104 insertions(+), 29 deletions(-)
>
> To be completely frank: If there is any drawback to using
> SocketAddressFlat instead of SocketAdress, I would be against using it.
> Less indirections in C is an argument, but less {} on the wire is not,
> in my opinion. QMP is a machine interface and machines don't care about
> that additional level.
>
> Therefore, if you think this somehow affects compatibility, I would not
> want to do this change.

PRO:

1. Less nesting on the wire

   You think this isn't a valid argument.  I think it is, just a weak
   one.

2. Less indirection in C

   Makes dealing with the data type annoying.  In other words, the C
   interface is poor.  Poor C interfaces hiding in generated code is one
   thing, but SocketAddress is used in C interfaces between handwritten
   code.  Needs to go.

   Once its gone, all uses of SocketAddress we can't change for
   compatibility reasons need to go through a conversion function.  No
   biggie, but still, the fewer we have, the better.

3. Consistency within blockdev-add

   Nowhere else in blockdev-add do we wrap parts of socket addresses in
   "data".  I guess I should mention this in the commit message.

CON:

1. Renames -drive server.data.* to server.*.  These are new in 2.8.
   Libvirt doesn't use them.  I doubt anyone does.  My patch adds
   compatibility gunk anyway.

> I personally agree with Paolo that we can just break what we have, and
> in addition I think that we *should* break what we have or we should not
> do this change at all.

I'm totally fine with ripping out the compatibility gunk.

I put it in v1 so reviewers can like it or shoot it down.  Better than
not having it in v1, and have reviewers demand it for v2 just so they
can decide whether they want it.
