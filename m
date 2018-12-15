Received: from eggs.gnu.org ([2001:4830:134:3::10]:51441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gYBco-0005Sv-Ul
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 10:13:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gYBc7-0002E1-P0
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 10:12:24 -0500
Date: Sat, 15 Dec 2018 15:12:15 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20181215151215.GX27120@redhat.com>
References: <20181215135324.152629-1-eblake@redhat.com>
	<20181215135324.152629-12-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181215135324.152629-12-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 11/22] nbd/client: Change signature of
 nbd_negotiate_simple_meta_context()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, nsoffer@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Sat, Dec 15, 2018 at 07:53:13AM -0600, Eric Blake wrote:
> Pass 'info' instead of three separate parameters related to info,
> when requesting the server to set the meta context.  Update the
> NBDExportInfo struct to rename the received id field to match the
> fact that we are currently overloading the field to match whatever
> context the user supplied through the x-dirty-bitmap hack, as well
> as adding a TODO comment to remind future patches about a desire
> to request two contexts at once.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> v2: split patch into easier-to-review pieces [Rich, Vladimir]
> rename NBDExportInfo meta_base_allocation_id [Vladimir]
> ---
>  include/block/nbd.h |  2 +-
>  block/nbd-client.c  |  4 ++--
>  nbd/client.c        | 53 +++++++++++++++++++++------------------------
>  3 files changed, 28 insertions(+), 31 deletions(-)
> 
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index 65feff8ba96..ae5fe28f486 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -276,7 +276,7 @@ struct NBDExportInfo {
>      uint32_t opt_block;
>      uint32_t max_block;
> 
> -    uint32_t meta_base_allocation_id;
> +    uint32_t context_id;
>  };
>  typedef struct NBDExportInfo NBDExportInfo;
> 
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index 417971d8b05..608b578e1d3 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -246,11 +246,11 @@ static int nbd_parse_blockstatus_payload(NBDClientSession *client,
>      }
> 
>      context_id = payload_advance32(&payload);
> -    if (client->info.meta_base_allocation_id != context_id) {
> +    if (client->info.context_id != context_id) {
>          error_setg(errp, "Protocol error: unexpected context id %d for "
>                           "NBD_REPLY_TYPE_BLOCK_STATUS, when negotiated context "
>                           "id is %d", context_id,
> -                         client->info.meta_base_allocation_id);
> +                         client->info.context_id);
>          return -EINVAL;
>      }
> 
> diff --git a/nbd/client.c b/nbd/client.c
> index 7462fa5ae0e..bcccd5f555e 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -628,26 +628,30 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
>  }
> 
>  /* nbd_negotiate_simple_meta_context:
> - * Set one meta context. Simple means that reply must contain zero (not
> - * negotiated) or one (negotiated) contexts. More contexts would be considered
> - * as a protocol error. It's also implied that meta-data query equals queried
> - * context name, so, if server replies with something different than @context,
> - * it is considered an error too.
> - * return 1 for successful negotiation, context_id is set
> + * Request the server to set the meta context for export @info->name
> + * using @info->x_dirty_bitmap with a fallback to "base:allocation",
> + * setting @info->context_id to the resulting id. Fail if the server
> + * responds with more than one context or with a context different
> + * than the query.
> + * return 1 for successful negotiation,
>   *        0 if operation is unsupported,
>   *        -1 with errp set for any other error
>   */
>  static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
> -                                             const char *export,
> -                                             const char *context,
> -                                             uint32_t *context_id,
> +                                             NBDExportInfo *info,
>                                               Error **errp)
>  {
> +    /*
> +     * TODO: Removing the x_dirty_bitmap hack will mean refactoring
> +     * this function to request and store ids for multiple contexts
> +     * (both base:allocation and a dirty bitmap), at which point this
> +     * function should lose the term _simple.
> +     */
>      int ret;
>      NBDOptionReply reply;
> -    uint32_t received_id = 0;
> +    const char *context = info->x_dirty_bitmap ?: "base:allocation";
>      bool received = false;
> -    uint32_t export_len = strlen(export);
> +    uint32_t export_len = strlen(info->name);
>      uint32_t context_len = strlen(context);
>      uint32_t data_len = sizeof(export_len) + export_len +
>                          sizeof(uint32_t) + /* number of queries */
> @@ -655,9 +659,9 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
>      char *data = g_malloc(data_len);
>      char *p = data;
> 
> -    trace_nbd_opt_meta_request(context, export);
> +    trace_nbd_opt_meta_request(context, info->name);
>      stl_be_p(p, export_len);
> -    memcpy(p += sizeof(export_len), export, export_len);
> +    memcpy(p += sizeof(export_len), info->name, export_len);
>      stl_be_p(p += export_len, 1);
>      stl_be_p(p += sizeof(uint32_t), context_len);
>      memcpy(p += sizeof(context_len), context, context_len);
> @@ -683,7 +687,7 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
>      if (reply.type == NBD_REP_META_CONTEXT) {
>          char *name;
> 
> -        if (reply.length != sizeof(received_id) + context_len) {
> +        if (reply.length != sizeof(info->context_id) + context_len) {
>              error_setg(errp, "Failed to negotiate meta context '%s', server "
>                         "answered with unexpected length %" PRIu32, context,
>                         reply.length);
> @@ -691,12 +695,13 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
>              return -1;
>          }
> 
> -        if (nbd_read(ioc, &received_id, sizeof(received_id), errp) < 0) {
> +        if (nbd_read(ioc, &info->context_id, sizeof(info->context_id),
> +                     errp) < 0) {
>              return -1;
>          }
> -        received_id = be32_to_cpu(received_id);
> +        info->context_id = be32_to_cpu(info->context_id);
> 
> -        reply.length -= sizeof(received_id);
> +        reply.length -= sizeof(info->context_id);
>          name = g_malloc(reply.length + 1);
>          if (nbd_read(ioc, name, reply.length, errp) < 0) {
>              g_free(name);
> @@ -713,7 +718,7 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
>          }
>          g_free(name);
> 
> -        trace_nbd_opt_meta_reply(context, received_id);
> +        trace_nbd_opt_meta_reply(context, info->context_id);
>          received = true;
> 
>          /* receive NBD_REP_ACK */
> @@ -742,12 +747,7 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
>          return -1;
>      }
> 
> -    if (received) {
> -        *context_id = received_id;
> -        return 1;
> -    }
> -
> -    return 0;
> +    return received;
>  }
> 
>  int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
> @@ -846,10 +846,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
>              }
> 
>              if (info->structured_reply && base_allocation) {
> -                result = nbd_negotiate_simple_meta_context(
> -                        ioc, info->name,
> -                        info->x_dirty_bitmap ?: "base:allocation",
> -                        &info->meta_base_allocation_id, errp);
> +                result = nbd_negotiate_simple_meta_context(ioc, info, errp);
>                  if (result < 0) {
>                      goto fail;
>                  }

This is much clearer and smaller refactoring so:

Reviewed-by: Richard W.M. Jones <rjones@redhat.com>

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top
