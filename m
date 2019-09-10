Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D4FC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 12:45:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 094BA2084D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 12:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 094BA2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7fWP-0005bN-RK
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 08:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7fTM-0002nJ-Hh
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7fTK-0005PW-RS
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:42:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48830)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7fTH-0005Mn-Du; Tue, 10 Sep 2019 08:42:11 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B9845769E1;
 Tue, 10 Sep 2019 12:42:10 +0000 (UTC)
Received: from localhost (ovpn-117-90.ams2.redhat.com [10.36.117.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD6A460BE2;
 Tue, 10 Sep 2019 12:42:07 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 10 Sep 2019 14:41:35 +0200
Message-Id: <20190910124136.10565-7-mreitz@redhat.com>
In-Reply-To: <20190910124136.10565-1-mreitz@redhat.com>
References: <20190910124136.10565-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 10 Sep 2019 12:42:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 6/7] curl: Handle success in
 multi_check_completion
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Background: As of cURL 7.59.0, it verifies that several functions are
not called from within a callback.  Among these functions is
curl_multi_add_handle().

curl_read_cb() is a callback from cURL and not a coroutine.  Waking up
acb->co will lead to entering it then and there, which means the current
request will settle and the caller (if it runs in the same coroutine)
may then issue the next request.  In such a case, we will enter
curl_setup_preadv() effectively from within curl_read_cb().

Calling curl_multi_add_handle() will then fail and the new request will
not be processed.

Fix this by not letting curl_read_cb() wake up acb->co.  Instead, leave
the whole business of settling the AIOCB objects to
curl_multi_check_completion() (which is called from our timer callback
and our FD handler, so not from any cURL callbacks).

Reported-by: Natalie Gavrielov <ngavrilo@redhat.com>
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1740193
Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/curl.c | 69 ++++++++++++++++++++++------------------------------
 1 file changed, 29 insertions(+), 40 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index fd70f1ebc4..c343c7ed3d 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -229,7 +229,6 @@ static size_t curl_read_cb(void *ptr, size_t size, si=
ze_t nmemb, void *opaque)
 {
     CURLState *s =3D ((CURLState*)opaque);
     size_t realsize =3D size * nmemb;
-    int i;
=20
     trace_curl_read_cb(realsize);
=20
@@ -245,32 +244,6 @@ static size_t curl_read_cb(void *ptr, size_t size, s=
ize_t nmemb, void *opaque)
     memcpy(s->orig_buf + s->buf_off, ptr, realsize);
     s->buf_off +=3D realsize;
=20
-    for(i=3D0; i<CURL_NUM_ACB; i++) {
-        CURLAIOCB *acb =3D s->acb[i];
-
-        if (!acb)
-            continue;
-
-        if ((s->buf_off >=3D acb->end)) {
-            size_t request_length =3D acb->bytes;
-
-            qemu_iovec_from_buf(acb->qiov, 0, s->orig_buf + acb->start,
-                                acb->end - acb->start);
-
-            if (acb->end - acb->start < request_length) {
-                size_t offset =3D acb->end - acb->start;
-                qemu_iovec_memset(acb->qiov, offset, 0,
-                                  request_length - offset);
-            }
-
-            acb->ret =3D 0;
-            s->acb[i] =3D NULL;
-            qemu_mutex_unlock(&s->s->mutex);
-            aio_co_wake(acb->co);
-            qemu_mutex_lock(&s->s->mutex);
-        }
-    }
-
 read_end:
     /* curl will error out if we do not return this value */
     return size * nmemb;
@@ -351,13 +324,14 @@ static void curl_multi_check_completion(BDRVCURLSta=
te *s)
             break;
=20
         if (msg->msg =3D=3D CURLMSG_DONE) {
+            int i;
             CURLState *state =3D NULL;
+            bool error =3D msg->data.result !=3D CURLE_OK;
+
             curl_easy_getinfo(msg->easy_handle, CURLINFO_PRIVATE,
                               (char **)&state);
=20
-            /* ACBs for successful messages get completed in curl_read_c=
b */
-            if (msg->data.result !=3D CURLE_OK) {
-                int i;
+            if (error) {
                 static int errcount =3D 100;
=20
                 /* Don't lose the original error message from curl, sinc=
e
@@ -369,20 +343,35 @@ static void curl_multi_check_completion(BDRVCURLSta=
te *s)
                         error_report("curl: further errors suppressed");
                     }
                 }
+            }
=20
-                for (i =3D 0; i < CURL_NUM_ACB; i++) {
-                    CURLAIOCB *acb =3D state->acb[i];
+            for (i =3D 0; i < CURL_NUM_ACB; i++) {
+                CURLAIOCB *acb =3D state->acb[i];
=20
-                    if (acb =3D=3D NULL) {
-                        continue;
-                    }
+                if (acb =3D=3D NULL) {
+                    continue;
+                }
+
+                if (!error) {
+                    /* Assert that we have read all data */
+                    assert(state->buf_off >=3D acb->end);
+
+                    qemu_iovec_from_buf(acb->qiov, 0,
+                                        state->orig_buf + acb->start,
+                                        acb->end - acb->start);
=20
-                    acb->ret =3D -EIO;
-                    state->acb[i] =3D NULL;
-                    qemu_mutex_unlock(&s->mutex);
-                    aio_co_wake(acb->co);
-                    qemu_mutex_lock(&s->mutex);
+                    if (acb->end - acb->start < acb->bytes) {
+                        size_t offset =3D acb->end - acb->start;
+                        qemu_iovec_memset(acb->qiov, offset, 0,
+                                          acb->bytes - offset);
+                    }
                 }
+
+                acb->ret =3D error ? -EIO : 0;
+                state->acb[i] =3D NULL;
+                qemu_mutex_unlock(&s->mutex);
+                aio_co_wake(acb->co);
+                qemu_mutex_lock(&s->mutex);
             }
=20
             curl_clean_state(state);
--=20
2.21.0


