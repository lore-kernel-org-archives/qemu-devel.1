Received: from eggs.gnu.org ([2001:4830:134:3::10]:57374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d98oM-0003Xe-0a
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:32:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d98oI-0000tk-QQ
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:32:42 -0400
Received: from mailout3.w1.samsung.com ([210.118.77.13]:19970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1d98oI-0000ix-JO
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:32:38 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout3.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OPU00JR881ZQU80@mailout3.w1.samsung.com> for
	qemu-devel@nongnu.org; Fri, 12 May 2017 12:32:23 +0100 (BST)
Date: Fri, 12 May 2017 14:31:41 +0300
From: Alexey Perevalov <a.perevalov@samsung.com>
In-reply-to: <1494588703-9076-1-git-send-email-a.perevalov@samsung.com>
Message-id: <1494588703-9076-8-git-send-email-a.perevalov@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: QUOTED-PRINTABLE
References: <1494588703-9076-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170512113222eucas1p2f0964bb82e343438798c1c341c1cfe8a@eucas1p2.samsung.com>
Subject: [Qemu-devel] [PATCH V4 7/9] migration: calculate vCPU blocktime on
 dst side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, a.perevalov@samsung.com, i.maximets@samsung.com, peterx@redhat.com

This patch provides blocktime calculation per vCPU,
as a summary and as a overlapped value for all vCPUs.

This approach was suggested by Peter Xu, as an improvements of
previous approch where QEMU kept tree with faulted page address and c=
pus bitmask
in it. Now QEMU is keeping array with faulted page address as value a=
nd vCPU
as index. It helps to find proper vCPU at UFFD_COPY time. Also it kee=
ps
list for blocktime per vCPU (could be traced with page_fault_addr)

Blocktime will not calculated if postcopy_blocktime field of
MigrationIncomingState wasn't initialized.

PostcopyBlocktimeContext is not protected by lock, due to structure i=
tself is
not changing except postcopy end callback, but even in that time will=
 be
query-migrate request, query-migrate is not touching
page_fault_vcpu_time & vcpu_addr.=20

Also atomic for int64_t is using here, but QEMU's atomic_read/set is =
not
allowing operation on types which bigger than pointer size, although =
clang/gcc
supports it
("=E2=80=98__atomic=E2=80=99 builtins can be used with any integral s=
calar or pointer
type that is 1, 2, 4, or 8 bytes in length) also on 32 platforms such=
 as ARM.
Maybe could be a problem with mingw, but postcopy is under linux ifde=
f.

Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 migration/postcopy-ram.c | 87 ++++++++++++++++++++++++++++++++++++++=
+++++++++-
 migration/trace-events   |  5 ++-
 2 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index fd5aadd..db95747 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -23,6 +23,7 @@
 #include "postcopy-ram.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/balloon.h"
+#include <sys/param.h>
 #include "qemu/error-report.h"
 #include "trace.h"
=20
@@ -541,6 +542,86 @@ static int ram_block_enable_notify(const char *b=
lock_name, void *host_addr,
     return 0;
 }
=20
+static int get_mem_fault_cpu_index(uint32_t pid)
+{
+    CPUState *cpu_iter;
+
+    CPU_FOREACH(cpu_iter) {
+        if (cpu_iter->thread_id =3D=3D pid) {
+            return cpu_iter->cpu_index;
+        }
+    }
+    trace_get_mem_fault_cpu_index(pid);
+    return -1;
+}
+
+static void mark_postcopy_blocktime_begin(uint64_t addr, int cpu)
+{
+    MigrationIncomingState *mis =3D migration_incoming_get_current()=
;
+    PostcopyBlocktimeContext *dc;
+    int64_t now_ms;
+    if (!mis->blocktime_ctx || cpu < 0) {
+        return;
+    }
+    now_ms =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    dc =3D mis->blocktime_ctx;
+    if (dc->vcpu_addr[cpu] =3D=3D 0) {
+        atomic_inc(&dc->smp_cpus_down);
+    }
+
+    atomic_xchg__nocheck(&dc->vcpu_addr[cpu], addr);
+    atomic_xchg__nocheck(&dc->last_begin, now_ms);
+    atomic_xchg__nocheck(&dc->page_fault_vcpu_time[cpu], now_ms);
+
+    trace_mark_postcopy_blocktime_begin(addr, dc, dc->page_fault_vcp=
u_time[cpu],
+            cpu);
+}
+
+static void mark_postcopy_blocktime_end(uint64_t addr)
+{
+    MigrationIncomingState *mis =3D migration_incoming_get_current()=
;
+    PostcopyBlocktimeContext *dc;
+    int i, affected_cpu =3D 0;
+    int64_t now_ms;
+    bool vcpu_total_blocktime =3D false;
+
+    if (!mis->blocktime_ctx) {
+        return;
+    }
+    dc =3D mis->blocktime_ctx;
+    now_ms =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+
+    /* lookup cpu, to clear it,
+     * that algorithm looks straighforward, but it's not
+     * optimal, more optimal algorithm is keeping tree or hash
+     * where key is address value is a list of  */
+    for (i =3D 0; i < smp_cpus; i++) {
+        uint64_t vcpu_blocktime =3D 0;
+        if (atomic_fetch_add(&dc->vcpu_addr[i], 0) !=3D addr) {
+            continue;
+        }
+        atomic_xchg__nocheck(&dc->vcpu_addr[i], 0);
+        vcpu_blocktime =3D now_ms -
+            atomic_fetch_add(&dc->page_fault_vcpu_time[i], 0);
+        affected_cpu +=3D 1;
+        /* we need to know is that mark_postcopy_end was due to
+         * faulted page, another possible case it's prefetched
+         * page and in that case we shouldn't be here */
+        if (!vcpu_total_blocktime &&
+            atomic_fetch_add(&dc->smp_cpus_down, 0) =3D=3D smp_cpus)=
 {
+            vcpu_total_blocktime =3D true;
+        }
+        /* continue cycle, due to one page could affect several vCPU=
s */
+        dc->vcpu_blocktime[i] +=3D vcpu_blocktime;
+    }
+
+    atomic_sub(&dc->smp_cpus_down, affected_cpu);
+    if (vcpu_total_blocktime) {
+        dc->total_blocktime +=3D now_ms - atomic_fetch_add(&dc->last=
_begin, 0);
+    }
+    trace_mark_postcopy_blocktime_end(addr, dc, dc->total_blocktime)=
;
+}
+
 /*
  * Handle faults detected by the USERFAULT markings
  */
@@ -618,8 +699,11 @@ static void *postcopy_ram_fault_thread(void *opa=
que)
         rb_offset &=3D ~(qemu_ram_pagesize(rb) - 1);
         trace_postcopy_ram_fault_thread_request(msg.arg.pagefault.ad=
dress,
                                                 qemu_ram_get_idstr(r=
b),
-                                                rb_offset);
+                                                rb_offset,
+                                                msg.arg.pagefault.fe=
at.ptid);
=20
+        mark_postcopy_blocktime_begin((uintptr_t)(msg.arg.pagefault.=
address),
+                         get_mem_fault_cpu_index(msg.arg.pagefault.f=
eat.ptid));
         /*
          * Send the request to the source - we want to request one
          * of our host page sizes (which is >=3D TPS)
@@ -714,6 +798,7 @@ int postcopy_place_page(MigrationIncomingState *m=
is, void *host, void *from,
=20
         return -e;
     }
+    mark_postcopy_blocktime_end((uint64_t)(uintptr_t)host);
=20
     trace_postcopy_place_page(host);
     return 0;
diff --git a/migration/trace-events b/migration/trace-events
index 5b8ccf3..7bdadbb 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -112,6 +112,8 @@ process_incoming_migration_co_end(int ret, int ps=
) "ret=3D%d postcopy-state=3D%d"
 process_incoming_migration_co_postcopy_end_main(void) ""
 migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=
=3D%p ioctype=3D%s"
 migration_set_outgoing_channel(void *ioc, const char *ioctype, const=
 char *hostname)  "ioc=3D%p ioctype=3D%s hostname=3D%s"
+mark_postcopy_blocktime_begin(uint64_t addr, void *dd, int64_t time,=
 int cpu) "addr 0x%" PRIx64 " dd %p time %" PRId64 " cpu %d"
+mark_postcopy_blocktime_end(uint64_t addr, void *dd, int64_t time) "=
addr 0x%" PRIx64 " dd %p time %" PRId64
=20
 # migration/rdma.c
 qemu_rdma_accept_incoming_migration(void) ""
@@ -188,7 +190,7 @@ postcopy_ram_enable_notify(void) ""
 postcopy_ram_fault_thread_entry(void) ""
 postcopy_ram_fault_thread_exit(void) ""
 postcopy_ram_fault_thread_quit(void) ""
-postcopy_ram_fault_thread_request(uint64_t hostaddr, const char *ram=
block, size_t offset) "Request for HVA=3D%" PRIx64 " rb=3D%s offset=
=3D%zx"
+postcopy_ram_fault_thread_request(uint64_t hostaddr, const char *ram=
block, size_t offset, uint32_t pid) "Request for HVA=3D%" PRIx64 " rb=
=3D%s offset=3D%zx %u"
 postcopy_ram_incoming_cleanup_closeuf(void) ""
 postcopy_ram_incoming_cleanup_entry(void) ""
 postcopy_ram_incoming_cleanup_exit(void) ""
@@ -197,6 +199,7 @@ save_xbzrle_page_skipping(void) ""
 save_xbzrle_page_overflow(void) ""
 ram_save_iterate_big_wait(uint64_t milliconds, int iterations) "big =
wait: %" PRIu64 " milliseconds, %d iterations"
 ram_load_complete(int ret, uint64_t seq_iter) "exit_code %d seq iter=
ation %" PRIu64
+get_mem_fault_cpu_index(uint32_t pid) "pid %u is not vCPU"
=20
 # migration/exec.c
 migration_exec_outgoing(const char *cmd) "cmd=3D%s"
--=20
1.8.3.1
