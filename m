Received: from eggs.gnu.org ([2001:4830:134:3::10]:55144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fZ0J8-0005Be-Fi
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fZ0J7-0000lY-H3
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:47:54 -0400
From: Ari Sundholm <ari@tuxera.com>
Date: Fri, 29 Jun 2018 23:47:37 +0300
Message-ID: <1530305259-19184-1-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 0/2] New block driver: blklogwrites
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ari Sundholm <ari@tuxera.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

This patch series adds a new block driver, blklogwrites, to QEMU. The
driver is given two block devices: a raw device backed by an image or a
host block device, and a log device, typically backed by a file, on
which writes to the raw device are logged.

The logging format used is the same as in the dm-log-writes target of
the Linux kernel device mapper. The log reflects the writes that have
been performed on the guest block device and flushed. To be strict, the
log may contain writes that have not been flushed yet, but they are
technically outside the bounds of the log until the next flush updates
the metadata in the log superblock. We believe these semantics to be
useful even though they may not be completely identical to those of
dm-log-writes.

This functionality can be used for crash consistency and fs consistency
testing in filesystem drivers, including on non-Linux guests and older
guests running Linux versions without support for dm-log-writes. This
is simple and useful. Admittedly this and more advanced things could
perhaps be done by extending the quorum driver, but this approach would
require re-engineering the functionality and involve a more complicated
setup, so we offer this simple solution which we have found useful
internally.

In the first patch of this series, two block permission constants are
moved from block.c to include/block/block.h to make them available
outside of block.c. The next patch uses these constants.

In the second patch, the blklogwrites driver is introduced. The driver
accepts a target block device to be logged, a log device and an option
to set the sector size used for logging. All requests are aligned to
this sector size, and offsets and sizes in the log entries will be
expressed as a multiple of this value.

v6:
  - Remove patches containing the mechanism to pass block
    configurations to block drivers
  - Replace the use of the above-mentioned mechanism with an option to
    specify the sector size used for logging
  - Rebase on current upstream master

v5:
  - Reorder patches and squash blklogwrites driver patches together
  - Rebase on current upstream master
  - No functional changes

v4:
  - Check return value of snprintf() (flagged by patchew)
  - Don't use C99 for loop initial declaration (flagged by patchew, but
    wasn't QEMU supposed to be C99? Oh well.)
  - Add proper "Since" fields for blklogwrites in block-core.json
  - Rebase on current upstream master

v3:
  - Rebase on current upstream master

v2:
  - Incorporate review feedback
  - Add patches to apply block configurations in more block device
    drivers


Aapo Vienamo (1):
  block: Add blklogwrites

Ari Sundholm (1):
  block: Move two block permission constants to the relevant enum

 MAINTAINERS           |   6 +
 block.c               |   6 -
 block/Makefile.objs   |   1 +
 block/blklogwrites.c  | 392 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/block/block.h |   7 +
 qapi/block-core.json  |  33 ++++-
 6 files changed, 433 insertions(+), 12 deletions(-)
 create mode 100644 block/blklogwrites.c

-- 
2.7.4
