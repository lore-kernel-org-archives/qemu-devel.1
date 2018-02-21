Received: from eggs.gnu.org ([2001:4830:134:3::10]:59243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1eoVjm-0001ui-RT
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 09:51:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1eoVjl-0000JK-IH
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 09:51:14 -0500
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:39233)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1eoVjl-0000J0-BF
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 09:51:13 -0500
Received: by mail-oi0-x22b.google.com with SMTP id t185so1282836oif.6
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 06:51:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180221145502.434b3c0b@redhat.com>
References: <20180217063135.21550-1-haozhong.zhang@intel.com>
	<20180220151004.6fb932fb@redhat.com>
	<CAPcyv4g_zoQf-LBOeT8=HO1X3YiNc+vUdZN713=a7uJC_A32Fg@mail.gmail.com>
	<20180221145502.434b3c0b@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 21 Feb 2018 06:51:11 -0800
Message-ID: <CAPcyv4i=s-C1YxY0vS-pbWfaOrdNCLVhMvbjwKeRu76ZBqXLwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Haozhong Zhang <haozhong.zhang@intel.com>, Qemu Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, Feb 21, 2018 at 5:55 AM, Igor Mammedov <imammedo@redhat.com> wrote:
> On Tue, 20 Feb 2018 17:17:58 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>
>> On Tue, Feb 20, 2018 at 6:10 AM, Igor Mammedov <imammedo@redhat.com> wrote:
>> > On Sat, 17 Feb 2018 14:31:35 +0800
>> > Haozhong Zhang <haozhong.zhang@intel.com> wrote:
>> >
>> >> ACPI 6.2A Table 5-129 "SPA Range Structure" requires the proximity
>> >> domain of a NVDIMM SPA range must match with corresponding entry in
>> >> SRAT table.
>> >>
>> >> The address ranges of vNVDIMM in QEMU are allocated from the
>> >> hot-pluggable address space, which is entirely covered by one SRAT
>> >> memory affinity structure. However, users can set the vNVDIMM
>> >> proximity domain in NFIT SPA range structure by the 'node' property of
>> >> '-device nvdimm' to a value different than the one in the above SRAT
>> >> memory affinity structure.
>> >>
>> >> In order to solve such proximity domain mismatch, this patch build one
>> >> SRAT memory affinity structure for each NVDIMM device with the
>> >> proximity domain used in NFIT. The remaining hot-pluggable address
>> >> space is covered by one or multiple SRAT memory affinity structures
>> >> with the proximity domain of the last node as before.
>> >>
>> >> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
>> > If we consider hotpluggable system, correctly implemented OS should
>> > be able pull proximity from Device::_PXM and override any value from SRAT.
>> > Do we really have a problem here (anything that breaks if we would use _PXM)?
>> > Maybe we should add _PXM object to nvdimm device nodes instead of massaging SRAT?
>>
>> Unfortunately _PXM is an awkward fit. Currently the proximity domain
>> is attached to the SPA range structure. The SPA range may be
>> associated with multiple DIMM devices and those individual NVDIMMs may
>> have conflicting _PXM properties.
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
>> Even if that was unified across
>> DIMMs it is ambiguous whether a DIMM-device _PXM would relate to the
>> device's control interface, or the assembled persistent memory SPA
>> range.
> I'm not sure what you mean under 'device's control interface',
> could you clarify where the ambiguity comes from?

There are multiple SPA range types. In addition to the typical
Persistent Memory SPA range there are also Control Region SPA ranges
for MMIO registers on the DIMM for Block Apertures and other purposes.

>
> I read spec as: _PXM applies to address range covered by NVDIMM
> device it belongs to.

No, an NVDIMM may contribute to multiple SPA ranges and those ranges
may span sockets.

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

Especially when you consider the new HMAT table that wants to have
proximity domains for describing performance characteristics of an
address range relative to an initiator, the _PXM method on an
individual NVDIMM device is a poor fit for describing a wider set.
