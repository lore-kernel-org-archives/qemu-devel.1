Received: from eggs.gnu.org ([2001:4830:134:3::10]:50362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1daHun-0002sI-Fr
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1daHui-00047J-Pv
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:43:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1daHui-000475-G4
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:43:28 -0400
Date: Wed, 26 Jul 2017 16:43:23 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170726084323.GL1595@pxdev.xzpeter.org>
References: <1500533554-5779-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170720065249eucas1p2cc3e779e2cde2125f90ae25ff03ac646@eucas1p2.samsung.com>
	<1500533554-5779-4-git-send-email-a.perevalov@samsung.com>
	<20170726014921.GK1595@pxdev.xzpeter.org>
	<19a15ce5-5427-c85b-f194-c3eb6740aef3@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19a15ce5-5427-c85b-f194-c3eb6740aef3@samsung.com>
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

On Wed, Jul 26, 2017 at 11:07:17AM +0300, Alexey Perevalov wrote:
> On 07/26/2017 04:49 AM, Peter Xu wrote:
> >On Thu, Jul 20, 2017 at 09:52:34AM +0300, Alexey Perevalov wrote:
> >>This patch adds ability to track down already received
> >>pages, it's necessary for calculation vCPU block time in
> >>postcopy migration feature, maybe for restore after
> >>postcopy migration failure.
> >>Also it's necessary to solve shared memory issue in
> >>postcopy livemigration. Information about received pages
> >>will be transferred to the software virtual bridge
> >>(e.g. OVS-VSWITCHD), to avoid fallocate (unmap) for
> >>already received pages. fallocate syscall is required for
> >>remmaped shared memory, due to remmaping itself blocks
> >>ioctl(UFFDIO_COPY, ioctl in this case will end with EEXIT
> >>error (struct page is exists after remmap).
> >>
> >>Bitmap is placed into RAMBlock as another postcopy/precopy
> >>related bitmaps.
> >>
> >>Reviewed-by: Peter Xu <peterx@redhat.com>
> >>Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> >>---
> >[...]
> >
> >>  static int qemu_ufd_copy_ioctl(int userfault_fd, void *host_addr,
> >>-        void *from_addr, uint64_t pagesize)
> >>+                               void *from_addr, uint64_t pagesize, RAMBlock *rb)
> >>  {
> >>+    int ret;
> >>      if (from_addr) {
> >>          struct uffdio_copy copy_struct;
> >>          copy_struct.dst = (uint64_t)(uintptr_t)host_addr;
> >>          copy_struct.src = (uint64_t)(uintptr_t)from_addr;
> >>          copy_struct.len = pagesize;
> >>          copy_struct.mode = 0;
> >>-        return ioctl(userfault_fd, UFFDIO_COPY, &copy_struct);
> >>+        ret = ioctl(userfault_fd, UFFDIO_COPY, &copy_struct);
> >>      } else {
> >>          struct uffdio_zeropage zero_struct;
> >>          zero_struct.range.start = (uint64_t)(uintptr_t)host_addr;
> >>          zero_struct.range.len = pagesize;
> >>          zero_struct.mode = 0;
> >>-        return ioctl(userfault_fd, UFFDIO_ZEROPAGE, &zero_struct);
> >>+        ret = ioctl(userfault_fd, UFFDIO_ZEROPAGE, &zero_struct);
> >>+    }
> >>+    if (!ret) {
> >>+        ramblock_recv_bitmap_set(host_addr, rb);
> >Wait...
> >
> >Now we are using 4k-page/bit bitmap, do we need to take care of the
> >huge pages here?  Looks like we are only setting the first bit of it
> >if it is a huge page?
> First version was per ramblock page size, IOW bitmap was smaller in
> case of hugepages.

Yes, but this is not the first version any more. :)

This patch is using:

  bitmap_new(rb->max_length >> TARGET_PAGE_BITS);

to allocate bitmap, so it is using small pages always for bitmap,
right? (I should not really say "4k" pages, here I think the size is
host page size, which is the thing returned from getpagesize()).

> 
> 
> You mentioned that TARGET_PAGE_SIZE is reasonable for precopy case,
> in "Re: [Qemu-devel] [PATCH v1 2/2] migration: add bitmap for copied page"
> I though TARGET_PAGE_SIZE as transmition unit, is using in precopy even
> hugepage case.
> But it's not so logically, page being marked as dirty, should be sent as a
> whole page.

Sorry if I misunderstood, but I didn't see anything wrong - we are
sending pages in small pages, but when postcopy is there, we do
UFFDIO_COPY in huge page, so everything is fine?

-- 
Peter Xu
