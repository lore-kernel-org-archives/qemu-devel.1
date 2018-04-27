Received: from eggs.gnu.org ([2001:4830:134:3::10]:54203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fC3LA-00062c-ME
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:23:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fC3L9-0006cS-O0
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:23:08 -0400
References: <20180312152126.286890-1-vsementsov@virtuozzo.com>
	<20180312152126.286890-6-vsementsov@virtuozzo.com>
	<CAFEAcA-D3oi4Q0UyV8iim-r5sP5YO=qsxseHi5vPTuXF6_BgkQ@mail.gmail.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4fa51d75-4d62-1fe6-65c5-7ddf1585ca7c@virtuozzo.com>
Date: Fri, 27 Apr 2018 16:22:55 +0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-D3oi4Q0UyV8iim-r5sP5YO=qsxseHi5vPTuXF6_BgkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>

27.04.2018 15:50, Peter Maydell wrote:
> On 12 March 2018 at 15:21, Vladimir Sementsov-Ogievskiy
> <vsementsov@virtuozzo.com> wrote:
>> Minimal realization: only one extent in server answer is supported.
>> Flag NBD_CMD_FLAG_REQ_ONE is used to force this behavior.
> Hi; Coverity complains about a possible use of uninitialized
> variables in this function (CID 1390607, 1390611):
>
>> +static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
>> +                                             const char *export,
>> +                                             const char *context,
>> +                                             uint32_t *context_id,
>> +                                             Error **errp)
>> +{
>> +    int ret;
>> +    NBDOptionReply reply;
>> +    uint32_t received_id;
>> +    bool received;
> We declare received_id and received without initializing them...
>
>> +    uint32_t export_len = strlen(export);
>> +    uint32_t context_len = strlen(context);
>> +    uint32_t data_len = sizeof(export_len) + export_len +
>> +                        sizeof(uint32_t) + /* number of queries */
>> +                        sizeof(context_len) + context_len;
>> +    char *data = g_malloc(data_len);
>> +    char *p = data;
>> +
>> +    stl_be_p(p, export_len);
>> +    memcpy(p += sizeof(export_len), export, export_len);
>> +    stl_be_p(p += export_len, 1);
>> +    stl_be_p(p += sizeof(uint32_t), context_len);
>> +    memcpy(p += sizeof(context_len), context, context_len);
>> +
>> +    ret = nbd_send_option_request(ioc, NBD_OPT_SET_META_CONTEXT, data_len, data,
>> +                                  errp);
>> +    g_free(data);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    if (nbd_receive_option_reply(ioc, NBD_OPT_SET_META_CONTEXT, &reply,
>> +                                 errp) < 0)
>> +    {
>> +        return -1;
>> +    }
>> +
>> +    ret = nbd_handle_reply_err(ioc, &reply, errp);
>> +    if (ret <= 0) {
>> +        return ret;
>> +    }
>> +
>> +    if (reply.type == NBD_REP_META_CONTEXT) {
> ...and if we don't take this code path we don't ever initialize
> received...
>
>> +        char *name;
>> +        size_t len;
>> +
>> +        if (nbd_read(ioc, &received_id, sizeof(received_id), errp) < 0) {
>> +            return -EIO;
>> +        }
>> +        be32_to_cpus(&received_id);
>> +
>> +        len = reply.length - sizeof(received_id);
>> +        name = g_malloc(len + 1);
>> +        if (nbd_read(ioc, name, len, errp) < 0) {
>> +            g_free(name);
>> +            return -EIO;
>> +        }
>> +        name[len] = '\0';
>> +        if (strcmp(context, name)) {
>> +            error_setg(errp, "Failed to negotiate meta context '%s', server "
>> +                       "answered with different context '%s'", context,
>> +                       name);
>> +            g_free(name);
>> +            return -1;
>> +        }
>> +        g_free(name);
>> +
>> +        received = true;
>> +
>> +        /* receive NBD_REP_ACK */
>> +        if (nbd_receive_option_reply(ioc, NBD_OPT_SET_META_CONTEXT, &reply,
>> +                                     errp) < 0)
>> +        {
>> +            return -1;
>> +        }
>> +
>> +        ret = nbd_handle_reply_err(ioc, &reply, errp);
>> +        if (ret <= 0) {
>> +            return ret;
>> +        }
>> +    }
>> +
>> +    if (reply.type != NBD_REP_ACK) {
>> +        error_setg(errp, "Unexpected reply type %" PRIx32 " expected %x",
>> +                   reply.type, NBD_REP_ACK);
>> +        return -1;
>> +    }
>> +
>> +    if (received) {
>> +        *context_id = received_id;
> ...so we might use both received and received_id uninitialized here.
>
>> +        return 1;
>> +    }
>> +
>> +    return 0;
>> +}
> My guess is that the correct fix is just to initialize received
> with "bool received = false;". Coverity should then be able to figure
> out that we don't touch received_id unless we initialized it.

Yes, looks like a bug. I'll send a patch.

>
> thanks
> -- PMM


-- 
Best regards,
Vladimir
