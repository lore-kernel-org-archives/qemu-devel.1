Received: from eggs.gnu.org ([2001:4830:134:3::10]:48286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC2pv-00056K-7W
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC2pu-0007rv-5q
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:50:51 -0400
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:46144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC2pu-0007rh-03
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:50:50 -0400
Received: by mail-ot0-x233.google.com with SMTP id t1-v6so1856805ott.13
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 05:50:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180312152126.286890-6-vsementsov@virtuozzo.com>
References: <20180312152126.286890-1-vsementsov@virtuozzo.com>
	<20180312152126.286890-6-vsementsov@virtuozzo.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 13:50:28 +0100
Message-ID: <CAFEAcA-D3oi4Q0UyV8iim-r5sP5YO=qsxseHi5vPTuXF6_BgkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 5/8] nbd: BLOCK_STATUS for standard
 get_block_status function: client part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>

On 12 March 2018 at 15:21, Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
> Minimal realization: only one extent in server answer is supported.
> Flag NBD_CMD_FLAG_REQ_ONE is used to force this behavior.

Hi; Coverity complains about a possible use of uninitialized
variables in this function (CID 1390607, 1390611):

> +static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
> +                                             const char *export,
> +                                             const char *context,
> +                                             uint32_t *context_id,
> +                                             Error **errp)
> +{
> +    int ret;
> +    NBDOptionReply reply;
> +    uint32_t received_id;
> +    bool received;

We declare received_id and received without initializing them...

> +    uint32_t export_len = strlen(export);
> +    uint32_t context_len = strlen(context);
> +    uint32_t data_len = sizeof(export_len) + export_len +
> +                        sizeof(uint32_t) + /* number of queries */
> +                        sizeof(context_len) + context_len;
> +    char *data = g_malloc(data_len);
> +    char *p = data;
> +
> +    stl_be_p(p, export_len);
> +    memcpy(p += sizeof(export_len), export, export_len);
> +    stl_be_p(p += export_len, 1);
> +    stl_be_p(p += sizeof(uint32_t), context_len);
> +    memcpy(p += sizeof(context_len), context, context_len);
> +
> +    ret = nbd_send_option_request(ioc, NBD_OPT_SET_META_CONTEXT, data_len, data,
> +                                  errp);
> +    g_free(data);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    if (nbd_receive_option_reply(ioc, NBD_OPT_SET_META_CONTEXT, &reply,
> +                                 errp) < 0)
> +    {
> +        return -1;
> +    }
> +
> +    ret = nbd_handle_reply_err(ioc, &reply, errp);
> +    if (ret <= 0) {
> +        return ret;
> +    }
> +
> +    if (reply.type == NBD_REP_META_CONTEXT) {

...and if we don't take this code path we don't ever initialize
received...

> +        char *name;
> +        size_t len;
> +
> +        if (nbd_read(ioc, &received_id, sizeof(received_id), errp) < 0) {
> +            return -EIO;
> +        }
> +        be32_to_cpus(&received_id);
> +
> +        len = reply.length - sizeof(received_id);
> +        name = g_malloc(len + 1);
> +        if (nbd_read(ioc, name, len, errp) < 0) {
> +            g_free(name);
> +            return -EIO;
> +        }
> +        name[len] = '\0';
> +        if (strcmp(context, name)) {
> +            error_setg(errp, "Failed to negotiate meta context '%s', server "
> +                       "answered with different context '%s'", context,
> +                       name);
> +            g_free(name);
> +            return -1;
> +        }
> +        g_free(name);
> +
> +        received = true;
> +
> +        /* receive NBD_REP_ACK */
> +        if (nbd_receive_option_reply(ioc, NBD_OPT_SET_META_CONTEXT, &reply,
> +                                     errp) < 0)
> +        {
> +            return -1;
> +        }
> +
> +        ret = nbd_handle_reply_err(ioc, &reply, errp);
> +        if (ret <= 0) {
> +            return ret;
> +        }
> +    }
> +
> +    if (reply.type != NBD_REP_ACK) {
> +        error_setg(errp, "Unexpected reply type %" PRIx32 " expected %x",
> +                   reply.type, NBD_REP_ACK);
> +        return -1;
> +    }
> +
> +    if (received) {
> +        *context_id = received_id;

...so we might use both received and received_id uninitialized here.

> +        return 1;
> +    }
> +
> +    return 0;
> +}

My guess is that the correct fix is just to initialize received
with "bool received = false;". Coverity should then be able to figure
out that we don't touch received_id unless we initialized it.

thanks
-- PMM
