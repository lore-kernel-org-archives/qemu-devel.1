Received: from eggs.gnu.org ([2001:4830:134:3::10]:51991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ds87Z-0005uf-Eu
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ds87U-0008Fd-IS
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:54:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ds87U-0008Ey-Cp
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:54:24 -0400
Date: Wed, 13 Sep 2017 14:54:18 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170913135418.GA14243@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] QEMU -M nvdimm=on and hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mprivozn@redhat.com
Cc: Haozhong Zhang <haozhong.zhang@intel.com>, libvir-list@redhat.com, qemu-devel@nongnu.org

Hi Michal,
You asked how NVDIMM hotplug should work if the domain was launched
without -M nvdimm=on.  I'm not very familiar with ACPI so this may be
incorrect.

Hotplug relies on the presence of ACPI tables (SSDT Device=NVDR
_HID=ACPI0012) added by -M nvdimm=on.  The ACPI tables contain the
interface needed to handle hotplug events.

The device_add command fails with the following message if -M nvdimm=on
is missing:

  nvdimm is not enabled: missing 'nvdimm' in '-M'

I'm not sure if ACPI allows SSDT tables to be dynamically added but in
any case the current QEMU code doesn't support that.

Options for libvirt:

1. Rely on QEMU's device_add error.
   Pro: If QEMU behavior ever changes then libvirt will also start
        working without code changes.
   Cons: Does libvirt interpret QMP error strings?

2. Only allow NVDIMM hotplug if the domain was started with -M
   nvdimm=on.

I think QEMU will not add -M nvdimm=on to the "pc" machine type by
default since it adds the NVDIMM DSM hardware interface that increases
the security attack surface.

Stefan
