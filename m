Received: from eggs.gnu.org ([209.51.188.92]:52323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gx9Un-0004uS-Qo
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 07:00:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gx9Um-000472-Qm
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 07:00:01 -0500
Received: from fanzine.igalia.com ([91.117.99.155]:39613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1gx9Um-0003ph-74
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 07:00:00 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 22 Feb 2019 13:59:10 +0200
Message-Id: <0df0773f716140fec012d6778220b8a07067a5c6.1550836631.git.berto@igalia.com>
In-Reply-To: <cover.1550836631.git.berto@igalia.com>
References: <cover.1550836631.git.berto@igalia.com>
In-Reply-To: <cover.1550836631.git.berto@igalia.com>
References: <cover.1550836631.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 1/3] main-loop: Fix GSource leak in
 qio_task_thread_worker()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

After g_source_attach() the GMainContext holds a reference to the
GSource, so the caller does not need to keep it.

qio_task_thread_worker() is not releasing its reference so the GSource
is being leaked since a17536c594bfed94d05667b419f747b692f5fc7f.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 io/task.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io/task.c b/io/task.c
index 64c4c7126a..1ae7b86488 100644
--- a/io/task.c
+++ b/io/task.c
@@ -136,6 +136,7 @@ static gpointer qio_task_thread_worker(gpointer opaque)
                           qio_task_thread_result, task, NULL);
     g_source_attach(task->thread->completion,
                     task->thread->context);
+    g_source_unref(task->thread->completion);
     trace_qio_task_thread_source_attach(task, task->thread->completion);
 
     qemu_cond_signal(&task->thread_cond);
-- 
2.11.0
