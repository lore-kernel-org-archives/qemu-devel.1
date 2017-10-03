Received: from eggs.gnu.org ([2001:4830:134:3::10]:60078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dzJzP-0002UT-3d
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dzJzL-0005GS-Np
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:59:47 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:14565 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dzJzK-0005CW-Tm
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:59:43 -0400
References: <407cbf8e-3854-e657-deb7-03d5c808bd82@virtuozzo.com>
	<20170927151008.53763-1-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <153ee259-26fb-f42f-1ea6-ce00e6869b6e@virtuozzo.com>
Date: Tue, 3 Oct 2017 12:59:31 +0300
MIME-Version: 1.0
In-Reply-To: <20170927151008.53763-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v1.1 DRAFT] nbd: Minimal structured read
 for client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

Eric?


27.09.2017 18:10, Vladimir Sementsov-Ogievskiy wrote:
> Minimal implementation: drop most of additional error information.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>
> Hi!
>
> Here is a draft of how to refactor reply-payload receiving if you don't
> like my previous simple (but not flexible) try. Ofcourse, if we agree on this
> approach this patch should be splitted into several ones and many things
> (error handling) should be improved.
>
> The idea is:
>
> nbd_read_reply_entry reads only reply header through nbd/client.c code.
>
> Then, the payload is read through block/nbd-client-cmds.c:
> simple payload: generic per-command handler, however it should only exist
>    for CMD_READ
> structured NONE: no payload, handle in nbd_co_receive_one_chunk
> structured error: read by nbd_handle_structured_error_payload
>    defined in block/nbd-client-cmds.c
> structured success: read by per-[command X reply-type] handler
>    defined in block/nbd-client-cmds.c
>
> For now nbd-client-cmds.c looks more like nbd-payload.c, but, may be, we
> should move command sending special-casing (CMD_WRITE) to it too..
>
> Don't waste time on careful reviewing this patch, let's consider first
> the concept of nbd-client-cmds.c,
>
>   block/nbd-client.h      |  10 +++
>   include/block/nbd.h     |  82 ++++++++++++++++--
>   nbd/nbd-internal.h      |  25 ------
>   block/nbd-client-cmds.c | 220 ++++++++++++++++++++++++++++++++++++++++++++++++
>   block/nbd-client.c      | 118 ++++++++++++++++++++------
>   nbd/client.c            | 128 ++++++++++++++++------------
>   block/Makefile.objs     |   2 +-
>   7 files changed, 475 insertions(+), 110 deletions(-)
>   create mode 100644 block/nbd-client-cmds.c
>
> diff --git a/block/nbd-client.h b/block/nbd-client.h
> index b435754b82..abb88e4ea5 100644
> --- a/block/nbd-client.h
> +++ b/block/nbd-client.h
> @@ -35,6 +35,8 @@ typedef struct NBDClientSession {
>       NBDClientRequest requests[MAX_NBD_REQUESTS];
>       NBDReply reply;
>       bool quit;
> +
> +    bool structured_reply;
>   } NBDClientSession;
>   
>   NBDClientSession *nbd_get_client_session(BlockDriverState *bs);
> @@ -60,4 +62,12 @@ void nbd_client_detach_aio_context(BlockDriverState *bs);
>   void nbd_client_attach_aio_context(BlockDriverState *bs,
>                                      AioContext *new_context);
>   
> +int nbd_handle_structured_payload(QIOChannel *ioc, int cmd,
> +                                  NBDStructuredReplyChunk *reply, void *opaque);
> +int nbd_handle_simple_payload(QIOChannel *ioc, int cmd, void *opaque);
> +
> +int nbd_handle_structured_error_payload(QIOChannel *ioc,
> +                                        NBDStructuredReplyChunk *reply,
> +                                        int *request_ret);
> +
>   #endif /* NBD_CLIENT_H */
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index 314f2f9bbc..b9a4e1dfa9 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -57,12 +57,6 @@ struct NBDRequest {
>   };
>   typedef struct NBDRequest NBDRequest;
>   
> -struct NBDReply {
> -    uint64_t handle;
> -    uint32_t error;
> -};
> -typedef struct NBDReply NBDReply;
> -
>   typedef struct NBDSimpleReply {
>       uint32_t magic;  /* NBD_SIMPLE_REPLY_MAGIC */
>       uint32_t error;
> @@ -77,6 +71,24 @@ typedef struct NBDStructuredReplyChunk {
>       uint32_t length; /* length of payload */
>   } QEMU_PACKED NBDStructuredReplyChunk;
>   
> +typedef union NBDReply {
> +    NBDSimpleReply simple;
> +    NBDStructuredReplyChunk structured;
> +    struct {
> +        uint32_t magic;
> +        uint32_t _skip;
> +        uint64_t handle;
> +    } QEMU_PACKED;
> +} NBDReply;
> +
> +#define NBD_SIMPLE_REPLY_MAGIC      0x67446698
> +#define NBD_STRUCTURED_REPLY_MAGIC  0x668e33ef
> +
> +static inline bool nbd_reply_is_simple(NBDReply *reply)
> +{
> +    return reply->magic == NBD_SIMPLE_REPLY_MAGIC;
> +}
> +
>   typedef struct NBDStructuredRead {
>       NBDStructuredReplyChunk h;
>       uint64_t offset;
> @@ -88,6 +100,11 @@ typedef struct NBDStructuredError {
>       uint16_t message_length;
>   } QEMU_PACKED NBDStructuredError;
>   
> +typedef struct NBDPayloadOffsetHole {
> +    uint64_t offset;
> +    uint32_t hole_size;
> +} QEMU_PACKED NBDPayloadOffsetHole;
> +
>   /* Transmission (export) flags: sent from server to client during handshake,
>      but describe what will happen during transmission */
>   #define NBD_FLAG_HAS_FLAGS         (1 << 0) /* Flags are there */
> @@ -178,12 +195,54 @@ enum {
>   
>   #define NBD_SREP_TYPE_NONE          0
>   #define NBD_SREP_TYPE_OFFSET_DATA   1
> +#define NBD_SREP_TYPE_OFFSET_HOLE   2
>   #define NBD_SREP_TYPE_ERROR         NBD_SREP_ERR(1)
> +#define NBD_SREP_TYPE_ERROR_OFFSET  NBD_SREP_ERR(2)
> +
> +static inline bool nbd_srep_type_is_error(int type)
> +{
> +    return type & (1 << 15);
> +}
> +
> +/* NBD errors are based on errno numbers, so there is a 1:1 mapping,
> + * but only a limited set of errno values is specified in the protocol.
> + * Everything else is squashed to EINVAL.
> + */
> +#define NBD_SUCCESS    0
> +#define NBD_EPERM      1
> +#define NBD_EIO        5
> +#define NBD_ENOMEM     12
> +#define NBD_EINVAL     22
> +#define NBD_ENOSPC     28
> +#define NBD_ESHUTDOWN  108
> +
> +static inline int nbd_errno_to_system_errno(int err)
> +{
> +    switch (err) {
> +    case NBD_SUCCESS:
> +        return 0;
> +    case NBD_EPERM:
> +        return EPERM;
> +    case NBD_EIO:
> +        return EIO;
> +    case NBD_ENOMEM:
> +        return ENOMEM;
> +    case NBD_ENOSPC:
> +        return ENOSPC;
> +    case NBD_ESHUTDOWN:
> +        return ESHUTDOWN;
> +    case NBD_EINVAL:
> +        return EINVAL;
> +    }
> +
> +    return EINVAL;
> +}
>   
>   /* Details collected by NBD_OPT_EXPORT_NAME and NBD_OPT_GO */
>   struct NBDExportInfo {
>       /* Set by client before nbd_receive_negotiate() */
>       bool request_sizes;
> +    bool structured_reply;
>       /* Set by server results during nbd_receive_negotiate() */
>       uint64_t size;
>       uint16_t flags;
> @@ -233,4 +292,15 @@ void nbd_client_put(NBDClient *client);
>   void nbd_server_start(SocketAddress *addr, const char *tls_creds,
>                         Error **errp);
>   
> +/* nbd_read
> + * Reads @size bytes from @ioc. Returns 0 on success.
> + */
> +static inline int nbd_read(QIOChannel *ioc, void *buffer, size_t size,
> +                           Error **errp)
> +{
> +    return qio_channel_read_all(ioc, buffer, size, errp) < 0 ? -EIO : 0;
> +}
> +
> +int nbd_drop(QIOChannel *ioc, size_t size, Error **errp);
> +
>   #endif
> diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
> index 6b0d1183ba..9f7b6b68e8 100644
> --- a/nbd/nbd-internal.h
> +++ b/nbd/nbd-internal.h
> @@ -47,8 +47,6 @@
>   #define NBD_OLDSTYLE_NEGOTIATE_SIZE (8 + 8 + 8 + 4 + 124)
>   
>   #define NBD_REQUEST_MAGIC           0x25609513
> -#define NBD_SIMPLE_REPLY_MAGIC      0x67446698
> -#define NBD_STRUCTURED_REPLY_MAGIC  0x668e33ef
>   #define NBD_OPTS_MAGIC              0x49484156454F5054LL
>   #define NBD_CLIENT_MAGIC            0x0000420281861253LL
>   #define NBD_REP_MAGIC               0x0003e889045565a9LL
> @@ -65,18 +63,6 @@
>   #define NBD_SET_TIMEOUT             _IO(0xab, 9)
>   #define NBD_SET_FLAGS               _IO(0xab, 10)
>   
> -/* NBD errors are based on errno numbers, so there is a 1:1 mapping,
> - * but only a limited set of errno values is specified in the protocol.
> - * Everything else is squashed to EINVAL.
> - */
> -#define NBD_SUCCESS    0
> -#define NBD_EPERM      1
> -#define NBD_EIO        5
> -#define NBD_ENOMEM     12
> -#define NBD_EINVAL     22
> -#define NBD_ENOSPC     28
> -#define NBD_ESHUTDOWN  108
> -
>   /* nbd_read_eof
>    * Tries to read @size bytes from @ioc.
>    * Returns 1 on success
> @@ -96,15 +82,6 @@ static inline int nbd_read_eof(QIOChannel *ioc, void *buffer, size_t size,
>       return ret;
>   }
>   
> -/* nbd_read
> - * Reads @size bytes from @ioc. Returns 0 on success.
> - */
> -static inline int nbd_read(QIOChannel *ioc, void *buffer, size_t size,
> -                           Error **errp)
> -{
> -    return qio_channel_read_all(ioc, buffer, size, errp) < 0 ? -EIO : 0;
> -}
> -
>   /* nbd_write
>    * Writes @size bytes to @ioc. Returns 0 on success.
>    */
> @@ -137,6 +114,4 @@ const char *nbd_rep_lookup(uint32_t rep);
>   const char *nbd_info_lookup(uint16_t info);
>   const char *nbd_cmd_lookup(uint16_t info);
>   
> -int nbd_drop(QIOChannel *ioc, size_t size, Error **errp);
> -
>   #endif
> diff --git a/block/nbd-client-cmds.c b/block/nbd-client-cmds.c
> new file mode 100644
> index 0000000000..488a3dc267
> --- /dev/null
> +++ b/block/nbd-client-cmds.c
> @@ -0,0 +1,220 @@
> +/*
> + * QEMU Block driver for NBD
> + *
> + * Copyright (c) 2017 Parallels International GmbH
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "nbd-client.h"
> +
> +
> +typedef int (*NBDCommandFn)(QIOChannel *ioc,
> +                            NBDStructuredReplyChunk *chunk,
> +                            void *opaque);
> +typedef struct NBDCommand {
> +    int (*read_simple_payload)(QIOChannel *ioc, void *opaque);
> +    NBDCommandFn read_offset_data;
> +    NBDCommandFn read_offset_hole;
> +} NBDCommand;
> +
> +static int nbd_cmd_read__siple_payload(QIOChannel *ioc, void *opaque)
> +{
> +    QEMUIOVector *qiov = (QEMUIOVector *)opaque;
> +    return qio_channel_readv_all(ioc, qiov->iov, qiov->niov, NULL);
> +}
> +
> +static int nbd_cmd_read__offset_data(QIOChannel *ioc,
> +                                     NBDStructuredReplyChunk *chunk,
> +                                     void *opaque)
> +{
> +    QEMUIOVector *qiov = (QEMUIOVector *)opaque;
> +    QEMUIOVector sub_qiov;
> +    uint64_t offset;
> +    size_t data_size;
> +    int ret;
> +
> +    if (chunk->length < sizeof(offset)) {
> +        return -1;
> +    }
> +
> +    if (nbd_read(ioc, &offset, sizeof(offset), NULL) < 0) {
> +        return -1;
> +    }
> +    be64_to_cpus(&offset);
> +
> +    data_size = chunk->length - sizeof(offset);
> +    if (offset + data_size > qiov->size) {
> +        return -1;
> +    }
> +
> +    qemu_iovec_init(&sub_qiov, qiov->niov);
> +    qemu_iovec_concat(&sub_qiov, qiov, offset, data_size);
> +    ret = qio_channel_readv_all(ioc, sub_qiov.iov, sub_qiov.niov, NULL);
> +    qemu_iovec_destroy(&sub_qiov);
> +
> +    return ret;
> +}
> +
> +static int nbd_cmd_read__offset_hole(QIOChannel *ioc,
> +                                     NBDStructuredReplyChunk *chunk,
> +                                     void *opaque)
> +{
> +    QEMUIOVector *qiov = (QEMUIOVector *)opaque;
> +    NBDPayloadOffsetHole pl;
> +
> +    if (chunk->length != sizeof(pl)) {
> +        return -1;
> +    }
> +
> +    if (nbd_read(ioc, &pl, sizeof(pl), NULL) < 0) {
> +        return -1;
> +    }
> +
> +    be64_to_cpus(&pl.offset);
> +    be32_to_cpus(&pl.hole_size);
> +
> +    if (pl.offset + pl.hole_size > qiov->size) {
> +        return -1;
> +    }
> +
> +    qemu_iovec_memset(qiov, pl.offset, 0, pl.hole_size);
> +
> +    return 0;
> +}
> +
> +NBDCommand nbd_cmd_read = {
> +    .read_simple_payload = nbd_cmd_read__siple_payload,
> +    .read_offset_data = nbd_cmd_read__offset_data,
> +    .read_offset_hole = nbd_cmd_read__offset_hole,
> +};
> +
> +static NBDCommand *nbd_get_cmd(int cmd)
> +{
> +    switch (cmd) {
> +    case NBD_CMD_READ:
> +        return &nbd_cmd_read;
> +    }
> +
> +    return NULL;
> +}
> +
> +static NBDCommandFn nbd_cmd_get_handler(int cmd, int reply_type)
> +{
> +    NBDCommand *command = nbd_get_cmd(cmd);
> +
> +    if (command == NULL) {
> +        return NULL;
> +    }
> +
> +    switch (reply_type) {
> +    case NBD_SREP_TYPE_OFFSET_DATA:
> +        return command->read_offset_data;
> +    case NBD_SREP_TYPE_OFFSET_HOLE:
> +        return command->read_offset_hole;
> +    }
> +
> +    return NULL;
> +}
> +
> +/* nbd_handle_structured_payload
> + * Find corresponding handler and call it.
> + * If not found return -1 (fail)
> + */
> +int nbd_handle_structured_payload(QIOChannel *ioc, int cmd, NBDStructuredReplyChunk *chunk,
> +                                  void *opaque)
> +{
> +    NBDCommandFn fn = nbd_cmd_get_handler(cmd, chunk->type);
> +
> +    if (fn == NULL) {
> +        return -1;
> +    }
> +
> +    return fn(ioc, chunk, opaque);
> +}
> +
> +/* nbd_handle_simple_payload
> + * Find corresponding handler and call it.
> + * If not found return 0 (success)
> + */
> +int nbd_handle_simple_payload(QIOChannel *ioc, int cmd, void *opaque)
> +{
> +    NBDCommand *command = nbd_get_cmd(cmd);
> +
> +    if (command == NULL || command->read_simple_payload == NULL) {
> +        return 0;
> +    }
> +
> +    return command->read_simple_payload(ioc, opaque);
> +}
> +
> +int nbd_handle_structured_error_payload(QIOChannel *ioc, NBDStructuredReplyChunk *chunk,
> +                                        int *request_ret)
> +{
> +    uint32_t error;
> +    uint16_t message_size;
> +    int ret;
> +    assert(chunk->type & (1 << 15));
> +
> +    switch (chunk->type) {
> +    case NBD_SREP_TYPE_ERROR:
> +    case NBD_SREP_TYPE_ERROR_OFFSET:
> +        ret = nbd_read(ioc, &error, sizeof(error), NULL);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +        be32_to_cpus(&error);
> +
> +        ret = nbd_read(ioc, &message_size, sizeof(message_size), NULL);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +        be16_to_cpus(&message_size);
> +
> +        if (message_size > 0) {
> +            /* TODO: provide error message to user */
> +            ret = nbd_drop(ioc, message_size, NULL);
> +            if (ret < 0) {
> +                return ret;
> +            }
> +        }
> +
> +        if (chunk->type == NBD_SREP_TYPE_ERROR_OFFSET) {
> +            /* drop 64bit offset */
> +            ret = nbd_drop(ioc, 8, NULL);
> +            if (ret < 0) {
> +                return ret;
> +            }
> +        }
> +        break;
> +    default:
> +        /* unknown error */
> +        ret = nbd_drop(ioc, chunk->length, NULL);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +
> +        error = NBD_EINVAL;
> +    }
> +
> +    *request_ret = nbd_errno_to_system_errno(error);
> +    return 0;
> +}
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index e4f0c789f4..cf80564a83 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -179,9 +179,9 @@ err:
>       return rc;
>   }
>   
> -static int nbd_co_receive_reply(NBDClientSession *s,
> -                                uint64_t handle,
> -                                QEMUIOVector *qiov)
> +static int nbd_co_receive_one_chunk(NBDClientSession *s, uint64_t handle,
> +                                    int request_cmd, void *request_opaque,
> +                                    bool *cont)
>   {
>       int ret;
>       int i = HANDLE_TO_INDEX(s, handle);
> @@ -191,29 +191,93 @@ static int nbd_co_receive_reply(NBDClientSession *s,
>       qemu_coroutine_yield();
>       s->requests[i].receiving = false;
>       if (!s->ioc || s->quit) {
> -        ret = -EIO;
> -    } else {
> -        assert(s->reply.handle == handle);
> -        ret = -s->reply.error;
> -        if (qiov && s->reply.error == 0) {
> -            if (qio_channel_readv_all(s->ioc, qiov->iov, qiov->niov,
> -                                      NULL) < 0) {
> -                ret = -EIO;
> -                s->quit = true;
> +        *cont = false;
> +        return -EIO;
> +    }
> +
> +    assert(s->reply.handle == handle);
> +
> +    if (nbd_reply_is_simple(&s->reply)) {
> +        *cont = false;
> +        ret = -s->reply.simple.error;
> +        if (s->structured_reply && request_cmd == NBD_CMD_READ) {
> +            goto fatal;
> +        }
> +        if (ret == 0) {
> +            if (nbd_handle_simple_payload(s->ioc, request_cmd,
> +                                          request_opaque) < 0)
> +            {
> +                goto fatal;
>               }
>           }
> +        goto out;
> +    }
> +
> +    /* handle structured reply chunk */
> +
> +    *cont = !(s->reply.structured.flags & NBD_SREP_FLAG_DONE);
>   
> -        /* Tell the read handler to read another header.  */
> -        s->reply.handle = 0;
> +    if (s->reply.structured.type == NBD_SREP_TYPE_NONE) {
> +        goto out;
>       }
>   
> -    s->requests[i].coroutine = NULL;
> +    if (nbd_srep_type_is_error(s->reply.structured.type)) {
> +        if (nbd_handle_structured_error_payload(s->ioc, &s->reply.structured,
> +                                                &ret) < 0)
> +        {
> +            goto fatal;
> +        }
> +        goto out;
> +    }
> +
> +    /* here we deal with successful not-NONE structured reply */
> +    if (nbd_handle_structured_payload(s->ioc, request_cmd,
> +                                      &s->reply.structured,
> +                                      request_opaque) < 0)
> +    {
> +        goto fatal;
> +    }
> +
> +out:
> +    /* For assert at loop start in nbd_read_reply_entry */
> +    s->reply.handle = 0;
>   
> -    /* Kick the read_reply_co to get the next reply.  */
>       if (s->read_reply_co) {
>           aio_co_wake(s->read_reply_co);
>       }
>   
> +    return ret;
> +
> +fatal:
> +    /* protocol or ioc failure */
> +    *cont = false;
> +    s->quit = true;
> +    if (s->read_reply_co) {
> +        aio_co_wake(s->read_reply_co);
> +    }
> +
> +    return -EIO;
> +}
> +
> +static int nbd_co_receive_reply(NBDClientSession *s,
> +                                uint64_t handle,
> +                                int request_cmd,
> +                                void *request_opaque)
> +{
> +    int ret = 0;
> +    int i = HANDLE_TO_INDEX(s, handle);
> +    bool cont = true;
> +
> +    while (cont) {
> +        int rc = nbd_co_receive_one_chunk(s, handle, request_cmd,
> +                                          request_opaque, &cont);
> +        if (rc < 0 && ret == 0) {
> +            ret = rc;
> +        }
> +    }
> +
> +    s->requests[i].coroutine = NULL;
> +
>       qemu_co_mutex_lock(&s->send_mutex);
>       s->in_flight--;
>       qemu_co_queue_next(&s->free_sema);
> @@ -224,22 +288,28 @@ static int nbd_co_receive_reply(NBDClientSession *s,
>   
>   static int nbd_co_request(BlockDriverState *bs,
>                             NBDRequest *request,
> -                          QEMUIOVector *qiov)
> +                          void *request_opaque)
>   {
>       NBDClientSession *client = nbd_get_client_session(bs);
>       int ret;
> +    QEMUIOVector *send_qiov = NULL;
> +
> +    if (request->type == NBD_CMD_WRITE) {
> +        /* TODO: move request sending special casing to nbd-client-cmds.c like
> +         * receiving part. */
> +        send_qiov = request_opaque;
> +        request_opaque = NULL;
> +        assert(send_qiov &&
> +               request->len == iov_size(send_qiov->iov, send_qiov->niov));
> +    }
>   
> -    assert(!qiov || request->type == NBD_CMD_WRITE ||
> -           request->type == NBD_CMD_READ);
> -    assert(!qiov || request->len == iov_size(qiov->iov, qiov->niov));
> -    ret = nbd_co_send_request(bs, request,
> -                              request->type == NBD_CMD_WRITE ? qiov : NULL);
> +    ret = nbd_co_send_request(bs, request, send_qiov);
>       if (ret < 0) {
>           return ret;
>       }
>   
> -    return nbd_co_receive_reply(client, request->handle,
> -                                request->type == NBD_CMD_READ ? qiov : NULL);
> +    return nbd_co_receive_reply(client, request->handle, request->type,
> +                                request_opaque);
>   }
>   
>   int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
> diff --git a/nbd/client.c b/nbd/client.c
> index 51ae492e92..d0e9b8f138 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -22,38 +22,6 @@
>   #include "trace.h"
>   #include "nbd-internal.h"
>   
> -static int nbd_errno_to_system_errno(int err)
> -{
> -    int ret;
> -    switch (err) {
> -    case NBD_SUCCESS:
> -        ret = 0;
> -        break;
> -    case NBD_EPERM:
> -        ret = EPERM;
> -        break;
> -    case NBD_EIO:
> -        ret = EIO;
> -        break;
> -    case NBD_ENOMEM:
> -        ret = ENOMEM;
> -        break;
> -    case NBD_ENOSPC:
> -        ret = ENOSPC;
> -        break;
> -    case NBD_ESHUTDOWN:
> -        ret = ESHUTDOWN;
> -        break;
> -    default:
> -        trace_nbd_unknown_error(err);
> -        /* fallthrough */
> -    case NBD_EINVAL:
> -        ret = EINVAL;
> -        break;
> -    }
> -    return ret;
> -}
> -
>   /* Definitions for opaque data types */
>   
>   static QTAILQ_HEAD(, NBDExport) exports = QTAILQ_HEAD_INITIALIZER(exports);
> @@ -719,6 +687,13 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
>           if (fixedNewStyle) {
>               int result;
>   
> +            result = nbd_request_simple_option(ioc, NBD_OPT_STRUCTURED_REPLY,
> +                                               errp);
> +            if (result < 0) {
> +                goto fail;
> +            }
> +            info->structured_reply = result > 0;
> +
>               /* Try NBD_OPT_GO first - if it works, we are done (it
>                * also gives us a good message if the server requires
>                * TLS).  If it is not available, fall back to
> @@ -759,6 +734,12 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
>               goto fail;
>           }
>           be16_to_cpus(&info->flags);
> +
> +        if (info->structured_reply && !(info->flags & NBD_CMD_FLAG_DF)) {
> +            error_setg(errp, "Structured reply is negotiated, "
> +                             "but DF flag is not.");
> +            goto fail;
> +        }
>       } else if (magic == NBD_CLIENT_MAGIC) {
>           uint32_t oldflags;
>   
> @@ -942,6 +923,46 @@ int nbd_send_request(QIOChannel *ioc, NBDRequest *request)
>       return nbd_write(ioc, buf, sizeof(buf), NULL);
>   }
>   
> +/* nbd_receive_simple_reply
> + * Read simple reply except magic field (which should be already read)
> + */
> +static int nbd_receive_simple_reply(QIOChannel *ioc, NBDSimpleReply *reply,
> +                                   Error **errp)
> +{
> +    int ret = nbd_read(ioc, (uint8_t *)reply + sizeof(reply->magic),
> +                       sizeof(*reply) - sizeof(reply->magic), errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    be32_to_cpus(&reply->error);
> +    be64_to_cpus(&reply->handle);
> +
> +    return 0;
> +}
> +
> +/* nbd_receive_structured_reply_chunk
> + * Read structured reply chunk except magic field (which should be already read)
> + * Payload is not read.
> + */
> +static int nbd_receive_structured_reply_chunk(QIOChannel *ioc,
> +                                              NBDStructuredReplyChunk *chunk,
> +                                              Error **errp)
> +{
> +    int ret = nbd_read(ioc, (uint8_t *)chunk + sizeof(chunk->magic),
> +                       sizeof(*chunk) - sizeof(chunk->magic), errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    be16_to_cpus(&chunk->flags);
> +    be16_to_cpus(&chunk->type);
> +    be64_to_cpus(&chunk->handle);
> +    be32_to_cpus(&chunk->length);
> +
> +    return 0;
> +}
> +
>   /* nbd_receive_reply
>    * Returns 1 on success
>    *         0 on eof, when no data was read (errp is not set)
> @@ -949,39 +970,38 @@ int nbd_send_request(QIOChannel *ioc, NBDRequest *request)
>    */
>   int nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
>   {
> -    uint8_t buf[NBD_REPLY_SIZE];
> -    uint32_t magic;
>       int ret;
>   
> -    ret = nbd_read_eof(ioc, buf, sizeof(buf), errp);
> +    ret = nbd_read_eof(ioc, &reply->magic, sizeof(reply->magic), errp);
>       if (ret <= 0) {
>           return ret;
>       }
>   
> -    /* Reply
> -       [ 0 ..  3]    magic   (NBD_SIMPLE_REPLY_MAGIC)
> -       [ 4 ..  7]    error   (0 == no error)
> -       [ 7 .. 15]    handle
> -     */
> +    be32_to_cpus(&reply->magic);
>   
> -    magic = ldl_be_p(buf);
> -    reply->error  = ldl_be_p(buf + 4);
> -    reply->handle = ldq_be_p(buf + 8);
> +    switch (reply->magic) {
> +    case NBD_SIMPLE_REPLY_MAGIC:
> +        ret = nbd_receive_simple_reply(ioc, &reply->simple, errp);
> +        reply->simple.error = nbd_errno_to_system_errno(reply->simple.error);
>   
> -    reply->error = nbd_errno_to_system_errno(reply->error);
> -
> -    if (reply->error == ESHUTDOWN) {
> -        /* This works even on mingw which lacks a native ESHUTDOWN */
> -        error_setg(errp, "server shutting down");
> +        if (reply->simple.error == ESHUTDOWN) {
> +            /* This works even on mingw which lacks a native ESHUTDOWN */
> +            error_setg(errp, "server shutting down");
> +            return -EINVAL;
> +        }
> +        trace_nbd_receive_reply(reply->magic, reply->simple.error,
> +                                reply->simple.handle);
> +        break;
> +    case NBD_STRUCTURED_REPLY_MAGIC:
> +        ret = nbd_receive_structured_reply_chunk(ioc, &reply->structured, errp);
> +        break;
> +    default:
> +        error_setg(errp, "invalid magic (got 0x%" PRIx32 ")", reply->magic);
>           return -EINVAL;
>       }
> -    trace_nbd_receive_reply(magic, reply->error, reply->handle);
> -
> -    if (magic != NBD_SIMPLE_REPLY_MAGIC) {
> -        error_setg(errp, "invalid magic (got 0x%" PRIx32 ")", magic);
> -        return -EINVAL;
> +    if (ret < 0) {
> +        return ret;
>       }
>   
>       return 1;
>   }
> -
> diff --git a/block/Makefile.objs b/block/Makefile.objs
> index 6eaf78a046..c99420f42b 100644
> --- a/block/Makefile.objs
> +++ b/block/Makefile.objs
> @@ -12,7 +12,7 @@ block-obj-$(CONFIG_LINUX_AIO) += linux-aio.o
>   block-obj-y += null.o mirror.o commit.o io.o
>   block-obj-y += throttle-groups.o
>   
> -block-obj-y += nbd.o nbd-client.o sheepdog.o
> +block-obj-y += nbd.o nbd-client.o nbd-client-cmds.o sheepdog.o
>   block-obj-$(CONFIG_LIBISCSI) += iscsi.o
>   block-obj-$(if $(CONFIG_LIBISCSI),y,n) += iscsi-opts.o
>   block-obj-$(CONFIG_LIBNFS) += nfs.o


-- 
Best regards,
Vladimir
