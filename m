Received: from eggs.gnu.org ([2001:4830:134:3::10]:46546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1esjxa-0007UL-Q9
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:50:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1esjxW-0001Ru-SH
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:50:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57620 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1esjxW-0001R6-Nu
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:50:54 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39E4B402312B
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 06:50:51 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon,  5 Mar 2018 14:50:32 +0800
Message-Id: <20180305065040.10353-2-peterx@redhat.com>
In-Reply-To: <20180305065040.10353-1-peterx@redhat.com>
References: <20180305065040.10353-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 1/9] vl: export machine_init_done
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

We have that variable but not exported.  Export that so modules can have
a way to poke on whether machine init has finished.

Meanwhile, set that up even before calling the notifiers, so that
notifiers who may depend on this field will get a correct answer.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/sysemu/sysemu.h   | 2 ++
 stubs/machine-init-done.c | 2 ++
 vl.c                      | 4 ++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 77bb3da582..3f0f35610b 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -86,6 +86,8 @@ void qemu_system_guest_panicked(GuestPanicInformation *info);
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
index a33ac008fb..57777e8d47 100644
--- a/vl.c
+++ b/vl.c
@@ -2712,7 +2712,7 @@ static void qemu_run_exit_notifiers(void)
     notifier_list_notify(&exit_notifiers, NULL);
 }
 
-static bool machine_init_done;
+bool machine_init_done;
 
 void qemu_add_machine_init_done_notifier(Notifier *notify)
 {
@@ -2729,8 +2729,8 @@ void qemu_remove_machine_init_done_notifier(Notifier *notify)
 
 static void qemu_run_machine_init_done_notifiers(void)
 {
-    notifier_list_notify(&machine_init_done_notifiers, NULL);
     machine_init_done = true;
+    notifier_list_notify(&machine_init_done_notifiers, NULL);
 }
 
 static const QEMUOption *lookup_opt(int argc, char **argv,
-- 
2.14.3
