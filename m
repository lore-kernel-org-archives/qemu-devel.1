Received: from eggs.gnu.org ([209.51.188.92]:39382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sir@cmpwn.com>) id 1gtfou-0001Fw-Cl
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:42:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sir@cmpwn.com>) id 1gtfot-0007Ym-Ix
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:42:24 -0500
Received: from mail.cmpwn.com ([45.56.77.53]:48594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sir@cmpwn.com>) id 1gtfot-0007SC-A7
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:42:23 -0500
Date: Tue, 12 Feb 2019 16:42:16 -0500
From: Drew DeVault <sir@cmpwn.com>
Message-ID: <20190212214216.GA17279@homura.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] Combining -loadvm and -snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I recently ran into an issue where I found I couldn't combine the
-loadvm and -snapshot flags, nor any conceivable combination of
alternate approaches like loadvm via the monitor. Independently, both
options work as expected, but together I get this error:

qemu-system-x86_64: Device 'virtio0' does not have the requested snapshot 'base'

The goal here is to resume the VM state from a snapshot, but to prevent
the guest from persisting writes to the underlying qcow2.

I started digging into the code to understand this problem more, and I
was pretty deep in the weeds when I realized what the underlying problem
probably was and the kind of refactoring necessary to fix it - so I'm
here to touch base before moving any further.

I believe this happens because -snapshot creates a temporary qcow2
overlaid on top of the disk you're using, and this overlay does not have
any snapshots copied, nor does any of the snapshot reading code (e.g.
qcow2_snapshot_list or qcow2_snapshot_goto) iterate over backing disks
to load their snapshots.

At first I was going to adjust the qcow2 snapshot loading code (those
two functions in particular) to read through their backends, but I'm a
little unfamiliar with this code and the refactoring is not minor so I
would like to get feedback from some of the wiser folks on this mailing
list before I sink too much time into this.

Thoughts?

--
Drew DeVault
