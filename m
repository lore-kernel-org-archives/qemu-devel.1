Received: from eggs.gnu.org ([2001:4830:134:3::10]:58550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctUAb-0002KF-NS
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 03:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctUAa-0008Ks-Iw
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 03:06:57 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
	<1490805920-17029-8-git-send-email-armbru@redhat.com>
	<27410c8a-0213-6ede-e9a3-cbb248f3e7a4@redhat.com>
Date: Thu, 30 Mar 2017 09:06:48 +0200
In-Reply-To: <27410c8a-0213-6ede-e9a3-cbb248f3e7a4@redhat.com> (Eric Blake's
	message of "Wed, 29 Mar 2017 15:19:40 -0500")
Message-ID: <87zig3dz07.fsf@dusky.pond.sub.org>
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
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, namei.unix@gmail.com

Eric Blake <eblake@redhat.com> writes:

> On 03/29/2017 11:45 AM, Markus Armbruster wrote:
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
>
> This part makes sense, and means this has to go in 2.9.
>
>> 
>> Since the internal interfaces still take SocketAddress, this requires
>> conversion function socket_address_crumple().  It'll go away when I
>> update the interfaces.
>
> This is probably the fastest way forward for 2.9, even if we rip it out
> later in 2.10.
>
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
>
> Here, I'm 50/50 on whether the compatibility gunk is worth it, or
> whether to make a clean break of old configurations, as I'm not sure who
> is using the old configurations.  But given the lateness of the change
> (and my recent case of being burned on qom-type during freeze when I was
> not conservative), I agree with your conservative approach of remaining
> compatible, even if it means the patch is larger than desired, and even
> if we rip it out again in 2.10.

Ripping out becomes harder the long we wait.

Since both Paolo and Max prefer to go without the compatibility gunk,
I'll drop it.

>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  block/nbd.c          | 131 ++++++++++++++++++++++++++++++++++++++++-----------
>>  qapi/block-core.json |   2 +-
>>  2 files changed, 104 insertions(+), 29 deletions(-)
>> 
>
>> @@ -223,17 +224,45 @@ static bool nbd_process_legacy_socket_options(QDict *output_options,
>>      const char *path = qemu_opt_get(legacy_opts, "path");
>>      const char *host = qemu_opt_get(legacy_opts, "host");
>>      const char *port = qemu_opt_get(legacy_opts, "port");
>> +    const char *sd_path = qemu_opt_get(legacy_opts, "server.data.path");
>> +    const char *sd_host = qemu_opt_get(legacy_opts, "server.data.host");
>> +    const char *sd_port = qemu_opt_get(legacy_opts, "server.data.port");
>> +    bool no_server = path || host || port;
>> +    bool server_data = sd_path || sd_host || sd_port;
>>      const QDictEntry *e;
>>  
>> -    if (!path && !host && !port) {
>> +    if (!no_server && !server_data) {
>
> Feels like a double negative, although it's not really serving that
> role.  Maybe a better name would be s/no_server/bare/, so that 'bare' is
> now your counterpart to 'server_data'.

If we change our mind and keep the gunk, I'll rename to @bare.

>> +        return true;
>> +    }
>> +
>> +    if (no_server && server_data) {
>> +        error_setg(errp, "Cannot use %s and %s at the same time",
>> +                   "path/host/port", "server.data.*");
>> +        return false;
>
> Again, 'bare' makes this conditional read a bit better.
>
>> +    }
>> +
>> +    if (server_data) {
>> +        if (sd_host) {
>> +            qdict_put(output_options, "server.host",
>> +                      qstring_from_str(sd_host));
>> +        }
>> +        if (sd_port) {
>> +            qdict_put(output_options, "server.port",
>> +                      qstring_from_str(sd_port));
>> +        }
>> +        if (sd_path) {
>> +            qdict_put(output_options, "server.path",
>> +                      qstring_from_str(sd_path));
>> +        }
>
> Wow, I need to rebase my qdict_put_str() stuff again - that ought to be
> something we include early in 2.10, as it touches a lot of stuff.
> Doesn't affect your patch for now, though.
>
> Renaming the local variable is trivial, so whether or not you
> incorporate my naming suggestion,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Need to drop the R-by along with the compatibility gunk, but thanks
anyway!
