Received: from eggs.gnu.org ([2001:4830:134:3::10]:40978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWRO-0002lT-Cg
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:28:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWRN-0007XK-2Y
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:28:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWRM-0007Wn-R5
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:28:25 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E1295F5DDA
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:28:24 +0000 (UTC)
Date: Fri, 6 Jan 2017 15:28:19 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170106152819.GP31112@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170105160701.22118-1-berrange@redhat.com>
	<20170105160701.22118-4-berrange@redhat.com>
	<b9fc5446-b9d9-cede-2b1a-b3012f904b8d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9fc5446-b9d9-cede-2b1a-b3012f904b8d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/8] ui: refactor VncDisplay to allow
 multiple listening sockets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

On Fri, Jan 06, 2017 at 09:23:24AM -0600, Eric Blake wrote:
> On 01/05/2017 10:06 AM, Daniel P. Berrange wrote:
> > Currently there is only a single listener for plain VNC and
> > a single listener for websockets VNC. This means that is
> 
> s/is/if/
> 
> > getaddrinfo() returns multiple IP addresses, for a hostname,
> > the VNC server can only listen on one of them. This is
> > just bearable if listening on wildcard interface, or if
> > the host only has a single network interface to listen on,
> > but if there are multiple NICs and the VNC server needs
> > to listen on 2 or more specific IP addresses, it can't be
> > done.
> > 
> > This refactors the VncDisplay state so that it holds an
> > array of listening sockets, but still only listens on
> > one socket.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  ui/vnc.c | 103 +++++++++++++++++++++++++++++++++++++++++----------------------
> >  ui/vnc.h |  10 ++++---
> >  2 files changed, 73 insertions(+), 40 deletions(-)
> 
> Are you using git's order directives to put .h files first?

No special git config at all.

> > @@ -3819,30 +3843,36 @@ void vnc_display_open(const char *id, Error **errp)
> >          vnc_connect(vd, sioc, false, false);
> >          object_unref(OBJECT(sioc));
> >      } else {
> > -        vd->lsock = qio_channel_socket_new();
> > -        qio_channel_set_name(QIO_CHANNEL(vd->lsock), "vnc-listen");
> > -        if (qio_channel_socket_listen_sync(vd->lsock, saddr, errp) < 0) {
> > +        vd->nlsock = 1;
> > +        vd->lsock = g_new0(QIOChannelSocket *, 1);
> > +        vd->lsock_tag = g_new0(guint, 1);
> 
> Is guint really the best type here...

Yep, guint is what the the Glib main loop uses as the type for
tracking GSource IDs. e.g.

https://developer.gnome.org/glib/stable/glib-The-Main-Event-Loop.html#g-source-get-id

> 
> > +++ b/ui/vnc.h
> > @@ -146,10 +146,12 @@ struct VncDisplay
> >      int num_exclusive;
> >      int connections_limit;
> >      VncSharePolicy share_policy;
> > -    QIOChannelSocket *lsock;
> > -    guint lsock_tag;
> > -    QIOChannelSocket *lwebsock;
> > -    guint lwebsock_tag;
> > +    size_t nlsock;
> > +    QIOChannelSocket **lsock;
> > +    guint *lsock_tag;
> 
> ...and here?
> 
> > +    size_t nlwebsock;
> > +    QIOChannelSocket **lwebsock;
> > +    guint *lwebsock_tag;
> >      DisplaySurface *ds;
> >      DisplayChangeListener dcl;
> >      kbd_layout_t *kbd_layout;
> > 
> 
> Whether or not you tweak the types to something a little more direct (I
> thing guint is more hassle than it's worth when not directly passing the
> field to glib functions),

It'll be passed to g_source_remove later which expects guint

https://developer.gnome.org/glib/stable/glib-The-Main-Event-Loop.html#g-source-remove

> Reviewed-by: Eric Blake <eblake@redhat.com>

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
