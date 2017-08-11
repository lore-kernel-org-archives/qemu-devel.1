Received: from eggs.gnu.org ([2001:4830:134:3::10]:36552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dg9Mq-0002Dh-Rm
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 08:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dg9Mp-0004S4-I6
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 08:48:44 -0400
Date: Fri, 11 Aug 2017 13:48:21 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170811124821.GL2554@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170810160451.32723-1-berrange@redhat.com>
	<20170810160451.32723-3-berrange@redhat.com>
	<20170811122559.GB2076@work-vm> <20170811122936.GK2554@redhat.com>
	<20170811123942.GC2076@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170811123942.GC2076@work-vm>
Subject: Re: [Qemu-devel] [PATCH 2/8] io: introduce a network socket
 listener API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org

On Fri, Aug 11, 2017 at 01:39:43PM +0100, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrange (berrange@redhat.com) wrote:
> > On Fri, Aug 11, 2017 at 01:26:00PM +0100, Dr. David Alan Gilbert wrote:
> > > * Daniel P. Berrange (berrange@redhat.com) wrote:
> > > > The existing QIOChannelSocket class provides the ability to
> > > > listen on a single socket at a time. This patch introduces
> > > > a QIONetListener class that provides a higher level API
> > > > concept around listening for network services, allowing
> > > > for listening on multiple sockets.
> > > 
> > > What protects against a connection on more than one of the sockets?
> > 
> > That's not the responsibility of this module. If a backend only
> > wants to allow a single client at a time, it has to unregister
> > the new client callback and re-register when it is ready to
> > accept a new client. This aspect is no different to the existing
> > case of multiple clients connecting to a single listener socket.
> 
> OK, and we guarantee that we never call accept() twice because we
> make sure we do that unregister before we get back to the main loop?

Yes, and even if 2 clients arrive at exactly the same time, and thus
both sockets show G_IO_IN on the same iteration of the main loop,
we check whether the new client callback is NULL, and so will just
drop the 2nd client.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
