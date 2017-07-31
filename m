Received: from eggs.gnu.org ([2001:4830:134:3::10]:33692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dcD8d-0004YR-3t
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dcD8Z-0008Dm-6x
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:01:47 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:1163 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dcD8Y-0008D6-Sq
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:01:43 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 31 Jul 2017 19:01:31 +0300
Message-Id: <20170731160135.12101-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 0/4] trace-events: print 0x before hex
 numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, mreitz@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, stefanha@gmail.com, peter.maydell@linaro.org, berrange@redhat.com, cohuck@redhat.com

Hi all!

It is hard to read logs, when there are hex and dec numbers in one line, when
hex number doesn't contain any letters and don't have '0x' prefix.

So, here is a complete solution for the problem:

- add information into CODING_STYLE
- add a check into checkpatch.pl
- fix current state

The new rule for the style is:

Hex numbers should be prefixed by '0x', except groups of numbers,
separated by symbols ' ', '.', ':', '/', however '0x' can be used for
numbers in such groups too. Flag '#' in number format is not allowed.

Note: checkpatch fails on checkpatch change (03) due to long lines.
It is because checkpatch.pl is indented by tabs and when it checks
for long lines it consider tabs as 8 spaces. Looks like nobody cares,
so do I. I see two ways here:
 -  s/\t/    /g
 -  make exclusion in checkpatch.pl for checkpatch.pl to consider tabs
    as 4 spaces, not 8.  However I don't want to fix it in the context
    of these series.

v3: 01 - rewording
    02 - adjust commit message - add two printf flags "'I" into a check
         add Stefan's and Eric's r-bs
    03 - fix commit message s/Accordingly/According/
         add Stefan's r-b
    04 - add Stefan's r-b
         add Cornelia's a-b
v2: almost everything (style, checkpatch, excluding number groups)
V1: was a draft of the idea using two sed commands.

Vladimir Sementsov-Ogievskiy (4):
  coding_style: add point about 0x in trace-events
  trace-events: fix code style: %# -> 0x%
  checkpatch: check trace-events code style
  trace-events: fix code style: print 0x before hex numbers

 CODING_STYLE              |  35 +++++++++
 accel/tcg/trace-events    |   2 +-
 audio/trace-events        |   4 +-
 block/trace-events        |  28 ++++----
 hw/audio/trace-events     |   4 +-
 hw/char/trace-events      |  12 ++--
 hw/display/trace-events   |  14 ++--
 hw/dma/trace-events       |  20 +++---
 hw/i386/xen/trace-events  |  26 +++----
 hw/input/trace-events     |   6 +-
 hw/intc/trace-events      | 176 +++++++++++++++++++++++-----------------------
 hw/isa/trace-events       |   4 +-
 hw/misc/trace-events      |  78 ++++++++++----------
 hw/net/trace-events       |  52 +++++++-------
 hw/nvram/trace-events     |   2 +-
 hw/pci/trace-events       |   4 +-
 hw/ppc/trace-events       |  64 ++++++++---------
 hw/s390x/trace-events     |  20 +++---
 hw/scsi/trace-events      | 118 +++++++++++++++----------------
 hw/sd/trace-events        |   4 +-
 hw/timer/trace-events     |  20 +++---
 hw/usb/trace-events       |  56 +++++++--------
 hw/vfio/trace-events      |  44 ++++++------
 hw/virtio/trace-events    |   6 +-
 hw/xen/trace-events       |   8 +--
 linux-user/trace-events   |  10 +--
 migration/trace-events    |  36 +++++-----
 nbd/trace-events          |  18 ++---
 net/trace-events          |   4 +-
 scripts/checkpatch.pl     |  19 +++++
 target/arm/trace-events   |  10 +--
 target/s390x/trace-events |   2 +-
 target/sparc/trace-events |  30 ++++----
 trace-events              |  20 +++---
 34 files changed, 505 insertions(+), 451 deletions(-)

-- 
2.11.1
