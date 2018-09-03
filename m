Received: from eggs.gnu.org ([2001:4830:134:3::10]:36697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fwpwh-0004G2-SM
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 10:35:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fwpwc-0000Yx-Na
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 10:35:15 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Mon,  3 Sep 2018 17:33:58 +0300
Message-Id: <cover.1535983918.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 00/10] Misc reopen-related patches
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

v2:
- Patches 3 and 5: Make comments more explicit. [Max]
- Patch 6: Use qemu_opts_to_qdict() in bdrv_reopen_prepare() to put
  all unprocessed options back into the QDict. [Max]
- Patches 8-10: Use qemu_opt_get_del() and update commit messages to
  reflect the changes in patch 6. [Max]

v1: https://lists.gnu.org/archive/html/qemu-block/2018-08/msg00846.html
- Initial version

Output of backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/10:[----] [--] 'qemu-io: Fix writethrough check in reopen'
002/10:[----] [--] 'file-posix: x-check-cache-dropped should default to false on reopen'
003/10:[0003] [FC] 'block: Remove child references from bs->{options,explicit_options}'
004/10:[----] [--] 'block: Don't look for child references in append_open_options()'
005/10:[0005] [FC] 'block: Allow child references on reopen'
006/10:[down] 'block: Forbid trying to change unsupported options during reopen'
007/10:[----] [--] 'file-posix: Forbid trying to change unsupported options during reopen'
008/10:[0003] [FC] 'block: Allow changing 'discard' on reopen'
009/10:[0002] [FC] 'block: Allow changing 'detect-zeroes' on reopen'
010/10:[0002] [FC] 'block: Allow changing 'force-share' on reopen'

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

 block.c               | 161 +++++++++++++++++++++++++++++++++-----------------
 block/file-posix.c    |   9 ++-
 include/block/block.h |   2 +
 qemu-io-cmds.c        |   2 +-
 4 files changed, 117 insertions(+), 57 deletions(-)

-- 
2.11.0
