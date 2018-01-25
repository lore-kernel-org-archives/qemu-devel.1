Received: from eggs.gnu.org ([2001:4830:134:3::10]:44412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eelog-0000Es-QZ
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 13:00:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eelof-0004T4-U7
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 13:00:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eelof-0004Rc-PY
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 13:00:01 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 06CA3780F4
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 18:00:01 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 25 Jan 2018 18:59:49 +0100
Message-Id: <20180125175949.7780-6-pbonzini@redhat.com>
In-Reply-To: <20180125175949.7780-1-pbonzini@redhat.com>
References: <20180125175949.7780-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 5/5] curl: convert to CoQueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com

Now that CoQueues can use a QemuMutex for thread-safety, there is no
need for curl to roll its own coroutine queue.  Coroutines can be
placed directly on the queue instead of using a list of CURLAIOCBs.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/curl.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index 35cf417f59..cd578d3d14 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -101,8 +101,6 @@ typedef struct CURLAIOCB {
 
     size_t start;
     size_t end;
-
-    QSIMPLEQ_ENTRY(CURLAIOCB) next;
 } CURLAIOCB;
 
 typedef struct CURLSocket {
@@ -138,7 +136,7 @@ typedef struct BDRVCURLState {
     bool accept_range;
     AioContext *aio_context;
     QemuMutex mutex;
-    QSIMPLEQ_HEAD(, CURLAIOCB) free_state_waitq;
+    CoQueue free_state_waitq;
     char *username;
     char *password;
     char *proxyusername;
@@ -538,7 +536,6 @@ static int curl_init_state(BDRVCURLState *s, CURLState *state)
 /* Called with s->mutex held.  */
 static void curl_clean_state(CURLState *s)
 {
-    CURLAIOCB *next;
     int j;
     for (j = 0; j < CURL_NUM_ACB; j++) {
         assert(!s->acb[j]);
@@ -556,13 +553,7 @@ static void curl_clean_state(CURLState *s)
 
     s->in_use = 0;
 
-    next = QSIMPLEQ_FIRST(&s->s->free_state_waitq);
-    if (next) {
-        QSIMPLEQ_REMOVE_HEAD(&s->s->free_state_waitq, next);
-        qemu_mutex_unlock(&s->s->mutex);
-        aio_co_wake(next->co);
-        qemu_mutex_lock(&s->s->mutex);
-    }
+    qemu_co_enter_next(&s->s->free_state_waitq, &s->s->mutex);
 }
 
 static void curl_parse_filename(const char *filename, QDict *options,
@@ -784,7 +775,7 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     DPRINTF("CURL: Opening %s\n", file);
-    QSIMPLEQ_INIT(&s->free_state_waitq);
+    qemu_co_queue_init(&s->free_state_waitq);
     s->aio_context = bdrv_get_aio_context(bs);
     s->url = g_strdup(file);
     qemu_mutex_lock(&s->mutex);
@@ -888,10 +879,7 @@ static void curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
         if (state) {
             break;
         }
-        QSIMPLEQ_INSERT_TAIL(&s->free_state_waitq, acb, next);
-        qemu_mutex_unlock(&s->mutex);
-        qemu_coroutine_yield();
-        qemu_mutex_lock(&s->mutex);
+        qemu_co_queue_wait(&s->free_state_waitq, &s->mutex);
     }
 
     if (curl_init_state(s, state) < 0) {
-- 
2.14.3
