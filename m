Received: from eggs.gnu.org ([2001:4830:134:3::10]:43622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eS46S-0000g9-EB
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 11:53:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eS46P-00040Q-Bp
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 11:53:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eS46P-0003zc-2D
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 11:53:49 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 110526A7D0
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 16:53:48 +0000 (UTC)
Date: Thu, 21 Dec 2017 16:53:32 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171221165332.GK30327@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171221132717.30284-1-berrange@redhat.com>
	<20171221132717.30284-3-berrange@redhat.com>
	<87mv2cuiut.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mv2cuiut.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v1 2/2] char: allow passing pre-opened
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

On Thu, Dec 21, 2017 at 05:49:14PM +0100, Markus Armbruster wrote:
> QAPI schema review only.
> 
> "Daniel P. Berrange" <berrange@redhat.com> writes:
> 
> > When starting QEMU management apps will usually setup a monitor socket, and
> > then open it immediately after startup. If not using QEMU's own -daemonize
> > arg, this process can be troublesome to handle correctly. The mgmt app will
> > need to repeatedly call connect() until it succeeds, because it does not
> > know when QEMU has created the listener socket. If can't retry connect()
> > forever though, because an error might have caused QEMU to exit before it
> > even creates the monitor.
> >
> > The obvious way to fix this kind of problem is to just pass in a pre-opened
> > socket file descriptor for the QEMU monitor to listen on. The management app
> > can now immediately call connect() just once. If connect() fails it knows
> > that QEMU has exited with an error.
> >
> > The SocketAddress(Legacy) structs allow for FD passing via the monitor, using
> > the 'getfd' command, but only when using QMP JSON syntax. The HMP syntax has
> > no way to initialize the SocketAddress(Legacy) 'fd' variant. So this patch
> > first wires up the 'fd' parameter to refer to a monitor file descriptor,
> > allowing HMP to use
> >
> >    getfd myfd
> >    chardev-add socket,fd=myfd
> >
> > The SocketAddress 'fd' variant is currently tied to the use of the monitor
> > 'getfd' command, so we have a chicken & egg problem with reusing that at
> > startup wher no monitor connection is available. We could define that the
> 
> s/wher/where/
> 
> > special fd name prefix '/dev/fdset' refers to a FD passed via the CLI, but
> > magic strings feel unpleasant.
> >
> > Instead we define a SocketAddress 'fdset' variant that takes an fd set number
> > that works in combination with the 'add-fd' command line argument. e.g.
> >
> >   -add-fd fd=3,set=1
> >   -chardev socket,fdset=1,id=mon
> >   -mon chardev=mon,mode=control
> >
> > Note that we do not wire this up in the legacy chardev syntax, so you cannot
> > use FD passing with '-qmp', you must use the modern '-mon' + '-chardev' pair
> >
> > An illustrative example of usage is:
> >
> >   #!/usr/bin/perl
> >
> >   use IO::Socket::UNIX;
> >   use Fcntl;
> >
> >   unlink "/tmp/qmp";
> >   my $srv = IO::Socket::UNIX->new(
> >     Type => SOCK_STREAM(),
> >     Local => "/tmp/qmp",
> >     Listen => 1,
> >   );
> >
> >   my $flags = fcntl $srv, F_GETFD, 0;
> >   fcntl $srv, F_SETFD, $flags & ~FD_CLOEXEC;
> >
> >   my $fd = $srv->fileno();
> >
> >   exec "qemu-system-x86_64", \
> >       "-add-fd", "fd=$fd,set=1", \
> >       "-chardev", "socket,fdset=1,server,nowait,id=mon", \
> >       "-mon", "chardev=mon,mode=control";
> >
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> [...]
> > diff --git a/qapi/common.json b/qapi/common.json
> > index 6eb01821ef..a15cdc36e9 100644
> > --- a/qapi/common.json
> > +++ b/qapi/common.json
> > @@ -74,6 +74,17 @@
> >  { 'enum': 'OnOffSplit',
> >    'data': [ 'on', 'off', 'split' ] }
> >  
> > +##
> > +# @Int:
> > +#
> > +# A fat type wrapping 'int', to be embedded in lists.
> 
> I figure you got the "to be embedded in lists" part from @String.  That
> one's occasionally used as list element type, but there are other uses.
> @Int has only such other uses so far.  Let's drop this line from both types.
> 
> > +#
> > +# Since: 2.12
> > +##
> > +{ 'struct': 'Int',
> > +  'data': {
> > +    'i': 'int' } }
> > +
> >  ##
> >  # @String:
> >  #
> > diff --git a/qapi/sockets.json b/qapi/sockets.json
> > index ac022c6ad0..f3cac02166 100644
> > --- a/qapi/sockets.json
> > +++ b/qapi/sockets.json
> > @@ -112,7 +112,8 @@
> >      'inet': 'InetSocketAddress',
> >      'unix': 'UnixSocketAddress',
> >      'vsock': 'VsockSocketAddress',
> > -    'fd': 'String' } }
> > +    'fd': 'String',
> > +    'fdset': 'Int' } }
> >  
> >  ##
> >  # @SocketAddressType:
> > @@ -123,10 +124,16 @@
> >  #
> >  # @unix:  Unix domain socket
> >  #
> > +# @vsock: VSOCK socket
> > +#
> > +# @fd: socket file descriptor passed over monitor
> > +#
> 
> Indepedent doc fix.  I'd put it in a separate patch.
> 
> One inaccuracy: @fd is *not* a file descriptor, it's the *name* of a
> file descriptor.  Please fix.
> 
> > +# @fdset: socket file descriptor passed via CLI (since 2.12)
> > +#
> 
> I gather we have to ways to pass file descriptors.  One way identifies
> them by name (member @fd), the other by numeric ID (member @fdset).
> 
> 0. This is disgusting.  Is there any way to unify the two, and deprecate
> the loser (hopefully the numeric one)?

Checkout my v2 which takes a different, less disgusting approach.

> 1. What makes the second one a *set*?

Just that the API i used was called fdset.

> 2. What ties the second one to the CLI?  Accidents of implementation or
> something deeper?

Nothing strict - just convention of usage. You could technically (ab)use
it from the monitor too.  My v2 approach enforces the distinct usage
more strictly.

> 
> >  # Since: 2.9
> >  ##
> >  { 'enum': 'SocketAddressType',
> > -  'data': [ 'inet', 'unix', 'vsock', 'fd' ] }
> > +  'data': [ 'inet', 'unix', 'vsock', 'fd', 'fdset' ] }
> >  
> >  ##
> >  # @SocketAddress:
> > @@ -144,4 +151,5 @@
> >    'data': { 'inet': 'InetSocketAddress',
> >              'unix': 'UnixSocketAddress',
> >              'vsock': 'VsockSocketAddress',
> > -            'fd': 'String' } }
> > +            'fd': 'String',
> > +            'fdset': 'Int' } }
> [...]

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
