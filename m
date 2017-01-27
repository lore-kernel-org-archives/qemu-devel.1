Received: from eggs.gnu.org ([2001:4830:134:3::10]:41185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cX5Jb-00038N-K6
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 07:07:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cX5JV-00086P-Tc
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 07:07:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cX5JV-00086D-Jy
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 07:07:33 -0500
Date: Fri, 27 Jan 2017 12:07:27 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170127120726.GD3323@work-vm>
References: <20161229091619.31049-1-fanc.fnst@cn.fujitsu.com>
	<20170118051015.GA6649@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170118051015.GA6649@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH RFC] migration: set cpu throttle value by
 workload
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, amit.shah@redhat.com, douly.fnst@cn.fujitsu.com, caoj.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com, izumi.taku@jp.fujitsu.com

* Chao Fan (fanc.fnst@cn.fujitsu.com) wrote:
> Hi all,
> 
> This is a test for this RFC patch.
> 
> Start vm as following:
> cmdline="./x86_64-softmmu/qemu-system-x86_64 -m 2560 \
> -drive if=none,file=/nfs/img/fedora.qcow2,format=qcow2,id=foo \
> -netdev tap,id=hn0,queues=1 \
> -device virtio-net-pci,id=net-pci0,netdev=hn0 \
> -device virtio-blk,drive=foo \
> -enable-kvm -M pc -cpu host \
> -vnc :3 \
> -monitor stdio"
> 
> Continue running benchmark program named himeno[*](modified base on
> original source). The code is in the attach file, make it in MIDDLE.
> It costs much cpu calculation and memory. Then migrate the guest.
> The source host and target host are in one switch.
> 
> "before" means the upstream version, "after" means applying this patch.
> "idpr" means "inst_dirty_pages_rate", a new variable in this RFC PATCH.
> "count" is "dirty sync count" in "info migrate".
> "time" is "total time" in "info migrate".
> "ct pct" is "cpu throttle percentage" in "info migrate".
> 
> -------------------------------------------- 
> |     |    before    |        after        | 
> |-----|--------------|---------------------| 
> |count|time(s)|ct pct|time(s)| idpr |ct pct| 
> |-----|-------|------|-------|------|------| 
> |  1  |    3  |   0  |    4  |   x  |   0  | 
> |  2  |   53  |   0  |   53  | 14237|   0  | 
> |  3  |   97  |   0  |   95  |  3142|   0  | 
> |  4  |  109  |   0  |  105  | 11085|   0  | 
> |  5  |  117  |   0  |  113  | 12894|   0  | 
> |  6  |  125  |  20  |  121  | 13549|  67  | 
> |  7  |  133  |  20  |  130  | 13550|  67  | 
> |  8  |  141  |  20  |  136  | 13587|  67  | 
> |  9  |  149  |  30  |  144  | 13553|  99  | 
> | 10  |  156  |  30  |  152  |  1474|  99  |  
> | 11  |  164  |  30  |  152  |  1706|  99  |  
> | 12  |  172  |  40  |  153  |   0  |  99  |  
> | 13  |  180  |  40  |  153  |   0  |   x  |  
> | 14  |  188  |  40  |---------------------|
> | 15  |  195  |  50  |      completed      |  
> | 16  |  203  |  50  |                     |  
> | 17  |  211  |  50  |                     |  
> | 18  |  219  |  60  |                     |  
> | 19  |  227  |  60  |                     |  
> | 20  |  235  |  60  |                     |  
> | 21  |  242  |  70  |                     |  
> | 22  |  250  |  70  |                     |  
> | 23  |  258  |  70  |                     |  
> | 24  |  266  |  80  |                     |  
> | 25  |  274  |  80  |                     |  
> | 26  |  281  |  80  |                     |  
> | 27  |  289  |  90  |                     |  
> | 28  |  297  |  90  |                     |  
> | 29  |  305  |  90  |                     |  
> | 30  |  315  |  99  |                     |  
> | 31  |  320  |  99  |                     |  
> | 32  |  320  |  99  |                     |  
> | 33  |  321  |  99  |                     |  
> | 34  |  321  |  99  |                     |  
> |--------------------|                     |
> |    completed       |                     |
> --------------------------------------------
> 
> And the "info migrate" when completed:
> 
> before:
> capabilities: xbzrle: off rdma-pin-all: off auto-converge: on
> zero-blocks: off compress: off events: off postcopy-ram: off x-colo: off 
> Migration status: completed
> total time: 321091 milliseconds
> downtime: 573 milliseconds
> setup: 40 milliseconds
> transferred ram: 10509346 kbytes
> throughput: 268.13 mbps
> remaining ram: 0 kbytes
> total ram: 2638664 kbytes
> duplicate: 362439 pages
> skipped: 0 pages
> normal: 2621414 pages
> normal bytes: 10485656 kbytes
> dirty sync count: 34
> 
> after:
> capabilities: xbzrle: off rdma-pin-all: off auto-converge: on
> zero-blocks: off compress: off events: off postcopy-ram: off x-colo: off 
> Migration status: completed
> total time: 152652 milliseconds
> downtime: 290 milliseconds
> setup: 47 milliseconds
> transferred ram: 4997452 kbytes
> throughput: 268.20 mbps
> remaining ram: 0 kbytes
> total ram: 2638664 kbytes
> duplicate: 359598 pages
> skipped: 0 pages
> normal: 1246136 pages
> normal bytes: 4984544 kbytes
> dirty sync count: 13
> 
> It's clear that the total time is much better(321s VS 153s).
> The guest began cpu throttle in the 6th dirty sync. But at this time,
> the dirty pages born too much in this guest. So the default
> cpu throttle percentage(20 and 10) is too small for this condition. I
> just use (inst_dirty_pages_rate / 200) to calculate the cpu throttle
> value. This is just an adhoc algorithm, not supported by any theories. 
> 
> Of course on the other hand, the cpu throttle percentage is higher, the
> guest runs more slowly. But in the result, after applying this patch,
> the guest spend 23s with the cpu throttle percentage is 67 (total time
> from 121 to 144), and 9s with cpu throttle percentage is 99 (total time
> from 144 to completed). But in the upstream version, the guest spend
> 73s with the cpu throttle percentage is 70.80.90 (total time from 21 to
> 30), 6s with the cpu throttle percentage is 99 (total time from 30 to
> completed). So I think the influence to the guest performance after my
> patch is fewer than the upstream version.
> 
> Any comments will be welcome.

