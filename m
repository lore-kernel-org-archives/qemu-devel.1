Received: from eggs.gnu.org ([2001:4830:134:3::10]:48023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fKnjM-0007oe-EW
	for qemu-devel@nongnu.org; Mon, 21 May 2018 12:32:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fKnjH-00086h-HZ
	for qemu-devel@nongnu.org; Mon, 21 May 2018 12:32:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:48359)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ross.zwisler@linux.intel.com>)
	id 1fKnjH-00085w-8R
	for qemu-devel@nongnu.org; Mon, 21 May 2018 12:32:11 -0400
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Date: Mon, 21 May 2018 10:31:59 -0600
Message-Id: <20180521163203.26590-1-ross.zwisler@linux.intel.com>
Subject: [Qemu-devel] [qemu PATCH v4 0/4] support NFIT platform capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>

Changes since v3:
 * Updated the text in docs/nvdimm.txt to make it clear that the value
   being passed in on the command line in an integer made up of various
   bit fields. (Rob Elliott)
 
 * Updated the "Highest Valid Capability" byte to be dynamic based on
   the highest valid bit in the user's input. (Rob Elliott)

---

The first 2 patches in this series clean up some things I noticed while
coding.

Patch 3 adds support for the new Platform Capabilities Structure, which
was added to the NFIT in ACPI 6.2 Errata A.  We add a machine command
line option "nvdimm-cap":

    -machine pc,accel=kvm,nvdimm,nvdimm-cap=2

which allows the user to pass in a value for this structure.  When such
a value is passed in we will generate the new NFIT subtable.

Patch 4 adds code to the "make check" self test infrastructure so that
we generate the new Platform Capabilities Structure, and adds it to the
expected NFIT output so that we test for it.

Ross Zwisler (4):
  nvdimm: fix typo in label-size definition
  tests/.gitignore: add entry for generated file
  nvdimm, acpi: support NFIT platform capabilities
  ACPI testing: test NFIT platform capabilities

 docs/nvdimm.txt                       |  27 ++++++++++++++++++++
 hw/acpi/nvdimm.c                      |  45 +++++++++++++++++++++++++++++++---
 hw/i386/pc.c                          |  31 +++++++++++++++++++++++
 hw/mem/nvdimm.c                       |   2 +-
 include/hw/i386/pc.h                  |   1 +
 include/hw/mem/nvdimm.h               |   7 +++++-
 tests/.gitignore                      |   1 +
 tests/acpi-test-data/pc/NFIT.dimmpxm  | Bin 224 -> 240 bytes
 tests/acpi-test-data/q35/NFIT.dimmpxm | Bin 224 -> 240 bytes
 tests/bios-tables-test.c              |   2 +-
 10 files changed, 109 insertions(+), 7 deletions(-)

-- 
2.14.3
