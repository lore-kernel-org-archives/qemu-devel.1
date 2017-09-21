Received: from eggs.gnu.org ([2001:4830:134:3::10]:37504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAib-0004zc-D7
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiY-0004XW-Qj
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:17 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:49802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dvAiY-0004W4-HX
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:14 -0400
Received: by mail-wm0-x22e.google.com with SMTP id r74so5712145wme.4
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 16:17:14 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-246-117.clienti.tiscali.it.
	[78.12.246.117]) by smtp.gmail.com with ESMTPSA id
	u186sm2596278wmd.19.2017.09.21.16.17.11 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 21 Sep 2017 16:17:12 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Sep 2017 01:16:33 +0200
Message-Id: <1506035800-30509-26-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
References: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 25/32] scsi,
 file-posix: add support for persistent reservation management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

It is a common requirement for virtual machine to send persistent
reservations, but this currently requires either running QEMU with
CAP_SYS_RAWIO, or using out-of-tree patches that let an unprivileged
QEMU bypass Linux's filter on SG_IO commands.

As an alternative mechanism, the next patches will introduce a
privileged helper to run persistent reservation commands without
expanding QEMU's attack surface unnecessarily.

The helper is invoked through a "pr-manager" QOM object, to which
file-posix.c passes SG_IO requests for PERSISTENT RESERVE OUT and
PERSISTENT RESERVE IN commands.  For example:

  $ qemu-system-x86_64
      -device virtio-scsi \
      -object pr-manager-helper,id=helper0,path=/var/run/qemu-pr-helper.sock
      -drive if=none,id=hd,driver=raw,file.filename=/dev/sdb,file.pr-manager=helper0
      -device scsi-block,drive=hd

or:

  $ qemu-system-x86_64
      -device virtio-scsi \
      -object pr-manager-helper,id=helper0,path=/var/run/qemu-pr-helper.sock
      -blockdev node-name=hd,driver=raw,file.driver=host_device,file.filename=/dev/sdb,file.pr-manager=helper0
      -device scsi-block,drive=hd

Multiple pr-manager implementations are conceivable and possible, though
only one is implemented right now.  For example, a pr-manager could:

- talk directly to the multipath daemon from a privileged QEMU
  (i.e. QEMU links to libmpathpersist); this makes reservation work
  properly with multipath, but still requires CAP_SYS_RAWIO

- use the Linux IOC_PR_* ioctls (they require CAP_SYS_ADMIN though)

- more interestingly, implement reservations directly in QEMU
  through file system locks or a shared database (e.g. sqlite)

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs             |   1 +
 block/file-posix.c        |  30 +++++++++++++
 docs/pr-manager.rst       |  51 ++++++++++++++++++++++
 include/scsi/pr-manager.h |  56 ++++++++++++++++++++++++
 qapi/block-core.json      |   4 ++
 scsi/Makefile.objs        |   2 +
 scsi/pr-manager.c         | 109 ++++++++++++++++++++++++++++++++++++++++++++++
 scsi/trace-events         |   3 ++
 vl.c                      |   3 +-
 9 files changed, 258 insertions(+), 1 deletion(-)
 create mode 100644 docs/pr-manager.rst
 create mode 100644 include/scsi/pr-manager.h
 create mode 100644 scsi/pr-manager.c
 create mode 100644 scsi/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index 9e89100..bdfa3b6 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -171,6 +171,7 @@ trace-events-subdirs += qapi
 trace-events-subdirs += accel/tcg
 trace-events-subdirs += accel/kvm
 trace-events-subdirs += nbd
+trace-events-subdirs += scsi
 
 trace-events-files = $(SRC_PATH)/trace-events $(trace-events-subdirs:%=$(SRC_PATH)/%/trace-events)
 
diff --git a/block/file-posix.c b/block/file-posix.c
index 6acbd56..ab12a2b 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -33,6 +33,9 @@
 #include "block/raw-aio.h"
 #include "qapi/qmp/qstring.h"
 
+#include "scsi/pr-manager.h"
+#include "scsi/constants.h"
+
 #if defined(__APPLE__) && (__MACH__)
 #include <paths.h>
 #include <sys/param.h>
