Received: from eggs.gnu.org ([2001:4830:134:3::10]:47012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dAeoV-0003na-ID
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:55:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dAeoP-0001mA-Q9
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:55:07 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 16 May 2017 11:54:20 -0400
Message-Id: <20170516155420.10106-9-jcody@redhat.com>
In-Reply-To: <20170516155420.10106-1-jcody@redhat.com>
References: <20170516155420.10106-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 8/8] curl: do not do aio_poll when waiting for a
 free CURLState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Instead, put the CURLAIOCB on a wait list and yield; curl_clean_state will
wake the corresponding coroutine.

Because of CURL's callback-based structure, we cannot easily convert
everything to CoMutex/CoQueue; keeping the QemuMutex is simpler.  However,
CoQueue is a simple wrapper around a linked list, so we can easily
use QSIMPLEQ and open-code a CoQueue, protected by the BDRVCURLState
QemuMutex instead of a CoMutex.

Reviewed-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170515100059.15795-8-pbonzini@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/curl.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/block/curl.c b/block/curl.c
index 1c04903..2a244e2 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -99,6 +99,8 @@ typedef struct CURLAIOCB {
 
     size_t start;
     size_t end;
+
+    QSIMPLEQ_ENTRY(CURLAIOCB) next;
 } CURLAIOCB;
 
 typedef struct CURLSocket {
@@ -134,6 +136,7 @@ typedef struct BDRVCURLState {
     bool accept_range;
     AioContext *aio_context;
     QemuMutex mutex;
+    QSIMPLEQ_HEAD(, CURLAIOCB) free_state_waitq;
     char *username;
     char *password;
     char *proxyusername;
@@ -533,6 +536,7 @@ static int curl_init_state(BDRVCURLState *s, CURLState *state)
 /* Called with s->mutex held.  */
 static void curl_clean_state(CURLState *s)
 {
+    CURLAIOCB *next;
     int j;
     for (j = 0; j < CURL_NUM_ACB; j++) {
         assert(!s->acb[j]);
@@ -549,6 +553,14 @@ static void curl_clean_state(CURLState *s)
     }
 
     s->in_use = 0;
+
+    next = QSIMPLEQ_FIRST(&s->s->free_state_waitq);
+    if (next) {
+        QSIMPLEQ_REMOVE_HEAD(&s->s->free_state_waitq, next);
+        qemu_mutex_unlock(&s->s->mutex);
+        aio_co_wake(next->co);
+        qemu_mutex_lock(&s->s->mutex);
+    }
 }
 
 static void curl_parse_filename(const char *filename, QDict *options,
@@ -766,6 +778,7 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     DPRINTF("CURL: Opening %s\n", file);
+    QSIMPLEQ_INIT(&s->free_state_waitq);
     s->aio_context = bdrv_get_aio_context(bs);
     s->url = g_strdup(file);
     qemu_mutex_lock(&s->mutex);
@@ -866,8 +879,9 @@ static void curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
         if (state) {
             break;
         }
+        QSIMPLEQ_INSERT_TAIL(&s->free_state_waitq, acb, next);
         qemu_mutex_unlock(&s->mutex);
-        aio_poll(bdrv_get_aio_context(bs), true);
+        qemu_coroutine_yield();
         qemu_mutex_lock(&s->mutex);
     }
 
-- 
2.9.3
