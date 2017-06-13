Received: from eggs.gnu.org ([2001:4830:134:3::10]:57504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dKpUG-0002bX-Dd
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 13:20:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dKpUF-000100-LH
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 13:20:16 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 13 Jun 2017 19:20:04 +0200
Message-Id: <20170613172006.19685-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] block: Fix gcc 7 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

blkdebug and blkverify use snprintf() to generate a filename; however,
that may not fit into the target buffer (BDS.exact_filename). If so,
they generate a truncated and thus pretty much unusable filename. In
this case it's better to just not generate a filename at all (until we
have better infrastructure which is not bound by a static buffer size).

Also, gcc 7 warns about these snprintf() instances and these patches fix
these warnings. There is another one in hw/usb/bus.c which is not
addressed by this series.

Max Reitz (2):
  blkdebug: Catch bs->exact_filename overflow
  blkverify: Catch bs->exact_filename overflow

 block/blkdebug.c  | 10 +++++++---
 block/blkverify.c | 12 ++++++++----
 2 files changed, 15 insertions(+), 7 deletions(-)

-- 
2.9.4
