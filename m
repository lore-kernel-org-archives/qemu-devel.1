Received: from eggs.gnu.org ([209.51.188.92]:36450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5Ge-0002cx-C9
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5Gc-00047Y-26
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:20 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:38875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gr5Gb-000459-Jb
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:17 -0500
Received: by mail-wm1-x329.google.com with SMTP id m22so4769611wml.3
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:16:15 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  5 Feb 2019 19:14:54 +0100
Message-Id: <1549390526-24246-45-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 44/76] qemu-options: Remove deprecated
 "-virtioconsole" option
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

It's been deprecated since QEMU 3.0, and nobody complained so far, so
it is time to remove this option now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1544684731-18828-1-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/qdev-device-use.txt |  4 ----
 include/hw/boards.h      |  1 -
 qemu-deprecated.texi     |  5 ----
 qemu-options.hx          | 10 --------
 vl.c                     | 61 +-----------------------------------------------
 5 files changed, 1 insertion(+), 80 deletions(-)

diff --git a/docs/qdev-device-use.txt b/docs/qdev-device-use.txt
index 98229b3..cc53e97 100644
--- a/docs/qdev-device-use.txt
+++ b/docs/qdev-device-use.txt
@@ -190,10 +190,6 @@ The appropriate DEVNAME depends on the machine type.  For type "pc":
 
   -device usb-braille,chardev=braille -chardev braille,id=braille
 
