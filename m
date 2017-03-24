Received: from eggs.gnu.org ([2001:4830:134:3::10]:37855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1crTKT-00025p-Et
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:48:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1crTKS-0003Ha-JB
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:48:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1crTKS-0003HN-EC
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:48:48 -0400
Date: Fri, 24 Mar 2017 18:48:44 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170324174844.GC3823@noname.redhat.com>
References: <87mvccaqhb.fsf@dusky.pond.sub.org>
	<20170324154710.GC5849@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170324154710.GC5849@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] Question nbd_refresh_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 24.03.2017 um 16:47 hat Stefan Hajnoczi geschrieben:
> On Thu, Mar 23, 2017 at 05:48:48PM +0100, Markus Armbruster wrote:
> > BlockdevOptionsNbd has a member SocketAddress, and nbd_config() doesn't
> > restrict variants.  Thus, all four SOCKET_ADDRESS_KIND_ can occur.
> > 
> > Now have a look at nbd_refresh_filename().  s->saddr->type is If
> > SOCKET_ADDRESS_KIND_VSOCK or SOCKET_ADDRESS_KIND_FD, then @host, @port
> > and @path all remain null, and bs->exact_filename[] is not touched.
> > 
> > Does this work as intended?
> 
> NDB over AF_VSOCK has not been tested.  I would expect it to fail
> earlier than nbd_refresh_filename().

Why would that be? Do the socket creation helper functions not support
vsock yet?

> It's certainly possible to come up with the host=,port= for AF_VSOCK.
> 
> Not sure about file descriptor passing.  Either we could getsockaddr()
> and print out the host=,port= or path= (depending on the address
> family), or we could use some syntax for referring to the file
> descriptor.

The point of .bdrv_refresh_filename is to provide a "nicer" filename for
humans, but it still needs to be a valid input. We do accept URLs as a
convenience feature for NBD connections over TCP and Unix domain
sockets, so we create a filename for those. For everything else, we
require individual options rather than a URL and should therefore not
create a filename. The block layer creates a json: description then.

Kevin
