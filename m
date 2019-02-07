Received: from eggs.gnu.org ([209.51.188.92]:33705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <neil@tembosocial.com>) id 1grsWZ-0005b2-96
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 17:52:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <neil@tembosocial.com>) id 1grsWY-0000TS-8R
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 17:52:03 -0500
Received: from 206-248-184-9.dsl.teksavvy.com ([206.248.184.9]:39526
	helo=puppet.polldev.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <neil@tembosocial.com>)
	id 1grsWY-0000T8-17
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 17:52:02 -0500
From: Neil Skrypuch <neil@tembosocial.com>
Date: Thu, 07 Feb 2019 17:33:25 -0500
Message-ID: <2932080.UxbmD43V0u@neil>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: [Qemu-devel] [regression] Clock jump on VM migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

We (ab)use migration + block mirroring to perform transparent zero downtime VM 
backups. Basically:

1) do a block mirror of the source VM's disk
2) migrate the source VM to a destination VM using the disk copy
3) cancel the block mirroring
4) resume the source VM
5) shut down the destination VM gracefully and move the disk to backup

Note that both source and destination VMs are running on the same host and 
same disk array.

Relatively recently, the source VM's clock started jumping after step #4. The 
specific amount of clock jump is generally around 1s, but sometimes as much as 
2-3s. I was able to bisect this down to the following QEMU change:

commit dd577a26ff03b6829721b1ffbbf9e7c411b72378
Author: Stefan Hajnoczi <stefanha@redhat.com>
Date:   Fri Apr 27 17:23:11 2018 +0100

    block/file-posix: implement bdrv_co_invalidate_cache() on Linux
    
    On Linux posix_fadvise(POSIX_FADV_DONTNEED) invalidates pages*.  Use
    this to drop page cache on the destination host during shared storage
    migration.  This way the destination host will read the latest copy of
    the data and will not use stale data from the page cache.
    
    The flow is as follows:
    
    1. Source host writes out all dirty pages and inactivates drives.
    2. QEMU_VM_EOF is sent on migration stream.
    3. Destination host invalidates caches before accessing drives.
    
    This patch enables live migration even with -drive cache.direct=off.
    
    * Terms and conditions may apply, please see patch for details.
    
    Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
    Reviewed-by: Fam Zheng <famz@redhat.com>
    Message-id: 20180427162312.18583-2-stefanha@redhat.com
    Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

That patch went in for QEMU 3.0.0, and I can confirm this issue affects both 
3.1.0 and 3.0.0, but not 2.12.0. Most testing has been done on kernel 4.20.5, 
but I also confirmed the issue with 4.13.0.

Reproducing this issue is easy, it happens 100% of the time with a CentOS 7 
guest (other guests not tested), NTP will notice the clock jump quite soon 
after migration.

We are seeing this issue across our entire fleet of VMs, but the specific VM 
I've been testing with has a 20G disk and 1.5G of RAM.

To further debug this issue, I made the following changes:

diff --git a/block/file-posix.c b/block/file-posix.c                                                                                                                           
index 07bbdab953..4724b543df 100644                                                                                                                                            
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
@@ -2581,6 +2582,8 @@ static void coroutine_fn 
raw_co_invalidate_cache(BlockDriverState *bs,                                                                                   
         return; /* No host kernel page cache */                                                                                                                               
     }                                                                                                                                                                         
                                                                                                                                                                               
+    gettimeofday(&t, NULL);                                                                                                                                                   
+    printf("before: %d.%d\n", (int) t.tv_sec, (int) t.tv_usec);                                                                                                               
 #if defined(__linux__)                                                                                                                                                        
     /* This sets the scene for the next syscall... */                                                                                                                         
     ret = bdrv_co_flush(bs);                                                                                                                                                  
@@ -2610,6 +2613,8 @@ static void coroutine_fn 
raw_co_invalidate_cache(BlockDriverState *bs,                                                                                   
      * configurations that should not cause errors.                                                                                                                           
      */                                                                                                                                                                       
 #endif /* !__linux__ */                                                                                                                                                       
+    gettimeofday(&t, NULL);                                                                                                                                                   
+    printf("after: %d.%d\n", (int) t.tv_sec, (int) t.tv_usec);                                                                                                                
 }                                                                                                                                                                             
                                                                                                                                                                               
 static coroutine_fn int

In two separate runs, they produced the following:

before: 1549567702.412048
after: 1549567703.295500
-> clock jump: 949ms

before: 1549576767.707454
after: 1549576768.584981
-> clock jump: 941ms

The clock jump numbers above are from NTP, but you can see that they are quite 
close to the amount of time spent in raw_co_invalidate_cache. So, it looks 
like flushing the cache is just taking a long time and stalling the guest, 
which causes the clock jump. This isn't too surprising as the entire disk 
image was just written as part of the block mirror and would likely still be 
in the cache.

I see the use case for this feature, but I don't think it applies here, as 
we're not technically using shared storage. I believe an option to toggle this 
behaviour on/off and/or some sort of heuristic to guess whether or not it 
should be enabled by default would be in order here.

- Neil
