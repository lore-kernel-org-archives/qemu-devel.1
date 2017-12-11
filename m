Received: from eggs.gnu.org ([2001:4830:134:3::10]:48115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eOPk7-0003pS-3T
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 10:11:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eOPk3-0006Lg-Fv
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 10:11:43 -0500
Date: Mon, 11 Dec 2017 16:11:29 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171211161129.5c0005f3.cohuck@redhat.com>
In-Reply-To: <585800a9-cab8-a79a-048a-380de5a54f6c@de.ibm.com>
References: <20171211122146.162430-1-borntraeger@de.ibm.com>
	<a26d11cb-4ba6-3bd7-2b00-7fc698cc6cd9@redhat.com>
	<585800a9-cab8-a79a-048a-380de5a54f6c@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 1/1] s390-ccw-virtio: allow
 for systems larger that 7.999TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>

On Mon, 11 Dec 2017 15:04:13 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 12/11/2017 02:55 PM, David Hildenbrand wrote:
> > On 11.12.2017 13:21, Christian Borntraeger wrote:  
> >> KVM does not allow memory regions > KVM_MEM_MAX_NR_PAGES, basically
> >> limiting the memory per slot to 8TB-4k. As memory slots on s390/kvm must
> >> be a multiple of 1MB we need start a new memory region if we cross
> >> 8TB-1M.
> >>
> >> With that (and optimistic overcommitment in the kernel) I was able to
> >> start a 24TB guest on a 1TB system.
> >>
> >> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >> ---
> >>  hw/s390x/s390-virtio-ccw.c | 28 +++++++++++++++++++++++++---
> >>  1 file changed, 25 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> >> index 8425534..073f6ed 100644
> >> --- a/hw/s390x/s390-virtio-ccw.c
> >> +++ b/hw/s390x/s390-virtio-ccw.c
> >> @@ -154,14 +154,36 @@ static void virtio_ccw_register_hcalls(void)
> >>                                     virtio_ccw_hcall_early_printk);
> >>  }
> >>  
> >> +/*
> >> + * KVM does only support memory slots up to KVM_MEM_MAX_NR_PAGES pages
> >> + * as the dirty bitmap must be managed by bitops that take an int as
> >> + * position indicator. If we have a guest beyond that we will split off
> >> + * new subregions. The split must happen on a segment boundary (1MB).
> >> + */
> >> +#define KVM_MEM_MAX_NR_PAGES ((1UL << 31) - 1)
> >> +#define SEG_MSK (~0xfffffULL)
> >> +#define KVM_SLOT_MAX_BYTES ((KVM_MEM_MAX_NR_PAGES * TARGET_PAGE_SIZE) & SEG_MSK)  
> > 
> > Just wondering if we could get into trouble when calculating
> > 
> > KVM_MEM_MAX_NR_PAGES * TARGET_PAGE_SIZE  
> 
> maybe just using 1ULL instead of 1UL?

I vote for 1ULL, just to be on the safe side.

> 
> 
> > 
> > on a host with sizeof(long) == 4
> > 
> > could it wrap? (e.g. crazy mingw stuff)

FWIW, both the 1UL and 1ULL variants compile fine for me both when
building natively and cross-building with mingw.
