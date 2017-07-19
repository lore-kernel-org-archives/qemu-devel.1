Received: from eggs.gnu.org ([2001:4830:134:3::10]:60262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dXs4g-00041f-8r
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 12:43:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dXs4d-0007CI-4s
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 12:43:46 -0400
References: <20170707203049.534-1-eblake@redhat.com>
	<20170707203049.534-8-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <5d065e35-6ffd-8db0-f7bb-6be4c01f2a31@virtuozzo.com>
Date: Wed, 19 Jul 2017 19:43:37 +0300
MIME-Version: 1.0
In-Reply-To: <20170707203049.534-8-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v5 7/9] nbd: Implement NBD_OPT_GO on client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@virtuozzo.com, marcandre.lureau@redhat.com, qemu-block@nongnu.org

07.07.2017 23:30, Eric Blake wrote:

[..]

>
> +/* Returns -1 if NBD_OPT_GO proves the export @wantname cannot be
> + * used, 0 if NBD_OPT_GO is unsupported (fall back to NBD_OPT_LIST and
> + * NBD_OPT_EXPORT_NAME in that case), and > 0 if the export is good to
> + * go (with @info populated). */
> +static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
> +                      NBDExportInfo *info, Error **errp)
> +{
> +    nbd_opt_reply reply;
> +    uint32_t len = strlen(wantname);
> +    uint16_t type;
> +    int error;
> +    char *buf;
> +
> +    /* The protocol requires that the server send NBD_INFO_EXPORT with
> +     * a non-zero flags (at least NBD_FLAG_HAS_FLAGS must be set); so
> +     * flags still 0 is a witness of a broken server. */
> +    info->flags = 0;
> +
> +    trace_nbd_opt_go_start(wantname);
> +    buf = g_malloc(4 + len + 2 + 1);
> +    stl_be_p(buf, len);
> +    memcpy(buf + 4, wantname, len);
> +    /* No requests, live with whatever server sends */
> +    stw_be_p(buf + 4 + len, 0);
> +    if (nbd_send_option_request(ioc, NBD_OPT_GO, len + 6, buf, errp) < 0) {
> +        return -1;
> +    }
> +
> +    while (1) {
> +        if (nbd_receive_option_reply(ioc, NBD_OPT_GO, &reply, errp) < 0) {
> +            return -1;
> +        }
> +        error = nbd_handle_reply_err(ioc, &reply, errp);
> +        if (error <= 0) {
> +            return error;
> +        }
> +        len = reply.length;
> +
> +        if (reply.type == NBD_REP_ACK) {
> +            /* Server is done sending info and moved into transmission
> +               phase, but make sure it sent flags */
> +            if (len) {
> +                error_setg(errp, "server sent invalid NBD_REP_ACK");
> +                nbd_send_opt_abort(ioc);

server is already in transmission phase, so we cant send any options 
more, shouldn't CMD_DISC be send here instead?

> +                return -1;
> +            }
> +            if (!info->flags) {
> +                error_setg(errp, "broken server omitted NBD_INFO_EXPORT");
> +                nbd_send_opt_abort(ioc);

and here

> +                return -1;
> +            }
> +            trace_nbd_opt_go_success();
> +            return 1;
> +        }
> +        if (reply.type != NBD_REP_INFO) {
> +            error_setg(errp, "unexpected reply type %" PRIx32 ", expected %x",
> +                       reply.type, NBD_REP_INFO);
> +            nbd_send_opt_abort(ioc);
> +            return -1;
> +        }
> +        if (len < sizeof(type)) {
> +            error_setg(errp, "


-- 
Best regards,
Vladimir
