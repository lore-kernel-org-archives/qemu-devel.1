Received: from eggs.gnu.org ([209.51.188.92]:46855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHFlf-0001jm-Bd
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 18:44:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHFaf-0000yz-RX
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 18:33:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hHFaf-0000xR-J6
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 18:33:09 -0400
Date: Thu, 18 Apr 2019 19:33:01 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190418223301.GQ25134@habkost.net>
References: <cover.1549555521.git.yi.z.zhang@linux.intel.com>
	<5d07bf7e9a3e576f5a87e81d786e8886fb2bb551.1549555521.git.yi.z.zhang@linux.intel.com>
	<20190418220516.GP25134@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418220516.GP25134@habkost.net>
Subject: Re: [Qemu-devel] [PATCH V13 4/5] util/mmap-alloc: support MAP_SYNC
 in qemu_ram_mmap()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zhang, Yi" <yi.z.zhang@linux.intel.com>
Cc: xiaoguangrong.eric@gmail.com, stefanha@redhat.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, richardw.yang@linux.intel.com, mst@redhat.com, imammedo@redhat.com, dan.j.williams@intel.com, qemu-devel@nongnu.org, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

On Thu, Apr 18, 2019 at 07:05:16PM -0300, Eduardo Habkost wrote:
> Hi,
> 
> I found out that this series missed QEMU 4.0 and I was going to
> queue for 4.1, but unfortunately this patch conflicts with:
> 
> commit 2044c3e7116eeac0449dcb4a4130cc8f8b9310da
> Author: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> Date:   Wed Jan 30 21:36:04 2019 -0200
> 
>     mmap-alloc: unfold qemu_ram_mmap()
[...]
> On Fri, Feb 08, 2019 at 06:11:11PM +0800, Zhang, Yi wrote:
> > From: Zhang Yi <yi.z.zhang@linux.intel.com>
> > 
> > When a file supporting DAX is used as vNVDIMM backend, mmap it with
> > MAP_SYNC flag in addition which can ensure file system metadata
> > synced in each guest writes to the backend file, without other QEMU
> > actions (e.g., periodic fsync() by QEMU).
> > 
> > Current, We have below different possible use cases:
> > 
> > 1. pmem=on is set, shared=on is set, MAP_SYNC supported:
> >    a: backend is a dax supporting file.
> >     - MAP_SYNC will active.
> >    b: backend is not a dax supporting file.
> >     - mmap will trigger a warning. then MAP_SYNC flag will be ignored
> > 
> > 2. The rest of cases:
> >    - we will never pass the MAP_SYNC to mmap2
> > 
> > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> > Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>

Untested patch rebase is below.  Can Intel help test it and
submit v14?

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
[ehabkost: Rebased patch to latest code on master]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 util/mmap-alloc.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index 9713f4b960..7063a44c7d 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -10,6 +10,13 @@
  * later.  See the COPYING file in the top-level directory.
  */
 
+#ifdef CONFIG_LINUX
+#include <linux/mman.h>
+#else  /* !CONFIG_LINUX */
+#define MAP_SYNC              0x0
+#define MAP_SHARED_VALIDATE   0x0
+#endif /* CONFIG_LINUX */
+
 #include "qemu/osdep.h"
 #include "qemu/mmap-alloc.h"
 #include "qemu/host-utils.h"
@@ -82,6 +89,7 @@ void *qemu_ram_mmap(int fd,
                     bool is_pmem)
 {
     int flags;
+    int map_sync_flags = 0;
     int guardfd;
     size_t offset;
     size_t pagesize;
@@ -132,10 +140,39 @@ void *qemu_ram_mmap(int fd,
     flags = MAP_FIXED;
     flags |= fd == -1 ? MAP_ANONYMOUS : 0;
     flags |= shared ? MAP_SHARED : MAP_PRIVATE;
+    if (shared && is_pmem) {
+        map_sync_flags = MAP_SYNC | MAP_SHARED_VALIDATE;
+    }
     offset = QEMU_ALIGN_UP((uintptr_t)guardptr, align) - (uintptr_t)guardptr;
 
-    ptr = mmap(guardptr + offset, size, PROT_READ | PROT_WRITE, flags, fd, 0);
-
+    ptr = mmap(guardptr + offset, size, PROT_READ | PROT_WRITE,
+               flags | map_sync_flags, fd, 0);
+
+    if (ptr == MAP_FAILED && map_sync_flags) {
+        if (errno == ENOTSUP) {
+            char *proc_link, *file_name;
+            int len;
+            proc_link = g_strdup_printf("/proc/self/fd/%d", fd);
+            file_name = g_malloc0(PATH_MAX);
+            len = readlink(proc_link, file_name, PATH_MAX - 1);
+            if (len < 0) {
+                len = 0;
+            }
+            file_name[len] = '\0';
+            fprintf(stderr, "Warning: requesting persistence across crashes "
+                    "for backend file %s failed. Proceeding without "
+                    "persistence, data might become corrupted in case of host "
+                    "crash.\n", file_name);
+            g_free(proc_link);
+            g_free(file_name);
+        }
+        /*
+         * if map failed with MAP_SHARED_VALIDATE | MAP_SYNC,
+         * we will remove these flags to handle compatibility.
+         */
+        ptr = mmap(guardptr + offset, size, PROT_READ | PROT_WRITE,
+                   flags, fd, 0);
+    }
     if (ptr == MAP_FAILED) {
         munmap(guardptr, total);
         return MAP_FAILED;
-- 
2.18.0.rc1.1.g3f1ff2140
