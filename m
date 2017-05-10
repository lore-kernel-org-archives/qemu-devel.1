Received: from eggs.gnu.org ([2001:4830:134:3::10]:56401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8SfC-0001DY-8l
	for qemu-devel@nongnu.org; Wed, 10 May 2017 10:32:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8SfB-0002JK-Az
	for qemu-devel@nongnu.org; Wed, 10 May 2017 10:32:26 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 10 May 2017 16:32:05 +0200
Message-Id: <20170510143205.32013-8-pbonzini@redhat.com>
In-Reply-To: <20170510143205.32013-1-pbonzini@redhat.com>
References: <20170510143205.32013-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 7/7] curl: do not do aio_poll when waiting for
 a free CURLState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jcody@redhat.com, qemu-stable@nongnu.org, qemu-block@nongnu.org, rjones@redhat.com

Instead, put the CURLAIOCB on a wait list; curl_clean_state will
wake the corresponding coroutine.

Because of CURL's callback-based structure, we cannot easily convert
everything to CoMutex/CoQueue; keeping the QemuMutex is simpler.
However, CoQueue is a simple wrapper around a linked list, so we can
use QSIMPLEQ easily to open-code a CoQueue that has a QemuMutex's
protection instead of a CoMutex's.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/curl.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/block/curl.c b/block/curl.c
index 80870bd60c..4ccdf63510 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -98,6 +98,8 @@ typedef struct CURLAIOCB {
 
     size_t start;
     size_t end;
+
+    QSIMPLEQ_ENTRY(CURLAIOCB) next;
 } CURLAIOCB;
 
 typedef struct CURLSocket {
@@ -133,6 +135,7 @@ typedef struct BDRVCURLState {
     bool accept_range;
     AioContext *aio_context;
     QemuMutex mutex;
+    QSIMPLEQ_HEAD(, CURLAIOCB) free_state_waitq;
     char *username;
     char *password;
     char *proxyusername;
@@ -532,6 +535,7 @@ static int curl_init_state(BDRVCURLState *s, CURLState *state)
 /* Called with s->mutex held.  */
 static void curl_clean_state(CURLState *s)
 {
+    CURLAIOCB *next;
     int j;
     for (j=0; j<CURL_NUM_ACB; j++) {
         assert(!s->acb[j]);
@@ -548,6 +552,14 @@ static void curl_clean_state(CURLState *s)
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
@@ -744,6 +756,7 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
 
     DPRINTF("CURL: Opening %s\n", file);
     qemu_mutex_init(&s->mutex);
+    QSIMPLEQ_INIT(&s->free_state_waitq);
     s->aio_context = bdrv_get_aio_context(bs);
     s->url = g_strdup(file);
     qemu_mutex_lock(&s->mutex);
@@ -843,8 +856,9 @@ static void curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
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
2.12.2
