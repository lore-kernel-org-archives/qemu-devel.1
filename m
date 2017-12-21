Received: from eggs.gnu.org ([2001:4830:134:3::10]:39500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eS1hw-0000Ld-DL
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:20:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eS1hs-00085u-5v
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:20:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eS1hr-00084x-ME
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:20:20 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DBC354E33A
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 14:20:18 +0000 (UTC)
Date: Thu, 21 Dec 2017 14:20:11 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171221142011.GH30327@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171221132717.30284-1-berrange@redhat.com>
	<20171221132717.30284-3-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171221132717.30284-3-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/2] char: allow passing pre-opened
 socket file descriptor at startup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>

On Thu, Dec 21, 2017 at 01:27:17PM +0000, Daniel P. Berrange wrote:
> When starting QEMU management apps will usually setup a monitor socket, and
> then open it immediately after startup. If not using QEMU's own -daemonize
> arg, this process can be troublesome to handle correctly. The mgmt app will
> need to repeatedly call connect() until it succeeds, because it does not
> know when QEMU has created the listener socket. If can't retry connect()
> forever though, because an error might have caused QEMU to exit before it
> even creates the monitor.
> 
> The obvious way to fix this kind of problem is to just pass in a pre-opened
> socket file descriptor for the QEMU monitor to listen on. The management app
> can now immediately call connect() just once. If connect() fails it knows
> that QEMU has exited with an error.
> 
> The SocketAddress(Legacy) structs allow for FD passing via the monitor, using
> the 'getfd' command, but only when using QMP JSON syntax. The HMP syntax has
> no way to initialize the SocketAddress(Legacy) 'fd' variant. So this patch
> first wires up the 'fd' parameter to refer to a monitor file descriptor,
> allowing HMP to use
> 
>    getfd myfd
>    chardev-add socket,fd=myfd
> 
> The SocketAddress 'fd' variant is currently tied to the use of the monitor
> 'getfd' command, so we have a chicken & egg problem with reusing that at
> startup wher no monitor connection is available. We could define that the
> special fd name prefix '/dev/fdset' refers to a FD passed via the CLI, but
> magic strings feel unpleasant.
> 
> Instead we define a SocketAddress 'fdset' variant that takes an fd set number
> that works in combination with the 'add-fd' command line argument. e.g.
> 
>   -add-fd fd=3,set=1
>   -chardev socket,fdset=1,id=mon
>   -mon chardev=mon,mode=control

Having written this, it occurs to me that using fdset for this is really
just adding uncessary complication.

The 'fd' parameter in SocketAddress is required to be a string that refers
to a named FD  passed over the monitor. I now see, however, that these
strings are forbidden to start with a digit. This means we could easily
re-use this facility to just directly reference a passed-in file descriptor
number, without clashing with named FD strings. eg we could do

   -chardev socket,fd=3,id=mon
   -mon chardev=mon,mode=control

This would simplify this patch significantly, and give close alignement
between the HMP & cli usage.



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
