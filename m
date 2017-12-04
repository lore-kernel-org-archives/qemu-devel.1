Received: from eggs.gnu.org ([2001:4830:134:3::10]:46164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eLjbT-0001N8-Ul
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 00:47:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eLjbQ-00037A-Rt
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 00:47:44 -0500
Received: from mga06.intel.com ([134.134.136.31]:9911)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eLjbQ-00036K-HQ
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 00:47:40 -0500
Date: Mon, 4 Dec 2017 13:47:36 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20171204054736.42xjsh4heqh46rl4@hz-desktop>
References: <20171127043517.22441-1-haozhong.zhang@intel.com>
	<20171127043517.22441-4-haozhong.zhang@intel.com>
	<20171201104454.GI23501@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171201104454.GI23501@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v3 3/3] nvdimm: add 'unarmed' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Xiao Guangrong <guangrong.xiao@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 12/01/17 10:44 +0000, Stefan Hajnoczi wrote:
> On Mon, Nov 27, 2017 at 12:35:17PM +0800, Haozhong Zhang wrote:
> > @@ -312,6 +315,10 @@ nvdimm_build_structure_memdev(GArray *structures, DeviceState *dev)
> >  
> >      /* Only one interleave for PMEM. */
> >      nfit_memdev->interleave_ways = cpu_to_le16(1);
> > +
> > +    if (nvdimm->unarmed) {
> > +        nfit_memdev->flags |= ACPI_NFIT_MEM_NOT_ARMED;
> 
> Missing cpu_to_le16()?
> 
> > +static void nvdimm_set_unarmed(Object *obj, bool value, Error **errp)
> > +{
> > +    NVDIMMDevice *nvdimm = NVDIMM(obj);
> > +    Error *local_err = NULL;
> > +
> > +    if (memory_region_size(&nvdimm->nvdimm_mr)) {
> > +        error_setg(&local_err, "cannot change property value");
> 
> This error message does not explain why the value cannot be changed.  I
> guess this is checking if the device has been realized.
> 
> Please call qdev_prop_set_after_realize() instead:
> 
>   if (memory_region_size(&nvdimm->nvdimm_mr)) {
>       qdev_prop_set_after_realize(DEVICE(obj), "unarmed", &local_err);
>       goto out;
>   }

I'll change in the next version.

Thanks,
Haozhong
