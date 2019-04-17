Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203A6C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:21:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E07302073F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07302073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58343 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGq7o-0002Nv-TY
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 15:21:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGptR-0007gs-Rw
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGptQ-0003d4-MO
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:06:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hGptN-0003Ws-3f; Wed, 17 Apr 2019 15:06:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2C6981F18;
	Wed, 17 Apr 2019 19:06:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 82B535D707;
	Wed, 17 Apr 2019 19:06:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id D4C9C1132BD3; Wed, 17 Apr 2019 21:06:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Apr 2019 21:06:28 +0200
Message-Id: <20190417190641.26814-3-armbru@redhat.com>
In-Reply-To: <20190417190641.26814-1-armbru@redhat.com>
References: <20190417190641.26814-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Wed, 17 Apr 2019 19:06:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 02/15] block/ssh: Do not report
 read/write/flush errors to the user
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>,
	qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190417190628.ZgTm-EbbgWjsrLY_K0mzlQ36YqGtn1Qyxib2nWcgXSE@z>

Callbacks ssh_co_readv(), ssh_co_writev(), ssh_co_flush() report
errors to the user with error_printf().  They shouldn't, it's their
caller's job.  Replace by a suitable trace point.  While there, drop
the unreachable !s->sftp case.

Perhaps we should convert this part of the block driver interface to
Error, so block drivers can pass more detail to their callers.  Not
today.

Cc: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/ssh.c        | 38 +++++++++++++-------------------------
 block/trace-events |  3 +++
 2 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/block/ssh.c b/block/ssh.c
index 190ef95300..859249113d 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -159,31 +159,19 @@ sftp_error_setg(Error **errp, BDRVSSHState *s, const char *fs, ...)
     g_free(msg);
 }
 
-static void GCC_FMT_ATTR(2, 3)
-sftp_error_report(BDRVSSHState *s, const char *fs, ...)
+static void sftp_error_trace(BDRVSSHState *s, const char *op)
 {
-    va_list args;
+    char *ssh_err;
+    int ssh_err_code;
+    unsigned long sftp_err_code;
 
-    va_start(args, fs);
-    error_vprintf(fs, args);
+    /* This is not an errno.  See <libssh2.h>. */
+    ssh_err_code = libssh2_session_last_error(s->session,
+                                              &ssh_err, NULL, 0);
+    /* See <libssh2_sftp.h>. */
+    sftp_err_code = libssh2_sftp_last_error((s)->sftp);
 
-    if ((s)->sftp) {
-        char *ssh_err;
-        int ssh_err_code;
-        unsigned long sftp_err_code;
-
-        /* This is not an errno.  See <libssh2.h>. */
-        ssh_err_code = libssh2_session_last_error(s->session,
-                                                  &ssh_err, NULL, 0);
-        /* See <libssh2_sftp.h>. */
-        sftp_err_code = libssh2_sftp_last_error((s)->sftp);
-
-        error_printf(": %s (libssh2 error code: %d, sftp error code: %lu)",
-                     ssh_err, ssh_err_code, sftp_err_code);
-    }
-
-    va_end(args);
-    error_printf("\n");
+    trace_sftp_error(op, ssh_err, ssh_err_code, sftp_err_code);
 }
 
 static int parse_uri(const char *filename, QDict *options, Error **errp)
@@ -1035,7 +1023,7 @@ static coroutine_fn int ssh_read(BDRVSSHState *s, BlockDriverState *bs,
             goto again;
         }
         if (r < 0) {
-            sftp_error_report(s, "read failed");
+            sftp_error_trace(s, "read");
             s->offset = -1;
             return -EIO;
         }
@@ -1105,7 +1093,7 @@ static int ssh_write(BDRVSSHState *s, BlockDriverState *bs,
             goto again;
         }
         if (r < 0) {
-            sftp_error_report(s, "write failed");
+            sftp_error_trace(s, "write");
             s->offset = -1;
             return -EIO;
         }
@@ -1188,7 +1176,7 @@ static coroutine_fn int ssh_flush(BDRVSSHState *s, BlockDriverState *bs)
         return 0;
     }
     if (r < 0) {
-        sftp_error_report(s, "fsync failed");
+        sftp_error_trace(s, "fsync");
         return -EIO;
     }
 
diff --git a/block/trace-events b/block/trace-events
index 7335a42540..79ccd8d824 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -208,3 +208,6 @@ sheepdog_co_rw_vector_new(uint64_t oid) "new oid 0x%" PRIx64
 sheepdog_snapshot_create_info(const char *sn_name, const char *id, const char *name, int64_t size, int is_snapshot) "sn_info: name %s id_str %s s: name %s vm_state_size %" PRId64 " " "is_snapshot %d"
 sheepdog_snapshot_create(const char *sn_name, const char *id) "%s %s"
 sheepdog_snapshot_create_inode(const char *name, uint32_t snap, uint32_t vdi) "s->inode: name %s snap_id 0x%" PRIx32 " vdi 0x%" PRIx32
+
+# ssh.c
+sftp_error(const char *op, const char *ssh_err, int ssh_err_code, unsigned long sftp_err_code) "%s failed: %s (libssh2 error code: %d, sftp error code: %lu)"
-- 
2.17.2


