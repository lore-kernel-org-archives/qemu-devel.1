Received: from eggs.gnu.org ([2001:4830:134:3::10]:40147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gK9Cr-0002lH-Fw
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:48:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gK93U-0001I6-GZ
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:38:40 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:55902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gK93T-0000eE-Tu
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:38:36 -0500
Received: by mail-wm1-x334.google.com with SMTP id s10-v6so12270239wmc.5
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 13:38:25 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Nov 2018 22:38:02 +0100
Message-Id: <1541540283-45699-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1541540283-45699-1-git-send-email-pbonzini@redhat.com>
References: <1541540283-45699-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 16/17] include/qemu/thread.h: Document
 qemu_thread_atexit* API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

Add documentation for the qemu_thread_atexit_add() and
qemu_thread_atexit_remove() functions.

We include a (previously undocumented) constraint that notifiers
may not be called if a thread is exiting because the entire
process is exiting. This is fine for our current use because
the callers use it only for cleaning up resources which go away
on process exit (memory, Win32 fibers), and we will need the
flexibility for the new posix implementation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20181105135538.28025-2-peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/thread.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index b2661b6..55d83a9 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -162,7 +162,29 @@ void qemu_thread_exit(void *retval);
 void qemu_thread_naming(bool enable);
 
 struct Notifier;
+/**
+ * qemu_thread_atexit_add:
+ * @notifier: Notifier to add
+ *
+ * Add the specified notifier to a list which will be run via
+ * notifier_list_notify() when this thread exits (either by calling
+ * qemu_thread_exit() or by returning from its start_routine).
+ * The usual usage is that the caller passes a Notifier which is
+ * a per-thread variable; it can then use the callback to free
+ * other per-thread data.
+ *
+ * If the thread exits as part of the entire process exiting,
+ * it is unspecified whether notifiers are called or not.
+ */
 void qemu_thread_atexit_add(struct Notifier *notifier);
+/**
+ * qemu_thread_atexit_remove:
+ * @notifier: Notifier to remove
+ *
+ * Remove the specified notifier from the thread-exit notification
+ * list. It is not valid to try to remove a notifier which is not
+ * on the list.
+ */
 void qemu_thread_atexit_remove(struct Notifier *notifier);
 
 struct QemuSpin {
-- 
1.8.3.1
