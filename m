Received: from eggs.gnu.org ([2001:4830:134:3::10]:35239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evhlq-0003UC-QI
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evhlm-0005ak-Qx
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:07:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42172 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1evhlm-0005aH-Lh
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:07:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7335776FB9
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 11:06:57 +0000 (UTC)
Date: Tue, 13 Mar 2018 11:06:52 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180313110652.GS3048@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180312141714.7223-1-berrange@redhat.com>
	<20180313092053.GA3545@work-vm>
	<be16f4e2-7b97-e251-332e-9445e4d9965c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be16f4e2-7b97-e251-332e-9445e4d9965c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 REPOST] migration: convert socket
 server to QIONetListener
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

On Tue, Mar 13, 2018 at 11:57:17AM +0100, Paolo Bonzini wrote:
> On 13/03/2018 10:20, Dr. David Alan Gilbert wrote:
> >>  static void socket_start_incoming_migration(SocketAddress *saddr,
> >>                                              Error **errp)
> >>  {
> >> -    QIOChannelSocket *listen_ioc = qio_channel_socket_new();
> >> +    QIONetListener *listener = qio_net_listener_new();
> >>  
> >> -    qio_channel_set_name(QIO_CHANNEL(listen_ioc),
> >> -                         "migration-socket-listener");
> >> +    qio_net_listener_set_name(listener, "migration-socket-listener");
> >>  
> >> -    if (qio_channel_socket_listen_sync(listen_ioc, saddr, errp) < 0) {
> >> -        object_unref(OBJECT(listen_ioc));
> >> +    if (qio_net_listener_open_sync(listener, saddr, errp) < 0) {
> >> +        object_unref(OBJECT(listener));
> >>          return;
> >>      }
> >>  
> >> -    qio_channel_add_watch(QIO_CHANNEL(listen_ioc),
> >> -                          G_IO_IN,
> >> -                          socket_accept_incoming_migration,
> >> -                          listen_ioc,
> >> -                          (GDestroyNotify)object_unref);
> >> +    qio_net_listener_set_client_func(listener,
> >> +                                     socket_accept_incoming_migration,
> >> +                                     NULL, NULL);
> >>  }
> >>  
> >>  void tcp_start_incoming_migration(const char *host_port, Error **errp)
> >> -- 
> >> 2.14.3
> >>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> 
> Could this get in 2.12 as a bugfix, even after soft freeze?  It's the
> last user of qio_channel_listen_sync that blocks full IPv4/IPv6 support.
>  All other users are for vsock/AF_UNIX.

I had been thinking of all this conversion as feature, but I guess if we
squint our eyes a bit we could claim it is just a bugfix on the grounds
that it is fixing broken IPv4/6 dual stack support.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
