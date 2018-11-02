Received: from eggs.gnu.org ([2001:4830:134:3::10]:56202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=837a4a9fa=tim.smith@citrix.com>)
	id 1gIVmB-0000Dl-Sp
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 05:30:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=837a4a9fa=tim.smith@citrix.com>)
	id 1gIVm8-0003X2-JU
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 05:29:59 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:4352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=837a4a9fa=tim.smith@citrix.com>)
	id 1gIVm8-0003WP-AS
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 05:29:56 -0400
From: Tim Smith <tim.smith@citrix.com>
Date: Fri, 2 Nov 2018 09:29:45 +0000
Message-ID: <154115098499.664.15585399091081300567.stgit@dhcp-3-135.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 0/3] Performance improvements for xen_disk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <Paul.Durrant@citrix.com>

A series of performance improvements for disks using the Xen PV ring.

These have had fairly extensive testing.

The batching and latency improvements together boost the throughput
of small reads and writes by two to six percent (measured using fio
in the guest)

Avoiding repeated calls to posix_memalign() reduced the dirty heap
from 25MB to 5MB in the case of a single datapath process while also
improving performance.

---

Tim Smith (3):
      Improve xen_disk batching behaviour
      Improve xen_disk response latency
      Avoid repeated memory allocation in xen_disk


 hw/block/xen_disk.c |   82 +++++++++++++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 36 deletions(-)

--
Tim Smith <tim.smith@citrix.com>
