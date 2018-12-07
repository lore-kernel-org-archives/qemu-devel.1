Received: from eggs.gnu.org ([2001:4830:134:3::10]:54591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=87219212e=anthony.perard@citrix.com>)
	id 1gVKkO-0002hd-RD
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 13:21:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=87219212e=anthony.perard@citrix.com>)
	id 1gVKkK-0004sL-RD
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 13:21:08 -0500
Date: Fri, 7 Dec 2018 18:20:54 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181207182054.GM18875@perard.uk.xensource.com>
References: <1544108924-10841-1-git-send-email-paul.durrant@citrix.com>
	<1544108924-10841-15-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1544108924-10841-15-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v2 14/18] xen: add implementations of
 xen-block connect and disconnect functions...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Thu, Dec 06, 2018 at 03:08:40PM +0000, Paul Durrant wrote:
> ...and wire in the dataplane.
> 
> This patch adds the remaining code to make the xen-block XenDevice
> functional. The parameters that a block frontend expects to find are
> populated in the backend xenstore area, and the 'ring-ref' and
> 'event-channel' values specified in the frontend xenstore area are
> mapped/bound and used to set up the dataplane.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

With this patch, we should be able to have QEMU instantiate a new
backend for a guest, right ? (via command line or QMP)

I've tried, and that doesn't work, the xenstore path for the frontend is
wrong. In the qemu trace, I have:
    xs_node_create /local/domain/0/backend/xen-disk/23/268572709
Which is probably fine, even if not described in xenstore-paths.markdown.
    xs_node_create /local/domain/23/device/xen-disk/268572709
Which is not, instead of "xen-disk", we should have "vbd".

I know that this is fixed in "xen: automatically create
XenBlockDevice-s", but at least the "vbd" type couldn't be added in this
patch, or maybe a previous one.


Another issue seems to be error handling. I've done a very simple test,
I've added '-device xen-disk,vdev=d536p37,id=mydisk' to the command
line (which is obvious wrong), and QEMU abort with:
    qemu-system-i386: hw/block/xen-block.c:174: xen_block_realize: Assertion `conf->blk' failed.
But I've pointed out the error in the code below.


And just for fun, adding then removing a xen-disk via QMP. Adding works
fine (once I've fixed the frontend name). I've run the following with
./scripts/qmp/qmp-shell:
blockdev-add driver=file  filename=/root/vm/disk/testing-disk.qcow2 node-name=emptyfile
blockdev-add driver=qcow2 node-name=emptyqcow2 file=emptyfile
device_add driver=xen-disk vdev=xvdn id=fromqmp drive=emptyqcow2

But, then, remove doesn't work, running "device_del id=fromqmp" doesn't
do anything. I guess we can try to fix that later if you don't find
what's missing.

> @@ -76,6 +151,7 @@ static void xen_block_realize(XenDevice *xendev, Error **errp)
>      const char *type = object_get_typename(OBJECT(blockdev));
>      XenBlockVdev *vdev = &blockdev->vdev;
>      Error *local_err = NULL;
> +    BlockConf *conf = &blockdev->conf;
>  
>      if (vdev->type == XEN_BLOCK_VDEV_TYPE_INVALID) {
>          error_setg(errp, "vdev property not set");
> @@ -90,6 +166,59 @@ static void xen_block_realize(XenDevice *xendev, Error **errp)
>              error_propagate(errp, local_err);

You probably want to add a return here, this is when
`blockdev_class->realize' fails.

>          }
>      }
> +
> +    /*
> +     * The blkif protocol does not deal with removable media, so it must
> +     * always be present, even for CDRom devices.
> +     */
> +    assert(conf->blk);

That assert should probably not be there, as a missing conf->blk isn't a
programming error, but a user error, I think.

Actually, the issue is the missing return abrove, and the assert is
probably fine.

-- 
Anthony PERARD
