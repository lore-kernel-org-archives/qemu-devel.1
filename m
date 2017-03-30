Received: from eggs.gnu.org ([2001:4830:134:3::10]:47821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chao.gao@intel.com>) id 1ctn8z-0000Id-Pm
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 23:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chao.gao@intel.com>) id 1ctn8w-0002Bd-L3
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 23:22:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:63178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chao.gao@intel.com>) id 1ctn8w-00029q-D2
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 23:22:30 -0400
Date: Fri, 31 Mar 2017 04:19:56 +0800
From: Chao Gao <chao.gao@intel.com>
Message-ID: <20170330201955.GA98879@skl-2s3.sh.intel.com>
References: <1489750157-17401-1-git-send-email-tianyu.lan@intel.com>
	<1489750157-17401-3-git-send-email-tianyu.lan@intel.com>
	<20170330162452.GB1864@perard.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170330162452.GB1864@perard.uk.xensource.com>
Subject: Re: [Qemu-devel] [RFC PATCH 2/4] Xen: add a dummy vIOMMU to
 create/destroy vIOMMU in Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: Lan Tianyu <tianyu.lan@intel.com>, xen-devel@lists.xensource.com, qemu-devel@nongnu.org, kevin.tian@intel.com, sstabellini@kernel.org

On Thu, Mar 30, 2017 at 05:24:52PM +0100, Anthony PERARD wrote:
>Hi,
>
>On Fri, Mar 17, 2017 at 07:29:15PM +0800, Lan Tianyu wrote:
>> From: Chao Gao <chao.gao@intel.com>
>> 
>> Since adding a dynamic sysbus device is forbidden, so choose TYPE_DEVICE
>> as parent class.
>> 
>> Signed-off-by: Chao Gao <chao.gao@intel.com>
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>> ---
>>  hw/xen/Makefile.objs |   1 +
>>  hw/xen/xen_viommu.c  | 116 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 117 insertions(+)
>>  create mode 100644 hw/xen/xen_viommu.c
>> 
>> +static void xen_viommu_realize(DeviceState *dev, Error **errp)
>> +{
>> +    int rc;
>> +    uint64_t cap;
>> +    char *dom;
>> +    char viommu_path[1024];
>> +    XenVIOMMUState *s = XEN_VIOMMU_DEVICE(dev);
>> +
>> +    s->id = -1;
>> +    
>> +    /* Read vIOMMU attributes from Xenstore. */
>> +    dom = xs_get_domain_path(xenstore, xen_domid);
>> +    snprintf(viommu_path, sizeof(viommu_path), "%s/viommu", dom);
>> +    rc = xenstore_read_uint64(viommu_path, "base_addr", &s->base_addr);  
>
>Could these informations (base_addr and cap) be read from the command
>line instead of via xenstore?
>Any reason for these informations to be on xenstore?

Actually, we passed both via command line at first. We just concerned
whether it was ok to pass a address through command line since
we find no device does the similar thing.

>
>> +    if (rc) {
>> +        error_report("Can't get base address of vIOMMU");
>
>I think error_setg should be used instead of error_report.
>
>> +        exit(1);
>
>Also, exit should be remove, and return instead. error_setg would be
>enough to signal that the device can not work.
>
>> +    }
>> +
>> +    rc = xenstore_read_uint64(viommu_path, "cap", &s->cap);
>> +    if (rc) {
>> +        error_report("Can't get capabilities of vIOMMU");
>> +        exit(1);
>> +    }
>> +
>> +    rc = xc_viommu_query_cap(xen_xc, xen_domid, &cap);
>
>Since xc_viommu_* seems to be new, you should use
>xendevicemodel_viommu_* instead, also you will need to define a stub for
>them to be able to compile QEMU against older version of Xen.

Will follow your suggestions above.

Thanks
Chao

>
>
>The patch looks good otherwise.
>
>Thanks,
>
>-- 
>Anthony PERARD
