Received: from eggs.gnu.org ([2001:4830:134:3::10]:58147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cpkwb-000519-Rm
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 20:13:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cpkwY-0004uO-Mx
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 20:13:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:9278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1cpkwY-0004u9-CO
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 20:13:02 -0400
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Mon, 20 Mar 2017 08:12:39 +0800
Message-Id: <20170320001249.25521-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [RFC QEMU PATCH v2 00/10] Implement vNVDIMM for Xen
 HVM guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xen.org
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is the QEMU patch of v2 RFC patch series to enable vNVDIMM
support for Xen HVM guest. v1 can be found at
https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg01678.html.

The corresponding Xen patch series is sent in another thread
"[RFC XEN PATCH v2 00/15] Add vNVDIMM support to HVM domains".

All patch series can be found at
  Xen:  https://github.com/hzzhan9/xen.git nvdimm-rfc-v2
  Qemu: https://github.com/hzzhan9/qemu.git xen-nvdimm-rfc-v2


Patch 1 is to avoid dereferencing the NULL pointer to non-existing
label data, as the Xen side support for labels is not implemented yet.

Patch 2 - 7 build and cooy NFIT from QEMU to Xen guest, when QEMU is
used as the Xen device model.

Patch 8 & 9 add a memory backend dedicated for Xen usage and a hotplug
memory region for Xen guest, in order to make the existing nvdimm
device plugging path work on Xen.

Patch 10 extends the the existing qmp command "query-memory-device" to
return information of NVDIMM devices required by Xen.

Haozhong Zhang (10):
  01/10 nvdimm xen: disable label support on Xen
  02/10 xen-hvm: initialize DM ACPI
  03/10 xen-hvm: support copying ACPI to guest memory
  04/10 nvdimm acpi: do not use fw_cfg on Xen
  05/10 nvdimm acpi: copy NFIT to Xen guest
  06/10 nvdimm acpi: build and copy NVDIMM namespace devices to guest on Xen
  07/10 xen-hvm: enable building DM ACPI on i386 machine
  08/10 hostmem: add a host memory backend for Xen
  09/10 xen-hvm: create hotplug memory region on Xen
  10/10 qapi: extend 'query-memory-devices' to list devices of specified type

 backends/Makefile.objs   |   1 +
 backends/hostmem-xen.c   | 121 ++++++++++++++++++++++++++++
 backends/hostmem.c       |   8 ++
 hmp.c                    |   3 +-
 hw/acpi/aml-build.c      |   9 ++-
 hw/acpi/nvdimm.c         |  67 +++++++++++-----
 hw/i386/pc.c             |  98 ++++++++++++-----------
 hw/mem/nvdimm.c          |  44 ++++++++++-
 hw/mem/pc-dimm.c         |  76 +++++++++++-------
 include/hw/i386/pc.h     |   1 +
 include/hw/mem/nvdimm.h  |   2 +
 include/hw/mem/pc-dimm.h |   1 +
 include/hw/xen/xen.h     |  20 +++++
 qapi-schema.json         |  48 ++++++++++-
 qmp.c                    |  13 ++-
 xen-hvm-stub.c           |  10 +++
 xen-hvm.c                | 202 +++++++++++++++++++++++++++++++++++++++++++++++
 17 files changed, 620 insertions(+), 104 deletions(-)
 create mode 100644 backends/hostmem-xen.c

-- 
2.12.0
