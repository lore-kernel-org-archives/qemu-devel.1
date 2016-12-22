Received: from eggs.gnu.org ([2001:4830:134:3::10]:44985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5mE-0007KS-CB
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:59:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5mD-0003cI-Fj
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:59:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cK5mD-0003bs-6e
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:59:29 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4994DC0ADB4D
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 15:59:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Dec 2016 16:59:14 +0100
Message-Id: <20161222155915.7232-11-pbonzini@redhat.com>
In-Reply-To: <20161222155915.7232-1-pbonzini@redhat.com>
References: <20161222155915.7232-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 10/11] build: remove
 --enable-colo/--disable-colo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com

No need to provide this knob, just enable COLO unconditionally.
Remove the configure option as well as stubs/migration-colo.c.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure               | 11 -----------
 migration/Makefile.objs |  3 +--
 stubs/Makefile.objs     |  1 -
 stubs/migration-colo.c  | 46 ----------------------------------------------
 4 files changed, 1 insertion(+), 60 deletions(-)
 delete mode 100644 stubs/migration-colo.c

diff --git a/configure b/configure
index 7dec6cd..f635cbe 100755
--- a/configure
+++ b/configure
@@ -228,7 +228,6 @@ vhost_net="no"
 vhost_scsi="no"
 vhost_vsock="no"
 kvm="no"
-colo="yes"
 rdma=""
 gprof="no"
 debug_tcg="no"
@@ -919,10 +918,6 @@ for opt do
   ;;
   --enable-kvm) kvm="yes"
   ;;
-  --disable-colo) colo="no"
-  ;;
-  --enable-colo) colo="yes"
-  ;;
   --disable-tcg-interpreter) tcg_interpreter="no"
   ;;
   --enable-tcg-interpreter) tcg_interpreter="yes"
diff --git a/configure b/configure
index f635cbe..dba3397 100755
--- a/configure
+++ b/configure
@@ -1366,7 +1366,6 @@ disabled with --disable-FEATURE, default is enabled if available:
   fdt             fdt device tree
   bluez           bluez stack connectivity
   kvm             KVM acceleration support
-  colo            COarse-grain LOck-stepping VM for Non-stop Service
   rdma            RDMA-based migration support
   vde             support for vde network
   netmap          support for netmap network
@@ -5043,7 +5042,6 @@ echo "Linux AIO support $linux_aio"
 echo "ATTR/XATTR support $attr"
 echo "Install blobs     $blobs"
 echo "KVM support       $kvm"
-echo "COLO support      $colo"
 echo "RDMA support      $rdma"
 echo "TCG interpreter   $tcg_interpreter"
 echo "fdt support       $fdt"
@@ -5684,10 +5679,6 @@ if have_backend "syslog"; then
 fi
 echo "CONFIG_TRACE_FILE=$trace_file" >> $config_host_mak
 
-if test "$colo" = "yes"; then
-  echo "CONFIG_COLO=y" >> $config_host_mak
-fi
-
 if test "$rdma" = "yes" ; then
   echo "CONFIG_RDMA=y" >> $config_host_mak
 fi
diff --git a/migration/Makefile.objs b/migration/Makefile.objs
index 3f3e237..480dd49 100644
--- a/migration/Makefile.objs
+++ b/migration/Makefile.objs
@@ -1,7 +1,6 @@
 common-obj-y += migration.o socket.o fd.o exec.o
 common-obj-y += tls.o
-common-obj-y += colo-comm.o
-common-obj-$(CONFIG_COLO) += colo.o colo-failover.o
+common-obj-y += colo-comm.o colo.o colo-failover.o
 common-obj-y += vmstate.o
 common-obj-y += qemu-file.o
 common-obj-y += qemu-file-channel.o
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index e863d9a..a7d3b72 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -36,4 +36,3 @@ stub-obj-y += qmp_pc_dimm_device_list.o
 stub-obj-y += target-monitor-defs.o
 stub-obj-y += target-get-monitor-def.o
 stub-obj-y += pc_madt_cpu_entry.o
-stub-obj-y += migration-colo.o
diff --git a/stubs/migration-colo.c b/stubs/migration-colo.c
deleted file mode 100644
index 7811764..0000000
--- a/stubs/migration-colo.c
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- * COarse-grain LOck-stepping Virtual Machines for Non-stop Service (COLO)
- * (a.k.a. Fault Tolerance or Continuous Replication)
- *
- * Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
- * Copyright (c) 2016 FUJITSU LIMITED
- * Copyright (c) 2016 Intel Corporation
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or
- * later.  See the COPYING file in the top-level directory.
- */
-
-#include "qemu/osdep.h"
-#include "migration/colo.h"
-#include "qmp-commands.h"
-
-bool colo_supported(void)
-{
-    return false;
-}
-
-bool migration_in_colo_state(void)
-{
-    return false;
-}
-
-bool migration_incoming_in_colo_state(void)
-{
-    return false;
-}
-
-void migrate_start_colo_process(MigrationState *s)
-{
-}
-
-void *colo_process_incoming_thread(void *opaque)
-{
-    return NULL;
-}
-
-void qmp_x_colo_lost_heartbeat(Error **errp)
-{
-    error_setg(errp, "COLO is not supported, please rerun configure"
-                     " with --enable-colo option in order to support"
-                     " COLO feature");
-}
-- 
2.9.3
