Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEA7C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:44:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D962083E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FRT1CmdB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D962083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixHbq-000395-Eb
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 16:44:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ixHWf-0002UD-2A
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:39:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ixHWb-0000tM-KW
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:39:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27045
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ixHWb-0000s3-0n
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:38:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580420336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7fwh0ME1HVlBOgnkxranGKr/eF5Lv+1xWTQqUr+ffoQ=;
 b=FRT1CmdBrCjeSD3NmSFbT6jA+NXivSk1lClWbOYQPY4qTPrUVms/1n0l8jNDxUJXKCxr4m
 RLGnEnNEbqVp6QhNW++a+RW4FZASeNXQ6K3qV8V7DAwIX+zZfVB/lG+rShABScET/UN+sD
 3D0b7ShHpAreYZMHLxduLwzBVDkMaqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-vjG5wI40Nr-WL6SgY4zSPw-1; Thu, 30 Jan 2020 16:38:54 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8265818A6EC0;
 Thu, 30 Jan 2020 21:38:53 +0000 (UTC)
Received: from localhost (unknown [10.36.118.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD81E5C296;
 Thu, 30 Jan 2020 21:38:47 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 5/5] qemu_set_log_filename: filename argument may be NULL
Date: Thu, 30 Jan 2020 21:38:14 +0000
Message-Id: <20200130213814.334195-6-stefanha@redhat.com>
In-Reply-To: <20200130213814.334195-1-stefanha@redhat.com>
References: <20200130213814.334195-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: vjG5wI40Nr-WL6SgY4zSPw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Salvador Fandino <salvador@qindel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Salvador Fandino <salvador@qindel.com>

NULL is a valid log filename used to indicate we want to use stderr
but qemu_set_log_filename (which is called by bsd-user/main.c) was not
handling it correctly.

That also made redundant a couple of NULL checks in calling code which
have been removed.

Signed-off-by: Salvador Fandino <salvador@qindel.com>
Message-Id: <20200123193626.19956-1-salvador@qindel.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 trace/control.c |  4 +---
 util/log.c      | 28 ++++++++++++++++------------
 vl.c            |  5 +----
 3 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/trace/control.c b/trace/control.c
index 0fb8124160..6c775e68eb 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -229,9 +229,7 @@ void trace_init_file(const char *file)
     /* If both the simple and the log backends are enabled, "--trace file"
      * only applies to the simple backend; use "-D" for the log backend.
      */
-    if (file) {
-        qemu_set_log_filename(file, &error_fatal);
-    }
+    qemu_set_log_filename(file, &error_fatal);
 #else
     if (file) {
         fprintf(stderr, "error: --trace file=3D...: "
diff --git a/util/log.c b/util/log.c
index 867264da8d..47f2827397 100644
--- a/util/log.c
+++ b/util/log.c
@@ -148,25 +148,29 @@ void qemu_log_needs_buffers(void)
  * Allow the user to include %d in their logfile which will be
  * substituted with the current PID. This is useful for debugging many
  * nested linux-user tasks but will result in lots of logs.
+ *
+ * filename may be NULL. In that case, log output is sent to stderr
  */
 void qemu_set_log_filename(const char *filename, Error **errp)
 {
-    char *pidstr;
     g_free(logfilename);
     logfilename =3D NULL;
=20
-    pidstr =3D strstr(filename, "%");
-    if (pidstr) {
-        /* We only accept one %d, no other format strings */
-        if (pidstr[1] !=3D 'd' || strchr(pidstr + 2, '%')) {
-            error_setg(errp, "Bad logfile format: %s", filename);
-            return;
-        } else {
-            logfilename =3D g_strdup_printf(filename, getpid());
-        }
-    } else {
-        logfilename =3D g_strdup(filename);
+    if (filename) {
+            char *pidstr =3D strstr(filename, "%");
+            if (pidstr) {
+                /* We only accept one %d, no other format strings */
+                if (pidstr[1] !=3D 'd' || strchr(pidstr + 2, '%')) {
+                    error_setg(errp, "Bad logfile format: %s", filename);
+                    return;
+                } else {
+                    logfilename =3D g_strdup_printf(filename, getpid());
+                }
+            } else {
+                logfilename =3D g_strdup(filename);
+            }
     }
+
     qemu_log_close();
     qemu_set_log(qemu_loglevel);
 }
diff --git a/vl.c b/vl.c
index 24951b51a9..7dcb0879c4 100644
--- a/vl.c
+++ b/vl.c
@@ -3903,10 +3903,7 @@ int main(int argc, char **argv, char **envp)
=20
     /* Open the logfile at this point and set the log mask if necessary.
      */
-    if (log_file) {
-        qemu_set_log_filename(log_file, &error_fatal);
-    }
-
+    qemu_set_log_filename(log_file, &error_fatal);
     if (log_mask) {
         int mask;
         mask =3D qemu_str_to_log_mask(log_mask);
--=20
2.24.1