Hi Chao Fan,
  I think with this benchmark those results do show it's better;
having 23s of high guest performance loss is better than 73s.

The difficulty is as you say the ' / 200' is an adhoc algorithm,
so for other benchmarks who knows what value we should use - higher
or smaller?  Your test is only on a very small VM (1 CPU, 2.5GB RAM);
what happens on a big VM (say 32 CPU, 256GB RAM).

I think there are two parts to this:
   a) Getting a better measure of how fast the guest changes memory
   b) Modifying the auto-converge parameters

  (a) would be good to do in QEMU
  (b) We can leave to some higher level management system outside
QEMU, as long as we provide (a) in the 'info migrate' status
for that tool to use - it means we don't have to fix that '/ 200'
in qemu.

I'm surprised that your code for (a) goes direct to dirty_memory[]
rather than using the migration_bitmap that we synchronise from;
that only gets updated at the end of each pass and that's what we
calculate the rate from - is your mechanism better than that?

Dave


> [*]http://accc.riken.jp/en/supercom/himenobmt/
> 
> Thanks,
> 
> Chao FanOn Thu, Dec 29, 2016 at 05:16:19PM +0800, Chao Fan wrote:
> >This RFC PATCH is my demo about the new feature, here is my POC mail:
> >https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg00646.html
> >
> >When migration_bitmap_sync executed, get the time and read bitmap to
> >calculate how many dirty pages born between two sync.
> >Use inst_dirty_pages / (time_now - time_prev) / ram_size to get
> >inst_dirty_pages_rate. Then map from the inst_dirty_pages_rate
> >to cpu throttle value. I have no idea how to map it. So I just do
> >that in a simple way. The mapping way is just a guess and should
> >be improved.
> >
> >This is just a demo. There are more methods.
> >1.In another file, calculate the inst_dirty_pages_rate every second
> >  or two seconds or another fixed time. Then set the cpu throttle
> >  value according to the inst_dirty_pages_rate
> >2.When inst_dirty_pages_rate gets a threshold, begin cpu throttle
> >  and set the throttle value.
> >
> >Any comments will be welcome.
> >
> >Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> >---
> > include/qemu/bitmap.h | 17 +++++++++++++++++
> > migration/ram.c       | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
> > 2 files changed, 66 insertions(+)
> >
> >diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
> >index 63ea2d0..dc99f9b 100644
> >--- a/include/qemu/bitmap.h
> >+++ b/include/qemu/bitmap.h
> >@@ -235,4 +235,21 @@ static inline unsigned long *bitmap_zero_extend(unsigned long *old,
> >     return new;
> > }
> > 
> >+static inline unsigned long bitmap_weight(const unsigned long *src, long nbits)
> >+{
> >+    unsigned long i, count = 0, nlong = nbits / BITS_PER_LONG;
> >+
> >+    if (small_nbits(nbits)) {
> >+        return hweight_long(*src & BITMAP_LAST_WORD_MASK(nbits));
> >+    }
> >+    for (i = 0; i < nlong; i++) {
> >+        count += hweight_long(src[i]);
> >+    }
> >+    if (nbits % BITS_PER_LONG) {
> >+        count += hweight_long(src[i] & BITMAP_LAST_WORD_MASK(nbits));
> >+    }
> >+
> >+    return count;
> >+}
> >+
> > #endif /* BITMAP_H */
> >diff --git a/migration/ram.c b/migration/ram.c
> >index a1c8089..f96e3e3 100644
> >--- a/migration/ram.c
> >+++ b/migration/ram.c
> >@@ -44,6 +44,7 @@
> > #include "exec/ram_addr.h"
> > #include "qemu/rcu_queue.h"
> > #include "migration/colo.h"
> >+#include "hw/boards.h"
> > 
> > #ifdef DEBUG_MIGRATION_RAM
> > #define DPRINTF(fmt, ...) \
> >@@ -599,6 +600,9 @@ static int64_t num_dirty_pages_period;
> > static uint64_t xbzrle_cache_miss_prev;
> > static uint64_t iterations_prev;
> > 
> >+static int64_t dirty_pages_time_prev;
> >+static int64_t dirty_pages_time_now;
> >+
> > static void migration_bitmap_sync_init(void)
> > {
> >     start_time = 0;
> >@@ -606,6 +610,49 @@ static void migration_bitmap_sync_init(void)
> >     num_dirty_pages_period = 0;
> >     xbzrle_cache_miss_prev = 0;
> >     iterations_prev = 0;
> >+
> >+    dirty_pages_time_prev = 0;
> >+    dirty_pages_time_now = 0;
> >+}
> >+
> >+static void migration_inst_rate(void)
> >+{
> >+    RAMBlock *block;
> >+    MigrationState *s = migrate_get_current();
> >+    int64_t inst_dirty_pages_rate, inst_dirty_pages = 0;
> >+    int64_t i;
> >+    unsigned long *num;
> >+    unsigned long len = 0;
> >+
> >+    dirty_pages_time_now = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> >+    if (dirty_pages_time_prev != 0) {
> >+        rcu_read_lock();
> >+        DirtyMemoryBlocks *blocks = atomic_rcu_read(
> >+                         &ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION]);
> >+        QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> >+            if (len == 0) {
> >+                len = block->offset;
> >+            }
> >+            len += block->used_length;
> >+        }
> >+        ram_addr_t idx = (len >> TARGET_PAGE_BITS) / DIRTY_MEMORY_BLOCK_SIZE;
> >+        if (((len >> TARGET_PAGE_BITS) % DIRTY_MEMORY_BLOCK_SIZE) != 0) {
> >+            idx++;
> >+        }
> >+        for (i = 0; i < idx; i++) {
> >+            num = blocks->blocks[i];
> >+            inst_dirty_pages += bitmap_weight(num, DIRTY_MEMORY_BLOCK_SIZE);
> >+        }
> >+        rcu_read_unlock();
> >+
> >+        inst_dirty_pages_rate = inst_dirty_pages * TARGET_PAGE_SIZE *
> >+                            1024 * 1024 * 1000 /
> >+                            (dirty_pages_time_now - dirty_pages_time_prev) /
> >+                            current_machine->ram_size;
> >+        s->parameters.cpu_throttle_initial = inst_dirty_pages_rate / 200;
> >+        s->parameters.cpu_throttle_increment = inst_dirty_pages_rate / 200;
> >+    }
> >+    dirty_pages_time_prev = dirty_pages_time_now;
> > }
> > 
> > static void migration_bitmap_sync(void)
> >@@ -629,6 +676,8 @@ static void migration_bitmap_sync(void)
> >     trace_migration_bitmap_sync_start();
> >     memory_global_dirty_log_sync();
> > 
> >+    migration_inst_rate();
> >+
> >     qemu_mutex_lock(&migration_bitmap_mutex);
> >     rcu_read_lock();
> >     QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> >-- 
> >2.9.3
> >
> 
> 

