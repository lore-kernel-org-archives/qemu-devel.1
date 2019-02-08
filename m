Received: from eggs.gnu.org ([209.51.188.92]:56335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <neil@tembosocial.com>) id 1gsF0p-00041Y-QH
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 17:52:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <neil@tembosocial.com>) id 1gsF0o-0005S5-3Z
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 17:52:47 -0500
Received: from 206-248-184-9.dsl.teksavvy.com ([206.248.184.9]:39154
	helo=puppet.polldev.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <neil@tembosocial.com>)
	id 1gsF0l-0005EE-W3
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 17:52:45 -0500
From: Neil Skrypuch <neil@tembosocial.com>
Date: Fri, 08 Feb 2019 17:52:25 -0500
Message-ID: <1808957.OXY5YYl177@neil>
In-Reply-To: <20190208094818.GA2608@work-vm>
References: <2932080.UxbmD43V0u@neil>
	<20190208062441.GF16257@stefanha-x1.localdomain>
	<20190208094818.GA2608@work-vm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [Qemu-devel] [regression] Clock jump on VM migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org

On Friday, February 8, 2019 4:48:19 AM EST Dr. David Alan Gilbert wrote:
> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > On Thu, Feb 07, 2019 at 05:33:25PM -0500, Neil Skrypuch wrote:
> > 
> > Thanks for your email!
> > 
> > Please post your QEMU command-line.

For the test VM, we're using the following:

/root/qemu-build/x86_64-softmmu/qemu-system-x86_64 -machine accel=kvm -vga 
cirrus -m 1536 -smp 2,cores=2,sockets=1,threads=1 -drive file=/var/lib/kvm/
testbackup-t1-n.polldev.com.img,format=raw,if=virtio -device virtio-net-
pci,mac=52:54:98:42:45:17,netdev=net1 -netdev type=tap,script=/etc/qemu-ifup-
br2,downscript=no,id=net1 -curses -monitor unix:/var/lib/kvm/monitor/
testbackup-t1-n,server,nowait -name "testbackup-t1-
n.polldev.com",process=testbackup-t1-n.polldev.com

Others are generally along the same lines.

> > > The clock jump numbers above are from NTP, but you can see that they are
> > > quite close to the amount of time spent in raw_co_invalidate_cache. So,
> > > it looks like flushing the cache is just taking a long time and
> > > stalling the guest, which causes the clock jump. This isn't too
> > > surprising as the entire disk image was just written as part of the
> > > block mirror and would likely still be in the cache.
> > > 
> > > I see the use case for this feature, but I don't think it applies here,
> > > as
> > > we're not technically using shared storage. I believe an option to
> > > toggle this behaviour on/off and/or some sort of heuristic to guess
> > > whether or not it should be enabled by default would be in order here.
> > 
> > It would be good to figure out how to perform the flush without
> > affecting guest time at all.  The clock jump will also inconvenience
> > users who do need the flush, so I rather not work around the clock jump
> > for a subset of users only.
> 
> One thing that makes Neil's setup different is that having the source
> and destination on the same host, that fadvise is bound to drop pages
> that are actually in use by the source on the same host.

Yes, flushing those pages in a setup like ours is bound to be expensive. Out 
of curiosity, I tried calling sync(1) after the drive mirror completes but 
before starting the migration. The sync itself was quite slow (~10s), but the 
clock jump was still observed and QEMU's own cache flush still took just as 
long.

I took one more step and both called sync(1) and dropped the system cache with 
echo 3 >/proc/sys/vm/drop_caches right before starting migration. In this 
case, qemu's cache flush was nearly instantaneous and no clock jump was 
observed. Now, dropping the whole system cache is not very nice, but it does 
suggest that if QEMU does the cache flush immediately before starting the 
migration as well as right after that the clock jump wouldn't occur, as long 
as there isn't too much cache dirtying during the migration.

> But I'm also curious at what point in the migration we call the
> invalidate and so which threads get held up, in which state.
> 
> Neil: Another printf would also be interesting, between the
> bdrv_co_flush and the posix_fadvise;  I'm assuming it's the
> bdrv_co_flush that's taking the time but it would be good to check.

I added two more printfs, like so:

diff --git a/block/file-posix.c b/block/file-posix.c                                                                                                                           
index 07bbdab953..ee64a8fc6e 100644                                                                                                                                            
--- a/block/file-posix.c                                                                                                                                                       
+++ b/block/file-posix.c                                                                                                                                                       
@@ -2570,6 +2570,7 @@ static void coroutine_fn 
raw_co_invalidate_cache(BlockDriverState *bs,                                                                                   
 {                                                                                                                                                                             
     BDRVRawState *s = bs->opaque;                                                                                                                                             
     int ret;                                                                                                                                                                  
+    struct timeval t;                                                                                                                                                         
                                                                                                                                                                               
     ret = fd_open(bs);                                                                                                                                                        
     if (ret < 0) {                                                                                                                                                            
@@ -2581,9 +2582,13 @@ static void coroutine_fn 
raw_co_invalidate_cache(BlockDriverState *bs,                                                                                  
         return; /* No host kernel page cache */                                                                                                                               
     }                                                                                                                                                                         
                                                                                                                                                                               
+    gettimeofday(&t, NULL);                                                                                                                                                   
+    printf("before: %d.%d\n", (int) t.tv_sec, (int) t.tv_usec);                                                                                                               
 #if defined(__linux__)                                                                                                                                                        
     /* This sets the scene for the next syscall... */                                                                                                                         
     ret = bdrv_co_flush(bs);                                                                                                                                                  
+    gettimeofday(&t, NULL);                                                                                                                                                   
+    printf("after bdrv_co_flush: %d.%d\n", (int) t.tv_sec, (int) t.tv_usec);                                                                                                  
     if (ret < 0) {                                                                                                                                                            
         error_setg_errno(errp, -ret, "flush failed");                                                                                                                         
         return;                                                                                                                                                               
@@ -2594,6 +2599,8 @@ static void coroutine_fn 
raw_co_invalidate_cache(BlockDriverState *bs,                                                                                   
      * we don't use mmap, and the file should not be in use by other 
processes.                                                                                               
      */                                                                                                                                                                       
     ret = posix_fadvise(s->fd, 0, 0, POSIX_FADV_DONTNEED);                                                                                                                    
+    gettimeofday(&t, NULL);                                                                                                                                                   
+    printf("after posix_fadvise: %d.%d\n", (int) t.tv_sec, (int) t.tv_usec);                                                                                                  
     if (ret != 0) { /* the return value is a positive errno */                                                                                                                
         error_setg_errno(errp, ret, "fadvise failed");                                                                                                                        
         return;                                                                                                                                                               
@@ -2610,6 +2617,8 @@ static void coroutine_fn 
raw_co_invalidate_cache(BlockDriverState *bs,                                                                                   
      * configurations that should not cause errors.                                                                                                                           
      */                                                                                                                                                                       
 #endif /* !__linux__ */                                                                                                                                                       
+    gettimeofday(&t, NULL);                                                                                                                                                   
+    printf("after: %d.%d\n", (int) t.tv_sec, (int) t.tv_usec);                                                                                                                
 }                                                                                                                                                                             
                                                                                                                                                                               
 static coroutine_fn int

Here's the output from a sample run:

before: 1549662160.360669
after bdrv_co_flush: 1549662160.360685
after posix_fadvise: 1549662161.244629
after: 1549662161.244648
-> clock jump: 1002ms

So, the time is more or less all spent in posix_fadvise.

- Neil
