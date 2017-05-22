Received: from eggs.gnu.org ([2001:4830:134:3::10]:54784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dCpKZ-0006gv-QB
	for qemu-devel@nongnu.org; Mon, 22 May 2017 11:33:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dCpKW-00022B-LU
	for qemu-devel@nongnu.org; Mon, 22 May 2017 11:33:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dCpKW-00021G-D7
	for qemu-devel@nongnu.org; Mon, 22 May 2017 11:33:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5CAC780C0A
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 15:33:07 +0000 (UTC)
Date: Mon, 22 May 2017 16:33:00 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170522153300.GB25655@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170519180342.19618-1-berrange@redhat.com>
	<20170519180342.19618-2-berrange@redhat.com>
	<073211ce-d3df-da9f-8c70-cafc2dd1270e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <073211ce-d3df-da9f-8c70-cafc2dd1270e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/5] sockets: ensure we can bind to both
 ipv4 & ipv6 separately
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

On Mon, May 22, 2017 at 10:26:09AM -0500, Eric Blake wrote:
> On 05/19/2017 01:03 PM, Daniel P. Berrange wrote:
> > When binding to an IPv6 socket we currently force the
> > IPV6_V6ONLY flag to off. This means that the IPv6 socket
> > will accept both IPv4 & IPv6 sockets when QEMU is launched
> > with something like
> > 
> >   -vnc :::1
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
> >  util/qemu-sockets.c | 31 +++++++++++++++++++++++--------
> >  1 file changed, 23 insertions(+), 8 deletions(-)
> > 
> 
> >          for (p = port_min; p <= port_max; p++) {
> > +#ifdef IPV6_V6ONLY
> > +            /* listen on both ipv4 and ipv6 */
> > +            int v6only = 0;
> > +#endif
> >              inet_setport(e, p);
> > +#ifdef IPV6_V6ONLY
> > +        rebind:
> > +            if (e->ai_family == PF_INET6) {
> 
> The rebind: label could go here with no change in semantics and one less
> conditional when compiled without optimization. But hopefully the
> compiler is smart enough to see that under -O2, so I don't see a reason
> for you to change the code.

Also bear in mind the running time of this method is going to be
dominated by the getaddrinfo() call most of the time, so I don't
think there's any measurable perf difference to moving the label.

> > +                qemu_setsockopt(slisten, IPPROTO_IPV6, IPV6_V6ONLY, &v6only,
> > +                                sizeof(v6only));
> > +            }
> > +#endif
> >              if (bind(slisten, e->ai_addr, e->ai_addrlen) == 0) {
> >                  goto listen;
> >              }
> > +
> > +#ifdef IPV6_V6ONLY
> > +            /* If we got EADDRINUSE from an IPv6 bind & V6ONLY is unset,
> > +             * it could be that the IPv4 port is already claimed, so retry
> > +             * with V6ONLY set
> > +             */
> > +            if (e->ai_family == PF_INET6 && errno == EADDRINUSE && !v6only) {
> > +                v6only = 1;
> > +                goto rebind;
> > +            }
> > +#endif
> > +
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
