Received: from eggs.gnu.org ([2001:4830:134:3::10]:47649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eofrl-0003MX-W1
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 20:41:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eofr1-0006FJ-Jm
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 20:40:09 -0500
Received: from mga11.intel.com ([192.55.52.93]:2118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eofr0-00065w-O8
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 20:39:23 -0500
Date: Thu, 22 Feb 2018 09:40:00 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20180222014000.sejshwednadokhhz@hz-desktop>
References: <20180217063135.21550-1-haozhong.zhang@intel.com>
	<20180220151004.6fb932fb@redhat.com>
	<CAPcyv4g_zoQf-LBOeT8=HO1X3YiNc+vUdZN713=a7uJC_A32Fg@mail.gmail.com>
	<20180221145502.434b3c0b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221145502.434b3c0b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/acpi-build: build SRAT memory affinity
 structures for NVDIMM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Qemu Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 02/21/18 14:55 +0100, Igor Mammedov wrote:
> On Tue, 20 Feb 2018 17:17:58 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > On Tue, Feb 20, 2018 at 6:10 AM, Igor Mammedov <imammedo@redhat.com> wrote:
> > > On Sat, 17 Feb 2018 14:31:35 +0800
> > > Haozhong Zhang <haozhong.zhang@intel.com> wrote:
> > >  
> > >> ACPI 6.2A Table 5-129 "SPA Range Structure" requires the proximity
> > >> domain of a NVDIMM SPA range must match with corresponding entry in
> > >> SRAT table.
> > >>
> > >> The address ranges of vNVDIMM in QEMU are allocated from the
> > >> hot-pluggable address space, which is entirely covered by one SRAT
> > >> memory affinity structure. However, users can set the vNVDIMM
> > >> proximity domain in NFIT SPA range structure by the 'node' property of
> > >> '-device nvdimm' to a value different than the one in the above SRAT
> > >> memory affinity structure.
> > >>
> > >> In order to solve such proximity domain mismatch, this patch build one
> > >> SRAT memory affinity structure for each NVDIMM device with the
> > >> proximity domain used in NFIT. The remaining hot-pluggable address
> > >> space is covered by one or multiple SRAT memory affinity structures
> > >> with the proximity domain of the last node as before.
> > >>
> > >> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>  
> > > If we consider hotpluggable system, correctly implemented OS should
> > > be able pull proximity from Device::_PXM and override any value from SRAT.
> > > Do we really have a problem here (anything that breaks if we would use _PXM)?
> > > Maybe we should add _PXM object to nvdimm device nodes instead of massaging SRAT?  
> > 
> > Unfortunately _PXM is an awkward fit. Currently the proximity domain
> > is attached to the SPA range structure. The SPA range may be
> > associated with multiple DIMM devices and those individual NVDIMMs may
> > have conflicting _PXM properties.
> There shouldn't be any conflict here as  NVDIMM device's _PXM method,
> should override in runtime any proximity specified by parent scope.
> (as parent scope I'd also count boot time NFIT/SRAT tables).
> 
> To make it more clear we could clear valid proximity domain flag in SPA
> like this:
> 
> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
> index 59d6e42..131bca5 100644
> --- a/hw/acpi/nvdimm.c
> +++ b/hw/acpi/nvdimm.c
> @@ -260,9 +260,7 @@ nvdimm_build_structure_spa(GArray *structures, DeviceState *dev)
>       */
>      nfit_spa->flags = cpu_to_le16(1 /* Control region is strictly for
>                                         management during hot add/online
> -                                       operation */ |
> -                                  2 /* Data in Proximity Domain field is
> -                                       valid*/);
> +                                       operation */);
>  
>      /* NUMA node. */
>      nfit_spa->proximity_domain = cpu_to_le32(node);
> 
> > Even if that was unified across
> > DIMMs it is ambiguous whether a DIMM-device _PXM would relate to the
> > device's control interface, or the assembled persistent memory SPA
> > range.
> I'm not sure what you mean under 'device's control interface',
> could you clarify where the ambiguity comes from?
> 
> I read spec as: _PXM applies to address range covered by NVDIMM
> device it belongs to.
> 
> As for assembled SPA, I'd assume that it applies to interleaved set
> and all NVDIMMs with it should be on the same node. It's somewhat
> irrelevant question though as QEMU so far implements only
>   1:1:1/SPA:Region Mapping:NVDIMM Device/
> mapping.
> 
> My main concern with using static configuration tables for proximity
> mapping, we'd miss on hotplug side of equation. However if we start
> from dynamic side first, we could later complement it with static
> tables if there really were need for it.

This patch affects only the static tables and static-plugged NVDIMM.
For hot-plugged NVDIMMs, guest OSPM still needs to evaluate _FIT to
get the information of the new NVDIMMs including their proximity
domains.

One intention of this patch is to simulate the bare metal as much as
possible. I have been using this patch to develop and test NVDIMM
enabling work on Xen, and think it might be useful for developers of
other OS and hypervisors.


Haozhong
