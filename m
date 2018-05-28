Received: from eggs.gnu.org ([2001:4830:134:3::10]:44581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fNPdr-0007lD-O0
	for qemu-devel@nongnu.org; Mon, 28 May 2018 17:25:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fNPdq-0006Bu-DL
	for qemu-devel@nongnu.org; Mon, 28 May 2018 17:25:23 -0400
Date: Mon, 28 May 2018 22:25:10 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180528212510.GC4660@redhat.com>
References: <20180518180440-mutt-send-email-mst@kernel.org>
	<20180524113251.GB4660@redhat.com>
	<d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
	<20180528183058.GG2209@redhat.com>
	<20180528183833.GJ4580@localhost.localdomain>
	<20180528212054.GH2209@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528212054.GH2209@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: ehabkost@redhat.com, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, stefanha@redhat.com

On Mon, May 28, 2018 at 10:20:54PM +0100, Richard W.M. Jones wrote:
> On Mon, May 28, 2018 at 08:38:33PM +0200, Kevin Wolf wrote:
> > Just accessing the image file within a tar archive is possible and we
> > could write a block driver for that (I actually think we should do
> > this), but it restricts you because certain operations like resizing
> > aren't really possible in tar. Unfortunately, resizing is a really
> > common operation for non-raw image formats.
> 
> We do this already in virt-v2v (using file.offset and file.size
> parameters in the raw driver).
> 
> For virt-v2v we only need to read the source so resizing isn't an
> issue.  For most of the cases we're talking about the downloaded image
> would also be a template / base image, so I suppose only reading would
> be required too.
> 
> I also wrote an nbdkit tar file driver (supports writes, but not
> resizing).
> https://manpages.debian.org/testing/nbdkit-plugin-perl/nbdkit-tar-plugin.1.en.html

I should add the other thorny issue with OVA files is that the
metadata contains a checksum (SHA1 or SHA256) of the disk images.  If
you modify the disk images in-place in the tar file then you need to
recalculate those.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/
