Received: from eggs.gnu.org ([2001:4830:134:3::10]:52440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f81QF-0001df-WC
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 06:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f81QE-0008PC-LR
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 06:31:44 -0400
Date: Mon, 16 Apr 2018 11:31:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180416103118.GH17600@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180413192605.2145-1-nirsof@gmail.com>
	<20180413192605.2145-2-nirsof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180413192605.2145-2-nirsof@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] nbd: Add option to disallow listing
 exports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nirsof@gmail.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, rjones@redhat.com, mreitz@redhat.com, pbonzini@redhat.com

On Fri, Apr 13, 2018 at 10:26:03PM +0300, Nir Soffer wrote:
> When a management application expose images using qemu-nbd, it needs a
> secure way to allow temporary access to the disk. Using a random export
> name can solve this problem:
> 
>     nbd://server:10809/22965f19-9ab5-4d18-94e1-cbeb321fa433
> 
> Assuming that the url is passed to the user in a secure way, and the
> user is using TLS to access the image.
> 
> However, since qemu-nbd implements NBD_OPT_LIST, anyone can easily find
> the secret export:
> 
>     $ nbd-client -l server 10809
>     Negotiation: ..
>     22965f19-9ab5-4d18-94e1-cbeb321fa433
> 
> Add a new --nolist option, disabling listing, similar the "allowlist"
> nbd-server configuration option.
> 
> When used, listing exports will fail like this:
> 
>     $ nbd-client -l localhost 10809
>     Negotiation: ..
> 
>     E: listing not allowed by server.
>     Server said: Listing exports is forbidden

Essentially this is abusing the export name as a crude authentication
token. There are NBD servers that expect NBD_OPT_LIST to always succeeed
when they detect that the new style protocol is available. I really hate
the idea of making it possible to break the NBD_OPT_LIST functionality
via a command line arg like this.

Furthermore, applications are *not* considering the export names to be
security sensitive data, so will not be taking any precautions to ensure
they remain secret, as they would do with authentication credentials.
Again I really hate the idea of using NBD exports an an auth credential.

So I don't think we should be suggesting that security through obscurity of
the export name is a supported approach to securing NBD.

I understand the desire to be able to secure NBD exports though, so think
we need to come up with some kind of supportable solution for this. There
are two approaches we should take

 - Add support for TLS client certification whitelisting. eg every client
   has a unique identity based on the distinguished name (dname) in the
   x509 cert they were issued. The NBD server can be told which of these
   dnames should be a permitted to connect. This is supported in VNC for
   years, and I've had patches pending to support this in a QEMU for chardevs
   NBD and migration for a while. These were stalled on way to convert
   -object ... syntax into nested QOM objects.

 - Define a mapping of the SASL protocol ontop NBD. SASL is a generic pluggable
   authentication mechanism for network protocols. It is already used in
   libvirt, VNC and SPICE, and would easily fit in with NBD from a conceptual
   POV. When used in combination with TLS, this offers a wide range of auth
   mechanisms from simple username+password, to full integration with Kerberos.

If this need is urgent, I think we could partially unblock the TLS x509
whitelisting support without much difficulty. We haven't been pushing hard
to unblock it simply because no one was urgently blocked by its absence
so far. This provides a strong solution, but the difficulty is that the
server may not know the x509 dname of the permitted client, which makes
it hard to use in practice. SASL with a simple username+password scheme
is thus still very compelling to implement, but will obviously  take longer
due to the amount of code/spec work required.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
