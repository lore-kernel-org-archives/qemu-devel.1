Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7646CC48BE3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 17:50:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58DB0206BF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 17:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58DB0206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51906 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he1Cf-0001KX-KF
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 13:50:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34839)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1he19O-0007Gv-Q9
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 13:47:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1he109-0004hb-Fl
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 13:37:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53936)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1he109-0004ez-8f
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 13:37:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 25FCA223879;
 Thu, 20 Jun 2019 17:37:31 +0000 (UTC)
Received: from localhost (ovpn-116-108.ams2.redhat.com [10.36.116.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C23AE5C1A1;
 Thu, 20 Jun 2019 17:37:25 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 20 Jun 2019 18:37:07 +0100
Message-Id: <20190620173709.14753-2-stefanha@redhat.com>
In-Reply-To: <20190620173709.14753-1-stefanha@redhat.com>
References: <20190620173709.14753-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 20 Jun 2019 17:37:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 1/3] vl: add
 qemu_add_vm_change_state_handler_prio()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add an API for registering vm change state handlers with a well-defined
ordering.  This is necessary when handlers depend on each other.

Small coding style fixes are included to make checkpatch.pl happy.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/sysemu/sysemu.h |  2 ++
 vl.c                    | 59 ++++++++++++++++++++++++++++++++---------
 2 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 61579ae71e..984c439ac9 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -29,6 +29,8 @@ typedef void VMChangeStateHandler(void *opaque, int run=
ning, RunState state);
=20
 VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandle=
r *cb,
                                                      void *opaque);
+VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
+        VMChangeStateHandler *cb, void *opaque, int priority);
 void qemu_del_vm_change_state_handler(VMChangeStateEntry *e);
 void vm_state_notify(int running, RunState state);
=20
diff --git a/vl.c b/vl.c
index 99a56b5556..7fac2ae7ca 100644
--- a/vl.c
+++ b/vl.c
@@ -1471,28 +1471,57 @@ static int machine_help_func(QemuOpts *opts, Mach=
ineState *machine)
 struct vm_change_state_entry {
     VMChangeStateHandler *cb;
     void *opaque;
-    QLIST_ENTRY (vm_change_state_entry) entries;
+    QTAILQ_ENTRY(vm_change_state_entry) entries;
+    int priority;
 };
=20
-static QLIST_HEAD(, vm_change_state_entry) vm_change_state_head;
+static QTAILQ_HEAD(, vm_change_state_entry) vm_change_state_head;
=20
-VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandle=
r *cb,
-                                                     void *opaque)
+/**
+ * qemu_add_vm_change_state_handler_prio:
+ * @cb: the callback to invoke
+ * @opaque: user data passed to the callback
+ * @priority: low priorities execute first when the vm runs and the reve=
rse is
+ *            true when the vm stops
+ *
+ * Register a callback function that is invoked when the vm starts or st=
ops
+ * running.
+ *
+ * Returns: an entry to be freed using qemu_del_vm_change_state_handler(=
)
+ */
+VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
+        VMChangeStateHandler *cb, void *opaque, int priority)
 {
     VMChangeStateEntry *e;
+    VMChangeStateEntry *other;
=20
-    e =3D g_malloc0(sizeof (*e));
-
+    e =3D g_malloc0(sizeof(*e));
     e->cb =3D cb;
     e->opaque =3D opaque;
-    QLIST_INSERT_HEAD(&vm_change_state_head, e, entries);
+    e->priority =3D priority;
+
+    /* Keep list sorted in ascending priority order */
+    QTAILQ_FOREACH(other, &vm_change_state_head, entries) {
+        if (priority < other->priority) {
+            QTAILQ_INSERT_BEFORE(other, e, entries);
+            return e;
+        }
+    }
+
+    QTAILQ_INSERT_TAIL(&vm_change_state_head, e, entries);
     return e;
 }
=20
+VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandle=
r *cb,
+                                                     void *opaque)
+{
+    return qemu_add_vm_change_state_handler_prio(cb, opaque, 0);
+}
+
 void qemu_del_vm_change_state_handler(VMChangeStateEntry *e)
 {
-    QLIST_REMOVE (e, entries);
-    g_free (e);
+    QTAILQ_REMOVE(&vm_change_state_head, e, entries);
+    g_free(e);
 }
=20
 void vm_state_notify(int running, RunState state)
@@ -1501,8 +1530,14 @@ void vm_state_notify(int running, RunState state)
=20
     trace_vm_state_notify(running, state, RunState_str(state));
=20
-    QLIST_FOREACH_SAFE(e, &vm_change_state_head, entries, next) {
-        e->cb(e->opaque, running, state);
+    if (running) {
+        QTAILQ_FOREACH_SAFE(e, &vm_change_state_head, entries, next) {
+            e->cb(e->opaque, running, state);
+        }
+    } else {
+        QTAILQ_FOREACH_REVERSE_SAFE(e, &vm_change_state_head, entries, n=
ext) {
+            e->cb(e->opaque, running, state);
+        }
     }
 }
=20
@@ -3025,7 +3060,7 @@ int main(int argc, char **argv, char **envp)
         exit(1);
     }
=20
-    QLIST_INIT (&vm_change_state_head);
+    QTAILQ_INIT(&vm_change_state_head);
     os_setup_early_signal_handling();
=20
     cpu_option =3D NULL;
--=20
2.21.0


