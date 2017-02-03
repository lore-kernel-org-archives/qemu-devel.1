Received: from eggs.gnu.org ([2001:4830:134:3::10]:52822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cZe7o-0000s8-Ak
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 08:42:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cZe7l-0008P9-7n
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 08:42:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cZe7l-0008P3-2O
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 08:42:01 -0500
Date: Fri, 3 Feb 2017 13:41:55 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170203134155.GJ10350@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170203120649.15637-1-berrange@redhat.com>
	<e33cb32f-b767-3f40-6543-33a7af513514@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e33cb32f-b767-3f40-6543-33a7af513514@msgid.tls.msk.ru>
Subject: Re: [Qemu-devel] [PATCH v3 0/8] Support multiple listening sockets
 per VNC server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

On Fri, Feb 03, 2017 at 04:29:43PM +0300, Michael Tokarev wrote:
> 03.02.2017 15:06, Daniel P. Berrange wrote:
> 
> >  - If a DNS name resolves to multiple distinct IP addresses,
> >    the VNC server is now able to listen on all of them
> > 
> >  - The -vnc argument syntax is extended to allow the 'vnc'
> >    and 'websocket' arguments to be listed multiple times.
> >    This allows a single VNC server to listen on multiple
> >    different names / addresses.
> 
> Why it's needed? To me it looks like to much for a very rarely
> useful thing, no? (Just thinking out loud, nothing more)

It is very common to have virtualization hosts with multiple network
interfaces and multiple address protocols. Wanting to restrict VNC
to listen on a subset of interfaces/addresses is pretty reasonable

eg, consider a host with

  eth0:  10.0.0.1
         2001:beef:1

  eth1:  192.168.0.1
         feed:beef:1

And you want VNC to only listen on the IP addresses associated with
the public interface eth1. With current QEMU this is impossible.

Even if you setup DNS e.g.

  internal.example.com A    10.0.0.1
                       AAAA 2001:beef:1

  public.example.com   A    192.168.0.1
                       AAAA feed:beef:1

and pass hostname public.example.com to QEMU -vnc, it'll only listen on
one of the two addresses the hostname resolves to. This series addresses
that flaw by making us open multiple listener sockets for all addresses
that are resolved.

Even with that flaw fixed, it is still unreasonable limited. There may
be multiple hostnames you wish VNC to listen on, or you may not have DNS
entries for the particular addresses you want VNC to listen on. Thus there
is need to allow for multiple addresses to be given to -vnc.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
