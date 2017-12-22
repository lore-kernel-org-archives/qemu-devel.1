Received: from eggs.gnu.org ([2001:4830:134:3::10]:37287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eSKWz-0002UC-6y
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 05:26:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eSKWw-0003Vp-F7
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 05:26:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eSKWw-0003VK-4z
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 05:26:18 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 13A821555A
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 10:26:17 +0000 (UTC)
Date: Fri, 22 Dec 2017 10:26:11 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171222102611.GK30605@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171221155905.3793-1-berrange@redhat.com>
	<20171221155905.3793-3-berrange@redhat.com>
	<87d137qdpn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87d137qdpn.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] char: allow passing pre-opened
 socket file descriptor at startup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Dec 22, 2017 at 11:06:12AM +0100, Markus Armbruster wrote:
> "Daniel P. Berrange" <berrange@redhat.com> writes:

> > +
> > +/* Syms in libqemustub.a are discarded at .o file granularity.
> > + * To replace monitor_get_fd() we must ensure everything in
> > + * stubs/monitor.c is defined, to make sure monitor.o is discarded
> > + * otherwise we get duplicate syms at link time.
> > + */
> > +Monitor *cur_mon = NULL;
> > +void monitor_init(Chardev *chr, int flags) {}
> > +
> > +/* If a monitor is active (ie cur_mon != NULL), then
> > + * we should be able to use fd=<NAME> syntax
> > + */
> > +static void char_socket_fdpass_mon_test(void)
> > +{
> > +    Chardev *chr;
> > +    const char *optstr;
> > +    QemuOpts *opts;
> > +    int fd;
> > +
> > +    fd = char_socket_listener();
> > +    mon_fd = fd;
> > +    cur_mon = g_malloc(1); /* Pretend we have a mon available */
> 
> Feels unnecessarily dirty.  Suggest to define cur_mon like this:
> 
>    static Monitor dummy_mon;
>    Monitor *cur_mon = &dummy_mon;  /* Pretend we have a mon available */
> 
> Or in case cur_mon must remain null outside this function, set it like
> this:
> 
>        Monitor dummy_mon = {0};
>        cur_mon = &dummy_mon;       /* Pretend we have a mon available */
> 
> More of the same below.

FYI, I didn't do that because 'struct Monitor' is defined inside
monitor.c, not exposed in header files. I felt it would be worse
to pollute the header file with what's supposed to be a private
struct definition, just for sake of tests, particularly since
we don't actually need any of the Monitor object contents.

We could create a monitor-internal.h for the "struct Monitor"
definition, if you feel strongly we should take this approach
in the tests instead of my hack here ?


> > diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> > index 1d23f0b742..9400f9a940 100644
> > --- a/util/qemu-sockets.c
> > +++ b/util/qemu-sockets.c
> > @@ -1046,7 +1046,26 @@ int socket_connect(SocketAddress *addr, Error **errp)
> >          break;
> >  
> >      case SOCKET_ADDRESS_TYPE_FD:
> > -        fd = monitor_get_fd(cur_mon, addr->u.fd.str, errp);
> > +        if (cur_mon) {
> > +            fd = monitor_get_fd(cur_mon, addr->u.fd.str, errp);
> > +            if (fd < 0) {
> > +                return -1;
> > +            }
> > +        } else {
> > +            unsigned long i;
> 
> Naming a long @i is bad taste.  Let's rename to @ul.
> 
> > +            if (qemu_strtoul(addr->u.fd.str, NULL, 10, &i) < 0) {
> > +                error_setg_errno(errp, errno,
> > +                                 "Unable to parse FD number %s",
> > +                                 addr->u.fd.str);
> > +                return -1;
> > +            }
> > +            fd = i;
> 
> Truncates silently.  Shouldn't you check for range?
> 
> If the parent process screws up passing the file descriptor, fd can
> hijack some random internal file.  I'd ask you to catch that if I had
> any idea how to do that easily.

I guess it is just a matter of defining yet another qemu_strtoNN variant
that takes an "int" parameter instead of "long", and does range checking.

> Outside monitor context, you can now use numeric fds, and only numeric
> fds.  Makes sense, because named fds are associated with a monitor.
> Note that before the patch, we crashed in monitor_get_fd() dereferencing
> cur_mon.

Yeah, that is fun, but I don't think there's any code path that could
trigger it.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
