Received: from eggs.gnu.org ([2001:4830:134:3::10]:42759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ehr9e-0001Ao-4u
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 01:18:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ehr9c-0004y8-5x
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 01:18:26 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Sat,  3 Feb 2018 07:16:18 +0100
Message-Id: <20180203061621.7033-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] block/iscsi: fix ioctl cancel
 use-after-free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Felipe Franciosi <felipe@nutanix.com>, qemu-block@nongnu.org, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Peter Lieven <pl@kamp.de>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

v2:
 * It was unnecessary to avoid duplicate iscsi_schedule_bh() calls since this
   function already protects against duplicate calls internally [Stefan]

Patches 1 & 2 are cleanups.

Patch 3 fixes cancellation of ioctls.  Felipe showed me a trace where an acb is
cancelled and then completes twice.  The second time around crashes QEMU.

Compile-tested only.

Felipe: Please let us know if this fixes the issue you are seeing.  Thanks!

Stefan Hajnoczi (3):
  block/iscsi: drop unused IscsiAIOCB->buf field
  block/iscsi: take iscsilun->mutex in iscsi_timed_check_events()
  block/iscsi: fix ioctl cancel use-after-free

 block/iscsi.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

-- 
2.14.3
