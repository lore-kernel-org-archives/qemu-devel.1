Received: from eggs.gnu.org ([2001:4830:134:3::10]:45153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1ceQrf-0007D4-J7
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 13:33:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1ceQrc-0004CH-DX
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 13:33:11 -0500
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-12-vsementsov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
Message-ID: <29a208bf-4b7e-930e-7016-fc7269982ae6@virtuozzo.com>
Date: Thu, 16 Feb 2017 16:00:15 +0300
MIME-Version: 1.0
In-Reply-To: <20170203154757.36140-12-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/18] nbd: BLOCK_STATUS for bitmap export:
 server part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, stefanha@redhat.com

On 02/03/2017 06:47 PM, Vladimir Sementsov-Ogievskiy wrote:
> Only one meta context type is defined: qemu-bitmap:<bitmap-name>.
> Maximum one query is allowed for NBD_OPT_{SET,LIST}_META_CONTEXT,
> NBD_REP_ERR_TOO_BIG is returned otherwise.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
...
> +static int nbd_negotiate_opt_meta_context_start(NBDClient *client, uint32_t opt,
> +                                                uint32_t length,
> +                                                uint32_t *nb_queries,
> +                                                BlockDriverState **bs)
> +{
> +    int ret;
> +    NBDExport *exp;
> +    char *export_name;
> +    int nb_read = 0;
> +
> +    if (!client->structured_reply) {
> +        uint32_t tail = length - nb_read;
> +        LOG("Structured reply is not negotiated");
> +
> +        if (nbd_negotiate_drop_sync(client->ioc, tail) != tail) {
> +            return -EIO;
> +        }
> +        ret = nbd_negotiate_send_rep_err(client->ioc, NBD_REP_ERR_INVALID, opt,
> +                                         "Structured reply is not negotiated");
> +        g_free(export_name);
export_name is not initialized here! for me there is no need to free
anything here


> +
> +        if (ret < 0) {
> +            return ret;
> +        } else {
> +            *bs = NULL;
> +            *nb_queries = 0;
> +            return length;
> +        }
> +    }
> +
> +    nb_read = nbd_negotiate_read_size_string(client->ioc, &export_name,
> +                                             NBD_MAX_NAME_SIZE);
> +    if (nb_read < 0) {
> +        return nb_read;
> +    }
> +
> +    exp = nbd_export_find(export_name);
> +    if (exp == NULL) {
> +        uint32_t tail = length - nb_read;
> +        LOG("export '%s' is not found", export_name);
> +
> +        if (nbd_negotiate_drop_sync(client->ioc, tail) != tail) {
export_name is leaked on this path

> +            return -EIO;
> +        }
> +        ret = nbd_negotiate_send_rep_err(client->ioc, NBD_REP_ERR_INVALID, opt,
> +                                         "export '%s' is not found",
> +                                         export_name);
> +        g_free(export_name);
> +
