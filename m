Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3785C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 18:31:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55760208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 18:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eIvbjWnm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55760208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxaZ1-00084B-AX
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 14:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jxaXn-0007SZ-1k
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 14:29:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26943
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jxaXk-0004jU-3O
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 14:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595269778;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ESC7lHJZEWU8baXjgzf9kEzpgGoBQTa40Od5KbPxuos=;
 b=eIvbjWnmD1GAuxLGkDV3npdE6jxhERBbK+ALWv3lPT1WpgkASDYNaxbCDNxI+SiPPSQG1y
 VkhGMoOU72Kn1/TelIHDH/Va3XjvomshEJ+iO/Ed4nW1TGDpxlIyd9SQSxEyJV4hvH5jD5
 T9rnCwdb0Bjmuol4PD2n4lzT3X57XG8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-SXBfPDZ0NICzTifIysEbYQ-1; Mon, 20 Jul 2020 14:29:33 -0400
X-MC-Unique: SXBfPDZ0NICzTifIysEbYQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C95C8015F3;
 Mon, 20 Jul 2020 18:29:32 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 187B45D9D5;
 Mon, 20 Jul 2020 18:29:25 +0000 (UTC)
Date: Mon, 20 Jul 2020 19:29:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 3/4] io/channel-socket: implement non-blocking connect
Message-ID: <20200720182923.GP643836@redhat.com>
References: <20200720180715.10521-1-vsementsov@virtuozzo.com>
 <20200720180715.10521-4-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200720180715.10521-4-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/19 21:45:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, kraxel@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 20, 2020 at 09:07:14PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Utilize new socket API to make a non-blocking connect for inet sockets.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/io/channel-socket.h | 14 +++++++
>  io/channel-socket.c         | 74 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 88 insertions(+)
> 
> diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
> index 777ff5954e..82e868bc02 100644
> --- a/include/io/channel-socket.h
> +++ b/include/io/channel-socket.h
> @@ -94,6 +94,20 @@ int qio_channel_socket_connect_sync(QIOChannelSocket *ioc,
>                                      SocketAddress *addr,
>                                      Error **errp);
>  
> +/**
> + * qio_channel_socket_connect_non_blocking_sync:
> + * @ioc: the socket channel object
> + * @addr: the address to connect to
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Attempt to connect to the address @addr using non-blocking mode of
> + * the socket. Function is synchronous, but being called from
> + * coroutine context will yield during connect operation.
> + */
> +int qio_channel_socket_connect_non_blocking_sync(QIOChannelSocket *ioc,
> +                                                 SocketAddress *addr,
> +                                                 Error **errp);
> +
>  /**
>   * qio_channel_socket_connect_async:
>   * @ioc: the socket channel object
> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index e1b4667087..076de7578a 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c
> @@ -22,6 +22,7 @@
>  #include "qapi/error.h"
>  #include "qapi/qapi-visit-sockets.h"
>  #include "qemu/module.h"
> +#include "qemu/sockets.h"
>  #include "io/channel-socket.h"
>  #include "io/channel-watch.h"
>  #include "trace.h"
> @@ -29,6 +30,8 @@
>  
>  #define SOCKET_MAX_FDS 16
>  
> +static int qio_channel_socket_close(QIOChannel *ioc, Error **errp);
> +
>  SocketAddress *
>  qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
>                                       Error **errp)
> @@ -157,6 +160,77 @@ int qio_channel_socket_connect_sync(QIOChannelSocket *ioc,
>      return 0;
>  }
>  
> +static int qio_channel_inet_connect_non_blocking_sync(QIOChannelSocket *ioc,
> +        InetSocketAddress *addr, Error **errp)
> +{
> +    Error *local_err = NULL;
> +    struct addrinfo *infos, *info;
> +    int sock = -1;
> +
> +    infos = inet_parse_connect_saddr(addr, errp);
> +    if (!infos) {
> +        return -1;
> +    }

This call is blocking since it calls getaddrinfo whose design
offers no ability todo non-blocking DNS lookups. Given this
call, ...

> +
> +    for (info = infos; info != NULL; info = info->ai_next) {
> +        bool in_progress;
> +
> +        error_free(local_err);
> +        local_err = NULL;
> +
> +        sock = inet_connect_addr(addr, info, false, &in_progress, &local_err);
> +        if (sock < 0) {
> +            continue;
> +        }
> +
> +        if (qio_channel_socket_set_fd(ioc, sock, &local_err) < 0) {
> +            close(sock);
> +            continue;
> +        }
> +
> +        if (in_progress) {
> +            if (qemu_in_coroutine()) {
> +                qio_channel_yield(QIO_CHANNEL(ioc), G_IO_OUT);
> +            } else {
> +                qio_channel_wait(QIO_CHANNEL(ioc), G_IO_OUT);
> +            }

...this is offering false assurances of being non-blocking.

If we don't want the current thread to be blocked then we
need to be using the existing qio_channel_socket_connect_async
method or similar. It uses a throw away background thread to
run the connection attempt, and then reports completion back
later, thus avoiding the getaddrinfo design flaw for the callers.

I explicitly didn't want to add an method like the impl in this
patch, because getaddrinfo dooms it and we already had bugs in
the pre-QIOChannel code where QEMU thought it was non-blocking
but wasn't due to getaddrinfo lookups.


IIUC, the main appeal of this method is that the non-blocking
nature is hidden from the caller who can continue to treat it
as a synchronous call and have the coroutine magic happen in
behind the scenes.

IOW, What's needed is a simple way to run the operation in a
thread, and sleep for completion while having the coroutine
yield.

I think this could likely be achieved with QIOTask with an
alternate impl of the qio_task_wait_thread() method that is
friendly to coroutines instead of being based on pthread
condition variable waits.


> +            if (socket_check(sock, &local_err) < 0) {
> +                qio_channel_socket_close(QIO_CHANNEL(ioc), NULL);
> +                continue;
> +            }
> +        }
> +
> +        break;
> +    }
> +
> +    freeaddrinfo(infos);
> +
> +    error_propagate(errp, local_err);
> +    return sock;
> +}

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


