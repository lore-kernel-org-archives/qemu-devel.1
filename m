Received: from eggs.gnu.org ([2001:4830:134:3::10]:55371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fT3Wp-0005kc-4U
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 07:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fT3Wk-0007IG-AC
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 07:01:27 -0400
Date: Wed, 13 Jun 2018 13:01:13 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180613130113.64852912@redhat.com>
In-Reply-To: <20180611121655.19616-6-david@redhat.com>
References: <20180611121655.19616-1-david@redhat.com>
	<20180611121655.19616-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 05/11] spapr: move memory hotplug size
 check into plug code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S
	. Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>, Haozhong Zhang <haozhong.zhang@intel.com>xiaoguangrong.eric@gmail.com, Junyan He <junyan.he@intel.com>

On Mon, 11 Jun 2018 14:16:49 +0200
David Hildenbrand <david@redhat.com> wrote:

> This might look like a step backwards, but it is not. get_memory_region()
> should not be called on uninititalized devices. In general, only
> properties should be access, but no "derived" satte like the memory
> region.
>
> 1. We need duplicate error checks if memdev is actually already set.
>    realize() performs these checks, no need to duplicate.
it's not duplicate, if a machine doesn't access to memory region
in preplug time (hence doesn't check), then device itself would check it,
check won't be missed by accident.
(yep it's more code but more robust at the same time, so I'd leave it as is)

> 2. This is bad practise as one can see when looking at the NVDIMM
>    implemetation. The call does not return sane data before the device
>    is realized. Although spapr does not use NVDIMM, conceptually it is
>    wrong.
> 
> So let's just move this call to the right place. We can then cleanup
> get_memory_region().
So I have to say no to this particular patch.
It is indeed a step backwards and it looks like workaround for broken nvdimm impl.

Firstly, memdev property must be set for dimm device and
a user accessing memory region first must check for error.
More details below.

[...]

> @@ -3196,18 +3199,6 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>          return;
>      }
>  
> -    mr = ddc->get_memory_region(dimm, errp);
> -    if (!mr) {
here 2 bugs are colliding and leading to invalid code path
'if(!mr)' check happens to work for pc-dimm as it returns NULL on error
and error is reported to user.

however in nvdimm case, nvdimm_get_memory_region() unconditionally
returns pointer to not initialized memory alias without any checks

1st issue here is that spapr_memory_pre_plug() should check for error
like spapr_memory_plug() does when calling the same function.

2nd, nvdimm should (re)initialize nvdimm_mr alias whenever hostmem/label_size
properties are set (it's doable but could be tricky. however device model
shouldn't push its issues up to the stack).
There are other places in nvdimm that access uninitialized nvdimm_mr
during properties setting (I suppose all this sites should be fixed
as part of 2nd bugfix).
CCing author & co of nvdimm_mr, so that they could fix issue



> -        return;
> -    }
> -    size = memory_region_size(mr);
> -
> -    if (size % SPAPR_MEMORY_BLOCK_SIZE) {
> -        error_setg(errp, "Hotplugged memory size must be a multiple of "
> -                      "%lld MB", SPAPR_MEMORY_BLOCK_SIZE / M_BYTE);
> -        return;
> -    }
> -
>      mem_dev = object_property_get_str(OBJECT(dimm), PC_DIMM_MEMDEV_PROP, NULL);
>      if (mem_dev && !kvmppc_is_mem_backend_page_size_ok(mem_dev)) {
>          error_setg(errp, "Memory backend has bad page size. "
