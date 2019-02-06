Received: from eggs.gnu.org ([209.51.188.92]:51222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1grQl6-0000EX-1W
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:13:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1grQZ8-0006pY-QM
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:00:53 -0500
Date: Wed, 6 Feb 2019 17:00:46 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20190206170046.GW12500@redhat.com>
References: <20190206152919.5532-1-mreitz@redhat.com>
	<20190206163704.GV12500@redhat.com>
	<0d644429-0b16-bc7c-c583-d4684e47adb1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d644429-0b16-bc7c-c583-d4684e47adb1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] block/ssh: Implement
 .bdrv_refresh_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Wed, Feb 06, 2019 at 05:42:15PM +0100, Max Reitz wrote:
> On 06.02.19 17:37, Richard W.M. Jones wrote:
> > On Wed, Feb 06, 2019 at 04:29:17PM +0100, Max Reitz wrote:
> >> This series implements .bdrv_refresh_filename() for the ssh block
> >> driver, along with an appropriate .bdrv_dirname() so we don't chop off
> >> query strings for backing files with relative filenames.
> >>
> >> This series depends on my "block: Fix some filename generation issues"
> >> series.
> >>
> >> Based-on: 20190201192935.18394-1-mreitz@redhat.com
> > 
> > I have verified that this doesn't appear to break the existing driver:
> > ssh connections to block devices still work as well as they did before
> > (which is to say, not very well, I wish we would replace this driver
> > with Pino Toscano's reimplementation that uses libssh1).
> > 
> > However I wasn't sure how I could trigger the bdrv_refresh_filename
> > code path, so I don't think I tested that.
> 
> One test case goes like this:
> 
> Before this series:
> 
> $ ./qemu-img create -f qcow2 /tmp/base.qcow2 64M
> $ ./qemu-img create -f qcow2 -b base.qcow2 /tmp/top.qcow2
> $ ./qemu-img info ssh://localhost/tmp/top.qcow2
> image: json:{"driver": "qcow2", "file": {"server.host": "localhost",
> "server.port": "22", "driver": "ssh", "path": "/tmp/top.qcow2"}}
> [...]
> backing file: base.qcow2 (cannot determine actual path)
> [...]
> $ ./qemu-io ssh://localhost/tmp/top.qcow2
> can't open device ssh://localhost/tmp/top.qcow2: Cannot generate a base
> directory for ssh nodes
> 
> 
> So the filename is weird and you cannot open overlays with relative
> backing files.
> 
> After this series:
> 
> $ ./qemu-img info ssh://localhost/tmp/top.qcow2
> image: ssh://maxx@localhost:22/tmp/top.qcow2
> [...]
> backing file: base.qcow2 (actual path:
> ssh://maxx@localhost:22/tmp/base.qcow2)
> $ ./qemu-io ssh://localhost/tmp/top.qcow2
> qemu-io> quit
> 
> The filename looks better and the image is usable.

I have to use ?host_key_check=no because of my modern ssh server.  I
see this error (with your patch series applied):

$ ./qemu-img info 'ssh://localhost/tmp/top.qcow2?host_key_check=no'
image: ssh://rjones@localhost:22/tmp/top.qcow2?host_key_check=no
...
backing file: base.qcow2 (cannot determine actual path)

$ ./qemu-io 'ssh://localhost/tmp/top.qcow2?host_key_check=no'
can't open device ssh://localhost/tmp/top.qcow2?host_key_check=no: Cannot generate a base directory with host_key_check set

I can see the error message in block/ssh.c:

static char *ssh_bdrv_dirname(BlockDriverState *bs, Error **errp)
{
    if (qdict_haskey(bs->full_open_options, "host_key_check")) {
        /*
         * We cannot generate a simple prefix if we would have to
         * append a query string.
         */
        error_setg(errp,
                   "Cannot generate a base directory with host_key_check set");

It seems as if bdrv_dirname is mis-designed?  Either it shouldn't
assume dirname is always a strict prefix of a path, or g_strconcatdir
[from bdrv_make_absolute_filename] should really be a bdrv_* function
so that block devices can override it.

In any case I don't think this should hold up the patch, so:

Tested-by: Richard W.M. Jones <rjones@redhat.com>

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW
