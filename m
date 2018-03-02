Received: from eggs.gnu.org ([2001:4830:134:3::10]:33596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ermrb-0004V1-2n
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:44:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ermrX-00062U-W9
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:44:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55468 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ermrX-0005yH-Q9
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:44:47 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 223234022909
	for <qemu-devel@nongnu.org>; Fri,  2 Mar 2018 15:44:38 +0000 (UTC)
Date: Fri, 2 Mar 2018 15:44:24 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180302154424.GG26972@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301084438.13594-4-peterx@redhat.com>
	<2c8bac11-9f90-f79b-7b08-77f94a196c3a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2c8bac11-9f90-f79b-7b08-77f94a196c3a@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Mar 01, 2018 at 06:13:06PM +0100, Paolo Bonzini wrote:
> On 01/03/2018 09:44, Peter Xu wrote:
> > + * qio_channel_add_watch_source:
> > + * @ioc: the channel object
> > + * @condition: the I/O condition to monitor
> > + * @func: callback to invoke when the source becomes ready
> > + * @user_data: opaque data to pass to @func
> > + * @notify: callback to free @user_data
> > + * @context: gcontext to bind the source to
> > + *
> > + * Similar as qio_channel_add_watch(), but allows to specify context
> > + * to run the watch source, meanwhile return the GSource object
> > + * instead of tag ID, with the GSource referenced already.
> > + *
> > + * Note: callers is responsible to unref the source when not needed.
> > + *
> > + * Returns: the source pointer
> > + */
> > +GSource *qio_channel_add_watch_source(QIOChannel *ioc,
> > +                                      GIOCondition condition,
> > +                                      QIOChannelFunc func,
> > +                                      gpointer user_data,
> > +                                      GDestroyNotify notify,
> > +                                      GMainContext *context);
> >  
> 
> Just a small thing, this is a bit inconsistent with the rest of the
> GSource API, where the g_source_attach is usually left to the caller
> when a function returns GSource *.

The APIs which return a GSource in glib typically don't even set the
callback function - we already cover that scenario with the
qio_channel_create_watch APIs.

GLib doesn't typically have APIs which return a GSource after the
mix of creating the watch, setting callback & attaching to context.
They all just return the watch ID value.

So I think this proposal is ok as it is as there's no real precedence.

Alternatively we could simply do without this API entirely. It is
trivial enough for the code that needs a GSource to get iuse the
normal qio_channel_add_watch|watch_full APIs, and then lookup the
GSource themselves - only one extra line of code in the callers.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
