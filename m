Received: from eggs.gnu.org ([2001:4830:134:3::10]:59173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1eh59B-0001yL-F7
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 22:02:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1eh59A-0004xB-Cj
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 22:02:45 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:45063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1eh59A-0004t2-6K
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 22:02:44 -0500
Received: by mail-oi0-x242.google.com with SMTP id c189so11555945oib.12
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 19:02:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180201022900.4znup2fovqr7bu5m@hz-desktop>
References: <20180131060229.9294-1-haozhong.zhang@intel.com>
	<CAPcyv4gJyS=yiXg6SHxdiHT9vzmLx2yXsfdyOe3+qTLwzrMDQQ@mail.gmail.com>
	<20180201000240.zmwa6wwnthg2su36@hz-desktop>
	<CAPcyv4gZSGtPLt7ED0eOngYApHM8=9CTTjOHKpDCG-GfBes4xQ@mail.gmail.com>
	<20180201002457.hgyvph7z6iys5yvy@hz-desktop>
	<CAPcyv4g=1FQYWTAjrrm9DmZaP3nZEZJKXc6JC=f8GSWhccv+wg@mail.gmail.com>
	<20180201022900.4znup2fovqr7bu5m@hz-desktop>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 31 Jan 2018 19:02:27 -0800
Message-ID: <CAPcyv4i0UFoq-ot0KPBeNaDhENUZJs9iFdjotKny=kSnOHXeMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Dan Williams <dan.j.williams@intel.com>, Qemu Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, dgilbert@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alex Williamson <alex.williamson@redhat.com>

On Wed, Jan 31, 2018 at 6:29 PM, Haozhong Zhang
<haozhong.zhang@intel.com> wrote:
> + vfio maintainer Alex Williamson in case my understanding of vfio is incorrect.
>
> On 01/31/18 16:32 -0800, Dan Williams wrote:
>> On Wed, Jan 31, 2018 at 4:24 PM, Haozhong Zhang
>> <haozhong.zhang@intel.com> wrote:
>> > On 01/31/18 16:08 -0800, Dan Williams wrote:
>> >> On Wed, Jan 31, 2018 at 4:02 PM, Haozhong Zhang
>> >> <haozhong.zhang@intel.com> wrote:
>> >> > On 01/31/18 14:25 -0800, Dan Williams wrote:
>> >> >> On Tue, Jan 30, 2018 at 10:02 PM, Haozhong Zhang
>> >> >> <haozhong.zhang@intel.com> wrote:
>> >> >> > Linux 4.15 introduces a new mmap flag MAP_SYNC, which can be used to
>> >> >> > guarantee the write persistence to mmap'ed files supporting DAX (e.g.,
>> >> >> > files on ext4/xfs file system mounted with '-o dax').
>> >> >>
>> >> >> Wait, MAP_SYNC does not guarantee persistence. It makes sure that the
>> >> >> metadata is in sync after a fault. However, that does not make
>> >> >> filesystem-DAX safe for use with QEMU, because we still need to
>> >> >> coordinate DMA with fileystem operations. There is no way to do that
>> >> >> coordination from within a guest. QEMU needs to use device-dax if the
>> >> >> guest might ever perform DMA to a virtual-pmem range. See this patch
>> >> >> set for more details on the DAX vs DMA problem [1]. I think we need to
>> >> >> enforce this in the host kernel. I.e. do not allow file backed DAX
>> >> >> pages to be mapped in EPT entries unless / until we have a solution to
>> >> >> the DMA synchronization problem. Apologies for not noticing this
>> >> >> earlier.
>> >> >
>> >> > QEMU does not truncate or punch holes of the file once it has been
>> >> > mmap()'ed. Does the problem [1] still exist in such case?
>> >>
>> >> Something else on the system might. The only agent that could enforce
>> >> protection is the kernel, and the kernel will likely just disallow
>> >> passing addresses from filesystem-dax vmas through to a guest
>> >> altogether. I think there's even a problem in the non-DAX case unless
>> >> KVM is pinning pages while they are handed out to a guest. The problem
>> >> is that we don't have a page cache page to pin in the DAX case.
>> >>
>> >
>> > Does it mean any user-space code like
>> >   ptr = mmap(..., fd, ...); // fd refers to a file on DAX filesystem
>> >   // make DMA to ptr
>> > is unsafe?
>>
>> Yes, it is currently unsafe because there is no coordination with the
>> filesytem if it decides to make block layout changes. We can fix that
>> in the non-virtualization case by having the filesystem wait for DMA
>> completion callbacks (i.e. what for all pages to be idle), but as far
>> as I can see we can't do the same coordination for DMA initiated by a
>> guest device driver.
>>
>
> I think that fix [1] also works for KVM/QEMU. The guest DMA are
> performed on two types of devices:
>
> 1. For emulated devices, the guest DMA requests are trapped and
>    actually performed by QEMU on the host side. The host side fix [1]
>    can cover this case.
>
> 2. For passthrough devices, vfio pins all pages, including those
>    backed by dax mode files, used by the guest if any device is
>    passthroughed to it. If I read the commit message in [2] correctly,
>    operations that change the page-to-file offset association of pages
>    from dax mode files will be deferred until the reference count of
>    the affected pages becomes 1.  That is, if any passthrough device
>    is used with a VM, the changes of page-to-file offset will not be
>    able to happen until the VM is shutdown, so the fix [1] still takes
>    effect here.

This sounds like a longterm mapping under control of vfio and not the
filesystem. See get_user_pages_longterm(), it is a problem if pages
are pinned indefinitely especially DAX. It sounds like vfio is in the
same boat as RDMA and cannot support long lived pins of DAX pages. As
of 4.15 RDMA to filesystem-DAX pages has been disabled. The eventual
fix will be to create a "memory-registration with lease" semantic
available for RDMA so that the kernel can forcibly revoke page pinning
to perform physical layout changes. In the near it seems
vaddr_get_pfn() needs to be fixed to use get_user_pages_longterm() so
that filesystem-dax mappings are explicitly disallowed.

> Another question is how a user-space application (e.g., QEMU) knows
> whether it's safe to mmap a file on the DAX file system?

I think we fix vaddr_get_pfn() to start failing for DAX mappings
unless/until we can add a "with lease" mechanism. Userspace will know
when it is safe again when vfio stops failing.
