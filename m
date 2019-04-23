Received: from eggs.gnu.org ([209.51.188.92]:38178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hIqRn-00029O-Jm
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:06:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hIqRl-0004bN-UJ
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:06:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hIqRl-0004aB-MH
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 04:06:33 -0400
From: Pankaj Gupta <pagupta@redhat.com>
Date: Tue, 23 Apr 2019 13:36:06 +0530
Message-Id: <20190423080612.15361-1-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 0/6] virtio pmem driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org, qemu-devel@nongnu.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Cc: dan.j.williams@intel.com, zwisler@kernel.org, vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com, jasowang@redhat.com, willy@infradead.org, rjw@rjwysocki.net, hch@infradead.org, lenb@kernel.org, jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com, lcapitulino@redhat.com, kwolf@redhat.com, imammedo@redhat.com, jmoyer@redhat.com, nilal@redhat.com, riel@surriel.com, stefanha@redhat.com, aarcange@redhat.com, david@redhat.com, david@fromorbit.com, cohuck@redhat.com, xiaoguangrong.eric@gmail.com, pagupta@redhat.com, pbonzini@redhat.com, yuval.shaia@oracle.com, kilobyte@angband.pl

 This patch series has implementation for "virtio pmem".=20
 "virtio pmem" is fake persistent memory(nvdimm) in guest=20
 which allows to bypass the guest page cache. This also
 implements a VIRTIO based asynchronous flush mechanism. =20
=20
 Sharing guest kernel driver in this patchset with the=20
 changes suggested in v4. Tested with Qemu side device=20
 emulation [6] for virtio-pmem. Documented the impact of
 possible page cache side channel attacks with suggested
 countermeasures.

 Incorporated all the review suggestions in V5.
=20
 Details of project idea for 'virtio pmem' flushing interface=20
 is shared [3] & [4].

 Implementation is divided into two parts:
 New virtio pmem guest driver and qemu code changes for new=20
 virtio pmem paravirtualized device.

1. Guest virtio-pmem kernel driver
---------------------------------
   - Reads persistent memory range from paravirt device and=20
     registers with 'nvdimm_bus'. =20
   - 'nvdimm/pmem' driver uses this information to allocate=20
     persistent memory region and setup filesystem operations=20
     to the allocated memory.=20
   - virtio pmem driver implements asynchronous flushing=20
     interface to flush from guest to host.

2. Qemu virtio-pmem device
---------------------------------
   - Creates virtio pmem device and exposes a memory range to=20
     KVM guest.=20
   - At host side this is file backed memory which acts as=20
     persistent memory.=20
   - Qemu side flush uses aio thread pool API's and virtio=20
     for asynchronous guest multi request handling.=20

   David Hildenbrand CCed also posted a modified version[7] of=20
   qemu virtio-pmem code based on updated Qemu memory device API.=20

 Virtio-pmem security implications and countermeasures:
 -----------------------------------------------------

 In previous posting of kernel driver, there was discussion [9]
 on possible implications of page cache side channel attacks with=20
 virtio pmem. After thorough analysis of details of known side=20
 channel attacks, below are the suggestions:

 - Depends entirely on how host backing image file is mapped=20
   into guest address space.=20

 - virtio-pmem device emulation, by default shared mapping is used
   to map host backing file. It is recommended to use separate
   backing file at host side for every guest. This will prevent
   any possibility of executing common code from multiple guests
   and any chance of inferring guest local data based based on=20
   execution time.

 - If backing file is required to be shared among multiple guests=20
   it is recommended to don't support host page cache eviction=20
   commands from the guest driver. This will avoid any possibility
   of inferring guest local data or host data from another guest.=20

 - Proposed device specification [8] for virtio-pmem device with=20
   details of possible security implications and suggested=20
   countermeasures for device emulation.

 Virtio-pmem errors handling:
 ----------------------------------------
  Checked behaviour of virtio-pmem for below types of errors
  Need suggestions on expected behaviour for handling these errors?

  - Hardware Errors: Uncorrectable recoverable Errors:=20
  a] virtio-pmem:=20
    - As per current logic if error page belongs to Qemu process,=20
      host MCE handler isolates(hwpoison) that page and send SIGBUS.=20
      Qemu SIGBUS handler injects exception to KVM guest.=20
    - KVM guest then isolates the page and send SIGBUS to guest=20
      userspace process which has mapped the page.=20
 =20
  b] Existing implementation for ACPI pmem driver:=20
    - Handles such errors with MCE notifier and creates a list=20
      of bad blocks. Read/direct access DAX operation return EIO=20
      if accessed memory page fall in bad block list.
    - It also starts backgound scrubbing. =20
    - Similar functionality can be reused in virtio-pmem with MCE=20
      notifier but without scrubbing(no ACPI/ARS)? Need inputs to=20
      confirm if this behaviour is ok or needs any change?

Changes from PATCH v5: [1]
  Changes suggested in by - [Cornelia, Yuval]
- Remove assignment chaining in virtio driver
- Better error message and remove not required free
- Check nd_region before use

  Changes suggested by - [Jan Kara]
- dax_synchronous() for !CONFIG_DAX
- Correct 'daxdev_mapping_supported' comment and non-dax implementation

  Changes suggested by - [Dan Williams]
