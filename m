Received: from eggs.gnu.org ([2001:4830:134:3::10]:60147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfa-0004Mr-TI
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfS-0005aw-HY
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:26 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHfS-0005aW-Ai
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:22 -0400
Received: by mail-wm0-x242.google.com with SMTP id m127so3757436wmm.0
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:30:22 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:29:23 +0200
Message-Id: <1505824179-21541-35-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 34/50] Convert remaining error_report() to
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
Cc: Alistair Francis <alistair.francis@xilinx.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@redhat.com>

From: Alistair Francis <alistair.francis@xilinx.com>

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

Two messages were manually fixed up as well.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Graf <agraf@suse.de>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <eec8cba0d5434bd828639e5e45f12182490ff47d.1505158760.git.alistair.francis@xilinx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/qcow2.c      | 9 +++++----
 target/s390x/kvm.c | 4 ++--
 trace/control.c    | 4 ++--
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index bae5893..d33fb3e 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -301,10 +301,11 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
             }
 
             if (!(s->autoclear_features & QCOW2_AUTOCLEAR_BITMAPS)) {
-                error_report("WARNING: a program lacking bitmap support "
-                             "modified this file, so all bitmaps are now "
-                             "considered inconsistent. Some clusters may be "
-                             "leaked, run 'qemu-img check -r' on the image "
+                warn_report("a program lacking bitmap support "
+                            "modified this file, so all bitmaps are now "
+                            "considered inconsistent");
+                error_printf("Some clusters may be leaked, "
+                             "run 'qemu-img check -r' on the image "
                              "file to fix.");
                 if (need_update_header != NULL) {
                     /* Updating is needed to drop invalid bitmap extension. */
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index d07763f..ad7ce9f 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -224,8 +224,8 @@ static void kvm_s390_enable_cmma(void)
     };
 
     if (mem_path) {
-        error_report("Warning: CMM will not be enabled because it is not "
-                     "compatible to hugetlbfs.");
+        warn_report("CMM will not be enabled because it is not "
+                    "compatible with hugetlbfs.");
         return;
     }
     rc = kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
diff --git a/trace/control.c b/trace/control.c
index 82d8989..2769934 100644
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
1.8.3.1
