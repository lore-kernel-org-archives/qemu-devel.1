Received: from eggs.gnu.org ([2001:4830:134:3::10]:33308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ceIZ7-0007D0-JH
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 04:41:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ceIZ3-00070v-TC
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 04:41:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ceIZ3-00070m-NS
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 04:41:25 -0500
Date: Thu, 16 Feb 2017 09:41:20 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170216094120.GD7346@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170215182732.GN24672@redhat.com>
	<5ae6dee4-779b-7073-4192-21554b8a2b62@redhat.com>
	<20170216093203.GA7346@redhat.com>
	<a964ee79-d160-207d-34e8-de480fdf3e23@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a964ee79-d160-207d-34e8-de480fdf3e23@redhat.com>
Subject: Re: [Qemu-devel] RFC: How to make seccomp reliable and useful ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Otubo <eduardo.otubo@profitbricks.com>

On Thu, Feb 16, 2017 at 10:37:31AM +0100, Thomas Huth wrote:
> On 16.02.2017 10:32, Daniel P. Berrange wrote:
> > On Thu, Feb 16, 2017 at 09:38:59AM +0100, Thomas Huth wrote:
> >> I like your proposal! I just wanted to add an idea for an additional
> >> parameter (not sure whether it is feasible, though): Something like
> >> "-sandbox on,network=off" ... i.e. forbid all system calls that are used
> >> for networking. Rationale: Sometimes your VM does not need any
> >> networking, and you want to make sure that a malicious guest can also
> >> not reach your local network in that case.
> > 
> > This is pretty tricky. Even if there is not obviously configured network
> > backend in QEMU, there's plenty of scope for things in libraries to
> > be using networking. Something want a fully qualified hostname ? That'll
> > trigger UDP / TCP connections to a DNS resolver. Running with the SDL
> > or GTK display frontends - those use networking over UNIX sockets to
> > talk to a display server. Linked to glib2 ? That'll connect to DConf
> > over DBus UNIX socket in the background. etc
> 
> Oh, too bad. Aren't there at least some system calls which could be used
> to block TCP/IP connections, while we still allow local UNIX sockets?
> ... hmm, maybe that's rather something to solve at the SELinux level
> instead...

seccomp lets you filter based on value of syscall arguments. So you could
filter out socket() calls with family != AF_UNIX.  This still leaves
potential trouble with DNS resolvers though, which can be valid to use
even if not wanting to make network connections. Annoyingly even if one
ran a localhost DNS resolver, there's no facility in /etc/resolv.conf
to specify a UNIX socket for talking to it - it'd have to use TCP over
localhost :-(

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
