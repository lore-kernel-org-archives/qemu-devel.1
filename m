Received: from eggs.gnu.org ([2001:4830:134:3::10]:35475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1erRlX-0003hq-Vv
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:13:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1erRlV-0003kk-Ba
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:13:11 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:54659)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1erRlV-0003k7-4X
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:13:09 -0500
Received: by mail-wm0-x22d.google.com with SMTP id z81so13481262wmb.4
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 09:13:09 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301084438.13594-4-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2c8bac11-9f90-f79b-7b08-77f94a196c3a@redhat.com>
Date: Thu, 1 Mar 2018 18:13:06 +0100
MIME-Version: 1.0
In-Reply-To: <20180301084438.13594-4-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 03/15] qio: introduce
 qio_channel_add_watch_{full|source}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 01/03/2018 09:44, Peter Xu wrote:
> + * qio_channel_add_watch_source:
> + * @ioc: the channel object
> + * @condition: the I/O condition to monitor
> + * @func: callback to invoke when the source becomes ready
> + * @user_data: opaque data to pass to @func
> + * @notify: callback to free @user_data
> + * @context: gcontext to bind the source to
> + *
> + * Similar as qio_channel_add_watch(), but allows to specify context
> + * to run the watch source, meanwhile return the GSource object
> + * instead of tag ID, with the GSource referenced already.
> + *
> + * Note: callers is responsible to unref the source when not needed.
> + *
> + * Returns: the source pointer
> + */
> +GSource *qio_channel_add_watch_source(QIOChannel *ioc,
> +                                      GIOCondition condition,
> +                                      QIOChannelFunc func,
> +                                      gpointer user_data,
> +                                      GDestroyNotify notify,
> +                                      GMainContext *context);
>  

Just a small thing, this is a bit inconsistent with the rest of the
GSource API, where the g_source_attach is usually left to the caller
when a function returns GSource *.

You might therefore name it instead qio_channel_create_watch, for
consistency with g_io_{add,create}_watch, and remove the "context" argument.

(Not making it perfectly the same API is okay, for example in practice
all callers would use g_source_set_callback so it's okay IMO to add the
three arguments func/user_data/notify.  However, inconsistency on
g_source_add is more subtle).

Thanks,

Paolo
