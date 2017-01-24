Received: from eggs.gnu.org ([2001:4830:134:3::10]:55481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cW68M-0001NZ-Hr
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cW68L-0006tp-JX
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cW68L-0006tZ-Bs
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:57 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7E5CEC065114
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 18:47:57 +0000 (UTC)
Received: from dgilbert-t530.redhat.com (ovpn-116-204.ams2.redhat.com
	[10.36.116.204])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v0OIlhV3020536
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 13:47:56 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 24 Jan 2017 18:47:42 +0000
Message-Id: <20170124184742.1639-16-dgilbert@redhat.com>
In-Reply-To: <20170124184742.1639-1-dgilbert@redhat.com>
References: <20170124184742.1639-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 15/15] migration/tracing: Add tracing on save
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add some tracing to vmstate_subsection_save and vmstate_save_state
to help in debugging when you're not sure if a conditional piece
of data is being saved.

In vmstate_subsection_save I renamed the inner vmsd to avoid the aliasing
and be able to print both names.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20161212125838.14425-1-dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/trace-events |  4 ++++
 migration/vmstate.c    | 15 ++++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/migration/trace-events b/migration/trace-events
index ba6bee4..48e531d 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -40,6 +40,10 @@ savevm_state_iterate(void) ""
 savevm_state_cleanup(void) ""
 savevm_state_complete_precopy(void) ""
 vmstate_save(const char *idstr, const char *vmsd_name) "%s, %s"
+vmstate_save_state_loop(const char *name, const char *field, int n_elems) "%s/%s[%d]"
+vmstate_save_state_top(const char *idstr) "%s"
+vmstate_subsection_save_loop(const char *name, const char *sub) "%s/%s"
+vmstate_subsection_save_top(const char *idstr) "%s"
 vmstate_load(const char *idstr, const char *vmsd_name) "%s, %s"
 qemu_announce_self_iter(const char *mac) "%s"
 
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 8ddd230..2b2b3a5 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -306,6 +306,8 @@ void vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
 {
     VMStateField *field = vmsd->fields;
 
+    trace_vmstate_save_state_top(vmsd->name);
+
     if (vmsd->pre_save) {
         vmsd->pre_save(opaque);
     }
@@ -325,6 +327,7 @@ void vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
             int64_t old_offset, written_bytes;
             QJSON *vmdesc_loop = vmdesc;
 
+            trace_vmstate_save_state_loop(vmsd->name, field->name, n_elems);
             for (i = 0; i < n_elems; i++) {
                 void *addr = base_addr + size * i;
 
@@ -434,11 +437,13 @@ static void vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
     const VMStateDescription **sub = vmsd->subsections;
     bool subsection_found = false;
 
+    trace_vmstate_subsection_save_top(vmsd->name);
     while (sub && *sub && (*sub)->needed) {
         if ((*sub)->needed(opaque)) {
-            const VMStateDescription *vmsd = *sub;
+            const VMStateDescription *vmsdsub = *sub;
             uint8_t len;
 
+            trace_vmstate_subsection_save_loop(vmsd->name, vmsdsub->name);
             if (vmdesc) {
                 /* Only create subsection array when we have any */
                 if (!subsection_found) {
@@ -450,11 +455,11 @@ static void vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
             }
 
             qemu_put_byte(f, QEMU_VM_SUBSECTION);
-            len = strlen(vmsd->name);
+            len = strlen(vmsdsub->name);
             qemu_put_byte(f, len);
-            qemu_put_buffer(f, (uint8_t *)vmsd->name, len);
-            qemu_put_be32(f, vmsd->version_id);
-            vmstate_save_state(f, vmsd, opaque, vmdesc);
+            qemu_put_buffer(f, (uint8_t *)vmsdsub->name, len);
+            qemu_put_be32(f, vmsdsub->version_id);
+            vmstate_save_state(f, vmsdsub, opaque, vmdesc);
 
             if (vmdesc) {
                 json_end_object(vmdesc);
-- 
2.9.3
