Received: from eggs.gnu.org ([2001:4830:134:3::10]:47661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7883262b0=anthony.perard@citrix.com>)
	id 1g0m7S-00014v-28
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 07:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7883262b0=anthony.perard@citrix.com>)
	id 1g0m7P-0001wQ-Cc
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 07:18:37 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:40306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=7883262b0=anthony.perard@citrix.com>)
	id 1g0m7P-0001sf-0N
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 07:18:35 -0400
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Fri, 14 Sep 2018 12:18:29 +0100
Message-ID: <20180914111830.28466-2-anthony.perard@citrix.com>
In-Reply-To: <20180914111830.28466-1-anthony.perard@citrix.com>
References: <20180914111830.28466-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/2] Remove broken Xen PV domain builder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anthony Perard <anthony.perard@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org

It is broken since Xen 4.9 [1] and it will not build in Xen 4.12. Also,
it is not built by default since QEMU 2.6.

[1] https://lists.xenproject.org/archives/html/xen-devel/2018-09/msg00313.html

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 configure                   |  17 --
 hw/xenpv/Makefile.objs      |   2 -
 hw/xenpv/xen_domainbuild.c  | 299 ------------------------------------
 hw/xenpv/xen_domainbuild.h  |  13 --
 hw/xenpv/xen_machine_pv.c   |  14 --
 include/hw/xen/xen.h        |   1 -
 include/hw/xen/xen_common.h |  18 ---
 qemu-options.hx             |   8 -
 vl.c                        |   7 -
 9 files changed, 379 deletions(-)
 delete mode 100644 hw/xenpv/xen_domainbuild.c
 delete mode 100644 hw/xenpv/xen_domainbuild.h

diff --git a/configure b/configure
index 58862d2ae8..c844b72e36 100755
--- a/configure
+++ b/configure
@@ -356,7 +356,6 @@ vnc_png=""
 xkbcommon=""
 xen=""
 xen_ctrl_version=""
-xen_pv_domain_build="no"
 xen_pci_passthrough=""
 linux_aio=""
 cap_ng=""
@@ -1107,10 +1106,6 @@ for opt do
   ;;
   --enable-xen-pci-passthrough) xen_pci_passthrough="yes"
   ;;
-  --disable-xen-pv-domain-build) xen_pv_domain_build="no"
-  ;;
-  --enable-xen-pv-domain-build) xen_pv_domain_build="yes"
-  ;;
   --disable-brlapi) brlapi="no"
   ;;
   --enable-brlapi) brlapi="yes"
@@ -1631,8 +1626,6 @@ Advanced options (experts only):
   --tls-priority           default TLS protocol/cipher priority string
   --enable-gprof           QEMU profiling with gprof
   --enable-profiler        profiler support
-  --enable-xen-pv-domain-build
-                           xen pv domain builder
   --enable-debug-stack-usage
                            track the maximum stack usage of stacks created by qemu_alloc_stack
 
@@ -2601,12 +2594,6 @@ if test "$xen_pci_passthrough" != "no"; then
   fi
 fi
 
-if test "$xen_pv_domain_build" = "yes" &&
-   test "$xen" != "yes"; then
-    error_exit "User requested Xen PV domain builder support" \
-	       "which requires Xen support."
-fi
-
 ##########################################
 # Windows Hypervisor Platform accelerator (WHPX) check
 if test "$whpx" != "no" ; then
@@ -6018,7 +6005,6 @@ fi
 echo "xen support       $xen"
 if test "$xen" = "yes" ; then
   echo "xen ctrl version  $xen_ctrl_version"
-  echo "pv dom build      $xen_pv_domain_build"
 fi
 echo "brlapi support    $brlapi"
 echo "bluez  support    $bluez"
@@ -6490,9 +6476,6 @@ fi
 if test "$xen" = "yes" ; then
   echo "CONFIG_XEN_BACKEND=y" >> $config_host_mak
   echo "CONFIG_XEN_CTRL_INTERFACE_VERSION=$xen_ctrl_version" >> $config_host_mak
-  if test "$xen_pv_domain_build" = "yes" ; then
-    echo "CONFIG_XEN_PV_DOMAIN_BUILD=y" >> $config_host_mak
-  fi
 fi
 if test "$linux_aio" = "yes" ; then
   echo "CONFIG_LINUX_AIO=y" >> $config_host_mak