- Pass meaningful flag 'DAXDEV_F_SYNC' to alloc_dax
- Gate nvdimm_flush instead of additional async parameter
- Move block chaining logic to flush callback than common nvdimm_flush
- Use NULL flush callback for generic flush for better readability [Dan, =
Jan]

- Use virtio device id 27 from 25(already used) - [MST]

Changes from PATCH v4: [2]
- Factor out MAP_SYNC supported functionality to a common helper
				[Dave, Darrick, Jan]
- Comment, indentation and virtqueue_kick failure handle - Yuval Shaia

Changes from PATCH v3:=20
- Use generic dax_synchronous() helper to check for DAXDEV_SYNC=20
  flag - [Dan, Darrick, Jan]
- Add 'is_nvdimm_async' function
- Document page cache side channel attacks implications &=20
  countermeasures - [Dave Chinner, Michael]

Changes from PATCH v2:=20
- Disable MAP_SYNC for ext4 & XFS filesystems - [Dan]=20
- Use name 'virtio pmem' in place of 'fake dax'=20

Changes from PATCH v1:=20
- 0-day build test for build dependency on libnvdimm=20

 Changes suggested by - [Dan Williams]
- Split the driver into two parts virtio & pmem =20
- Move queuing of async block request to block layer
- Add "sync" parameter in nvdimm_flush function
- Use indirect call for nvdimm_flush
- Don=E2=80=99t move declarations to common global header e.g nd.h
- nvdimm_flush() return 0 or -EIO if it fails
- Teach nsio_rw_bytes() that the flush can fail
- Rename nvdimm_flush() to generic_nvdimm_flush()
- Use 'nd_region->provider_data' for long dereferencing
- Remove virtio_pmem_freeze/restore functions
- Remove BSD license text with SPDX license text

- Add might_sleep() in virtio_pmem_flush - [Luiz]
- Make spin_lock_irqsave() narrow

Changes from RFC v3
- Rebase to latest upstream - Luiz
- Call ndregion->flush in place of nvdimm_flush- Luiz
- kmalloc return check - Luiz
- virtqueue full handling - Stefan
- Don't map entire virtio_pmem_req to device - Stefan
- request leak, correct sizeof req - Stefan
- Move declaration to virtio_pmem.c

Changes from RFC v2:
- Add flush function in the nd_region in place of switching
  on a flag - Dan & Stefan
- Add flush completion function with proper locking and wait
  for host side flush completion - Stefan & Dan
- Keep userspace API in uapi header file - Stefan, MST
- Use LE fields & New device id - MST
- Indentation & spacing suggestions - MST & Eric
- Remove extra header files & add licensing - Stefan

Changes from RFC v1:
- Reuse existing 'pmem' code for registering persistent=20
  memory and other operations instead of creating an entirely=20
  new block driver.
- Use VIRTIO driver to register memory information with=20
  nvdimm_bus and create region_type accordingly.=20
- Call VIRTIO flush from existing pmem driver.

Pankaj Gupta (6):
   libnvdimm: nd_region flush callback support
   virtio-pmem: Add virtio-pmem guest driver
   libnvdimm: add nd_region buffered dax_dev flag
   dax: check synchronous mapping is supported
   ext4: disable map_sync for virtio pmem
   xfs: disable map_sync for virtio pmem

[1] https://lkml.org/lkml/2019/4/10/3
[2] https://lkml.org/lkml/2019/4/3/394
[3] https://www.spinics.net/lists/kvm/msg149761.html
[4] https://www.spinics.net/lists/kvm/msg153095.html =20
[5] https://lkml.org/lkml/2018/8/31/413
[6] https://marc.info/?l=3Dlinux-kernel&m=3D153572228719237&w=3D2=20
[7] https://marc.info/?l=3Dqemu-devel&m=3D153555721901824&w=3D2
[8] https://lists.oasis-open.org/archives/virtio-dev/201903/msg00083.html
[9] https://lkml.org/lkml/2019/1/9/1191

 drivers/acpi/nfit/core.c         |    4 -
 drivers/dax/bus.c                |    2=20
 drivers/dax/super.c              |   13 +++-
 drivers/md/dm.c                  |    3=20
 drivers/nvdimm/claim.c           |    6 +
 drivers/nvdimm/nd.h              |    1=20
 drivers/nvdimm/pmem.c            |   16 +++--
 drivers/nvdimm/region_devs.c     |   33 ++++++++++
 drivers/nvdimm/virtio_pmem.c     |  114 ++++++++++++++++++++++++++++++++=
+++++
 drivers/virtio/Kconfig           |   10 +++
 drivers/virtio/Makefile          |    1=20
 drivers/virtio/pmem.c            |  118 ++++++++++++++++++++++++++++++++=
+++++++
 fs/ext4/file.c                   |   11 +--
 fs/xfs/xfs_file.c                |   10 +--
 include/linux/dax.h              |   25 +++++++-
 include/linux/libnvdimm.h        |    9 ++
 include/linux/virtio_pmem.h      |   60 +++++++++++++++++++
 include/uapi/linux/virtio_ids.h  |    1=20
 include/uapi/linux/virtio_pmem.h |   10 +++
 19 files changed, 420 insertions(+), 27 deletions(-)
