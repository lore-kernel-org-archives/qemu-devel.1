Received: from eggs.gnu.org ([208.118.235.92]:40154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g8N9E-00068V-18
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 06:15:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g8N98-0007fg-Rf
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 06:15:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1g8N98-0007f4-Jq
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 06:15:46 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  5 Oct 2018 12:15:35 +0200
Message-Id: <1538734535-7483-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/core/generic-loader: Compile only once,
 not for each target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>

The generic-loader is currently compiled target specific due to one
single "#ifdef TARGET_WORDS_BIGENDIAN" in the file. We've already
got a function called target_words_bigendian() for this instead, so
we can put the generic-loader into common-obj to save some compilation
time.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 exec.c                   | 1 -
 hw/core/Makefile.objs    | 2 +-
 hw/core/generic-loader.c | 6 +-----
 hw/virtio/virtio.c       | 1 -
 include/qom/cpu.h        | 2 ++
 qom/cpu.c                | 1 -
 6 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/exec.c b/exec.c
index d0821e6..3ae0e54 100644
--- a/exec.c
+++ b/exec.c
@@ -3910,7 +3910,6 @@ int qemu_target_page_bits_min(void)
  * A helper function for the _utterly broken_ virtio device model to find out if
  * it's running on a big endian machine. Don't do this at home kids!
  */
-bool target_words_bigendian(void);
 bool target_words_bigendian(void)
 {
 #if defined(TARGET_WORDS_BIGENDIAN)
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index eb88ca9..b736ce2 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -20,6 +20,6 @@ common-obj-$(CONFIG_SOFTMMU) += register.o
 common-obj-$(CONFIG_SOFTMMU) += or-irq.o
 common-obj-$(CONFIG_SOFTMMU) += split-irq.o
 common-obj-$(CONFIG_PLATFORM_BUS) += platform-bus.o
+common-obj-$(CONFIG_SOFTMMU) += generic-loader.o
 
-obj-$(CONFIG_SOFTMMU) += generic-loader.o
 obj-$(CONFIG_SOFTMMU) += null-machine.o
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index be29ae1..fbae05f 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -130,11 +130,7 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
         s->cpu = first_cpu;
     }
 
-#ifdef TARGET_WORDS_BIGENDIAN
-    big_endian = 1;
-#else
-    big_endian = 0;
-#endif
+    big_endian = target_words_bigendian();
 
     if (s->file) {
         AddressSpace *as = s->cpu ? s->cpu->as :  NULL;
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 94f5c8e..4e61944 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1169,7 +1169,6 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
     return 0;
 }
 
-bool target_words_bigendian(void);
 static enum virtio_device_endian virtio_default_endian(void)
 {
     if (target_words_bigendian()) {
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index dc130cd..0e2ce80 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -1085,6 +1085,8 @@ void cpu_exec_initfn(CPUState *cpu);
 void cpu_exec_realizefn(CPUState *cpu, Error **errp);
 void cpu_exec_unrealizefn(CPUState *cpu);
 
+bool target_words_bigendian(void);
+
 #ifdef NEED_CPU_H
 
 #ifdef CONFIG_SOFTMMU
diff --git a/qom/cpu.c b/qom/cpu.c
index 92599f3..f774654 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -194,7 +194,6 @@ static bool cpu_common_debug_check_watchpoint(CPUState *cpu, CPUWatchpoint *wp)
     return true;
 }
 
-bool target_words_bigendian(void);
 static bool cpu_common_virtio_is_big_endian(CPUState *cpu)
 {
     return target_words_bigendian();
-- 
1.8.3.1
