Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C46C433E4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 15:23:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76FB82071A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 15:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJJCILLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76FB82071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyGaX-0007DY-Me
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 11:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyGZa-0006iA-91
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 11:22:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24291
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyGZW-0002mp-IE
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 11:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595431336;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iidGg8wVYGCyFmhtVMElwzQY3Xm1rvtRBT5OoefeyFw=;
 b=iJJCILLqrN1NzWzBjPfrIo/oOAJ/BZW0/699BCW8rD4yVx1/VqfLzfZ40gyDugPpyoqcem
 CQqakjNyXPAgL8sCvD0Q4EMlXf7OY4P6+wsY1Ip3pJGJZIik1PNsjvaHk337z4vPuQl3Ek
 5lQ/G8cSuSWsNXiwpWyxEZOVcRUQy1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-44nOpORWNzWF5z1mklL7Yg-1; Wed, 22 Jul 2020 11:22:12 -0400
X-MC-Unique: 44nOpORWNzWF5z1mklL7Yg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D00AA1099AFD;
 Wed, 22 Jul 2020 15:21:45 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ADAAA69324;
 Wed, 22 Jul 2020 15:21:43 +0000 (UTC)
Date: Wed, 22 Jul 2020 16:21:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 3/4] io/channel-socket: implement non-blocking connect
Message-ID: <20200722152140.GO2324845@redhat.com>
References: <20200720180715.10521-1-vsementsov@virtuozzo.com>
 <20200720180715.10521-4-vsementsov@virtuozzo.com>
 <20200720182923.GP643836@redhat.com>
 <840b762e-1ce1-af25-2ea0-b8cfdedba0d4@virtuozzo.com>
 <20200722112104.GC2324845@redhat.com>
 <cd5058fe-20d4-615e-8489-a30ac54d57de@virtuozzo.com>
 <20200722125303.GI2324845@redhat.com>
 <71bd9b95-6db6-bfaa-729e-df9d1493e5b7@virtuozzo.com>
 <46847ccc-22d0-59b9-6c43-16cb6af4b078@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <46847ccc-22d0-59b9-6c43-16cb6af4b078@virtuozzo.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:34:34
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

