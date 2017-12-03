Received: from eggs.gnu.org ([2001:4830:134:3::10]:42937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eLZVp-0008HD-CB
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 14:01:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eLZVo-0004SQ-G6
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 14:01:13 -0500
Date: Sun, 3 Dec 2017 19:01:03 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20171203190103.GG2450@redhat.com>
References: <20171109165939.23154-1-eblake@redhat.com>
	<20171109165939.23154-4-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171109165939.23154-4-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PULL 3/8] nbd-client: Refuse read-only client
 with BDRV_O_RDWR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org, "open list:Network Block Dev..." <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Thu, Nov 09, 2017 at 10:59:34AM -0600, Eric Blake wrote:
> The NBD spec says that clients should not try to write/trim to
> an export advertised as read-only by the server.  But we failed
> to check that, and would allow the block layer to use NBD with
> BDRV_O_RDWR even when the server is read-only, which meant we
> were depending on the server sending a proper EPERM failure for
> various commands, and also exposes a leaky abstraction: using
> qemu-io in read-write mode would succeed on 'w -z 0 0' because
> of local short-circuiting logic, but 'w 0 0' would send a
> request over the wire (where it then depends on the server, and
> fails at least for qemu-nbd but might pass for other NBD
> implementations).
> 
> With this patch, a client MUST request read-only mode to access
> a server that is doing a read-only export, or else it will get
> a message like:
> 
> can't open device nbd://localhost:10809/foo: request for write access conflicts with read-only export

Nice one!

This caught 3 bugs in the nbdkit test suite where we were opening the
connection for write to a read-only server instance, and it happened
to work because the test did not write anything.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW
