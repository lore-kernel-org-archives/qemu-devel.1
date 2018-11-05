Received: from eggs.gnu.org ([2001:4830:134:3::10]:55097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gJfMA-0001Gv-DD
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:55:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gJfM9-0006l9-7E
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:55:54 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gJfM8-0006eU-Sn
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:55:53 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  5 Nov 2018 13:55:37 +0000
Message-Id: <20181105135538.28025-2-peter.maydell@linaro.org>
In-Reply-To: <20181105135538.28025-1-peter.maydell@linaro.org>
References: <20181105135538.28025-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-3.1 1/2] include/qemu/thread.h: Document
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
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Add documentation for the qemu_thread_atexit_add() and
qemu_thread_atexit_remove() functions.

We include a (previously undocumented) constraint that notifiers
may not be called if a thread is exiting because the entire
process is exiting. This is fine for our current use because
the callers use it only for cleaning up resources which go away
on process exit (memory, Win32 fibers), and we will need the
flexibility for the new posix implementation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/qemu/thread.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index b2661b66720..55d83a907cd 100644
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
2.19.1
