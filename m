Received: from eggs.gnu.org ([2001:4830:134:3::10]:43374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cyEQB-0003ZC-J7
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:18:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cyEQ7-0002ws-9s
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:18:39 -0400
Date: Wed, 12 Apr 2017 11:18:19 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170412091819.GB4955@noname.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] migrate -b problems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, famz@redhat.com, quintela@redhat.com, dgilbert@redhat.com

Hi all,

after getting assertion failure reports for block migration in the last
minute, we just hacked around it by commenting out op blocker assertions
for the 2.9 release, but now we need to see how to fix things properly.
Luckily, get_maintainer.pl doesn't report me, but only you. :-)

The main problem I see with the block migration code (on the
destination) is that it abuses the BlockBackend that belongs to the
guest device to make its own writes to the image file. If the guest
isn't allowed to write to the image (which it now isn't during incoming
migration since it would conflict with the newer style of block
migration using an NBD server), writing to this BlockBackend doesn't
work any more.

So what should really happen is that incoming block migration creates
its own BlockBackend for writing to the image. Now we don't want to do
this anew for every incoming block, but ideally we'd just create all
necessary BlockBackends upfront and then keep using them throughout the
whole migration. Is there a way to get some setup/teardown callbacks
at the start/end of the migration that could initialise and free such
global data?

The other problem with block migration is that is uses a BlockBackend
name to identify which device is migrated. However, there can be images
that are not attached to any BlockBackend, or if it is, the BlockBackend
might be anonymous, so this doesn't work. I suppose changing the field
to "device name if available, node-name otherwise" would solve this.

Kevin
