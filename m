Received: from eggs.gnu.org ([2001:4830:134:3::10]:59011)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1df2LC-00063P-71
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:06:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1df2L9-0000o4-2b
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:06:26 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:38210 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1df2L8-0000ka-PC
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 07:06:23 -0400
References: <ebdf772d1a48ccec999866f9c5cb209b2fcedf48.1502144886.git.jcody@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <26aeaaa2-1366-adef-bb0d-6e64d3097293@kamp.de>
Date: Tue, 8 Aug 2017 13:06:17 +0200
MIME-Version: 1.0
In-Reply-To: <ebdf772d1a48ccec999866f9c5cb209b2fcedf48.1502144886.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH for-2.10] block/nfs: fix mutex assertion in
 nfs_file_close()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, qemu-stable <qemu-stable@nongnu.org>

Am 08.08.2017 um 00:29 schrieb Jeff Cody:
> Commit c096358e747e88fc7364e40e3c354ee0bb683960 introduced assertion
> checks for when qemu_mutex() functions are called without the
> corresponding qemu_mutex_init() having initialized the mutex.
>
> This uncovered a latent bug in qemu's nfs driver - in
> nfs_client_close(), the NFSClient structure is overwritten with zeros,
> prior to the mutex being destroyed.
>
> Go ahead and destroy the mutex in nfs_client_close(), and change where
> we call qemu_mutex_init() so that it is correctly balanced.
>
> There are also a couple of memory leaks obscured by the memset, so this
> fixes those as well.
>
> Finally, we should be able to get rid of the memset(), as it isn't
> necessary.
>
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>   block/nfs.c | 21 +++++++++++++--------
>   1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/block/nfs.c b/block/nfs.c
> index d8db419..bec16b7 100644
> --- a/block/nfs.c
> +++ b/block/nfs.c
> @@ -433,19 +433,23 @@ static void nfs_client_close(NFSClient *client)
>       if (client->context) {
>           if (client->fh) {
>               nfs_close(client->context, client->fh);
> +            client->fh = NULL;
>           }
>           aio_set_fd_handler(client->aio_context, nfs_get_fd(client->context),
>                              false, NULL, NULL, NULL, NULL);
>           nfs_destroy_context(client->context);
> +        client->context = NULL;
>       }
> -    memset(client, 0, sizeof(NFSClient));
> -}
> -
> -static void nfs_file_close(BlockDriverState *bs)
> -{
> -    NFSClient *client = bs->opaque;
> -    nfs_client_close(client);
> +    g_free(client->path);
>       qemu_mutex_destroy(&client->mutex);
> +    qapi_free_NFSServer(client->server);
> +    client->server = NULL;
> +}
> +
> +static void nfs_file_close(BlockDriverState *bs)
> +{
> +    NFSClient *client = bs->opaque;
> +    nfs_client_close(client);
>   }
>   
>   static NFSServer *nfs_config(QDict *options, Error **errp)
> @@ -498,6 +502,7 @@ static int64_t nfs_client_open(NFSClient *client, QDict *options,
>       struct stat st;
>       char *file = NULL, *strp = NULL;
>   
> +    qemu_mutex_init(&client->mutex);
>       opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
>       qemu_opts_absorb_qdict(opts, options, &local_err);
>       if (local_err) {
> @@ -660,7 +665,7 @@ static int nfs_file_open(BlockDriverState *bs, QDict *options, int flags,
>       if (ret < 0) {
>           return ret;
>       }
> -    qemu_mutex_init(&client->mutex);
> +
>       bs->total_sectors = ret;
>       ret = 0;
>       return ret;

Reviewed-by: Peter Lieven <pl@kamp.de>

Also CC'ing qemu-stable as this affects 2.9.0 as well.

Peter
