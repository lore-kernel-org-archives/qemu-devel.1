Received: from eggs.gnu.org ([2001:4830:134:3::10]:50921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fYqEM-0008LW-6A
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fYqEI-0003TX-5O
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:02:18 -0400
References: <20180621032539.134944-1-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c4c1dc69-9d64-435b-1dab-c1edfa6ce2bd@virtuozzo.com>
Date: Fri, 29 Jun 2018 13:01:50 +0300
MIME-Version: 1.0
In-Reply-To: <20180621032539.134944-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] nbd/client: add x-block-status hack for
 testing server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>

Sorry for being late, here are some thoughts. Anyway, idea is good, 
we've planned to do something like this, but you were the first)

21.06.2018 06:25, Eric Blake wrote:
> In order to test that the NBD server is properly advertising
> dirty bitmaps, we need a bare minimum client that can request
> and read the context.  This patch is a hack (hence the use of
> the x- prefix) that serves two purposes: first, it lets the
> client pass a request of more than one context at a time to
> the server, to test the reaction of the server to various
> contexts (via the list command).  Second, whatever the first
> context in the user's list becomes the context wired up to the
> results visible in bdrv_block_status(); this has the result
> that if you pass in 'qemu:dirty-bitmap:b' instead of the usual
> 'base:allocation', and the server is currently serving a named
> bitmap 'b', then commands like 'qemu-img map' now output status
> corresponding to the dirty bitmap (dirty sections look like
> holes, while clean sections look like data, based on how the
> status bits are mapped over the NBD protocol).
>
> Since the hack corrupts the meaning of bdrv_block_status(), I
> would NOT try to run 'qemu-img convert' or any other program
> that might misbehave based on thinking clusters have a different
> status than what the normal 'base:allocation' would provide.
>
> The hack uses a semicolon-separated list embedded in a single
> string, as that was easier to wire into the nbd block driver than
> figuring out the right incantation of flattened QDict to represent
> an array via the command line.  Oh well, just one more reason that
> this hack deserves the 'x-' prefix.
>
> As a demo, I was able to prove things work with the following sequence:
>
> $ qemu-img info file
> image: file
> file format: qcow2
> virtual size: 2.0M (2097152 bytes)
> disk size: 2.0M
> cluster_size: 65536
> Format specific information:
>      compat: 1.1
>      lazy refcounts: false
>      refcount bits: 16
>      corrupt: false
>
> $ ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -nographic -qmp stdio
> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 12, "major": 2}, "package": "v2.12.0-1531-g3ab98aa673d"}, "capabilities": []}}
> {'execute':'qmp_capabilities'}
> {"return": {}}
> {'execute':'blockdev-add','arguments':{'driver':'qcow2','node-name':'n','file':{'driver':'file','filename':'file'}}}
> {"return": {}}
> {'execute':'block-dirty-bitmap-add','arguments':{'node':'n','name':'b','persistent':true}}
> {"return": {}}
> {'execute':'quit'}
> {"return": {}}
> {"timestamp": {"seconds": 1529548814, "microseconds": 472828}, "event": "SHUTDOWN", "data": {"guest": false}}
>
> $ ./qemu-io -f qcow2 file
> qemu-io> r -v 0 1
> 00000000:  01  .
> read 1/1 bytes at offset 0
> 1 bytes, 1 ops; 0.0001 sec (4.957 KiB/sec and 5076.1421 ops/sec)
> qemu-io> w -P 1 0 1
> wrote 1/1 bytes at offset 0
> 1 bytes, 1 ops; 0.0078 sec (127.502231 bytes/sec and 127.5022 ops/sec)
> qemu-io> q
>
> $ ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -nographic -qmp stdio
> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 12, "major": 2}, "package": "v2.12.0-1531-g3ab98aa673d"}, "capabilities": []}}
> {'execute':'qmp_capabilities'}
> {"return": {}}
> {'execute':'nbd-server-start','arguments':{'addr':{'type':'inet','data':{'host':'localhost','port':'10809'}}}}
> {"return": {}}
> {'execute':'blockdev-add','arguments':{'driver':'qcow2','node-name':'n','file':{'driver':'file','filename':'file'}}}
> {"return": {}}
> {'execute':'nbd-server-add','arguments':{'device':'n'}}
> {"return": {}}
> {'execute':'x-nbd-server-add-bitmap','arguments':{'name':'n','bitmap':'b'}}
> {"error": {"class": "GenericError", "desc": "Bitmap 'b' is enabled"}}
> {'execute':'x-block-dirty-bitmap-disable','arguments':{'node':'n','name':'b'}}
> {"return": {}}
> {'execute':'x-nbd-server-add-bitmap','arguments':{'name':'n','bitmap':'b'}}
> {"return": {}}
> ... leave running
>
> $ ./qemu-img map --output=json --image-opts driver=nbd,export=n,server.type=inet,server.host=localhost,server.port=10809
> [{ "start": 0, "length": 1114112, "depth": 0, "zero": false, "data": true},
> { "start": 1114112, "length": 458752, "depth": 0, "zero": true, "data": false},
> { "start": 1572864, "length": 524288, "depth": 0, "zero": false, "data": true}]
>
> $ ./qemu-img map --output=json --image-opts driver=nbd,export=n,server.type=inet,server.host=localhost,server.port=10809,x-block-status=qemu:dirty-bitmap:b
> [{ "start": 0, "length": 65536, "depth": 0, "zero": false, "data": false},
> { "start": 65536, "length": 2031616, "depth": 0, "zero": false, "data": true}]
>
> The difference between the two runs shows that base:allocation status
> is thus different from the contents of dirty bitmap 'b'; and that the
> dirty bitmap 'b' indeed tracked the first 64k of the file as being
> dirty due to the qemu-io write at offset 0 performed between the creation
> of bitmap b in the first qemu, and the disabling it prior to exporting it
> in the second qemu.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>
> Based-on: <20180621031957.134718-1-eblake@redhat.com>
> ([PULL 0/7] bitmap export over NBD)
>
>   qapi/block-core.json |  12 ++++-
>   block/nbd-client.h   |   1 +
>   include/block/nbd.h  |   1 +
>   block/nbd-client.c   |   2 +
>   block/nbd.c          |   9 +++-
>   nbd/client.c         | 130 +++++++++++++++++++++++++++++++++++++++++++++++++--
>   nbd/trace-events     |   2 +-
>   7 files changed, 149 insertions(+), 8 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index cc3ede06309..be0456f72b7 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3484,12 +3484,22 @@
>   #
>   # @tls-creds:   TLS credentials ID
>   #
> +# @x-block-status: A string containing a semicolon-separated list of
> +#                  block status context names to query and then
> +#                  request

