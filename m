Received: from eggs.gnu.org ([2001:4830:134:3::10]:47509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drPO4-0004WQ-41
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:08:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drPO0-0007FZ-Nw
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:08:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1drPO0-0007EO-E6
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:08:28 -0400
Date: Mon, 11 Sep 2017 16:08:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170911160818.1bd44a82@nial.brq.redhat.com>
In-Reply-To: <20170911044157.15403-1-haozhong.zhang@intel.com>
References: <20170911043820.14617-1-haozhong.zhang@intel.com>
	<20170911044157.15403-1-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC QEMU PATCH v3 00/10] Implement vNVDIMM for
 Xen HVM guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xen.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

On Mon, 11 Sep 2017 12:41:47 +0800
Haozhong Zhang <haozhong.zhang@intel.com> wrote:

> This is the QEMU part patches that works with the associated Xen
> patches to enable vNVDIMM support for Xen HVM domains. Xen relies on
> QEMU to build guest NFIT and NVDIMM namespace devices, and allocate
> guest address space for vNVDIMM devices.
> 
> All patches can be found at
>   Xen:  https://github.com/hzzhan9/xen.git nvdimm-rfc-v3
>   QEMU: https://github.com/hzzhan9/qemu.git xen-nvdimm-rfc-v3
> 
> Patch 1 is to avoid dereferencing the NULL pointer to non-existing
> label data, as the Xen side support for labels is not implemented yet.
> 
> Patch 2 & 3 add a memory backend dedicated for Xen usage and a hotplug
> memory region for Xen guest, in order to make the existing nvdimm
> device plugging path work on Xen.
> 
> Patch 4 - 10 build and cooy NFIT from QEMU to Xen guest, when QEMU is
> used as the Xen device model.

I've skimmed over patch-set and can't say that I'm happy with
number of xen_enabled() invariants it introduced as well as
with partial blobs it creates.

I'd like to reduce above and a way to do this might be making xen 
 1. use fw_cfg
 2. fetch QEMU build acpi tables from fw_cfg
 3. extract nvdim tables (which is trivial) and use them

looking at xen_load_linux(), it seems possible to use fw_cfg.

So what's stopping xen from using it elsewhere?,
instead of adding more xen specific code to do 'the same'
job and not reusing/sharing common code with tcg/kvm.


> Haozhong Zhang (10):
>   nvdimm: do not intiailize nvdimm->label_data if label size is zero
>   hw/xen-hvm: create the hotplug memory region on Xen
>   hostmem-xen: add a host memory backend for Xen
>   nvdimm acpi: do not use fw_cfg on Xen
>   hw/xen-hvm: initialize DM ACPI
>   hw/xen-hvm: add function to copy ACPI into guest memory
>   nvdimm acpi: copy NFIT to Xen guest
>   nvdimm acpi: copy ACPI namespace device of vNVDIMM to Xen guest
>   nvdimm acpi: do not build _FIT method on Xen
>   hw/xen-hvm: enable building DM ACPI if vNVDIMM is enabled
> 
>  backends/Makefile.objs |   1 +
>  backends/hostmem-xen.c | 108 ++++++++++++++++++++++++++
>  backends/hostmem.c     |   9 +++
>  hw/acpi/aml-build.c    |  10 ++-
>  hw/acpi/nvdimm.c       |  79 ++++++++++++++-----
>  hw/i386/pc.c           | 102 ++++++++++++++-----------
>  hw/i386/xen/xen-hvm.c  | 204 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  hw/mem/nvdimm.c        |  10 ++-
>  hw/mem/pc-dimm.c       |   6 +-
>  include/hw/i386/pc.h   |   1 +
>  include/hw/xen/xen.h   |  25 ++++++
>  stubs/xen-hvm.c        |  10 +++
>  12 files changed, 495 insertions(+), 70 deletions(-)
>  create mode 100644 backends/hostmem-xen.c
> 
