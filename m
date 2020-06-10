Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CB0C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 01:19:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CECAB206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 01:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EL2/+Iq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CECAB206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jipOX-0004C1-2l
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 21:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jipMt-0001m5-Bs
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 21:17:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38803
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jipMp-00033d-NS
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 21:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591751843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CmIBDV8O2gEu/XvJBe8RT9x5c00/GLzhWDZHGUZ6Cyk=;
 b=EL2/+Iq667KQ8RiGnuezeqgQMRFNDWzm+lWadEy+JXlvC+WsIFxDH8SM70FqBnUJQYqtmD
 MQoJYSBWOli1A38y2LLLT9d/IBzCOMt0orttsxIVdB31etC0ALdjxGhoHPLsdheKdT5/Tm
 MyH594gq4zOL0lafNyRhRezkFCLSs6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-xazI-jBGNuSFchCqX4Bczw-1; Tue, 09 Jun 2020 21:17:19 -0400
X-MC-Unique: xazI-jBGNuSFchCqX4Bczw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59B7C805723;
 Wed, 10 Jun 2020 01:17:18 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD1505C1BD;
 Wed, 10 Jun 2020 01:17:17 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] nbd/server: Avoid long error message assertions
 CVE-2020-10761
Date: Tue,  9 Jun 2020 20:17:12 -0500
Message-Id: <20200610011713.3687895-3-eblake@redhat.com>
In-Reply-To: <20200610011713.3687895-1-eblake@redhat.com>
References: <20200610011713.3687895-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 21:17:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Xueqiang Wei <xuwei@redhat.com>,
 qemu-stable@nongnu.org,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ever since commit 36683283 (v2.8), the server code asserts that error
strings sent to the client are well-formed per the protocol by not
exceeding the maximum string length of 4096.  At the time the server
first started sending error messages, the assertion could not be
triggered, because messages were completely under our control.
However, over the years, we have added latent scenarios where a client
could trigger the server to attempt an error message that would
include the client's information if it passed other checks first:

- requesting NBD_OPT_INFO/GO on an export name that is not present
  (commit 0cfae925 in v2.12 echoes the name)

- requesting NBD_OPT_LIST/SET_META_CONTEXT on an export name that is
  not present (commit e7b1948d in v2.12 echoes the name)

At the time, those were still safe because we flagged names larger
than 256 bytes with a different message; but that changed in commit
93676c88 (v4.2) when we raised the name limit to 4096 to match the NBD
string limit.  (That commit also failed to change the magic number
4096 in nbd_negotiate_send_rep_err to the just-introduced named
constant.)  So with that commit, long client names appended to server
text can now trigger the assertion, and thus be used as a denial of
service attack against a server.  As a mitigating factor, if the
server requires TLS, the client cannot trigger the problematic paths
unless it first supplies TLS credentials, and such trusted clients are
less likely to try to intentionally crash the server.

Reported-by: Xueqiang Wei <xuwei@redhat.com>
CC: qemu-stable@nongnu.org
Fixes: https://bugzilla.redhat.com/1843684 CVE-2020-10761
Fixes: 93676c88d7
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200608182638.3256473-2-eblake@redhat.com>
---
 nbd/server.c               | 28 +++++++++++++++++++++++++---
 tests/qemu-iotests/143     |  4 ++++
 tests/qemu-iotests/143.out |  2 ++
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 02b1ed080145..ec130303586d 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -217,7 +217,7 @@ nbd_negotiate_send_rep_verr(NBDClient *client, uint32_t type,

     msg = g_strdup_vprintf(fmt, va);
     len = strlen(msg);
-    assert(len < 4096);
+    assert(len < NBD_MAX_STRING_SIZE);
     trace_nbd_negotiate_send_rep_err(msg);
     ret = nbd_negotiate_send_rep_len(client, type, len, errp);
     if (ret < 0) {
@@ -231,6 +231,27 @@ nbd_negotiate_send_rep_verr(NBDClient *client, uint32_t type,
     return 0;
 }

+/*
+ * Truncate a potentially-long user-supplied string into something
+ * more suitable for an error reply.
+ */
+static const char *
+nbd_truncate_name(const char *name)
+{
+#define SANE_LENGTH 80
+    static char buf[SANE_LENGTH + 3 + 1]; /* Trailing '...', NUL */
+
+    if (strlen(name) < SANE_LENGTH) {
+        return name;
+    }
+    memcpy(buf, name, SANE_LENGTH);
+    buf[SANE_LENGTH] = '.';
+    buf[SANE_LENGTH + 1] = '.';
+    buf[SANE_LENGTH + 2] = '.';
+    buf[SANE_LENGTH + 3] = '\0';
+    return buf;
+}
+
 /* Send an error reply.
  * Return -errno on error, 0 on success. */
 static int GCC_FMT_ATTR(4, 5)
@@ -597,7 +618,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, Error **errp)
     if (!exp) {
         return nbd_negotiate_send_rep_err(client, NBD_REP_ERR_UNKNOWN,
                                           errp, "export '%s' not present",
-                                          name);
+                                          nbd_truncate_name(name));
     }

     /* Don't bother sending NBD_INFO_NAME unless client requested it */
@@ -996,7 +1017,8 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
     meta->exp = nbd_export_find(export_name);
     if (meta->exp == NULL) {
         return nbd_opt_drop(client, NBD_REP_ERR_UNKNOWN, errp,
-                            "export '%s' not present", export_name);
+                            "export '%s' not present",
+                            nbd_truncate_name(export_name));
     }

     ret = nbd_opt_read(client, &nb_queries, sizeof(nb_queries), errp);
diff --git a/tests/qemu-iotests/143 b/tests/qemu-iotests/143
index f649b3619501..b0b1cff86cb6 100755
--- a/tests/qemu-iotests/143
+++ b/tests/qemu-iotests/143
@@ -58,6 +58,10 @@ _send_qemu_cmd $QEMU_HANDLE \
 $QEMU_IO_PROG -f raw -c quit \
     "nbd+unix:///no_such_export?socket=$SOCK_DIR/nbd" 2>&1 \
     | _filter_qemu_io | _filter_nbd
+# Likewise, with longest possible name permitted in NBD protocol
+$QEMU_IO_PROG -f raw -c quit \
+    "nbd+unix:///$(printf %4096d 1 | tr ' ' a)?socket=$SOCK_DIR/nbd" 2>&1 \
+    | _filter_qemu_io | _filter_nbd | sed 's/aa.*aa/aa...aa/'

 _send_qemu_cmd $QEMU_HANDLE \
     "{ 'execute': 'quit' }" \
diff --git a/tests/qemu-iotests/143.out b/tests/qemu-iotests/143.out
index 1f4001c60131..be1f3a625458 100644
--- a/tests/qemu-iotests/143.out
+++ b/tests/qemu-iotests/143.out
@@ -5,6 +5,8 @@ QA output created by 143
 {"return": {}}
 qemu-io: can't open device nbd+unix:///no_such_export?socket=SOCK_DIR/nbd: Requested export not available
 server reported: export 'no_such_export' not present
+qemu-io: can't open device nbd+unix:///aa...aa1?socket=SOCK_DIR/nbd: Requested export not available
+server reported: export 'aa...aa...' not present
 { 'execute': 'quit' }
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
-- 
2.27.0


