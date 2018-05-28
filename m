Received: from eggs.gnu.org ([2001:4830:134:3::10]:43680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNN2X-0002mb-La
	for qemu-devel@nongnu.org; Mon, 28 May 2018 14:38:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fNN2W-0002qd-TL
	for qemu-devel@nongnu.org; Mon, 28 May 2018 14:38:41 -0400
Date: Mon, 28 May 2018 20:38:33 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180528183833.GJ4580@localhost.localdomain>
References: <20180518180440-mutt-send-email-mst@kernel.org>
	<20180524113251.GB4660@redhat.com>
	<d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
	<20180528183058.GG2209@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528183058.GG2209@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, ehabkost@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 28.05.2018 um 20:30 hat Richard W.M. Jones geschrieben:
> On Mon, May 28, 2018 at 08:10:32PM +0200, Max Reitz wrote:
> > As someone who is just naive and doesn't see the big picture, I don't
> > see what's wrong with using a tar file that contains the image and
> > additional data.
> 
> FWIW an OVA file is exactly this: an uncompressed tar file containing
> disk image(s) and metadata.

If we combine VM configuration and the disk image this way, I would
still want to directly use that combined thing without having to extract
its components first.

Just accessing the image file within a tar archive is possible and we
could write a block driver for that (I actually think we should do
this), but it restricts you because certain operations like resizing
aren't really possible in tar. Unfortunately, resizing is a really
common operation for non-raw image formats.

And if I think of a file format that can contain several different
things that can be individually resized etc., I end up with qcow2 in the
simple case or a full file system in the more complex case.

Kevin