diff --git a/hw/xenpv/Makefile.objs b/hw/xenpv/Makefile.objs
index bbf5873fd1..8bfa4586ab 100644
--- a/hw/xenpv/Makefile.objs
+++ b/hw/xenpv/Makefile.objs
@@ -1,4 +1,2 @@
 # Xen PV machine support
 obj-$(CONFIG_XEN) += xen_machine_pv.o
-# Xen PV machine builder support
-obj-$(CONFIG_XEN_PV_DOMAIN_BUILD) += xen_domainbuild.o
diff --git a/hw/xenpv/xen_domainbuild.c b/hw/xenpv/xen_domainbuild.c
deleted file mode 100644
index 188acaca16..0000000000
--- a/hw/xenpv/xen_domainbuild.c
+++ /dev/null
@@ -1,299 +0,0 @@
-#include "qemu/osdep.h"
-#include "qemu/units.h"
-#include "hw/xen/xen_backend.h"
-#include "xen_domainbuild.h"
-#include "qemu/timer.h"
-#include "qemu/log.h"
-
-#include <xenguest.h>
-
-static int xenstore_domain_mkdir(char *path)
-{
-    struct xs_permissions perms_ro[] = {{
-            .id    = 0, /* set owner: dom0 */
-        },{
-            .id    = xen_domid,
-            .perms = XS_PERM_READ,
-        }};
-    struct xs_permissions perms_rw[] = {{
-            .id    = 0, /* set owner: dom0 */
-        },{
-            .id    = xen_domid,
-            .perms = XS_PERM_READ | XS_PERM_WRITE,
-        }};
-    const char *writable[] = { "device", "control", "error", NULL };
-    char subpath[256];
-    int i;
-
-    if (!xs_mkdir(xenstore, 0, path)) {
-        fprintf(stderr, "%s: xs_mkdir %s: failed\n", __func__, path);
-	return -1;
-    }
-    if (!xs_set_permissions(xenstore, 0, path, perms_ro, 2)) {
-        fprintf(stderr, "%s: xs_set_permissions failed\n", __func__);
-	return -1;
-    }
-
-    for (i = 0; writable[i]; i++) {
-        snprintf(subpath, sizeof(subpath), "%s/%s", path, writable[i]);
-        if (!xs_mkdir(xenstore, 0, subpath)) {
-            fprintf(stderr, "%s: xs_mkdir %s: failed\n", __func__, subpath);
-            return -1;
-        }
-        if (!xs_set_permissions(xenstore, 0, subpath, perms_rw, 2)) {
-            fprintf(stderr, "%s: xs_set_permissions failed\n", __func__);
-            return -1;
-        }
-    }
-    return 0;
-}
-
-int xenstore_domain_init1(const char *kernel, const char *ramdisk,
-                          const char *cmdline)
-{
-    char *dom, uuid_string[42], vm[256], path[256];
-    int i;
-
-    qemu_uuid_unparse(&qemu_uuid, uuid_string);
-    dom = xs_get_domain_path(xenstore, xen_domid);
-    snprintf(vm,  sizeof(vm),  "/vm/%s", uuid_string);
-
-    xenstore_domain_mkdir(dom);
-
-    xenstore_write_str(vm, "image/ostype",  "linux");
-    if (kernel)
-        xenstore_write_str(vm, "image/kernel",  kernel);
-    if (ramdisk)
-        xenstore_write_str(vm, "image/ramdisk", ramdisk);
-    if (cmdline)
-        xenstore_write_str(vm, "image/cmdline", cmdline);
-
-    /* name + id */
-    xenstore_write_str(vm,  "name",   qemu_name ? qemu_name : "no-name");
-    xenstore_write_str(vm,  "uuid",   uuid_string);
-    xenstore_write_str(dom, "name",   qemu_name ? qemu_name : "no-name");
-    xenstore_write_int(dom, "domid",  xen_domid);
-    xenstore_write_str(dom, "vm",     vm);
-
-    /* memory */
-    xenstore_write_int(dom, "memory/target", ram_size / KiB);
-    xenstore_write_int(vm, "memory",         ram_size / MiB);
-    xenstore_write_int(vm, "maxmem",         ram_size / MiB);
-
-    /* cpus */
-    for (i = 0; i < smp_cpus; i++) {
-	snprintf(path, sizeof(path), "cpu/%d/availability",i);
-	xenstore_write_str(dom, path, "online");
-    }
-    xenstore_write_int(vm, "vcpu_avail",  smp_cpus);
-    xenstore_write_int(vm, "vcpus",       smp_cpus);
-
-    /* vnc password */
-    xenstore_write_str(vm, "vncpassword", "" /* FIXME */);
-
-    free(dom);
-    return 0;
-}
-
-int xenstore_domain_init2(int xenstore_port, int xenstore_mfn,
-                          int console_port, int console_mfn)
-{
-    char *dom;
-
-    dom = xs_get_domain_path(xenstore, xen_domid);
-
-    /* signal new domain */
-    xs_introduce_domain(xenstore,
-                        xen_domid,
-                        xenstore_mfn,
-                        xenstore_port);
-
-    /* xenstore */
-    xenstore_write_int(dom, "store/ring-ref",   xenstore_mfn);
-    xenstore_write_int(dom, "store/port",       xenstore_port);
-
-    /* console */
-    xenstore_write_str(dom, "console/type",     "ioemu");
-    xenstore_write_int(dom, "console/limit",    128 * KiB);
-    xenstore_write_int(dom, "console/ring-ref", console_mfn);
-    xenstore_write_int(dom, "console/port",     console_port);
-    xen_config_dev_console(0);
-
-    free(dom);
-    return 0;
-}
-
-/* ------------------------------------------------------------- */
-
-static QEMUTimer *xen_poll;
-
-/* check domain state once per second */
-static void xen_domain_poll(void *opaque)
-{
-    struct xc_dominfo info;
-    int rc;
-
-    rc = xc_domain_getinfo(xen_xc, xen_domid, 1, &info);
-    if ((rc != 1) || (info.domid != xen_domid)) {
-        qemu_log("xen: domain %d is gone\n", xen_domid);
-        goto quit;
-    }
-    if (info.dying) {
-        qemu_log("xen: domain %d is dying (%s%s)\n", xen_domid,
-                 info.crashed  ? "crashed"  : "",
-                 info.shutdown ? "shutdown" : "");
-        goto quit;
-    }
-
-    timer_mod(xen_poll, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + 1000);
-    return;
-
-quit:
-    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
-}
-
-static int xen_domain_watcher(void)
-{
-    int qemu_running = 1;
-    int fd[2], i, n, rc;
-    char byte;
-
-    if (pipe(fd) != 0) {
-        qemu_log("%s: Huh? pipe error: %s\n", __func__, strerror(errno));
-        return -1;
-    }
-    if (fork() != 0)
-        return 0; /* not child */
-
-    /* close all file handles, except stdio/out/err,
-     * our watch pipe and the xen interface handle */
-    n = getdtablesize();
-    for (i = 3; i < n; i++) {
-        if (i == fd[0])
-            continue;
-        close(i);
-    }
-
-    /*
-     * Reopen xc interface, since the original is unsafe after fork
-     * and was closed above.
-     */
-    xen_xc = xc_interface_open(0, 0, 0);
-
-    /* ignore term signals */
-    signal(SIGINT,  SIG_IGN);
-    signal(SIGTERM, SIG_IGN);
-
-    /* wait for qemu exiting */
-    while (qemu_running) {
-        rc = read(fd[0], &byte, 1);
-        switch (rc) {
-        case -1:
-            if (errno == EINTR)
-                continue;
-            qemu_log("%s: Huh? read error: %s\n", __func__, strerror(errno));
-            qemu_running = 0;
-            break;
-        case 0:
-            /* EOF -> qemu exited */
-            qemu_running = 0;
-            break;
-        default:
-            qemu_log("%s: Huh? data on the watch pipe?\n", __func__);
-            break;
-        }
-    }
-
-    /* cleanup */
-    qemu_log("%s: destroy domain %d\n", __func__, xen_domid);
-    xc_domain_destroy(xen_xc, xen_domid);
-    _exit(0);
-}
-
-/* normal cleanup */
-static void xen_domain_cleanup(void)
-{
-    char *dom;
-
-    dom = xs_get_domain_path(xenstore, xen_domid);
-    if (dom) {
-        xs_rm(xenstore, 0, dom);
-        free(dom);
-    }
-    xs_release_domain(xenstore, xen_domid);
-}
-
-int xen_domain_build_pv(const char *kernel, const char *ramdisk,
-                        const char *cmdline)
-{
-    uint32_t ssidref = 0;
-    uint32_t flags = 0;
-    xen_domain_handle_t uuid;
-    unsigned int xenstore_port = 0, console_port = 0;
-    unsigned long xenstore_mfn = 0, console_mfn = 0;
-    int rc;
-
-    memcpy(uuid, &qemu_uuid, sizeof(uuid));
-    rc = xen_domain_create(xen_xc, ssidref, uuid, flags, &xen_domid);
-    if (rc < 0) {
-        fprintf(stderr, "xen: xc_domain_create() failed\n");
-        goto err;
-    }
-    qemu_log("xen: created domain %d\n", xen_domid);
-    atexit(xen_domain_cleanup);
-    if (xen_domain_watcher() == -1) {
-        goto err;
-    }
-
-    xenstore_domain_init1(kernel, ramdisk, cmdline);
-
-    rc = xc_domain_max_vcpus(xen_xc, xen_domid, smp_cpus);
-    if (rc < 0) {
-        fprintf(stderr, "xen: xc_domain_max_vcpus() failed\n");
-        goto err;
-    }
-
-#if 0
-    rc = xc_domain_setcpuweight(xen_xc, xen_domid, 256);
-    if (rc < 0) {
-        fprintf(stderr, "xen: xc_domain_setcpuweight() failed\n");
-        goto err;
-    }
-#endif
-
-    rc = xc_domain_setmaxmem(xen_xc, xen_domid, ram_size / KiB);
-    if (rc < 0) {
-        fprintf(stderr, "xen: xc_domain_setmaxmem() failed\n");
-        goto err;
-    }
-
-    xenstore_port = xc_evtchn_alloc_unbound(xen_xc, xen_domid, 0);
-    console_port = xc_evtchn_alloc_unbound(xen_xc, xen_domid, 0);
-
-    rc = xc_linux_build(xen_xc, xen_domid, ram_size / MiB,
-                        kernel, ramdisk, cmdline,
-                        0, flags,
-                        xenstore_port, &xenstore_mfn,
-                        console_port, &console_mfn);
-    if (rc < 0) {
-        fprintf(stderr, "xen: xc_linux_build() failed\n");
-        goto err;
-    }
-
-    xenstore_domain_init2(xenstore_port, xenstore_mfn,
-                          console_port, console_mfn);
-
-    qemu_log("xen: unpausing domain %d\n", xen_domid);
-    rc = xc_domain_unpause(xen_xc, xen_domid);
-    if (rc < 0) {
-        fprintf(stderr, "xen: xc_domain_unpause() failed\n");
-        goto err;
-    }
-
-    xen_poll = timer_new_ms(QEMU_CLOCK_REALTIME, xen_domain_poll, NULL);
-    timer_mod(xen_poll, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + 1000);
-    return 0;
-
-err:
-    return -1;
-}
diff --git a/hw/xenpv/xen_domainbuild.h b/hw/xenpv/xen_domainbuild.h
deleted file mode 100644
index 652d9b410f..0000000000
--- a/hw/xenpv/xen_domainbuild.h
+++ /dev/null
@@ -1,13 +0,0 @@
-#ifndef QEMU_HW_XEN_DOMAINBUILD_H
-#define QEMU_HW_XEN_DOMAINBUILD_H
-
-#include "hw/xen/xen_common.h"
-
-int xenstore_domain_init1(const char *kernel, const char *ramdisk,
-                          const char *cmdline);
-int xenstore_domain_init2(int xenstore_port, int xenstore_mfn,
-                          int console_port, int console_mfn);
-int xen_domain_build_pv(const char *kernel, const char *ramdisk,
-                        const char *cmdline);
-
-#endif /* QEMU_HW_XEN_DOMAINBUILD_H */
diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
index 44d67b87c4..4d03aa59cb 100644
--- a/hw/xenpv/xen_machine_pv.c
+++ b/hw/xenpv/xen_machine_pv.c
@@ -27,7 +27,6 @@
 #include "hw/hw.h"
 #include "hw/boards.h"
 #include "hw/xen/xen_backend.h"