and then request only the first one

> (see NBD_OPT_LIST_META_CONTEXT in the NBD
> +#                  protocol), only useful for debugging server
> +#                  behavior. If omitted, no query is made, and the
> +#                  request uses just "base:allocation". Since this
> +#                  command is already a hack, it uses a flat string
> +#                  instead of ['str']. (since 3.0)
> +#
>   # Since: 2.9
>   ##
>   { 'struct': 'BlockdevOptionsNbd',
>     'data': { 'server': 'SocketAddress',
>               '*export': 'str',
> -            '*tls-creds': 'str' } }
> +            '*tls-creds': 'str',
> +            '*x-block-status': 'str' } }
>
>   ##
>   # @BlockdevOptionsRaw:
> diff --git a/block/nbd-client.h b/block/nbd-client.h
> index 0ece76e5aff..18405e84a50 100644
> --- a/block/nbd-client.h
> +++ b/block/nbd-client.h
> @@ -45,6 +45,7 @@ int nbd_client_init(BlockDriverState *bs,
>                       const char *export_name,
>                       QCryptoTLSCreds *tlscreds,
>                       const char *hostname,
> +                    const char *x_block_status,
>                       Error **errp);
>   void nbd_client_close(BlockDriverState *bs);
>
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index 8bb9606c39b..79e237e15fa 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -258,6 +258,7 @@ static inline bool nbd_reply_type_is_error(int type)
>   struct NBDExportInfo {
>       /* Set by client before nbd_receive_negotiate() */
>       bool request_sizes;
> +    const char *x_block_status;
>
>       /* In-out fields, set by client before nbd_receive_negotiate() and
>        * updated by server results during nbd_receive_negotiate() */
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index 8d69eaaa32f..d27d65d6519 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -970,6 +970,7 @@ int nbd_client_init(BlockDriverState *bs,
>                       const char *export,
>                       QCryptoTLSCreds *tlscreds,
>                       const char *hostname,
> +                    const char *x_block_status,
>                       Error **errp)
>   {
>       NBDClientSession *client = nbd_get_client_session(bs);
> @@ -982,6 +983,7 @@ int nbd_client_init(BlockDriverState *bs,
>       client->info.request_sizes = true;
>       client->info.structured_reply = true;
>       client->info.base_allocation = true;
> +    client->info.x_block_status = x_block_status;
>       ret = nbd_receive_negotiate(QIO_CHANNEL(sioc), export,
>                                   tlscreds, hostname,
>                                   &client->ioc, &client->info, errp);
> diff --git a/block/nbd.c b/block/nbd.c
> index 13db4030e67..019d8e05450 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -378,6 +378,11 @@ static QemuOptsList nbd_runtime_opts = {
>               .type = QEMU_OPT_STRING,
>               .help = "ID of the TLS credentials to use",
>           },
> +        {
> +            .name = "x-block-status",
> +            .type = QEMU_OPT_STRING,
> +            .help = "debugging only: block status contexts to request",
> +        },
>           { /* end of list */ }
>       },
>   };
> @@ -438,8 +443,8 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
>       }
>
>       /* NBD handshake */
> -    ret = nbd_client_init(bs, sioc, s->export,
> -                          tlscreds, hostname, errp);
> +    ret = nbd_client_init(bs, sioc, s->export, tlscreds, hostname,
> +                          qemu_opt_get(opts, "x-block-status"), errp);

