Received: from eggs.gnu.org ([2001:4830:134:3::10]:54575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eh4d2-0002mF-Bc
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 21:29:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eh4cz-00071b-3t
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 21:29:32 -0500
Received: from mga02.intel.com ([134.134.136.20]:10499)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eh4cy-00070l-Qh
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 21:29:29 -0500
Date: Thu, 1 Feb 2018 10:29:00 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20180201022900.4znup2fovqr7bu5m@hz-desktop>
References: <20180131060229.9294-1-haozhong.zhang@intel.com>
	<CAPcyv4gJyS=yiXg6SHxdiHT9vzmLx2yXsfdyOe3+qTLwzrMDQQ@mail.gmail.com>
	<20180201000240.zmwa6wwnthg2su36@hz-desktop>
	<CAPcyv4gZSGtPLt7ED0eOngYApHM8=9CTTjOHKpDCG-GfBes4xQ@mail.gmail.com>
	<20180201002457.hgyvph7z6iys5yvy@hz-desktop>
	<CAPcyv4g=1FQYWTAjrrm9DmZaP3nZEZJKXc6JC=f8GSWhccv+wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4g=1FQYWTAjrrm9DmZaP3nZEZJKXc6JC=f8GSWhccv+wg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/6] nvdimm: support MAP_SYNC for
 memory-backend-file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, dgilbert@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alex Williamson <alex.williamson@redhat.com>

+ vfio maintainer Alex Williamson in case my understanding of vfio is incorrect.

On 01/31/18 16:32 -0800, Dan Williams wrote:
> On Wed, Jan 31, 2018 at 4:24 PM, Haozhong Zhang
> <haozhong.zhang@intel.com> wrote:
> > On 01/31/18 16:08 -0800, Dan Williams wrote:
> >> On Wed, Jan 31, 2018 at 4:02 PM, Haozhong Zhang
> >> <haozhong.zhang@intel.com> wrote:
> >> > On 01/31/18 14:25 -0800, Dan Williams wrote:
> >> >> On Tue, Jan 30, 2018 at 10:02 PM, Haozhong Zhang
> >> >> <haozhong.zhang@intel.com> wrote:
> >> >> > Linux 4.15 introduces a new mmap flag MAP_SYNC, which can be used to
> >> >> > guarantee the write persistence to mmap'ed files supporting DAX (e.g.,
> >> >> > files on ext4/xfs file system mounted with '-o dax').
> >> >>
> >> >> Wait, MAP_SYNC does not guarantee persistence. It makes sure that the
> >> >> metadata is in sync after a fault. However, that does not make
> >> >> filesystem-DAX safe for use with QEMU, because we still need to
> >> >> coordinate DMA with fileystem operations. There is no way to do that
> >> >> coordination from within a guest. QEMU needs to use device-dax if the
> >> >> guest might ever perform DMA to a virtual-pmem range. See this patch
> >> >> set for more details on the DAX vs DMA problem [1]. I think we need to
> >> >> enforce this in the host kernel. I.e. do not allow file backed DAX
> >> >> pages to be mapped in EPT entries unless / until we have a solution to
> >> >> the DMA synchronization problem. Apologies for not noticing this
> >> >> earlier.
> >> >
> >> > QEMU does not truncate or punch holes of the file once it has been
> >> > mmap()'ed. Does the problem [1] still exist in such case?
> >>
> >> Something else on the system might. The only agent that could enforce
> >> protection is the kernel, and the kernel will likely just disallow
> >> passing addresses from filesystem-dax vmas through to a guest
> >> altogether. I think there's even a problem in the non-DAX case unless
> >> KVM is pinning pages while they are handed out to a guest. The problem
> >> is that we don't have a page cache page to pin in the DAX case.
> >>
> >
> > Does it mean any user-space code like
> >   ptr = mmap(..., fd, ...); // fd refers to a file on DAX filesystem
> >   // make DMA to ptr
> > is unsafe?
> 
> Yes, it is currently unsafe because there is no coordination with the
> filesytem if it decides to make block layout changes. We can fix that
> in the non-virtualization case by having the filesystem wait for DMA
> completion callbacks (i.e. what for all pages to be idle), but as far
> as I can see we can't do the same coordination for DMA initiated by a
> guest device driver.
> 

I think that fix [1] also works for KVM/QEMU. The guest DMA are
performed on two types of devices:

1. For emulated devices, the guest DMA requests are trapped and
   actually performed by QEMU on the host side. The host side fix [1]
   can cover this case.

2. For passthrough devices, vfio pins all pages, including those
   backed by dax mode files, used by the guest if any device is
   passthroughed to it. If I read the commit message in [2] correctly,
   operations that change the page-to-file offset association of pages
   from dax mode files will be deferred until the reference count of
   the affected pages becomes 1.  That is, if any passthrough device
   is used with a VM, the changes of page-to-file offset will not be
   able to happen until the VM is shutdown, so the fix [1] still takes
   effect here.

Another question is how a user-space application (e.g., QEMU) knows
whether it's safe to mmap a file on the DAX file system?

[1] https://lists.01.org/pipermail/linux-nvdimm/2017-December/013704.html
[2] https://lists.01.org/pipermail/linux-nvdimm/2017-December/013713.html


Thanks,
Haozhong
