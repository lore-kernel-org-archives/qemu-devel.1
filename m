Received: from eggs.gnu.org ([2001:4830:134:3::10]:51704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctc94-0002BS-Bx
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:37:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctc93-0000df-1P
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:37:54 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
	<1490879707-6060-9-git-send-email-armbru@redhat.com>
	<bf9194b9-0dde-bbd7-c0f4-2799ade58204@redhat.com>
Date: Thu, 30 Mar 2017 17:37:44 +0200
In-Reply-To: <bf9194b9-0dde-bbd7-c0f4-2799ade58204@redhat.com> (Eric Blake's
	message of "Thu, 30 Mar 2017 10:09:02 -0500")
Message-ID: <87mvc2wzav.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC v2 for-2.9 08/10] nbd: Tidy up blockdev-add
 interface
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

> On 03/30/2017 08:15 AM, Markus Armbruster wrote:
>> SocketAddress is a simple union, and simple unions are awkward: they
>> have their variant members wrapped in a "data" object on the wire, and
>> require additional indirections in C.  I intend to limit its use to
>> existing external interfaces, and convert all internal interfaces to
>> SocketAddressFlat.
>> 
>> BlockdevOptionsNbd is an external interface using SocketAddress.  We
>> already use SocketAddressFlat elsewhere in blockdev=add.  Replace it
>> by SocketAddressFlat while we can (it's new in 2.9) for simplicity and
>> consistency.  For example,
>> 
>>     { "execute": "blockdev-add",
>>       "arguments": { "node-name": "foo", "driver": "nbd",
>>                      "server": { "type": "inet",
>> 		                 "data": { "host": "localhost",
>> 				           "port": "12345" } } } }
>> 
>> becomes
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
>
> So far, so good.
>
>> Unfortunately, SocketAddress is also visible in -drive since 2.8.  Add
>> still more gunk to nbd_process_legacy_socket_options().  You can now
>> shorten
>
> Dead commit message comment?  Or did you still leave it in here, with
> one last chance to approve it before ripping it out in v3 for comparison?
>
> /me reads patch - looks like you did not remove the gunk yet on this
> revision
>
>> 
>>     -drive if=none,driver=nbd,server.type=inet,server.data.host=127.0.0.1,server.data.port=12345
>> 
>> to
>> 
>>     -drive if=none,driver=nbd,server.type=inet,server.host=127.0.0.1,server.port=12345
>
> The example is useful, but if you drop the compatibility gunk, you'll
> want to reword this as an intentional change in (heretofore
> undocumented) behavior.
>
> I'm ambivalent on whether to keep or remove the server.* gunk (the
> conservative approach is to keep it for at least 2.9, even if we rip it
> out in 2.10, as we already found out with qom-type that not being
> conservative during hard freeze risks unintentional breakage - but the
> counter-argument is that -drive parameters have been undocumented and
> that libvirt is not using 2.8's server.data, so it is unlikely anyone
> else is either).  Or put another way, we've already taken care of
> back-compat to make sure that the legacy 'host' works, whether or not
> the new form is spelled 'server.host' or 'server.data.host', so breaking
> back-compat with 'server.data.host' should not impact clients that are
> only using the older 'host'.

Yes.

I'd like to use the license to break this undocumented interface offered
Paolo et al, but I feel offering everybody one more opportunity to
object can't hurt.

