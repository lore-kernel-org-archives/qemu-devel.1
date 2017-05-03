Received: from eggs.gnu.org ([2001:4830:134:3::10]:50149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d5pn6-00047a-Im
	for qemu-devel@nongnu.org; Wed, 03 May 2017 04:37:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d5pn3-0008BJ-Ez
	for qemu-devel@nongnu.org; Wed, 03 May 2017 04:37:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d5pn3-0008B7-55
	for qemu-devel@nongnu.org; Wed, 03 May 2017 04:37:41 -0400
Date: Wed, 3 May 2017 09:37:35 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170503083735.GB4121@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <cover.1493191677.git.maozy.fnst@cn.fujitsu.com>
	<2bc05de0edd61cdcdd3d2b894378a874d1e12327.1493191677.git.maozy.fnst@cn.fujitsu.com>
	<87shktu8cu.fsf@dusky.pond.sub.org>
	<20170427163025.GD30599@redhat.com>
	<87lgqlnenh.fsf@dusky.pond.sub.org>
	<23e5dc02-3e69-2166-c18b-786fc75172ff@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <23e5dc02-3e69-2166-c18b-786fc75172ff@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] net/socket: Convert error report
 message to Error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: Markus Armbruster <armbru@redhat.com>, jasowang@redhat.com, qemu-devel@nongnu.org

On Wed, May 03, 2017 at 03:09:57PM +0800, Mao Zhongyi wrote:
> Hi, Markus,Daniel
> 
> On 04/28/2017 04:02 PM, Markus Armbruster wrote:
> > "Daniel P. Berrange" <berrange@redhat.com> writes:
> > 
> > > On Thu, Apr 27, 2017 at 06:24:17PM +0200, Markus Armbruster wrote:
> > > > No review, just an observation.
> > > > 
> > > > Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:
> > > > 
> > > > > Currently, net_socket_mcast_create(), net_socket_fd_init_dgram() and
> > > > > net_socket_fd_init() use the function such as fprintf(), perror() to
> > > > > report an error message.
> > > > > 
> > > > > Now, convert these functions to Error.
> > > > > 
> > > > > CC: jasowang@redhat.com, armbru@redhat.com
> > > > > Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> > > > > ---
> > > > >  net/socket.c | 66 +++++++++++++++++++++++++++++++++++++-----------------------
> > > > >  1 file changed, 41 insertions(+), 25 deletions(-)
> > > > > 
> > > > > diff --git a/net/socket.c b/net/socket.c
> > > > > index b0decbe..559e09a 100644
> > > > > --- a/net/socket.c
> > > > > +++ b/net/socket.c
> > > > [...]
> > > > > @@ -433,25 +437,27 @@ static NetSocketState *net_socket_fd_init_stream(NetClientState *peer,
> > > > > 
> > > > >  static NetSocketState *net_socket_fd_init(NetClientState *peer,
> > > > >                                            const char *model, const char *name,
> > > > > -                                          int fd, int is_connected)
> > > > > +                                          int fd, int is_connected,
> > > > > +                                          Error **errp)
> > > > >  {
> > > > >      int so_type = -1, optlen=sizeof(so_type);
> > > > > 
> > > > >      if(getsockopt(fd, SOL_SOCKET, SO_TYPE, (char *)&so_type,
> > > > >          (socklen_t *)&optlen)< 0) {
> > > > > -        fprintf(stderr, "qemu: error: getsockopt(SO_TYPE) for fd=%d failed\n",
> > > > > +        error_setg(errp, "qemu: error: getsockopt(SO_TYPE) for fd=%d failed",
> > > > >                  fd);
> > > > >          closesocket(fd);
> > > > >          return NULL;
> > > > >      }
> > > > >      switch(so_type) {
> > > > >      case SOCK_DGRAM:
> > > > > -        return net_socket_fd_init_dgram(peer, model, name, fd, is_connected);
> > > > > +        return net_socket_fd_init_dgram(peer, model, name, fd, is_connected, errp);
> > > > >      case SOCK_STREAM:
> > > > >          return net_socket_fd_init_stream(peer, model, name, fd, is_connected);
> > > > >      default:
> > > > >          /* who knows ... this could be a eg. a pty, do warn and continue as stream */
> > > > > -        fprintf(stderr, "qemu: warning: socket type=%d for fd=%d is not SOCK_DGRAM or SOCK_STREAM\n", so_type, fd);
> > > > > +        error_setg(errp, "qemu: warning: socket type=%d for fd=%d is not SOCK_DGRAM"
> > > > > +                   " or SOCK_STREAM", so_type, fd);
> > > > 
> > > > Not this patches problem: this case is odd, and the comment is bogus.
> > > > If @fd really was a pty, getsockopt() would fail with ENOTSOCK, wouldn't
> > > > it?  If @fd is a socket, but neither SOCK_DGRAM nor SOCK_STREAM (say
> > > > SOCK_RAW), why is it safe to continue as if it was SOCK_STREAM?  Jason?
> > > 
> > > IMHO it is a problem with this patch. Previously we merely printed
> > > a warning & carried on, which is conceptually ok in general, though
> > > dubious here for the reason you say.
> > > 
> > > Now we are filling an Error **errp object, and carrying on - this is
> > > conceptually broken anywhere. If an Error ** is filled, we must return.
> > > If we want to carry on, we shouldn't fill Error **.
> > 
> > You're right.
> > 
> > > > >          return net_socket_fd_init_stream(peer, model, name, fd, is_connected);
> > > 
> > > IMHO, we just kill this and put return NULL here. If there is a genuine
> > > reason to support something like SOCK_RAW, it should be explicitly
> > > handled, because this default: case will certainly break SOCK_SEQPACKET
> > > and SOCK_RDM which can't be treated as streams.
> > 
> > It's either magic or misguided defensive programming.  Probably the
> > latter, but I'd like to hear Jason's opinion.
> > 
> > If it's *necessary* magic, we can't use error_setg().  Else, we should
> > drop the default, and insert a closesocket(fd) before the final return
> > NULL.
> 
> As Daniel said, although the previous printed warning message is
> dubious, but it is conceptually ok in general. Simply filling it to
> Error ** is problematic. Of course, as you said drop the default case,
> there will be no problem. But really to do that?

Yes, please drop that 'default' case since it is broken already.

BTW, drop the default case in a separate patch at the start of
your series, before changing the error code, so the functional
change is clear in git history.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