-#include "xen_domainbuild.h"
 #include "sysemu/block-backend.h"
 
 static void xen_init_pv(MachineState *machine)
@@ -45,19 +44,6 @@ static void xen_init_pv(MachineState *machine)
     case XEN_ATTACH:
         /* nothing to do, xend handles everything */
         break;
-#ifdef CONFIG_XEN_PV_DOMAIN_BUILD
-    case XEN_CREATE: {
-        const char *kernel_filename = machine->kernel_filename;
-        const char *kernel_cmdline = machine->kernel_cmdline;
-        const char *initrd_filename = machine->initrd_filename;
-        if (xen_domain_build_pv(kernel_filename, initrd_filename,
-                                kernel_cmdline) < 0) {
-            error_report("xen pv domain creation failed");
-            exit(1);
-        }
-        break;
-    }
-#endif
     case XEN_EMULATE:
         error_report("xen emulation not implemented (yet)");
         exit(1);
diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index 7efcdaa8fe..978aaa31fb 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -15,7 +15,6 @@
 /* xen-machine.c */
 enum xen_mode {
     XEN_EMULATE = 0,  // xen emulation, using xenner (default)
-    XEN_CREATE,       // create xen domain
     XEN_ATTACH        // attach to xen domain created by xend
 };
 
diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
index 93f631e5bf..2b91d199a1 100644
--- a/include/hw/xen/xen_common.h
+++ b/include/hw/xen/xen_common.h
@@ -661,24 +661,6 @@ static inline int xen_set_ioreq_server_state(domid_t dom,
 
 #endif
 
-#ifdef CONFIG_XEN_PV_DOMAIN_BUILD
-#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40700
-static inline int xen_domain_create(xc_interface *xc, uint32_t ssidref,
-                                    xen_domain_handle_t handle, uint32_t flags,
-                                    uint32_t *pdomid)
-{
-    return xc_domain_create(xc, ssidref, handle, flags, pdomid);
-}
-#else
-static inline int xen_domain_create(xc_interface *xc, uint32_t ssidref,
-                                    xen_domain_handle_t handle, uint32_t flags,
-                                    uint32_t *pdomid)
-{
-    return xc_domain_create(xc, ssidref, handle, flags, pdomid, NULL);
-}
-#endif
-#endif
-
 /* Xen before 4.8 */
 
 #if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40800
diff --git a/qemu-options.hx b/qemu-options.hx
index 654ef484d9..d14a50805a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3398,10 +3398,6 @@ ETEXI
 
 DEF("xen-domid", HAS_ARG, QEMU_OPTION_xen_domid,
     "-xen-domid id   specify xen guest domain id\n", QEMU_ARCH_ALL)
-DEF("xen-create", 0, QEMU_OPTION_xen_create,
-    "-xen-create     create domain using xen hypercalls, bypassing xend\n"
-    "                warning: should not be used when xend is in use\n",
-    QEMU_ARCH_ALL)
 DEF("xen-attach", 0, QEMU_OPTION_xen_attach,
     "-xen-attach     attach to existing xen domain\n"
     "                xend will use this when starting QEMU\n",
@@ -3415,10 +3411,6 @@ STEXI
 @item -xen-domid @var{id}
 @findex -xen-domid
 Specify xen guest domain @var{id} (XEN only).
-@item -xen-create
-@findex -xen-create
-Create domain using xen hypercalls, bypassing xend.
-Warning: should not be used when xend is in use (XEN only).
 @item -xen-attach
 @findex -xen-attach
 Attach to existing xen domain.
diff --git a/vl.c b/vl.c
index 5ba06adf78..acd34f7f94 100644
--- a/vl.c
+++ b/vl.c
@@ -3814,13 +3814,6 @@ int main(int argc, char **argv, char **envp)
                 }
                 xen_domid = atoi(optarg);
                 break;
-            case QEMU_OPTION_xen_create:
-                if (!(xen_available())) {
-                    error_report("Option not supported for this target");
-                    exit(1);
-                }
-                xen_mode = XEN_CREATE;
-                break;
             case QEMU_OPTION_xen_attach:
                 if (!(xen_available())) {
                     error_report("Option not supported for this target");
-- 
Anthony PERARD
