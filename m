Received: from eggs.gnu.org ([2001:4830:134:3::10]:53449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fLQ95-0000V6-EM
	for qemu-devel@nongnu.org; Wed, 23 May 2018 05:33:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fLQ8z-0003Pf-Gl
	for qemu-devel@nongnu.org; Wed, 23 May 2018 05:33:23 -0400
References: <20180522134102.17332-1-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d056710d-fbfc-bb21-66db-be1b8f2e7ff0@virtuozzo.com>
Date: Wed, 23 May 2018 12:33:03 +0300
MIME-Version: 1.0
In-Reply-To: <20180522134102.17332-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] nbd/server: fix trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, den@openvz.org

will resend with "NBD export bitmaps" series v3

22.05.2018 16:41, Vladimir Sementsov-Ogievskiy wrote:
> Return code = 1 doesn't mean that we parsed base:allocation. Move
> trace point to appropriate place.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   nbd/server.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/nbd/server.c b/nbd/server.c
> index 9e1f227178..84381baaa8 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -741,7 +741,10 @@ static int nbd_negotiate_send_meta_context(NBDClient *client,
>    * the current name, after the 'base:' portion has been stripped.
>    *
>    * Return -errno on I/O error, 0 if option was completely handled by
> - * sending a reply about inconsistent lengths, or 1 on success. */
> + * sending a reply about inconsistent lengths, or 1 on success.
> + *
> + * Note: return code = 1 doesn't mean that we've parsed "base:allocation"
> + * namespace. It only mean that there are no errors.*/
>   static int nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
>                                  uint32_t len, Error **errp)
>   {
> @@ -768,10 +771,10 @@ static int nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
>       }
>   
>       if (strncmp(query, "allocation", alen) == 0) {
> +        trace_nbd_negotiate_meta_query_parse("base:allocation");
>           meta->base_allocation = true;
>       }
>   
> -    trace_nbd_negotiate_meta_query_parse("base:allocation");
>       return 1;
>   }
>   


-- 
Best regards,
Vladimir
