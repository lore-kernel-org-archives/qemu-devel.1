Received: from eggs.gnu.org ([2001:4830:134:3::10]:58118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eurDz-00038H-B5
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 22:00:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eurDv-0001Sp-7W
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 22:00:39 -0500
Received: from mga09.intel.com ([134.134.136.24]:7544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eurDu-0001RJ-UL
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 22:00:35 -0500
Date: Sun, 11 Mar 2018 11:00:30 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20180311030030.xow4nzssgxtxdpmu@hz-desktop>
References: <20180311013426.32610-1-haozhong.zhang@intel.com>
	<20180311013426.32610-3-haozhong.zhang@intel.com>
	<c8e811b5-251a-6621-6ada-e894d7eaee43@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8e811b5-251a-6621-6ada-e894d7eaee43@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/5] qmp: distinguish PC-DIMM and NVDIMM
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

On 03/10/18 20:31 -0600, Eric Blake wrote:
> On 03/10/2018 07:34 PM, Haozhong Zhang wrote:
> > It may need to treat PC-DIMM and NVDIMM differently, e.g., when
> > deciding the necessity of non-volatile flag bit in SRAT memory
> > affinity structures.
> > 
> > NVDIMMDeviceInfo, which inherits from PCDIMMDeviceInfo, is added to
> > union type MemoryDeviceInfo to record information of NVDIMM devices.
> > The NVDIMM-specific data is currently left empty and will be filled
> > when necessary in the future.
> 
> Stale comment.

Oops, my stupid miss. I'll send another version soon. 

Thanks,
Haozhong

> 
> > 
> > It also fixes "info memory-devices"/query-memory-devices which
> > currently show nvdimm devices as dimm devices since
> > object_dynamic_cast(obj, TYPE_PC_DIMM) happily cast nvdimm to
> > TYPE_PC_DIMM which it's been inherited from.
> > 
> > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> > ---
> >   hmp.c            | 14 +++++++++++---
> >   hw/mem/pc-dimm.c | 10 +++++++++-
> >   numa.c           | 19 +++++++++++++------
> >   qapi/misc.json   |  6 +++++-
> >   4 files changed, 38 insertions(+), 11 deletions(-)
> > 
> 
> > +++ b/qapi/misc.json
> > @@ -2852,7 +2852,11 @@
> >   #
> >   # Since: 2.1
> 
> Perhaps this could somehow use a '(since 2.12)' tag; but as this is a
> "simple union" (which is anything but simple in the QAPI generator), and
> we're trying to avoid introducing new ones where possible, I'm fine
> overlooking it for now.
> 
> >   ##
> > -{ 'union': 'MemoryDeviceInfo', 'data': {'dimm': 'PCDIMMDeviceInfo'} }
> > +{ 'union': 'MemoryDeviceInfo',
> > +  'data': { 'dimm': 'PCDIMMDeviceInfo',
> > +            'nvdimm': 'PCDIMMDeviceInfo'
> > +          }
> > +}
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
