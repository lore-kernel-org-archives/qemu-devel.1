Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D628C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 18:44:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC2C4206D7
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 18:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+DjNEoa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2C4206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkXck-0007cq-2D
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 14:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jkXbq-00076l-JP
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 14:43:58 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:33674)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jkXbo-0001u0-5F
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 14:43:58 -0400
Received: by mail-pl1-x643.google.com with SMTP id 35so524615ple.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2020 11:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=PZA9ofiLxV2yyp8XIhMsfEvOp/KVqZ4Yktm5OtgYBqY=;
 b=U+DjNEoawiy9SDPoQed5gLfp8TMr9km6wQFpg0IngS8YLWcT9rqvimT4toJYhP/9eV
 k7mcteWL9FQ1lq4GcQ7HzFk757Wkwc+oi5jenfK9JIhtWKSt0zy5FrS8Cqm74m0VslQA
 o4bjqxSsSNN4ZKOjW18MbXYYBD0cLagCaLxjtug+bTNZS/3AWz23Mb5Ab6XrdBqJV2Rk
 HPMHUraytKX6H3YtcC2PKxzNBLsGDvmTaCGwFPy//S2jE5EnCVxphctScQbD+6liBMes
 ebmpqo1oNrkZoKpCnrcCdRKiDxnEww9ufcVJ9ZPv4ZZvtiM6cO6oGUL/nmEfQU5dCX/R
 vvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PZA9ofiLxV2yyp8XIhMsfEvOp/KVqZ4Yktm5OtgYBqY=;
 b=IMGU6G/13H7sfW+cKVR9ZOolsZQD0dDILUT+HXFh916MMSrur5WnwoA0hBK2+/bl7F
 WJKMrupgUqx0tksxghQdGGHY3GYsYN2j0JMKA4AT38aDJ5qvti0+FuDa05y3AktVuFrV
 eEYTki6K29K4UVCjpz9VTgDSMXKZgJ/bMZiSUpim+zPVfqeXf8YXAAsWfxJ5oAErhlqz
 8dllSCN9F/5oSUjcZ+CiM2FHuH6QP4bYtZweHxqKJbcDdRZBNJC3+Dq95MR/19M1DOXc
 vlm2T5+3yt0LoowYVJh4+HqAboHJzHhG4PpZdcJoa4qXeQRITQYqpfDeT1sv5gwNGWw3
 OTOw==
X-Gm-Message-State: AOAM530OKVXwkLCycc16YSDjZ3p134zf2I/x7eLox2t97n0kimK6Gi+/
 ZI/Xk9e7TZkgjYTZdbUeezg=
