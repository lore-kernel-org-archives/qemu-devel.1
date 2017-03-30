Received: from eggs.gnu.org ([2001:4830:134:3::10]:48069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctdW5-0005a4-49
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 13:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctdW0-0000dl-LI
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 13:05:45 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
	<1490879707-6060-11-git-send-email-armbru@redhat.com>
	<b65b4a5a-bb31-8b15-f35f-b55ffd10b4c3@redhat.com>
Date: Thu, 30 Mar 2017 19:05:29 +0200
In-Reply-To: <b65b4a5a-bb31-8b15-f35f-b55ffd10b4c3@redhat.com> (Max Reitz's
	message of "Thu, 30 Mar 2017 18:42:47 +0200")
Message-ID: <871ste4rvq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC v2 for-2.9 10/10] sheepdog: Fix blockdev-add
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

> On 30.03.2017 15:15, Markus Armbruster wrote:
>> Commit 831acdc "sheepdog: Implement bdrv_parse_filename()" and commit
>> d282f34 "sheepdog: Support blockdev-add" have different ideas on how
>> the QemuOpts parameters for the server address are named.  Fix that.
>> While there, rename BlockdevOptionsSheepdog member addr to server, for
>> consistency with BlockdevOptionsSsh, BlockdevOptionsGluster,
>> BlockdevOptionsNbd.
>> 
>> Commit 831acdc's example becomes
>> 
>>     --drive driver=sheepdog,server.type=inet,server.host=fido,server.port=7000,vdi=dolly
>> 
>> instead of
>> 
>>     --drive driver=sheepdog,host=fido,vdi=dolly
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  block/sheepdog.c     | 84 ++++++++++++++++++++++++++++++++++------------------
>>  qapi/block-core.json |  4 +--
>>  2 files changed, 58 insertions(+), 30 deletions(-)
>
> There's trailing whitespace somewhere in this patch (git-am complained).

Fixe in my tree.

>> diff --git a/block/sheepdog.c b/block/sheepdog.c
>> index 89e98ed..c81013d 100644
>> --- a/block/sheepdog.c
>> +++ b/block/sheepdog.c
>> @@ -13,9 +13,11 @@
>>   */
>>  
>>  #include "qemu/osdep.h"
>> +#include "qapi-visit.h"
>>  #include "qapi/error.h"
>>  #include "qapi/qmp/qdict.h"
>>  #include "qapi/qmp/qint.h"
>> +#include "qapi/qobject-input-visitor.h"
>>  #include "qemu/uri.h"
>>  #include "qemu/error-report.h"
>>  #include "qemu/sockets.h"
>> @@ -547,6 +549,47 @@ static SocketAddress *sd_socket_address(const char *path,
>>      return addr;
>>  }
>>  
>> +static SocketAddress *sd_server_config(QDict *options, Error **errp)
>> +{
>> +    QDict *server = NULL;
>> +    QObject *crumpled_server = NULL;
>> +    Visitor *iv = NULL;
>> +    SocketAddressFlat *saddr_flat = NULL;
>> +    SocketAddress *saddr = NULL;
>> +    Error *local_err = NULL;
>> +
>> +    qdict_extract_subqdict(options, &server, "server.");
>
> server may be empty:
>
> $ ./qemu-img info sheepdog:vdi
> qemu-img: Could not open 'sheepdog:vdi': Parameter 'type' is missing
>
> I'd propose creating an 'inet' SocketAddress object then for
> SD_DEFAULT_ADDR and SD_DEFAULT_PORT so that existing behavior won't change.

Makes sense.

In my working tree:

    $ upstream-qemu-img info sheepdog:vdi
    @@@ server.host=localhost
    @@@ server.port=7000
    @@@ tag=
    @@@ server.type=inet
    @@@ vdi=vdi
    ### vdi=vdi addr=localhost:7000 snap-id=(null) tag=
    upstream-qemu-img: Could not open 'sheepdog:vdi': Failed to connect socket: Connection refused

>> +
>> +    crumpled_server = qdict_crumple(server, errp);
>> +    if (!crumpled_server) {
>> +        goto done;
>> +    }
>> +
>> +    /*
>> +     * FIXME .numeric, .to, .ipv4 or .ipv6 don't work with -drive
>> +     * server.type=inet.  .to doesn't matter, it's ignored anyway.
>> +     * That's because when @options come from -blockdev or
>> +     * blockdev_add, members are typed according to the QAPI schema,
>> +     * but when they come from -drive, they're all QString.  The
>> +     * visitor expects the former.
>> +     */
>> +    iv = qobject_input_visitor_new(crumpled_server);
>> +    visit_type_SocketAddressFlat(iv, NULL, &saddr_flat, &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        goto done;
>> +    }
>> +
>> +    saddr = socket_address_crumple(saddr_flat);
>> +
>> +done:
>> +    qapi_free_SocketAddressFlat(saddr_flat);
>> +    visit_free(iv);
>> +    qobject_decref(crumpled_server);
>> +    QDECREF(server);
>> +    return saddr;
>> +}
>> +
>>  /* Return -EIO in case of error, file descriptor on success */
>>  static int connect_to_sdog(BDRVSheepdogState *s, Error **errp)
>>  {
>> @@ -1175,15 +1218,17 @@ static void sd_parse_filename(const char *filename, QDict *options,
>>      }
>>  
>>      if (cfg.host) {
>> -        qdict_set_default_str(options, "host", cfg.host);
>> +        qdict_set_default_str(options, "server.host", cfg.host);
>> +        qdict_set_default_str(options, "server.type", "inet");
>>      }
>>      if (cfg.port) {
>>          snprintf(buf, sizeof(buf), "%d", cfg.port);
>> -        qdict_set_default_str(options, "port", buf);
>> +        qdict_set_default_str(options, "server.port", buf);
>
> .port is mandatory, so doing this optionally results in:
>
> $ ./qemu-img info sheepdog://localhost/foo
> qemu-img: Could not open 'sheepdog://localhost/foo': Parameter 'port' is
> missing

In my working tree:

    $ upstream-qemu-img info sheepdog://localhost6/foo
    @@@ server.host=localhost6
    @@@ server.port=7000
    @@@ tag=
    @@@ server.type=inet
    @@@ vdi=foo
    ### vdi=foo addr=localhost6:7000 snap-id=(null) tag=
    upstream-qemu-img: Could not open 'sheepdog://localhost6/foo': Failed to connect socket: Connection refused
    $ upstream-qemu-img info sheepdog://:123/foo
    @@@ server.host=localhost
    @@@ server.port=123
    @@@ tag=
    @@@ server.type=inet
    @@@ vdi=foo
    ### vdi=foo addr=localhost:123 snap-id=(null) tag=
    upstream-qemu-img: Could not open 'sheepdog://:123/foo': Failed to connect socket: Connection refused
    $ upstream-qemu-img info sheepdog:///foo
    @@@ server.host=localhost
    @@@ server.port=7000
    @@@ tag=
    @@@ server.type=inet
    @@@ vdi=foo
    ### vdi=foo addr=localhost:7000 snap-id=(null) tag=
    upstream-qemu-img: Could not open 'sheepdog:///foo': Failed to connect socket: Connection refused

>>      }
>>      if (cfg.path) {
>> -        qdict_set_default_str(options, "path", cfg.path);
>> -    }
>> +        qdict_set_default_str(options, "server.path", cfg.path); 
>> +        qdict_set_default_str(options, "server.type", "unix");
>> +   }
>
> Indentation is off.

Fixing...

> Max

Thanks!

[...]
