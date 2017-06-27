Received: from eggs.gnu.org ([2001:4830:134:3::10]:47241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dPrVK-0005n4-W9
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 10:30:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dPrVG-00075n-MQ
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 10:30:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:16046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1dPrVG-0006xk-Bl
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 10:30:06 -0400
Date: Tue, 27 Jun 2017 22:30:01 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20170627143001.jsfmxqnaig7nfawx@hz-desktop>
References: <20170622140827.GA29936@stefanha-x1.localdomain>
	<20170623001313.n6cms5sunwuqnf4h@hz-desktop>
	<20170623095522.GB12689@stefanha-x1.localdomain>
	<20170626020501.xq54xlnqmhika3zw@hz-desktop>
	<20170626125651.GA7776@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="v7j5x4tzweyi4mkm"
Content-Disposition: inline
In-Reply-To: <20170626125651.GA7776@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] NVDIMM live migration broken?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong@tencent.com>


--v7j5x4tzweyi4mkm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 06/26/17 13:56 +0100, Stefan Hajnoczi wrote:
> On Mon, Jun 26, 2017 at 10:05:01AM +0800, Haozhong Zhang wrote:
> > On 06/23/17 10:55 +0100, Stefan Hajnoczi wrote:
> > > On Fri, Jun 23, 2017 at 08:13:13AM +0800, haozhong.zhang@intel.com wrote:
> > > > On 06/22/17 15:08 +0100, Stefan Hajnoczi wrote:
> > > > > I tried live migrating a guest with NVDIMM on qemu.git/master (edf8bc984):
> > > > > 
> > > > >   $ qemu -M accel=kvm,nvdimm=on -m 1G,slots=4,maxmem=8G -cpu host \
> > > > >          -object memory-backend-file,id=mem1,share=on,mem-path=nvdimm.dat,size=1G \
> > > > > 	 -device nvdimm,id=nvdimm1,memdev=mem1 \
> > > > > 	 -drive if=virtio,file=test.img,format=raw
> > > > > 
> > > > >   $ qemu -M accel=kvm,nvdimm=on -m 1G,slots=4,maxmem=8G -cpu host \
> > > > >          -object memory-backend-file,id=mem1,share=on,mem-path=nvdimm.dat,size=1G \
> > > > > 	 -device nvdimm,id=nvdimm1,memdev=mem1 \
> > > > > 	 -drive if=virtio,file=test.img,format=raw \
> > > > > 	 -incoming tcp::1234
> > > > > 
> > > > >   (qemu) migrate tcp:127.0.0.1:1234
> > > > > 
> > > > > The guest kernel panics or hangs every time on the destination.  It
> > > > > happens as long as the nvdimm device is present - I didn't even mount it
> > > > > inside the guest.
> > > > > 
> > > > > Is migration expected to work?
> > > > 
> > > > Yes, I tested on QEMU 2.8.0 several months ago and it worked. I'll
> > > > have a look at this issue.
> > > 
> > > Great, thanks!
> > > 
> > > David Gilbert suggested the following on IRC, it sounds like a good
> > > starting point for debugging:
> > > 
> > > Launch the destination QEMU with -S (vcpus will be paused) and after
> > > migration has completed, compare the NVDIMM contents on source and
> > > destination.
> > > 
> > 
> > Which host and guest kernel are you testing? Is any workload running
> > in guest when migration?
> > 
> > I just tested QEMU commit edf8bc984 with host/guest kernel 4.8.0, and
> > could not reproduce the issue.
> 
> I can still reproduce the problem on qemu.git edf8bc984.
> 
> My guest kernel is fairly close to yours.  The host kernel is newer.
> 
> Host kernel: 4.11.6-201.fc25.x86_64
> Guest kernel: 4.8.8-300.fc25.x86_64
> 
> Command-line:
> 
>   qemu-system-x86_64 \
>       -enable-kvm \
>       -cpu host \
>       -machine pc,nvdimm \
>       -m 1G,slots=4,maxmem=8G \
>       -object memory-backend-file,id=mem1,share=on,mem-path=nvdimm.dat,size=1G \
>       -device nvdimm,id=nvdimm1,memdev=mem1 \
>       -drive if=virtio,file=test.img,format=raw \
>       -display none \
>       -serial stdio \
>       -monitor unix:/tmp/monitor.sock,server,nowait
> 
> Start migration at the guest login prompt.  You don't need to log in or
> do anything inside the guest.
> 
> There seems to be a guest RAM corruption because I get different
> backtraces inside the guest every time.
> 
> The problem goes away if I remove -device nvdimm.
> 

I managed to reproduce this bug. After bisect between good v2.8.0 and
bad edf8bc984, it looks a regression introduced by
    6b6712efccd "ram: Split dirty bitmap by RAMBlock"
This commit may result in guest crash after migration if any host
memory backend is used.

Could you test whether the attached draft patch fixes this bug? If yes,
I will make a formal patch later.

Thanks,
Haozhong

--v7j5x4tzweyi4mkm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="migration-fix.patch"

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 73d1bea8b6..2ae4ff3965 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -377,7 +377,9 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
                                                uint64_t *real_dirty_pages)
 {
     ram_addr_t addr;
+    ram_addr_t offset = rb->offset;
     unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
+    unsigned long dirty_page = BIT_WORD((start + offset) >> TARGET_PAGE_BITS);
     uint64_t num_dirty = 0;
     unsigned long *dest = rb->bmap;
 
@@ -386,8 +388,9 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
         int k;
         int nr = BITS_TO_LONGS(length >> TARGET_PAGE_BITS);
         unsigned long * const *src;
-        unsigned long idx = (page * BITS_PER_LONG) / DIRTY_MEMORY_BLOCK_SIZE;
-        unsigned long offset = BIT_WORD((page * BITS_PER_LONG) %
+        unsigned long idx = (dirty_page * BITS_PER_LONG) /
+                            DIRTY_MEMORY_BLOCK_SIZE;
+        unsigned long offset = BIT_WORD((dirty_page * BITS_PER_LONG) %
                                         DIRTY_MEMORY_BLOCK_SIZE);
 
         rcu_read_lock();
@@ -416,7 +419,7 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
     } else {
         for (addr = 0; addr < length; addr += TARGET_PAGE_SIZE) {
             if (cpu_physical_memory_test_and_clear_dirty(
-                        start + addr,
+                        start + addr + offset,
                         TARGET_PAGE_SIZE,
                         DIRTY_MEMORY_MIGRATION)) {
                 *real_dirty_pages += 1;

--v7j5x4tzweyi4mkm--
