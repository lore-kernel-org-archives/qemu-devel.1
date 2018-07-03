Received: from eggs.gnu.org ([2001:4830:134:3::10]:37348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1faHtQ-0002t9-Ga
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:46:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1faHtP-0005u9-DZ
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 05:46:40 -0400
References: <20180702191458.28741-1-eblake@redhat.com>
	<20180702191458.28741-2-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <79924948-36a8-e604-22c3-d7e407c84e30@virtuozzo.com>
Date: Tue, 3 Jul 2018 12:46:23 +0300
MIME-Version: 1.0
In-Reply-To: <20180702191458.28741-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 1/2] nbd/client: Add x-dirty-bitmap to
 query bitmap from server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>

02.07.2018 22:14, Eric Blake wrote:
> In order to test that the NBD server is properly advertising
> dirty bitmaps, we need a bare minimum client that can request
> and read the context.  Since feature freeze for 3.0 is imminent,
> this is the smallest workable patch, which replaces the qemu
> block status report with the results of the NBD server's dirty
> bitmap (making it very easy to use 'qemu-img map --output=json'
> to learn where the dirty portions are).  Note that the NBD
> protocol defines a dirty section with the same bit but opposite
> sense that normal "base:allocation" uses to report an allocated
> section; so in qemu-img map output, "data":true corresponds to
> clean, "data":false corresponds to dirty.
>
> A more complete solution that allows dirty bitmaps to be queried
> at the same time as normal block status will be required before
> this addition can lose the x- prefix.  Until then, the fact that
> this replaces normal status with dirty status means actions
> like 'qemu-img convert' will likely misbehave due to treating
> dirty regions of the file as if they are unallocated.
>
> The next patch adds an iotest to exercise this new code.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>
>   qapi/block-core.json |  7 ++++++-
>   block/nbd-client.h   |  1 +
>   include/block/nbd.h  |  1 +
>   block/nbd-client.c   |  3 +++
>   block/nbd.c          | 10 ++++++++--
>   nbd/client.c         |  4 ++--
>   6 files changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 577ce5e9991..90e554ed0ff 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3471,12 +3471,17 @@
>   #
>   # @tls-creds:   TLS credentials ID
>   #
> +# @x-dirty-bitmap: A "qemu:dirty-bitmap:NAME" string to query in place of
> +#                  traditional "base:allocation" block status (see
> +#                  NBD_OPT_LIST_META_CONTEXT in the NBD protocol) (since 3.0)
> +#

"x-dirty-bitmap=qemu:dirty-bitmap:NAME", is a bit strange, looks like it 
should be "x-dirty-bitmap=NAME", and "qemu:dirty-bitmap" added 
automatically. (and you don't check it, so actually this parameter is 
x-meta-context, and user can select any context, for example, 
"base:allocation", so "x-meta-context=qemu:dirty-bitmap:NAME" sounds 
better too). But I'm ok to leave it as is for now, with x- prefix.


>   # Since: 2.9
>   ##
>   { 'struct': 'BlockdevOptionsNbd',
>     'data': { 'server': 'SocketAddress',
>               '*export': 'str',
> -            '*tls-creds': 'str' } }
> +            '*tls-creds': 'str',
> +            '*x-dirty-bitmap': 'str' } }
>
>   ##
>   # @BlockdevOptionsRaw:
> diff --git a/block/nbd-client.h b/block/nbd-client.h
> index 0ece76e5aff..cfc90550b99 100644
> --- a/block/nbd-client.h
> +++ b/block/nbd-client.h
> @@ -45,6 +45,7 @@ int nbd_client_init(BlockDriverState *bs,
>                       const char *export_name,
>                       QCryptoTLSCreds *tlscreds,
>                       const char *hostname,
> +                    const char *x_dirty_bitmap,
>                       Error **errp);
>   void nbd_client_close(BlockDriverState *bs);
>
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index daaeae61bf9..4638c839f51 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -259,6 +259,7 @@ static inline bool nbd_reply_type_is_error(int type)
>   struct NBDExportInfo {
>       /* Set by client before nbd_receive_negotiate() */
>       bool request_sizes;
> +    char *x_dirty_bitmap;
>
>       /* In-out fields, set by client before nbd_receive_negotiate() and
>        * updated by server results during nbd_receive_negotiate() */
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index 8d69eaaa32f..9686ecbd5ee 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -970,6 +970,7 @@ int nbd_client_init(BlockDriverState *bs,
>                       const char *export,
>                       QCryptoTLSCreds *tlscreds,
>                       const char *hostname,
> +                    const char *x_dirty_bitmap,
>                       Error **errp)
>   {
>       NBDClientSession *client = nbd_get_client_session(bs);
> @@ -982,9 +983,11 @@ int nbd_client_init(BlockDriverState *bs,
>       client->info.request_sizes = true;
>       client->info.structured_reply = true;
>       client->info.base_allocation = true;
> +    client->info.x_dirty_bitmap = g_strdup(x_dirty_bitmap);
>       ret = nbd_receive_negotiate(QIO_CHANNEL(sioc), export,
>                                   tlscreds, hostname,
>                                   &client->ioc, &client->info, errp);
> +    g_free(client->info.x_dirty_bitmap);

hm, pointer remains invalid. If you want free it here, what is the 
reason to strdup it? At least, it worth to zero out the pointer after 
g_free.. Or, free it not here but in client close.

with pointer zeroed or g_free to client destroy procedure,

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>



-- 
Best regards,
Vladimir