X-Google-Smtp-Source: ABdhPJx4ZG7nOIL8SLlMpgQcp7iFU6i5VhNxRRwN9PktAH1iOXs7OegLXNZ6rjBvotXCCOOLCE1prQ==
X-Received: by 2002:a17:902:7897:: with SMTP id
 q23mr19877521pll.5.1592160229760; 
 Sun, 14 Jun 2020 11:43:49 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
 by smtp.gmail.com with ESMTPSA id p6sm2505725pfb.152.2020.06.14.11.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2020 11:43:49 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Mon, 15 Jun 2020 02:43:46 +0800
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v8 2/4] generic vhost user server
Message-ID: <20200614184346.iua4zb4xyswkgfnl@r>
References: <20200604233538.256325-1-coiby.xu@gmail.com>
 <20200604233538.256325-3-coiby.xu@gmail.com>
 <20200611131449.GB77457@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200611131449.GB77457@stefanha-x1.localdomain>
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=coiby.xu@gmail.com; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 11, 2020 at 02:14:49PM +0100, Stefan Hajnoczi wrote:
>On Fri, Jun 05, 2020 at 07:35:36AM +0800, Coiby Xu wrote:
>> +static bool coroutine_fn
>> +vu_message_read(VuDev *vu_dev, int conn_fd, VhostUserMsg *vmsg)
>> +{
>> +    struct iovec iov = {
>> +        .iov_base = (char *)vmsg,
>> +        .iov_len = VHOST_USER_HDR_SIZE,
>> +    };
>> +    int rc, read_bytes = 0;
>> +    Error *local_err = NULL;
>> +    /*
>> +     * Store fds/nfds returned from qio_channel_readv_full into
>> +     * temporary variables.
>> +     *
>> +     * VhostUserMsg is a packed structure, gcc will complain about passing
>> +     * pointer to a packed structure member if we pass &VhostUserMsg.fd_num
>> +     * and &VhostUserMsg.fds directly when calling qio_channel_readv_full,
>> +     * thus two temporary variables nfds and fds are used here.
>> +     */
>> +    size_t nfds = 0, nfds_t = 0;
>> +    int *fds = NULL, *fds_t = NULL;
>> +    VuServer *server = container_of(vu_dev, VuServer, vu_dev);
>> +    QIOChannel *ioc = NULL;
>> +
>> +    if (conn_fd == server->sioc->fd) {
>> +        ioc = server->ioc;
>> +    } else {
>> +        /* Slave communication will also use this function to read msg */
>> +        ioc = slave_io_channel(server, conn_fd, &local_err);
>> +    }
>> +
>> +    if (!ioc) {
>> +        error_report_err(local_err);
>> +        goto fail;
>> +    }
>> +
>> +    assert(qemu_in_coroutine());
>> +    do {
>> +        /*
>> +         * qio_channel_readv_full may have short reads, keeping calling it
>> +         * until getting VHOST_USER_HDR_SIZE or 0 bytes in total
>> +         */
>> +        rc = qio_channel_readv_full(ioc, &iov, 1, &fds_t, &nfds_t, &local_err);
>> +        if (rc < 0) {
>> +            if (rc == QIO_CHANNEL_ERR_BLOCK) {
>> +                qio_channel_yield(ioc, G_IO_IN);
>> +                continue;
>> +            } else {
>> +                error_report_err(local_err);
>> +                return false;
>> +            }
>> +        }
>> +        read_bytes += rc;
>> +        if (nfds_t > 0) {
>> +            fds = g_renew(int, fds, nfds + nfds_t);
>> +            memcpy(fds + nfds, fds_t, nfds_t *sizeof(int));
>> +            nfds += nfds_t;
>> +            if (nfds > VHOST_MEMORY_MAX_NREGIONS) {
>> +                error_report("A maximum of %d fds are allowed, "
>> +                             "however got %lu fds now",
>> +                             VHOST_MEMORY_MAX_NREGIONS, nfds);
>> +                goto fail;
>> +            }
>> +            g_free(fds_t);
>
>I'm not sure why the temporary fds[] array is necessary. Copying the fds
>directly into vmsg->fds would be simpler:
>
>  if (nfds + nfds_t > G_N_ELEMENTS(vmsg->fds)) {
>      error_report("A maximum of %d fds are allowed, "
>                   "however got %lu fds now",
>                   VHOST_MEMORY_MAX_NREGIONS, nfds);
>      goto fail;
>  }
>  memcpy(vmsg->fds + nfds, fds_t, nfds_t * sizeof(vds->fds[0]));
>  nfds += nfds_t;
>
>Did I misunderstand how this works?

No, the temporary fds[] array is not necessary. Thank for the
simplication!

>> +        }
>> +        if (read_bytes == VHOST_USER_HDR_SIZE || rc == 0) {
>> +            break;
>> +        }
>> +        iov.iov_base = (char *)vmsg + read_bytes;
>> +        iov.iov_len = VHOST_USER_HDR_SIZE - read_bytes;
>> +    } while (true);
>> +
>> +    vmsg->fd_num = nfds;
>> +    if (nfds > 0) {
>> +        memcpy(vmsg->fds, fds, nfds * sizeof(int));
>> +    }
>> +    g_free(fds);
>> +    /* qio_channel_readv_full will make socket fds blocking, unblock them */
>> +    vmsg_unblock_fds(vmsg);
>> +    if (vmsg->size > sizeof(vmsg->payload)) {
>> +        error_report("Error: too big message request: %d, "
>> +                     "size: vmsg->size: %u, "
>> +                     "while sizeof(vmsg->payload) = %zu",
>> +                     vmsg->request, vmsg->size, sizeof(vmsg->payload));
>> +        goto fail;
>> +    }
>> +
>> +    struct iovec iov_payload = {
>> +        .iov_base = (char *)&vmsg->payload,
>> +        .iov_len = vmsg->size,
>> +    };
>> +    if (vmsg->size) {
>> +        rc = qio_channel_readv_all_eof(ioc, &iov_payload, 1, &local_err);
>> +        if (rc == -1) {
>> +            error_report_err(local_err);
>> +            goto fail;
>> +        }
>> +    }
>> +
>> +    return true;
>> +
>> +fail:
>> +    vmsg_close_fds(vmsg);
>> +
>> +    return false;
>> +}
>> +
>> +
>> +static void vu_client_start(VuServer *server);
>> +static coroutine_fn void vu_client_trip(void *opaque)
>> +{
>> +    VuServer *server = opaque;
>> +
>> +    while (!server->aio_context_changed && server->sioc) {
>> +        vu_dispatch(&server->vu_dev);
>> +    }
>> +
>> +    if (server->aio_context_changed && server->sioc) {
>> +        server->aio_context_changed = false;
>> +        vu_client_start(server);
>> +    }
>> +}
>> +
>> +static void vu_client_start(VuServer *server)
>> +{
>> +    server->co_trip = qemu_coroutine_create(vu_client_trip, server);
>> +    aio_co_enter(server->ctx, server->co_trip);
>> +}
>> +
>> +/*
>> + * a wrapper for vu_kick_cb
>> + *
>> + * since aio_dispatch can only pass one user data pointer to the
>> + * callback function, pack VuDev and pvt into a struct. Then unpack it
>> + * and pass them to vu_kick_cb
>> + */
>> +static void kick_handler(void *opaque)
>> +{
>> +    KickInfo *kick_info = opaque;
>> +    kick_info->cb(kick_info->vu_dev, 0, (void *) kick_info->index);
>> +}
>> +
>> +
>> +static void
>> +set_watch(VuDev *vu_dev, int fd, int vu_evt,
>> +          vu_watch_cb cb, void *pvt)
>> +{
>> +
>> +    VuServer *server = container_of(vu_dev, VuServer, vu_dev);
>> +    g_assert(vu_dev);
>> +    g_assert(fd >= 0);
>> +    long index = (intptr_t) pvt;
>> +    g_assert(cb);
>> +    KickInfo *kick_info = &server->kick_info[index];
>> +    if (!kick_info->cb) {
>> +        kick_info->fd = fd;
>> +        kick_info->cb = cb;
>> +        qemu_set_nonblock(fd);
>> +        aio_set_fd_handler(server->ioc->ctx, fd, false, kick_handler,
>> +                           NULL, NULL, kick_info);
>> +        kick_info->vu_dev = vu_dev;
>> +    }
>> +}
>> +
>> +
>> +static void remove_watch(VuDev *vu_dev, int fd)
>> +{
>> +    VuServer *server;
>> +    int i;
>> +    int index = -1;
>> +    g_assert(vu_dev);
>> +    g_assert(fd >= 0);
>> +
>> +    server = container_of(vu_dev, VuServer, vu_dev);
>> +    for (i = 0; i < vu_dev->max_queues; i++) {
>> +        if (server->kick_info[i].fd == fd) {
>> +            index = i;
>> +            break;
>> +        }
>> +    }
>> +
>> +    if (index == -1) {
>> +        return;
>> +    }
>> +    server->kick_info[i].cb = NULL;
>> +    aio_set_fd_handler(server->ioc->ctx, fd, false, NULL, NULL, NULL, NULL);
>> +}
>> +
>> +
>> +static void vu_accept(QIONetListener *listener, QIOChannelSocket *sioc,
>> +                      gpointer opaque)
>> +{
>> +    VuServer *server = opaque;
>> +
>> +    if (server->sioc) {
>> +        warn_report("Only one vhost-user client is allowed to "
>> +                    "connect the server one time");
>> +        return;
>> +    }
>> +
>> +    if (!vu_init(&server->vu_dev, server->max_queues, sioc->fd, panic_cb,
>> +                 vu_message_read, set_watch, remove_watch, server->vu_iface)) {
>> +        error_report("Failed to initialized libvhost-user");
>> +        return;
>> +    }
>> +
>> +    /*
>> +     * Unset the callback function for network listener to make another
>> +     * vhost-user client keeping waiting until this client disconnects
>> +     */
>> +    qio_net_listener_set_client_func(server->listener,
>> +                                     NULL,
>> +                                     NULL,
>> +                                     NULL);
>> +    server->sioc = sioc;
>> +    server->kick_info = g_new0(KickInfo, server->max_queues);
>
>Where is kick_info freed?
>
>> +    /*
>> +     * Increase the object reference, so cioc will not freed by
>
>s/cioc/sioc/
>
>> +     * qio_net_listener_channel_func which will call object_unref(OBJECT(sioc))
>> +     */
>> +    object_ref(OBJECT(server->sioc));
>> +    qio_channel_set_name(QIO_CHANNEL(sioc), "vhost-user client");
>> +    server->ioc = QIO_CHANNEL(sioc);
>> +    object_ref(OBJECT(server->ioc));
>> +    object_ref(OBJECT(sioc));
>
>Why are there two object_refs for sioc and where is unref called?

Thank you for pointing out the errors regarding memory deallocation and
the typo.
>> +    qio_channel_attach_aio_context(server->ioc, server->ctx);
>> +    qio_channel_set_blocking(QIO_CHANNEL(server->sioc), false, NULL);
>> +    vu_client_start(server);
>> +}
>> +
>> +
>> +void vhost_user_server_stop(VuServer *server)
>> +{
>> +    if (!server) {
>> +        return;
>> +    }
>> +
>> +    if (server->sioc) {
>> +        close_client(server);
>> +        object_unref(OBJECT(server->sioc));
>
>This call is object_unref(NULL) since close_client() does server->sioc =
>NULL.
>
>> +    }
>> +
>> +    if (server->listener) {
>> +        qio_net_listener_disconnect(server->listener);
>> +        object_unref(OBJECT(server->listener));
>> +    }
>> +}
>> +
>> +static void detach_context(VuServer *server)
>> +{
>> +    int i;
>> +    AioContext *ctx = server->ioc->ctx;
>> +    qio_channel_detach_aio_context(server->ioc);
>> +    for (i = 0; i < server->vu_dev.max_queues; i++) {
>> +        if (server->kick_info[i].cb) {
>> +            aio_set_fd_handler(ctx, server->kick_info[i].fd, false, NULL,
>> +                               NULL, NULL, NULL);
>> +        }
>> +    }
>> +}
>> +
>> +static void attach_context(VuServer *server, AioContext *ctx)
>> +{
>> +    int i;
>> +    qio_channel_attach_aio_context(server->ioc, ctx);
>> +    server->aio_context_changed = true;
>> +    if (server->co_trip) {
>> +        aio_co_schedule(ctx, server->co_trip);
>> +    }
>> +    for (i = 0; i < server->vu_dev.max_queues; i++) {
>> +        if (server->kick_info[i].cb) {
>> +            aio_set_fd_handler(ctx, server->kick_info[i].fd, false,
>> +                               kick_handler, NULL, NULL,
>> +                               &server->kick_info[i]);
>> +        }
>> +    }
>> +}
>> +
>> +void vhost_user_server_set_aio_context(AioContext *ctx, VuServer *server)
>> +{
>> +    server->ctx = ctx ? ctx : qemu_get_aio_context();
>> +    if (!server->sioc) {
>> +        return;
>> +    }
>> +    if (ctx) {
>> +        attach_context(server, ctx);
>> +    } else {
>> +        detach_context(server);
>> +    }
>> +}
>> +
>> +
>> +bool vhost_user_server_start(uint16_t max_queues,
>> +                             SocketAddress *socket_addr,
>> +                             AioContext *ctx,
>> +                             VuServer *server,
>> +                             void *device_panic_notifier,
>> +                             const VuDevIface *vu_iface,
>> +                             Error **errp)
>> +{
>> +    server->listener = qio_net_listener_new();
>> +    if (qio_net_listener_open_sync(server->listener, socket_addr, 1,
>> +                                   errp) < 0) {
>> +        goto error;
>> +    }
>> +
>> +    qio_net_listener_set_name(server->listener, "vhost-user-backend-listener");
>> +
>> +    server->vu_iface = vu_iface;
>> +    server->max_queues = max_queues;
>> +    server->ctx = ctx;
>> +    server->device_panic_notifier = device_panic_notifier;
>> +    qio_net_listener_set_client_func(server->listener,
>> +                                     vu_accept,
>> +                                     server,
>> +                                     NULL);
>
>The qio_net_listener_set_client_func() call uses the default
>GMainContext but we have an AioContext *ctx argument. This is
>surprising. I would expect the socket to be handled in the AioContext.
>
>Can you clarify how this should work?
Yes, the vhost-user server will accept new client connections in the
default GMainText. But vhost-user message and kick event will be
processed in the block drive's AIOContext and if the block drive's
AIOContext is changed, these tasks will also be move to the new AIOContext.

Btw, I intended to use chardev to help manage client connections after
limiting one vhost-user server to serve one client one time. But according
to Mark and other people[1], converting all chardev functions to AIO doesn't
seem to be worth the effort.

[1] https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg01485.html


>> +
>> +    return true;
>> +error:
>> +    g_free(server);
>
>It's surprising that this function frees the server argument when an
>error occurs. vhost_user_server_stop() does not free server. I suggest
>letting the caller free server since they own the object.
>
>> +    return false;
>> +}
>> diff --git a/util/vhost-user-server.h b/util/vhost-user-server.h
>> new file mode 100644
>> index 0000000000..4315556b66
>> --- /dev/null
>> +++ b/util/vhost-user-server.h
>> @@ -0,0 +1,59 @@
>> +/*
>> + * Sharing QEMU devices via vhost-user protocol
>> + *
>> + * Author: Coiby Xu <coiby.xu@gmail.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or
>> + * later.  See the COPYING file in the top-level directory.
>> + */
>> +
>> +#ifndef VHOST_USER_SERVER_H
>> +#define VHOST_USER_SERVER_H
>> +
>> +#include "contrib/libvhost-user/libvhost-user.h"
>> +#include "io/channel-socket.h"
>> +#include "io/channel-file.h"
>> +#include "io/net-listener.h"
>> +#include "qemu/error-report.h"
>> +#include "qapi/error.h"
>> +#include "standard-headers/linux/virtio_blk.h"
>> +
>> +typedef struct KickInfo {
>> +    VuDev *vu_dev;
>> +    int fd; /*kick fd*/
>> +    long index; /*queue index*/
>> +    vu_watch_cb cb;
>> +} KickInfo;
>> +
>> +typedef struct VuServer {
>> +    QIONetListener *listener;
>> +    AioContext *ctx;
>> +    void (*device_panic_notifier)(struct VuServer *server) ;
>> +    int max_queues;
>> +    const VuDevIface *vu_iface;
>> +    VuDev vu_dev;
>> +    QIOChannel *ioc; /* The I/O channel with the client */
>> +    QIOChannelSocket *sioc; /* The underlying data channel with the client */
>> +    /* IOChannel for fd provided via VHOST_USER_SET_SLAVE_REQ_FD */
>> +    QIOChannel *ioc_slave;
>> +    QIOChannelSocket *sioc_slave;
>> +    Coroutine *co_trip; /* coroutine for processing VhostUserMsg */
>> +    KickInfo *kick_info; /* an array with the length of the queue number */
>> +    /* restart coroutine co_trip if AIOContext is changed */
>> +    bool aio_context_changed;
>> +} VuServer;
>> +
>> +
>> +bool vhost_user_server_start(uint16_t max_queues,
>> +                             SocketAddress *unix_socket,
>> +                             AioContext *ctx,
>> +                             VuServer *server,
>> +                             void *device_panic_notifier,
>
>Please declare the function pointer type:
>
>typedef void DevicePanicNotifierFn(struct VuServer *server);
>
>Then the argument list can use DevicePanicNotifierFn
>*device_panic_notifier instead of void *.
>
>> +                             const VuDevIface *vu_iface,
>> +                             Error **errp);
>> +
>> +void vhost_user_server_stop(VuServer *server);
>> +
>> +void vhost_user_server_set_aio_context(AioContext *ctx, VuServer *server);
>
>If you send another revision, please make VuServer *server the first
>argument of vhost_user_server_start() and
>vhost_user_server_set_aio_context(). Functions usually have the object
>they act on as the first argument.

Thank you! These issues have been addressed in v9.


--
Best regards,
Coiby

