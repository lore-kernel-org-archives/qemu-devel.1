Received: from eggs.gnu.org ([2001:4830:134:3::10]:51978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1ciFdy-0001Kx-Ep
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 02:22:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1ciFdv-0004Bc-At
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 02:22:50 -0500
Received: from [59.151.112.132] (port=18034 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1ciFdu-0004AR-Ty
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 02:22:47 -0500
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Date: Mon, 27 Feb 2017 15:30:24 +0800
Message-ID: <1488180627-18258-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/3] vfio-pci: support recovery of AER non
 fatal error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, alex.williamson@redhat.com, izumi.taku@jp.fujitsu.com

This is nearly new design of the feature, so re-number the verion from 0.

About The test:
Hardware problem(unsteady) still occurs like before. The test server is in
another country spot A, and my contact of the country located spot B, so
it is not quite convenient to find help(plug cable, or check the hardware).
So, my NIC(has 2 functions) still just has func1 connected to gateway.
If there is other people who has the hardware could test the patches, that
would be great help.


Basically, there are two phenomenon of unsteady hardware:
1. Start vm, the hardware emit fatal error itself before I did anything,
   cause vm stop.
2. Start vm, assign IP to func1, then ping the gateway, it will show
   "Destination Host Unreachable" after dozens of or hundreds of successful
   ping, and guest dmesg shows nothing abnormal.  I think this phenomenon is
   the *strong evidence* of saying unsteady hardware, I speculate that
   the cable has problem.

   on the opposite, I also saw perfect result 2 times in my numerous tests,
   which just assign func1 while func0 has no user. It can ping several housrs(
   more than 15000 times ping) withtout any problem, during the period, inject
   non fatal error to func0 & func1, error recovery is very good.

   So, most of time, I must do the test quickly before the hardware goes crazy,
   until get what I expected.


Test:
scenario 1: assign func1 to vm while func0 has no user.
scenario 2: assign both functions to 1 vm, with the same topology as host.
scenario 3: assign both functions to 1 vm, under different bus.
scenario 4: assign each function to a separate vm.

the steps is: assign IP to func1, ping the gateway, inject non fatal error to
both functions, see if func1 still can ping after recovery.

Although we don't have cable for func0, but in the test like scenario 4,
inject to func0, it doesn't affect func1's recovery, so I think it can prove
that one function's recovery doesn't affect another.


Extra info FYI:
1. During the test, some debug lines are added in vfio_err_notifier_handler,
   read the uncor status register in this function when fatal error occured,
   it shows all F's every time.
2. Based on the v10 patch & the corresponding kernel part, modified as
   comments: revert the eventfd handling(don't signal uncor status), and
   guest link reset will induce the host link reset. The test result shows:
   non fatal error recovery is good; fatal error recovery has same result
   with what Alex find before(guest kernel crash), because guest device
   driver's error_detected() access the MMIO registers, get all F's.


Cao jin (3):
  pcie aer: verify if AER functionality is available
  vfio pci: new function to init AER capability
  vfio-pci: process non fatal error of AER

 hw/pci/pcie_aer.c          |  28 +++++++
 hw/vfio/pci.c              | 180 +++++++++++++++++++++++++++++++++++++++++++--
 hw/vfio/pci.h              |   3 +
 linux-headers/linux/vfio.h |   1 +
 4 files changed, 207 insertions(+), 5 deletions(-)

-- 
1.8.3.1
