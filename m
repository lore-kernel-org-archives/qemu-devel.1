Received: from eggs.gnu.org ([2001:4830:134:3::10]:35112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyIog-0005rz-3u
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyIoY-00005p-JW
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:04:46 -0400
Date: Tue, 20 Mar 2018 16:04:21 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180320150421.GC4865@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] luks: Initial content of unwritten blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, eblake@redhat.com

Hi,

I just tried to add luks support to qemu-iotests 025, a basic resize
test, which made me realise that luks doesn't read zeros in unwritten
blocks (which makes the test fail).

The reason for this is that we get zeros on the protocol layer (i.e. in
the encrpyted data as it is on the disk), but not in the decrpyted
format layer.

Now I'm wondering if that's a problem. Not reading zeros in the guest is
unusual, but not unheard of (e.g. host_device), but visible zeros in the
image file could be considered an information leak. On the other hand,
qcow2 metadata for encrypted images is visible, too, so that's really
just the same thing.

What do you think, is the current behaviour good enough or should we
essentially enforce full preallocation for luks images and initialise
the image so that zeros are visible on the format layer, but random
encrypted stuff on the protocol layer?

Either way, we should probably document the decision somewhere as
intentional.

Kevin
