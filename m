Received: from eggs.gnu.org ([2001:4830:134:3::10]:46907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dbDc1-0006BF-KA
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 18:20:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dbDbw-0006mi-WD
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 18:20:01 -0400
Received: from mail-sn1nam02on0060.outbound.protection.outlook.com
	([104.47.36.60]:30777
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dbDbw-0006lh-M0
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 18:19:56 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 28 Jul 2017 15:16:32 -0700
Message-ID: <3f6b2d73ff7b718c41e190aab01a32aa1a75a6b2.1501280035.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1501280035.git.alistair.francis@xilinx.com>
References: <cover.1501280035.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 2/5] Convert remaining error_report() to
 warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@redhat.com>

In a previous patch (3dc6f8693694a649a9c83f1e2746565b47683923) we
converted uses of error_report("warning:"... to use warn_report()
instead. This was to help standardise on a single method of printing
warnings to the user.

There appears to have been some cases that slipped through in patch sets
applied around the same time, this patch catches the few remaining
cases.

All of the warnings were changed using this command:
  find ./* -type f -exec sed -i \
    's|error_report(".*warning[,:] |warn_report("|Ig' {} +

Indentation fixed up manually afterwards.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Graf <agraf@suse.de>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
---

 block/qcow2.c      | 10 +++++-----
 target/s390x/kvm.c |  4 ++--
 trace/control.c    |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index d7c600b5a2..039e4dac7a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -302,11 +302,11 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
             }
 
             if (!(s->autoclear_features & QCOW2_AUTOCLEAR_BITMAPS)) {
-                error_report("WARNING: a program lacking bitmap support "
-                             "modified this file, so all bitmaps are now "
-                             "considered inconsistent. Some clusters may be "
-                             "leaked, run 'qemu-img check -r' on the image "
-                             "file to fix.");
+                warn_report("a program lacking bitmap support "
+                            "modified this file, so all bitmaps are now "
+                            "considered inconsistent. Some clusters may be "
+                            "leaked, run 'qemu-img check -r' on the image "
+                            "file to fix.");
                 if (need_update_header != NULL) {
                     /* Updating is needed to drop invalid bitmap extension. */
                     *need_update_header = true;
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index c4c5791d27..1084923adb 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -222,8 +222,8 @@ static void kvm_s390_enable_cmma(void)
     };
 
     if (mem_path) {
-        error_report("Warning: CMM will not be enabled because it is not "
-                     "compatible to hugetlbfs.");
+        warn_report("CMM will not be enabled because it is not "
+                    "compatible to hugetlbfs.");
         return;
     }
     rc = kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
diff --git a/trace/control.c b/trace/control.c
index 82d8989c4d..2769934bec 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -72,8 +72,8 @@ void trace_event_register_group(TraceEvent **events)
         if (likely(next_vcpu_id < CPU_TRACE_DSTATE_MAX_EVENTS)) {
             events[i]->vcpu_id = next_vcpu_id++;
         } else {
-            error_report("WARNING: too many vcpu trace events; dropping '%s'",
-                         events[i]->name);
+            warn_report("too many vcpu trace events; dropping '%s'",
+                        events[i]->name);
         }
     }
     event_groups = g_renew(TraceEventGroup, event_groups, nevent_groups + 1);
-- 
2.11.0