>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  block/nbd.c          | 94 +++++++++++++++++++++++++++++++++++++---------------
>>  qapi/block-core.json |  2 +-
>>  2 files changed, 69 insertions(+), 27 deletions(-)
>> 
>
>> @@ -223,12 +223,51 @@ static bool nbd_process_legacy_socket_options(QDict *output_options,
>>      const char *path = qemu_opt_get(legacy_opts, "path");
>>      const char *host = qemu_opt_get(legacy_opts, "host");
>>      const char *port = qemu_opt_get(legacy_opts, "port");
>> +    const char *sd_path = qdict_get_try_str(output_options,
>> +                                            "server.data.path");
>> +    const char *sd_host = qdict_get_try_str(output_options,
>> +                                            "server.data.host");
>> +    const char *sd_port = qdict_get_try_str(output_options,
>> +                                            "server.data.port");
>> +    bool bare = path || host || port;
>> +    bool server_data = sd_path || sd_host || sd_port;
>
> Ah, so diff from v1 is that you took my suggestion of 'bare' for making
> the compatibility gunk checks easier to read.
>
>
>> +    if (bare && server_data) {
>> +        error_setg(errp, "Cannot use 'server' and path/host/port at the "
>> +                   "same time");
>> +        return false;
>> +    }
>> +
>> +    if (server_data) {
>> +        if (sd_host) {
>> +            val = qdict_get(output_options, "server.data.host");
>> +            qobject_incref(val);
>> +            qdict_put_obj(output_options, "server.host", val);
>> +            qdict_del(output_options, "server.data.host");
>> +        }
>> +        if (sd_port) {
>> +            val = qdict_get(output_options, "server.data.port");
>> +            qobject_incref(val);
>> +            qdict_put_obj(output_options, "server.port", val);
>> +            qdict_del(output_options, "server.data.port");
>> +        }
>> +        if (sd_path) {
>> +            val = qdict_get(output_options, "server.data.path");
>> +            qobject_incref(val);
>> +            qdict_put_obj(output_options, "server.path", val);
>> +            qdict_del(output_options, "server.data.path");
>> +        }
>> +        return true;
>
> This exits early, possibly setting both server.host and server.path, and
> misses out on the fact that 'bare' mode flags:
>
>     if (path && host) {
>         error_setg(errp, "path and host may not be used at the same time");
>         return false;
>
> If I'm understanding it right, this will still be flagged later during
> the QAPI type visit as invalid, although the error message quality may
> be different.

s/different/not so hot/

> Would it be any better to just use the same validation logic for both,
> by instead writing:
>
> if (server_data) {
>     if (sd_host) {
>         host = sd_host;
>     }
>     if (sd_port) {
>         port = sd_port;
>     }
>     if (sd_path) {
>         path = sd_path;
>     }
> } else {
>
>> +    }
>> +
>> +    assert(bare);
>> +
>>      for (e = qdict_first(output_options); e; e = qdict_next(output_options, e))
>>      {
>>          if (strstart(e->key, "server.", NULL)) {
>
> to enclose this for loop to only happen on the bare branch, having both
> branches then fall into the validation code?

My reason for doing it this way is to avoid changing the existing gunk
as much as I possibly can, even when that leads to suboptimal error
messages.

>> @@ -248,20 +287,21 @@ static bool nbd_process_legacy_socket_options(QDict *output_options,
>>          }
>>  
>>          qdict_put(output_options, "server.type", qstring_from_str("unix"));
>> -        qdict_put(output_options, "server.data.path", qstring_from_str(path));
>> +        qdict_put(output_options, "server.path", qstring_from_str(path));
>>      } else if (host) {
>>          qdict_put(output_options, "server.type", qstring_from_str("inet"));
>> -        qdict_put(output_options, "server.data.host", qstring_from_str(host));
>> -        qdict_put(output_options, "server.data.port",
>> +        qdict_put(output_options, "server.host", qstring_from_str(host));
>> +        qdict_put(output_options, "server.port",
>>                    qstring_from_str(port ?: stringify(NBD_DEFAULT_PORT)));
>
> Perhaps another reason to fall through: server.port is mandatory in the
> schema (for the 'inet' branch of the union), but 'port' is optional on
> the command line by populating the default here.  Returning early on the
> server_data form makes 'server.data.port' mandatory, if you use the
> server.* form; I guess it's a question of whether we want the server.*
> form to match the bare form, or whether it can be as strict as the QMP
> form and only the bare form has to have compatibility gunk.  Or maybe,
> as argued by others, we don't want 'server.data'*' back-compat at all.

If we decide to keep the new compatibility gunk (and I hope we won't),
we can improve it in 2.10.
