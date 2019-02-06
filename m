Received: from eggs.gnu.org ([209.51.188.92]:52428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sbhat@linux.ibm.com>) id 1grFh9-0002ft-TH
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:24:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sbhat@linux.ibm.com>) id 1grFh8-0003Q0-Og
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:24:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sbhat@linux.ibm.com>) id 1grFh8-0003Nq-EK
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:24:22 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x165OIFi139505
	for <qemu-devel@nongnu.org>; Wed, 6 Feb 2019 00:24:19 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qfkwhn9dw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 00:24:19 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sbhat@linux.ibm.com>;
	Wed, 6 Feb 2019 05:24:12 -0000
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Date: Tue, 05 Feb 2019 23:24:05 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <154943058200.27958.11497653677605446596.stgit@lep8c.aus.stglabs.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 0/4] ppc: spapr: virtual NVDIMM support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xiaoguangrong.eric@gmail.com, sbhat@linux.ibm.com, mst@redhat.com, bharata@linux.ibm.com, qemu-ppc@nongnu.org, vaibhav@linux.ibm.com, imammedo@redhat.com, david@gibson.dropbear.id.au

The patchset attempts to implement the virtual NVDIMM for pseries.

PAPR semantics is such that each NVDIMM device is comprising of multiple
SCM(Storage Class Memory) blocks. The hypervisor is expected to prepare the
FDT for the NVDIMM device and send guest a hotplug interrupt with new type 
RTAS_LOG_V6_HP_TYPE_PMEM currently handled by the upstream kernel. In response
to that interrupt, the guest requests the hypervisor to bind each of the SCM
blocks of the NVDIMM device using hcalls. There can be SCM block unbind
requests in case of driver errors or unplug(not supported now) use cases. The
NVDIMM label read/writes are done through hcalls.

There are also new futuristic hcalls added(currently unused in the kernel), for
querying the informations such as binding, logical addresses of the SCM blocks.
The current patchset leaves them unimplemented.

Since each virtual NVDIMM device is divided into multiple SCM blocks, the bind,
unbind, and queries using hcalls on those blocks can come independently. This
doesnt fit well into the qemu device semantics, where the map/unmap are done at
the (whole)device/object level granularity. The patchset uses the existing
NVDIMM class structures for the implementation. The bind/unbind is left to
happen at the object_add/del phase itself instead of at hcalls on-demand.

The guest kernel makes bind/unbind requests for the virtual NVDIMM device at the
region level granularity. Without interleaving, each virtual NVDIMM device is
presented as separate region. There is no way to configure the virtual NVDIMM
interleaving for the guests today. So, there is no way a partial bind/unbind
request can come for the vNVDIMM in a hcall for a subset of SCM blocks of a
virtual NVDIMM. Hence it is safe to do bind/unbind everything during the
object_add/del.

The free device-memory region which is used for memory hotplug are done using
multiple LMBs of size(256MiB) and are expected to be aligned to 256 MiB. As the
SCM blocks are mapped to the same region, the SCM blocks also need to be
aligned to this size for the subsequent memory hotplug to work. The minimum SCM
block size is set to this size for that reason and can be made user configurable
in future if required.

The first patch moves around the existing static function to common area
for using it in the subsequent patches. The second patch implements
memory_device_set_region_size, for which we already have "get" implementation.
The remaining two, one of them adds the FDT entries and basic device support,
the other adds the hcalls implementation.

The patches are also available at https://github.com/ShivaprasadGBhat/qemu.git -
pseries-nvdimm branch and can be used with the upstream kernel. ndctl can be
used for configuring the nvdimms inside the guest.

This is how it can be used ..
Add nvdimm=on to the qemu machine argument,
Ex : -machine pseries,nvdimm=on
For coldplug, the device to be added in qemu command line as shown below
-object memory-backend-file,id=memnvdimm0,prealloc=yes,mem-path=/tmp/nvdimm0
-device nvdimm,label-size=128k,memdev=memnvdimm0,id=nvdimm0,slot=0

For hotplug, the device to be added from monitor as below
object_add memory-backend-file,id=memnvdimm0,prealloc=yes,mem-path=/tmp/nvdi
device_add nvdimm,label-size=128k,memdev=memnvdimm0,id=nvdimm0,slot=0

---

Shivaprasad G Bhat (4):
      mem: make nvdimm_device_list global
      mem: implement memory_device_set_region_size
      spapr: Add NVDIMM device support
      spapr: Add Hcalls to support PAPR NVDIMM device


 default-configs/ppc64-softmmu.mak |    1 
 hw/acpi/nvdimm.c                  |   27 ----
 hw/mem/memory-device.c            |   15 ++
 hw/mem/nvdimm.c                   |   27 ++++
 hw/ppc/spapr.c                    |  212 ++++++++++++++++++++++++++++++++--
 hw/ppc/spapr_drc.c                |   17 +++
 hw/ppc/spapr_events.c             |    4 +
 hw/ppc/spapr_hcall.c              |  230 +++++++++++++++++++++++++++++++++++++
 include/hw/mem/memory-device.h    |    2 
 include/hw/mem/nvdimm.h           |    2 
 include/hw/ppc/spapr.h            |   20 +++
 include/hw/ppc/spapr_drc.h        |    9 +
 12 files changed, 526 insertions(+), 40 deletions(-)

--
Signature