> /********************************************************************
> 
>  This benchmark test program is measuring a cpu performance
>  of floating point operation by a Poisson equation solver.
> 
>  If you have any question, please ask me via email.
>  written by Ryutaro HIMENO, November 26, 2001.
>  Version 3.0
>  ----------------------------------------------
>  Ryutaro Himeno, Dr. of Eng.
>  Head of Computer Information Division,
>  RIKEN (The Institute of Pysical and Chemical Research)
>  Email : himeno@postman.riken.go.jp
>  ---------------------------------------------------------------
>  You can adjust the size of this benchmark code to fit your target
>  computer. In that case, please chose following sets of
>  (mimax,mjmax,mkmax):
>  small : 33,33,65
>  small : 65,65,129
>  midium: 129,129,257
>  large : 257,257,513
>  ext.large: 513,513,1025
>  This program is to measure a computer performance in MFLOPS
>  by using a kernel which appears in a linear solver of pressure
>  Poisson eq. which appears in an incompressible Navier-Stokes solver.
>  A point-Jacobi method is employed in this solver as this method can 
>  be easyly vectrized and be parallelized.
>  ------------------
>  Finite-difference method, curvilinear coodinate system
>  Vectorizable and parallelizable on each grid point
>  No. of grid points : imax x jmax x kmax including boundaries
>  ------------------
>  A,B,C:coefficient matrix, wrk1: source term of Poisson equation
>  wrk2 : working area, OMEGA : relaxation parameter
>  BND:control variable for boundaries and objects ( = 0 or 1)
>  P: pressure
> ********************************************************************/
> 
> #include <stdio.h>
> 
> #ifdef XSMALL
> #define MIMAX            16
> #define MJMAX            16
> #define MKMAX            16
> #endif
> 
> #ifdef SSSMALL
> #define MIMAX            17
> #define MJMAX            17
> #define MKMAX            33
> #endif
> 
> #ifdef SSMALL
> #define MIMAX            33
> #define MJMAX            33
> #define MKMAX            65
> #endif
> 
> #ifdef SMALL
> #define MIMAX            65
> #define MJMAX            65
> #define MKMAX            129
> #endif
> 
> #ifdef MIDDLE
> #define MIMAX            129
> #define MJMAX            129
> #define MKMAX            257
> #endif
> 
> #ifdef LARGE
> #define MIMAX            257
> #define MJMAX            257
> #define MKMAX            513
> #endif
> 
> #ifdef ELARGE
> #define MIMAX            513
> #define MJMAX            513
> #define MKMAX            1025
> #endif
> 
> double second();
> float jacobi();
> void initmt();
> double fflop(int,int,int);
> double mflops(int,double,double);
> 
> static float  p[MIMAX][MJMAX][MKMAX];
> static float  a[4][MIMAX][MJMAX][MKMAX],
>               b[3][MIMAX][MJMAX][MKMAX],
>               c[3][MIMAX][MJMAX][MKMAX];
> static float  bnd[MIMAX][MJMAX][MKMAX];
> static float  wrk1[MIMAX][MJMAX][MKMAX],
>               wrk2[MIMAX][MJMAX][MKMAX];
> 
> static int imax, jmax, kmax;
> static float omega;
> 
> int
> main()
> {
>   int    i,j,k,nn;
>   float  gosa;
>   double cpu,cpu0,cpu1,flop,target;
> 
>   target= 3.0;
>   omega= 0.8;
>   imax = MIMAX-1;
>   jmax = MJMAX-1;
>   kmax = MKMAX-1;
> 
>   /*
>    *    Initializing matrixes
>    */
>   initmt();
>   printf("mimax = %d mjmax = %d mkmax = %d\n",MIMAX, MJMAX, MKMAX);
>   printf("imax = %d jmax = %d kmax =%d\n",imax,jmax,kmax);
> 
>   nn= 3;
>   printf(" Start rehearsal measurement process.\n");
>   printf(" Measure the performance in %d times.\n\n",nn);
> 
>   cpu0= second();
>   gosa= jacobi(nn);
>   cpu1= second();
>   cpu= cpu1 - cpu0;
> 
>   flop= fflop(imax,jmax,kmax);
>   
>   printf(" MFLOPS: %f time(s): %f %e\n\n",
>          mflops(nn,cpu,flop),cpu,gosa);
> 
>   nn= (int)(target/(cpu/3.0));
> 
>   printf(" Now, start the actual measurement process.\n");
>   printf(" The loop will be excuted in %d times\n",nn);
>   printf(" This will take about one minute.\n");
>   printf(" Wait for a while\n\n");
> 
>   /*
>    *    Start measuring
>    */
> while (1)
> {
>   cpu0 = second();
>   gosa = jacobi(nn);
>   cpu1 = second();
> 
>   cpu= cpu1 - cpu0;
>   
>   //printf(" Loop executed for %d times\n",nn);
>   //printf(" Gosa : %e \n",gosa);
>   printf(" MFLOPS measured : %f\tcpu : %f\n",mflops(nn,cpu,flop),cpu);
>   fflush(stdout);
>   //printf(" Score based on Pentium III 600MHz : %f\n",
>   //       mflops(nn,cpu,flop)/82,84);
> }  
>   return (0);
> }
> 
> void
> initmt()
> {
> 	int i,j,k;
> 
>   for(i=0 ; i<MIMAX ; i++)
>     for(j=0 ; j<MJMAX ; j++)
>       for(k=0 ; k<MKMAX ; k++){
>         a[0][i][j][k]=0.0;
>         a[1][i][j][k]=0.0;
>         a[2][i][j][k]=0.0;
>         a[3][i][j][k]=0.0;
>         b[0][i][j][k]=0.0;
>         b[1][i][j][k]=0.0;
>         b[2][i][j][k]=0.0;
>         c[0][i][j][k]=0.0;
>         c[1][i][j][k]=0.0;
>         c[2][i][j][k]=0.0;
>         p[i][j][k]=0.0;
>         wrk1[i][j][k]=0.0;
>         bnd[i][j][k]=0.0;
>       }
> 
>   for(i=0 ; i<imax ; i++)
>     for(j=0 ; j<jmax ; j++)
>       for(k=0 ; k<kmax ; k++){
>         a[0][i][j][k]=1.0;
>         a[1][i][j][k]=1.0;
>         a[2][i][j][k]=1.0;
>         a[3][i][j][k]=1.0/6.0;
>         b[0][i][j][k]=0.0;
>         b[1][i][j][k]=0.0;
>         b[2][i][j][k]=0.0;
>         c[0][i][j][k]=1.0;
>         c[1][i][j][k]=1.0;
>         c[2][i][j][k]=1.0;
>         p[i][j][k]=(float)(i*i)/(float)((imax-1)*(imax-1));
>         wrk1[i][j][k]=0.0;
>         bnd[i][j][k]=1.0;
>       }
> }
> 
> float
> jacobi(int nn)
> {
>   int i,j,k,n;
>   float gosa, s0, ss;
> 
>   for(n=0 ; n<nn ; ++n){
>     gosa = 0.0;
> 
>     for(i=1 ; i<imax-1 ; i++)
>       for(j=1 ; j<jmax-1 ; j++)
>         for(k=1 ; k<kmax-1 ; k++){
>           s0 = a[0][i][j][k] * p[i+1][j  ][k  ]
>              + a[1][i][j][k] * p[i  ][j+1][k  ]
>              + a[2][i][j][k] * p[i  ][j  ][k+1]
>              + b[0][i][j][k] * ( p[i+1][j+1][k  ] - p[i+1][j-1][k  ]
>                               - p[i-1][j+1][k  ] + p[i-1][j-1][k  ] )
>              + b[1][i][j][k] * ( p[i  ][j+1][k+1] - p[i  ][j-1][k+1]
>                                - p[i  ][j+1][k-1] + p[i  ][j-1][k-1] )
>              + b[2][i][j][k] * ( p[i+1][j  ][k+1] - p[i-1][j  ][k+1]
>                                - p[i+1][j  ][k-1] + p[i-1][j  ][k-1] )
>              + c[0][i][j][k] * p[i-1][j  ][k  ]
>              + c[1][i][j][k] * p[i  ][j-1][k  ]
>              + c[2][i][j][k] * p[i  ][j  ][k-1]
>              + wrk1[i][j][k];
> 
>           ss = ( s0 * a[3][i][j][k] - p[i][j][k] ) * bnd[i][j][k];
> 
>           gosa+= ss*ss;
>           /* gosa= (gosa > ss*ss) ? a : b; */
> 
>           wrk2[i][j][k] = p[i][j][k] + omega * ss;
>         }
> 
>     for(i=1 ; i<imax-1 ; ++i)
>       for(j=1 ; j<jmax-1 ; ++j)
>         for(k=1 ; k<kmax-1 ; ++k)
>           p[i][j][k] = wrk2[i][j][k];
>     
>   } /* end n loop */
> 
>   return(gosa);
> }
> 
> double
> fflop(int mx,int my, int mz)
> {
>   return((double)(mz-2)*(double)(my-2)*(double)(mx-2)*34.0);
> }
> 
> double
> mflops(int nn,double cpu,double flop)
> {
>   return(flop/cpu*1.e-6*(double)nn);
> }
> 
> double
> second()
> {
> #include <sys/time.h>
> 
>   struct timeval tm;
>   double t ;
> 
>   static int base_sec = 0,base_usec = 0;
> 
>   gettimeofday(&tm, NULL);
>   
>   if(base_sec == 0 && base_usec == 0)
>     {
>       base_sec = tm.tv_sec;
>       base_usec = tm.tv_usec;
>       t = 0.0;
>   } else {
>     t = (double) (tm.tv_sec-base_sec) + 
>       ((double) (tm.tv_usec-base_usec))/1.0e6 ;
>   }
> 
>   return t ;
> }

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
