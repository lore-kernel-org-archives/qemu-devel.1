Received: from eggs.gnu.org ([2001:4830:134:3::10]:33034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dazDD-0007pt-SZ
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 02:57:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dazDC-0005N5-Gr
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 02:57:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dazDC-0005Me-82
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 02:57:26 -0400
Date: Fri, 28 Jul 2017 14:57:19 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170728065719.GA8572@pxdev.xzpeter.org>
References: <CGME20170720065249eucas1p2cc3e779e2cde2125f90ae25ff03ac646@eucas1p2.samsung.com>
	<1500533554-5779-4-git-send-email-a.perevalov@samsung.com>
	<20170726014921.GK1595@pxdev.xzpeter.org>
	<19a15ce5-5427-c85b-f194-c3eb6740aef3@samsung.com>
	<20170726084323.GL1595@pxdev.xzpeter.org>
	<fd5bc5a7-d3fe-a0fc-2e27-0ba3389c2c11@samsung.com>
	<20170727023538.GO1595@pxdev.xzpeter.org>
	<bb34d360-3ad8-f6c5-c03a-8d2dc994fb95@samsung.com>
	<20170728042758.GS1595@pxdev.xzpeter.org>
	<bd1a2b11-6475-84ec-9901-66ce81cddec2@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bd1a2b11-6475-84ec-9901-66ce81cddec2@samsung.com>
Subject: Re: [Qemu-devel] [PATCH v8 3/3] migration: add bitmap for received
 page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, quintela@redhat.com, heetae82.ahn@samsung.com, dgilbert@redhat.com

On Fri, Jul 28, 2017 at 09:43:28AM +0300, Alexey Perevalov wrote:
> On 07/28/2017 07:27 AM, Peter Xu wrote:
> >On Thu, Jul 27, 2017 at 10:27:41AM +0300, Alexey Perevalov wrote:
> >>On 07/27/2017 05:35 AM, Peter Xu wrote:
> >>>On Wed, Jul 26, 2017 at 06:24:11PM +0300, Alexey Perevalov wrote:
> >>>>On 07/26/2017 11:43 AM, Peter Xu wrote:
> >>>>>On Wed, Jul 26, 2017 at 11:07:17AM +0300, Alexey Perevalov wrote:
> >>>>>>On 07/26/2017 04:49 AM, Peter Xu wrote:
> >>>>>>>On Thu, Jul 20, 2017 at 09:52:34AM +0300, Alexey Perevalov wrote:
> >>>>>>>>This patch adds ability to track down already received
> >>>>>>>>pages, it's necessary for calculation vCPU block time in
> >>>>>>>>postcopy migration feature, maybe for restore after
> >>>>>>>>postcopy migration failure.
> >>>>>>>>Also it's necessary to solve shared memory issue in
> >>>>>>>>postcopy livemigration. Information about received pages
> >>>>>>>>will be transferred to the software virtual bridge
> >>>>>>>>(e.g. OVS-VSWITCHD), to avoid fallocate (unmap) for
> >>>>>>>>already received pages. fallocate syscall is required for
> >>>>>>>>remmaped shared memory, due to remmaping itself blocks
> >>>>>>>>ioctl(UFFDIO_COPY, ioctl in this case will end with EEXIT
> >>>>>>>>error (struct page is exists after remmap).
> >>>>>>>>
> >>>>>>>>Bitmap is placed into RAMBlock as another postcopy/precopy
> >>>>>>>>related bitmaps.
> >>>>>>>>
> >>>>>>>>Reviewed-by: Peter Xu <peterx@redhat.com>
> >>>>>>>>Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> >>>>>>>>---
> >>>>>>>[...]
> >>>>>>>
> >>>>>>>>  static int qemu_ufd_copy_ioctl(int userfault_fd, void *host_addr,
> >>>>>>>>-        void *from_addr, uint64_t pagesize)
> >>>>>>>>+                               void *from_addr, uint64_t pagesize, RAMBlock *rb)
> >>>>>>>>  {
> >>>>>>>>+    int ret;
> >>>>>>>>      if (from_addr) {
> >>>>>>>>          struct uffdio_copy copy_struct;
> >>>>>>>>          copy_struct.dst = (uint64_t)(uintptr_t)host_addr;
> >>>>>>>>          copy_struct.src = (uint64_t)(uintptr_t)from_addr;
> >>>>>>>>          copy_struct.len = pagesize;
> >>>>>>>>          copy_struct.mode = 0;
> >>>>>>>>-        return ioctl(userfault_fd, UFFDIO_COPY, &copy_struct);
> >>>>>>>>+        ret = ioctl(userfault_fd, UFFDIO_COPY, &copy_struct);
> >>>>>>>>      } else {
> >>>>>>>>          struct uffdio_zeropage zero_struct;
> >>>>>>>>          zero_struct.range.start = (uint64_t)(uintptr_t)host_addr;
> >>>>>>>>          zero_struct.range.len = pagesize;
> >>>>>>>>          zero_struct.mode = 0;
> >>>>>>>>-        return ioctl(userfault_fd, UFFDIO_ZEROPAGE, &zero_struct);
> >>>>>>>>+        ret = ioctl(userfault_fd, UFFDIO_ZEROPAGE, &zero_struct);
> >>>>>>>>+    }
> >>>>>>>>+    if (!ret) {
> >>>>>>>>+        ramblock_recv_bitmap_set(host_addr, rb);
> >>>>>>>Wait...
> >>>>>>>
> >>>>>>>Now we are using 4k-page/bit bitmap, do we need to take care of the
> >>>>>>>huge pages here?  Looks like we are only setting the first bit of it
> >>>>>>>if it is a huge page?
> >>>>>>First version was per ramblock page size, IOW bitmap was smaller in
> >>>>>>case of hugepages.
> >>>>>Yes, but this is not the first version any more. :)
> >>>>>
> >>>>>This patch is using:
> >>>>>
> >>>>>   bitmap_new(rb->max_length >> TARGET_PAGE_BITS);
> >>>>>
> >>>>>to allocate bitmap, so it is using small pages always for bitmap,
> >>>>>right? (I should not really say "4k" pages, here I think the size is
> >>>>>host page size, which is the thing returned from getpagesize()).
> >>>>>
> >>>>>>You mentioned that TARGET_PAGE_SIZE is reasonable for precopy case,
> >>>>>>in "Re: [Qemu-devel] [PATCH v1 2/2] migration: add bitmap for copied page"
> >>>>>>I though TARGET_PAGE_SIZE as transmition unit, is using in precopy even
> >>>>>>hugepage case.
> >>>>>>But it's not so logically, page being marked as dirty, should be sent as a
> >>>>>>whole page.
> >>>>>Sorry if I misunderstood, but I didn't see anything wrong - we are
> >>>>>sending pages in small pages, but when postcopy is there, we do
> >>>>>UFFDIO_COPY in huge page, so everything is fine?
> >>>>I think yes, we chose TARGET_PAGE_SIZE because of wider
> >>>>use case ranges.
> >>>So... are you going to post another version? IIUC we just need to use
> >>>a bitmap_set() to replace the ramblock_recv_bitmap_set(), while set
> >>>the size with "pagesize / TARGET_PAGE_SIZE"?
> >> From my point of view TARGET_PAGE_SIZE/TARGET_PAGE_BITS it's a platform
> >>specific
> >>
> >>and it used in ram_load to copy to buffer so it's more preferred for bitmap size
> >>and I'm not going to replace ramblock_recv_bitmap_set helper - it calculates offset.
> >>
> >>>(I think I was wrong when saying getpagesize() above: the small page
> >>>  should be target page size, while the huge page should be the host's)
> >>I think we should forget about huge page case in "received bitmap"
> >>concept, maybe in "uffd_copied bitmap" it was reasonable ;)
> >Again, I am not sure I got the whole idea of the reply...
> >
> >However, I do think when we UFFDIO_COPY a huge page, then we should do
> >bitmap_set() on the received bitmap for the whole range that the huge
> >page covers.
> for what purpose?

We chose to use small-paged bitmap since in precopy we need to have
such a granularity (in precopy, we can copy a small page even that
small page is on a host huge page).

Since we decided to use the small-paged bitmap, we need to make sure
it follows how it was defined: one bit defines whether the
corresponding small page is received. IMHO not following that is hacky
and error-prone.

> 
> >
> >IMHO, the bitmap is defined as "one bit per small page", and the small
> >page size is TARGET_PAGE_SIZE. We cannot just assume that "as long as
> >the first bit of the huge page is set, all the small pages in the huge
> >page are set".
> At the moment of copying all small pages of the huge page,
> should be received. Yes it's assumption, but I couldn't predict
> side effect, maybe it will be necessary in postcopy failure handling,
> while copying pages back, but I'm not sure right now.
> To know that, need to start implementing it, or at least to deep
> investigation.

Yes, postcopy failure handling is exactly one case where it can be
used. Of course with all the ramblock information we can re-construct
the real bitmap when the source received the bitmaps from destination.
However, why not we make it correct at the very beginning (especially
when it is quite easy to do so)?

(Actually, I asked since I am working on the RFC series of postcopy
 failure recovery. I will post RFCs soon)

Thanks,

-- 
Peter Xu
