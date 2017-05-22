Received: from eggs.gnu.org ([2001:4830:134:3::10]:55301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dCpMD-0007eD-K6
	for qemu-devel@nongnu.org; Mon, 22 May 2017 11:34:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dCpM7-0002iW-EJ
	for qemu-devel@nongnu.org; Mon, 22 May 2017 11:34:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dCpM7-0002i3-85
	for qemu-devel@nongnu.org; Mon, 22 May 2017 11:34:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3A11A7F6AC
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 15:34:46 +0000 (UTC)
Date: Mon, 22 May 2017 16:34:38 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170522153438.GC25655@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170519180342.19618-1-berrange@redhat.com>
	<20170519180342.19618-3-berrange@redhat.com>
	<cfb86d90-8a74-ed2c-ae15-feb7d628f197@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cfb86d90-8a74-ed2c-ae15-feb7d628f197@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] sockets: don't block IPv4 clients
 when listening on "::"
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

On Mon, May 22, 2017 at 10:30:55AM -0500, Eric Blake wrote:
> On 05/19/2017 01:03 PM, Daniel P. Berrange wrote:
> > When inet_parse() parses the hostname, it is forcing the
> > has_ipv6 && ipv6 flags if the address contains a ":". This
> > means that if the user had set the ipv4=on flag, to try to
> > restrict the listener to just ipv4, an error would not have
> > been raised.  eg
> > 
> >    -incoming tcp:[::]:9000,ipv4
> > 
> > should have raised an error because listening for IPv4
> > on "::" is a non-sensical combination.
> 
> If I understand correctly, the correct response (and post-patch
> behavior) is an error (mismatch between requesting IPv4-only usage while
> giving an IPv6 address), but the buggy response (pre-patch behavior) is
> that we ended up setting ipv6 in addition to the user-set ipv4 (because
> we found a ':'), and then end up listening on IPv6 after all contrary to
> the user's request.

Yes, with this patch you get this error:

  qemu-system-x86_64: -incoming tcp:[::]:9000,ipv4: address resolution
    failed for :::9000: Address family for hostname not supported

because it now (correctly) tries to resolve "::" as an IPv4 address
and fails (just like -chardev and -vnc already do)

> 
> 
> > With this removed,
> > we now call getaddrinfo() on "::" passing PF_INET and
> > so getaddrinfo reports an error about the hostname being
> > incompatible with the requested protocol.
> > 
> > Likewise it is explicitly setting the has_ipv4 & ipv4
> > flags when the address contains only digits + '.'. This
> > has no ill-effect, but also has no benefit, so is removed.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  util/qemu-sockets.c | 4 ----
> >  1 file changed, 4 deletions(-)
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