@@ -155,6 +158,8 @@ typedef struct BDRVRawState {
     bool page_cache_inconsistent:1;
     bool has_fallocate;
     bool needs_alignment;
+
+    PRManager *pr_mgr;
 } BDRVRawState;
 
 typedef struct BDRVRawReopenState {
@@ -402,6 +407,11 @@ static QemuOptsList raw_runtime_opts = {
             .type = QEMU_OPT_STRING,
             .help = "file locking mode (on/off/auto, default: auto)",
         },
+        {
+            .name = "pr-manager",
+            .type = QEMU_OPT_STRING,
+            .help = "id of persistent reservation manager object (default: none)",
+        },
         { /* end of list */ }
     },
 };
@@ -413,6 +423,7 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     QemuOpts *opts;
     Error *local_err = NULL;
     const char *filename = NULL;
+    const char *str;
     BlockdevAioOptions aio, aio_default;
     int fd, ret;
     struct stat st;
@@ -476,6 +487,16 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
         abort();
     }
 
+    str = qemu_opt_get(opts, "pr-manager");
+    if (str) {
+        s->pr_mgr = pr_manager_lookup(str, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            ret = -EINVAL;
+            goto fail;
+        }
+    }
+
     s->open_flags = open_flags;
     raw_parse_flags(bdrv_flags, &s->open_flags);
 