-* -virtioconsole becomes
-  -device virtio-serial-pci,class=C,vectors=V,ioeventfd=IOEVENTFD,max_ports=N
-  -device virtconsole,is_console=NUM,nr=NR,name=NAME
-
 LEGACY-CHARDEV translates to -chardev HOST-OPTS... as follows:
 
 * null becomes -chardev null
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 02f1140..05f9f45 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -180,7 +180,6 @@ struct MachineClass {
     int default_cpus;
     unsigned int no_serial:1,
         no_parallel:1,
-        use_virtcon:1,
         no_floppy:1,
         no_cdrom:1,
         no_sdcard:1,
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index dcf85a9..87c4e55 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -43,11 +43,6 @@ The @code{--no-frame} argument works with SDL 1.2 only. The other user
 interfaces never implemented this in the first place. So this will be
 removed together with SDL 1.2 support.
 
-@subsection -virtioconsole (since 3.0.0)
-
-Option @option{-virtioconsole} has been replaced by
-@option{-device virtconsole}.
-
 @subsection -clock (since 3.0.0)
 
 The @code{-clock} option is ignored since QEMU version 1.7.0. There is no
diff --git a/qemu-options.hx b/qemu-options.hx
index 8f34dce..2769c0c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3616,16 +3616,6 @@ character to Control-t.
 @end table
 ETEXI
 
-DEF("virtioconsole", HAS_ARG, QEMU_OPTION_virtiocon, \
-    "-virtioconsole c\n" \
-    "                set virtio console\n", QEMU_ARCH_ALL)
-STEXI
-@item -virtioconsole @var{c}
-@findex -virtioconsole
-Set virtio console.
-This option is deprecated, please use @option{-device virtconsole} instead.
-ETEXI
-
 DEF("show-cursor", 0, QEMU_OPTION_show_cursor, \
     "-show-cursor    show cursor\n", QEMU_ARCH_ALL)
 STEXI
diff --git a/vl.c b/vl.c
index 804fbdb..41d6af2 100644
--- a/vl.c
+++ b/vl.c
@@ -164,7 +164,6 @@ int no_frame;
 static int num_serial_hds;
 static Chardev **serial_hds;
 Chardev *parallel_hds[MAX_PARALLEL_PORTS];
-Chardev *virtcon_hds[MAX_VIRTIO_CONSOLES];
 int win2k_install_hack = 0;
 int singlestep = 0;
 int smp_cpus;
@@ -215,7 +214,6 @@ bool xen_domid_restrict;
 static int has_defaults = 1;
 static int default_serial = 1;
 static int default_parallel = 1;
-static int default_virtcon = 1;
 static int default_monitor = 1;
 static int default_floppy = 1;
 static int default_cdrom = 1;
@@ -236,8 +234,6 @@ static struct {
     { .driver = "ide-drive",            .flag = &default_cdrom     },
     { .driver = "scsi-cd",              .flag = &default_cdrom     },
     { .driver = "scsi-hd",              .flag = &default_cdrom     },
-    { .driver = "virtio-serial-pci",    .flag = &default_virtcon   },
-    { .driver = "virtio-serial",        .flag = &default_virtcon   },
     { .driver = "VGA",                  .flag = &default_vga       },
     { .driver = "isa-vga",              .flag = &default_vga       },
     { .driver = "cirrus-vga",           .flag = &default_vga       },
@@ -2405,7 +2401,6 @@ struct device_config {
         DEV_BT,        /* -bt            */
         DEV_SERIAL,    /* -serial        */
         DEV_PARALLEL,  /* -parallel      */
-        DEV_VIRTCON,   /* -virtioconsole */
         DEV_DEBUGCON,  /* -debugcon */
         DEV_GDB,       /* -gdb, -s */
         DEV_SCLP,      /* s390 sclp */
@@ -2503,39 +2498,6 @@ static int parallel_parse(const char *devname)
     return 0;
 }
 
-static int virtcon_parse(const char *devname)
-{
-    QemuOptsList *device = qemu_find_opts("device");
-    static int index = 0;
-    char label[32];
-    QemuOpts *bus_opts, *dev_opts;
-
-    if (strcmp(devname, "none") == 0)
-        return 0;
-    if (index == MAX_VIRTIO_CONSOLES) {
-        error_report("too many virtio consoles");
-        exit(1);
-    }
-
-    bus_opts = qemu_opts_create(device, NULL, 0, &error_abort);
-    qemu_opt_set(bus_opts, "driver", "virtio-serial", &error_abort);
-
-    dev_opts = qemu_opts_create(device, NULL, 0, &error_abort);
-    qemu_opt_set(dev_opts, "driver", "virtconsole", &error_abort);
-
-    snprintf(label, sizeof(label), "virtcon%d", index);
-    virtcon_hds[index] = qemu_chr_new_mux_mon(label, devname);
-    if (!virtcon_hds[index]) {
-        error_report("could not connect virtio console"
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
@@ -3570,15 +3532,6 @@ int main(int argc, char **argv, char **envp)
                     exit(1);
                 }
                 break;
-            case QEMU_OPTION_virtiocon:
-                warn_report("This option is deprecated, "
-                            "use '-device virtconsole' instead");
-                add_device_config(DEV_VIRTCON, optarg);
-                default_virtcon = 0;
-                if (strncmp(optarg, "mon:", 4) == 0) {
-                    default_monitor = 0;
-                }
-                break;
             case QEMU_OPTION_parallel:
                 add_device_config(DEV_PARALLEL, optarg);
                 default_parallel = 0;
@@ -4183,9 +4136,6 @@ int main(int argc, char **argv, char **envp)
     if (!has_defaults || machine_class->no_parallel) {
         default_parallel = 0;
     }
-    if (!has_defaults || !machine_class->use_virtcon) {
-        default_virtcon = 0;
-    }
     if (!has_defaults || machine_class->no_floppy) {
         default_floppy = 0;
     }
@@ -4218,8 +4168,7 @@ int main(int argc, char **argv, char **envp)
          * usage, -nographic is just a no-op in this case.
          */
         if (nographic
-            && (default_parallel || default_serial
-                || default_monitor || default_virtcon)) {
+            && (default_parallel || default_serial || default_monitor)) {
             error_report("-nographic cannot be used with -daemonize");
             exit(1);
         }
@@ -4236,13 +4185,9 @@ int main(int argc, char **argv, char **envp)
             add_device_config(DEV_PARALLEL, "null");
         if (default_serial && default_monitor) {
             add_device_config(DEV_SERIAL, "mon:stdio");
-        } else if (default_virtcon && default_monitor) {
-            add_device_config(DEV_VIRTCON, "mon:stdio");
         } else {
             if (default_serial)
                 add_device_config(DEV_SERIAL, "stdio");
-            if (default_virtcon)
-                add_device_config(DEV_VIRTCON, "stdio");
             if (default_monitor)
                 monitor_parse("stdio", "readline", false);
         }
@@ -4253,8 +4198,6 @@ int main(int argc, char **argv, char **envp)
             add_device_config(DEV_PARALLEL, "vc:80Cx24C");
         if (default_monitor)
             monitor_parse("vc:80Cx24C", "readline", false);
-        if (default_virtcon)
-            add_device_config(DEV_VIRTCON, "vc:80Cx24C");
     }
 
 #if defined(CONFIG_VNC)
@@ -4485,8 +4428,6 @@ int main(int argc, char **argv, char **envp)
         exit(1);
     if (foreach_device_config(DEV_PARALLEL, parallel_parse) < 0)
         exit(1);
-    if (foreach_device_config(DEV_VIRTCON, virtcon_parse) < 0)
-        exit(1);
     if (foreach_device_config(DEV_DEBUGCON, debugcon_parse) < 0)
         exit(1);
 
-- 
1.8.3.1
