Received: from eggs.gnu.org ([2001:4830:134:3::10]:36614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fRHZt-0003n2-At
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 09:37:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fRHZp-0004Xq-9N
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 09:37:17 -0400
References: <20180523102419.28665-1-vsementsov@virtuozzo.com>
	<20180523102419.28665-4-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <758d1370-b973-ff14-c6e8-c56a50cd8534@virtuozzo.com>
Date: Fri, 8 Jun 2018 16:37:05 +0300
MIME-Version: 1.0
In-Reply-To: <20180523102419.28665-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 3/5] nbd/server: implement dirty bitmap
 export
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, eblake@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

23.05.2018 13:24, Vladimir Sementsov-Ogievskiy wrote:
> Handle new NBD meta namespace: "qemu", and corresponding queries:
> "qemu:dirty-bitmap:<export bitmap name>".
>
> With new metadata context negotiated, BLOCK_STATUS query will reply
> with dirty-bitmap data, converted to extents. New public function
> nbd_export_bitmap selects bitmap to export. For now, only one bitmap
> may be exported.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

[...]

>   
> +/* nbd_meta_bitmap_query
> + *
> + * Handle query to 'qemu:' namespace.
> + * @len is the amount of text remaining to be read from the current name, after
> + * the 'qemu:' portion has been stripped.
> + *
> + * Return -errno on I/O error, 0 if option was completely handled by
> + * sending a reply about inconsistent lengths, or 1 on success. */
> +static int nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,
> +                               uint32_t len, Error **errp)
> +{
> +    bool dirty_bitmap = false;
> +    int dirty_bitmap_len = strlen("dirty-bitmap:");
> +    int ret;
> +
> +    if (!client->exp->export_bitmap) {

client->exp is not yet set here. meta->exp should be used instead (and 
patch should be added, to move from meta->export_name to meta->exp, I'll 
add it in v4)

> +        return nbd_opt_skip(client, len, errp);
> +    }
> +
> +    if (len == 0) {
> +        if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
> +            meta->dirty_bitmap = true;
> +        }
> +        trace_nbd_negotiate_meta_query_parse("empty");
> +        return 1;
> +    }
> +
> +    if (len < dirty_bitmap_len) {
> +        trace_nbd_negotiate_meta_query_skip("not dirty-bitmap:");
> +        return nbd_opt_skip(client, len, errp);
> +    }
> +
> +    len -= dirty_bitmap_len;
> +    ret = nbd_meta_pattern(client, "dirty-bitmap:", &dirty_bitmap, errp);
> +    if (ret <= 0) {
> +        return ret;
> +    }
> +    if (!dirty_bitmap) {
> +        trace_nbd_negotiate_meta_query_skip("not dirty-bitmap:");
> +        return nbd_opt_skip(client, len, errp);
> +    }
> +
> +    trace_nbd_negotiate_meta_query_parse("dirty-bitmap:");
> +
> +    return nbd_meta_empty_or_pattern(
> +            client, client->exp->export_bitmap_context +

meta->exp

> +            strlen("qemu:dirty_bitmap:"), len, &meta->dirty_bitmap, errp);
> +}
> +
>   

-- 
Best regards,
Vladimir