@@ -2597,6 +2618,15 @@ static BlockAIOCB *hdev_aio_ioctl(BlockDriverState *bs,
     if (fd_open(bs) < 0)
         return NULL;
 
+    if (req == SG_IO && s->pr_mgr) {
+        struct sg_io_hdr *io_hdr = buf;
+        if (io_hdr->cmdp[0] == PERSISTENT_RESERVE_OUT ||
+            io_hdr->cmdp[0] == PERSISTENT_RESERVE_IN) {
+            return pr_manager_execute(s->pr_mgr, bdrv_get_aio_context(bs),
+                                      s->fd, io_hdr, cb, opaque);
+        }
+    }
+
     acb = g_new(RawPosixAIOData, 1);
     acb->bs = bs;
     acb->aio_type = QEMU_AIO_IOCTL;
diff --git a/docs/pr-manager.rst b/docs/pr-manager.rst
new file mode 100644
index 0000000..b6089fb
--- /dev/null
+++ b/docs/pr-manager.rst
@@ -0,0 +1,51 @@
+======================================
+Persistent reservation managers
+======================================
+
+SCSI persistent Reservations allow restricting access to block devices
+to specific initiators in a shared storage setup.  When implementing
+clustering of virtual machines, it is a common requirement for virtual
+machines to send persistent reservation SCSI commands.  However,
+the operating system restricts sending these commands to unprivileged
+programs because incorrect usage can disrupt regular operation of the
+storage fabric.
+
+For this reason, QEMU's SCSI passthrough devices, ``scsi-block``
+and ``scsi-generic`` (both are only available on Linux) can delegate
+implementation of persistent reservations to a separate object,
+the "persistent reservation manager".  Only PERSISTENT RESERVE OUT and
+PERSISTENT RESERVE IN commands are passed to the persistent reservation
+manager object; other commands are processed by QEMU as usual.
+
+-----------------------------------------
+Defining a persistent reservation manager
+-----------------------------------------
+
+A persistent reservation manager is an instance of a subclass of the
+"pr-manager" QOM class.
+
+Right now only one subclass is defined, ``pr-manager-helper``, which
+forwards the commands to an external privileged helper program
+over Unix sockets.  The helper program only allows sending persistent
+reservation commands to devices for which QEMU has a file descriptor,
+so that QEMU will not be able to effect persistent reservations
+unless it has access to both the socket and the device.
+
+``pr-manager-helper`` has a single string property, ``path``, which
+accepts the path to the helper program's Unix socket.  For example,
+the following command line defines a ``pr-manager-helper`` object and
+attaches it to a SCSI passthrough device::
+
+      $ qemu-system-x86_64
+          -device virtio-scsi \
+          -object pr-manager-helper,id=helper0,path=/var/run/qemu-pr-helper.sock
+          -drive if=none,id=hd,driver=raw,file.filename=/dev/sdb,file.pr-manager=helper0
+          -device scsi-block,drive=hd
+
+Alternatively, using ``-blockdev``::
+
+      $ qemu-system-x86_64
+          -device virtio-scsi \
+          -object pr-manager-helper,id=helper0,path=/var/run/qemu-pr-helper.sock
+          -blockdev node-name=hd,driver=raw,file.driver=host_device,file.filename=/dev/sdb,file.pr-manager=helper0
+          -device scsi-block,drive=hd
diff --git a/include/scsi/pr-manager.h b/include/scsi/pr-manager.h
new file mode 100644
index 0000000..b2b37d6
--- /dev/null
+++ b/include/scsi/pr-manager.h
@@ -0,0 +1,56 @@
+#ifndef PR_MANAGER_H
+#define PR_MANAGER_H
+
+#include "qom/object.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/visitor.h"
+#include "qom/object_interfaces.h"
+#include "block/aio.h"
+
+#define TYPE_PR_MANAGER "pr-manager"
+
+#define PR_MANAGER_CLASS(klass) \
+     OBJECT_CLASS_CHECK(PRManagerClass, (klass), TYPE_PR_MANAGER)
+#define PR_MANAGER_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(PRManagerClass, (obj), TYPE_PR_MANAGER)
+#define PR_MANAGER(obj) \
+     OBJECT_CHECK(PRManager, (obj), TYPE_PR_MANAGER)
+
+struct sg_io_hdr;
+
+typedef struct PRManager {
+    /* <private> */
+    Object parent;
+} PRManager;
+
+/**
+ * PRManagerClass:
+ * @parent_class: the base class
+ * @run: callback invoked in thread pool context
+ */
+typedef struct PRManagerClass {
+    /* <private> */
+    ObjectClass parent_class;
+
+    /* <public> */
+    int (*run)(PRManager *pr_mgr, int fd, struct sg_io_hdr *hdr);
+} PRManagerClass;
+
+BlockAIOCB *pr_manager_execute(PRManager *pr_mgr,
+                               AioContext *ctx, int fd,
+                               struct sg_io_hdr *hdr,
+                               BlockCompletionFunc *complete,
+                               void *opaque);
+
+#ifdef CONFIG_LINUX
+PRManager *pr_manager_lookup(const char *id, Error **errp);
+#else
+static inline PRManager *pr_manager_lookup(const char *id, Error **errp)
+{
+    /* The classes do not exist at all!  */
+    error_setg(errp, "No persistent reservation manager with id '%s'", id);
+    return NULL;
+}
+#endif
+
+#endif
diff --git a/qapi/block-core.json b/qapi/block-core.json
index bb11815..c69a395 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2241,6 +2241,9 @@
 # Driver specific block device options for the file backend.
 #
 # @filename:    path to the image file
+# @pr-manager:  the id for the object that will handle persistent reservations
+#               for this device (default: none, forward the commands via SG_IO;
+#               since 2.11)
 # @aio:         AIO backend (default: threads) (since: 2.8)
 # @locking:     whether to enable file locking. If set to 'auto', only enable
 #               when Open File Descriptor (OFD) locking API is available
@@ -2250,6 +2253,7 @@
 ##
 { 'struct': 'BlockdevOptionsFile',
   'data': { 'filename': 'str',
+            '*pr-manager': 'str',
             '*locking': 'OnOffAuto',
             '*aio': 'BlockdevAioOptions' } }
 
diff --git a/scsi/Makefile.objs b/scsi/Makefile.objs
index 31b82a5..5496d2a 100644
--- a/scsi/Makefile.objs
+++ b/scsi/Makefile.objs
@@ -1 +1,3 @@
 block-obj-y += utils.o
+
+block-obj-$(CONFIG_LINUX) += pr-manager.o
diff --git a/scsi/pr-manager.c b/scsi/pr-manager.c
new file mode 100644
index 0000000..87c45db
--- /dev/null
+++ b/scsi/pr-manager.c
@@ -0,0 +1,109 @@
+/*
+ * Persistent reservation manager abstract class
+ *
+ * Copyright (c) 2017 Red Hat, Inc.
+ *
+ * Author: Paolo Bonzini <pbonzini@redhat.com>
+ *
+ * This code is licensed under the LGPL.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include <scsi/sg.h>
+
+#include "qapi/error.h"
+#include "block/aio.h"
+#include "block/thread-pool.h"
+#include "scsi/pr-manager.h"
+#include "trace.h"
+
+typedef struct PRManagerData {
+    PRManager *pr_mgr;
+    struct sg_io_hdr *hdr;
+    int fd;
+} PRManagerData;
+
+static int pr_manager_worker(void *opaque)
+{
+    PRManagerData *data = opaque;
+    PRManager *pr_mgr = data->pr_mgr;
+    PRManagerClass *pr_mgr_class =
+        PR_MANAGER_GET_CLASS(pr_mgr);
+    struct sg_io_hdr *hdr = data->hdr;
+    int fd = data->fd;
+    int r;
+
+    g_free(data);
+    trace_pr_manager_run(fd, hdr->cmdp[0], hdr->cmdp[1]);
+
+    /* The reference was taken in pr_manager_execute.  */
+    r = pr_mgr_class->run(pr_mgr, fd, hdr);
+    object_unref(OBJECT(pr_mgr));
+    return r;
+}
+
+
+BlockAIOCB *pr_manager_execute(PRManager *pr_mgr,
+                               AioContext *ctx, int fd,
+                               struct sg_io_hdr *hdr,
+                               BlockCompletionFunc *complete,
+                               void *opaque)
+{
+    PRManagerData *data = g_new(PRManagerData, 1);
+    ThreadPool *pool = aio_get_thread_pool(ctx);
+
+    trace_pr_manager_execute(fd, hdr->cmdp[0], hdr->cmdp[1], opaque);
+    data->pr_mgr = pr_mgr;
+    data->fd = fd;
+    data->hdr = hdr;
+
+    /* The matching object_unref is in pr_manager_worker.  */
+    object_ref(OBJECT(pr_mgr));
+    return thread_pool_submit_aio(pool, pr_manager_worker,
+                                  data, complete, opaque);
+}
+
+static const TypeInfo pr_manager_info = {
+    .parent = TYPE_OBJECT,
+    .name = TYPE_PR_MANAGER,
+    .class_size = sizeof(PRManagerClass),
+    .abstract = true,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
+PRManager *pr_manager_lookup(const char *id, Error **errp)
+{
+    Object *obj;
+    PRManager *pr_mgr;
+
+    obj = object_resolve_path_component(object_get_objects_root(), id);
+    if (!obj) {
+        error_setg(errp, "No persistent reservation manager with id '%s'", id);
+        return NULL;
+    }
+
+    pr_mgr = (PRManager *)
+        object_dynamic_cast(obj,
+                            TYPE_PR_MANAGER);
+    if (!pr_mgr) {
+        error_setg(errp,
+                   "Object with id '%s' is not a persistent reservation manager",
+                   id);
+        return NULL;
+    }
+
+    return pr_mgr;
+}
+
+static void
+pr_manager_register_types(void)
+{
+    type_register_static(&pr_manager_info);
+}
+
+
+type_init(pr_manager_register_types);
diff --git a/scsi/trace-events b/scsi/trace-events
new file mode 100644
index 0000000..45f5b6e
--- /dev/null
+++ b/scsi/trace-events
@@ -0,0 +1,3 @@
+# scsi/pr-manager.c
+pr_manager_execute(int fd, int cmd, int sa, void *opaque) "fd=%d cmd=0x%02x service action=0x%02x opaque=%p"
+pr_manager_run(int fd, int cmd, int sa) "fd=%d cmd=0x%02x service action=0x%02x"
diff --git a/vl.c b/vl.c
index 9bb5058..a121a65 100644
--- a/vl.c
+++ b/vl.c
@@ -2893,7 +2893,8 @@ static int machine_set_property(void *opaque,
  */
 static bool object_create_initial(const char *type)
 {
-    if (g_str_equal(type, "rng-egd")) {
+    if (g_str_equal(type, "rng-egd") ||
+        g_str_has_prefix(type, "pr-manager-")) {
         return false;
     }
 
-- 
1.8.3.1
