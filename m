Received: from eggs.gnu.org ([2001:4830:134:3::10]:44231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fB2c7-0005O0-3n
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 14:24:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fB2c3-0002ZS-UK
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 14:24:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38604 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fB2c3-0002Z5-Nc
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 14:24:23 -0400
Date: Tue, 24 Apr 2018 19:24:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180424182405.GM20310@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1524295325-18136-1-git-send-email-wangxinxin.wang@huawei.com>
	<20180424171631.GF2521@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180424171631.GF2521@work-vm>
Subject: Re: [Qemu-devel] [PATCH] migration/fd: abort migration if receive
 POLLHUP event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Wang Xin <wangxinxin.wang@huawei.com>, qemu-devel@nongnu.org, quintela@redhat.com, arei.gonglei@huawei.com, peterx@redhat.com

On Tue, Apr 24, 2018 at 06:16:31PM +0100, Dr. David Alan Gilbert wrote:
> * Wang Xin (wangxinxin.wang@huawei.com) wrote:
> > If the fd socket peer closed shortly, ppoll may receive a POLLHUP
> > event before the expected POLLIN event, and qemu will do nothing
> > but goes into an infinite loop of the POLLHUP event.
> > 
> > So, abort the migration if we receive a POLLHUP event.
> 
> Hi Wang Xin,
>   Can you explain how you manage to trigger this case; I've not hit it.
> 
> > Signed-off-by: Wang Xin <wangxinxin.wang@huawei.com>
> > 
> > diff --git a/migration/fd.c b/migration/fd.c
> > index cd06182..5932c87 100644
> > --- a/migration/fd.c
> > +++ b/migration/fd.c
> > @@ -15,6 +15,7 @@
> >   */
> >  
> >  #include "qemu/osdep.h"
> > +#include "qemu/error-report.h"
> >  #include "channel.h"
> >  #include "fd.h"
> >  #include "monitor/monitor.h"
> > @@ -46,6 +47,11 @@ static gboolean fd_accept_incoming_migration(QIOChannel *ioc,
> >                                               GIOCondition condition,
> >                                               gpointer opaque)
> >  {
> > +    if (condition & G_IO_HUP) {
> > +        error_report("The migration peer closed, job abort");
> > +        exit(EXIT_FAILURE);
> > +    }
> > +
> 
> OK,  I wish we had a nicer way for failing;  especially for the
> multifd/postcopy recovery worlds where one failed connection might not
> be fatal; but I don't see how to do that here.

This doesn't feel right to me.

We have passed in a pre-opened FD to QEMU, and we registered a watch
on it to detect when there is data from the src QEMU that is available
to read.  Normally the src will have sent something so we'll get G_IO_IN,
but you're suggesting the client has quit immediately, so we're getting
G_IO_HUP due to end of file.

The migration_channel_process_incoming() method that we pass the ioc
object to will be calling qio_channel_read(ioc) somewhere to try to
read that data.

For QEMU to spin in infinite loop there must be code in the
migration_channel_process_incoming() that is ignoring the return
value of qio_channel_read() in some manner causing it to retry
the read again & again I presume.

Putting this check for G_IO_HUP fixes your immediate problem scenario,
but whatever code was spinning in infinite loop is still broken and
I'd guess it was possible to still trigger the loop. eg by writing
1 single byte and then closing the socket.

So, IMHO this fix is wrong - we need to find the root cause and fix
that, not try to avoid calling the buggy code.

> 
> >      migration_channel_process_incoming(ioc);
> >      object_unref(OBJECT(ioc));
> >      return G_SOURCE_REMOVE;
> > @@ -67,7 +73,7 @@ void fd_start_incoming_migration(const char *infd, Error **errp)
> >  
> >      qio_channel_set_name(QIO_CHANNEL(ioc), "migration-fd-incoming");
> >      qio_channel_add_watch(ioc,
> > -                          G_IO_IN,
> > +                          G_IO_IN | G_IO_HUP,
> >                            fd_accept_incoming_migration,
> >                            NULL,
> >                            NULL);
> 
> Dave
> 
> > -- 
> > 2.8.1.windows.1
> > 
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
