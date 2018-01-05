Received: from eggs.gnu.org ([2001:4830:134:3::10]:40730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eXLv3-0003hh-4P
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 01:55:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eXLv2-0002NV-EW
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 01:55:57 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri,  5 Jan 2018 14:55:36 +0800
Message-Id: <20180105065538.13375-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] qemu-img: Let "info" warn and go ahead
 without -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Management and users are accustomed to "qemu-img info" to query status of
images even when they are used by guests. Since image locking was added, the -U
(--force-share) option is needed for that to work. The reason has been that due
to possible race with image header update, the output can be misleading.

But what are likely to happen after we emit the error are that, for interactive
users, '-U' will be used and the command retried; for management (nova, RHV,
etc.), the operation is broken with no knob to workaround this.

This series changes that error to a warning so that it doesn't get in the way.

Fam

Fam Zheng (2):
  qemu-img: Move img_open error reporting to callers
  qemu-img: info: try -U automatically

 qemu-img.c                 | 129 +++++++++++++++++++++++++++++----------------
 tests/qemu-iotests/043.out |   6 +--
 tests/qemu-iotests/153.out |   3 +-
 3 files changed, 88 insertions(+), 50 deletions(-)

-- 
2.14.3
