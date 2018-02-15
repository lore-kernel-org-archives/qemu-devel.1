Received: from eggs.gnu.org ([2001:4830:134:3::10]:53418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1emMRR-0002On-35
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 11:31:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1emMRN-0007Xg-38
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 11:31:25 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 15 Feb 2018 18:30:53 +0200
Message-Id: <cover.1518711805.git.berto@igalia.com>
Subject: [Qemu-devel] [RFC PATCH 0/2] Allow checking and repairing corrupted
 internal snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

Here's a small series that prevents the user from opening corrupted
internal snapshots and allows 'qemu-img check' to detect and repair
them.

This is an RFC because I tried a few different approaches to deal with
this but I'm not 100% convinced with any of them.

What this one does is simply delete the corrupted snapshots when
'qemu-img check' is run with '-r all'.

Other possible alternatives:

- Do the same but with a different option ('-r snapshots' or whatever)
- Zero the L1 size field of the corrupted snapshots (so they're empty
  in practice) but leave them in the snapshot table, so the user would
  have to delete them manually afterwards.
- Ask interactively "Do you want to delete this snapshot?" for each
  one of them. This was mentioned in the mailing list, but is this
  really useful?

Berto

Alberto Garcia (2):
  qcow2: Allow checking and repairing corrupted internal snapshots
  qcow2: Check the L1 table parameters from all internal snapshots

 block/qcow2-snapshot.c     | 71 ++++++++++++++++++++++++++++++++++++++++++----
 block/qcow2.c              |  9 ++++--
 block/qcow2.h              |  4 ++-
 tests/qemu-iotests/080     | 16 ++++++++++-
 tests/qemu-iotests/080.out | 42 +++++++++++++++++++++++++--
 5 files changed, 131 insertions(+), 11 deletions(-)

-- 
2.11.0
