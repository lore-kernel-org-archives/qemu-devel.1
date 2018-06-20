Received: from eggs.gnu.org ([2001:4830:134:3::10]:43896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fVh1T-000428-7C
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 13:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fVh1O-0006wT-AY
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 13:35:59 -0400
References: <20180619134141.29478-1-david@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ee8114e9-03f5-5d2b-981d-d86fb2ee185d@redhat.com>
Date: Wed, 20 Jun 2018 19:35:49 +0200
MIME-Version: 1.0
In-Reply-To: <20180619134141.29478-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 00/12] pc-dimm: next bunch of cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

On 19/06/2018 15:41, David Hildenbrand wrote:
> This is another set of cleanups as the result from
>     [PATCH v4 00/14] MemoryDevice: use multi stage hotplug handlers
> And is based on
>     [PATCH v1 0/2] memory: fix alignment checks/asserts
> 
> These cleanup are the last step before
> - 1. moving pc-dimm address and slot assignment into pc_dimm_pre_plug
> - 2. factoring out pre_plug, plug and unplug logic of memory devices
>      completely

Queued, thanks.

Paolo

> v4 -> v5:
> - "nvdimm: convert nvdimm_mr into a pointer"
> -- fix memory leak by freeing in instance_finalize()
> - "nvdimm: make get_memory_region() perform checks and initialization"
> -- trun check into assert in "
> 
> v3 -> v4:
> - drop "nvdimm: allow setting the label-size to 0"
> 
> v2 -> v3:
> - "nvdimm: no need to overwrite get_vmstate_memory_region()"
> -- reshuffeld to avoid breaking compilation in between patches
> - "nvdimm: convert "label-size" into a static property"
> -- replace by "nvdimm: convert nvdimm_mr into a pointer"
> -- and "nvdimm: allow setting the label-size to 0"
> 
> v1 -> v2:
> - deferring "pc-dimm: assign and verify the "slot" property during pre_plug"
> - deferring "pc-dimm: introduce and use pc_dimm_memory_pre_plug()"
> - dropped "pc-dimm: get_memory_region() will never return a NULL pointer"
> - dropped "pc-dimm: don't allow to access "size" before the device was realized"
> - dropped "spapr: move memory hotplug size check into plug code"
> - dropped "pc-dimm: get_memory_region() can never fail"
> -- replaces by "pc-dimm: get_memory_region() will not fail after realize"
> - added "pc: rename pc_dimm_(plug|unplug|...)* into ..."
> - added "pc-dimm: rename pc_dimm_memory_* to pc_dimm_*"
> - added "pc-dimm: remove pc_dimm_get_free_slot() from header"
> - added "pc-dimm: merge get_(vmstate_)memory_region()"
> - added "nvdimm: convert "unarmed" into a static property"
> - added "nvdimm: convert "label-size" into a static property"
> - added "nvdimm: make get_memory_region() perform checks and initialization"
> 
> David Hildenbrand (12):
>   pc-dimm: remove leftover "struct pc_dimms_capacity"
>   pc: rename pc_dimm_(plug|unplug|...)* into
>     pc_memory_(plug|unplug|...)*
>   pc-dimm: rename pc_dimm_memory_* to pc_dimm_*
>   pc-dimm: remove pc_dimm_get_free_slot() from header
>   pc: factor out pc specific dimm checks into pc_memory_pre_plug()
>   nvdimm: no need to overwrite get_vmstate_memory_region()
>   hostmem: drop error variable from host_memory_backend_get_memory()
>   pc-dimm: merge get_(vmstate_)memory_region()
>   nvdimm: convert "unarmed" into a static property
>   nvdimm: convert nvdimm_mr into a pointer
>   nvdimm: make get_memory_region() perform checks and initialization
>   pc-dimm: get_memory_region() will not fail after realize
> 
>  backends/hostmem.c       |  3 +-
>  hw/i386/pc.c             | 73 ++++++++++++++++---------------
>  hw/mem/nvdimm.c          | 93 ++++++++++++++++++++++------------------
>  hw/mem/pc-dimm.c         | 35 ++++++---------
>  hw/misc/ivshmem.c        |  3 +-
>  hw/ppc/spapr.c           | 18 +++-----
>  include/hw/mem/nvdimm.h  |  2 +-
>  include/hw/mem/pc-dimm.h | 17 ++++----
>  include/sysemu/hostmem.h |  3 +-
>  numa.c                   |  3 +-
>  10 files changed, 121 insertions(+), 129 deletions(-)
> 
