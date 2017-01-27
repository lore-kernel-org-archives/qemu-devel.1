Received: from eggs.gnu.org ([2001:4830:134:3::10]:33470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6qu-00050L-Mq
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6qt-0003y4-Ky
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:08 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6qt-0003xR-Ey
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:07 -0500
Received: by mail-wm0-x242.google.com with SMTP id r144so58439863wme.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:46:07 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:22 +0100
Message-Id: <1485524749-118532-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 14/41] Introduce DEVICE_CATEGORY_CPU for CPU
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

Now that CPUs show up in the help text of "-device ?",
we should group them into an appropriate category.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <1484917276-7107-1-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/cpu/core.c          | 8 ++++++++
 include/hw/qdev-core.h | 1 +
 qdev-monitor.c         | 1 +
 qom/cpu.c              | 1 +
 4 files changed, 11 insertions(+)

diff --git a/hw/cpu/core.c b/hw/cpu/core.c
index eff90c1..2bf960d 100644
--- a/hw/cpu/core.c
+++ b/hw/cpu/core.c
@@ -72,10 +72,18 @@ static void cpu_core_instance_init(Object *obj)
     core->nr_threads = smp_threads;
 }
 
+static void cpu_core_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    set_bit(DEVICE_CATEGORY_CPU, dc->categories);
+}
+
 static const TypeInfo cpu_core_type_info = {
     .name = TYPE_CPU_CORE,
     .parent = TYPE_DEVICE,
     .abstract = true,
+    .class_init = cpu_core_class_init,
     .instance_size = sizeof(CPUCore),
     .instance_init = cpu_core_instance_init,
 };
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 2c97347..b44b476 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -26,6 +26,7 @@ typedef enum DeviceCategory {
     DEVICE_CATEGORY_DISPLAY,
     DEVICE_CATEGORY_SOUND,
     DEVICE_CATEGORY_MISC,
+    DEVICE_CATEGORY_CPU,
     DEVICE_CATEGORY_MAX
 } DeviceCategory;
 
diff --git a/qdev-monitor.c b/qdev-monitor.c
index c73410c..5f2fcdf 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -136,6 +136,7 @@ static void qdev_print_devinfos(bool show_no_user)
         [DEVICE_CATEGORY_DISPLAY] = "Display",
         [DEVICE_CATEGORY_SOUND]   = "Sound",
         [DEVICE_CATEGORY_MISC]    = "Misc",
+        [DEVICE_CATEGORY_CPU]     = "CPU",
         [DEVICE_CATEGORY_MAX]     = "Uncategorized",
     };
     GSList *list, *elt;
diff --git a/qom/cpu.c b/qom/cpu.c
index 7f57587..e815db7 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -415,6 +415,7 @@ static void cpu_class_init(ObjectClass *klass, void *data)
     k->cpu_exec_enter = cpu_common_noop;
     k->cpu_exec_exit = cpu_common_noop;
     k->cpu_exec_interrupt = cpu_common_exec_interrupt;
+    set_bit(DEVICE_CATEGORY_CPU, dc->categories);
     dc->realize = cpu_common_realizefn;
     dc->unrealize = cpu_common_unrealizefn;
     /*
-- 
1.8.3.1
