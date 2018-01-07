Received: from eggs.gnu.org ([2001:4830:134:3::10]:46100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eYA87-0007Fs-5m
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 07:32:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eYA83-0003We-Uj
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 07:32:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eYA83-0003W1-M7
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 07:32:43 -0500
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Sun,  7 Jan 2018 14:32:22 +0200
Message-Id: <20180107123224.100877-4-marcel@redhat.com>
In-Reply-To: <20180107123224.100877-1-marcel@redhat.com>
References: <20180107123224.100877-1-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH V6 3/5] docs: add pvrdma device documentation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, yuval.shaia@oracle.com, marcel@redhat.com, pbonzini@redhat.com, mst@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
---
 docs/pvrdma.txt | 254 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 254 insertions(+)
 create mode 100644 docs/pvrdma.txt

diff --git a/docs/pvrdma.txt b/docs/pvrdma.txt
new file mode 100644
index 0000000000..8d004b79a1
--- /dev/null
+++ b/docs/pvrdma.txt
@@ -0,0 +1,254 @@
+Paravirtualized RDMA Device (PVRDMA)
+====================================
+
+
+1. Description
+===============
+PVRDMA is the QEMU implementation of VMware's paravirtualized RDMA device.
+It works with its Linux Kernel driver AS IS, no need for any special guest
+modifications.
+
+While it complies with the VMware device, it can also communicate with bare
+metal RDMA-enabled machines and does not require an RDMA HCA in the host, it
+can work with Soft-RoCE (rxe).
+
+It does not require the whole guest RAM to be pinned allowing memory
+over-commit and, even if not implemented yet, migration support will be
+possible with some HW assistance.
+
+A project presentation accompany this document:
+- http://events.linuxfoundation.org/sites/events/files/slides/lpc-2017-pvrdma-marcel-apfelbaum-yuval-shaia.pdf
+
+
+
+2. Setup
+========
+
+
+2.1 Guest setup
+===============
+Fedora 27+ kernels work out of the box, older distributions
+require updating the kernel to 4.14 to include the pvrdma driver.
+
+However the libpvrdma library needed by User Level Software is still
+not available as part of the distributions, so the rdma-core library
+needs to be compiled and optionally installed.
+
+Please follow the instructions at:
+  https://github.com/linux-rdma/rdma-core.git
+
+
+2.2 Host Setup
+==============
+The pvrdma backend is an ibdevice interface that can be exposed
+either by a Soft-RoCE(rxe) device on machines with no RDMA device,
+or an HCA SRIOV function(VF/PF).
+Note that ibdevice interfaces can't be shared between pvrdma devices,
+each one requiring a separate instance (rxe or SRIOV VF).
+
+
+2.2.1 Soft-RoCE backend(rxe)
+===========================
+A stable version of rxe is required, Fedora 27+ or a Linux
+Kernel 4.14+ is preferred.
+
+The rdma_rxe module is part of the Linux Kernel but not loaded by default.
+Install the User Level library (librxe) following the instructions from:
+https://github.com/SoftRoCE/rxe-dev/wiki/rxe-dev:-Home
+
+Associate an ETH interface with rxe by running:
+   rxe_cfg add eth0
+An rxe0 ibdevice interface will be created and can be used as pvrdma backend.
+
+
+2.2.2 RDMA device Virtual Function backend
+==========================================
+Nothing special is required, the pvrdma device can work not only with
+Ethernet Links, but also Infinibands Links.
+All is needed is an ibdevice with an active port, for Mellanox cards
+will be something like mlx5_6 which can be the backend.
+
+
+2.2.3 QEMU setup
+================
+Configure QEMU with --enable-rdma flag, installing
+the required RDMA libraries.
+
+
+
+3. Usage
+========
+Currently the device is working only with memory backed RAM
+and it must be mark as "shared":
+   -m 1G \
+   -object memory-backend-ram,id=mb1,size=1G,share \
+   -numa node,memdev=mb1 \
+
+The pvrdma device is composed of two functions:
+ - Function 0 is a vmxnet Ethernet Device which is redundant in Guest
+   but is required to pass the ibdevice GID using its MAC.
+   Examples:
+     For an rxe backend using eth0 interface it will use its mac:
+       -device vmxnet3,addr=<slot>.0,multifunction=on,mac=<eth0 MAC>
+     For an SRIOV VF, we take the Ethernet Interface exposed by it:
+       -device vmxnet3,multifunction=on,mac=<RoCE eth MAC>
+ - Function 1 is the actual device:
+       -device pvrdma,addr=<slot>.1,backend-dev=<ibdevice>,backend-gid-idx=<gid>,backend-port=<port>
+   where the ibdevice can be rxe or RDMA VF (e.g. mlx5_4)
+ Note: Pay special attention that the GID at backend-gid-idx matches vmxnet's MAC.
+ The rules of conversion are part of the RoCE spec, but since manual conversion
+ is not required, spotting problems is not hard:
+    Example: GID: fe80:0000:0000:0000:7efe:90ff:fecb:743a
+             MAC: 7c:fe:90:cb:74:3a
+    Note the difference between the first byte of the MAC and the GID.
+
+
+
+4. Implementation details
+=========================
+
+
+4.1 Overview
+============
+The device acts like a proxy between the Guest Driver and the host
+ibdevice interface.
+On configuration path:
+ - For every hardware resource request (PD/QP/CQ/...) the pvrdma will request
+   a resource from the backend interface, maintaining a 1-1 mapping
+   between the guest and host.
+On data path:
+ - Every post_send/receive received from the guest will be converted into
+   a post_send/receive for the backend. The buffers data will not be touched
+   or copied resulting in near bare-metal performance for large enough buffers.
+ - Completions from the backend interface will result in completions for
+   the pvrdma device.
+
+
+4.2 PCI BARs
+============
+PCI Bars:
+	BAR 0 - MSI-X
+        MSI-X vectors:
+		(0) Command - used when execution of a command is completed.
+		(1) Async - not in use.
+		(2) Completion - used when a completion event is placed in
+		  device's CQ ring.
+	BAR 1 - Registers
+        --------------------------------------------------------
+        | VERSION |  DSR | CTL | REQ | ERR |  ICR | IMR  | MAC |
+        --------------------------------------------------------
+		DSR - Address of driver/device shared memory used
+              for the command channel, used for passing:
+			    - General info such as driver version
+			    - Address of 'command' and 'response'
+			    - Address of async ring
+			    - Address of device's CQ ring
+			    - Device capabilities
+		CTL - Device control operations (activate, reset etc)
+		IMG - Set interrupt mask
+		REQ - Command execution register
+		ERR - Operation status
+
+	BAR 2 - UAR
+        ---------------------------------------------------------
+        | QP_NUM  | SEND/RECV Flag ||  CQ_NUM |   ARM/POLL Flag |
+        ---------------------------------------------------------
+		- Offset 0 used for QP operations (send and recv)
+		- Offset 4 used for CQ operations (arm and poll)
+
+
+4.3 Major flows
+===============
+
+4.3.1 Create CQ
+===============
+    - Guest driver
+        - Allocates pages for CQ ring
+        - Creates page directory (pdir) to hold CQ ring's pages
+        - Initializes CQ ring
+        - Initializes 'Create CQ' command object (cqe, pdir etc)
+        - Copies the command to 'command' address
+        - Writes 0 into REQ register
+    - Device
+        - Reads the request object from the 'command' address
+        - Allocates CQ object and initialize CQ ring based on pdir
+        - Creates the backend CQ
+        - Writes operation status to ERR register
+        - Posts command-interrupt to guest
+    - Guest driver
+        - Reads the HW response code from ERR register
+
+4.3.2 Create QP
+===============
+    - Guest driver
+        - Allocates pages for send and receive rings
+        - Creates page directory(pdir) to hold the ring's pages
+        - Initializes 'Create QP' command object (max_send_wr,
+          send_cq_handle, recv_cq_handle, pdir etc)
+        - Copies the object to 'command' address
+        - Write 0 into REQ register
+    - Device
+        - Reads the request object from 'command' address
+        - Allocates the QP object and initialize
+            - Send and recv rings based on pdir
+            - Send and recv ring state
+        - Creates the backend QP
+        - Writes the operation status to ERR register
+        - Posts command-interrupt to guest
+    - Guest driver
+        - Reads the HW response code from ERR register
+
+4.3.3 Post receive
+==================
+    - Guest driver
+        - Initializes a wqe and place it on recv ring
+        - Write to qpn|qp_recv_bit (31) to QP offset in UAR
+    - Device
+        - Extracts qpn from UAR
+        - Walks through the ring and does the following for each wqe
+            - Prepares the backend CQE context to be used when
+              receiving completion from backend (wr_id, op_code, emu_cq_num)
+            - For each sge prepares backend sge
+            - Calls backend's post_recv
+
+4.3.4 Process backend events
+============================
+    - Done by a dedicated thread used to process backend events;
+      at initialization is attached to the device and creates
+      the communication channel.
+    - Thread main loop:
+        - Polls for completions
+        - Extracts QEMU _cq_num, wr_id and op_code from context
+        - Writes CQE to CQ ring
+        - Writes CQ number to device CQ
+        - Sends completion-interrupt to guest
+        - Deallocates context
+        - Acks the event to backend
+
+
+
+5. Limitations
+==============
+- The device obviously is limited by the Guest Linux Driver features implementation
+  of the VMware device API.
+- Memory registration mechanism requires mremap for every page in the buffer in order
+  to map it to a contiguous virtual address range. Since this is not the data path
+  it should not matter much.
+- The device requires target page size to be the same as the host page size.
+- QEMU cannot map guest RAM from a file descriptor if a pvrdma device is attached,
+  so it can't work with huge pages. The limitation will be addressed in the future,
+  however QEMU allocates Gust RAM with MADV_HUGEPAGE so if there are enough huge
+  pages available, QEMU will use them.
+- As previously stated, migration is not supported yet, however with some hardware
+  support can be done.
+
+
+
+6. Performance
+==============
+By design the pvrdma device exits on each post-send/receive, so for small buffers
+the performance is affected; however for medium buffers it will became close to
+bare metal and from 1MB buffers and  up it reaches bare metal performance.
+(tested with 2 VMs, the pvrdma devices connected to 2 VFs of the same device)
+
+All the above assumes no memory registration is done on data path.
-- 
2.13.5
