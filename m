Received: from eggs.gnu.org ([2001:4830:134:3::10]:53071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d47Ms-00021k-8p
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:59:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d47Mo-0006ng-Cd
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:59:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d47Mo-0006n0-64
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 10:59:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 17A2B4E4D2
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 14:59:29 +0000 (UTC)
Date: Fri, 28 Apr 2017 15:59:21 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170428145921.GG11415@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170428121553.22408-1-berrange@redhat.com>
	<6f1ae51f-5336-7789-66b0-c4f984b5c0cc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6f1ae51f-5336-7789-66b0-c4f984b5c0cc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] sockets: ensure we can bind to both ipv4 &
 ipv6 separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Fri, Apr 28, 2017 at 09:57:24AM -0500, Eric Blake wrote:
> On 04/28/2017 07:15 AM, Daniel P. Berrange wrote:
> > When binding to an IPv6 socket we currently force the
> > IPV6_V6ONLY flag to off. This means that the IPv6 socket
> > will accept both IPv4 & IPv6 sockets when QEMU is launched
> > with something like
> > 
> >   -vnc :::1
> 
> At first glance, I thought that was too many :.  But I guess it is
> parsed as host:screen, with host of '::', and port offset of '1'...

Yeah, I was amazed when it actually worked in fact :-) I thought
I was going to have to use {::}:1, but it seems we reverse search
for the last ':'.

> 
> > 
> > While this is good for that case, it is bad for other
> > cases. For example if an empty hostname is given,
> > getaddrinfo resolves it to 2 addresses 0.0.0.0 and ::,
> > in that order. We will thus bind to 0.0.0.0 first, and
> > then fail to bind to :: on the same port. The same
> > problem can happen if any other hostname lookup causes
> > the IPv4 address to be reported before the IPv6 address.
> > 
> > When we get an IPv6 bind failure, we should re-try the
> > same port, but with IPV6_V6ONLY turned on again, to
> > avoid clash with any IPv4 listener.
> > 
> > This ensures that
> > 
> >   -vnc :1
> 
> ...and matches this being parsed as host of '' and port offset of '1'
> 
> > 
> > will bind successfully to both 0.0.0.0 and ::, and also
> > avoid
> > 
> >   -vnc :1,to=2
> > 
> > from mistakenly using a 2nd port for the :: listener.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  util/qemu-sockets.c | 30 ++++++++++++++++++++++--------
> >  1 file changed, 22 insertions(+), 8 deletions(-)
> > 
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 




Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
