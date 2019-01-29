Received: from eggs.gnu.org ([209.51.188.92]:48041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=925720a60=anthony.perard@citrix.com>)
	id 1goSSJ-0005NR-F4
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 07:25:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=925720a60=anthony.perard@citrix.com>)
	id 1goSSG-0005Cf-TX
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 07:25:31 -0500
Date: Tue, 29 Jan 2019 12:25:14 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20190129122514.GB2306@perard.uk.xensource.com>
References: <20190123090849.7758-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190123090849.7758-1-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH] xen-block: handle resize callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: xen-devel@lists.xenproject.org, qemu-block@nongnu.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Wed, Jan 23, 2019 at 09:08:49AM +0000, Paul Durrant wrote:
> Some frontend drivers will handle dynamic resizing of PV disks, so set up
> the BlockDevOps resize_cb() method during xen_block_realize() to allow
> this to be done.

"will": which drivers are you thinking about? The Linux one seems to be
able to handle resize already.

About the Linux one, it check the new size only when the backend set
its "state" to "connected" again.
It's frontend seems to implement resize with
1fa73be6be65028a7543bba8f14474b42e064a1b.
There is this is the source code:
    static void blkfront_connect(struct blkfront_info *info)
    {
        // ...
        switch (info->connected) {
        case BLKIF_STATE_CONNECTED:
                /*
                 * Potentially, the back-end may be signalling
                 * a capacity change; update the capacity.
                 */

In the backend, Linux does this:
    xenbus_printf(xbt, dev->nodename, "sectors", "%llu", ...
    /*
     * Write the current state; we will use this to synchronize
     * the front-end. If the current state is "connected" the
     * front-end will get the new size information online.
     */
     xenbus_printf(xbt, dev->nodename, "state", "%d", dev->state);

Maybe the QEMU backend needs do to the same thing, and write its current
state again?

FreeBSD doesn't seems to care about resize.

And there is nothing in blkif.h about resizing :(.

Thanks,

-- 
Anthony PERARD
