Received: from eggs.gnu.org ([2001:4830:134:3::10]:39939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1et0PK-0006qf-Fl
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 19:24:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1et0PG-00084C-BM
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 19:24:42 -0500
Received: from mga07.intel.com ([134.134.136.100]:34234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1et0PG-00082k-1x
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 19:24:38 -0500
Date: Tue, 6 Mar 2018 08:24:32 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20180306002432.ckahdaz5vruotd65@hz-desktop>
References: <20180305065710.25876-1-haozhong.zhang@intel.com>
	<20180305065710.25876-3-haozhong.zhang@intel.com>
	<d22bd716-c48f-89a6-d264-cea75ab7b3c4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d22bd716-c48f-89a6-d264-cea75ab7b3c4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/5] qmp: distinguish PC-DIMM and NVDIMM
 in MemoryDeviceInfoList
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Markus Armbruster <armbru@redhat.com>, dgilbert@redhat.com

On 03/05/18 13:14 -0600, Eric Blake wrote:
> On 03/05/2018 12:57 AM, Haozhong Zhang wrote:
> > It may need to treat PC-DIMM and NVDIMM differently, e.g., when
> > deciding the necessity of non-volatile flag bit in SRAT memory
> > affinity structures.
> > 
> > NVDIMMDeviceInfo, which inherits from PCDIMMDeviceInfo, is added to
> > union type MemoryDeviceInfo to record information of NVDIMM devices.
> > The NVDIMM-specific data is currently left empty and will be filled
> > when necessary in the future.
> > 
> > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> > ---
> >   hmp.c            | 14 +++++++++++---
> >   hw/mem/pc-dimm.c | 20 ++++++++++++++++++--
> >   numa.c           | 19 +++++++++++++------
> >   qapi-schema.json | 18 +++++++++++++++++-
> 
> Will need rebasing now that the contents live in qapi/misc.json.

will do

> 
> > +++ b/qapi-schema.json
> > @@ -2920,6 +2920,18 @@
> >             }
> >   }
> > +##
> > +# @NVDIMMDeviceInfo:
> > +#
> > +# NVDIMMDevice state information
> > +#
> > +# Since: 2.12
> > +##
> > +{ 'struct': 'NVDIMMDeviceInfo',
> > +  'base': 'PCDIMMDeviceInfo',
> > +  'data': {}
> > +}
> 
> You added no data, so why did you need the type?
> 
> > +
> >   ##
> >   # @MemoryDeviceInfo:
> >   #
> > @@ -2927,7 +2939,11 @@
> >   #
> >   # Since: 2.1
> >   ##
> > -{ 'union': 'MemoryDeviceInfo', 'data': {'dimm': 'PCDIMMDeviceInfo'} }
> > +{ 'union': 'MemoryDeviceInfo',
> > +  'data': { 'dimm': 'PCDIMMDeviceInfo',
> > +            'nvdimm': 'NVDIMMDeviceInfo'
> 
> Names aren't part of the interface; would it be better to rename
> PCDIMMDeviceInfo into something that can be generically shared between both
> the 'dimm' and 'nvdimm' branches without having to create a pointless
> subtype?
>

The purpose of this NVDIMMDeviceInfo is to introduce
MEMORY_DEVICE_INFO_KIND_NVDIMM, which can be used to distinguish
NVDIMM from PC-DIMM in the list returned from query-memory-device.

If 'data' of NVDIMMDeviceInfo is filled with NVDIMM-specific
information (there does have some), would it make this type less
pointless?

Thanks,
Haozhong
