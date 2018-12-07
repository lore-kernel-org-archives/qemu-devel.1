Received: from eggs.gnu.org ([2001:4830:134:3::10]:54385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVHvR-0001vP-4L
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 10:20:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVHvQ-0007gi-2c
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 10:20:21 -0500
References: <20181130220344.3350618-1-eblake@redhat.com>
	<20181130220344.3350618-12-eblake@redhat.com>
	<66333381-b387-9396-03ed-0aae3b4225fb@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ff7cae77-30f5-b7f4-8f45-c8a7b4edef4b@redhat.com>
Date: Fri, 7 Dec 2018 09:19:58 -0600
MIME-Version: 1.0
In-Reply-To: <66333381-b387-9396-03ed-0aae3b4225fb@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/14] nbd/client: Add
 nbd_receive_export_list()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>, "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 12/7/18 4:04 AM, Vladimir Sementsov-Ogievskiy wrote:
> 01.12.2018 1:03, Eric Blake wrote:
>> We want to be able to detect whether a given qemu NBD server is
>> exposing the right export(s) and dirty bitmaps, at least for
>> regression testing.  We could use 'nbd-client -l' from the upstream
>> NBD project to list exports, but it's annoying to rely on
>> out-of-tree binaries; furthermore, nbd-client doesn't necessarily
>> know about all of the qemu NBD extensions.  Thus, we plan on adding
>> a new mode to qemu-nbd that merely sniffs all possible information
>> from the server during handshake phase, then disconnects and dumps
>> the information.
>>
>> This patch adds the low-level client code for grabbing the list
>> of exports.  It benefits from the recent refactoring patches, as
>> well as a minor tweak of changing nbd_opt_go() to nbd_opt_info_go(),
>> in order to share as much code as possible when it comes to doing
>> validation of server replies.  The resulting information is stored
>> in an array of NBDExportInfo which has been expanded to hold more
>> members, along with a convenience function for freeing the list.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---

>> +
>> +/* Query details about a server's exports, then disconnect without
>> + * going into transmission phase. Return a count of the exports listed
>> + * in @info by the server, or -1 on error. Caller must free @info. */
>> +int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
>> +                            const char *hostname, NBDExportInfo **info,
>> +                            Error **errp)
>> +{
>> +    int result;
>> +    int count = 0;
>> +    int i;
>> +    int rc;
>> +    int ret = -1;
>> +    NBDExportInfo *array = NULL;
>> +    uint32_t oldflags;
>> +    QIOChannel *sioc = NULL;
> 
> it's a bit confusing that you use sioc name for the second produced ioc, when
> in nbd_client_init it's visa-versa.
> 
> So, I assume that you mean Secure ioc, when in nbd_client_init it is Socket ioc.

I can s/sioc/outioc/ if that helps. Basically, the output ioc is the 
same as the original ioc for plaintext, and a secure wrapper socket for tls.

>> +    case 0: /* oldstyle, parse length and flags */
>> +        array = g_new0(NBDExportInfo, 1);
>> +        array->name = g_strdup("");
>> +        count = 1;
>> +
>> +        if (nbd_read(ioc, &array->size, sizeof(array->size), errp) < 0) {
>> +            error_prepend(errp, "Failed to read export length: ");
>> +            goto out;
>> +        }
>> +        array->size = be64_to_cpu(array->size);
>> +
>> +        if (nbd_read(ioc, &oldflags, sizeof(oldflags), errp) < 0) {
>> +            error_prepend(errp, "Failed to read export flags: ");
>> +            goto out;
>> +        }
>> +        oldflags = be32_to_cpu(oldflags);
>> +        if (oldflags & ~0xffff) {
>> +            error_setg(errp, "Unexpected export flags %0x" PRIx32, oldflags);
>> +            goto out;
>> +        }
>> +        array->flags = oldflags;
> 
> 
> ^^^
> this is a common part of nbd_receive_export_list and nbd_receive_negotiate,
> can we move it to nbd_start_negotiate?

Not quite, but I could probably create yet another helper function.

> 
>> +
>> + out:
>> +    qio_channel_shutdown(ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
>> +    qio_channel_close(ioc, NULL);
> 
> interesting, why we don't close it (only shutdown) in other nbd code..

I presume you mean block/nbd-client.c:nbd_teardown_connection, which 
indeed oncly calls qio_channel_shutdown() followed by object_unref().  I 
think that unref'ing a channel implies a close, but if not, then that 
code is leaking an fd (shutdown ends the connection, but does not close 
resources).  I'll have to debug that, but it's independent of this patch.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
