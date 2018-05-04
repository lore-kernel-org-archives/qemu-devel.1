Received: from eggs.gnu.org ([2001:4830:134:3::10]:34080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fEV5z-0004KZ-4n
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:25:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fEV5x-0007Bt-Hh
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:25:35 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  4 May 2018 09:25:04 +0200
Message-Id: <20180504072514.8450-6-cohuck@redhat.com>
In-Reply-To: <20180504072514.8450-1-cohuck@redhat.com>
References: <20180504072514.8450-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 05/15] hw/s390x: Allow to configure the consoles
 with the "-serial" parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The consoles ("sclpconsole" and "sclplmconsole") can only be configured
with "-device" and "-chardev" so far. Other machines use the convenience
option "-serial" to configure the default consoles, even for virtual
consoles like spapr-vty on the pseries machine. So let's support this
option on s390x, too. This way we can easily enable the serial console
here again with "-nodefaults", for example:

qemu-system-s390x -no-shutdown -nographic -nodefaults -serial mon:stdio

... which is way shorter than typing:

qemu-system-s390x -no-shutdown -nographic -nodefaults \
  -chardev stdio,id=c1,mux=on -device sclpconsole,chardev=c1 \
  -mon chardev=c1

The -serial parameter can also be used if you only want to see the QEMU
monitor on stdio without using -nodefaults, but not the console output.
That's something that is pretty impossible with the current code today:

qemu-system-s390x -no-shutdown -nographic -serial none

While we're at it, this patch also maps the second -serial option to the
"sclplmconsole", so that there is now an easy way to configure this second
console on s390x, too, for example:

qemu-system-s390x -no-shutdown -nographic -serial null -serial mon:stdio

Additionally, the new code is also smaller than the old one and we have
less s390x-specific code in vl.c :-)

I've also checked that migration still works as expected by migrating
a guest with console output back and forth between a qemu-system-s390x
that has this patch and an instance without this patch.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1524754794-28005-1-git-send-email-thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/event-facility.c         | 14 +++++++++++
 hw/s390x/s390-virtio-ccw.c        | 19 +++++++++++++--
 include/hw/boards.h               |  1 -
 include/hw/s390x/event-facility.h |  2 ++
 tests/boot-serial-test.c          |  3 +--
 vl.c                              | 50 ---------------------------------------
 6 files changed, 34 insertions(+), 55 deletions(-)

diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 0dea6cccae..ee5b83448b 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -543,3 +543,17 @@ static void register_types(void)
 }
 
 type_init(register_types)
+
+BusState *sclp_get_event_facility_bus(void)
+{
+    Object *busobj;
+    SCLPEventsBus *sbus;
+
+    busobj = object_resolve_path_type("", TYPE_SCLP_EVENTS_BUS, NULL);
+    sbus = OBJECT_CHECK(SCLPEventsBus, busobj, TYPE_SCLP_EVENTS_BUS);
+    if (!sbus) {
+        return NULL;
+    }
+
+    return &sbus->qbus;
+}
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index c84098dd17..100dfdc96d 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -288,6 +288,15 @@ static void s390_create_virtio_net(BusState *bus, const char *name)
     }
 }
 
+static void s390_create_sclpconsole(const char *type, Chardev *chardev)
+{
+    DeviceState *dev;
+
+    dev = qdev_create(sclp_get_event_facility_bus(), type);
+    qdev_prop_set_chr(dev, "chardev", chardev);
+    qdev_init_nofail(dev);
+}
+
 static void ccw_init(MachineState *machine)
 {
     int ret;
@@ -346,6 +355,14 @@ static void ccw_init(MachineState *machine)
     /* Create VirtIO network adapters */
     s390_create_virtio_net(BUS(css_bus), "virtio-net-ccw");
 
+    /* init consoles */
+    if (serial_hd(0)) {
+        s390_create_sclpconsole("sclpconsole", serial_hd(0));
+    }
+    if (serial_hd(1)) {
+        s390_create_sclpconsole("sclplmconsole", serial_hd(1));
+    }
+
     /* Register savevm handler for guest TOD clock */
     register_savevm_live(NULL, "todclock", 0, 1, &savevm_gtod, NULL);
 }
@@ -470,10 +487,8 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
     mc->no_floppy = 1;
-    mc->no_serial = 1;
     mc->no_parallel = 1;
     mc->no_sdcard = 1;
-    mc->use_sclp = 1;
     mc->max_cpus = S390_MAX_CPUS;
     mc->has_hotpluggable_cpus = true;
     mc->get_hotplug_handler = s390_get_hotplug_handler;
