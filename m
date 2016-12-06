Received: from eggs.gnu.org ([2001:4830:134:3::10]:59905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEC0G-0003mm-VW
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:25:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEC0B-00053B-CB
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:25:36 -0500
Date: Tue, 6 Dec 2016 10:25:23 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20161206092523.GA4990@noname.str.redhat.com>
References: <20161205234235.5728-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161205234235.5728-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] doc: Propose
 NBD_FLAG_INIT_ZEROES extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: nbd-general@lists.sourceforge.net, xieyingtai@huawei.com, subo7@huawei.com, qemu-block@nongnu.org, eric.fangyi@huawei.com, qemu-devel@nongnu.org, pbonzini@redhat.com

Am 06.12.2016 um 00:42 hat Eric Blake geschrieben:
> While not directly related to NBD_CMD_WRITE_ZEROES, the qemu
> team discovered that it is useful if a server can advertise
> whether an export is in a known-all-zeroes state at the time
> the client connects.

Does a server usually have the information to set this flag, other than
querying the block status of all blocks at startup? If so, the client
could just query this by itself.

The patch that was originally sent to qemu-devel just forwarded qemu's
.bdrv_has_zero_init() call to the server. However, what this function
returns is not a known-all-zeroes state on open, but just a
known-all-zeroes state immediately after bdrv_create(), i.e. creating a
new image. Then it becomes information that is easy to get and doesn't
involve querying all blocks (e.g. true for COW image formats, true for
raw on regular files, false for raw on block devices).

This is useful for 'qemu-img convert', which creates an image and then
writes the whole contents, but I'm not sure if this property is
applicable for NBD, which I think doesn't even have a create operation.

Kevin
