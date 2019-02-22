Received: from eggs.gnu.org ([209.51.188.92]:55221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gxBBW-0007KL-Ho
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:48:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gxBBV-0001j0-8G
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:48:14 -0500
Received: from fanzine.igalia.com ([91.117.99.155]:56217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1gxBBU-0000id-9j
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:48:13 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 22 Feb 2019 15:46:24 +0200
Message-Id: <d7e4fd4876866db327ac3db5cb7b1a8d9697b5b7.1550842915.git.berto@igalia.com>
In-Reply-To: <cover.1550842915.git.berto@igalia.com>
References: <cover.1550842915.git.berto@igalia.com>
In-Reply-To: <cover.1550842915.git.berto@igalia.com>
References: <cover.1550842915.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 1/3] main-loop: Fix GSource leak in
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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