hm, so, after this nbd_open finish, info.x_block_status will become 
invalid pointer..
It's not used in other places, but looks like bad idea anyway. If we 
don't want to allocate string,
we can pass it as a separate const char* paramter to nbd_receive_negotiate.

>    error:
>       if (sioc) {
>           object_unref(OBJECT(sioc));
> diff --git a/nbd/client.c b/nbd/client.c
> index 232ff4f46da..f80d88f6c1e 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -601,6 +601,119 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
>       return QIO_CHANNEL(tioc);
>   }
>
> +/* nbd_negotiate_list_meta_context:
> + * Hack for testing meta context negotiation. Subdivide list on semicolons,
> + * then pass that many queries for info and trace the results.
> + * return 0 for successful negotiation
> + *        -1 with errp set for any other error
> + */
> +static int nbd_negotiate_list_meta_context(QIOChannel *ioc,
> +                                           const char *export,
> +                                           const char *context,
> +                                           Error **errp)
> +{

hm, I'd prefer to refactor this, to not duplicate code.. this function 
(may be a bit improved) may be called from
nbd_negotiate_simple_meta_context(), and we will test normal code path 
when debugging with the hack.
However, I'm ok with this duplication for now, as a debugging hack.

> +    int ret;
> +    NBDOptionReply reply;
> +    uint32_t received_id = 0;
> +    char **list = g_strsplit(context, ";", -1);
> +    char **iter;
> +    uint32_t export_len = strlen(export);
> +    uint32_t context_len;
> +    uint32_t queries = g_strv_length(list);
> +    uint32_t data_len = sizeof(export_len) + export_len +
> +        sizeof(queries) + sizeof(context_len) * queries;
> +    /* Slight overallocation of data is okay */
> +    char *data = g_malloc(data_len + strlen(context));
> +    char *p = data;
> +
> +    trace_nbd_opt_meta_request("list", context, export);
> +    stl_be_p(p, export_len);
> +    memcpy(p += sizeof(export_len), export, export_len);
> +    stl_be_p(p += export_len, queries);
> +    p += sizeof(queries);
> +    for (iter = list; *iter; iter++) {
> +        context_len = strlen(*iter);
> +        stl_be_p(p, context_len);
> +        memcpy(p += sizeof(context_len), *iter, context_len);
> +        data_len += context_len;
> +        p += context_len;
> +    }
> +
> +    ret = nbd_send_option_request(ioc, NBD_OPT_LIST_META_CONTEXT, data_len,
> +                                  data, errp);
> +    g_free(data);
> +    if (ret < 0) {
> +        goto out;
> +    }
> +
> +    if (nbd_receive_option_reply(ioc, NBD_OPT_LIST_META_CONTEXT, &reply,
> +                                 errp) < 0)
> +    {
> +        ret = -1;
> +        goto out;
> +    }
> +
> +    ret = nbd_handle_reply_err(ioc, &reply, errp);
> +    if (ret <= 0) {
> +        goto out;
> +    }
> +
> +    while (reply.type == NBD_REP_META_CONTEXT) {
> +        char *name;
> +

don't you want to check reply.length before read?

> +        if (nbd_read(ioc, &received_id, sizeof(received_id), errp) < 0) {
> +            ret = -1;
> +            goto out;
> +        }
> +        be32_to_cpus(&received_id);
> +
> +        reply.length -= sizeof(received_id);
> +        name = g_malloc(reply.length + 1);
> +        if (nbd_read(ioc, name, reply.length, errp) < 0) {
> +            g_free(name);
> +            ret = -1;
> +            goto out;
> +        }
> +        name[reply.length] = '\0';
> +
> +        trace_nbd_opt_meta_reply(name, received_id);
> +        g_free(name);
> +
> +        /* read next part of reply */
> +        if (nbd_receive_option_reply(ioc, NBD_OPT_LIST_META_CONTEXT, &reply,
> +                                     errp) < 0)
> +        {
> +            ret = -1;
> +            goto out;
> +        }
> +
> +        ret = nbd_handle_reply_err(ioc, &reply, errp);
> +        if (ret <= 0) {
> +            goto out;
> +        }
> +    }
> +
> +    if (reply.type != NBD_REP_ACK) {
> +        error_setg(errp, "Unexpected reply type %" PRIx32 " expected %x",
> +                   reply.type, NBD_REP_ACK);
> +        nbd_send_opt_abort(ioc);
> +        ret = -1;
> +        goto out;
> +    }
> +    if (reply.length) {
> +        error_setg(errp, "Unexpected length to ACK response");
> +        nbd_send_opt_abort(ioc);
> +        ret = -1;
> +        goto out;
> +    }
> +
> +    ret = 0;
> +
> + out:
> +    g_strfreev(list);
> +    return ret;
> +}
> +
>   /* nbd_negotiate_simple_meta_context:
>    * Set one meta context. Simple means that reply must contain zero (not
>    * negotiated) or one (negotiated) contexts. More contexts would be considered
> @@ -622,14 +735,14 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
>       uint32_t received_id = 0;
>       bool received = false;
>       uint32_t export_len = strlen(export);
> -    uint32_t context_len = strlen(context);
> +    uint32_t context_len = strchrnul(context, ';') - context;

comment to above this function should be adjusted appropriately

>       uint32_t data_len = sizeof(export_len) + export_len +
>                           sizeof(uint32_t) + /* number of queries */
>                           sizeof(context_len) + context_len;
>       char *data = g_malloc(data_len);
>       char *p = data;
>
> -    trace_nbd_opt_meta_request(context, export);
> +    trace_nbd_opt_meta_request("set", context, export);
>       stl_be_p(p, export_len);
>       memcpy(p += sizeof(export_len), export, export_len);
>       stl_be_p(p += export_len, 1);
> @@ -677,7 +790,7 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
>               return -1;
>           }
>           name[reply.length] = '\0';
> -        if (strcmp(context, name)) {
> +        if (strncmp(context, name, context_len)) {
>               error_setg(errp, "Failed to negotiate meta context '%s', server "
>                          "answered with different context '%s'", context,
>                          name);
> @@ -829,9 +942,18 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
>                   info->structured_reply = result == 1;
>               }
>
> +            if (info->structured_reply && info->x_block_status &&
> +                nbd_negotiate_list_meta_context(ioc, name,
> +                                                info->x_block_status,
> +                                                errp) < 0) {
> +                goto fail;
> +            }
>               if (info->structured_reply && base_allocation) {
> +                if (!info->x_block_status) {
> +                    info->x_block_status = "base:allocation";
> +                }
>                   result = nbd_negotiate_simple_meta_context(
> -                        ioc, name, "base:allocation",
> +                        ioc, name, info->x_block_status,
>                           &info->meta_base_allocation_id, errp);
>                   if (result < 0) {
>                       goto fail;
> diff --git a/nbd/trace-events b/nbd/trace-events
> index 5e1d4afe8e6..7b587a64856 100644
> --- a/nbd/trace-events
> +++ b/nbd/trace-events
> @@ -10,7 +10,7 @@ nbd_receive_query_exports_start(const char *wantname) "Querying export list for
>   nbd_receive_query_exports_success(const char *wantname) "Found desired export name '%s'"
>   nbd_receive_starttls_new_client(void) "Setting up TLS"
>   nbd_receive_starttls_tls_handshake(void) "Starting TLS handshake"
> -nbd_opt_meta_request(const char *context, const char *export) "Requesting to set meta context %s for export %s"
> +nbd_opt_meta_request(const char *act, const char *context, const char *export) "Requesting to %s meta context %s for export %s"
>   nbd_opt_meta_reply(const char *context, uint32_t id) "Received mapping of context %s to id %" PRIu32
>   nbd_receive_negotiate(void *tlscreds, const char *hostname) "Receiving negotiation tlscreds=%p hostname=%s"
>   nbd_receive_negotiate_magic(uint64_t magic) "Magic is 0x%" PRIx64

-- 
Best regards,
Vladimir
