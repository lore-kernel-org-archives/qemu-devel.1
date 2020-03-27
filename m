Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE976C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:21:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1DFB20658
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aanw9ows"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1DFB20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHrjT-0006fO-VN
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 12:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jHrhz-0005d0-Ky
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:19:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jHrhy-0004ff-95
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:19:47 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:39873)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jHrhx-0004dg-QU
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585325984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hl2QeRFALRUYx31zZgprkAN+eRCTvjsgpmjOsW0+nOw=;
 b=Aanw9ows0W3XWKpvnl5F2OTZWUivfLNQNaugh3vJs7DdYMT6lvN5sY4snS24uIC3hOyw3L
 R8WZN9/AIUP5exZwzK+LpwQtqDa8VBNaPCBKfjNdLGPmERke5vJauVPkwRsH231OD73M6r
 hquZIFy0n0pbE2epKCzwLW8/I6C21PQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-IfS0Au2XONWCRNQSpXqiKA-1; Fri, 27 Mar 2020 12:19:42 -0400
X-MC-Unique: IfS0Au2XONWCRNQSpXqiKA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB4038010F6;
 Fri, 27 Mar 2020 16:19:41 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B4395C1D8;
 Fri, 27 Mar 2020 16:19:39 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] crypto: Add qcrypto_tls_shutdown()
Date: Fri, 27 Mar 2020 11:19:34 -0500
Message-Id: <20200327161936.2225989-2-eblake@redhat.com>
In-Reply-To: <20200327161936.2225989-1-eblake@redhat.com>
References: <20200327161936.2225989-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: berrange@redhat.com, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gnutls documents that applications that want to distinguish between a
clean end-of-communication and a malicious client abruptly tearing the
underlying transport out of under our feet need to use gnutls_bye().
Our channel code is already set up to allow shutdown requests, but we
weren't forwarding those to gnutls.  To make that work, we first need
a new entry point that can isolate the rest of our code from the
gnutls interface.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/crypto.json            | 15 +++++++++++++++
 include/crypto/tlssession.h | 24 ++++++++++++++++++++++++
 crypto/tlssession.c         | 27 +++++++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/qapi/crypto.json b/qapi/crypto.json
index b2a4cff683ff..1df0f4502885 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -119,6 +119,21 @@
   'prefix': 'QCRYPTO_IVGEN_ALG',
   'data': ['plain', 'plain64', 'essiv']}

+##
+# @QCryptoShutdownMode:
+#
+# The supported modes for requesting shutdown of a crypto
+# communication channel.
+#
+# @shut-wr: No more writes will be sent, but the remote end can still send
+#           data to be read.
+# @shut-rdwr: No more reads or writes should occur.
+# Since: 5.1
+##
+{ 'enum': 'QCryptoShutdownMode',
+  'prefix': 'QCRYPTO',
+  'data': ['shut-wr', 'shut-rdwr']}
+
 ##
 # @QCryptoBlockFormat:
 #
diff --git a/include/crypto/tlssession.h b/include/crypto/tlssession.h
index 15b9cef086cc..10c670e3b6a2 100644
--- a/include/crypto/tlssession.h
+++ b/include/crypto/tlssession.h
@@ -321,4 +321,28 @@ int qcrypto_tls_session_get_key_size(QCryptoTLSSession=
 *sess,
  */
 char *qcrypto_tls_session_get_peer_name(QCryptoTLSSession *sess);

+/**
+ * qcrypto_tls_shutdown:
+ * @sess: the TLS session object
+ * @how: the desired shutdown mode
+ *
+ * Prepare to terminate the session.  If @how is QCRYPTO_SHUT_WR, this
+ * side will no longer write data, but should still process reads
+ * until EOF; if @how is QCRYPTO_SHUT_RDWR, then the entire session
+ * should shut down.  Use of this function is optional, since closing
+ * the session implies QCRYPTO_SHUT_RDWR.  However, using this
+ * function prior to terminating the underlying transport layer makes
+ * it possible for the remote endpoint to distinguish between a
+ * malicious party prematurely terminating the the connection and
+ * normal termination.
+ *
+ * This function should only be used after a successful
+ * qcrypto_tls_session_handshake().
+ *
+ * Returns: 0 for success, or -EAGAIN if more underlying I/O is
+ * required to finish proper session shutdown.
+ */
+int qcrypto_tls_session_shutdown(QCryptoTLSSession *sess,
+                                 QCryptoShutdownMode how);
+
 #endif /* QCRYPTO_TLSSESSION_H */
diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index 33203e8ca711..903301189069 100644
--- a/crypto/tlssession.c
+++ b/crypto/tlssession.c
@@ -521,6 +521,33 @@ qcrypto_tls_session_get_handshake_status(QCryptoTLSSes=
sion *session)
 }


+int qcrypto_tls_session_shutdown(QCryptoTLSSession *session,
+                                 QCryptoShutdownMode how)
+{
+    gnutls_close_request_t mode;
+    int ret;
+
+    assert(session->handshakeComplete);
+    switch (how) {
+    case QCRYPTO_SHUT_WR:
+        mode =3D GNUTLS_SHUT_WR;
+        break;
+    case QCRYPTO_SHUT_RDWR:
+        mode =3D GNUTLS_SHUT_RDWR;
+        break;
+    default:
+        abort();
+    }
+
+    ret =3D gnutls_bye(session->handle, mode);
+    if (ret =3D=3D GNUTLS_E_INTERRUPTED ||
+        ret =3D=3D GNUTLS_E_AGAIN) {
+        return -EAGAIN;
+    }
+    return 0;
+}
+
+
 int
 qcrypto_tls_session_get_key_size(QCryptoTLSSession *session,
                                  Error **errp)
--=20
2.26.0.rc2