diff --git a/include/hw/boards.h b/include/hw/boards.h
index a609239112..5c5eee55e6 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -180,7 +180,6 @@ struct MachineClass {
     unsigned int no_serial:1,
         no_parallel:1,
         use_virtcon:1,
-        use_sclp:1,
         no_floppy:1,
         no_cdrom:1,
         no_sdcard:1,
diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-facility.h
index 8b39a80bb9..6cf71cec38 100644
--- a/include/hw/s390x/event-facility.h
+++ b/include/hw/s390x/event-facility.h
@@ -210,4 +210,6 @@ typedef struct SCLPEventFacilityClass {
     bool (*event_pending)(SCLPEventFacility *ef);
 } SCLPEventFacilityClass;
 
+BusState *sclp_get_event_facility_bus(void);
+
 #endif
diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index 011525d8cf..4d6815c3e0 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -96,8 +96,7 @@ static testdef_t tests[] = {
     { "sparc", "SS-4", "", "MB86904" },
     { "sparc", "SS-600MP", "", "TMS390Z55" },
     { "sparc64", "sun4u", "", "UltraSPARC" },
-    { "s390x", "s390-ccw-virtio",
-      "-nodefaults -device sclpconsole,chardev=serial0", "virtio device" },
+    { "s390x", "s390-ccw-virtio", "", "virtio device" },
     { "m68k", "mcf5208evb", "", "TT", sizeof(kernel_mcf5208), kernel_mcf5208 },
     { "microblaze", "petalogix-s3adsp1800", "", "TT",
       sizeof(kernel_pls3adsp1800), kernel_pls3adsp1800 },
diff --git a/vl.c b/vl.c
index 7487535dca..806eec2ef6 100644
--- a/vl.c
+++ b/vl.c
@@ -133,7 +133,6 @@ int main(int argc, char **argv)
 #include "sysemu/iothread.h"
 
 #define MAX_VIRTIO_CONSOLES 1
-#define MAX_SCLP_CONSOLES 1
 
 static const char *data_dir[16];
 static int data_dir_idx;
@@ -158,7 +157,6 @@ static int num_serial_hds = 0;
 static Chardev **serial_hds = NULL;
 Chardev *parallel_hds[MAX_PARALLEL_PORTS];
 Chardev *virtcon_hds[MAX_VIRTIO_CONSOLES];
-Chardev *sclp_hds[MAX_SCLP_CONSOLES];
 int win2k_install_hack = 0;
 int singlestep = 0;
 int smp_cpus;
@@ -210,7 +208,6 @@ static int has_defaults = 1;
 static int default_serial = 1;
 static int default_parallel = 1;
 static int default_virtcon = 1;
-static int default_sclp = 1;
 static int default_monitor = 1;
 static int default_floppy = 1;
 static int default_cdrom = 1;
@@ -2588,39 +2585,6 @@ static int virtcon_parse(const char *devname)
     return 0;
 }
 
-static int sclp_parse(const char *devname)
-{
-    QemuOptsList *device = qemu_find_opts("device");
-    static int index = 0;
-    char label[32];
-    QemuOpts *dev_opts;
-
-    if (strcmp(devname, "none") == 0) {
-        return 0;
-    }
-    if (index == MAX_SCLP_CONSOLES) {
-        error_report("too many sclp consoles");
-        exit(1);
-    }
-
-    assert(arch_type == QEMU_ARCH_S390X);
-
-    dev_opts = qemu_opts_create(device, NULL, 0, NULL);
-    qemu_opt_set(dev_opts, "driver", "sclpconsole", &error_abort);
-
-    snprintf(label, sizeof(label), "sclpcon%d", index);
-    sclp_hds[index] = qemu_chr_new(label, devname);
-    if (!sclp_hds[index]) {
-        error_report("could not connect sclp console"
-                     " to character backend '%s'", devname);
-        return -1;
-    }
-    qemu_opt_set(dev_opts, "chardev", label, &error_abort);
-
-    index++;
-    return 0;
-}
-
 static int debugcon_parse(const char *devname)
 {
     QemuOpts *opts;
@@ -4254,9 +4218,6 @@ int main(int argc, char **argv, char **envp)
     if (!has_defaults || !machine_class->use_virtcon) {
         default_virtcon = 0;
     }
-    if (!has_defaults || !machine_class->use_sclp) {
-        default_sclp = 0;
-    }
     if (!has_defaults || machine_class->no_floppy) {
         default_floppy = 0;
     }
@@ -4303,16 +4264,11 @@ int main(int argc, char **argv, char **envp)
             add_device_config(DEV_SERIAL, "mon:stdio");
         } else if (default_virtcon && default_monitor) {
             add_device_config(DEV_VIRTCON, "mon:stdio");
-        } else if (default_sclp && default_monitor) {
-            add_device_config(DEV_SCLP, "mon:stdio");
         } else {
             if (default_serial)
                 add_device_config(DEV_SERIAL, "stdio");
             if (default_virtcon)
                 add_device_config(DEV_VIRTCON, "stdio");
-            if (default_sclp) {
-                add_device_config(DEV_SCLP, "stdio");
-            }
             if (default_monitor)
                 monitor_parse("stdio", "readline", false);
         }
@@ -4325,9 +4281,6 @@ int main(int argc, char **argv, char **envp)
             monitor_parse("vc:80Cx24C", "readline", false);
         if (default_virtcon)
             add_device_config(DEV_VIRTCON, "vc:80Cx24C");
-        if (default_sclp) {
-            add_device_config(DEV_SCLP, "vc:80Cx24C");
-        }
     }
 
 #if defined(CONFIG_VNC)
@@ -4577,9 +4530,6 @@ int main(int argc, char **argv, char **envp)
         exit(1);
     if (foreach_device_config(DEV_VIRTCON, virtcon_parse) < 0)
         exit(1);
-    if (foreach_device_config(DEV_SCLP, sclp_parse) < 0) {
-        exit(1);
-    }
     if (foreach_device_config(DEV_DEBUGCON, debugcon_parse) < 0)
         exit(1);
 
-- 
2.14.3
