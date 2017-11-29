Received: from eggs.gnu.org ([2001:4830:134:3::10]:60414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eK5X5-0003si-Tr
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:48:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eK5X2-0007Ge-PB
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:48:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eK5X2-0007GL-FM
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:48:20 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 64E457F41D
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 16:48:19 +0000 (UTC)
Date: Wed, 29 Nov 2017 16:48:13 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171129164813.GA3138@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171030112112.6952-1-quintela@redhat.com>
	<20171030112112.6952-6-quintela@redhat.com>
	<20171103100746.GC20155@redhat.com> <873756pkca.fsf@secure.mitica>
	<20171122125458.GE29565@redhat.com>
	<20171122125840.GF29565@redhat.com> <87609t9gso.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87609t9gso.fsf@secure.laptop>
Subject: Re: [Qemu-devel] [PATCH 5/6] migration: Now set the migration uri
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com

On Wed, Nov 29, 2017 at 05:43:35PM +0100, Juan Quintela wrote:
> "Daniel P. Berrange" <berrange@redhat.com> wrote:
> > On Wed, Nov 22, 2017 at 12:54:58PM +0000, Daniel P. Berrange wrote:
> >> On Wed, Nov 22, 2017 at 01:29:57PM +0100, Juan Quintela wrote:
> >> > "Daniel P. Berrange" <berrange@redhat.com> wrote:
> >> > > On Mon, Oct 30, 2017 at 12:21:11PM +0100, Juan Quintela wrote:
> 
> > > > This is bad as it is throwing away data that the original URI
> >> > > had. In particular
> >> > > you loose the 'ipv4=on|off' and 'ipv6=on|off' flags. If you need to keep the
> >> > > original URI for later, then why not just keep the 'host_port' parameter that
> >> > > was passed into this function instead of trying to reverse
> >> > > engineeer the URI ?
> >> > 
> >> > I don't need the original uri anymore, this is the incoming side of
> >> > migration, and we can only set that once, if migration fails, we need to
> >> > restart qemu anymore.
> >> > 
> >> > I changed it to this:
> >> > 
> >> >             new_uri = g_strdup_printf("tcp:%s:%s%s%s", address->u.inet.host,
> >> >                                       address->u.inet.port,
> >> >                                       iaddr->has_ipv4 ? ",ipv4" : "",
> >> >                                       iaddr->has_ipv6 ? ",ipv6" : "");
> >> > 
> >> > 
> >> > Clearly, we don't care about the to= parameter.
> >> > 
> >> > The whole point of this exercise is that in destination, we use
> >> > 
> >> > -incoming tcp:0:0
> >> > 
> >> > and with the output of info migrate_parameters (uri) we are able to
> >> > migrate to that place.  For rest of migration posibilities, there is no
> >> > changes at all.
> >> 
> >> That doesn't work typically. When the incoming QEMU listens for connections,
> >> by default it will listen on 0.0.0.0, or ::, so that's what the address
> >> you're creating will contain.  You can't use 0.0.0.0 or :: in a connect()
> >> call on the other side as that's a wildcard address that refers to "any 
> >> valid IP address on the current host".
> >> 
> >> When you connect to the listening QEMU you need the actual IP address
> >> of one (of the possibly many) NICs on the target host.  IOW, the only
> >> time the listen address is useful is if you have told QEMU to listen on
> >> a specific NIC's IP address, instead of the wildcard address.
> >> 
> >> This is the core reason why libvirt calls 'gethostname()' on the target
> >> host to identify the primary IP address of the host, and uses that on the
> >> source host to establish the connection.
> >
> > I should have said the port number info will still be useful (if you're
> > using the dynamic port allocation), it is just the IP address that's not
> > usable in general.
> 
> I gave up O:-)
> 
> I introduced tcp_port parameter, that is really what I wanted to know.
> The test use case (the one that I am interested right now) is that I
> do:
> 
> qemu-system-x86_64 ..... --incomping tcp:127.0.0.1:0
> 
> And I want to know the port that the destination gets to connect to it.
> For migration, it don't really matters if we _also_ set the
> address/ip/whatever it gets translated to, because it is not possible
> right now to restart the migration incoming side (you need to restart
> qemu for long and boring historic reasons).
> 
> So, I ended just adding:
> 
> +#
> +# @tcp-port: Only used for tcp, to know what is the real port
> +#                     (Since 2.12)
>  #
> 
> And all the boilerplate code to access/setup this one.
> 
> BTW, I am not sure how  well the current code will work with a range of
> ports, because we don't have a way to tell the source which one the
> kernel/qemu decided to use O:-)

Ultimately I think we need to be able to report a full list of
SocketAddress structs representing the listening addresses, because
we will eventually be listening on multiple distinct sockets. Currently
if a hostname resolves to multiple IP addrs, we only listen on the first
successful IP, but I have patches that fix this so we listen on multiple
IPs....

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
