Received: from eggs.gnu.org ([2001:4830:134:3::10]:51968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fxqjK-0005jF-O5
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 05:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fxqjG-0003YV-IA
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 05:37:38 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu,  6 Sep 2018 12:37:00 +0300
Message-Id: <cover.1536226505.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v3 00/10] Misc reopen-related patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Hi,

as part of my blockdev-reopen work here's a new set of patches. This
doesn't implement yet the core functionality of the new reopen
command, but it does fix a few things that help us pave the way.
I believe that the next series after this one will be the last.

The main change is the removal of child references from the options
and explicit_options QDicts. This was already discussed in the
previous series[1], and here's the implementation.

Regards,

Berto

[1] https://lists.gnu.org/archive/html/qemu-block/2018-08/msg00474.html

v3:
- Patches 8 and 9: Don't leak the value returned by qemu_opt_get_del()

v2: https://lists.gnu.org/archive/html/qemu-block/2018-09/msg00011.html
- Patches 3 and 5: Make comments more explicit. [Max]
- Patch 6: Use qemu_opts_to_qdict() in bdrv_reopen_prepare() to put
  all unprocessed options back into the QDict. [Max]
- Patches 8-10: Use qemu_opt_get_del() and update commit messages to
  reflect the changes in patch 6. [Max]

v1: https://lists.gnu.org/archive/html/qemu-block/2018-08/msg00846.html
- Initial version

Output of backport-diff against v2:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/10:[----] [--] 'qemu-io: Fix writethrough check in reopen'
002/10:[----] [--] 'file-posix: x-check-cache-dropped should default to false on reopen'
003/10:[----] [--] 'block: Remove child references from bs->{options,explicit_options}'
004/10:[----] [--] 'block: Don't look for child references in append_open_options()'
005/10:[----] [--] 'block: Allow child references on reopen'
006/10:[----] [--] 'block: Forbid trying to change unsupported options during reopen'
007/10:[----] [--] 'file-posix: Forbid trying to change unsupported options during reopen'
008/10:[0009] [FC] 'block: Allow changing 'discard' on reopen'
009/10:[0003] [FC] 'block: Allow changing 'detect-zeroes' on reopen'
010/10:[----] [--] 'block: Allow changing 'force-share' on reopen'

Alberto Garcia (10):
  qemu-io: Fix writethrough check in reopen
  file-posix: x-check-cache-dropped should default to false on reopen
  block: Remove child references from bs->{options,explicit_options}
  block: Don't look for child references in append_open_options()
  block: Allow child references on reopen
  block: Forbid trying to change unsupported options during reopen
  file-posix: Forbid trying to change unsupported options during reopen
  block: Allow changing 'discard' on reopen
  block: Allow changing 'detect-zeroes' on reopen
  block: Allow changing 'force-share' on reopen

 block.c               | 165 +++++++++++++++++++++++++++++++++-----------------
 block/file-posix.c    |   9 ++-
 include/block/block.h |   2 +
 qemu-io-cmds.c        |   2 +-
 4 files changed, 120 insertions(+), 58 deletions(-)

-- 
2.11.0
