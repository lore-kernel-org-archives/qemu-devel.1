Received: from eggs.gnu.org ([2001:4830:134:3::10]:36620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cWRBl-0001KT-7C
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:16:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cWRBi-0005ek-3D
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:16:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cWRBh-0005eV-T3
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:16:50 -0500
References: <1485253571-19058-1-git-send-email-peterx@redhat.com>
	<1485253571-19058-3-git-send-email-peterx@redhat.com>
	<20170124092905.41832531@t450s.home>
	<20170125043221.GD5151@pxdev.xzpeter.org>
	<20170125094317.4298966e@t450s.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5eb1e617-5dec-0826-e683-fd4a6c03af03@redhat.com>
Date: Wed, 25 Jan 2017 18:16:44 +0100
MIME-Version: 1.0
In-Reply-To: <20170125094317.4298966e@t450s.home>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 02/18] vfio: introduce vfio_get_vaddr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, bd.aviv@gmail.com



On 25/01/2017 17:43, Alex Williamson wrote:
> On Wed, 25 Jan 2017 12:32:21 +0800
> Peter Xu <peterx@redhat.com> wrote:
>> I have similar question as well above - IIUC the RCU read lock
>> protects us from not losing the references of memory objects, however
>> in our case even after we release the lock, we are still using the
>> backend ram (vaddr) since we have set it up inside kernel to build up
>> the IO page table. After that, the kernel/device should be able to
>> write to addresses of that backend ram any time.

I don't think that's what happens.  As far as I understand, VFIO pins
the pages corresponding to vaddr, not vaddr itself.  The memory backend
is mmap-ed memory; when you hot-unplug it the munmap releases the VMA
and loses the connection between QEMU's virtual address space and the
pages.  However, the pages stay pinned and stay mapped into VFIO's own
IOMMU page tables.

So if a guest does a memory hot-unplug without IOMMU unmap, it would
keep on seeing the content of the hot-unplugged memory, and the host
could not release the pages, but the guest cannot overwrite QEMU data
structures.

Paolo
