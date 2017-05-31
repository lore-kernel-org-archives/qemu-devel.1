Received: from eggs.gnu.org ([2001:4830:134:3::10]:51177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dFwre-0006sp-5I
	for qemu-devel@nongnu.org; Wed, 31 May 2017 02:12:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dFwra-0005Uo-Rw
	for qemu-devel@nongnu.org; Wed, 31 May 2017 02:12:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:11611)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1dFwra-0005Tz-IE
	for qemu-devel@nongnu.org; Wed, 31 May 2017 02:12:10 -0400
Date: Wed, 31 May 2017 14:12:05 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20170531061205.pyzuih2htf4vqr7u@hz-desktop>
References: <20170526022438.17478-1-haozhong.zhang@intel.com>
	<20170530091511.GD11362@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170530091511.GD11362@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH 1/2] nvdimm: warn if the backend is not a
 DAX device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>

On 05/30/17 10:15 +0100, Stefan Hajnoczi wrote:
> On Fri, May 26, 2017 at 10:24:37AM +0800, Haozhong Zhang wrote:
> > Applications in Linux guest that use device-dax never trigger flush
> > that can be trapped by KVM/QEMU. Meanwhile, if the host backend is not
> > device-dax, QEMU cannot guarantee the persistence of guest writes.
> > Before solving this flushing problem, QEMU should warn users if the
> > host backend is not device-dax.
> > 
> > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> > Message-id: CAPcyv4hV2-ZW8SMCRtD0P_86KgR3DHOvNe+6T5SY2u7wXg3gEg@mail.gmail.com
> > ---
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Igor Mammedov <imammedo@redhat.com>
> > Cc: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> > Cc: Stefan Hajnoczi <stefanha@gmail.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  hw/mem/nvdimm.c | 37 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> > 
> > diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> > index db896b0bb6..c7bb407f33 100644
> > --- a/hw/mem/nvdimm.c
> > +++ b/hw/mem/nvdimm.c
> > @@ -26,6 +26,7 @@
> >  #include "qapi/error.h"
> >  #include "qapi/visitor.h"
> >  #include "hw/mem/nvdimm.h"
> > +#include "qemu/error-report.h"
> >  
> >  static void nvdimm_get_label_size(Object *obj, Visitor *v, const char *name,
> >                                    void *opaque, Error **errp)
> > @@ -78,12 +79,48 @@ static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm)
> >      return &nvdimm->nvdimm_mr;
> >  }
> >  
> > +static void nvdimm_check_dax(HostMemoryBackend *hostmem)
> > +{
> > +    char *mem_path =
> > +        object_property_get_str(OBJECT(hostmem), "mem-path", NULL);
> > +    char *dev_name = NULL, *sysfs_path = NULL;
> > +    bool is_dax = false;
> > +
> > +    if (!mem_path) {
> > +        goto out;
> > +    }
> > +
> > +    if (!g_str_has_prefix(mem_path, "/dev/dax")) {
> 
> Does not work with relative paths, symlinks, or device nodes in
> non-standard locations.
> 
> A more accurate check is to fstat the file descriptor for the char
> device major/minor number and verify that
> /sys/dev/char/MAJ:MIN/device/devtype is "nd_dax".
>

Yes, Dan also suggested to use this approach. I'll turn to it in v2.

> > +        goto out;
> > +    }
> > +
> > +    dev_name = mem_path + strlen("/dev/");
> > +    sysfs_path = g_strdup_printf("/sys/class/dax/%s", dev_name);
> > +    if (access(sysfs_path, F_OK)) {
> > +        goto out;
> > +    }
> > +
> > +    is_dax = true;
> 
> This check is Linux-specific, please use #ifdef __linux__.  It's okay to
> always print an error on other operating systems.
>

will change

> > +
> > + out:
> > +    if (!is_dax) {
> > +        error_report("warning: nvdimm backend %s is not DAX device, "
> 
> The check is not 100% accurate so:
> 
> s/is not/does not look like a/

ditto

Thanks,
Haozhong

> 
> > +                     "unable to guarantee persistence of guest writes",
> > +                     mem_path ?: "RAM");
> > +    }
> > +
> > +    g_free(sysfs_path);
> > +    g_free(mem_path);
> > +}
> > +
> >  static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
> >  {
> >      MemoryRegion *mr = host_memory_backend_get_memory(dimm->hostmem, errp);
> >      NVDIMMDevice *nvdimm = NVDIMM(dimm);
> >      uint64_t align, pmem_size, size = memory_region_size(mr);
> >  
> > +    nvdimm_check_dax(dimm->hostmem);
> > +
> >      align = memory_region_get_alignment(mr);
> >  
> >      pmem_size = size - nvdimm->label_size;
> > -- 
> > 2.11.0
> > 
