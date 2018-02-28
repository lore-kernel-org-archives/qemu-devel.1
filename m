Received: from eggs.gnu.org ([2001:4830:134:3::10]:45618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eqxjd-0000Rz-S8
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 04:09:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eqxjZ-0006MQ-QW
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 04:09:13 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60098 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eqxjZ-0006MA-Hg
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 04:09:09 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E8CE8182D2E
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 09:09:00 +0000 (UTC)
Date: Wed, 28 Feb 2018 09:08:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180228090845.GB31550@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180228050633.7410-1-peterx@redhat.com>
	<20180228050633.7410-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180228050633.7410-4-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/14] qio: introduce
 qio_channel_add_watch_full()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Feb 28, 2018 at 01:06:22PM +0800, Peter Xu wrote:
> It's a more powerful version of qio_channel_add_watch(), which supports
> non-default gcontext.  It's stripped from the old one, then we have
> g_source_get_id() to fetch the tag ID to keep the old interface.
> 
> Note that the new API will return a gsource, meanwhile keep a reference
> of it so that callers need to unref them explicitly.

I don't really like this. Having qio_channel_add_watch and
qio_channel_add_watch_full with differing return values is
really very surprising. They should be functionally identical,
except for the extra context arg.

> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/io/channel.h | 31 ++++++++++++++++++++++++++++---
>  io/channel.c         | 24 +++++++++++++++++++-----
>  2 files changed, 47 insertions(+), 8 deletions(-)
> 
> diff --git a/include/io/channel.h b/include/io/channel.h
> index 3995e243a3..36af5e58ae 100644
> --- a/include/io/channel.h
> +++ b/include/io/channel.h
> @@ -620,20 +620,45 @@ GSource *qio_channel_create_watch(QIOChannel *ioc,
>                                    GIOCondition condition);
>  
>  /**
> - * qio_channel_add_watch:
> + * qio_channel_add_watch_full:
>   * @ioc: the channel object
>   * @condition: the I/O condition to monitor
>   * @func: callback to invoke when the source becomes ready
>   * @user_data: opaque data to pass to @func
>   * @notify: callback to free @user_data
> + * @context: gcontext to bind the source to
>   *
> - * Create a new main loop source that is used to watch
> + * Create a new source that is used to watch
>   * for the I/O condition @condition. The callback @func
>   * will be registered against the source, to be invoked
>   * when the source becomes ready. The optional @user_data
>   * will be passed to @func when it is invoked. The @notify
>   * callback will be used to free @user_data when the
> - * watch is deleted
> + * watch is deleted.  The source will be bound to @context if
> + * provided, or main context if it is NULL.
> + *
> + * Note: if a valid source is returned, we need to explicitly unref
> + * the source to destroy it.
> + *
> + * Returns: the source pointer
> + */
> +GSource *qio_channel_add_watch_full(QIOChannel *ioc,
> +                                    GIOCondition condition,
> +                                    QIOChannelFunc func,
> +                                    gpointer user_data,
> +                                    GDestroyNotify notify,
> +                                    GMainContext *context);
> +
> +/**
> + * qio_channel_add_watch:
> + * @ioc: the channel object
> + * @condition: the I/O condition to monitor
> + * @func: callback to invoke when the source becomes ready
> + * @user_data: opaque data to pass to @func
> + * @notify: callback to free @user_data
> + *
> + * Wrapper of qio_channel_add_watch_full(), but it'll only bind the
> + * source object to default main context.
>   *
>   * The returned source ID can be used with g_source_remove()
>   * to remove and free the source when no longer required.
> diff --git a/io/channel.c b/io/channel.c
> index ec4b86de7c..3e734cc9a5 100644
> --- a/io/channel.c
> +++ b/io/channel.c
> @@ -299,6 +299,22 @@ void qio_channel_set_aio_fd_handler(QIOChannel *ioc,
>      klass->io_set_aio_fd_handler(ioc, ctx, io_read, io_write, opaque);
>  }
>  
> +GSource *qio_channel_add_watch_full(QIOChannel *ioc,
> +                                    GIOCondition condition,
> +                                    QIOChannelFunc func,
> +                                    gpointer user_data,
> +                                    GDestroyNotify notify,
> +                                    GMainContext *context)
> +{
> +    GSource *source;
> +
> +    source = qio_channel_create_watch(ioc, condition);
> +    g_source_set_callback(source, (GSourceFunc)func, user_data, notify);
> +    g_source_attach(source, context);
> +
> +    return source;
> +}
> +
>  guint qio_channel_add_watch(QIOChannel *ioc,
>                              GIOCondition condition,
>                              QIOChannelFunc func,
> @@ -308,11 +324,9 @@ guint qio_channel_add_watch(QIOChannel *ioc,
>      GSource *source;
>      guint id;
>  
> -    source = qio_channel_create_watch(ioc, condition);
> -
> -    g_source_set_callback(source, (GSourceFunc)func, user_data, notify);
> -
> -    id = g_source_attach(source, NULL);
> +    source = qio_channel_add_watch_full(ioc, condition, func,
> +                                        user_data, notify, NULL);
> +    id = g_source_get_id(source);
>      g_source_unref(source);
>  
>      return id;
> -- 
> 2.14.3
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
