Received: from eggs.gnu.org ([2001:4830:134:3::10]:37980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1etBnl-0007A3-0h
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:34:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1etBng-0007l9-Ul
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:34:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53512 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1etBng-0007km-OL
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:34:36 -0500
Date: Tue, 6 Mar 2018 13:34:27 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180306133427.565a7c81@redhat.com>
In-Reply-To: <d22bd716-c48f-89a6-d264-cea75ab7b3c4@redhat.com>
References: <20180305065710.25876-1-haozhong.zhang@intel.com>
	<20180305065710.25876-3-haozhong.zhang@intel.com>
	<d22bd716-c48f-89a6-d264-cea75ab7b3c4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: Haozhong Zhang <haozhong.zhang@intel.com>, qemu-devel@nongnu.org, mst@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Markus Armbruster <armbru@redhat.com>, dgilbert@redhat.com

On Mon, 5 Mar 2018 13:14:34 -0600
Eric Blake <eblake@redhat.com> wrote:

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
> 
> > +++ b/qapi-schema.json
> > @@ -2920,6 +2920,18 @@
> >             }
> >   }
> >   
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
> PCDIMMDeviceInfo into something that can be generically shared between 
> both the 'dimm' and 'nvdimm' branches without having to create a 
> pointless subtype?
Currently we are lying on query-memory-devices and reporting nvdimm
devices as pcdimm (I haven't noticed it when nvdimms were introduced),
this patch fixes it so it will be clear what type of device is used where.

Later we can extend data{} section with nvdimm specific info as needed.

The second goal of this patch (well, the actual reason I've asked for it),
is to reuse qmp_pc_dimm_device_list() internally in QEMU to get
list of dimm based memory devices, instead of creating yet another
API to do that for internal usage.
