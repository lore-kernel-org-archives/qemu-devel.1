Received: from eggs.gnu.org ([2001:4830:134:3::10]:44749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eongy-00062P-2F
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:01:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eongt-0008MZ-Qb
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:01:32 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54298 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eongt-0008Lo-LA
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 05:01:27 -0500
Date: Thu, 22 Feb 2018 18:01:19 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180222100119.GH18962@xz-mi>
References: <20180124053957.29145-1-peterx@redhat.com>
	<20180124053957.29145-10-peterx@redhat.com>
	<20180221160007.GA21436@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180221160007.GA21436@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v7 09/23] monitor: allow using IO thread
 for parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Feb 21, 2018 at 04:00:07PM +0000, Stefan Hajnoczi wrote:
> On Wed, Jan 24, 2018 at 01:39:43PM +0800, Peter Xu wrote:
> > @@ -4034,12 +4044,29 @@ static void sortcmdlist(void)
> >      qsort((void *)info_cmds, array_num, elem_size, compare_mon_cmd);
> >  }
> >  
> > +static GMainContext *monitor_io_context_get(void)
> > +{
> > +    return iothread_get_g_main_context(mon_global.mon_iothread);
> > +}
> > +
> > +static AioContext *monitor_aio_context_get(void)
> > +{
> > +    return iothread_get_aio_context(mon_global.mon_iothread);
> > +}
> 
> Please follow the X_get_Y() naming convention instead of X_Y_get().  For
> example, see qemu_get_aio_context() and iothread_get_aio_context().

Sure.

> 
> > @@ -4082,11 +4109,41 @@ void error_vprintf_unless_qmp(const char *fmt, va_list ap)
> >      }
> >  }
> >  
> > +static void monitor_list_append(Monitor *mon)
> > +{
> > +    qemu_mutex_lock(&monitor_lock);
> > +    QTAILQ_INSERT_HEAD(&mon_list, mon, entry);
> > +    qemu_mutex_unlock(&monitor_lock);
> > +}
> > +
> > +static void monitor_qmp_setup_handlers(void *data)
> 
> BH functions are usually declared like this:
> 
>   static void X_bh(void *opaque)
> 
> This way it's immediately clear that this function is invoked as a BH.
> 
> I suggest renaming the function to monitor_qmp_setup_handlers_bh().
> Using 'opaque' instead of 'data' is common, too.

Sure.

> 
> > @@ -4099,24 +4156,55 @@ void monitor_init(Chardev *chr, int flags)
> >      }
> >  
> >      if (monitor_is_qmp(mon)) {
> > -        qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_qmp_read,
> > -                                 monitor_qmp_event, NULL, mon, NULL, true);
> >          qemu_chr_fe_set_echo(&mon->chr, true);
> >          json_message_parser_init(&mon->qmp.parser, handle_qmp_command);
> > +        if (mon->use_io_thr) {
> > +            /*
> > +             * It's possible that we already have an IOWatchPoll
> > +             * registered for the Chardev during chardev_init_func().
> 
> When does this happen?
> 
> This seems like a hack that breaks when certain -chardev options are
> used.  For example, what happens if the chardev is a TCP connection with
> reconnect=5.  In that case the socket will be connecting asynchronously
> and we cannot just remove the fd watch.
> 
> How does this interact with TCP listen chardevs?  It looks like the
> listener socket uses the main loop (see tcp_chr_disconnect()).
> 
> I'm worried that the chardev layer isn't thread-safe and you haven't
> added anything to protect it or at least refuse to run in unsafe
> conditions.

Indeed, I did some more reading and noticed that the TCP typed chardev
is really special.

Firstly there can be the QIO thread that handles sync connecting when
"reconnect" is setup (I don't really understand why we only need the
threads when reconnect != 0, but anyway, I'll just assume we need the
threads).  It's done in qmp_chardev_open_socket().

Secondly, TCP can support TLS or TELNET (tcp_chr_new_client() handles
the main logic of it), so there can be actually more than one GSource
created for a single TCP chardev.  Meanwhile, the
chr_update_read_handler() calls never handles the re-setup of those
special GSources (TLS/TELNET), only the common GSource of TCP stream
read/write.

And the whole TCP channel is based on QIO stuff, which means I need to
add non-default context support to QIO stuff too...  That's mostly
about qio_channel_add_watch().  I may need to pass in context
information, and switch to GSource for that function instead of the
old tags, just like what I did to chardev in general.

I'll think about these.  I may possibly need some pre-requisite and
separated patches to fix existing problems before going on with OOB
again.

This is the worst thing I'd like to see - "surprises". :(

Thanks,

-- 
Peter Xu
