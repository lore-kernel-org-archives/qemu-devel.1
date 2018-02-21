Received: from eggs.gnu.org ([2001:4830:134:3::10]:54302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1eoJ2o-0003b5-31
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 20:18:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1eoJ2n-0006VV-1N
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 20:18:02 -0500
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:34847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1eoJ2m-0006Uv-SV
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 20:18:00 -0500
Received: by mail-ot0-x22b.google.com with SMTP id p8so45052otf.2
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 17:18:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180220151004.6fb932fb@redhat.com>
References: <20180217063135.21550-1-haozhong.zhang@intel.com>
	<20180220151004.6fb932fb@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 20 Feb 2018 17:17:58 -0800
Message-ID: <CAPcyv4g_zoQf-LBOeT8=HO1X3YiNc+vUdZN713=a7uJC_A32Fg@mail.gmail.com>
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

On Tue, Feb 20, 2018 at 6:10 AM, Igor Mammedov <imammedo@redhat.com> wrote:
> On Sat, 17 Feb 2018 14:31:35 +0800
> Haozhong Zhang <haozhong.zhang@intel.com> wrote:
>
>> ACPI 6.2A Table 5-129 "SPA Range Structure" requires the proximity
>> domain of a NVDIMM SPA range must match with corresponding entry in
>> SRAT table.
>>
>> The address ranges of vNVDIMM in QEMU are allocated from the
>> hot-pluggable address space, which is entirely covered by one SRAT
>> memory affinity structure. However, users can set the vNVDIMM
>> proximity domain in NFIT SPA range structure by the 'node' property of
>> '-device nvdimm' to a value different than the one in the above SRAT
>> memory affinity structure.
>>
>> In order to solve such proximity domain mismatch, this patch build one
>> SRAT memory affinity structure for each NVDIMM device with the
>> proximity domain used in NFIT. The remaining hot-pluggable address
>> space is covered by one or multiple SRAT memory affinity structures
>> with the proximity domain of the last node as before.
>>
>> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> If we consider hotpluggable system, correctly implemented OS should
> be able pull proximity from Device::_PXM and override any value from SRAT.
> Do we really have a problem here (anything that breaks if we would use _PXM)?
> Maybe we should add _PXM object to nvdimm device nodes instead of massaging SRAT?

Unfortunately _PXM is an awkward fit. Currently the proximity domain
is attached to the SPA range structure. The SPA range may be
associated with multiple DIMM devices and those individual NVDIMMs may
have conflicting _PXM properties. Even if that was unified across
DIMMs it is ambiguous whether a DIMM-device _PXM would relate to the
device's control interface, or the assembled persistent memory SPA
range.
