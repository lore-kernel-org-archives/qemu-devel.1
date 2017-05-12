Received: from eggs.gnu.org ([2001:4830:134:3::10]:44410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d9Bi6-0005Mx-02
	for qemu-devel@nongnu.org; Fri, 12 May 2017 10:38:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d9Bi4-0005Oy-Ux
	for qemu-devel@nongnu.org; Fri, 12 May 2017 10:38:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1d9Bi4-0005No-Ls
	for qemu-devel@nongnu.org; Fri, 12 May 2017 10:38:24 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 12 May 2017 10:38:12 -0400
Message-Id: <20170512143812.31067-2-stefanha@redhat.com>
In-Reply-To: <20170512143812.31067-1-stefanha@redhat.com>
References: <20170512143812.31067-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 1/1] trace: add sanity check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Anthony Xu <anthony.xu@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Anthony Xu <anthony.xu@intel.com>

If trace backend is set to TRACE_NOP, trace_get_vcpu_event_count
returns 0, cause bitmap_new call abort.

The abort can be triggered as follows:

  $ ./configure --enable-trace-backend=nop --target-list=x86_64-softmmu
  $ gdb ./x86_64-softmmu/qemu-system-x86_64 -M q35,accel=kvm -m 1G
  (gdb) bt
  #0  0x00007ffff04e25f7 in raise () from /lib64/libc.so.6
  #1  0x00007ffff04e3ce8 in abort () from /lib64/libc.so.6
  #2  0x00005555559de905 in bitmap_new (nbits=<optimized out>)
      at /home/root/git/qemu2.git/include/qemu/bitmap.h:96
  #3  cpu_common_initfn (obj=0x555556621d30) at qom/cpu.c:399
  #4  0x0000555555a11869 in object_init_with_type (obj=0x555556621d30, ti=0x55555656bbb0) at qom/object.c:341
  #5  0x0000555555a11869 in object_init_with_type (obj=0x555556621d30, ti=0x55555656bd30) at qom/object.c:341
  #6  0x0000555555a11efc in object_initialize_with_type (data=data@entry=0x555556621d30, size=76560,
      type=type@entry=0x55555656bd30) at qom/object.c:376
  #7  0x0000555555a12061 in object_new_with_type (type=0x55555656bd30) at qom/object.c:484
  #8  0x0000555555a121c5 in object_new (typename=typename@entry=0x555556550340 "qemu64-x86_64-cpu")
      at qom/object.c:494
  #9  0x00005555557f6e3d in pc_new_cpu (typename=typename@entry=0x555556550340 "qemu64-x86_64-cpu", apic_id=0,
      errp=errp@entry=0x5555565391b0 <error_fatal>) at /home/root/git/qemu2.git/hw/i386/pc.c:1101
  #10 0x00005555557fa33e in pc_cpus_init (pcms=pcms@entry=0x5555565f9690)
      at /home/root/git/qemu2.git/hw/i386/pc.c:1184
  #11 0x00005555557fe0f6 in pc_q35_init (machine=0x5555565f9690) at /home/root/git/qemu2.git/hw/i386/pc_q35.c:121
  #12 0x000055555574fbad in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at vl.c:4562

Signed-off-by: Anthony Xu <anthony.xu@intel.com>
Message-id: 1494369432-15418-1-git-send-email-anthony.xu@intel.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qom/cpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/qom/cpu.c b/qom/cpu.c
index f02e9c0..f9111a0 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -382,6 +382,7 @@ static void cpu_common_unrealizefn(DeviceState *dev, Error **errp)
 
 static void cpu_common_initfn(Object *obj)
 {
+    uint32_t count;
     CPUState *cpu = CPU(obj);
     CPUClass *cc = CPU_GET_CLASS(obj);
 
@@ -396,7 +397,10 @@ static void cpu_common_initfn(Object *obj)
     QTAILQ_INIT(&cpu->breakpoints);
     QTAILQ_INIT(&cpu->watchpoints);
 
-    cpu->trace_dstate = bitmap_new(trace_get_vcpu_event_count());
+    count = trace_get_vcpu_event_count();
+    if (count) {
+        cpu->trace_dstate = bitmap_new(count);
+    }
 
     cpu_exec_initfn(cpu);
 }
-- 
2.9.3
