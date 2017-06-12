Received: from eggs.gnu.org ([2001:4830:134:3::10]:39753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dKFs7-0001JT-Ga
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 23:18:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dKFs4-0004xJ-9w
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 23:18:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:12484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1dKFs3-0004wt-Uk
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 23:18:28 -0400
Date: Mon, 12 Jun 2017 11:18:21 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20170612031821.ycsasc2p6svil55a@hz-desktop>
References: <20170606072229.9302-1-haozhong.zhang@intel.com>
	<20170606072229.9302-3-haozhong.zhang@intel.com>
	<20170608154618-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170608154618-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] nvdimm: warn if the backend is not
 a DAX device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <guangrong.xiao@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Dan Williams <dan.j.williams@intel.com>

On 06/08/17 15:51 +0300, Michael S. Tsirkin wrote:
> On Tue, Jun 06, 2017 at 03:22:27PM +0800, Haozhong Zhang wrote:
> > Applications in Linux guest that use device-dax never trigger flush
> > that can be trapped by KVM/QEMU. Meanwhile, if the host backend is not
> > device-dax, QEMU cannot guarantee the persistence of guest writes.
> > Before solving this flushing problem, QEMU should warn users if the
> > host backend is not device-dax.
> 
> No one reads warnings unless things fail but they can be a debugging aid
> if they do. But they have to be simple and robust to be helpful for
> that. This one seems to me too complex and fragile.
>
> 
> > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> > Message-id: CAPcyv4hV2-ZW8SMCRtD0P_86KgR3DHOvNe+6T5SY2u7wXg3gEg@mail.gmail.com
> 
> Don't include this line in commit log please. Put it after --- if you
> must.
> 
> > ---
> >  hw/mem/nvdimm.c      |  6 ++++++
> >  include/qemu/osdep.h |  9 ++++++++
> >  util/osdep.c         | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 76 insertions(+)
> > 
> > diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> > index a9b0863f20..b23542fbdf 100644
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
> > @@ -84,6 +85,11 @@ static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
> >      NVDIMMDevice *nvdimm = NVDIMM(dimm);
> >      uint64_t align, pmem_size, size = memory_region_size(mr);
> >  
> > +    if (!qemu_fd_is_dev_dax(memory_region_get_fd(mr))) {
> > +        error_report("warning: nvdimm backend does not look like a DAX device, "
> > +                     "unable to guarantee persistence of guest writes");
> > +    }
> > +
> >      align = memory_region_get_alignment(mr);
> >  
> >      pmem_size = size - nvdimm->label_size;
> > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> > index 1c9f5e260c..7f26af371e 100644
> > --- a/include/qemu/osdep.h
> > +++ b/include/qemu/osdep.h
> > @@ -470,4 +470,13 @@ char *qemu_get_pid_name(pid_t pid);
> >   */
> >  pid_t qemu_fork(Error **errp);
> >  
> > +/**
> > + * qemu_fd_is_dev_dax:
> > + *
> > + * Check whether @fd describes a DAX device.
> > + *
> > + * Returns true if it is; otherwise, return false.
> > + */
> > +bool qemu_fd_is_dev_dax(int fd);
> > +
> >  #endif
> > diff --git a/util/osdep.c b/util/osdep.c
> > index a2863c8e53..02881f96bc 100644
> > --- a/util/osdep.c
> > +++ b/util/osdep.c
> > @@ -471,3 +471,64 @@ writev(int fd, const struct iovec *iov, int iov_cnt)
> >      return readv_writev(fd, iov, iov_cnt, true);
> >  }
> >  #endif
> > +
> > +#ifdef __linux__
> > +static ssize_t qemu_dev_dax_sysfs_read(int fd, const char *entry,
> > +                                       char *buf, size_t len)
> > +{
> > +    ssize_t read_bytes;
> > +    struct stat st;
> > +    unsigned int major, minor;
> > +    char *path, *pos;
> > +    int sysfs_fd;
> > +
> > +    if (fstat(fd, &st)) {
> > +        return 0;
> > +    }
> > +
> > +    major = major(st.st_rdev);
> > +    minor = minor(st.st_rdev);
> > +    path = g_strdup_printf("/sys/dev/char/%u:%u/%s", major, minor, entry);
> > +
> > +    sysfs_fd = open(path, O_RDONLY);
> > +    g_free(path);
> > +    if (sysfs_fd == -1) {
> > +        return 0;
> > +    }
> > +
> > +    read_bytes = read(sysfs_fd, buf, len - 1);
> > +    close(sysfs_fd);
> > +    if (read_bytes > 0) {
> > +        buf[read_bytes] = '\0';
> > +        pos = g_strstr_len(buf, read_bytes, "\n");
> > +        if (pos) {
> > +            *pos = '\0';
> > +        }
> > +    }
> > +
> > +    return read_bytes;
> > +}
> > +#endif /* __linux__ */
> > +
> > +bool qemu_fd_is_dev_dax(int fd)
> > +{
> > +    bool is_dax = false;
> > +
> > +#ifdef __linux__
> > +    char devtype[7];
> > +    ssize_t len;
> > +
> > +    if (fd == -1) {
> > +        return false;
> > +    }
> > +
> > +    len = qemu_dev_dax_sysfs_read(fd, "device/devtype",
> > +                                  devtype, sizeof(devtype));
> > +    if (len <= 0) {
> > +        return false;
> > +    }
> 
> This can easily trigger false positives e.g. if sysfs access
> is blocked by selinux.
>

A part of userland interface of nvdimm is exposed via sysfs, so QEMU
has to access to certain sysfs entries in order to, e.g. perform the
DAX check in this patch and get alignment requirement in patch 4.

I agree it's not robust if the permission is not properly granted. We
may either
1) require users to grant the permissions to QEMU and document the
   requirements
 or
2) get the information from sysfs from the outside of QEMU
   (e.g. libvirt) which has the permission and then pass to QEMU.

Which one do you think is better?

> 
> > +    is_dax = !strncmp(devtype, "nd_dax", len);
> 
> E.g. will return true on any string starting with nd_dax.
> And it's not clear non-dax devices can't guarantee safety.

This check can be done by checking whether /sys/dev/char/MAJ:MIN/subsystem
points to /sys/class/dax, as Dan suggested, if we decide to access
sysfs in QEMU.

Thanks,
Haozhong

> 
> > +#endif /* __linux__ */
> > +
> > +    return is_dax;
> > +}
> > -- 
> > 2.11.0
