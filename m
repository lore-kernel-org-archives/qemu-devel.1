Received: from eggs.gnu.org ([2001:4830:134:3::10]:56572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCTM5-00063G-GJ
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:42:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCTM2-0008Ux-46
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:42:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gCTM1-0008TI-Oe
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:42:01 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 16 Oct 2018 19:41:22 +0200
Message-Id: <20181016174158.15229-3-armbru@redhat.com>
In-Reply-To: <20181016174158.15229-1-armbru@redhat.com>
References: <20181016174158.15229-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 02/38] Use error_fatal to simplify obvious
 fatal errors (again)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Add a slight improvement of the Coccinelle semantic patch from commit
007b06578ab, and use it to clean up.  It leaves dead Error * variables
behind, cleaned up manually.

Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>
Cc: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics_kvm.c                       |  7 +------
 qemu-nbd.c                               |  6 +-----
 scripts/coccinelle/use-error_fatal.cocci | 20 ++++++++++++++++++++
 vl.c                                     |  7 +------
 4 files changed, 23 insertions(+), 17 deletions(-)
 create mode 100644 scripts/coccinelle/use-error_fatal.cocci

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 30c3769a20..e8fa9a53ae 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -198,17 +198,12 @@ static void ics_get_kvm_state(ICSState *ics)
 {
     uint64_t state;
     int i;
-    Error *local_err = NULL;
 
     for (i = 0; i < ics->nr_irqs; i++) {
         ICSIRQState *irq = &ics->irqs[i];
 
         kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
-                          i + ics->offset, &state, false, &local_err);
-        if (local_err) {
-            error_report_err(local_err);
-            exit(1);
-        }
+                          i + ics->offset, &state, false, &error_fatal);
 
         irq->server = state & KVM_XICS_DESTINATION_MASK;
         irq->saved_priority = (state >> KVM_XICS_PRIORITY_SHIFT)
diff --git a/qemu-nbd.c b/qemu-nbd.c
index e76fe3082a..7874bc973c 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -1002,11 +1002,7 @@ int main(int argc, char **argv)
     }
 
     exp = nbd_export_new(bs, dev_offset, fd_size, nbdflags, nbd_export_closed,
-                         writethrough, NULL, &local_err);
-    if (!exp) {
-        error_report_err(local_err);
-        exit(EXIT_FAILURE);
-    }
+                         writethrough, NULL, &error_fatal);
     nbd_export_set_name(exp, export_name);
     nbd_export_set_description(exp, export_description);
 
diff --git a/scripts/coccinelle/use-error_fatal.cocci b/scripts/coccinelle/use-error_fatal.cocci
new file mode 100644
index 0000000000..10fff0aec4
--- /dev/null
+++ b/scripts/coccinelle/use-error_fatal.cocci
@@ -0,0 +1,20 @@
+@@
+type T;
+identifier FUN, RET;
+expression list ARGS;
+expression ERR, EC, FAIL;
+@@
+(
+-    T RET = FUN(ARGS, &ERR);
++    T RET = FUN(ARGS, &error_fatal);
+|
+-    RET = FUN(ARGS, &ERR);
++    RET = FUN(ARGS, &error_fatal);
+|
+-    FUN(ARGS, &ERR);
++    FUN(ARGS, &error_fatal);
+)
+-    if (FAIL) {
+-        error_report_err(ERR);
+-        exit(EC);
+-    }
diff --git a/vl.c b/vl.c
index 4e25c78bff..ff50199e64 100644
--- a/vl.c
+++ b/vl.c
@@ -2002,15 +2002,10 @@ static void select_vgahw(const char *p)
 
 static void parse_display_qapi(const char *optarg)
 {
-    Error *err = NULL;
     DisplayOptions *opts;
     Visitor *v;
 
-    v = qobject_input_visitor_new_str(optarg, "type", &err);
-    if (!v) {
-        error_report_err(err);
-        exit(1);
-    }
+    v = qobject_input_visitor_new_str(optarg, "type", &error_fatal);
 
     visit_type_DisplayOptions(v, NULL, &opts, &error_fatal);
     QAPI_CLONE_MEMBERS(DisplayOptions, &dpy, opts);
-- 
2.17.1
