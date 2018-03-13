Received: from eggs.gnu.org ([2001:4830:134:3::10]:57855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshm-0005SW-1H
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshi-0002s6-Ug
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:38 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:55341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evshi-0002r6-Nl
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:34 -0400
Received: by mail-wm0-x244.google.com with SMTP id q83so871076wme.5
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:47:34 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:20 +0100
Message-Id: <20180313224719.4954-11-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/69] vl: export machine_init_done
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

We have that variable but not exported.  Export that so modules can have
a way to poke on whether machine init has finished.

Meanwhile, set that up even before calling the notifiers, so that
notifiers who may depend on this field will get a correct answer.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180306053320.15401-2-peterx@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/sysemu.h   | 2 ++
 stubs/machine-init-done.c | 2 ++
 vl.c                      | 4 ++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 356bfdc1c1..2b42151c63 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -88,6 +88,8 @@ void qemu_system_guest_panicked(GuestPanicInformation *info);
 void qemu_add_exit_notifier(Notifier *notify);
 void qemu_remove_exit_notifier(Notifier *notify);
 
+extern bool machine_init_done;
+
 void qemu_add_machine_init_done_notifier(Notifier *notify);
 void qemu_remove_machine_init_done_notifier(Notifier *notify);
 
diff --git a/stubs/machine-init-done.c b/stubs/machine-init-done.c
index 9a0d62514f..4121f1709b 100644
--- a/stubs/machine-init-done.c
+++ b/stubs/machine-init-done.c
@@ -2,6 +2,8 @@
 #include "qemu-common.h"
 #include "sysemu/sysemu.h"
 
+bool machine_init_done = true;
+
 void qemu_add_machine_init_done_notifier(Notifier *notify)
 {
 }
diff --git a/vl.c b/vl.c
index 3ef04ce991..26662eb9e7 100644
--- a/vl.c
+++ b/vl.c
@@ -2696,7 +2696,7 @@ static void qemu_run_exit_notifiers(void)
     notifier_list_notify(&exit_notifiers, NULL);
 }
 
-static bool machine_init_done;
+bool machine_init_done;
 
 void qemu_add_machine_init_done_notifier(Notifier *notify)
 {
@@ -2713,8 +2713,8 @@ void qemu_remove_machine_init_done_notifier(Notifier *notify)
 
 static void qemu_run_machine_init_done_notifiers(void)
 {
-    notifier_list_notify(&machine_init_done_notifiers, NULL);
     machine_init_done = true;
+    notifier_list_notify(&machine_init_done_notifiers, NULL);
 }
 
 static const QEMUOption *lookup_opt(int argc, char **argv,
-- 
2.14.3
