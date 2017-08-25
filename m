Received: from eggs.gnu.org ([2001:4830:134:3::10]:36304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wrfsh@yandex-team.ru>) id 1dlGuV-0005XK-Up
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:52:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wrfsh@yandex-team.ru>) id 1dlGuR-00024i-Um
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:52:40 -0400
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:55794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wrfsh@yandex-team.ru>)
	id 1dlGuR-00022W-K8
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:52:35 -0400
From: Evgeny Yakovlev <wrfsh@yandex-team.ru>
Date: Fri, 25 Aug 2017 18:52:26 +0300
Message-Id: <1503676346-3762-1-git-send-email-wrfsh@yandex-team.ru>
Subject: [Qemu-devel] [PATCH] block/curl: wake read completion coroutine
 only if necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jcody@redhat.com
Cc: asmetanin@yandex-team.ru, Evgeny Yakovlev <wrfsh@yandex-team.ru>

When curl_co_preadv is called it sets up an ACB block which points to
current coroutine. It will then call curl_setup_preadv and wait until
request is completed by polling return status and yeilding:

    curl_setup_preadv(bs, &acb);
    while (acb.ret == -EINPROGRESS) {
        qemu_coroutine_yield();
    }

curl_setup_preadv will ask libcurl to handle read request and to use
curl_read_cb as completion callback for each completed chunk.

When curl_read_cb sees request as completed it will attempt to wake up
issuing coroutine assuming that yield was called previously:

    qemu_mutex_unlock(&s->s->mutex);
    aio_co_wake(acb->co);
    qemu_mutex_lock(&s->s->mutex);

However if request is short enough (< 16K in our test) curl_read_cb will
be called right away before returning from libcurl to curl_setup_preadv.
Request will be completed before yield was called from the same
coroutine, which asserts in aio_co_enter.

This change attempts to fix this by waking completion coroutine only if
it is not the current one.

Signed-off-by: Evgeny Yakovlev <wrfsh@yandex-team.ru>
---
 block/curl.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index 2a244e2..b1106d6 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -271,9 +271,12 @@ static size_t curl_read_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
 
             acb->ret = 0;
             s->acb[i] = NULL;
-            qemu_mutex_unlock(&s->s->mutex);
-            aio_co_wake(acb->co);
-            qemu_mutex_lock(&s->s->mutex);
+
+            if (qemu_coroutine_self() != acb->co) {
+                qemu_mutex_unlock(&s->s->mutex);
+                aio_co_wake(acb->co);
+                qemu_mutex_lock(&s->s->mutex);
+            }
         }
     }
 
-- 
2.7.4