On Wed, Jul 22, 2020 at 06:04:53PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> 22.07.2020 16:47, Vladimir Sementsov-Ogievskiy wrote:
> > 22.07.2020 15:53, Daniel P. Berrangé wrote:
> > > On Wed, Jul 22, 2020 at 03:43:54PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > 22.07.2020 14:21, Daniel P. Berrangé wrote:
> > > > > On Wed, Jul 22, 2020 at 02:00:25PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > > > 20.07.2020 21:29, Daniel P. Berrangé wrote:
> > > > > > > On Mon, Jul 20, 2020 at 09:07:14PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > > > > > Utilize new socket API to make a non-blocking connect for inet sockets.
> > > > > > > > 
> > > > > > > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > > > > > > > ---
> > > > > > > >     include/io/channel-socket.h | 14 +++++++
> > > > > > > >     io/channel-socket.c         | 74 +++++++++++++++++++++++++++++++++++++
> > > > > > > >     2 files changed, 88 insertions(+)
> > > > > > > > 
> > > > > > > > diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
> > > > > > > > index 777ff5954e..82e868bc02 100644
> > > > > > > > --- a/include/io/channel-socket.h
> > > > > > > > +++ b/include/io/channel-socket.h
> > > > > > > > @@ -94,6 +94,20 @@ int qio_channel_socket_connect_sync(QIOChannelSocket *ioc,
> > > > > > > >                                         SocketAddress *addr,
> > > > > > > >                                         Error **errp);
> > > > > > > > +/**
> > > > > > > > + * qio_channel_socket_connect_non_blocking_sync:
> > > > > > > > + * @ioc: the socket channel object
> > > > > > > > + * @addr: the address to connect to
> > > > > > > > + * @errp: pointer to a NULL-initialized error object
> > > > > > > > + *
> > > > > > > > + * Attempt to connect to the address @addr using non-blocking mode of
> > > > > > > > + * the socket. Function is synchronous, but being called from
> > > > > > > > + * coroutine context will yield during connect operation.
> > > > > > > > + */
> > > > > > > > +int qio_channel_socket_connect_non_blocking_sync(QIOChannelSocket *ioc,
> > > > > > > > +                                                 SocketAddress *addr,
> > > > > > > > +                                                 Error **errp);
> > > > > > > > +
> > > > > > > >     /**
> > > > > > > >      * qio_channel_socket_connect_async:
> > > > > > > >      * @ioc: the socket channel object
> > > > > > > > diff --git a/io/channel-socket.c b/io/channel-socket.c
> > > > > > > > index e1b4667087..076de7578a 100644
> > > > > > > > --- a/io/channel-socket.c
> > > > > > > > +++ b/io/channel-socket.c
> > > > > > > > @@ -22,6 +22,7 @@
> > > > > > > >     #include "qapi/error.h"
> > > > > > > >     #include "qapi/qapi-visit-sockets.h"
> > > > > > > >     #include "qemu/module.h"
> > > > > > > > +#include "qemu/sockets.h"
> > > > > > > >     #include "io/channel-socket.h"
> > > > > > > >     #include "io/channel-watch.h"
> > > > > > > >     #include "trace.h"
> > > > > > > > @@ -29,6 +30,8 @@
> > > > > > > >     #define SOCKET_MAX_FDS 16
> > > > > > > > +static int qio_channel_socket_close(QIOChannel *ioc, Error **errp);
> > > > > > > > +
> > > > > > > >     SocketAddress *
> > > > > > > >     qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
> > > > > > > >                                          Error **errp)
> > > > > > > > @@ -157,6 +160,77 @@ int qio_channel_socket_connect_sync(QIOChannelSocket *ioc,
> > > > > > > >         return 0;
> > > > > > > >     }
> > > > > > > > +static int qio_channel_inet_connect_non_blocking_sync(QIOChannelSocket *ioc,
> > > > > > > > +        InetSocketAddress *addr, Error **errp)
> > > > > > > > +{
> > > > > > > > +    Error *local_err = NULL;
> > > > > > > > +    struct addrinfo *infos, *info;
> > > > > > > > +    int sock = -1;
> > > > > > > > +
> > > > > > > > +    infos = inet_parse_connect_saddr(addr, errp);
> > > > > > > > +    if (!infos) {
> > > > > > > > +        return -1;
> > > > > > > > +    }
> > > > > > > 
> > > > > > > This call is blocking since it calls getaddrinfo whose design
> > > > > > > offers no ability todo non-blocking DNS lookups. Given this
> > > > > > > call, ...
> > > > > > 
> > > > > > Oh, that's bad, thanks for taking a look on that early stage!
> > > > > > 
> > > > > > > 
> > > > > > > > +
> > > > > > > > +    for (info = infos; info != NULL; info = info->ai_next) {
> > > > > > > > +        bool in_progress;
> > > > > > > > +
> > > > > > > > +        error_free(local_err);
> > > > > > > > +        local_err = NULL;
> > > > > > > > +
> > > > > > > > +        sock = inet_connect_addr(addr, info, false, &in_progress, &local_err);
> > > > > > > > +        if (sock < 0) {
> > > > > > > > +            continue;
> > > > > > > > +        }
> > > > > > > > +
> > > > > > > > +        if (qio_channel_socket_set_fd(ioc, sock, &local_err) < 0) {
> > > > > > > > +            close(sock);
> > > > > > > > +            continue;
> > > > > > > > +        }
> > > > > > > > +
> > > > > > > > +        if (in_progress) {
> > > > > > > > +            if (qemu_in_coroutine()) {
> > > > > > > > +                qio_channel_yield(QIO_CHANNEL(ioc), G_IO_OUT);
> > > > > > > > +            } else {
> > > > > > > > +                qio_channel_wait(QIO_CHANNEL(ioc), G_IO_OUT);
> > > > > > > > +            }
> > > > > > > 
> > > > > > > ...this is offering false assurances of being non-blocking.
> > > > > > > 
> > > > > > > If we don't want the current thread to be blocked then we
> > > > > > > need to be using the existing qio_channel_socket_connect_async
> > > > > > > method or similar. It uses a throw away background thread to
> > > > > > > run the connection attempt, and then reports completion back
> > > > > > > later, thus avoiding the getaddrinfo design flaw for the callers.
> > > > > > > 
> > > > > > > I explicitly didn't want to add an method like the impl in this
> > > > > > > patch, because getaddrinfo dooms it and we already had bugs in
> > > > > > > the pre-QIOChannel code where QEMU thought it was non-blocking
> > > > > > > but wasn't due to getaddrinfo lookups.
> > > > > > > 
> > > > > > > 
> > > > > > > IIUC, the main appeal of this method is that the non-blocking
> > > > > > > nature is hidden from the caller who can continue to treat it
> > > > > > > as a synchronous call and have the coroutine magic happen in
> > > > > > > behind the scenes.
> > > > > > > 
> > > > > > > IOW, What's needed is a simple way to run the operation in a
> > > > > > > thread, and sleep for completion while having the coroutine
> > > > > > > yield.
> > > > > > > 
> > > > > > > I think this could likely be achieved with QIOTask with an
> > > > > > > alternate impl of the qio_task_wait_thread() method that is
> > > > > > > friendly to coroutines instead of being based on pthread
> > > > > > > condition variable waits.
> > > > > > 
> > > > > > The most simple thing is just run qio_channel_socket_connect_sync in
> > > > > > a thread with help of thread_pool_submit_co() which is coroutine-friendly.
> > > > > > And this don't need any changes in io/channel.
> > > > > > 
> > > > > > Actually, I've started with such design, but decided that better use
> > > > > > non-blocking connect to not deal with cancelling the connecting thread
> > > > > > on shutdown.
> > > > > > 
> > > > > > I think, I'll resend based on thread_pool_submit_co().
> > > > > > 
> > > > > > ===
> > > > > > 
> > > > > > Hmm, there is async getaddrinfo_a function.. What do you think of it?
> > > > > 
> > > > > It isn't portable, glibc only.
> > > > > 
> > > > > > But seems simpler to use a thread than move to async interfaces everywhere.
> > > > > 
> > > > > 
> > > > 
> > > > Hmm.. Still, on shutdown, how to cancel this connect and getaddrinfo ? I'm not sure
> > > > how much time may getaddrinfo take, but connect can take about a minute. It's not really
> > > > good to wait for it on shutdown.
> > > 
> > > The intention was that if you don't want to carry on waiting for the
> > > async operation to complete you just give and pretend it no longer
> > > exists. Eventually it will fail or complete and the thread will exit.
> > > The only important thing there is making sure that the callback you
> > > are passing to the _async() method can cope with the cleanup when the
> > > work eventually completes, even if you've given up.
> > > 
> > 
> > At least it's not possible with thread_pool_submit_co as I wanted, because underlying
> > thread pool waits for all its threads to complete on exit.
> > 
> > 
> 
> 
> I'm trying to use qio_channel_socket_connect_async().. But callback
> is not called.
> 
> How to make it be executed? In tests/test-io-channel-socket.c it's
> done by g_main_loop_new .. g_main_loop_run. But I need to yield.
> socket_start_outgoing_migration uses qio_channel_socket_connect_async
> as well, but is not doing any magic with g_main_loop. But it works. How?

The _async() impls uses  qio_task_run_in_thread to spawn the background
thread. When the thread finishes, it uses g_idle_add to invoke the
callback so that it runs in the context of the main thread, not the
background thread. So something needs to be running the main loop
in QEMU.

If that isn't viable for the scenario you're in, then you can create
your own async version by spawning the thread yourself and running
the _sync() function - the _async() function is ajust a convenient
wrapper combining QIOTask + _sync(), but doesn't always do what 
everyone might need.   In the char-socket.c for example, I do the
async bit manually instead of using teh _async() wrapper.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


