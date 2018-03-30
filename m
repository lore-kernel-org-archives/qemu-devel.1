Received: from eggs.gnu.org ([2001:4830:134:3::10]:35413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f1wx1-0004Mg-KK
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 12:32:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f1wx0-0005uc-BO
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 12:32:27 -0400
References: <20180330130950.1931229-1-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ba967166-28fb-e460-d85c-e3cc5c09f6df@virtuozzo.com>
Date: Fri, 30 Mar 2018 19:32:09 +0300
MIME-Version: 1.0
In-Reply-To: <20180330130950.1931229-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH for-2.12] nbd: trace meta context
 negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

30.03.2018 16:09, Eric Blake wrote:
> Having a more detailed log of the interaction between client and
> server is invaluable in debugging how meta context negotiation
> actually works.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   nbd/client.c     | 2 ++
>   nbd/server.c     | 8 ++++++++
>   nbd/trace-events | 6 ++++++
>   3 files changed, 16 insertions(+)
>
> diff --git a/nbd/client.c b/nbd/client.c
> index 4ee1d9a4a2c..478b6085df7 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -623,6 +623,7 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
>       char *data = g_malloc(data_len);
>       char *p = data;
>
> +    trace_nbd_opt_meta_request(context, export);
>       stl_be_p(p, export_len);
>       memcpy(p += sizeof(export_len), export, export_len);
>       stl_be_p(p += export_len, 1);
> @@ -681,6 +682,7 @@ static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
>           }
>           g_free(name);
>
> +        trace_nbd_opt_meta_reply(context, received_id);
>           received = true;
>
>           /* receive NBD_REP_ACK */
> diff --git a/nbd/server.c b/nbd/server.c
> index cea158913ba..9e1f2271784 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -726,6 +726,7 @@ static int nbd_negotiate_send_meta_context(NBDClient *client,
>           context_id = 0;
>       }
>
> +    trace_nbd_negotiate_meta_query_reply(context, context_id);
>       set_be_option_rep(&opt.h, client->opt, NBD_REP_META_CONTEXT,
>                         sizeof(opt) - sizeof(opt.h) + iov[1].iov_len);
>       stl_be_p(&opt.context_id, context_id);
> @@ -752,10 +753,12 @@ static int nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
>           if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
>               meta->base_allocation = true;
>           }
> +        trace_nbd_negotiate_meta_query_parse("base:");
>           return 1;
>       }
>
>       if (len != alen) {
> +        trace_nbd_negotiate_meta_query_skip("not base:allocation");
>           return nbd_opt_skip(client, len, errp);
>       }
>
> @@ -768,6 +771,7 @@ static int nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
>           meta->base_allocation = true;
>       }
>
> +    trace_nbd_negotiate_meta_query_parse("base:allocation");
>       return 1;
>   }
>
> @@ -800,6 +804,7 @@ static int nbd_negotiate_meta_query(NBDClient *client,
>       /* The only supported namespace for now is 'base'. So query should start
>        * with 'base:'. Otherwise, we can ignore it and skip the remainder. */
>       if (len < baselen) {
> +        trace_nbd_negotiate_meta_query_skip("length too short");
>           return nbd_opt_skip(client, len, errp);
>       }
>
> @@ -809,6 +814,7 @@ static int nbd_negotiate_meta_query(NBDClient *client,
>           return ret;
>       }
>       if (strncmp(query, "base:", baselen) != 0) {
> +        trace_nbd_negotiate_meta_query_skip("not for base: namespace");

Hmm, reasonable example of using same trace-point in several places in 
the code. Is it a precedent?

>           return nbd_opt_skip(client, len, errp);
>       }
>
> @@ -858,6 +864,8 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
>           return ret;
>       }
>       cpu_to_be32s(&nb_queries);
> +    trace_nbd_negotiate_meta_context(nbd_opt_lookup(client->opt),
> +                                     meta->export_name, nb_queries);
>
>       if (client->opt == NBD_OPT_LIST_META_CONTEXT && !nb_queries) {
>           /* enable all known contexts */
> diff --git a/nbd/trace-events b/nbd/trace-events
> index 0d03edc967d..cfdbe04b447 100644
> --- a/nbd/trace-events
> +++ b/nbd/trace-events
> @@ -10,6 +10,8 @@ nbd_receive_query_exports_start(const char *wantname) "Querying export list for
>   nbd_receive_query_exports_success(const char *wantname) "Found desired export name '%s'"
>   nbd_receive_starttls_new_client(void) "Setting up TLS"
>   nbd_receive_starttls_tls_handshake(void) "Starting TLS handshake"
> +nbd_opt_meta_request(const char *context, const char *export) "Requesting to set meta context %s for export %s"
> +nbd_opt_meta_reply(const char *context, int id) "Received mapping of context %s to id %d"

actual type is uint32_t, I'd prefer to reflect it here.

>   nbd_receive_negotiate(void *tlscreds, const char *hostname) "Receiving negotiation tlscreds=%p hostname=%s"
>   nbd_receive_negotiate_magic(uint64_t magic) "Magic is 0x%" PRIx64
>   nbd_receive_negotiate_server_flags(uint32_t globalflags) "Global flags are 0x%" PRIx32
> @@ -44,6 +46,10 @@ nbd_negotiate_handle_info_request(int request, const char *name) "Client request
>   nbd_negotiate_handle_info_block_size(uint32_t minimum, uint32_t preferred, uint32_t maximum) "advertising minimum 0x%" PRIx32 ", preferred 0x%" PRIx32 ", maximum 0x%" PRIx32
>   nbd_negotiate_handle_starttls(void) "Setting up TLS"
>   nbd_negotiate_handle_starttls_handshake(void) "Starting TLS handshake"
> +nbd_negotiate_meta_context(const char *optname, const char *export, int queries) "Client requested %s for export %s, with %d queries"

and here

> +nbd_negotiate_meta_query_skip(const char *reason) "Skipping meta query: %s"
> +nbd_negotiate_meta_query_parse(const char *query) "Parsed meta query '%s'"
> +nbd_negotiate_meta_query_reply(const char *context, unsigned int id) "Replying with meta context '%s' id %d"

and here

>   nbd_negotiate_options_flags(uint32_t flags) "Received client flags 0x%" PRIx32
>   nbd_negotiate_options_check_magic(uint64_t magic) "Checking opts magic 0x%" PRIx64
>   nbd_negotiate_options_check_option(uint32_t option, const char *name) "Checking option %" PRIu32 " (%s)"

Must-have trace-points, anyway:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir
