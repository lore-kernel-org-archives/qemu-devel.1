Received: from eggs.gnu.org ([2001:4830:134:3::10]:44059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1eazdm-0004fn-Ks
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 02:57:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1eazdj-0003x0-GD
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 02:57:10 -0500
Received: from mga01.intel.com ([192.55.52.88]:30015)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1eazdj-0003vL-7f
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 02:57:07 -0500
From: Changpeng Liu <changpeng.liu@intel.com>
Date: Mon, 15 Jan 2018 16:01:54 +0800
Message-Id: <1516003315-17878-1-git-send-email-changpeng.liu@intel.com>
Subject: [Qemu-devel] [RFC v1] Introduce a new NVMe host device type to QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, changpeng.liu@intel.com
Cc: james.r.harris@intel.com, keith.busch@intel.com, famz@redhat.com, stefanha@gmail.com, pbonzini@redhat.com, mst@redhat.com

NVMe 1.3 specification(http://nvmexpress.org/resources/specifications/) introduced a new Admin command:
Doorbell Buffer Config, which designed for emulated NVMe controllers only, Linux kernel 4.12 added the
support of Doorbell Buffer Config. With this feature, when NVMe driver issues new requests to firmware,
the driver will write shadow doorbell instead of MMIO writes, so the NVMe specification itself can
become a great Para-virtualization protocol.

While here, similar with existing vhost-user-scsi idea, we can setup a slave I/O target which can serve
Guest I/Os directly via NVMe I/O queues. Here we can route the NVMe queue's information, such as queue
size/queue address etc. to a separate slave I/O target via UNIX domain socket. I took exist QEMU
vhost-user protocol as reference, designed several totally new socket messages to enable the function.
With this idea, an emulated virtual NVMe controller  will be presented at the Guest, and native NVMe
driver inside Guest can be used.

-----------------------------------------------------------------------------------------------------------------------------------------
| Unix Domain Socket Messages      | Description                                                                                                | 
-----------------------------------------------------------------------------------------------------------------------------------------
| Get Controller Capabilities             | Controller capabilitiy register of NVMe specification                        |
-----------------------------------------------------------------------------------------------------------------------------------------
| Get/Set Controller Configuration | Enable/Disable NVMe controller                                                            |
-----------------------------------------------------------------------------------------------------------------------------------------
| Admin passthrough                        | Mandatory NVMe Admin commands routed to slave I/O target      |
-----------------------------------------------------------------------------------------------------------------------------------------
| IO passthrough                               | IO messages before the shadow doorbell buffer being configured  |
-----------------------------------------------------------------------------------------------------------------------------------------
| Set memory table                          | Same with exist vhost-user message, used for memory translation |
-----------------------------------------------------------------------------------------------------------------------------------------
| Set Guest Notifier                          | Completion queue interrupt, interrupt Guest when I/O completed |
-----------------------------------------------------------------------------------------------------------------------------------------

With those messages, slave I/O target can access all the I/O queues of NVMe include submission queue and
completion queue. After finished the Admin Shadow Doorbell command, the slave I/O target can start to
process the I/O requests sent from Guest.

Currently I implemented both QEMU driver and slave I/O target which largely reused the code from QEMU
NVMe driver and vhost-user driver for performance evaluation:

Optional slave I/O target(SPDK Vhost Target) patches: https://review.gerrithub.io/#/c/384213/

User space NVMe driver is implemented at the slave I/O target so that NVMe controller can be shared
with multiple VMs, and the namespaces presented to the guest VM are virtual namespaces, meaning the
slave I/O target can back these namespaces with any kind of storage. Guest OS must be 4.12 or later(with
Admin Doorbell Buffer Config support), tests from my side used Fedora 27 with 4.13 kernel.

Currently this still is an ongoing work, there are some opens need to be addressed:
-Reused a lot of code from QEMU/nvme driver, need to think about abstracting a common NVMe library;
-Reused a lot of code from QEMU/vhost-user driver, for this idea, we just want to use UNIX domain
 socket to deliver mandatory messages, of course Set memory table and Set guest notifier is exactly
 same with vhost-user driver;
-Can support Guest OS kernel > 4.12 with Admin Doorbell Buffer feature enabled inside Guest, for BIOS
 stage IO requests and older Linux kernel without Admin Doorbell Buffer support, it can forward the IO
 requests through socket message, but this will have huge performance drop;

Any feedback is appreciated.

Changpeng Liu (1):
  block/NVMe: introduce a new vhost NVMe host device to QEMU

 hw/block/Makefile.objs     |   3 +
 hw/block/nvme.h            |  28 ++
 hw/block/vhost.c           | 439 ++++++++++++++++++++++
 hw/block/vhost_user.c      | 588 +++++++++++++++++++++++++++++
 hw/block/vhost_user_nvme.c | 902 +++++++++++++++++++++++++++++++++++++++++++++
 hw/block/vhost_user_nvme.h |  38 ++
 6 files changed, 1998 insertions(+)
 create mode 100644 hw/block/vhost.c
 create mode 100644 hw/block/vhost_user.c
 create mode 100644 hw/block/vhost_user_nvme.c
 create mode 100644 hw/block/vhost_user_nvme.h

-- 
1.9.3
