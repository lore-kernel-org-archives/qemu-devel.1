Received: from eggs.gnu.org ([2001:4830:134:3::10]:36553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gNIkR-0005YN-7v
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:36:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gNIkQ-00060K-HG
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:35:59 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Nov 2018 14:35:33 +0000
Message-Id: <20181115143535.5885-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-3.1 0/2] hw/block/onenand: fix
 out-of-bounds read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Thomas Huth <thuth@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

An off-by-one error in a switch case in onenand_read() allowed
a misbehaving guest to read off the end of a block of memory.
This bug was revealed now that QEMU supports execution from
device memory: if started with no guest image loaded,
"qemu-system-arm -M n800" will now try to execute by reading
from this device's registers until it gets to the offset
triggering the segfault. Previously it would have run into
the "can't execute from device memory" assert first.

As a followup, patch 2 fixes some reporting so that we don't
trigger a hw_error() for reads of unimplemented registers.
With the two patches, execution now successfully results in
QEMU emulating the guest being off in the weeds...
    
NB: the onenand device is used only by the "n800" and "n810"
machines, which are usable only with TCG, not KVM, so the
segfault is not a security issue.

thanks
-- PMM

Peter Maydell (2):
  hw/block/onenand: Fix off-by-one error allowing out-of-bounds read
  hw/block/onenand: use qemu_log_mask() for reporting

 hw/block/onenand.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

-- 
2.19.1
